Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2143A4F13
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jun 2021 15:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhFLNRk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Jun 2021 09:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhFLNRj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Jun 2021 09:17:39 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85D91C061574;
        Sat, 12 Jun 2021 06:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=hpF82FbzK3dvrZKLG58TMGKoVTQlhY9cugq9/lUm9Xo=; b=njZNJngaWiUd/
        FeUXBIDCYXAWyLT5JK3peJzZjKpfwwV4pmnTNRWkLpcG8DvaDn1P7yzAZMIuCMIE
        3ycPkVEc6WTW/KpnJvM47yZr4OuJAOdn9GlxfjMObnCCIS+zqy8rrCUd4HIVRlSJ
        aqnOaau3oRZQaA5dAa8iz89Ws9uApE=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygBHTYlws8RgpwzNAA--.48913S2;
        Sat, 12 Jun 2021 21:15:28 +0800 (CST)
Date:   Sat, 12 Jun 2021 21:09:53 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/proc/vmcore: hide mmap_vmcore_fault() and
 vmcore_mmap_ops for nommu
Message-ID: <20210612210953.34dff323@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygBHTYlws8RgpwzNAA--.48913S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyfCFyDKw45tF48Gw45Wrg_yoW8JFy8pF
        15tw1UGF17Wrn8W3W8GFs8GFyrGa4DXFWYgrWUGw1ayrsxJwsruw4YgFsYqFyDWFyxKa4f
        WFWj9rykXay5XrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUy2b7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E
        4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
        Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jY6wZUUUUU=
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

Without CONFIG_MMU, we get a W=1 build warning:

fs/proc/vmcore.c:443:42: warning: unused variable 'vmcore_mmap_ops' [-Wunused-const-variable]
static const struct vm_operations_struct vmcore_mmap_ops = {

The vmcore_mmap_ops is only referenced from an #ifdef'ed caller, so
this uses the same #ifdef around vmcore_mmap_ops and mmap_vmcore_fault().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 fs/proc/vmcore.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 9a15334da208..d902a67cc3ea 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -401,6 +401,7 @@ static ssize_t read_vmcore(struct file *file, char __user *buffer,
 	return __read_vmcore((__force char *) buffer, buflen, fpos, 1);
 }
 
+#ifdef CONFIG_MMU
 /*
  * The vmcore fault handler uses the page cache and fills data using the
  * standard __vmcore_read() function.
@@ -443,6 +444,7 @@ static vm_fault_t mmap_vmcore_fault(struct vm_fault *vmf)
 static const struct vm_operations_struct vmcore_mmap_ops = {
 	.fault = mmap_vmcore_fault,
 };
+#endif
 
 /**
  * vmcore_alloc_buf - allocate buffer in vmalloc memory
-- 
2.32.0


