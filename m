Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05233E9357
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 16:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbhHKOMO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 10:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbhHKOMN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 10:12:13 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE86C0613D3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Aug 2021 07:11:49 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z11so3921637edb.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Aug 2021 07:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=h8iKVDtBUyzsr7/V/NiTCr0uqw4kRNEUJDacgRjPpPI=;
        b=XL181+6FYKSKBUdZaWYWBUY8mgGlgimGrbE6W9t+S/CSDUsMfhMILm5c4fJpe8cGWw
         y69iS8ZOrpqeOroj49BS7wxsPVlCUcRdfdNbsYlFXhzeHCD4zDd6Y1FjOnfhb8XaTgmn
         2UqXLYJFB69t5469hPnoS0iq7QRam7VNhUGBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=h8iKVDtBUyzsr7/V/NiTCr0uqw4kRNEUJDacgRjPpPI=;
        b=m8fWF6RUFk9KZOqT9kLFsJGR2QMuPkWhJlv4ykab0aU+APbPfQ7dC3vAp+lrgMqJ4a
         cnOCd7beCXeLQFuk/b33L+p0KNHSXI3Uw+itUWOLvz5TU8/QCSzzZJ3o2aH+lJN48g14
         fjsU4zH4lKJaPbDf63g5923G8MSKo7oE6T14nuy4V0aST6F5aiiZOMWWfDgY2xcNypRU
         d4v3WgvScbruWX/JGpV54zt7JWBklcj2WECDhgWeQmVqXTXMWkbhxKFv7+/MOfkbX2QT
         BGkP2ScHtNrCmWiZoo9RNdQMOPYFxg/hRI7XOpRaxYzFRppa9tXatSYtdPOlixBZKMCm
         a+6w==
X-Gm-Message-State: AOAM533EswZJjFmYG7P5Pfed1kqDQ+HvRdUe6p1+fN9M0xKnH5Z8RI5n
        j4NZ6cstsCw7X4zXntYFvOkYGlrZD1OgBw==
X-Google-Smtp-Source: ABdhPJxzcRA6Pnf737/+TIKDMNnxcylKXpNDwUnkPSHJCb5Yk/qPApU4i/Om2je8VrI1JQyJESThkg==
X-Received: by 2002:aa7:d296:: with SMTP id w22mr11561530edq.170.1628691108358;
        Wed, 11 Aug 2021 07:11:48 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-16.catv.broadband.hu. [86.101.169.16])
        by smtp.gmail.com with ESMTPSA id s24sm3290589edq.56.2021.08.11.07.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 07:11:47 -0700 (PDT)
Date:   Wed, 11 Aug 2021 16:11:45 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: mmap denywrite mess (Was: [GIT PULL] overlayfs fixes for 5.14-rc6)
Message-ID: <YRPaodsBm3ambw8z@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 09, 2021 at 02:25:17PM -0700, Linus Torvalds wrote:

> Ugh. Th edances with denywrite and mapping_unmap_writable are really
> really annoying.

Attached version has error and success paths separated.  Was that your
complaint?

> I get the feeling that the whole thing with deny_write_access and
> mapping_map_writable could possibly be done after-the-fact somehow as
> part of actually inserting the vma in the vma tree, rather than done
> as the vma is prepared.

I don't know if that's doable or not.  The final denywrite count is obtained in
__vma_link_file(), called after __vma_link().  The questions are:

 - does the order of those helper calls matter?

 - if it does, could the __vma_link() be safely undone after an unsuccessful
   __vmal_link_file()?

> And most users of vma_set_file() probably really don't want that whole
> thing at all (ie the DRM stuff that just switches out a local thing.
> They also don't check for the new error cases you've added.

Christian König wants to follow up with those checks (which should be asserts,
if the code wasn't buggy in the first place).

> So I really think this is quite questionable, and those cases should
> probably have been done entirely inside ovlfs rather than polluting
> the cases that don't care and don't check.

I don't get that.  mmap_region() currently drops the deny counts from the
original file.  That doesn't work for overlayfs since it needs to take new temp
counts on the override file.

So mmap_region() is changed to drop the counts on vma->vm_file, but then all
callers of vma_set_file() will need to do that switch of temp counts, there's no
way around that.

Thanks,
Miklos

For reference, here's the previous discussion:

https://lore.kernel.org/linux-mm/YNHXzBgzRrZu1MrD@miu.piliscsaba.redhat.com/

---
 fs/overlayfs/file.c |    4 +++-
 include/linux/mm.h  |    2 +-
 mm/mmap.c           |    2 +-
 mm/util.c           |   31 ++++++++++++++++++++++++++++++-
 4 files changed, 35 insertions(+), 4 deletions(-)

--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -475,7 +475,9 @@ static int ovl_mmap(struct file *file, s
 	if (WARN_ON(file != vma->vm_file))
 		return -EIO;
 
-	vma_set_file(vma, realfile);
+	ret = vma_set_file(vma, realfile);
+	if (ret)
+		return ret;
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	ret = call_mmap(vma->vm_file, vma);
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2780,7 +2780,7 @@ static inline void vma_set_page_prot(str
 }
 #endif
 
-void vma_set_file(struct vm_area_struct *vma, struct file *file);
+int /* __must_check */ vma_set_file(struct vm_area_struct *vma, struct file *file);
 
 #ifdef CONFIG_NUMA_BALANCING
 unsigned long change_prot_numa(struct vm_area_struct *vma,
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1806,6 +1806,7 @@ unsigned long mmap_region(struct file *f
 		 */
 		vma->vm_file = get_file(file);
 		error = call_mmap(file, vma);
+		file = vma->vm_file;
 		if (error)
 			goto unmap_and_free_vma;
 
@@ -1867,7 +1868,6 @@ unsigned long mmap_region(struct file *f
 		if (vm_flags & VM_DENYWRITE)
 			allow_write_access(file);
 	}
-	file = vma->vm_file;
 out:
 	perf_event_mmap(vma);
 
--- a/mm/util.c
+++ b/mm/util.c
@@ -314,12 +314,41 @@ int vma_is_stack_for_current(struct vm_a
 /*
  * Change backing file, only valid to use during initial VMA setup.
  */
-void vma_set_file(struct vm_area_struct *vma, struct file *file)
+int vma_set_file(struct vm_area_struct *vma, struct file *file)
 {
+	vm_flags_t vm_flags = vma->vm_flags;
+	int err;
+
+	/* Get temporary denial counts on replacement */
+	if (vm_flags & VM_DENYWRITE) {
+		err = deny_write_access(file);
+		if (err)
+			return err;
+	}
+	if (vm_flags & VM_SHARED) {
+		err = mapping_map_writable(file->f_mapping);
+		if (err)
+			goto undo_denywrite;
+	}
+
 	/* Changing an anonymous vma with this is illegal */
 	get_file(file);
 	swap(vma->vm_file, file);
+
+	/* Undo temporary denial counts on replaced */
+	if (vm_flags & VM_SHARED)
+		mapping_unmap_writable(file->f_mapping);
+
+	if (vm_flags & VM_DENYWRITE)
+		allow_write_access(file);
+
 	fput(file);
+	return 0;
+
+undo_denywrite:
+	if (vm_flags & VM_DENYWRITE)
+		allow_write_access(file);
+	return err;
 }
 EXPORT_SYMBOL(vma_set_file);
 
