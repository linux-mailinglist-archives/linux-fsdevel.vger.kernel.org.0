Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E832B1613
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 07:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgKMG5c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 01:57:32 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17194 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726301AbgKMG5b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 01:57:31 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1605250629; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=XxfuUQ2O6vD2Zbthi377ozGLKA6+svQR8Wp/5kNWihA75a9vY5JMbqlM3Z+0ufjNJH/g86Kbplao2jWEt2iLALRAss/9KqYELmr2pyLynMWHMwcmcHlV0hOAIOR7gRikRHQfUNRFpOGoVsM5m8WdDBTn2Ak1sUc+u+jQUduLT78=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1605250629; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=fvqzm+3URTfc4SNv5XnFr/jbDxgFHKTjuWBcOlIXqVs=; 
        b=R3DRbasmzrGnV0g5pkwUb9zEehxcUy0wLCtGzDKnGVNv2bcUv+ySGJnZutLU8oCTnK87aHEKqkfsz7cQxl7SmH+ycTrzGKANM7hr7GzQf/JoFRIVz/d/BGAde6CZuPCsh+cXqj2AcILhlD6b9yk8wfy1hsP8hp2iZ9jCoDs+4VE=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1605250629;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=fvqzm+3URTfc4SNv5XnFr/jbDxgFHKTjuWBcOlIXqVs=;
        b=SLMS3bnoENjizdCvCH5EoGwrboGl+PJnz0RWQsA51CBd6fiQZhlINSsLJ+fE8OX1
        bepADgcqWmpyM1quWj0fY+BD9jVZw4bfgK3LvgA6TnNw/gLtNsSWmIVWExPCJIv4ekZ
        2a8A2yC7tsQ8ctB6FWZP3jriD6CuVUEg5JvotEBU=
Received: from localhost.localdomain (116.30.195.173 [116.30.195.173]) by mx.zoho.com.cn
        with SMTPS id 1605250628208189.30840318851824; Fri, 13 Nov 2020 14:57:08 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201113065555.147276-9-cgxu519@mykernel.net>
Subject: [RFC PATCH v4 8/9] fs: export wait_sb_inodes()
Date:   Fri, 13 Nov 2020 14:55:54 +0800
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201113065555.147276-1-cgxu519@mykernel.net>
References: <20201113065555.147276-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to wait syncing upper inodes we need to call wait_sb_inodes()
in overlayfs' ->sync_fs.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/fs-writeback.c         | 3 ++-
 include/linux/writeback.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 149227160ff0..55dafdc72661 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2365,7 +2365,7 @@ EXPORT_SYMBOL(__mark_inode_dirty);
  * completed by the time we have gained the lock and waited for all IO tha=
t is
  * in progress regardless of the order callers are granted the lock.
  */
-static void wait_sb_inodes(struct super_block *sb)
+void wait_sb_inodes(struct super_block *sb)
 {
 =09LIST_HEAD(sync_list);
=20
@@ -2449,6 +2449,7 @@ static void wait_sb_inodes(struct super_block *sb)
 =09rcu_read_unlock();
 =09mutex_unlock(&sb->s_sync_lock);
 }
+EXPORT_SYMBOL(wait_sb_inodes);
=20
 static void __writeback_inodes_sb_nr(struct super_block *sb, unsigned long=
 nr,
 =09=09=09=09     enum wb_reason reason, bool skip_if_busy)
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 8e5c5bb16e2d..53e826af33b6 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -198,6 +198,7 @@ void wakeup_flusher_threads_bdi(struct backing_dev_info=
 *bdi,
 =09=09=09=09enum wb_reason reason);
 void inode_wait_for_writeback(struct inode *inode);
 void inode_io_list_del(struct inode *inode);
+void wait_sb_inodes(struct super_block *sb);
=20
 /* writeback.h requires fs.h; it, too, is not included from here. */
 static inline void wait_on_inode(struct inode *inode)
--=20
2.26.2


