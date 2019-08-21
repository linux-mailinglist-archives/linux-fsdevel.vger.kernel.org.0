Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFA59818D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 19:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbfHURjQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 13:39:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728044AbfHURiU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:38:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E112307D930;
        Wed, 21 Aug 2019 17:38:20 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 126AA60E1C;
        Wed, 21 Aug 2019 17:38:15 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9CC60223CFD; Wed, 21 Aug 2019 13:38:14 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu
Cc:     virtio-fs@redhat.com, vgoyal@redhat.com, stefanha@redhat.com,
        dgilbert@redhat.com, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 01/13] fuse: delete dentry if timeout is zero
Date:   Wed, 21 Aug 2019 13:37:30 -0400
Message-Id: <20190821173742.24574-2-vgoyal@redhat.com>
In-Reply-To: <20190821173742.24574-1-vgoyal@redhat.com>
References: <20190821173742.24574-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 21 Aug 2019 17:38:20 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

Don't hold onto dentry in lru list if need to re-lookup it anyway at next
access.

More advanced version of this patch would periodically flush out dentries
from the lru which have gone stale.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dir.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index dd0f64f7bc06..fd8636e67ae9 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -29,12 +29,26 @@ union fuse_dentry {
 	struct rcu_head rcu;
 };
 
-static inline void fuse_dentry_settime(struct dentry *entry, u64 time)
+static void fuse_dentry_settime(struct dentry *dentry, u64 time)
 {
-	((union fuse_dentry *) entry->d_fsdata)->time = time;
+	/*
+	 * Mess with DCACHE_OP_DELETE because dput() will be faster without it.
+	 *  Don't care about races, either way it's just an optimization
+	 */
+	if ((time && (dentry->d_flags & DCACHE_OP_DELETE)) ||
+	    (!time && !(dentry->d_flags & DCACHE_OP_DELETE))) {
+		spin_lock(&dentry->d_lock);
+		if (time)
+			dentry->d_flags &= ~DCACHE_OP_DELETE;
+		else
+			dentry->d_flags |= DCACHE_OP_DELETE;
+		spin_unlock(&dentry->d_lock);
+	}
+
+	((union fuse_dentry *) dentry->d_fsdata)->time = time;
 }
 
-static inline u64 fuse_dentry_time(struct dentry *entry)
+static inline u64 fuse_dentry_time(const struct dentry *entry)
 {
 	return ((union fuse_dentry *) entry->d_fsdata)->time;
 }
@@ -255,8 +269,14 @@ static void fuse_dentry_release(struct dentry *dentry)
 	kfree_rcu(fd, rcu);
 }
 
+static int fuse_dentry_delete(const struct dentry *dentry)
+{
+	return time_before64(fuse_dentry_time(dentry), get_jiffies_64());
+}
+
 const struct dentry_operations fuse_dentry_operations = {
 	.d_revalidate	= fuse_dentry_revalidate,
+	.d_delete	= fuse_dentry_delete,
 	.d_init		= fuse_dentry_init,
 	.d_release	= fuse_dentry_release,
 };
-- 
2.20.1

