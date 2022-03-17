Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6008D4DD15D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 00:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiCQXuM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 19:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiCQXuJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 19:50:09 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958272A5AA8;
        Thu, 17 Mar 2022 16:48:50 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o68-20020a17090a0a4a00b001c686a48263so1899098pjo.1;
        Thu, 17 Mar 2022 16:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lpJtQjEfn/J2FKfZSO5FEN5nDVRpWWfEH9M+CcSvJbU=;
        b=RW+a9Wh2STaMT2/ByGK2Md1L8l3qKvZPNAaJhGfAVuHce7kmLxJdX9c9n536/G9P9y
         rvKTyft8Ed8eVecVBtxNJ2AhZb5BHkZZRQ6tIYAz7LjMedc55NDEtR/KaNFKvJJDd+P7
         dy6mETgUQ3B6OTZJRO7Su7WKmvdgNXwy+9EwnZOz9NXxEQTMUvnGftE1KdHEXVH19Unr
         03ZuudCFe8ibtoQLSzHvkHZddzxVkQNTFTI+HDVGugx8wRTOOgdYd3gwkGBPGeF2R8/z
         YER8jENcx9I+w/nKNDbx91mtq4iJfWJC/8eIMf2hu7fjepJma0HgRYdRXFf3QEkXmcBs
         OFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lpJtQjEfn/J2FKfZSO5FEN5nDVRpWWfEH9M+CcSvJbU=;
        b=Uz9cXlJMhNaitTQyoxcUP9wwa54uEhBtI6mpqH4ZbaPgPLnJ0M6meLZVxKupqbcgr8
         X1KRIxoKE6uV37w0Az5JRdSi4zr0OOTzik+32QxTtJZwUvR+NcE0aNzeTMOa07mHi+oP
         mI7gJBqxKZ/uEgT5gUZCiAcqRozt6JB4/uTgYa5RAN0mDh1WZU55Q41ppwiGkIQXpzuJ
         W8O/QrUrYK8KEm8PJLM94/jggvP9KR+LlB/8HLHqrZuPf9cRMxUOtn6QVMIPiA+hERV7
         n6xq4Q4nhTL7TSI7EgQ9ZXhM0ZH+s7mLehmub/De2sN33ZOP4sLN4TCSWlOWaX80uQTW
         cOFA==
X-Gm-Message-State: AOAM531HjpWBEnUOfDer8rJh1q7sGmKNg0R/hvWqM/7ysEFZDf2xIKuF
        I6xwtYzlxLTHNxeu6FcFMgQ=
X-Google-Smtp-Source: ABdhPJzOSd1Yo9VoDx5vkTBlM+flQ+uJvq5hb6bD1MASZybdj0vNcol2PHZgGMYbr9bl0KDm+fi/4g==
X-Received: by 2002:a17:902:aa01:b0:153:3a40:1097 with SMTP id be1-20020a170902aa0100b001533a401097mr7196864plb.107.1647560930108;
        Thu, 17 Mar 2022 16:48:50 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id o7-20020aa79787000000b004f8e44a02e2sm8581329pfp.45.2022.03.17.16.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 16:48:49 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH 8/8] fs: register suitable readonly vmas for khugepaged
Date:   Thu, 17 Mar 2022 16:48:27 -0700
Message-Id: <20220317234827.447799-9-shy828301@gmail.com>
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

The readonly FS THP relies on khugepaged to collapse THP for suitable
vmas.  But it is kind of "random luck" for khugepaged to see the
readonly FS vmas (https://lore.kernel.org/linux-mm/00f195d4-d039-3cf2-d3a1-a2c88de397a0@suse.cz/)
since currently the vmas are registered to khugepaged when:
  - Anon huge pmd page fault
  - VMA merge
  - MADV_HUGEPAGE
  - Shmem mmap

If the above conditions are not met, even though khugepaged is enabled
it won't see readonly FS vmas at all.  MADV_HUGEPAGE could be specified
explicitly to tell khugepaged to collapse this area, but when khugepaged
mode is "always" it should scan suitable vmas as long as VM_NOHUGEPAGE
is not set.

So make sure readonly FS vmas are registered to khugepaged to make the
behavior more consistent.

Registering the vmas in mmap path seems more preferred from performance
point of view since page fault path is definitely hot path.

Reported-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 fs/ext4/file.c    | 4 ++++
 fs/xfs/xfs_file.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 8cc11715518a..b894cd5aff44 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -30,6 +30,7 @@
 #include <linux/uio.h>
 #include <linux/mman.h>
 #include <linux/backing-dev.h>
+#include <linux/khugepaged.h>
 #include "ext4.h"
 #include "ext4_jbd2.h"
 #include "xattr.h"
@@ -782,6 +783,9 @@ static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
 	} else {
 		vma->vm_ops = &ext4_file_vm_ops;
 	}
+
+	khugepaged_enter_file(vma, vma->vm_flags);
+
 	return 0;
 }
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 5bddb1e9e0b3..d94144b1fb0f 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -30,6 +30,7 @@
 #include <linux/mman.h>
 #include <linux/fadvise.h>
 #include <linux/mount.h>
+#include <linux/khugepaged.h>
 
 static const struct vm_operations_struct xfs_file_vm_ops;
 
@@ -1407,6 +1408,9 @@ xfs_file_mmap(
 	vma->vm_ops = &xfs_file_vm_ops;
 	if (IS_DAX(inode))
 		vma->vm_flags |= VM_HUGEPAGE;
+
+	khugepaged_enter_file(vma, vma->vm_flags);
+
 	return 0;
 }
 
-- 
2.26.3

