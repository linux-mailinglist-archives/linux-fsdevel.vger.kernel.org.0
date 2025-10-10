Return-Path: <linux-fsdevel+bounces-63817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF27CBCEAC4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 00:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C2BB4F6562
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 22:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9A126B75B;
	Fri, 10 Oct 2025 22:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abXBkQkP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE9426CE0C
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 22:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760134109; cv=none; b=csNHzEirRta/KHxVjxan+Xv6zr3YyG9h3eeO069gZW5uq6ddzb+BdCqIm+xvFqgSG6LztHsnUbE46cL4pB4vgGUbDNrSzDGJ3yhtCGhhQbT/+vADJbUMk5sGjpbV53RBst6i+w43slK2r612KRmobzwj+rFZ97l0f2Dx/xLIzew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760134109; c=relaxed/simple;
	bh=Byb40PNzIM16B+ka0/oTWAt1pJki0ilc62do2H/m3p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYK+JrCcdbxzpAym6LIXX4N7em3sAPiWTboJm9Ql6TPBx6iAYPZh1sl6Gzg5dj6G5gikZhlgt0Nz2FCUaBMuBlui8tr6scyf6STOirftWeGXpHy9NDWWDDXrQIAUdfJzUlr+57k6xO8gcsspyQ8Xxu0mDcYmDpRE/tRHnTbEDG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abXBkQkP; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b62fcddfa21so1584926a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 15:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760134107; x=1760738907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3ghXW+owxj/7tyVLNLa7MqSxuYXRJwnK1KuHi/Rs3I=;
        b=abXBkQkPjxdh2vgPbshoKI41Uh8rlqTrlPRFprW6UM4zf9TisTuyrHMYN61FVqVYBc
         Zxwcfj8MgY3wZ0Uwbu/BCtuzxJAyxu5o4o0qilFRVcrPXKHE8esqnzS0dpDcwfAG39yz
         JpcMUHSEKbxmIaSabVvT8IKGripCE/mgLkVjBzHzAcwitZwBLARph9OH86O3geoDJKU1
         UyrZOhT5OW7uQnWa2lu1fty59cdO906uiTIHdbDijh0QWu0xSAH6h/Oob/1mAIAXe/LM
         fP4L8QR3omiahqZsUoD2fkmzO2RIVcfA73nCsKZ2HOd6qlu3U0VukDt2tb387Ou+A45l
         tQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760134107; x=1760738907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3ghXW+owxj/7tyVLNLa7MqSxuYXRJwnK1KuHi/Rs3I=;
        b=KjYUdlgW0qc/sV6h0kdDIqYRwgsLBgMgF1Ypi4nNu4h2UJN1trm80I9qBBhzRGgOCX
         aJLsgymHPpWn/zaxug/agSFPf3WhqJ+J/hdUtEqay/dJz0WY2YPGignwVEjMqriz8n1t
         BxNSwNg8So/71RWJKQL6w0jad9otZ+Giz4mARk4mlYgpXz3khJOZE3vyIzD6vXONmqYD
         RmCp/NClPJ1HsyoOnrn+qGabI9fit/vkIPKp/aVbPrAxKl6pPxa9ZfmHvaiRgWz/mpXd
         /xyDkN/pmPnQ9/JXr1iKsjzbW1dDxOgYWLspOLV6ew+EHLRMuBYIWWaKelPn2vWqLOpd
         rH1g==
X-Gm-Message-State: AOJu0YwetDzwZ3U+jdQ50rTNHbnZbU8jZOAwBh5QrlvP3G+NYUTuXr2O
	06QELM32U23784E7KbtHycRBlUZ3FfrBepuFtmv0lmNnEU3Fq7fJ2SsK
X-Gm-Gg: ASbGnculTcQEwAqvgESWaXJJwJOxb/XPGBTqkjlyU2CdCrc2Wbu8sBZvqSoWiOElORV
	QW9vTY9A1pj75l452gUpNivmiDKVRVMOoQQJXvQFZbJQxxlCWWUHnWO3yqClmlvoXwlvDT7NX3n
	TDfHNBWMKYbdLRUkcVsXkbnUiUo/4M1NC0/4D01rG9k4NKwz1QYtYw63MRei+fCL4ACjZ8rz5Pt
	m8uxUxePww+NEgMLwBUAIKKJ9bUNkSfKPrpG0LvxZ7aHaWQ9+5AqU9QcTWOX9i+fSitkw4jZC+F
	d6wHwBQJwjox8swJrwPHQyoZRVtjBHJNjJxW0oqqStff4lhwJuF82GXw/UDSzd/+JfbmSgijG0a
	0MttXkzLScda23uJcCWD0m25pSORJAIKfiX5oI4CDm777U6YfMuOJQjtcVNzt4zVdLkg=
