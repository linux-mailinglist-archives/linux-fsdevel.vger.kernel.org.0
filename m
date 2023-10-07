Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E907BC9DA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 22:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344196AbjJGUvU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Oct 2023 16:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344176AbjJGUvP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Oct 2023 16:51:15 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D685EB9;
        Sat,  7 Oct 2023 13:51:12 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3296b87aa13so1498169f8f.3;
        Sat, 07 Oct 2023 13:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696711871; x=1697316671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgUbWzhgbQTh2Tsrre/VRjjQqlOhd22889mYfV2Y6PM=;
        b=TfR9S7iZqWd68vkAG78o8osauyeVyv21OxFixVbIkzSvoBOM2Nc3ZB666TI0MVNcwe
         CLSaAaJ4dwmJlACIc31kfIf1eG4jMiWe/+E4dftKQQaBrOOP2VOuXuDiS6fm1Mo+Bm/U
         Bj4tfqH/d8Qc0Vc+DC4720Y8XaS9ykYbFVHxFx07G7NgX3/k4UJBPTw4vsZUKETjMOot
         9+mWT2mcw7uwYv5xEpnOwibVIgNtLqgWUIR1QYgEGY5Byjdr9nz8l/bn42RsF7KJtzIT
         /sMoq5QgYSSi3FmbtS7jyBErJ+SpbxR5DKq7zQC0Xoil1dIMpc4hAq+KF3MUWVsLiKi0
         g6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696711871; x=1697316671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgUbWzhgbQTh2Tsrre/VRjjQqlOhd22889mYfV2Y6PM=;
        b=wjDK6XrQANyjj3zmYMZW4bpqvO0cRiUC24N1c4+TXmNJOZBccWQZTXTEFPQdUQS0fh
         vU8DGx/jcotcv62oo+dQ/jNJBAfsd1BB2wBVLAmIxVqx+h6VnHHAC//IGy7++iWWG+04
         vlhQIVZrOha8ynYzLhw2Hzj1sMnQm+Lpo590WC3V04IKHkYHO52GRsbuYPz+1JKXArSy
         7J43JVEVn3oiorTsV/HSUOmXC7Zgx7z8Ep7KXrdii0lQ/OeD85GpjLecaKmUGakAHXO8
         ofPHT8KEbUPHZZu6cLyoVU5XN9eYGnbZG8v7Uz41WENeO+GDXaL/ugwwvK5y9n89aT9D
         9dzg==
X-Gm-Message-State: AOJu0YxN53ELhqrZtleu4yjdlBg0vLDNYG717suU/XttMYdLyNlVBFqF
        7MPuRr55o6yNottVCfU2l6c=
X-Google-Smtp-Source: AGHT+IEXmITz4RMxLO9GqG7a0wyR3fIBUWZzSpv/XJYSngX65HmU/52/H9zjUYWovmJKhPLVZlC06A==
X-Received: by 2002:adf:f005:0:b0:326:c623:3bbf with SMTP id j5-20020adff005000000b00326c6233bbfmr11078774wro.26.1696711871254;
        Sat, 07 Oct 2023 13:51:11 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id g7-20020adfe407000000b003232d122dbfsm5120550wrm.66.2023.10.07.13.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 13:51:10 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Andy Lutomirski <luto@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v3 2/3] mm: update memfd seal write check to include F_SEAL_WRITE
Date:   Sat,  7 Oct 2023 21:51:00 +0100
Message-ID: <f33faf83fe231441b41a8eeb170e9212b346c547.1696709413.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696709413.git.lstoakes@gmail.com>
References: <cover.1696709413.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The seal_check_future_write() function is called by shmem_mmap() or
hugetlbfs_file_mmap() to disallow any future writable mappings of an memfd
sealed this way.

The F_SEAL_WRITE flag is not checked here, as that is handled via the
mapping->i_mmap_writable mechanism and so any attempt at a mapping would
fail before this could be run.

However we intend to change this, meaning this check can be performed for
F_SEAL_WRITE mappings also.

The logic here is equally applicable to both flags, so update this function
to accommodate both and rename it accordingly.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 fs/hugetlbfs/inode.c |  2 +-
 include/linux/mm.h   | 15 ++++++++-------
 mm/shmem.c           |  2 +-
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 06693bb1153d..5c333373dcc9 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -112,7 +112,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND);
 	vma->vm_ops = &hugetlb_vm_ops;
 
-	ret = seal_check_future_write(info->seals, vma);
+	ret = seal_check_write(info->seals, vma);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c9e9628addc4..51a217ed4d1b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4027,25 +4027,26 @@ static inline void mem_dump_obj(void *object) {}
 #endif
 
 /**
- * seal_check_future_write - Check for F_SEAL_FUTURE_WRITE flag and handle it
+ * seal_check_write - Check for F_SEAL_WRITE or F_SEAL_FUTURE_WRITE flags and
+ *                    handle them.
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
-		 * "future write" seal active.
+		 * write seals are active.
 		 */
 		if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
 			return -EPERM;
 
 		/*
-		 * Since an F_SEAL_FUTURE_WRITE sealed memfd can be mapped as
+		 * Since an F_SEAL_[FUTURE_]WRITE sealed memfd can be mapped as
 		 * MAP_SHARED and read-only, take care to not allow mprotect to
 		 * revert protections on such mappings. Do this only for shared
 		 * mappings. For private mappings, don't need to mask
diff --git a/mm/shmem.c b/mm/shmem.c
index 6503910b0f54..cab053831fea 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2405,7 +2405,7 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	int ret;
 
-	ret = seal_check_future_write(info->seals, vma);
+	ret = seal_check_write(info->seals, vma);
 	if (ret)
 		return ret;
 
-- 
2.42.0

