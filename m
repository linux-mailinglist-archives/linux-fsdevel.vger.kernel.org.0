Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9D95459F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 04:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242351AbiFJCK6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 22:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbiFJCK5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 22:10:57 -0400
X-Greylist: delayed 125 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Jun 2022 19:10:53 PDT
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D357D2E4C9B
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jun 2022 19:10:53 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id EYS00042;
        Fri, 10 Jun 2022 10:08:42 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server id
 15.1.2308.27; Fri, 10 Jun 2022 10:08:42 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <vgoyal@redhat.com>, <stefanha@redhat.com>, <miklos@szeredi.hu>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] virtiofs: delete unused parameter for virtio_fs_cleanup_vqs
Date:   Thu, 9 Jun 2022 22:08:38 -0400
Message-ID: <20220610020838.1543-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   20226101008420bf8402121fba2a78ef67f2620eb00cc
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fs parameter not used. So, it needs to be deleted.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 fs/fuse/virtio_fs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 8db53fa67359..0991199d19c1 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -741,8 +741,7 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 }
 
 /* Free virtqueues (device must already be reset) */
-static void virtio_fs_cleanup_vqs(struct virtio_device *vdev,
-				  struct virtio_fs *fs)
+static void virtio_fs_cleanup_vqs(struct virtio_device *vdev)
 {
 	vdev->config->del_vqs(vdev);
 }
@@ -895,7 +894,7 @@ static int virtio_fs_probe(struct virtio_device *vdev)
 
 out_vqs:
 	virtio_reset_device(vdev);
-	virtio_fs_cleanup_vqs(vdev, fs);
+	virtio_fs_cleanup_vqs(vdev);
 	kfree(fs->vqs);
 
 out:
@@ -927,7 +926,7 @@ static void virtio_fs_remove(struct virtio_device *vdev)
 	virtio_fs_stop_all_queues(fs);
 	virtio_fs_drain_all_queues_locked(fs);
 	virtio_reset_device(vdev);
-	virtio_fs_cleanup_vqs(vdev, fs);
+	virtio_fs_cleanup_vqs(vdev);
 
 	vdev->priv = NULL;
 	/* Put device reference on virtio_fs object */
-- 
2.27.0

