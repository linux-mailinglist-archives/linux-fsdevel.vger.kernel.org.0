Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305F83FADE9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 20:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhH2So6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Aug 2021 14:44:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47652 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhH2So6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Aug 2021 14:44:58 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630262645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YIcamjfwVlhaadFlylOQXRTn4w1QtmfouqqV1RahVbw=;
        b=Yxx1XZH1ocDdYENRnIydThdIkPVnGlUQuJzkqDi41wn938xsOxxdTwbvQdqpmk/BiCP5OQ
        3jTdZDOZR7cN6HSrDI79eSuuCQKm7VUFajUIC6WfRMktyxDycvlnNzTNJO56njXVdRIwd6
        K+pLVqIx3L3SK8Rp0XEMrcMm+M3RQIocxeyK5z4pA7fjlhiwy0jDMOGWA5ln/tbKkFYL+P
        2w1fVgKGElxzJiSoegryOCx8VKLlPob7vpBxuUlRn/jhTEna/xrC12D6YRZkQZ6T45AONU
        Q/oNnKaKzhN+wEmd4k+gLhsSPkuo+8HJuoydkl5UcddGrnb9z1Ic8zYvafB3DA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630262645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YIcamjfwVlhaadFlylOQXRTn4w1QtmfouqqV1RahVbw=;
        b=+68crkmN56/F2OSP3PsrBPbiDxChhQm5zydU53mgC3MPIVgGUASMWQzJ4DKvstyANPp7hN
        tk6rhJocJEofJuAg==
To:     Al Viro <viro@zeniv.linux.org.uk>
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
In-Reply-To: <YSq93XetyaUuAsY7@zeniv-ca.linux.org.uk>
References: <YSk7xfcHVc7CxtQO@zeniv-ca.linux.org.uk>
 <CAHk-=wjMyZLH+ta5SohAViSc10iPj-hRnHc-KPDoj1XZCmxdBg@mail.gmail.com>
 <YSk+9cTMYi2+BFW7@zeniv-ca.linux.org.uk>
 <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
 <YSlftta38M4FsWUq@zeniv-ca.linux.org.uk>
 <20210827232246.GA1668365@agluck-desk2.amr.corp.intel.com>
 <87r1edgs2w.ffs@tglx> <YSqy+U/3lnF6K0ia@zeniv-ca.linux.org.uk>
 <YSq0mPAIBfqFC/NE@zeniv-ca.linux.org.uk>
 <YSq2WJindB0pJPRb@zeniv-ca.linux.org.uk>
 <YSq93XetyaUuAsY7@zeniv-ca.linux.org.uk>
Date:   Sun, 29 Aug 2021 20:44:04 +0200
Message-ID: <87k0k4gkgb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 28 2021 at 22:51, Al Viro wrote:
> @@ -345,7 +346,7 @@ static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
>  	 */
>  	err = __clear_user(&buf->header, sizeof(buf->header));
>  	if (unlikely(err))
> -		return -EFAULT;
> +		return -X86_TRAP_PF;

This clear_user can be lifted into copy_fpstate_to_sigframe(). Something
like the below.
  
Thanks,

        tglx
---
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -135,18 +135,12 @@ static inline int save_xstate_epilog(voi
 
 static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
 {
-	int err;
-
 	if (use_xsave())
-		err = xsave_to_user_sigframe(buf);
-	else if (use_fxsr())
-		err = fxsave_to_user_sigframe((struct fxregs_state __user *) buf);
+		return xsave_to_user_sigframe(buf);
+	if (use_fxsr())
+		return fxsave_to_user_sigframe((struct fxregs_state __user *) buf);
 	else
-		err = fnsave_to_user_sigframe((struct fregs_state __user *) buf);
-
-	if (unlikely(err) && __clear_user(buf, fpu_user_xstate_size))
-		err = -EFAULT;
-	return err;
+		return fnsave_to_user_sigframe((struct fregs_state __user *) buf);
 }
 
 /*
@@ -188,6 +182,16 @@ int copy_fpstate_to_sigframe(void __user
 
 	if (!access_ok(buf, size))
 		return -EACCES;
+
+	if (use_xsave()) {
+		/*
+		 * Clear the xsave header first, so that reserved fields are
+		 * initialized to zero.
+		 */
+		ret = __clear_user(&buf->header, sizeof(buf->header));
+		if (unlikely(ret))
+			return ret;
+	}
 retry:
 	/*
 	 * Load the FPU registers if they are not valid for the current task.
@@ -205,9 +209,10 @@ int copy_fpstate_to_sigframe(void __user
 	fpregs_unlock();
 
 	if (ret) {
-		if (!fault_in_pages_writeable(buf_fx, fpu_user_xstate_size))
+		if (!__clear_user(buf_fx, fpu_user_xstate_size) &&
+		    ret == -X86_TRAP_PF)
 			goto retry;
-		return -EFAULT;
+		return -1;
 	}
 
 	/* Save the fsave header for the 32-bit frames. */
@@ -275,7 +280,7 @@ static int restore_fpregs_from_user(void
 		fpregs_unlock();
 
 		/* Try to handle #PF, but anything else is fatal. */
-		if (ret != -EFAULT)
+		if (ret != -X86_TRAP_PF)
 			return -EINVAL;
 
 		ret = fault_in_pages_readable(buf, size);
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -323,9 +323,12 @@ static inline void os_xrstor(struct xreg
  * We don't use modified optimization because xrstor/xrstors might track
  * a different application.
  *
- * We don't use compacted format xsave area for
- * backward compatibility for old applications which don't understand
- * compacted format of xsave area.
+ * We don't use compacted format xsave area for backward compatibility for
+ * old applications which don't understand the compacted format of the
+ * xsave area.
+ *
+ * The caller has to zero buf::header before calling this because XSAVE*
+ * does not touch them.
  */
 static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
 {
@@ -339,14 +342,6 @@ static inline int xsave_to_user_sigframe
 	u32 hmask = mask >> 32;
 	int err;
 
-	/*
-	 * Clear the xsave header first, so that reserved fields are
-	 * initialized to zero.
-	 */
-	err = __clear_user(&buf->header, sizeof(buf->header));
-	if (unlikely(err))
-		return -EFAULT;
-
 	stac();
 	XSTATE_OP(XSAVE, buf, lmask, hmask, err);
 	clac();
