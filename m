Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D692345BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 14:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733306AbgGaMWQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 08:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733282AbgGaMWM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:22:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF51C061575;
        Fri, 31 Jul 2020 05:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=U7JLs+mjSHVkT29ZltdW4qWvuLQjr3lykkFG0wE52WA=; b=RDIwfmRRCIxlNl7qPAXNNDXinU
        ktiwC/ppol+Hs/4vHLIn73vpBaKtQAJs2CH6K7yh4OqdcC+l6nacVDCxRsMe5maQ9igdBE85h3HaN
        iN5bGCcNvLwBCi2njQFU4Dv8hXkRyvgNx4y9/ahgz2vgNkdJ/z76F8vEQVVsSjv+IrCqZO9Z16MyB
        Yh15hJQmoWccFW66+4i2ZjuTjv0jNRni26iEWGQ9z4oO1+uPcjwax5Z3KB1YOo/1HoO9aJlHB1lC5
        l7Mwbhc3UdiBB3ZHDBht9g6V+9CoLIzQnRr5JbcGWStDeDj8Ua5cifdL+UWnDYrOEZMHLF4fzaqi0
        3oh0SEzw==;
Received: from 138.57.168.109.cust.ip.kpnqwest.it ([109.168.57.138] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1U35-000261-OV; Fri, 31 Jul 2020 12:22:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org, Jan Kara <jack@suse.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 1/3] compat: lift compat_s64 and compat_u64 to <asm-generic/compat.h>
Date:   Fri, 31 Jul 2020 14:22:00 +0200
Message-Id: <20200731122202.213333-2-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200731122202.213333-1-hch@lst.de>
References: <20200731122202.213333-1-hch@lst.de>
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
2.27.0

