Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 898E319F561
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 14:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgDFMD0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 08:03:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44450 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbgDFMD0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 08:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6Gpwc8l2/E0mkvtBTTLed6sDz+2UNSVqDp2RLWlkgzs=; b=dSBJ+Gp22aUT1x2PQw+3K/VZpb
        9HK9+ahGlqEtNNeOsCZkKnKBr9IjKWm8dYEviFdkk2MrgD9/sErTUkQ8/ndMmj+Y92ergG4egl6tM
        su/WztU9oEu+r3bnVOaAk3FDgvTX9H4YbkiJtBwqEW28vCjZGCv7jeiB8UVaNVXrn3S5cSuO7Zooo
        gMLLq1DQFfS7B11OLV2vNWnJzV2sHnTWNPW6qW+NWwYlVExz88zebtuCTdeqZsOwMspb/iqeZpaBC
        H2Mc7BTgh2l5i7p5tRBSH9zboMjJrly9eZ9zDJkhRpQexAVYlCL8TlNjgUjugCNDmIMTshesqanF3
        9WPVQiAg==;
Received: from [2001:4bb8:180:5765:7ca0:239a:fe26:fec2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLQTJ-0003Jr-8c; Mon, 06 Apr 2020 12:03:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] binfmt_elf: remove the set_fs(KERNEL_DS) in elf_core_dump
Date:   Mon,  6 Apr 2020 14:03:09 +0200
Message-Id: <20200406120312.1150405-4-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200406120312.1150405-1-hch@lst.de>
References: <20200406120312.1150405-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no logic in elf_core_dump itself that uses uaccess routines
on kernel pointers, the file writes are nicely encapsulated in dump_emit
which does its own set_fs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/binfmt_elf.c | 40 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index d744ce9a4b52..ef9f68bab7be 100644
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
@@ -2185,7 +2178,6 @@ static void fill_extnum_info(struct elfhdr *elf, struct elf_shdr *shdr4extnum,
 static int elf_core_dump(struct coredump_params *cprm)
 {
 	int has_dumped = 0;
-	mm_segment_t fs;
 	int segs, i;
 	size_t vma_data_size = 0;
 	struct vm_area_struct *vma, *gate_vma;
@@ -2238,9 +2230,6 @@ static int elf_core_dump(struct coredump_params *cprm)
 
 	has_dumped = 1;
 
-	fs = get_fs();
-	set_fs(KERNEL_DS);
-
 	offset += sizeof(elf);				/* Elf header */
 	offset += segs * sizeof(struct elf_phdr);	/* Program headers */
 
@@ -2252,7 +2241,7 @@ static int elf_core_dump(struct coredump_params *cprm)
 
 		phdr4note = kmalloc(sizeof(*phdr4note), GFP_KERNEL);
 		if (!phdr4note)
-			goto end_coredump;
+			goto cleanup;
 
 		fill_elf_note_phdr(phdr4note, sz, offset);
 		offset += sz;
@@ -2267,7 +2256,7 @@ static int elf_core_dump(struct coredump_params *cprm)
 	vma_filesz = kvmalloc(array_size(sizeof(*vma_filesz), (segs - 1)),
 			      GFP_KERNEL);
 	if (!vma_filesz)
-		goto end_coredump;
+		goto cleanup;
 
 	for (i = 0, vma = first_vma(current, gate_vma); vma != NULL;
 			vma = next_vma(vma, gate_vma)) {
@@ -2285,17 +2274,17 @@ static int elf_core_dump(struct coredump_params *cprm)
 	if (e_phnum == PN_XNUM) {
 		shdr4extnum = kmalloc(sizeof(*shdr4extnum), GFP_KERNEL);
 		if (!shdr4extnum)
-			goto end_coredump;
+			goto cleanup;
 		fill_extnum_info(&elf, shdr4extnum, e_shoff, segs);
 	}
 
 	offset = dataoff;
 
 	if (!dump_emit(cprm, &elf, sizeof(elf)))
-		goto end_coredump;
+		goto cleanup;
 
 	if (!dump_emit(cprm, phdr4note, sizeof(*phdr4note)))
-		goto end_coredump;
+		goto cleanup;
 
 	/* Write program headers for segments dump */
 	for (i = 0, vma = first_vma(current, gate_vma); vma != NULL;
@@ -2317,22 +2306,22 @@ static int elf_core_dump(struct coredump_params *cprm)
 		phdr.p_align = ELF_EXEC_PAGESIZE;
 
 		if (!dump_emit(cprm, &phdr, sizeof(phdr)))
-			goto end_coredump;
+			goto cleanup;
 	}
 
 	if (!elf_core_write_extra_phdrs(cprm, offset))
-		goto end_coredump;
+		goto cleanup;
 
  	/* write out the notes section */
 	if (!write_note_info(&info, cprm))
-		goto end_coredump;
+		goto cleanup;
 
 	if (elf_coredump_extra_notes_write(cprm))
-		goto end_coredump;
+		goto cleanup;
 
 	/* Align to page */
 	if (!dump_skip(cprm, dataoff - cprm->pos))
-		goto end_coredump;
+		goto cleanup;
 
 	for (i = 0, vma = first_vma(current, gate_vma); vma != NULL;
 			vma = next_vma(vma, gate_vma)) {
@@ -2354,22 +2343,19 @@ static int elf_core_dump(struct coredump_params *cprm)
 			} else
 				stop = !dump_skip(cprm, PAGE_SIZE);
 			if (stop)
-				goto end_coredump;
+				goto cleanup;
 		}
 	}
 	dump_truncate(cprm);
 
 	if (!elf_core_write_extra_data(cprm))
-		goto end_coredump;
+		goto cleanup;
 
 	if (e_phnum == PN_XNUM) {
 		if (!dump_emit(cprm, shdr4extnum, sizeof(*shdr4extnum)))
-			goto end_coredump;
+			goto cleanup;
 	}
 
-end_coredump:
-	set_fs(fs);
-
 cleanup:
 	free_note_info(&info);
 	kfree(shdr4extnum);
-- 
2.25.1

