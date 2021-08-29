Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9593FA81F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 03:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbhH2BBa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Aug 2021 21:01:30 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:38374 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhH2BBa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Aug 2021 21:01:30 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mK99Q-00Gvaz-Dk; Sun, 29 Aug 2021 00:58:20 +0000
Date:   Sun, 29 Aug 2021 00:58:20 +0000
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
Message-ID: <YSrbrAtVOjvV0e2T@zeniv-ca.linux.org.uk>
References: <20210827164926.1726765-1-agruenba@redhat.com>
 <20210827164926.1726765-6-agruenba@redhat.com>
 <YSkz025ncjhyRmlB@zeniv-ca.linux.org.uk>
 <CAHk-=wh5p6zpgUUoY+O7e74X9BZyODhnsqvv=xqnTaLRNj3d_Q@mail.gmail.com>
 <YSk7xfcHVc7CxtQO@zeniv-ca.linux.org.uk>
 <CAHk-=wjMyZLH+ta5SohAViSc10iPj-hRnHc-KPDoj1XZCmxdBg@mail.gmail.com>
 <YSk+9cTMYi2+BFW7@zeniv-ca.linux.org.uk>
 <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 09:48:55PM +0000, Al Viro wrote:

> So we have 3 callers where we want all-or-nothing semantics - two in
> arch/x86/kernel/fpu/signal.c and one in btrfs.  HWPOISON will be a problem
> for all 3, AFAICS...
> 
> IOW, it looks like we have two different things mixed here - one that wants
> to try and fault stuff in, with callers caring only about having _something_
> faulted in (most of the users) and one that wants to make sure we *can* do
> stores or loads on each byte in the affected area.
> 
> Just accessing a byte in each page really won't suffice for the second kind.
> Neither will g-u-p use, unless we teach it about HWPOISON and other fun
> beasts...  Looks like we want that thing to be a separate primitive; for
> btrfs I'd probably replace fault_in_pages_writeable() with clear_user()
> as a quick fix for now...

Looks like out of these 3 we have
	* x86 restoring FPU state on sigreturn: correct, if somewhat obfuscated;
HWPOISON is not an issue.  We want full fault-in there (1 or 2 pages)
	* x86 saving FPU state into sigframe: not really needed; we do
__clear_user() on any error anyway, and taking it into the caller past the
pagefault_enable() will serve just fine instead of fault-in of the same
for write.
	* btrfs search_ioctl(): HWPOISON is not an issue (no #MC on stores),
but arm64 side of the things very likely is a problem with MTE; there we
can have successful store in some bytes in a page with faults on stores
elsewhere in it.  With such setups that thing will loop indefinitely.
And unlike x86 FPU handling, btrfs is arch-independent.

IOW, unless I'm misreading the situation, we have one caller where "all or
nothing" semantics is correct and needed, several where fault-in is pointless,
one where the current use of fault-in is actively wrong (ppc kvm, patch from
ppc folks exists), another place where neither semantics is right (btrfs on
arm64) and a bunch where "can we access at least the first byte?" should be
fine...
