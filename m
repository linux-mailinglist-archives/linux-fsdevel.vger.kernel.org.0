Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA914701D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 14:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238841AbhLJNkR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 08:40:17 -0500
Received: from mail.loongson.cn ([114.242.206.163]:59972 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242038AbhLJNjv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:39:51 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxusjBV7Nh3OEFAA--.12281S3;
        Fri, 10 Dec 2021 21:36:02 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        x86@kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kdump: vmcore: move copy_to() from vmcore.c to uaccess.h
Date:   Fri, 10 Dec 2021 21:36:00 +0800
Message-Id: <1639143361-17773-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1639143361-17773-1-git-send-email-yangtiezhu@loongson.cn>
References: <1639143361-17773-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9AxusjBV7Nh3OEFAA--.12281S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF43Ar4Utr4rKr43tw4ktFb_yoW8AF4Upr
        nxJry3Gr48KryUJFnFywnru3WrX3Z3CF4Uta97GF1rZ3sxZr12vrn3uFyagrW8JrZ2kFW5
        CF95GrW3Gr4DXw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPIb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY
        1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4
        xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCa
        FVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkIec
        xEwVAFwVW5GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
        F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
        ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
        1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jD
        fHUUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In arch/*/kernel/crash_dump*.c, there exist similar code about
copy_oldmem_page(), move copy_to() from vmcore.c to uaccess.h,
and then we can use copy_to() to simplify the related code.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 fs/proc/vmcore.c        | 14 --------------
 include/linux/uaccess.h | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 509f851..c5976a8 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -238,20 +238,6 @@ copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
 	return copy_oldmem_page(pfn, buf, csize, offset, userbuf);
 }
 
-/*
- * Copy to either kernel or user space
- */
-static int copy_to(void *target, void *src, size_t size, int userbuf)
-{
-	if (userbuf) {
-		if (copy_to_user((char __user *) target, src, size))
-			return -EFAULT;
-	} else {
-		memcpy(target, src, size);
-	}
-	return 0;
-}
-
 #ifdef CONFIG_PROC_VMCORE_DEVICE_DUMP
 static int vmcoredd_copy_dumps(void *dst, u64 start, size_t size, int userbuf)
 {
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index ac03940..4a6c3e4 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -201,6 +201,20 @@ copy_to_user(void __user *to, const void *from, unsigned long n)
 	return n;
 }
 
+/*
+ * Copy to either kernel or user space
+ */
+static inline int copy_to(void *target, void *src, size_t size, int userbuf)
+{
+	if (userbuf) {
+		if (copy_to_user((char __user *) target, src, size))
+			return -EFAULT;
+	} else {
+		memcpy(target, src, size);
+	}
+	return 0;
+}
+
 #ifndef copy_mc_to_kernel
 /*
  * Without arch opt-in this generic copy_mc_to_kernel() will not handle
-- 
2.1.0

