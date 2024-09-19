Return-Path: <linux-fsdevel+bounces-29719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6447997CC05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 18:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 967621C21CA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 16:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CD01A072A;
	Thu, 19 Sep 2024 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhsKx4co"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6BD1A0713
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2024 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726762005; cv=none; b=CBYMoYSpcewbQTeMCVOyLVLy+MYEzUi1mplhR1T55LhR4JnDZXKs1MJ/D69lvJGFCuEfHKkcj74xbEAWX9NeLhRX51KPnybiIK6FfC83gQPVkfC71DXe3mnoeRPokEdhfK+r+cJWPQfqVYKQ7BALa2znLBavAxsAbAtlJ2OqF18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726762005; c=relaxed/simple;
	bh=XEM5F6kFyXLUxyf1vKeQmAjqgM1ZIZmRQvo3zZQoGGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dV4oXQLEDbXsUdgdj2/Fg2l+/N+VO3qWVbhG8g9ScX2nE24DTVYtNOyPnfnQevLEe1SFLdOv6jw3FJxfGE0FaNlbX1WG5ItN5t22y4V4fvH5gis/dGhU0adR30gN5RjGoSTyVlKkQFNUnQHzVRHJuFIRBCgKbLibV9NQxpeQ86E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QhsKx4co; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726762003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Iu9w4/pdlA/C4lnKYiprUYbbck6Hh3XVGFak1anZvk=;
	b=QhsKx4coGPHtWIZSW9Az6pmwCeMzRv11eUjhOfxie2/pdaGOIh3V76/PUiJ0N2WbmFUChf
	aa1ASODwdRpF2HeWunKcuBMrz1eUDgIaxcgHky9AdH8m6wJ11VwdF5DKNvOTWmGcT6pcQc
	8kPOplMcgJKvOtlCGiqu+ePG2yO0nfU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-FDbLKZuHMeKQ0c_FHjUlAQ-1; Thu,
 19 Sep 2024 12:06:36 -0400
X-MC-Unique: FDbLKZuHMeKQ0c_FHjUlAQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F69E1945118;
	Thu, 19 Sep 2024 16:06:35 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.9.175])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A0A019560A3;
	Thu, 19 Sep 2024 16:06:34 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-ext4@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	willy@infradead.org
Subject: [PATCH 1/2] ext4: partial zero eof block on unaligned inode size extension
Date: Thu, 19 Sep 2024 12:07:40 -0400
Message-ID: <20240919160741.208162-2-bfoster@redhat.com>
In-Reply-To: <20240919160741.208162-1-bfoster@redhat.com>
References: <20240919160741.208162-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Using mapped writes, it's technically possible to expose stale
post-eof data on a truncate up operation. Consider the following
example:

$ xfs_io -fc "pwrite 0 2k" -c "mmap 0 4k" -c "mwrite 2k 2k" \
	-c "truncate 8k" -c "pread -v 2k 16" <file>
...
00000800:  58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  XXXXXXXXXXXXXXXX
...

This shows that the post-eof data written via mwrite lands within
EOF after a truncate up. While this is deliberate of the test case,
behavior is somewhat unpredictable because writeback does post-eof
zeroing, and writeback can occur at any time in the background. For
example, an fsync inserted between the mwrite and truncate causes
the subsequent read to instead return zeroes. This basically means
that there is a race window in this situation between any subsequent
extending operation and writeback that dictates whether post-eof
data is exposed to the file or zeroed.

To prevent this problem, perform partial block zeroing as part of
the various inode size extending operations that are susceptible to
it. For truncate extension, zero around the original eof similar to
how truncate down does partial zeroing of the new eof. For extension
via writes and fallocate related operations, zero the newly exposed
range of the file to cover any partial zeroing that must occur at
the original and new eof blocks.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/ext4/extents.c |  7 ++++++-
 fs/ext4/inode.c   | 51 +++++++++++++++++++++++++++++++++--------------
 2 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index e067f2dd0335..d43a23abf148 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4457,7 +4457,7 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 	int depth = 0;
 	struct ext4_map_blocks map;
 	unsigned int credits;
-	loff_t epos;
+	loff_t epos, old_size = i_size_read(inode);
 
 	BUG_ON(!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS));
 	map.m_lblk = offset;
