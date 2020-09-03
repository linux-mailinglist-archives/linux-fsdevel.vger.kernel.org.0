Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B9225C32D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 16:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgICOqX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 10:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729313AbgICOZk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:25:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD255C0619C2;
        Thu,  3 Sep 2020 07:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bH0npQmg7q4MUz/DOcBOJ2fcWOcjfiOlt/aOz+3Bgpg=; b=kXYpAuO/cmD2EKD2yQNuETsXF1
        c+fCmgtcS5YMFsxsK450GWgwaue/5Z/kPd99c2iqcMUKSp533KEJvoUBzwuYHo+NGiqMLcCiAf5C+
        AZ/9CnGAWO1D5nPh2PoNKE+AsgSnqh8UahhT+qyWBocsnblgjfWL/mhoTdikAwBY1FZZ9k39dKm3D
        /cMSOcKO4JDlnW03pxm0B5vDMF33iady1JjX/ULuHgnkCq0xSEjOwb1wvGryNBFl2XNtEx+/HLn5C
        QY7seNhy9MXftAHS0nBk50VbdjYrdOQgVKCUL8W8gfYKgJLfLkwvwOl5GKwPAl72mmOOz/VEEhd5x
        Y3texVXA==;
Received: from [2001:4bb8:184:af1:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDq8i-0004cM-AS; Thu, 03 Sep 2020 14:23:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 13/14] powerpc: use non-set_fs based maccess routines
Date:   Thu,  3 Sep 2020 16:22:41 +0200
Message-Id: <20200903142242.925828-14-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903142242.925828-1-hch@lst.de>
References: <20200903142242.925828-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide __get_kernel_nofault and __put_kernel_nofault routines to
implement the maccess routines without messing with set_fs and without
opening up access to user space.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/uaccess.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 00699903f1efca..7fe3531ad36a77 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -623,4 +623,20 @@ do {									\
 		__put_user_goto(*(u8*)(_src + _i), (u8 __user *)(_dst + _i), e);\
 } while (0)
 
+#define HAVE_GET_KERNEL_NOFAULT
+
+#define __get_kernel_nofault(dst, src, type, err_label)			\
+do {									\
+	int __kr_err;							\
+									\
+	__get_user_size_allowed(*((type *)(dst)), (__force type __user *)(src),\
+			sizeof(type), __kr_err);			\
+	if (unlikely(__kr_err))						\
+		goto err_label;						\
+} while (0)
+
+#define __put_kernel_nofault(dst, src, type, err_label)			\
+	__put_user_size_goto(*((type *)(src)),				\
+		(__force type __user *)(dst), sizeof(type), err_label)
+
 #endif	/* _ARCH_POWERPC_UACCESS_H */
-- 
2.28.0

