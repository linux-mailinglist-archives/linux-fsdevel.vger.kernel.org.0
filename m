Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 735FEAAC34
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 21:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389945AbfIETt2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 15:49:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388340AbfIETt1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:49:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2CCCC30860B9;
        Thu,  5 Sep 2019 19:49:27 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 093FD5C1D4;
        Thu,  5 Sep 2019 19:49:27 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 30FDB2253AA; Thu,  5 Sep 2019 15:49:18 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu
Cc:     linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        mst@redhat.com
Subject: [PATCH 18/18] virtiofs: Remove TODO item from virtio_fs_free_devs()
Date:   Thu,  5 Sep 2019 15:48:59 -0400
Message-Id: <20190905194859.16219-19-vgoyal@redhat.com>
In-Reply-To: <20190905194859.16219-1-vgoyal@redhat.com>
References: <20190905194859.16219-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 05 Sep 2019 19:49:27 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

virtio_fs_free_devs() is now called from ->kill_sb(). By this time
all device queues have been quiesced. I am assuming that while
->kill_sb() is in progress, another mount instance will wait for
it to finish (sb->s_umount mutex provides mutual exclusion).

W.r.t ->remove path, we should be fine as we are not touching vdev
or virtqueues. And we have reference on virtio_fs object, so we know
rest of the data structures are valid.

So I can't see the need of any additional locking yet.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index eadaea6eb8e2..61aa3eba7b22 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -200,8 +200,6 @@ static void virtio_fs_free_devs(struct virtio_fs *fs)
 {
 	unsigned int i;
 
-	/* TODO lock */
-
 	for (i = 0; i < fs->nvqs; i++) {
 		struct virtio_fs_vq *fsvq = &fs->vqs[i];
 
-- 
2.20.1

