Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDE2B19F56E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 14:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgDFMDb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 08:03:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44780 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgDFMDa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 08:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=PqrAb/R+T1+weUMpxzPvgPO+qhhXZzaZTaIC3FpFndY=; b=Kn+9pJ/mysCBzu8GjjoOQcumax
        hSuKp9CdjFc4ZwzOO4eGQ0knuFONtyN88JXFQMIRcxopWq5PRPj25rmdTbzYfqStGRXBcQijUstZz
        4wkaqvg+VRoZuM9cpNlGy7PjdOEfJpSZG/xMjRei8BOdXi3pIympfj9LtKErKXLdxgH8Ty6Xns+iD
        7N+6YEUc+TVLnZphiO1IAPqc4FrcX9DSzhKqDeW/NuPGYGSE/VixxxV7vdi54CLEYeoUQZkF01cwN
        udwiqwTX+RlG5UUKKkseM9YOKBkocRUBI770gnDwqI2drxrNcJ+BG42vg2LR9EvLqj2KaEBLhu6bK
        Wm2cqXXg==;
Received: from [2001:4bb8:180:5765:7ca0:239a:fe26:fec2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLQTL-0003KV-Mz; Mon, 06 Apr 2020 12:03:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] binfmt_elf_fdpic: remove the set_fs(KERNEL_DS) in elf_fdpic_core_dump
Date:   Mon,  6 Apr 2020 14:03:10 +0200
Message-Id: <20200406120312.1150405-5-hch@lst.de>
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

There is no logic in elf_fdpic_core_dump itself that uses uaccess
routines on kernel pointers, the file writes are nicely encapsulated in
dump_emit which does its own set_fs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/binfmt_elf_fdpic.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 240f66663543..c62c17a5c34a 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1549,7 +1549,6 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 {
 #define	NUM_NOTES	6
 	int has_dumped = 0;
-	mm_segment_t fs;
 	int segs;
 	int i;
 	struct vm_area_struct *vma;
@@ -1678,9 +1677,6 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 			  "LINUX", ELF_CORE_XFPREG_TYPE, sizeof(*xfpu), xfpu);
 #endif
 
-	fs = get_fs();
-	set_fs(KERNEL_DS);
-
 	offset += sizeof(*elf);				/* Elf header */
 	offset += segs * sizeof(struct elf_phdr);	/* Program headers */
 
@@ -1695,7 +1691,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 
 		phdr4note = kmalloc(sizeof(*phdr4note), GFP_KERNEL);
 		if (!phdr4note)
-			goto end_coredump;
+			goto cleanup;
 
 		fill_elf_note_phdr(phdr4note, sz, offset);
 		offset += sz;
@@ -1711,17 +1707,17 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	if (e_phnum == PN_XNUM) {
 		shdr4extnum = kmalloc(sizeof(*shdr4extnum), GFP_KERNEL);
 		if (!shdr4extnum)
-			goto end_coredump;
+			goto cleanup;
 		fill_extnum_info(elf, shdr4extnum, e_shoff, segs);
 	}
 
 	offset = dataoff;
 
 	if (!dump_emit(cprm, elf, sizeof(*elf)))
-		goto end_coredump;
+		goto cleanup;
 
 	if (!dump_emit(cprm, phdr4note, sizeof(*phdr4note)))
-		goto end_coredump;
+		goto cleanup;
 
 	/* write program headers for segments dump */
 	for (vma = current->mm->mmap; vma; vma = vma->vm_next) {
@@ -1745,16 +1741,16 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 		phdr.p_align = ELF_EXEC_PAGESIZE;
 
 		if (!dump_emit(cprm, &phdr, sizeof(phdr)))
-			goto end_coredump;
+			goto cleanup;
 	}
 
 	if (!elf_core_write_extra_phdrs(cprm, offset))
-		goto end_coredump;
+		goto cleanup;
 
  	/* write out the notes section */
 	for (i = 0; i < numnote; i++)
 		if (!writenote(notes + i, cprm))
-			goto end_coredump;
+			goto cleanup;
 
 	/* write out the thread status notes section */
 	list_for_each(t, &thread_list) {
@@ -1763,21 +1759,21 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 
 		for (i = 0; i < tmp->num_notes; i++)
 			if (!writenote(&tmp->notes[i], cprm))
-				goto end_coredump;
+				goto cleanup;
 	}
 
 	if (!dump_skip(cprm, dataoff - cprm->pos))
-		goto end_coredump;
+		goto cleanup;
 
 	if (!elf_fdpic_dump_segments(cprm))
-		goto end_coredump;
+		goto cleanup;
 
 	if (!elf_core_write_extra_data(cprm))
-		goto end_coredump;
+		goto cleanup;
 
 	if (e_phnum == PN_XNUM) {
 		if (!dump_emit(cprm, shdr4extnum, sizeof(*shdr4extnum)))
-			goto end_coredump;
+			goto cleanup;
 	}
 
 	if (cprm->file->f_pos != offset) {
@@ -1787,9 +1783,6 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 		       cprm->file->f_pos, offset);
 	}
 
-end_coredump:
-	set_fs(fs);
-
 cleanup:
 	while (!list_empty(&thread_list)) {
 		struct list_head *tmp = thread_list.next;
-- 
2.25.1

