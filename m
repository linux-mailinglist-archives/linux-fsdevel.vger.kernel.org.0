Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD936D54C1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 00:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbjDCW24 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 18:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbjDCW2r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 18:28:47 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B958730C1;
        Mon,  3 Apr 2023 15:28:45 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j1-20020a05600c1c0100b003f04da00d07so33682wms.1;
        Mon, 03 Apr 2023 15:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680560924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOkGNKrS3X8eAh/4YCdQnl8x0t7nmqXgWQ3n3gC1iCs=;
        b=jnlFG6Zns7WaDQp/BY3IPGn+pGG/Dx9g0H40O2QA6832a7BPjAtYRm4G4MU4TCvHtl
         m/M02a7CdS7+AigaUke7H8ep9j7A5R9R/XhipaYu9lQsd5SPnAP2H2bDlxqoD+KlIn2d
         G6H1WgZqCYZ6Ypy1J/lCJ67//GxRrZ6s9WAl1Oo5uDmjsg7e/4mApHDMq8oFvtz6xVi9
         idOLsR399TXIN2Sh1PxMVPmxPiUkEUv7LeHNU8flh0z5OCl0NpPnCea4mWhcTmLEHo8Z
         1ZuGn9j1RokAD13ddtIMcYwzVgBeCIp4ej0FPNh+jpmCNO9mn1R0kjvTj0deKR5odtHi
         480w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680560924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOkGNKrS3X8eAh/4YCdQnl8x0t7nmqXgWQ3n3gC1iCs=;
        b=qdBR7wlA5QQUQydNi/84Pq28IKMtuRsETe3ZS5EbU70YDbw0wwYvNsgi4/Pg4RCc6u
         iHaau6FJW6r1h/nHJVUlLYrle3njI9pAO5pHZ0iGJDqJpvJ2ZAu0bal2SL9P0Uf99hCH
         0NivXjN+omJXySu3V/JUCic09lURVYvCdvhpt/MQJApF9Q6DQXUp4Q5B5cDVtsEODQlj
         IXaxWOxlcytHa0bDvXxxiOBYUxIM/Y2bhJjd3qbIz+MuvZqJJJXeO3qo3lnk9hE2d0Wc
         Uk9fNDK/RyfTslahOEHrE4pdv8ruDLwsz3KIviDNhUh0ofM0euMcrcESXsLXKNu3kSMa
         WcfQ==
X-Gm-Message-State: AAQBX9cvdxialK43afMe2tKNmlTKI4CFpYGcIAfD+3SWEpk7gmwhh9Gi
        PNddgqWtwRvOliNeE01UB7Q=
X-Google-Smtp-Source: AKy350Z/FSj711UfPkBNuLid9fhkpzpeDavb2nQlLtZkylTV4lV9oCldNngP7ESdTiD6fR3iiF2f/g==
X-Received: by 2002:a05:600c:218d:b0:3ee:36f:3485 with SMTP id e13-20020a05600c218d00b003ee036f3485mr657646wme.8.1680560924213;
        Mon, 03 Apr 2023 15:28:44 -0700 (PDT)
Received: from lucifer.home (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.googlemail.com with ESMTPSA id u17-20020a05600c19d100b003dd1bd0b915sm20731309wmq.22.2023.04.03.15.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 15:28:43 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [RFC PATCH 2/3] mm: update seal_check_[future_]write() to include F_SEAL_WRITE as well
Date:   Mon,  3 Apr 2023 23:28:31 +0100
Message-Id: <75478249600532faab441e43f73d4d04582efcc3.1680560277.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1680560277.git.lstoakes@gmail.com>
References: <cover.1680560277.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index 702d79639c0d..8ab8840707ac 100644
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
index 8e64041b1703..ddf1b35b9dbb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3775,16 +3775,17 @@ static inline void mem_dump_obj(void *object) {}
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
@@ -3793,7 +3794,7 @@ static inline int seal_check_future_write(int seals, struct vm_area_struct *vma)
 			return -EPERM;
 
 		/*
-		 * Since an F_SEAL_FUTURE_WRITE sealed memfd can be mapped as
+		 * Since an F_SEAL_[FUTURE_]WRITE sealed memfd can be mapped as
 		 * MAP_SHARED and read-only, take care to not allow mprotect to
 		 * revert protections on such mappings. Do this only for shared
 		 * mappings. For private mappings, don't need to mask
diff --git a/mm/shmem.c b/mm/shmem.c
index 9218c955f482..863f2ff9fab8 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2313,7 +2313,7 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	int ret;
 
-	ret = seal_check_future_write(info->seals, vma);
+	ret = seal_check_write(info->seals, vma);
 	if (ret)
 		return ret;
 
-- 
2.40.0