X-Google-Smtp-Source: AGHT+IH6VtAl9Ey2i8kXWGhqLfrhQea7Yr+wCgX3YAw4h2wd4EB2TzMXg/ebaH5bbOxQF3W3gzafMQ==
X-Received: by 2002:a17:903:252:b0:267:a231:34d0 with SMTP id d9443c01a7336-290272e3d1fmr156355205ad.42.1760134107145;
        Fri, 10 Oct 2025 15:08:27 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de6c70sm66736815ad.13.2025.10.10.15.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 15:08:26 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	osandov@fb.com,
	hsiangkao@linux.alibaba.com,
	kernel-team@meta.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/1] fuse: fix readahead reclaim deadlock
Date: Fri, 10 Oct 2025 15:07:38 -0700
Message-ID: <20251010220738.3674538-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251010220738.3674538-1-joannelkoong@gmail.com>
References: <20251010220738.3674538-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e26ee4efbc79 ("fuse: allocate ff->release_args only if release is
needed") skips allocating ff->release_args if the server does not
implement open. However in doing so, fuse_prepare_release() now skips
grabbing the reference on the inode, which makes it possible for an
inode to be evicted from the dcache while there are inflight readahead
requests. This causes a deadlock if the server triggers reclaim while
servicing the readahead request and reclaim attempts to evict the inode
of the file being read ahead. Since the folio is locked during
readahead, when reclaim evicts the fuse inode and fuse_evict_inode()
attempts to remove all folios associated with the inode from the page
cache (truncate_inode_pages_range()), reclaim will block forever waiting
for the lock since readahead cannot relinquish the lock because it is
itself blocked in reclaim:

>>> stack_trace(1504735)
 folio_wait_bit_common (mm/filemap.c:1308:4)
 folio_lock (./include/linux/pagemap.h:1052:3)
 truncate_inode_pages_range (mm/truncate.c:336:10)
 fuse_evict_inode (fs/fuse/inode.c:161:2)
 evict (fs/inode.c:704:3)
 dentry_unlink_inode (fs/dcache.c:412:3)
 __dentry_kill (fs/dcache.c:615:3)
 shrink_kill (fs/dcache.c:1060:12)
 shrink_dentry_list (fs/dcache.c:1087:3)
 prune_dcache_sb (fs/dcache.c:1168:2)
 super_cache_scan (fs/super.c:221:10)
 do_shrink_slab (mm/shrinker.c:435:9)
 shrink_slab (mm/shrinker.c:626:10)
 shrink_node (mm/vmscan.c:5951:2)
 shrink_zones (mm/vmscan.c:6195:3)
 do_try_to_free_pages (mm/vmscan.c:6257:3)
 do_swap_page (mm/memory.c:4136:11)
 handle_pte_fault (mm/memory.c:5562:10)
 handle_mm_fault (mm/memory.c:5870:9)
 do_user_addr_fault (arch/x86/mm/fault.c:1338:10)
 handle_page_fault (arch/x86/mm/fault.c:1481:3)
 exc_page_fault (arch/x86/mm/fault.c:1539:2)
 asm_exc_page_fault+0x22/0x27

Fix this deadlock by allocating ff->release_args and grabbing the
reference on the inode when preparing the file for release even if the
server does not implement open. The inode reference will be dropped when
the last reference on the fuse file is dropped (see fuse_file_put() ->
fuse_release_end()).

Fixes: e26ee4efbc79 ("fuse: allocate ff->release_args only if release is needed")
Cc: stable@vger.kernel.org
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reported-by: Omar Sandoval <osandov@fb.com>
---
 fs/fuse/file.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f1ef77a0be05..654e21ee93fb 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -100,7 +100,7 @@ static void fuse_release_end(struct fuse_mount *fm, struct fuse_args *args,
 	kfree(ra);
 }
 
-static void fuse_file_put(struct fuse_file *ff, bool sync)
+static void fuse_file_put(struct fuse_file *ff, bool sync, bool isdir)
 {
 	if (refcount_dec_and_test(&ff->count)) {
 		struct fuse_release_args *ra = &ff->args->release_args;
@@ -110,7 +110,9 @@ static void fuse_file_put(struct fuse_file *ff, bool sync)
 			fuse_file_io_release(ff, ra->inode);
 
 		if (!args) {
-			/* Do nothing when server does not implement 'open' */
+			/* Do nothing when server does not implement 'opendir' */
+		} else if (!isdir && ff->fm->fc->no_open) {
+			fuse_release_end(ff->fm, args, 0);
 		} else if (sync) {
 			fuse_simple_request(ff->fm, args);
 			fuse_release_end(ff->fm, args, 0);
@@ -131,8 +133,17 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 	struct fuse_file *ff;
 	int opcode = isdir ? FUSE_OPENDIR : FUSE_OPEN;
 	bool open = isdir ? !fc->no_opendir : !fc->no_open;
+	bool release = !isdir || open;
 
-	ff = fuse_file_alloc(fm, open);
+	/*
+	 * ff->args->release_args still needs to be allocated (so we can hold an
+	 * inode reference while there are pending inflight file operations when
+	 * ->release() is called, see fuse_prepare_release()) even if
+	 * fc->no_open is set else it becomes possible for reclaim to deadlock
+	 * if while servicing the readahead request the server triggers reclaim
+	 * and reclaim evicts the inode of the file being read ahead.
+	 */
+	ff = fuse_file_alloc(fm, release);
 	if (!ff)
 		return ERR_PTR(-ENOMEM);
 
@@ -152,13 +163,14 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 			fuse_file_free(ff);
 			return ERR_PTR(err);
 		} else {
-			/* No release needed */
-			kfree(ff->args);
-			ff->args = NULL;
-			if (isdir)
+			if (isdir) {
+				/* No release needed */
+				kfree(ff->args);
+				ff->args = NULL;
 				fc->no_opendir = 1;
-			else
+			} else {
 				fc->no_open = 1;
+			}
 		}
 	}
 
@@ -363,7 +375,7 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 	 * own ref to the file, the IO completion has to drop the ref, which is
 	 * how the fuse server can end up closing its clients' files.
 	 */
-	fuse_file_put(ff, false);
+	fuse_file_put(ff, false, isdir);
 }
 
 void fuse_release_common(struct file *file, bool isdir)
@@ -394,7 +406,7 @@ void fuse_sync_release(struct fuse_inode *fi, struct fuse_file *ff,
 {
 	WARN_ON(refcount_read(&ff->count) > 1);
 	fuse_prepare_release(fi, ff, flags, FUSE_RELEASE, true);
-	fuse_file_put(ff, true);
+	fuse_file_put(ff, true, false);
 }
 EXPORT_SYMBOL_GPL(fuse_sync_release);
 
@@ -891,7 +903,7 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 		folio_put(ap->folios[i]);
 	}
 	if (ia->ff)
-		fuse_file_put(ia->ff, false);
+		fuse_file_put(ia->ff, false, false);
 
 	fuse_io_free(ia);
 }
@@ -1815,7 +1827,7 @@ static void fuse_writepage_free(struct fuse_writepage_args *wpa)
 	if (wpa->bucket)
 		fuse_sync_bucket_dec(wpa->bucket);
 
-	fuse_file_put(wpa->ia.ff, false);
+	fuse_file_put(wpa->ia.ff, false, false);
 
 	kfree(ap->folios);
 	kfree(wpa);
@@ -1968,7 +1980,7 @@ int fuse_write_inode(struct inode *inode, struct writeback_control *wbc)
 	ff = __fuse_write_file_get(fi);
 	err = fuse_flush_times(inode, ff);
 	if (ff)
-		fuse_file_put(ff, false);
+		fuse_file_put(ff, false, false);
 
 	return err;
 }
@@ -2186,7 +2198,7 @@ static int fuse_iomap_writeback_submit(struct iomap_writepage_ctx *wpc,
 	}
 
 	if (data->ff)
-		fuse_file_put(data->ff, false);
+		fuse_file_put(data->ff, false, false);
 
 	return error;
 }
-- 
2.47.3


