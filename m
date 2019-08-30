Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 842ADA4107
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2019 01:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbfH3X3f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 19:29:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45674 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfH3X3e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 19:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=silDtNj8mBmuN3iX2OzWF6cGvby74qt7BRdpejRaOic=; b=S9fCFjGUZ2Lut9Cu9VLcsHpdh
        A6M95AuaGrMr+Ka1cWS0Fn3FdclW+antlSHEZq5Xcn7XiHWWyTNworuL18pF18CosT3HB8V7YNZoj
        pCuv7DGQq+frjo4rgadCda45kET0FDx01qqMc3nPbli+TV2Gg7rxwODDzVivcYhO6jRvme9RYDEZb
        cZgUUNCfDyeBDx0rWBWdW9bcRkDiLfVhHcgkS1ruYJ6uf1mH6Ycif9IMahjxX2BMWq1UmStKxz4cL
        dj3jTrVjJKa3lyq4cJOYY6dGaBdXWhNNhY2mSK1u0gpN93HLVp7gNelq9ecqTMyP/dJ4W+omh/qxA
        DrTWGYUQQ==;
Received: from [2601:1c0:6200:6e8::4f71]
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3qKj-0001by-QN; Fri, 30 Aug 2019 23:29:33 +0000
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] fuse: fix virtio_fs.c build warnings
Message-ID: <4dbb6d9e-846f-e566-30a4-0082dd113bd3@infradead.org>
Date:   Fri, 30 Aug 2019 16:29:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Be consistent in using CONFIG_PM_SLEEP for the freeze and restore
functions to avoid build warnings.

../fs/fuse/virtio_fs.c:501:12: warning: ‘virtio_fs_restore’ defined but not used [-Wunused-function]
 static int virtio_fs_restore(struct virtio_device *vdev)
            ^~~~~~~~~~~~~~~~~
../fs/fuse/virtio_fs.c:496:12: warning: ‘virtio_fs_freeze’ defined but not used [-Wunused-function]
 static int virtio_fs_freeze(struct virtio_device *vdev)
            ^~~~~~~~~~~~~~~~

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/fuse/virtio_fs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20190830.orig/fs/fuse/virtio_fs.c
+++ linux-next-20190830/fs/fuse/virtio_fs.c
@@ -492,7 +492,7 @@ static void virtio_fs_remove(struct virt
 	vdev->priv = NULL;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int virtio_fs_freeze(struct virtio_device *vdev)
 {
 	return 0; /* TODO */
@@ -502,7 +502,7 @@ static int virtio_fs_restore(struct virt
 {
 	return 0; /* TODO */
 }
-#endif /* CONFIG_PM */
+#endif /* CONFIG_PM_SLEEP */
 
 const static struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_FS, VIRTIO_DEV_ANY_ID },


