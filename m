Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6871C52BF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 12:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgEEKNb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 06:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728727AbgEEKN1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 06:13:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D9EC061A0F;
        Tue,  5 May 2020 03:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=0bHppblaPmDxTAjn3jOg5XHlDLubZOOc/MJ2gG3CZzc=; b=mplopeTSiFGW6qyoJEY67/74uJ
        B4c0b6qCTqcztRxwKqid7gyrWJ/1xrJuFYoYH6BkxSg4qxCkEBwPlbyDX4D4H9vQ1XKnEMrMeQuQd
        sRE4dVtLTSxs4CsQibco9O6uyr2agdhZomhHmwhoTwXEu2VRYKJba7+WfxFUyenCkTqldLFAGc0bW
        SAjxUzWvs9Dxmi4SlCIrFx0aAd/yWFTxfy95XTfOgx/tpibtmlLsSUnHjYB9dAU7vfy3tbrugr1QJ
        1vfhONYSuTiDGGrd4kV4+WPOTiUei9+b9UVljXpESqX//frFBxaJnVMIzE6xEMuN04E7peMK6Qx5h
        1S6/Dcaw==;
Received: from [2001:4bb8:191:66b6:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVuZf-0006wC-RN; Tue, 05 May 2020 10:13:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] binfmt_elf: remove the set_fs(KERNEL_DS) in elf_core_dump
Date:   Tue,  5 May 2020 12:12:55 +0200
Message-Id: <20200505101256.3121270-7-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505101256.3121270-1-hch@lst.de>
References: <20200505101256.3121270-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no logic in elf_core_dump itself or in the various arch helpers
called from it which use uaccess routines on kernel pointers except for
the file writes thate are nicely encapsulated by using __kernel_write in
dump_emit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/binfmt_elf.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index a1f57e20c3cf2..ba6f87ba029a7 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1355,7 +1355,6 @@ static unsigned long vma_dump_size(struct vm_area_struct *vma,
 	    vma->vm_pgoff == 0 && (vma->vm_flags & VM_READ)) {
 		u32 __user *header = (u32 __user *) vma->vm_start;
 		u32 word;
-		mm_segment_t fs = get_fs();
 		/*
 		 * Doing it this way gets the constant folded by GCC.
 		 */
@@ -1368,14 +1367,8 @@ static unsigned long vma_dump_size(struct vm_area_struct *vma,
 		magic.elfmag[EI_MAG1] = ELFMAG1;
 		magic.elfmag[EI_MAG2] = ELFMAG2;
 		magic.elfmag[EI_MAG3] = ELFMAG3;
-		/*
-		 * Switch to the user "segment" for get_user(),
-		 * then put back what elf_core_dump() had in place.
-		 */
-		set_fs(USER_DS);
 		if (unlikely(get_user(word, header)))
 			word = 0;
-		set_fs(fs);
 		if (word == magic.cmp)
 			return PAGE_SIZE;
 	}
@@ -2183,7 +2176,6 @@ static void fill_extnum_info(struct elfhdr *elf, struct elf_shdr *shdr4extnum,
 static int elf_core_dump(struct coredump_params *cprm)
 {
 	int has_dumped = 0;
-	mm_segment_t fs;
 	int segs, i;
 	size_t vma_data_size = 0;
 	struct vm_area_struct *vma, *gate_vma;
@@ -2232,13 +2224,10 @@ static int elf_core_dump(struct coredump_params *cprm)
 	 * notes.  This also sets up the file header.
 	 */
 	if (!fill_note_info(&elf, e_phnum, &info, cprm->siginfo, cprm->regs))
-		goto cleanup;
+		goto end_coredump;
 
 	has_dumped = 1;
 
-	fs = get_fs();
-	set_fs(KERNEL_DS);
-
 	offset += sizeof(elf);				/* Elf header */
 	offset += segs * sizeof(struct elf_phdr);	/* Program headers */
 
@@ -2366,9 +2355,6 @@ static int elf_core_dump(struct coredump_params *cprm)
 	}
 
 end_coredump:
-	set_fs(fs);
-
-cleanup:
 	free_note_info(&info);
 	kfree(shdr4extnum);
 	kvfree(vma_filesz);
-- 
2.26.2

