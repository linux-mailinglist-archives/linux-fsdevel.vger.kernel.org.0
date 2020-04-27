Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432721BAEC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 22:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgD0UGx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 16:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726789AbgD0UGv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:06:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C95C0610D5;
        Mon, 27 Apr 2020 13:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=HvsuEE5+Vpf11RhZiIeD024n91SKgo+pyfBY5PqLiHs=; b=fz44ydA9lpLx6+mZRQa+jdunmM
        2xFuVgrbgquFBgLBTB0qhCVkbWljLk7X4dPlF7J4ybyPZozZD1qrxtRJ3VPoA/mgtFeFJtv3RJtjM
        geoHbg0cLo4+wcMK71JhpYf/XfXJBhjDvehe8oo+Di0E9PJ9KTYO1Mjp0NFDKb9FQi+3dWIURdVKr
        EmjYzBi4tgSUfVvz8ndaGuAFsY02irEX5Et7pDslGVdUnIgcUzKIFKApOwUQtPjeQYmS25C+BZPJd
        Mxk3KwE1i5I+dcnCksa1cpOyXnLi0Y6ve9y/kQyWaJd9B2ODWGM2IwBkC9h/Cew0TFfvatych1ed0
        Z5Bf0NEg==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTA1Y-00019J-QF; Mon, 27 Apr 2020 20:06:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] binfmt_elf_fdpic: remove the set_fs(KERNEL_DS) in elf_fdpic_core_dump
Date:   Mon, 27 Apr 2020 22:06:25 +0200
Message-Id: <20200427200626.1622060-6-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200427200626.1622060-1-hch@lst.de>
References: <20200427200626.1622060-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no logic in elf_fdpic_core_dump itself or in the various arch
helpers called from it which use uaccess routines on kernel pointers
except for the file writes thate are nicely encapsulated by using
__kernel_write in dump_emit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/binfmt_elf_fdpic.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 240f666635437..c62c17a5c34a9 100644
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
2.26.1

