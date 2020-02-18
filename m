Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB651633A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 22:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgBRVAb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 16:00:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46302 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgBRVAb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 16:00:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jmhvUBgL17K+r/z50BTqQAddoJVQaQTjgCD8Zfi7qDw=; b=uiXSnsN+bwKi/q21BCykCKBpvx
        Bij7HgN63mKw+71YEhKt4bMXXsGI7DWYt9a6mIyAKNuV9z6Cy0tmPLsZUZ1uAPX0ApjbbRESX2Tea
        BolrKBORcHB3RMoAoSTyRNGW4saLOZhJElLRcMvqxb1f0LxzTIhVFep6zlrLUXBfVo+ugFcN9NonW
        ne7D8DRh047omN+zxg9S1dxSk8/TrWI48pV4dB9iZNTgdbRjQnN4EiFOo1xvvFm1z7ZAPjybiv0oQ
        0pJ7QMMugB04KxP1injETN8lvjSNvOVYHie4HgP+fwEjWclEXPV8mleexYLqqjXBaDqE9AzO4AxGl
        zcTTYyYw==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j49yo-0007Kt-Sj; Tue, 18 Feb 2020 21:00:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3] xfs: ensure that the inode uid/gid match values match the icdinode ones
Date:   Tue, 18 Feb 2020 13:00:18 -0800
Message-Id: <20200218210020.40846-2-hch@lst.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200218210020.40846-1-hch@lst.de>
References: <20200218210020.40846-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of only synchronizing the uid/gid values in xfs_setup_inode,
ensure that they always match to prepare for removing the icdinode
fields.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/libxfs/xfs_inode_buf.c | 2 ++
 fs/xfs/xfs_icache.c           | 4 ++++
 fs/xfs/xfs_inode.c            | 8 ++++++--
 fs/xfs/xfs_iops.c             | 3 ---
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
index 8afacfe4be0a..cc4efd34843a 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.c
+++ b/fs/xfs/libxfs/xfs_inode_buf.c
@@ -223,7 +223,9 @@ xfs_inode_from_disk(
 
 	to->di_format = from->di_format;
 	to->di_uid = be32_to_cpu(from->di_uid);
+	inode->i_uid = xfs_uid_to_kuid(to->di_uid);
 	to->di_gid = be32_to_cpu(from->di_gid);
+	inode->i_gid = xfs_gid_to_kgid(to->di_gid);
 	to->di_flushiter = be16_to_cpu(from->di_flushiter);
 
 	/*
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 8dc2e5414276..a7be7a9e5c1a 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -289,6 +289,8 @@ xfs_reinit_inode(
 	uint64_t	version = inode_peek_iversion(inode);
 	umode_t		mode = inode->i_mode;
 	dev_t		dev = inode->i_rdev;
+	kuid_t		uid = inode->i_uid;
+	kgid_t		gid = inode->i_gid;
 
 	error = inode_init_always(mp->m_super, inode);
 
@@ -297,6 +299,8 @@ xfs_reinit_inode(
 	inode_set_iversion_queried(inode, version);
 	inode->i_mode = mode;
 	inode->i_rdev = dev;
+	inode->i_uid = uid;
+	inode->i_gid = gid;
 	return error;
 }
 
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index c5077e6326c7..938b0943bd95 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -812,15 +812,19 @@ xfs_ialloc(
 
 	inode->i_mode = mode;
 	set_nlink(inode, nlink);
-	ip->i_d.di_uid = xfs_kuid_to_uid(current_fsuid());
-	ip->i_d.di_gid = xfs_kgid_to_gid(current_fsgid());
+	inode->i_uid = current_fsuid();
+	ip->i_d.di_uid = xfs_kuid_to_uid(inode->i_uid);
 	inode->i_rdev = rdev;
 	ip->i_d.di_projid = prid;
 
 	if (pip && XFS_INHERIT_GID(pip)) {
+		inode->i_gid = VFS_I(pip)->i_gid;
 		ip->i_d.di_gid = pip->i_d.di_gid;
 		if ((VFS_I(pip)->i_mode & S_ISGID) && S_ISDIR(mode))
 			inode->i_mode |= S_ISGID;
+	} else {
+		inode->i_gid = current_fsgid();
+		ip->i_d.di_gid = xfs_kgid_to_gid(inode->i_gid);
 	}
 
 	/*
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 81f2f93caec0..b818b261918f 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1304,9 +1304,6 @@ xfs_setup_inode(
 	/* make the inode look hashed for the writeback code */
 	inode_fake_hash(inode);
 
-	inode->i_uid    = xfs_uid_to_kuid(ip->i_d.di_uid);
-	inode->i_gid    = xfs_gid_to_kgid(ip->i_d.di_gid);
-
 	i_size_write(inode, ip->i_d.di_size);
 	xfs_diflags_to_iflags(inode, ip);
 
-- 
2.24.1

