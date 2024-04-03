Return-Path: <linux-fsdevel+bounces-15986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0490B89668F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 09:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85FDD287ABA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 07:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAD978B63;
	Wed,  3 Apr 2024 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="U9x8ao/Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7808C757E8;
	Wed,  3 Apr 2024 07:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129605; cv=none; b=mBxl27Ytuozr8B1CoFh/QI57X2ZsIOWIf2d9swhLiM8brrFds0nF3VpvxLTrBqEK780yDaWRfvsb7rPzjrB4mPyx2tQVNcxVXTMwRyg4fMb7bKgQQIXAH25F4/UtkzfuMjbSt0w2to1ZuINH1xxH47Do8WklTxrOCprJwbdAQDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129605; c=relaxed/simple;
	bh=OPpE9eN8CD5ANdNxUZDWvEkQM4rXnf4BVN57cpWu324=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KALmm92mqRrf8D4omxg+IEfzbxNHNkPxDvmgUIUcSuV6hQFFodBkIYI7Tj4ZH6VFz2/NI2cMw1igh3Nykb0XCyX0gVVJVqGzC0Flp71cjiLy+cFJYNIUFHkmuQxM2227SS1Vqdt2xvKVFEjpjq3A6E3ImoYHyuJYXprQrsl3u8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=U9x8ao/Y; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id A63518083E;
	Wed,  3 Apr 2024 03:33:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1712129603; bh=OPpE9eN8CD5ANdNxUZDWvEkQM4rXnf4BVN57cpWu324=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=U9x8ao/YtXeIP6vqNHdNGYgKj+yXOk1vCiXgPT1yActpXGHe++Cr6YI8vvggHRBq6
	 yQEPr3sMnm2kFzTH1ieN/TMe77oodEDsf67NWszgd9UtORzWsZJSpA8/rHVAR+Vp/k
	 kSy507v6yuJWP9ELUOt8WkY/1ccbX2arnapapc48dOzST9mkwFMNkApXmXBsrlTJpU
	 r8clqmo9BKvDy4PEY//3I3P1NQc9gF8QtGRC3alOIUoJOicylNVMZ/7KIPNo5srPrx
	 6ht8RdqQE+ef8OZayxffgmoiCnjb1fa4WZpT69KzEyzHxEgLWebS5z8bReBLyq1zg9
	 1YgF3ZuwkD2Eg==
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To: Jonathan Corbet <corbet@lwn.net>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 08/13] f2fs: fiemap: add physical length to trace_f2fs_fiemap
Date: Wed,  3 Apr 2024 03:22:49 -0400
Message-ID: <c24fc95fa184fdd799d9d3d32b3227f790ba772f.1712126039.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1712126039.git.sweettea-kernel@dorminy.me>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/f2fs/data.c              |  6 +++---
 fs/f2fs/inline.c            |  2 +-
 include/trace/events/f2fs.h | 10 +++++++---
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 87f8d828e038..34af1673461b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1836,7 +1836,7 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 
 		err = fiemap_fill_next_extent(
 				fieinfo, 0, phys, len, 0, flags);
-		trace_f2fs_fiemap(inode, 0, phys, len, flags, err);
+		trace_f2fs_fiemap(inode, 0, phys, len, 0, flags, err);
 		if (err)
 			return err;
 	}
@@ -1863,7 +1863,7 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 	if (phys) {
 		err = fiemap_fill_next_extent(
 				fieinfo, 0, phys, len, 0, flags);
-		trace_f2fs_fiemap(inode, 0, phys, len, flags, err);
+		trace_f2fs_fiemap(inode, 0, phys, len, 0, flags, err);
 	}
 
 	return (err < 0 ? err : 0);
@@ -1982,7 +1982,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 
 		ret = fiemap_fill_next_extent(fieinfo, logical,
 				phys, size, 0, flags);
-		trace_f2fs_fiemap(inode, logical, phys, size, flags, ret);
+		trace_f2fs_fiemap(inode, logical, phys, size, 0, flags, ret);
 		if (ret)
 			goto out;
 		size = 0;
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 49d2f87fe048..235b0d72f6fc 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -808,7 +808,7 @@ int f2fs_inline_data_fiemap(struct inode *inode,
 					(char *)F2FS_INODE(ipage);
 	err = fiemap_fill_next_extent(
 			fieinfo, start, byteaddr, ilen, 0, flags);
-	trace_f2fs_fiemap(inode, start, byteaddr, ilen, flags, err);
+	trace_f2fs_fiemap(inode, start, byteaddr, ilen, 0, flags, err);
 out:
 	f2fs_put_page(ipage, 1);
 	return err;
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 7ed0fc430dc6..63706eb3a5db 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -2276,9 +2276,10 @@ TRACE_EVENT(f2fs_bmap,
 TRACE_EVENT(f2fs_fiemap,
 
 	TP_PROTO(struct inode *inode, sector_t lblock, sector_t pblock,
-		unsigned long long len, unsigned int flags, int ret),
+		unsigned long long len, unsigned long long phys_len,
+		unsigned int flags, int ret),
 
-	TP_ARGS(inode, lblock, pblock, len, flags, ret),
+	TP_ARGS(inode, lblock, pblock, len, phys_len, flags, ret),
 
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
@@ -2286,6 +2287,7 @@ TRACE_EVENT(f2fs_fiemap,
 		__field(sector_t, lblock)
 		__field(sector_t, pblock)
 		__field(unsigned long long, len)
+		__field(unsigned long long, phys_len)
 		__field(unsigned int, flags)
 		__field(int, ret)
 	),
@@ -2296,16 +2298,18 @@ TRACE_EVENT(f2fs_fiemap,
 		__entry->lblock		= lblock;
 		__entry->pblock		= pblock;
 		__entry->len		= len;
+		__entry->phys_len	= phys_len;
 		__entry->flags		= flags;
 		__entry->ret		= ret;
 	),
 
 	TP_printk("dev = (%d,%d), ino = %lu, lblock:%lld, pblock:%lld, "
-		"len:%llu, flags:%u, ret:%d",
+		"len:%llu, plen:%llu, flags:%u, ret:%d",
 		show_dev_ino(__entry),
 		(unsigned long long)__entry->lblock,
 		(unsigned long long)__entry->pblock,
 		__entry->len,
+		__entry->phys_len,
 		__entry->flags,
 		__entry->ret)
 );
-- 
2.43.0


