Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26ACE1FAB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 21:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfEOT3S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 15:29:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727655AbfEOT1e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 15:27:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1FF7330C1AE6;
        Wed, 15 May 2019 19:27:34 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE2AC5D728;
        Wed, 15 May 2019 19:27:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 253D4225490; Wed, 15 May 2019 15:27:30 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, swhiteho@redhat.com
Subject: [PATCH v2 28/30] fuse: Reschedule dax free work if too many EAGAIN attempts
Date:   Wed, 15 May 2019 15:27:13 -0400
Message-Id: <20190515192715.18000-29-vgoyal@redhat.com>
In-Reply-To: <20190515192715.18000-1-vgoyal@redhat.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 15 May 2019 19:27:34 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fuse_dax_free_memory() can be very cpu intensive in corner cases. For example,
if one inode has consumed all the memory and a setupmapping request is
pending, that means inode lock is held by request and worker thread will
not get lock for a while. And given there is only one inode consuming all
the dax ranges, all the attempts to acquire lock will fail.

So if there are too many inode lock failures (-EAGAIN), reschedule the
worker with a 10ms delay.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/file.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index b0293a308b5e..9b82d9b4ebc3 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -4047,7 +4047,7 @@ int fuse_dax_free_one_mapping(struct fuse_conn *fc, struct inode *inode,
 int fuse_dax_free_memory(struct fuse_conn *fc, unsigned long nr_to_free)
 {
 	struct fuse_dax_mapping *dmap, *pos, *temp;
-	int ret, nr_freed = 0;
+	int ret, nr_freed = 0, nr_eagain = 0;
 	u64 dmap_start = 0, window_offset = 0;
 	struct inode *inode = NULL;
 
@@ -4056,6 +4056,12 @@ int fuse_dax_free_memory(struct fuse_conn *fc, unsigned long nr_to_free)
 		if (nr_freed >= nr_to_free)
 			break;
 
+		if (nr_eagain > 20) {
+			queue_delayed_work(system_long_wq, &fc->dax_free_work,
+						msecs_to_jiffies(10));
+			return 0;
+		}
+
 		dmap = NULL;
 		spin_lock(&fc->lock);
 
@@ -4093,8 +4099,10 @@ int fuse_dax_free_memory(struct fuse_conn *fc, unsigned long nr_to_free)
 		}
 
 		/* Could not get inode lock. Try next element */
-		if (ret == -EAGAIN)
+		if (ret == -EAGAIN) {
+			nr_eagain++;
 			continue;
+		}
 		nr_freed++;
 	}
 	return 0;
-- 
2.20.1

