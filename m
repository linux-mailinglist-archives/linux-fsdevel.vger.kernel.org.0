Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D61DAAC57
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 21:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391503AbfIETuS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 15:50:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388067AbfIETt1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:49:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E1282308FC20;
        Thu,  5 Sep 2019 19:49:26 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBF88600F8;
        Thu,  5 Sep 2019 19:49:26 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 08BE92253A3; Thu,  5 Sep 2019 15:49:18 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu
Cc:     linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        mst@redhat.com
Subject: [PATCH 11/18] virtiofs: stop and drain queues after sending DESTROY
Date:   Thu,  5 Sep 2019 15:48:52 -0400
Message-Id: <20190905194859.16219-12-vgoyal@redhat.com>
In-Reply-To: <20190905194859.16219-1-vgoyal@redhat.com>
References: <20190905194859.16219-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 05 Sep 2019 19:49:26 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

During virtio_kill_sb() we first stop forget queue and drain it and then
call fuse_kill_sb_anon(). This will result in sending DESTROY request to
fuse server. Once finished, stop all the queues and drain one more time
just to be sure and then free up the devices.

Given drain queues will call flush_work() on various workers, remove this
logic from virtio_free_devs().

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 1ea0f889e804..a76bd5a04521 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -180,9 +180,6 @@ static void virtio_fs_free_devs(struct virtio_fs *fs)
 		if (!fsvq->fud)
 			continue;
 
-		flush_work(&fsvq->done_work);
-		flush_delayed_work(&fsvq->dispatch_work);
-
 		/* TODO need to quiesce/end_requests/decrement dev_count */
 		fuse_dev_free(fsvq->fud);
 		fsvq->fud = NULL;
@@ -994,6 +991,8 @@ static int virtio_fs_fill_super(struct super_block *sb)
 		atomic_inc(&fc->dev_count);
 	}
 
+	/* Previous unmount will stop all queues. Start these again */
+	virtio_fs_start_all_queues(fs);
 	fuse_send_init(fc, init_req);
 	return 0;
 
@@ -1026,6 +1025,12 @@ static void virtio_kill_sb(struct super_block *sb)
 	virtio_fs_drain_all_queues(vfs);
 
 	fuse_kill_sb_anon(sb);
+
+	/* fuse_kill_sb_anon() must have sent destroy. Stop all queues
+	 * and drain one more time and free fuse devices.
+	 */
+	virtio_fs_stop_all_queues(vfs);
+	virtio_fs_drain_all_queues(vfs);
 	virtio_fs_free_devs(vfs);
 }
 
-- 
2.20.1

