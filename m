Return-Path: <linux-fsdevel+bounces-34129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4749C2921
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 02:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DA2F1F22FF0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 01:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5485A4C1;
	Sat,  9 Nov 2024 01:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="KT3cFvwj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96F2288B5
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Nov 2024 01:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731115739; cv=none; b=Lwa0JUOWjtQU6e7xFPXOrd9P2pfMNjxTBXw3AStvn+TGe4cuzeDiYIzFR/1Hg+1N1gkeRiOCXw9GosdwKb6K0Y+jpHrCB0T2sg8ssyb3EfeS8tNlxoOxrL6Aihn36hl2WnlKXg796uticqttflD/9M/rVrnFKwLwAM9M72Qweq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731115739; c=relaxed/simple;
	bh=XrcsrSAOKXBBBQwVA9Tuimkn9w8T10KOuIdPu7i4L1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISxepNemx3cnVHOxMEwzm5lY2WgaIZnj0FrhVxjiPI66UzJCcxsI5T99608dolLCU7oAXlHilhbfTpnbcFjGly1dfjiv50Ma4pNJB/7IKpdpDcjZGZLZQVvd/P/pDhzLVHOu7TVmqsxzFE5dQodGX6nU8nmFXoX7MbuX33l0f5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=KT3cFvwj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c78a10eb3so8125ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 17:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1731115737; x=1731720537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsQOXM5eEzPefp4DDDW0FE1HiiPiLYyB+AE/vJxP/T4=;
        b=KT3cFvwjStx4TIdQ7YP5oRlY8JjUadpER7nSGZOhd8xcEWdi+KCCgxGgtCUWNXiogP
         vj2ryIqJKmjJQcyf2Ks6+Ya8DHNpkA0YBn44VDVoGfjRqykpLM/C6eQ01387nAA4xcNu
         wKGTWx2+BW7KrxKv7l0ZSwKedHfqWzAPafhmtItm9PaR+itNgXaBYjN9vSPCDyqHFhWU
         SIXCLcBYCTiD8A3gtHp7iL9zijbxGZVD9cnIhAxFF8ueU+Xv4/B1XNi+UR3ndFF7qL2D
         uYcDkyg5aHaKBgMpu0KE3YLjHwht5TUo4toLbL8pyvGaa0k4FVf/ss0xFrlvDpPKibly
         hJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731115737; x=1731720537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsQOXM5eEzPefp4DDDW0FE1HiiPiLYyB+AE/vJxP/T4=;
        b=nR85Tq17Yu97mY/Sabg5qgUn8kgZGUS0/cqjVzioAIUnqDBp6b+U8cBp8NdZBkdbH2
         2+GrfDSHjWCPjHmnMqh4rZ8XBzrzck/O3fvDjgEcnt2swRWbAxYfj93FwbNYUpyb86Oe
         Kkjxf4QzdqFbOXgXkhWS59U8fLG43vlnE8xhl+UTO8d9NDmx6qVZdJ5y0seVi5q5a38B
         /czz52zHodDRMaR25TglEWZ6jjeiF8c8DDdsL/l/CvqlL09H8S7fjeTQyqrLvW8XYWUI
         MTxToJdUxa+RvTVRAZ7WnbKH5bjAAkIOUASjFAbmKuP2pCqKtcucHPA1Z3Scy0BY4zn+
         zM7g==
X-Gm-Message-State: AOJu0Yz1JieGSAugjZxIjPn7d/THKOFULot7zC7daaaF8/n/j4jTeDH7
	1UhWVw2FzYXSVzBqw10yUC0Bz4xBU5Egxe44vba6u+2mw2Xp96mslSct5RGAd7rrsdurzg/X1Od
	E
X-Google-Smtp-Source: AGHT+IEMcxzKuKijFu4ssmt1kgbjUcwDcCVAU1kIvePW6gaP9G0DE3o/yXMPTKHGS67Lr03Hm8FB/A==
X-Received: by 2002:a17:902:ecd0:b0:20c:ee32:7595 with SMTP id d9443c01a7336-211834de6d9mr27903515ad.2.1731115736792;
        Fri, 08 Nov 2024 17:28:56 -0800 (PST)
Received: from telecaster.hsd1.wa.comcast.net ([2601:602:8980:9170::5633])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6c96fsm37493355ad.255.2024.11.08.17.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 17:28:55 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: kernel-team@fb.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] proc/kcore: don't walk list on every read
Date: Fri,  8 Nov 2024 17:28:40 -0800
Message-ID: <8d945558b9c9efe74103a34b7780f1cd90d9ce7f.1731115587.git.osandov@fb.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731115587.git.osandov@fb.com>
References: <cover.1731115587.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

