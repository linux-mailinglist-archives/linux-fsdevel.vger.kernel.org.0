Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820F94D15E6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 12:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346377AbiCHLMD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 06:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346336AbiCHLLz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:11:55 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC79C46152;
        Tue,  8 Mar 2022 03:10:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 05BA1CE1389;
        Tue,  8 Mar 2022 11:10:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DB9C340EC;
        Tue,  8 Mar 2022 11:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646737853;
        bh=WFgarrj7YVpHc+BKJTPJxYeEYbi76FtZ0eeCRFRqG1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oxjmeSyvoQwzOY1Cm834gXsI/z3vB2GRWDWv4fICOaZRvtKV1YcIlNe1emEzAdkhS
         E649NWxLq3ZqXaiRBSUunEUzFZNlIPck6S2ntQlYQUoslsZnbpfztS6SrQPgtu8VfY
         YrRJZGd6V/leH8pTIaRSCJ+3G7xN+KtL1ciD4VUVHBFP8ZU8J8jvxfw5X0IZyuiSaD
         gfj6bp2Y2HvnlPF4SuY0TmAxY3gsn/Ep09VWfy/BsOBV1ETJoXB/P3CyMJaym+HDSQ
         4KTARfatOkIOiUQFeWszFgi79eFpVOaVyKRKaAsctGU01O0iqqbhs31hhHfLrxAOoR
         0Wm6FffB1QTRQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH RFC v2 1/3] mm: Add f_op->populate() for populating memory outside of core mm
Date:   Tue,  8 Mar 2022 13:10:01 +0200
Message-Id: <20220308111003.257351-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220308111003.257351-1-jarkko@kernel.org>
References: <20220308111003.257351-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGX memory is managed outside the core mm.  It doesn't have a 'struct
page' and get_user_pages() doesn't work on it.  Its VMAs are marked with
VM_IO.  So, none of the existing methods for avoiding page faults work
on SGX memory.

Add f_op->populate() to overcome this issue:

int (*populate)(struct file *, unsigned long start, unsigned long end);

Then in populate_vma_page_range(), allow it to be used in the place of
get_user_pages() for memory that falls outside of its scope.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v4:
* Reimplement based on Dave's suggestion:
  https://lore.kernel.org/linux-sgx/c3083144-bfc1-3260-164c-e59b2d110df8@intel.com/
* Copy the text from the suggestion as part of the commit message (and
  cover letter).
v3:
-       if (!ret && do_populate && file->f_op->populate)
+       if (!ret && do_populate && file->f_op->populate &&
+           !!(vma->vm_flags & (VM_IO | VM_PFNMAP)))
(reported by Matthew Wilcox)
v2:
-       if (!ret && do_populate)
+       if (!ret && do_populate && file->f_op->populate)
(reported by Jan Harkes)
 include/linux/fs.h | 1 +
 mm/gup.c           | 9 +++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index e2d892b201b0..54151af88ee0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1993,6 +1993,7 @@ struct file_operations {
 	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
 	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
 	int (*mmap) (struct file *, struct vm_area_struct *);
+	int (*populate)(struct file *, unsigned long start, unsigned long end);
 	unsigned long mmap_supported_flags;
 	int (*open) (struct inode *, struct file *);
 	int (*flush) (struct file *, fl_owner_t id);
diff --git a/mm/gup.c b/mm/gup.c
index a9d4d724aef7..66736a188a9c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1519,8 +1519,11 @@ long populate_vma_page_range(struct vm_area_struct *vma,
 	 * We made sure addr is within a VMA, so the following will
 	 * not result in a stack expansion that recurses back here.
 	 */
-	return __get_user_pages(mm, start, nr_pages, gup_flags,
-				NULL, NULL, locked);
+	if ((vma->vm_flags & (VM_IO | VM_PFNMAP)) && vma->vm_file->f_op->populate)
+		return vma->vm_file->f_op->populate(vma->vm_file, start, end);
+	else
+		return __get_user_pages(mm, start, nr_pages, gup_flags,
+					NULL, NULL, locked);
 }
 
 /*
@@ -1619,8 +1622,6 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 		 * range with the first VMA. Also, skip undesirable VMA types.
 		 */
 		nend = min(end, vma->vm_end);
-		if (vma->vm_flags & (VM_IO | VM_PFNMAP))
-			continue;
 		if (nstart < vma->vm_start)
 			nstart = vma->vm_start;
 		/*
-- 
2.35.1

