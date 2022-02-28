Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076CB4C7EE3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 00:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiB1X7X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 18:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiB1X7L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 18:59:11 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7969E38798;
        Mon, 28 Feb 2022 15:58:31 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id x18so12542322pfh.5;
        Mon, 28 Feb 2022 15:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lpJtQjEfn/J2FKfZSO5FEN5nDVRpWWfEH9M+CcSvJbU=;
        b=VLRQXiy3wvMknW7AOO7IVvKT7MqkbdlU3FLw3ClWWTqHa1MhRB+cT54O6woccfVv23
         bPVM9qXq6z9fQnsc1ZNinyshivIpU9XgnlE6GxxVR1pVJGieloj7NEL4/9Y56UqfEefA
         nt0ayjMOUb9cb5rL/nilpAkiprwoLdMwikh2BzDI0fmBq2RU3iHJb5syWs73VxIvmf8s
         vaJN5zmC0ipjUwAO6ioaulNabDVSklq6nQ0EHwtl1muE1bO4Tn2al5xuHpb3H/mVmLqH
         zt4VDKst1elD4wKiZ07Ed36eOtFfAxmYtn6WW6JoTyUtsIPpcErbDYEt5qorV2Crwkr8
         TRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lpJtQjEfn/J2FKfZSO5FEN5nDVRpWWfEH9M+CcSvJbU=;
        b=6Apbuw3lvV/Z5fx0GMn/HTF/OQCtS4bzuTgzmOrHWdGjhUgs69nQXq5Jb2NIzCAJjV
         dj5JSIxVQZwUsnSecfnyfaRArtCPYTGfvqz22zuaey04WOhcH3AqBCwpZz3+ZzIUKajV
         LzXfhJpAcFvk0+OePaQZkpWEw4DoQLwl3FnDcAd5ybtN2dWxR57aJYIOH+uO8pksxrQS
         0mwjLjhigX10N6JryCqnsTtR7qf58nUznYj+SqzpnDtbhjFEPdsJ8NbyEQ23w61I7MdD
         0rihIycoSwwspo+KCSZhATZFTKg6mOWyyPNxnpTfx6IwjFZRYQOUuqGnScU7XcKRPkhQ
         A5Iw==
X-Gm-Message-State: AOAM530jeoODsO2AD0KSe61e0X11XDHHEInbD0Ih6Ahi9SLiKj5Cake+
        OzkN48zFtY+NRpwkS1qOMfk=
X-Google-Smtp-Source: ABdhPJzyv0UQbz9tZczy02j/XLMhXWEhyZDVPmYSr4FxI3UgPBCDu42TpFtDCT4zx3Gb1O0sASg6pA==
X-Received: by 2002:a05:6a00:22d3:b0:4f3:d439:7189 with SMTP id f19-20020a056a0022d300b004f3d4397189mr18780779pfj.79.1646092711038;
        Mon, 28 Feb 2022 15:58:31 -0800 (PST)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id on15-20020a17090b1d0f00b001b9d1b5f901sm396963pjb.47.2022.02.28.15.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 15:58:30 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        songliubraving@fb.com, linmiaohe@huawei.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] fs: register suitable readonly vmas for khugepaged
Date:   Mon, 28 Feb 2022 15:57:41 -0800
Message-Id: <20220228235741.102941-9-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220228235741.102941-1-shy828301@gmail.com>
References: <20220228235741.102941-1-shy828301@gmail.com>
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

