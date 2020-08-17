Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1468C245DFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 09:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgHQHcx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 03:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgHQHcf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:32:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABA6C061346;
        Mon, 17 Aug 2020 00:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3qEOF4AeMzDrBPiTnGe1Fi7T4ulUxh9tT2b5Llhhj24=; b=mK1/oXp62aR0yay7hI5rxF1rAO
        oIsweDRzAybAXvXwihafnDeOYhrE2n+0bZlTynkTLCeN2Dft2OWptTFcZ0c+Ljmzou4BBptsQZ+cE
        0WcSunosxHVcotlNa/rI3b318DLQXHBoYZZegd9x5Yis9biXRTIjkMLxPL3Usu9AkBvWYJ3qmMQf1
        l6wqXqzOVXQI/CO1e536dwgXJwAxJPt8DWi26u63Db+xcZ7fBk6a4uIvosgZsLEb9gJZhTvzW+Ta5
        YxOkXrxmW78qeAsfMYFzC1ir41mo1Ahv1Nsz4QILF/04RjFQMvKx+/88wZzYfZLpGewiWy9mnrHqC
        +/UpGE0w==;
Received: from [2001:4bb8:188:3918:4550:cdf7:3d45:afb9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7Zd8-0000x5-1X; Mon, 17 Aug 2020 07:32:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 10/11] powerpc: use non-set_fs based maccess routines
Date:   Mon, 17 Aug 2020 09:32:11 +0200
Message-Id: <20200817073212.830069-11-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817073212.830069-1-hch@lst.de>
References: <20200817073212.830069-1-hch@lst.de>
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
index 00699903f1efca..a31de40ac00b62 100644
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
+	__get_user_size(*((type *)(dst)), (__force type __user *)(src),	\
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

