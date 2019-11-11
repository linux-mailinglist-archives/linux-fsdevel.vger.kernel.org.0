Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90396F7397
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 13:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfKKMIa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 07:08:30 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5762 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726811AbfKKMIa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 07:08:30 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A97208A61F89CF98DA81;
        Mon, 11 Nov 2019 20:08:28 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Mon, 11 Nov 2019
 20:08:21 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <vgoyal@redhat.com>, <stefanha@redhat.com>, <mszeredi@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH v2] virtiofs: Use static const, not const static
Date:   Mon, 11 Nov 2019 20:15:45 +0800
Message-ID: <1573474545-37037-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the static keyword to the front of declarations, which resolves
compiler warnings when building with "W=1":

fs/fuse/virtio_fs.c:687:1: warning: ‘static’ is not at beginning of declaration [-Wold-style-declaration]
 const static struct virtio_device_id id_table[] = {
 ^
fs/fuse/virtio_fs.c:692:1: warning: ‘static’ is not at beginning of declaration [-Wold-style-declaration]
 const static unsigned int feature_table[] = {};
 ^
fs/fuse/virtio_fs.c:1029:1: warning: ‘static’ is not at beginning of declaration [-Wold-style-declaration]
 const static struct fuse_iqueue_ops virtio_fs_fiq_ops = {

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
v1->v2: modify comment
 fs/fuse/virtio_fs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index b77acea..2ac6818 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -684,12 +684,12 @@ static int virtio_fs_restore(struct virtio_device *vdev)
 }
 #endif /* CONFIG_PM_SLEEP */

-const static struct virtio_device_id id_table[] = {
+static const struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_FS, VIRTIO_DEV_ANY_ID },
 	{},
 };

-const static unsigned int feature_table[] = {};
+static const unsigned int feature_table[] = {};

 static struct virtio_driver virtio_fs_driver = {
 	.driver.name		= KBUILD_MODNAME,
@@ -1026,7 +1026,7 @@ __releases(fiq->lock)
 	}
 }

-const static struct fuse_iqueue_ops virtio_fs_fiq_ops = {
+static const struct fuse_iqueue_ops virtio_fs_fiq_ops = {
 	.wake_forget_and_unlock		= virtio_fs_wake_forget_and_unlock,
 	.wake_interrupt_and_unlock	= virtio_fs_wake_interrupt_and_unlock,
 	.wake_pending_and_unlock	= virtio_fs_wake_pending_and_unlock,
--
2.7.4

