Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354B42CA93E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 18:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388131AbgLARBL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 12:01:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50546 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729452AbgLARBL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 12:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606841984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T7i5uotD/IpTPlUrBO3NFp7pR07GWqIu1OIGoP+fxvk=;
        b=KxUTFHTDzur16+Ihg17A7SoWPKh+ppo0dPQ7LSTjYyYoQrfs6V7jfCG+bxnhVaNg35W3h2
        j2pf9R+nUwVfWY1fpxy/1ir/1YHBCLlGRJgJpW/zTvT4lrQDrbVG0bqGZANw4i6JK7B9ct
        J1eM3S1kaxKOUH55HNZLNSirSSS6LDI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-IHTBsiIEPnyyAbiv00K3AQ-1; Tue, 01 Dec 2020 11:59:39 -0500
X-MC-Unique: IHTBsiIEPnyyAbiv00K3AQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB0609A223;
        Tue,  1 Dec 2020 16:59:37 +0000 (UTC)
Received: from liberator.sandeen.net (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D8C919C44;
        Tue,  1 Dec 2020 16:59:36 +0000 (UTC)
Subject: [PATCH 2/2] statx: move STATX_ATTR_DAX attribute handling to
 filesystems
To:     torvalds@linux-foundation.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>,
        linux-ext4@vger.kernel.org, Xiaoli Feng <xifeng@redhat.com>
References: <e388f379-cd11-a5d2-db82-aa1aa518a582@redhat.com>
From:   Eric Sandeen <sandeen@redhat.com>
Message-ID: <05a0f4fd-7f62-8fbc-378d-886ccd5b3f11@redhat.com>
Date:   Tue, 1 Dec 2020 10:59:36 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <e388f379-cd11-a5d2-db82-aa1aa518a582@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It's a bit odd to set STATX_ATTR_DAX into the statx attributes in the VFS;
while the VFS can detect the current DAX state, it is the filesystem which
actually sets S_DAX on the inode, and the filesystem is the place that
knows whether DAX is something that the "filesystem actually supports" [1]
so that the statx attributes_mask can be properly set.

So, move STATX_ATTR_DAX attribute setting to the individual dax-capable
filesystems, and update the attributes_mask there as well.

[1] 3209f68b3ca4 statx: Include a mask for stx_attributes in struct statx

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/ext2/inode.c   | 6 +++++-
 fs/ext4/inode.c   | 5 ++++-
 fs/stat.c         | 3 ---
 fs/xfs/xfs_iops.c | 5 ++++-
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 11c5c6fe75bb..3550783a6ea0 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1653,11 +1653,15 @@ int ext2_getattr(const struct path *path, struct kstat *stat,
 		stat->attributes |= STATX_ATTR_IMMUTABLE;
 	if (flags & EXT2_NODUMP_FL)
 		stat->attributes |= STATX_ATTR_NODUMP;
+	if (IS_DAX(inode))
+		stat->attributes |= STATX_ATTR_DAX;
+
 	stat->attributes_mask |= (STATX_ATTR_APPEND |
 			STATX_ATTR_COMPRESSED |
 			STATX_ATTR_ENCRYPTED |
 			STATX_ATTR_IMMUTABLE |
-			STATX_ATTR_NODUMP);
+			STATX_ATTR_NODUMP |
+			STATX_ATTR_DAX);
 
 	generic_fillattr(inode, stat);
 	return 0;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0d8385aea898..848a0f2b154e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5550,13 +5550,16 @@ int ext4_getattr(const struct path *path, struct kstat *stat,
 		stat->attributes |= STATX_ATTR_NODUMP;
 	if (flags & EXT4_VERITY_FL)
 		stat->attributes |= STATX_ATTR_VERITY;
+	if (IS_DAX(inode))
+		stat->attributes |= STATX_ATTR_DAX;
 
 	stat->attributes_mask |= (STATX_ATTR_APPEND |
 				  STATX_ATTR_COMPRESSED |
 				  STATX_ATTR_ENCRYPTED |
 				  STATX_ATTR_IMMUTABLE |
 				  STATX_ATTR_NODUMP |
-				  STATX_ATTR_VERITY);
+				  STATX_ATTR_VERITY |
+				  STATX_ATTR_DAX);
 
 	generic_fillattr(inode, stat);
 	return 0;
diff --git a/fs/stat.c b/fs/stat.c
index dacecdda2e79..5bd90949c69b 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -80,9 +80,6 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 	if (IS_AUTOMOUNT(inode))
 		stat->attributes |= STATX_ATTR_AUTOMOUNT;
 
-	if (IS_DAX(inode))
-		stat->attributes |= STATX_ATTR_DAX;
-
 	if (inode->i_op->getattr)
 		return inode->i_op->getattr(path, stat, request_mask,
 					    query_flags);
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 1414ab79eacf..56deda7042fd 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -575,10 +575,13 @@ xfs_vn_getattr(
 		stat->attributes |= STATX_ATTR_APPEND;
 	if (ip->i_d.di_flags & XFS_DIFLAG_NODUMP)
 		stat->attributes |= STATX_ATTR_NODUMP;
+	if (IS_DAX(inode))
+		stat->attributes |= STATX_ATTR_DAX;
 
 	stat->attributes_mask |= (STATX_ATTR_IMMUTABLE |
 				  STATX_ATTR_APPEND |
-				  STATX_ATTR_NODUMP);
+				  STATX_ATTR_NODUMP |
+				  STATX_ATTR_DAX);
 
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFBLK:
-- 
2.17.0


