Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841B86F2B5B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 00:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjD3W0s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Apr 2023 18:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjD3W0r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Apr 2023 18:26:47 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930991A6;
        Sun, 30 Apr 2023 15:26:45 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-2fddb442d47so1747694f8f.2;
        Sun, 30 Apr 2023 15:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682893604; x=1685485604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StL9gTHBRtlU2jg4ZVDsgmTWUDVZUlKWf2f0xPKhTn0=;
        b=ZcBxn6CMjkdRm3nAQ39aBrgfJnBCb2bk30AmyalhJaUZtdYVYnfTR3+98YhxpbN0eq
         RhTd1LpgdoOLfHl3SkLCbW7yxPFGD2l0KZ7Z8lVMcb4ZkVNEU1QNvBEgwbxyAbaxfMKH
         tpKRISMTfXnczaBlzoVFBY+pjpmTJtB8J4v4SY2rv3erOLl/9kjRPNqAaxgedAdAx1ku
         QN290yBGpErHD0+GTxFLoO8Q190ngSHAqAfvDOCH4Iimp7xnEuxN9Tb9USlwV8WebZdW
         LHZmdGFVFmpPfQeowB54q52OQkDgFSZxYBxn1CQiruoKRKnD0SXq+P7FupuvI70mxFqd
         vVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682893604; x=1685485604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StL9gTHBRtlU2jg4ZVDsgmTWUDVZUlKWf2f0xPKhTn0=;
        b=EoiaNAY91Mgt15ycSSDZ5PHXQS3YEwz8HzPIOYe7Z0QsnUrIOX7z1Oprt4Qj+GkNFZ
         KvL1vPG20AmvisyQwH4KyG1LIPY8dXVmPt+taAsRYdhuF527vmmZQeqPseMQTHY9IZIm
         H6QPd74/fVR2ODJZh0bFXQiOnbiYuIrmEZFdFq71Xfn0TKlsH1V1iSapkPjP0Z0wqxJg
         r70rkwz2f3qUILs5cGDuWlErIw5BAY2t5r+CmZ83Jnj2FfrRIOQPvcsw8uy119jR7ZSn
         mabeXxt19OwBWFI7zSRVJpxwvIzyG80pvRcN6XjRWQJfRid4KfkSFq4p4sueQtijsfU7
         TF5g==
X-Gm-Message-State: AC+VfDy8AMxNE4+hIl4afW2fUpLbLggGa+6+2v1DA0ZxSPSKGcr3y8R6
        Y/xoNt2Sog2d1dLlipp3Tgc=
X-Google-Smtp-Source: ACHHUZ7+gOevXvXP/Vlp1ptLgrITWEfEUgVen2T7segNDbKUOuNGRaU+00ZCQHHi69rin2TjB/K1Jw==
X-Received: by 2002:adf:f484:0:b0:2f8:c94c:3895 with SMTP id l4-20020adff484000000b002f8c94c3895mr9214182wro.23.1682893603897;
        Sun, 30 Apr 2023 15:26:43 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id g2-20020a5d5402000000b002da75c5e143sm26699865wrv.29.2023.04.30.15.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 15:26:43 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v2 2/3] mm: update seal_check_[future_]write() to include F_SEAL_WRITE as well
Date:   Sun, 30 Apr 2023 23:26:06 +0100
Message-Id: <d230b5fb3c2acc955ddea83405f12a61468035c4.1682890156.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1682890156.git.lstoakes@gmail.com>
References: <cover.1682890156.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Check for F_SEAL_WRITE as well for which the precise same logic can
reasonably be applied, however so far this code will simply not be run as
the mapping_map_writable() call occurs before shmem_mmap() or
hugetlbfs_file_mmap() and thus would error out in the case of a read-only
shared mapping before the logic could be applied.

This therefore has no impact until the following patch which changes the
order in which the *_mmap() functions are called.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 fs/hugetlbfs/inode.c |  2 +-
 include/linux/mm.h   | 13 +++++++------
 mm/shmem.c           |  2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index ecfdfb2529a3..4abe3d4a6d1c 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -135,7 +135,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND);
 	vma->vm_ops = &hugetlb_vm_ops;
 
-	ret = seal_check_future_write(info->seals, vma);
+	ret = seal_check_write(info->seals, vma);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3e8fb4601520..6bf63ee1b769 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3784,16 +3784,17 @@ static inline void mem_dump_obj(void *object) {}
 #endif
 
 /**
- * seal_check_future_write - Check for F_SEAL_FUTURE_WRITE flag and handle it
+ * seal_check_write - Check for F_SEAL_WRITE or F_SEAL_FUTURE_WRITE flag and
+ *                    handle it.
  * @seals: the seals to check
  * @vma: the vma to operate on
  *
- * Check whether F_SEAL_FUTURE_WRITE is set; if so, do proper check/handling on
- * the vma flags.  Return 0 if check pass, or <0 for errors.
+ * Check whether F_SEAL_WRITE or F_SEAL_FUTURE_WRITE are set; if so, do proper
+ * check/handling on the vma flags.  Return 0 if check pass, or <0 for errors.
  */
-static inline int seal_check_future_write(int seals, struct vm_area_struct *vma)
+static inline int seal_check_write(int seals, struct vm_area_struct *vma)
 {
-	if (seals & F_SEAL_FUTURE_WRITE) {
+	if (seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE)) {
 		/*
 		 * New PROT_WRITE and MAP_SHARED mmaps are not allowed when
 		 * "future write" seal active.
@@ -3802,7 +3803,7 @@ static inline int seal_check_future_write(int seals, struct vm_area_struct *vma)
 			return -EPERM;
 
 		/*
-		 * Since an F_SEAL_FUTURE_WRITE sealed memfd can be mapped as
+		 * Since an F_SEAL_[FUTURE_]WRITE sealed memfd can be mapped as
 		 * MAP_SHARED and read-only, take care to not allow mprotect to
 		 * revert protections on such mappings. Do this only for shared
 		 * mappings. For private mappings, don't need to mask
diff --git a/mm/shmem.c b/mm/shmem.c
index e517ab50afd9..c54df8e36bc1 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2325,7 +2325,7 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	int ret;
 
-	ret = seal_check_future_write(info->seals, vma);
+	ret = seal_check_write(info->seals, vma);
 	if (ret)
 		return ret;
 
-- 
2.40.1

