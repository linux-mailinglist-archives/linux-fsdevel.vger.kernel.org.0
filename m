Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1094DD155
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 00:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiCQXuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 19:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiCQXuC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 19:50:02 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A672AA871;
        Thu, 17 Mar 2022 16:48:43 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id v4so6195794pjh.2;
        Thu, 17 Mar 2022 16:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lh1UGdWCnbI+ssw0qidScDsXf7KLfyH1hGff66irmcE=;
        b=R1QJxrwiBU4YS9L9DkNURkUR9lfvb/Cy/T8EIWRnh6gbYSCC+76DVh7/Jg9jXSf55g
         K6fpUi/kIkvkwh+o4gfxQRQ5zFay3g2W0HPBHBD6F0DwymIdlYggztiNO9NHEThRgSbr
         TtnUpg1e0ovlzbqghftQc0RWPR74EJoBCVaUoW93aADPRfCh7a47k3yhbTmOiWYCBy1I
         9EotNKrzw5joQz0eceyxb0qCftsl2fDAIaB+5eS4UgleMXpNCi4e479tODCu9TAGkrNj
         06Ao5McZwciCNSoBQ3XEaZmXgisinxI7sJzX9BY53KfeZsQezL79/RTAj83B6BCpzaJs
         BQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lh1UGdWCnbI+ssw0qidScDsXf7KLfyH1hGff66irmcE=;
        b=B9HGystSF1SvrQjwBr79rV8ZBeYH+eQ7fB7ZWosJ0GHASxv4qrRPe52PscGYCVn8rz
         quOrohOABwRnZiJPvPtwCI6tNEkj+YdjGNeBRQGrpsFpr/3ceQfRIewvWkocj3tw11Qx
         syDVCe++44SP2o3pCCbPNn3R3BPCesA0YnqyjXnxaNgWHwGzQ5gfM86h+Cssn6URYn3e
         SjB/f+YMiV14GiczFm+RmuSJDifYqba/qqb0ceXPMIFSTRv3y8TT8sG3wYIYF48//2P9
         zUGv4FpZgYUbIWWTZsl70vezO7TIbegx4QN1Dp52erGOcmVMSnmOAgb6MgEwBSJU6OD8
         y2Xg==
X-Gm-Message-State: AOAM5323lV7EP/jczdf22+tYehrQ9PKc/kmdKvaJcx6XKeoCaYtbxLwk
        zD+XgRg16X6Y0wouky+tFEM=
X-Google-Smtp-Source: ABdhPJxH1oWUw7HG5U383xf4tuloVnFsIXbUZKg15Usu8FWbDYGloqS9CKbXc3kH1w7IZ+w1PBStrQ==
X-Received: by 2002:a17:90a:e541:b0:1c6:55e5:ae4b with SMTP id ei1-20020a17090ae54100b001c655e5ae4bmr13968964pjb.62.1647560922758;
        Thu, 17 Mar 2022 16:48:42 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id o7-20020aa79787000000b004f8e44a02e2sm8581329pfp.45.2022.03.17.16.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 16:48:42 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH 4/8] mm: thp: only regular file could be THP eligible
Date:   Thu, 17 Mar 2022 16:48:23 -0700
Message-Id: <20220317234827.447799-5-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220317234827.447799-1-shy828301@gmail.com>
References: <20220317234827.447799-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since commit a4aeaa06d45e ("mm: khugepaged: skip huge page collapse for
special files"), khugepaged just collapses THP for regular file which is
the intended usecase for readonly fs THP.  Only show regular file as THP
eligible accordingly.

And make file_thp_enabled() available for khugepaged too in order to remove
duplicate code.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/huge_mm.h | 14 ++++++++++++++
 mm/huge_memory.c        | 11 ++---------
 mm/khugepaged.c         |  9 ++-------
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e4c18ba8d3bf..3cfa79732112 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -172,6 +172,20 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
 	return false;
 }
 
+static inline bool file_thp_enabled(struct vm_area_struct *vma)
+{
+	struct inode *inode;
+
+	if (!vma->vm_file)
+		return false;
+
+	inode = vma->vm_file->f_inode;
+
+	return (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS)) &&
+	       (vma->vm_flags & VM_EXEC) &&
+	       !inode_is_open_for_write(inode) && S_ISREG(inode->i_mode);
+}
+
 bool transparent_hugepage_active(struct vm_area_struct *vma);
 
 #define transparent_hugepage_use_zero_page()				\
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 406a3c28c026..a87b3df63209 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -64,13 +64,6 @@ static atomic_t huge_zero_refcount;
 struct page *huge_zero_page __read_mostly;
 unsigned long huge_zero_pfn __read_mostly = ~0UL;
 
-static inline bool file_thp_enabled(struct vm_area_struct *vma)
-{
-	return transhuge_vma_enabled(vma, vma->vm_flags) && vma->vm_file &&
-	       !inode_is_open_for_write(vma->vm_file->f_inode) &&
-	       (vma->vm_flags & VM_EXEC);
-}
-
 bool transparent_hugepage_active(struct vm_area_struct *vma)
 {
 	/* The addr is used to check if the vma size fits */
@@ -82,8 +75,8 @@ bool transparent_hugepage_active(struct vm_area_struct *vma)
 		return __transparent_hugepage_enabled(vma);
 	if (vma_is_shmem(vma))
 		return shmem_huge_enabled(vma);
-	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS))
-		return file_thp_enabled(vma);
+	if (transhuge_vma_enabled(vma, vma->vm_flags) && file_thp_enabled(vma))
+		return true;
 
 	return false;
 }
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a0e4fa33660e..3dbac3e23f43 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -465,13 +465,8 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
 		return false;
 
 	/* Only regular file is valid */
-	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && vma->vm_file &&
-	    (vm_flags & VM_EXEC)) {
-		struct inode *inode = vma->vm_file->f_inode;
-
-		return !inode_is_open_for_write(inode) &&
-			S_ISREG(inode->i_mode);
-	}
+	if (file_thp_enabled(vma))
+		return true;
 
 	if (!vma->anon_vma || vma->vm_ops)
 		return false;
-- 
2.26.3

