Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A127D26D4FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 09:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgIQHqq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 03:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgIQHqj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:46:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7B8C06174A;
        Thu, 17 Sep 2020 00:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2ShHJI+/iPB4f5g8wN1iTxox6+aW3YyXwKO49hsDfG8=; b=oLoWRqnhxJ8xGMBmE5TB2P1TOy
        4rsrn8hciRSFeM/QVDp1w1UIcbqaeu9F2qiTwmqPJAWREx/XUVa77m+qulK3m+Ohs7vGnUBrAJK07
        lMnKXVpi2/eug+NLkFhjmkWv2US8yni9JGj8emQVd3h7M+iMffn6l4d3LaZNlv/SHc1ktQnv+BUHT
        q1k7gRSQcBIiv/hzcUFpnPHT+U+if0nLOu/dbNglOFPLT1uIpv/zXvkDfTiP+x1MBZ2lmtT+iOnVL
        yHDDIjlGFEp6iZ57X5TuhTuPMIEijOMoLy1BI1tUMJXdCwyOIE2x/kC/cnB1Hv83og2jfH0NBbwYB
        iw94BApg==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIocZ-0006Vd-27; Thu, 17 Sep 2020 07:46:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org, Jan Kara <jack@suse.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 1/3] compat: lift compat_s64 and compat_u64 to <asm-generic/compat.h>
Date:   Thu, 17 Sep 2020 09:41:57 +0200
Message-Id: <20200917074159.2442167-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917074159.2442167-1-hch@lst.de>
References: <20200917074159.2442167-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

lift the compat_s64 and compat_u64 definitions into common code using the
COMPAT_FOR_U64_ALIGNMENT symbol for the x86 special case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/include/asm/compat.h   | 2 --
 arch/mips/include/asm/compat.h    | 2 --
 arch/parisc/include/asm/compat.h  | 2 --
 arch/powerpc/include/asm/compat.h | 2 --
 arch/s390/include/asm/compat.h    | 2 --
 arch/sparc/include/asm/compat.h   | 3 +--
 arch/x86/include/asm/compat.h     | 2 --
 include/asm-generic/compat.h      | 8 ++++++++
 8 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 935d2aa231bf06..23a9fb73c04ff8 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -35,8 +35,6 @@ typedef s32		compat_nlink_t;
 typedef u16		compat_ipc_pid_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
-typedef s64		compat_s64;
-typedef u64		compat_u64;
 
 struct compat_stat {
 #ifdef __AARCH64EB__
diff --git a/arch/mips/include/asm/compat.h b/arch/mips/include/asm/compat.h
index 255afcdd79c94b..65975712a22dcf 100644
--- a/arch/mips/include/asm/compat.h
+++ b/arch/mips/include/asm/compat.h
@@ -26,8 +26,6 @@ typedef s32		compat_caddr_t;
 typedef struct {
 	s32	val[2];
 } compat_fsid_t;
-typedef s64		compat_s64;
-typedef u64		compat_u64;
 
 struct compat_stat {
 	compat_dev_t	st_dev;
diff --git a/arch/parisc/include/asm/compat.h b/arch/parisc/include/asm/compat.h
index 2f4f66a3bac079..8f33085ff1bd88 100644
--- a/arch/parisc/include/asm/compat.h
+++ b/arch/parisc/include/asm/compat.h
@@ -22,8 +22,6 @@ typedef u32	compat_dev_t;
 typedef u16	compat_nlink_t;
 typedef u16	compat_ipc_pid_t;
 typedef u32	compat_caddr_t;
-typedef s64	compat_s64;
-typedef u64	compat_u64;
 
 struct compat_stat {
 	compat_dev_t		st_dev;	/* dev_t is 32 bits on parisc */
diff --git a/arch/powerpc/include/asm/compat.h b/arch/powerpc/include/asm/compat.h
index 3e3cdfaa76c6a5..9191fc29e6ed11 100644
--- a/arch/powerpc/include/asm/compat.h
+++ b/arch/powerpc/include/asm/compat.h
@@ -27,8 +27,6 @@ typedef s16		compat_nlink_t;
 typedef u16		compat_ipc_pid_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
-typedef s64		compat_s64;
-typedef u64		compat_u64;
 
 struct compat_stat {
 	compat_dev_t	st_dev;
diff --git a/arch/s390/include/asm/compat.h b/arch/s390/include/asm/compat.h
index 9547cd5d6cdc21..ea5b9c34b7be5b 100644
--- a/arch/s390/include/asm/compat.h
+++ b/arch/s390/include/asm/compat.h
@@ -63,8 +63,6 @@ typedef u16		compat_nlink_t;
 typedef u16		compat_ipc_pid_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
-typedef s64		compat_s64;
-typedef u64		compat_u64;
 
 typedef struct {
 	u32 mask;
diff --git a/arch/sparc/include/asm/compat.h b/arch/sparc/include/asm/compat.h
index 40a267b3bd5208..b85842cda99fe0 100644
--- a/arch/sparc/include/asm/compat.h
+++ b/arch/sparc/include/asm/compat.h
@@ -21,8 +21,7 @@ typedef s16		compat_nlink_t;
 typedef u16		compat_ipc_pid_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
-typedef s64		compat_s64;
-typedef u64		compat_u64;
+
 struct compat_stat {
 	compat_dev_t	st_dev;
 	compat_ino_t	st_ino;
diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index d4edf281fff49d..bf547701f41f87 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -27,8 +27,6 @@ typedef u16		compat_nlink_t;
 typedef u16		compat_ipc_pid_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
-typedef s64 __attribute__((aligned(4))) compat_s64;
-typedef u64 __attribute__((aligned(4))) compat_u64;
 
 struct compat_stat {
 	compat_dev_t	st_dev;
diff --git a/include/asm-generic/compat.h b/include/asm-generic/compat.h
index a86f65bffab8d0..30f7b18a36f939 100644
--- a/include/asm-generic/compat.h
+++ b/include/asm-generic/compat.h
@@ -22,4 +22,12 @@ typedef u32 compat_ulong_t;
 typedef u32 compat_uptr_t;
 typedef u32 compat_aio_context_t;
 
+#ifdef CONFIG_COMPAT_FOR_U64_ALIGNMENT
+typedef s64 __attribute__((aligned(4))) compat_s64;
+typedef u64 __attribute__((aligned(4))) compat_u64;
+#else
+typedef s64 compat_s64;
+typedef u64 compat_u64;
+#endif
+
 #endif
-- 
2.28.0

