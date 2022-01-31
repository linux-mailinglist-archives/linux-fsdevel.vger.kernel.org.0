Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825074A4AB9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 16:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379726AbiAaPiK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 10:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379378AbiAaPiJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:38:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF7CC061714;
        Mon, 31 Jan 2022 07:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=UfqBL4TG7ayNTZqiM/UFFRcaqGRyJgYgZDocc/keuXE=; b=pdxY7lVkV8i5XKsTRwTPih2xVR
        hObQ4k8GZnvA9aH9H3Pn+0RqHhyKh6DAceJsmQjgJ2GVLbxoIbS70X6CS92wecZCbQ4sVKusW4TvU
        XBVZy9hIY5BWrPKNM06g5FZLjrA1KDwOnik4QohwjI0ZJQdG4paX29rMbX2CIP0ObGzJlkRxDj1Km
        JH7C/ZdArHnrdpKMD2+Sl+S9BuPgWTnEr6GDl7v2nQTM8Fc7o6rev3eyjDflH92ACCi89hVVlepu4
        rigJgTP5Qax+B3//Dykv+R1Kcwud292QXpIQY14glJkQzjb/7ursNJmLZZADVepxSd0yu4rw5EyC9
        gseOXp3Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEYkl-00A3gb-I7; Mon, 31 Jan 2022 15:38:03 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Denys Vlasenko <vda.linux@googlemail.com>,
        Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH] binfmt_elf: Take the mmap lock when walking the VMA list
Date:   Mon, 31 Jan 2022 15:37:40 +0000
Message-Id: <20220131153740.2396974-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'm not sure if the VMA list can change under us, but dump_vma_snapshot()
is very careful to take the mmap_lock in write mode.  We only need to
take it in read mode here as we do not care if the size of the stack
VMA changes underneath us.

If it can be changed underneath us, this is a potential use-after-free
for a multithreaded process which is dumping core.

Fixes: 2aa362c49c31 ("coredump: extend core dump note section to contain file names of mapped files")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/binfmt_elf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 605017eb9349..dc2318355762 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1651,6 +1651,7 @@ static int fill_files_note(struct memelfnote *note)
 	name_base = name_curpos = ((char *)data) + names_ofs;
 	remaining = size - names_ofs;
 	count = 0;
+	mmap_read_lock(mm);
 	for (vma = mm->mmap; vma != NULL; vma = vma->vm_next) {
 		struct file *file;
 		const char *filename;
@@ -1661,6 +1662,7 @@ static int fill_files_note(struct memelfnote *note)
 		filename = file_path(file, name_curpos, remaining);
 		if (IS_ERR(filename)) {
 			if (PTR_ERR(filename) == -ENAMETOOLONG) {
+				mmap_read_unlock(mm);
 				kvfree(data);
 				size = size * 5 / 4;
 				goto alloc;
@@ -1680,6 +1682,7 @@ static int fill_files_note(struct memelfnote *note)
 		*start_end_ofs++ = vma->vm_pgoff;
 		count++;
 	}
+	mmap_read_unlock(mm);
 
 	/* Now we know exact count of files, can store it */
 	data[0] = count;
-- 
2.34.1

