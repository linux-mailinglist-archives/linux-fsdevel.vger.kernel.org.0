Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB024D1641
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 12:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiCHLaU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 06:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344841AbiCHLaR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:30:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3608C37BE8;
        Tue,  8 Mar 2022 03:29:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA31BB81752;
        Tue,  8 Mar 2022 11:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B53C340EC;
        Tue,  8 Mar 2022 11:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646738957;
        bh=aNy6hu47F0HY+IsRTnwsy1/gwrBD0sBaHYzkZ0C0zfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sWs2atuZwSihcX9Dy7w5encgCdyhpdbOegWQykbW4luZFEKIbFy86FaRrHEBusMEh
         0oXAF1kxbHkUygisJQxlslivtXff8+bOoWpn+KlMQHEBqGNCHdxYxCYg7M9p6s3QwP
         6Bs7VnLmco7h+VzS7jatw86hXzY5r+Jabjgq9Vm+uZUrMqOs8K/jvizmOXUGI520T5
         UHixmt47amntsk5Jgt6T6H3TeAxv7EX1XlCmvX2TRxtiDn8aNXdGPzgMgHUrzpRCIE
         U6fm/dlXYjLtMFfJBUF1/eePdZnqbXBj69Y/LMRFun9WfVyWrrOhHEmlI3eVc2CaSy
         iIBCMGnqmnGyw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH RFC v3 1/3] mm: Add f_op->populate() for populating memory outside of core mm
Date:   Tue,  8 Mar 2022 13:28:31 +0200
Message-Id: <20220308112833.262805-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220308112833.262805-1-jarkko@kernel.org>
References: <20220308112833.262805-1-jarkko@kernel.org>
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

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v5:
* In v4, one diff was left out of staging area in __mm_populate(). It
  was unintentional to remove the conditional statement.
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
---
 include/linux/fs.h |  1 +
 mm/gup.c           | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

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
index a9d4d724aef7..1f3a1d0b6e0d 100644
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
@@ -1598,6 +1601,7 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 	struct vm_area_struct *vma = NULL;
 	int locked = 0;
 	long ret = 0;
+	bool is_io;
 
 	end = start + len;
 
@@ -1619,7 +1623,8 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 		 * range with the first VMA. Also, skip undesirable VMA types.
 		 */
 		nend = min(end, vma->vm_end);
-		if (vma->vm_flags & (VM_IO | VM_PFNMAP))
+		is_io = !!(vma->vm_flags & (VM_IO | VM_PFNMAP));
+		if (is_io && !(is_io && vma->vm_file->f_op->populate))
 			continue;
 		if (nstart < vma->vm_start)
 			nstart = vma->vm_start;
-- 
2.35.1