We maintain a list of memory ranges for /proc/kcore, which usually has
10-20 entries. Currently, every single read from /proc/kcore walks the
entire list in order to count the number of entries and compute some
offsets. These values only change when the list of memory ranges
changes, which is very rare (only when memory is hot(un)plugged). We can
cache the values when the list is populated to avoid these redundant
walks.

In my benchmark, this reduces the time per read by another 20
nanoseconds on top of the previous change, from 215 nanoseconds per read
to 195.

Link: https://github.com/osandov/drgn/issues/106
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/proc/kcore.c | 70 ++++++++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 770e4e57f445..082718f5c02f 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -65,6 +65,10 @@ static inline void kc_unxlate_dev_mem_ptr(phys_addr_t phys, void *virt)
 #endif
 
 static LIST_HEAD(kclist_head);
+static int kcore_nphdr;
+static size_t kcore_phdrs_len;
+static size_t kcore_notes_len;
+static size_t kcore_data_offset;
 static DECLARE_RWSEM(kclist_lock);
 static int kcore_need_update = 1;
 
@@ -101,33 +105,32 @@ void __init kclist_add(struct kcore_list *new, void *addr, size_t size,
 	list_add_tail(&new->list, &kclist_head);
 }
 
-static size_t get_kcore_size(int *nphdr, size_t *phdrs_len, size_t *notes_len,
-			     size_t *data_offset)
+static void update_kcore_size(void)
 {
 	size_t try, size;
 	struct kcore_list *m;
 
-	*nphdr = 1; /* PT_NOTE */
+	kcore_nphdr = 1; /* PT_NOTE */
 	size = 0;
 
 	list_for_each_entry(m, &kclist_head, list) {
 		try = kc_vaddr_to_offset((size_t)m->addr + m->size);
 		if (try > size)
 			size = try;
-		*nphdr = *nphdr + 1;
+		kcore_nphdr++;
 	}
 
-	*phdrs_len = *nphdr * sizeof(struct elf_phdr);
-	*notes_len = (4 * sizeof(struct elf_note) +
-		      3 * ALIGN(sizeof(CORE_STR), 4) +
-		      VMCOREINFO_NOTE_NAME_BYTES +
-		      ALIGN(sizeof(struct elf_prstatus), 4) +
-		      ALIGN(sizeof(struct elf_prpsinfo), 4) +
-		      ALIGN(arch_task_struct_size, 4) +
-		      ALIGN(vmcoreinfo_size, 4));
-	*data_offset = PAGE_ALIGN(sizeof(struct elfhdr) + *phdrs_len +
-				  *notes_len);
-	return *data_offset + size;
+	kcore_phdrs_len = kcore_nphdr * sizeof(struct elf_phdr);
+	kcore_notes_len = (4 * sizeof(struct elf_note) +
+			   3 * ALIGN(sizeof(CORE_STR), 4) +
+			   VMCOREINFO_NOTE_NAME_BYTES +
+			   ALIGN(sizeof(struct elf_prstatus), 4) +
+			   ALIGN(sizeof(struct elf_prpsinfo), 4) +
+			   ALIGN(arch_task_struct_size, 4) +
+			   ALIGN(vmcoreinfo_size, 4));
+	kcore_data_offset = PAGE_ALIGN(sizeof(struct elfhdr) + kcore_phdrs_len +
+				       kcore_notes_len);
+	proc_root_kcore->size = kcore_data_offset + size;
 }
 
 #ifdef CONFIG_HIGHMEM
@@ -270,8 +273,6 @@ static int kcore_update_ram(void)
 {
 	LIST_HEAD(list);
 	LIST_HEAD(garbage);
-	int nphdr;
-	size_t phdrs_len, notes_len, data_offset;
 	struct kcore_list *tmp, *pos;
 	int ret = 0;
 
@@ -293,8 +294,7 @@ static int kcore_update_ram(void)
 	}
 	list_splice_tail(&list, &kclist_head);
 
-	proc_root_kcore->size = get_kcore_size(&nphdr, &phdrs_len, &notes_len,
-					       &data_offset);
+	update_kcore_size();
 
 out:
 	up_write(&kclist_lock);
@@ -326,12 +326,10 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 	struct file *file = iocb->ki_filp;
 	char *buf = file->private_data;
 	loff_t *fpos = &iocb->ki_pos;
-	size_t phdrs_offset, notes_offset, data_offset;
+	size_t phdrs_offset, notes_offset;
 	size_t page_offline_frozen = 1;
-	size_t phdrs_len, notes_len;
 	struct kcore_list *m;
 	size_t tsz;
-	int nphdr;
 	unsigned long start;
 	size_t buflen = iov_iter_count(iter);
 	size_t orig_buflen = buflen;
