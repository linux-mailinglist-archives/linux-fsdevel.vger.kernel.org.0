Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B13A22E10F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 18:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgGZQEN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 12:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbgGZQEM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 12:04:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D2AC0619D2;
        Sun, 26 Jul 2020 09:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=iZrQ/SYfvDaKBmEHzjE6dqWW+U25BQxNWauHk1h2nfU=; b=kifuhV4W5Vw0spDfEny1Eb8TGm
        M0yLJY8ex8XJ+kDK3fxYo2lSUKla0+6HPkvIIu0HpDSEp82F7rX4nk3ytR1Yag7PgHCgs3pyZPtvA
        63b1VMccKeOo5Gx9naFNsdj6Na8N+IO2JZ8IuZ3ezKlzq5sG/QaV1mQUDOtWRKPNRQvVOtAnlD++X
        7FuFp3ZnBeWrv7Emn7ObV1EpvRKHxPFOVmg8G0m/vYqFU5nrVb2EFbQ8TaJn7TbwZY7jF4iem8yhc
        KLpNBBg61qdHurP0M8RXupLdyMnYrGj0LIASGkJiPvhgW6jWgiy4Uu+mmhhysjW3MCIgST+lNvdD2
        KxEOJ/UQ==;
Received: from [2001:4bb8:18c:2acc:2375:88ff:9f84:118d] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzj8A-0000ZR-7i; Sun, 26 Jul 2020 16:04:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org, Jan Kara <jack@suse.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 2/4] compat: lift compat_s64 and compat_u64 to <linux/compat.h>
Date:   Sun, 26 Jul 2020 18:03:59 +0200
Message-Id: <20200726160401.311569-3-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200726160401.311569-1-hch@lst.de>
References: <20200726160401.311569-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
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
 include/linux/compat.h            | 8 ++++++++
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
diff --git a/include/linux/compat.h b/include/linux/compat.h
index e90100c0de72e4..c22a7f1d253b87 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -91,6 +91,14 @@
 	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
 #endif /* COMPAT_SYSCALL_DEFINEx */
 
+#ifdef COMPAT_FOR_U64_ALIGNMENT
+typedef s64 __attribute__((aligned(4))) compat_s64;
+typedef u64 __attribute__((aligned(4))) compat_u64;
+#else
+typedef s64 compat_s64;
+typedef u64 compat_u64;
+#endif
+
 #ifdef CONFIG_COMPAT
 
 #ifndef compat_user_stack_pointer
-- 
2.27.0

