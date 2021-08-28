Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7433FA7E4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 00:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhH1WUH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Aug 2021 18:20:07 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:35980 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhH1WUG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Aug 2021 18:20:06 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mK6fI-00Gu1S-6O; Sat, 28 Aug 2021 22:19:04 +0000
Date:   Sat, 28 Aug 2021 22:19:04 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: Re: [PATCH v7 05/19] iov_iter: Introduce fault_in_iov_iter_writeable
Message-ID: <YSq2WJindB0pJPRb@zeniv-ca.linux.org.uk>
References: <CAHk-=wh5p6zpgUUoY+O7e74X9BZyODhnsqvv=xqnTaLRNj3d_Q@mail.gmail.com>
 <YSk7xfcHVc7CxtQO@zeniv-ca.linux.org.uk>
 <CAHk-=wjMyZLH+ta5SohAViSc10iPj-hRnHc-KPDoj1XZCmxdBg@mail.gmail.com>
 <YSk+9cTMYi2+BFW7@zeniv-ca.linux.org.uk>
 <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
 <YSlftta38M4FsWUq@zeniv-ca.linux.org.uk>
 <20210827232246.GA1668365@agluck-desk2.amr.corp.intel.com>
 <87r1edgs2w.ffs@tglx>
 <YSqy+U/3lnF6K0ia@zeniv-ca.linux.org.uk>
 <YSq0mPAIBfqFC/NE@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSq0mPAIBfqFC/NE@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 28, 2021 at 10:11:36PM +0000, Al Viro wrote:
> On Sat, Aug 28, 2021 at 10:04:41PM +0000, Al Viro wrote:
> > On Sat, Aug 28, 2021 at 11:47:03PM +0200, Thomas Gleixner wrote:
> > 
> > >   /* Try to handle #PF, but anything else is fatal. */
> > >   if (ret != -EFAULT)
> > >      return -EINVAL;
> > 
> > > which all end up in user_insn(). user_insn() returns 0 or the negated
> > > trap number, which results in -EFAULT for #PF, but for #MC the negated
> > > trap number is -18 i.e. != -EFAULT. IOW, there is no endless loop.
> > > 
> > > This used to be a problem before commit:
> > > 
> > >   aee8c67a4faa ("x86/fpu: Return proper error codes from user access functions")
> > > 
> > > and as the changelog says the initial reason for this was #GP going into
> > > the fault path, but I'm pretty sure that I also discussed the #MC angle with
> > > Borislav back then. Should have added some more comments there
> > > obviously.
> > 
> > ... or at least have that check spelled
> > 
> > 	if (ret != -X86_TRAP_PF)
> > 		return -EINVAL;
> > 
> > Unless I'm misreading your explanation, that is...
> 
> BTW, is #MC triggered on stored to a poisoned cacheline?  Existence of CLZERO
> would seem to argue against that...

How about taking __clear_user() out of copy_fpregs_to_sigframe()
and replacing the call of fault_in_pages_writeable() with
	if (!clear_user(buf_fx, fpu_user_xstate_size))
		goto retry;
	return -EFAULT;
in the caller?