@@ -344,9 +342,8 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 	 */
 	page_offline_freeze();
 
-	get_kcore_size(&nphdr, &phdrs_len, &notes_len, &data_offset);
 	phdrs_offset = sizeof(struct elfhdr);
-	notes_offset = phdrs_offset + phdrs_len;
+	notes_offset = phdrs_offset + kcore_phdrs_len;
 
 	/* ELF file header. */
 	if (buflen && *fpos < sizeof(struct elfhdr)) {
@@ -368,7 +365,7 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 			.e_flags = ELF_CORE_EFLAGS,
 			.e_ehsize = sizeof(struct elfhdr),
 			.e_phentsize = sizeof(struct elf_phdr),
-			.e_phnum = nphdr,
+			.e_phnum = kcore_nphdr,
 		};
 
 		tsz = min_t(size_t, buflen, sizeof(struct elfhdr) - *fpos);
@@ -382,10 +379,10 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 	}
 
 	/* ELF program headers. */
-	if (buflen && *fpos < phdrs_offset + phdrs_len) {
+	if (buflen && *fpos < phdrs_offset + kcore_phdrs_len) {
 		struct elf_phdr *phdrs, *phdr;
 
-		phdrs = kzalloc(phdrs_len, GFP_KERNEL);
+		phdrs = kzalloc(kcore_phdrs_len, GFP_KERNEL);
 		if (!phdrs) {
 			ret = -ENOMEM;
 			goto out;
@@ -393,13 +390,14 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 		phdrs[0].p_type = PT_NOTE;
 		phdrs[0].p_offset = notes_offset;
-		phdrs[0].p_filesz = notes_len;
+		phdrs[0].p_filesz = kcore_notes_len;
 
 		phdr = &phdrs[1];
 		list_for_each_entry(m, &kclist_head, list) {
 			phdr->p_type = PT_LOAD;
 			phdr->p_flags = PF_R | PF_W | PF_X;
-			phdr->p_offset = kc_vaddr_to_offset(m->addr) + data_offset;
+			phdr->p_offset = kc_vaddr_to_offset(m->addr)
+					 + kcore_data_offset;
 			phdr->p_vaddr = (size_t)m->addr;
 			if (m->type == KCORE_RAM)
 				phdr->p_paddr = __pa(m->addr);
@@ -412,7 +410,8 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 			phdr++;
 		}
 
-		tsz = min_t(size_t, buflen, phdrs_offset + phdrs_len - *fpos);
+		tsz = min_t(size_t, buflen,
+			    phdrs_offset + kcore_phdrs_len - *fpos);
 		if (copy_to_iter((char *)phdrs + *fpos - phdrs_offset, tsz,
 				 iter) != tsz) {
 			kfree(phdrs);
@@ -426,7 +425,7 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 	}
 
 	/* ELF note segment. */
-	if (buflen && *fpos < notes_offset + notes_len) {
+	if (buflen && *fpos < notes_offset + kcore_notes_len) {
 		struct elf_prstatus prstatus = {};
 		struct elf_prpsinfo prpsinfo = {
 			.pr_sname = 'R',
@@ -438,7 +437,7 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 		strscpy(prpsinfo.pr_psargs, saved_command_line,
 			sizeof(prpsinfo.pr_psargs));
 
-		notes = kzalloc(notes_len, GFP_KERNEL);
+		notes = kzalloc(kcore_notes_len, GFP_KERNEL);
 		if (!notes) {
 			ret = -ENOMEM;
 			goto out;
@@ -459,9 +458,10 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 		 */
 		append_kcore_note(notes, &i, VMCOREINFO_NOTE_NAME, 0,
 				  vmcoreinfo_data,
-				  min(vmcoreinfo_size, notes_len - i));
+				  min(vmcoreinfo_size, kcore_notes_len - i));
 
-		tsz = min_t(size_t, buflen, notes_offset + notes_len - *fpos);
+		tsz = min_t(size_t, buflen,
+			    notes_offset + kcore_notes_len - *fpos);
 		if (copy_to_iter(notes + *fpos - notes_offset, tsz, iter) != tsz) {
 			kfree(notes);
 			ret = -EFAULT;
@@ -477,7 +477,7 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 	 * Check to see if our file offset matches with any of
 	 * the addresses in the elf_phdr on our list.
 	 */
-	start = kc_offset_to_vaddr(*fpos - data_offset);
+	start = kc_offset_to_vaddr(*fpos - kcore_data_offset);
 	if ((tsz = (PAGE_SIZE - (start & ~PAGE_MASK))) > buflen)
 		tsz = buflen;
 
-- 
2.47.0


