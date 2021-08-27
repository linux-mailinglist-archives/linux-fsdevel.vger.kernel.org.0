Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FFD3FA14A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 23:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbhH0VyL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 17:54:11 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:45042 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbhH0VyK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 17:54:10 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJjiZ-00GbUU-Au; Fri, 27 Aug 2021 21:48:55 +0000
Date:   Fri, 27 Aug 2021 21:48:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v7 05/19] iov_iter: Introduce fault_in_iov_iter_writeable
Message-ID: <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
References: <20210827164926.1726765-1-agruenba@redhat.com>
 <20210827164926.1726765-6-agruenba@redhat.com>
 <YSkz025ncjhyRmlB@zeniv-ca.linux.org.uk>
 <CAHk-=wh5p6zpgUUoY+O7e74X9BZyODhnsqvv=xqnTaLRNj3d_Q@mail.gmail.com>
 <YSk7xfcHVc7CxtQO@zeniv-ca.linux.org.uk>
 <CAHk-=wjMyZLH+ta5SohAViSc10iPj-hRnHc-KPDoj1XZCmxdBg@mail.gmail.com>
 <YSk+9cTMYi2+BFW7@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSk+9cTMYi2+BFW7@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 07:37:25PM +0000, Al Viro wrote:
> On Fri, Aug 27, 2021 at 12:33:00PM -0700, Linus Torvalds wrote:
> > On Fri, Aug 27, 2021 at 12:23 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > Could you show the cases where "partial copy, so it's OK" behaviour would
> > > break anything?
> > 
> > Absolutely.
> > 
> > For example, i t would cause an infinite loop in
> > restore_fpregs_from_user() if the "buf" argument is a situation where
> > the first page is fine, but the next page is not.
> > 
> > Why? Because __restore_fpregs_from_user() would take a fault, but then
> > fault_in_pages_readable() (renamed) would succeed, so you'd just do
> > that "retry" forever and ever.
> > 
> > Probably there are a number of other places too. That was literally
> > the *first* place I looked at.
> 
> OK...
> 
> Let me dig out the notes from the last time I looked through that area
> and grep around a bit.  Should be about an hour or two.

OK, I've dug it out and rechecked the current mainline.

Call trees:

fault_in_pages_readable()
	kvm_use_magic_page()

Broken, as per mpe.  Relevant part (see <87eeeqa7ng.fsf@mpe.ellerman.id.au> in
your mailbox back in early May for the full story):
|The current code is confused, ie. broken.
...
|We want to check that the mapping succeeded, that the address is
|readable (& writeable as well actually).
...
|diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
...
|-       if (!fault_in_pages_readable((const char *)KVM_MAGIC_PAGE, sizeof(u32))) {
|+       if (get_kernel_nofault(c, (const char *)KVM_MAGIC_PAGE)) {

	[ppc32]swapcontext()
	[ppc32]debug_setcontext()
	[ppc64]swapcontext()

Same situation in all three - it's going to kill the process if copy-in
fails, so it tries to be gentler about it and treat fault-in failures
as -EFAULT from syscall.  AFAICS, it's pointless, but I would like
comments from ppc folks.  Note that bogus *contents* of the
struct ucontext passed by user is almost certainly going to end up
with segfault; trying to catch the cases when bogus address happens
to point someplace unreadable is rather useless in that situation.

	restore_fpregs_from_user()
The one you've caught; hadn't been there last time I'd checked (back in
April).  Its counterpart in copy_fpstate_to_sigframe() had been, though.

	armada_gem_pwrite_ioctl()
Pointless, along with the access_ok() there - it does copy_from_user()
on that area shortly afterwards and failure of either is not a fast path.
	copy_page_from_iter_iovec()
Will do the right thing on short copy of any kind; we are fine with either
semantics.
	iov_iter_fault_in_readable()
		generic_perform_write()
Any short copy that had not lead to progress (== rejected by ->write_end())
will lead to next chunk shortened accordingly, so ->write_begin() would be
asked to prepare for the amount we expect to be able to copy; ->write_end()
should be fine with that.  Failure to copy anything at all (possible due to
eviction on memory pressure, etc.) leads to retry of the same chunk as the
last time, and that's where we rely on fault-in rejecting "nothing could be
faulted in" case.  That one is fine with partial fault-in reported as success.
		f2fs_file_write_iter()
Odd prealloc-related stuff.  AFAICS, from the correctness POV either variant
of semantics would do, but I'm not sure how if either is the right match
to what they are trying to do there.
		fuse_fill_write_pages()
Similar to generic_perform_write() situation, only simpler (no ->write_end()
counterpart there).  All we care about is failure if nothing could be faulted
in.
		btrfs_buffered_write()
Again, similar to generic_perform_write().  More convoluted (after a short
copy it switches to going page-by-page and getting destination pages uptodate,
which will be equivalent to ->write_end() always accepting everything it's
given from that point on), but it's the same "we care only about failure
to fault in the first page" situation.
		ntfs_perform_write()
Another generic_perform_write() analogue.  Same situation wrt fault-in
semantics.
		iomap_write_actor()
Another generic_perform_write() relative.  Same situation.


fault_in_pages_writeable()
        copy_fpstate_to_sigframe()
Same kind of "retry everything from scratch on short copy" as in the other
fpu/signal.c case.
	[btrfs]search_ioctl()
Broken with memory poisoning, for either variant of semantics.  Same for
arm64 sub-page permission differences, I think.
	copy_page_to_iter_iovec()
Will do the right thing on short copy of any kind; we are fine with either
semantics.

So we have 3 callers where we want all-or-nothing semantics - two in
arch/x86/kernel/fpu/signal.c and one in btrfs.  HWPOISON will be a problem
for all 3, AFAICS...

IOW, it looks like we have two different things mixed here - one that wants
to try and fault stuff in, with callers caring only about having _something_
faulted in (most of the users) and one that wants to make sure we *can* do
stores or loads on each byte in the affected area.

Just accessing a byte in each page really won't suffice for the second kind.
Neither will g-u-p use, unless we teach it about HWPOISON and other fun
beasts...  Looks like we want that thing to be a separate primitive; for
btrfs I'd probably replace fault_in_pages_writeable() with clear_user()
as a quick fix for now...

Comments?