@@ -4516,6 +4516,11 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 			if (ext4_update_inode_size(inode, epos) & 0x1)
 				inode_set_mtime_to_ts(inode,
 						      inode_get_ctime(inode));
+			if (epos > old_size) {
+				pagecache_isize_extended(inode, old_size, epos);
+				ext4_zero_partial_blocks(handle, inode,
+						     old_size, epos - old_size);
+			}
 		}
 		ret2 = ext4_mark_inode_dirty(handle, inode);
 		ext4_update_inode_fsync_trans(handle, inode, 1);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 03374dc215d1..c8d5334cecca 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1327,8 +1327,10 @@ static int ext4_write_end(struct file *file,
 	folio_unlock(folio);
 	folio_put(folio);
 
-	if (old_size < pos && !verity)
+	if (old_size < pos && !verity) {
 		pagecache_isize_extended(inode, old_size, pos);
+		ext4_zero_partial_blocks(handle, inode, old_size, pos - old_size);
+	}
 	/*
 	 * Don't mark the inode dirty under folio lock. First, it unnecessarily
 	 * makes the holding time of folio lock longer. Second, it forces lock
@@ -1443,8 +1445,10 @@ static int ext4_journalled_write_end(struct file *file,
 	folio_unlock(folio);
 	folio_put(folio);
 
-	if (old_size < pos && !verity)
+	if (old_size < pos && !verity) {
 		pagecache_isize_extended(inode, old_size, pos);
+		ext4_zero_partial_blocks(handle, inode, old_size, pos - old_size);
+	}
 
 	if (size_changed) {
 		ret2 = ext4_mark_inode_dirty(handle, inode);
@@ -3015,7 +3019,8 @@ static int ext4_da_do_write_end(struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	loff_t old_size = inode->i_size;
 	bool disksize_changed = false;
-	loff_t new_i_size;
+	loff_t new_i_size, zero_len = 0;
+	handle_t *handle;
 
 	if (unlikely(!folio_buffers(folio))) {
 		folio_unlock(folio);
@@ -3059,18 +3064,21 @@ static int ext4_da_do_write_end(struct address_space *mapping,
 	folio_unlock(folio);
 	folio_put(folio);
 
-	if (old_size < pos)
+	if (pos > old_size) {
 		pagecache_isize_extended(inode, old_size, pos);
+		zero_len = pos - old_size;
+	}
 
-	if (disksize_changed) {
-		handle_t *handle;
+	if (!disksize_changed && !zero_len)
+		return copied;
 
-		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
-		if (IS_ERR(handle))
-			return PTR_ERR(handle);
-		ext4_mark_inode_dirty(handle, inode);
-		ext4_journal_stop(handle);
-	}
+	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+	if (zero_len)
+		ext4_zero_partial_blocks(handle, inode, old_size, zero_len);
+	ext4_mark_inode_dirty(handle, inode);
+	ext4_journal_stop(handle);
 
 	return copied;
 }
@@ -5453,6 +5461,14 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		}
 
 		if (attr->ia_size != inode->i_size) {
+			/* attach jbd2 jinode for EOF folio tail zeroing */
+			if (attr->ia_size & (inode->i_sb->s_blocksize - 1) ||
+			    oldsize & (inode->i_sb->s_blocksize - 1)) {
+				error = ext4_inode_attach_jinode(inode);
+				if (error)
+					goto err_out;
+			}
+
 			handle = ext4_journal_start(inode, EXT4_HT_INODE, 3);
 			if (IS_ERR(handle)) {
 				error = PTR_ERR(handle);
@@ -5463,12 +5479,17 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 				orphan = 1;
 			}
 			/*
-			 * Update c/mtime on truncate up, ext4_truncate() will
-			 * update c/mtime in shrink case below
+			 * Update c/mtime and tail zero the EOF folio on
+			 * truncate up. ext4_truncate() handles the shrink case
+			 * below.
 			 */
-			if (!shrink)
+			if (!shrink) {
 				inode_set_mtime_to_ts(inode,
 						      inode_set_ctime_current(inode));
+				if (oldsize & (inode->i_sb->s_blocksize - 1))
+					ext4_block_truncate_page(handle,
+							inode->i_mapping, oldsize);
+			}
 
 			if (shrink)
 				ext4_fc_track_range(handle, inode,
-- 
2.45.0


