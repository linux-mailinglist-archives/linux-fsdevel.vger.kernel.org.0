Return-Path: <linux-fsdevel+bounces-46150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08D7A83615
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 03:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A25797B1993
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 01:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA641DE2DE;
	Thu, 10 Apr 2025 01:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rJPriUve"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548D6193077;
	Thu, 10 Apr 2025 01:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744249793; cv=none; b=YtQhVOLCSJPNjY2C4qldeEyq3YQ0r7T1pKPzEjH5Vrz4WGtUgkplJEBPYalbDSouhG+OIwXEnHL4ya0ZszWeCR9W7+8UrtovXfInwEgyf75fmq7IURHWZkWKtEP+YOSdYYBoed9GmkGQ9/1ayDDcnAIcMFDLhvCtk6lCen3tsVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744249793; c=relaxed/simple;
	bh=j18XkRZT8Iv+bow22V0UsyXoR45P8eB4imMXzaz4PiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gHO5cBue/swdj6HjLKrKpxsQ5g9ASjf0Qh1uH0s9RozBfr2Szx3tiXX955DGQfm2VSX+/zK9oM6lPM5yaf4xDSwSxLv+D/P4+keoPr3W7RR8VOPxuafMuV1lWkwd39J4SaHIiElxjsR8oU33COEdB7kR8D6R4RoWw5nIKwTC2wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rJPriUve; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=zXx4xaSMWMb3LOBQgWf2JR22pqZmwI+2jZSbXpELefQ=; b=rJPriUvenypkpmUpeJ0u1yQNW6
	9n/TNmnCNyxAF36Iu35qPLksZxeTJr7tDTlQwIFNI9iaqRDrB9jQDJrt6aCobuskV4GVxqAvKIyj6
	rMFTAOA1pRqR1+VXmw4FKbHcWBf+LIhHQDeNTEfMh7UuXlvDEbSeeJ/4nTwum7x4jFMPCYPyQ4Iks
	ozYZuavJJYbt+dWMjbQD5S1TERtIeXXcyMMeCw4UzZ0Ni2ls+jzz94syh2MkBvyTwoEnj2dLqRUDE
	zn8L6hnMpDY++pw8sgot2giYHriNA8aCLi69OBqzcBgj33tG0d0DRoVZCSPNjc5BzJawmDd3aZ/xP
	VxFWWpRA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2h36-00000008yvQ-04S3;
	Thu, 10 Apr 2025 01:49:48 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: brauner@kernel.org,
	jack@suse.cz,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	riel@surriel.com
Cc: dave@stgolabs.net,
	willy@infradead.org,
	hannes@cmpxchg.org,
	oliver.sang@intel.com,
	david@redhat.com,
	axboe@kernel.dk,
	hare@suse.de,
	david@fromorbit.com,
	djwong@kernel.org,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	mcgrof@kernel.org
Subject: [PATCH v2 6/8] fs/ext4: use sleeping version of __find_get_block()
Date: Wed,  9 Apr 2025 18:49:43 -0700
Message-ID: <20250410014945.2140781-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410014945.2140781-1-mcgrof@kernel.org>
References: <20250410014945.2140781-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

From: Davidlohr Bueso <dave@stgolabs.net>

Trivially introduce the wrapper and enable ext4_free_blocks() to use
it, which has a cond_resched to begin with. Convert to the new nonatomic
flavor to benefit from potential performance benefits and adapt in the
future vs migration such that semantics are kept.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/ext4/inode.c             | 2 ++
 fs/ext4/mballoc.c           | 3 ++-
 include/linux/buffer_head.h | 6 ++++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1dc09ed5d403..b7acb5d3adcb 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -860,6 +860,8 @@ struct buffer_head *ext4_getblk(handle_t *handle, struct inode *inode,
 		return sb_find_get_block(inode->i_sb, map.m_pblk);
 
 	/*
+	 * Potential TODO: use sb_find_get_block_nonatomic() instead.
+	 *
 	 * Since bh could introduce extra ref count such as referred by
 	 * journal_head etc. Try to avoid using __GFP_MOVABLE here
 	 * as it may fail the migration when journal_head remains.
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 0d523e9fb3d5..6f4265b21e19 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6644,7 +6644,8 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 		for (i = 0; i < count; i++) {
 			cond_resched();
 			if (is_metadata)
-				bh = sb_find_get_block(inode->i_sb, block + i);
+				bh = sb_find_get_block_nonatomic(inode->i_sb,
+								 block + i);
 			ext4_forget(handle, is_metadata, inode, bh, block + i);
 		}
 	}
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 2b5458517def..8db10ca288fc 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -399,6 +399,12 @@ sb_find_get_block(struct super_block *sb, sector_t block)
 	return __find_get_block(sb->s_bdev, block, sb->s_blocksize);
 }
 
+static inline struct buffer_head *
+sb_find_get_block_nonatomic(struct super_block *sb, sector_t block)
+{
+	return __find_get_block_nonatomic(sb->s_bdev, block, sb->s_blocksize);
+}
+
 static inline void
 map_bh(struct buffer_head *bh, struct super_block *sb, sector_t block)
 {
-- 
2.47.2


