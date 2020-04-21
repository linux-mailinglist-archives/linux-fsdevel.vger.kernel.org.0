Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3E71B2B76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 17:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgDUPmy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 11:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725994AbgDUPm0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:42:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6BBC061BD3;
        Tue, 21 Apr 2020 08:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=YqMqPP1bOJuWh6c5f5C8pIdJ2QOwE49mdXnpeXx3pPw=; b=Ablbdcopf5wKVWPixh/dTU//dL
        L92coUpHhBLLLbeitIb+DO1MQ5AGRCdKR9Ldgqdj3+vxyEfr6I6FRgneJ4nx4aozlUxKcR2pN7H5I
        In37t0a19ykta1JWUROQY+KHZnuMIARQah2kibWbIoYj4/na6zTtSIh9zkgtMfSHnmOTI4jT7WbER
        khZKrfmNMER8Dl343KxNE87vpCMrOxDjmMYTg8x3bR3k7qe3ivGqRrKuad1He+X4LiW42bHTO3KPv
        mYsmlvP2CKnBC0rJcWGRTnL8GVNoHUJl7WTV8yF5PlLI5wc7Z+Y0snq03c2EApeKKqck2vvUUP2Gt
        CfzjJf+A==;
Received: from [2001:4bb8:191:e12c:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQv2Q-0007rY-0D; Tue, 21 Apr 2020 15:42:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] binfmt_elf: remove the set_fs(KERNEL_DS) in elf_core_dump
Date:   Tue, 21 Apr 2020 17:42:01 +0200
Message-Id: <20200421154204.252921-5-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200421154204.252921-1-hch@lst.de>
References: <20200421154204.252921-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no logic in elf_core_dump itself, or in the various arch helpers
called from it which use uaccess routines on kernel pointers except for
the file writes thate are nicely encapsulated by using __kernel_write in
dump_emit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/binfmt_elf.c | 40 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index a1f57e20c3cf..b29b84595b09 100644
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
@@ -2236,9 +2228,6 @@ static int elf_core_dump(struct coredump_params *cprm)
 
 	has_dumped = 1;
 
-	fs = get_fs();
-	set_fs(KERNEL_DS);
-
 	offset += sizeof(elf);				/* Elf header */
 	offset += segs * sizeof(struct elf_phdr);	/* Program headers */
 
@@ -2250,7 +2239,7 @@ static int elf_core_dump(struct coredump_params *cprm)
 
 		phdr4note = kmalloc(sizeof(*phdr4note), GFP_KERNEL);
 		if (!phdr4note)
-			goto end_coredump;
+			goto cleanup;
 
 		fill_elf_note_phdr(phdr4note, sz, offset);
 		offset += sz;
@@ -2265,7 +2254,7 @@ static int elf_core_dump(struct coredump_params *cprm)
 	vma_filesz = kvmalloc(array_size(sizeof(*vma_filesz), (segs - 1)),
 			      GFP_KERNEL);
 	if (!vma_filesz)
-		goto end_coredump;
+		goto cleanup;
 
 	for (i = 0, vma = first_vma(current, gate_vma); vma != NULL;
 			vma = next_vma(vma, gate_vma)) {
@@ -2283,17 +2272,17 @@ static int elf_core_dump(struct coredump_params *cprm)
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
@@ -2315,22 +2304,22 @@ static int elf_core_dump(struct coredump_params *cprm)
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
@@ -2352,22 +2341,19 @@ static int elf_core_dump(struct coredump_params *cprm)
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
2.26.1

