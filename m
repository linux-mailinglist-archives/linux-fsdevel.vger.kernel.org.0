Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43BE13FAE33
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 21:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbhH2Tt1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Aug 2021 15:49:27 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:53634 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhH2Tt1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Aug 2021 15:49:27 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKQkm-00H7LP-82; Sun, 29 Aug 2021 19:46:04 +0000
Date:   Sun, 29 Aug 2021 19:46:04 +0000
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
Message-ID: <YSvj/ML2saV3+5Ru@zeniv-ca.linux.org.uk>
References: <YSk+9cTMYi2+BFW7@zeniv-ca.linux.org.uk>
 <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
 <YSlftta38M4FsWUq@zeniv-ca.linux.org.uk>
 <20210827232246.GA1668365@agluck-desk2.amr.corp.intel.com>
 <87r1edgs2w.ffs@tglx>
 <YSqy+U/3lnF6K0ia@zeniv-ca.linux.org.uk>
 <YSq0mPAIBfqFC/NE@zeniv-ca.linux.org.uk>
 <YSq2WJindB0pJPRb@zeniv-ca.linux.org.uk>
 <YSq93XetyaUuAsY7@zeniv-ca.linux.org.uk>
 <87k0k4gkgb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0k4gkgb.ffs@tglx>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 29, 2021 at 08:44:04PM +0200, Thomas Gleixner wrote:
> On Sat, Aug 28 2021 at 22:51, Al Viro wrote:
> > @@ -345,7 +346,7 @@ static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
> >  	 */
> >  	err = __clear_user(&buf->header, sizeof(buf->header));
> >  	if (unlikely(err))
> > -		return -EFAULT;
> > +		return -X86_TRAP_PF;
> 
> This clear_user can be lifted into copy_fpstate_to_sigframe(). Something
> like the below.

Hmm...  This mixing of -X86_TRAP_... with -E... looks like it's asking for
trouble in general.  Might be worth making e.g. fpu__restore_sig() (and
its callers) return bool, seeing that we only check for 0/non-zero in
there.
