Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9311C52C0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 12:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgEEKNl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 06:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728672AbgEEKNb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 06:13:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F85C061A10;
        Tue,  5 May 2020 03:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=pf+8UbD/8jsz87XgA7eBkoAI8lHWNvd/TrPDgE8g/Q8=; b=T5S+O90V8jpK1jZDT4Xxt2bEyq
        vNENKGjTiapnYjdG+K+97VkW5vlrUBUMBrFYjM0CMTbcepQtRLcsfp+IEyEOCd2PuvKyeAiOIchRw
        oz5akyY7rTAXJOXrp5gSEO0kYh70TTzn1a1PeT3/yZkafIsSqgOAh7NJa8qAcNWNj4lt+jfPIBfQr
        35EzNTljJDykJnsLc50D1RB0lmLhFGnwsrp8Dl2CqiLvv2woKfnVoPuOvRoJw/eOkXMhFqInMtaUw
        v1WjxeIsQD3j9MDW0PouPbgRi0aop/eiOL0wEdpg1hJmBr9TEWZpmQutpYxq6KhMWLTj6bfuYwfwb
        TWIDtd4g==;
Received: from [2001:4bb8:191:66b6:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVuZi-0006wy-Kb; Tue, 05 May 2020 10:13:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] binfmt_elf_fdpic: remove the set_fs(KERNEL_DS) in elf_fdpic_core_dump
Date:   Tue,  5 May 2020 12:12:56 +0200
Message-Id: <20200505101256.3121270-8-hch@lst.de>
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

There is no logic in elf_fdpic_core_dump itself or in the various arch
helpers called from it which use uaccess routines on kernel pointers
except for the file writes thate are nicely encapsulated by using
__kernel_write in dump_emit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/binfmt_elf_fdpic.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 240f666635437..d9501a86cec97 100644
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
@@ -1589,31 +1588,31 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	/* alloc memory for large data structures: too large to be on stack */
 	elf = kmalloc(sizeof(*elf), GFP_KERNEL);
 	if (!elf)
-		goto cleanup;
+		goto end_coredump;
 	prstatus = kzalloc(sizeof(*prstatus), GFP_KERNEL);
 	if (!prstatus)
-		goto cleanup;
+		goto end_coredump;
 	psinfo = kmalloc(sizeof(*psinfo), GFP_KERNEL);
 	if (!psinfo)
-		goto cleanup;
+		goto end_coredump;
 	notes = kmalloc_array(NUM_NOTES, sizeof(struct memelfnote),
 			      GFP_KERNEL);
 	if (!notes)
-		goto cleanup;
+		goto end_coredump;
 	fpu = kmalloc(sizeof(*fpu), GFP_KERNEL);
 	if (!fpu)
-		goto cleanup;
+		goto end_coredump;
 #ifdef ELF_CORE_COPY_XFPREGS
 	xfpu = kmalloc(sizeof(*xfpu), GFP_KERNEL);
 	if (!xfpu)
-		goto cleanup;
+		goto end_coredump;
 #endif
 
 	for (ct = current->mm->core_state->dumper.next;
 					ct; ct = ct->next) {
 		tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
 		if (!tmp)
-			goto cleanup;
+			goto end_coredump;
 
 		tmp->thread = ct->task;
 		list_add(&tmp->list, &thread_list);
@@ -1678,9 +1677,6 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 			  "LINUX", ELF_CORE_XFPREG_TYPE, sizeof(*xfpu), xfpu);
 #endif
 
-	fs = get_fs();
-	set_fs(KERNEL_DS);
-
 	offset += sizeof(*elf);				/* Elf header */
 	offset += segs * sizeof(struct elf_phdr);	/* Program headers */
 
@@ -1788,9 +1784,6 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	}
 
 end_coredump:
-	set_fs(fs);
-
-cleanup:
 	while (!list_empty(&thread_list)) {
 		struct list_head *tmp = thread_list.next;
 		list_del(tmp);
-- 
2.26.2

