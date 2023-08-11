Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF48778CE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 13:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbjHKLFp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 07:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbjHKLFQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:05:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012F3E4C;
        Fri, 11 Aug 2023 04:05:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BD1191F891;
        Fri, 11 Aug 2023 11:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691751905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o4+jKqQ1x0Ey1yIHBqwsn99vq9xGiNmltJzcj4Snsx4=;
        b=NymZwWCmDVPf+oAdkRp6Fd3W33uCeIVi+mDXP+gMel/Ag9XuCoE75HkGLq87VAtzoY82Pm
        NRBGYqUSqo7VuWbrTkTzLCA0urGSKJ/5ochKyN1G0WVh4j4TjzEhOXMakth4zvXTMyjtXs
        phXifH8SKsqXtabIeHdhAQ6M8qKgMH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691751905;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o4+jKqQ1x0Ey1yIHBqwsn99vq9xGiNmltJzcj4Snsx4=;
        b=GsSZk6dIGu7xkC6a1rGWdt52tNx1adZtbaEtcaKG74D2xlinnFSyKWvF4DBqQnfyI5MBxR
        hwouiESDYmn+fWDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B031C139FD;
        Fri, 11 Aug 2023 11:05:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P7n/KuEV1mRGRQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 11 Aug 2023 11:05:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E0560A077F; Fri, 11 Aug 2023 13:05:04 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        xen-devel@lists.xenproject.org
Subject: [PATCH 07/29] xen/blkback: Convert to bdev_open_by_dev()
Date:   Fri, 11 Aug 2023 13:04:38 +0200
Message-Id: <20230811110504.27514-7-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230810171429.31759-1-jack@suse.cz>
References: <20230810171429.31759-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6152; i=jack@suse.cz; h=from:subject; bh=BtKISSNjUPlIJ2mx01CaoHxKal+UUOpgJzDPeV+Tjng=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk1hXJTAApujvhW+MJCl3UP6VxhTukhoQX0oarVPIN qZbOtKeJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZNYVyQAKCRCcnaoHP2RA2YTBCA CGxviiVkdtcZrheoDeTPAHsM7pySrLUYJzmmOtb66fig1K8eNsZaga/HYJbzFzqEARVS6BHDnBMlS3 O6ZPWXyrpodgPwsFXMfYq75Qm4aYI/emJOyrnM3Eg5TRgBaYBgBwKimM3309HZVfpmKEXA+l2JqpnN N1GFvI9ldoBqGQfiATVauUfxihdiK0b7Ci5P6Q6B/FABpjHt+kD2mOftlwneWhBtpWzPbo77dCeIq6 U5qLYZLH8KswL1ZMes46IO8lZ6pC8GnmqswRKSRwsLfsX3pCaY5rhmakO5hIhf6L3AcqUD519hed5z L1KRtGnxJ+LiyTUMYbQ1H0ZIb4KQeO
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert xen/blkback to use bdev_open_by_dev() and pass the
handle around.

CC: xen-devel@lists.xenproject.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/xen-blkback/blkback.c |  4 +--
 drivers/block/xen-blkback/common.h  |  4 +--
 drivers/block/xen-blkback/xenbus.c  | 40 +++++++++++++++--------------
 3 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index c362f4ad80ab..4defd7f387c7 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -465,7 +465,7 @@ static int xen_vbd_translate(struct phys_req *req, struct xen_blkif *blkif,
 	}
 
 	req->dev  = vbd->pdevice;
-	req->bdev = vbd->bdev;
+	req->bdev = vbd->bdev_handle->bdev;
 	rc = 0;
 
  out:
@@ -969,7 +969,7 @@ static int dispatch_discard_io(struct xen_blkif_ring *ring,
 	int err = 0;
 	int status = BLKIF_RSP_OKAY;
 	struct xen_blkif *blkif = ring->blkif;
-	struct block_device *bdev = blkif->vbd.bdev;
+	struct block_device *bdev = blkif->vbd.bdev_handle->bdev;
 	struct phys_req preq;
 
 	xen_blkif_get(blkif);
diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index 40f67bfc052d..5ff50e76cee5 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -221,7 +221,7 @@ struct xen_vbd {
 	unsigned char		type;
 	/* phys device that this vbd maps to. */
 	u32			pdevice;
-	struct block_device	*bdev;
+	struct bdev_handle	*bdev_handle;
 	/* Cached size parameter. */
 	sector_t		size;
 	unsigned int		flush_support:1;
@@ -360,7 +360,7 @@ struct pending_req {
 };
 
 
-#define vbd_sz(_v)	bdev_nr_sectors((_v)->bdev)
+#define vbd_sz(_v)	bdev_nr_sectors((_v)->bdev_handle->bdev)
 
 #define xen_blkif_get(_b) (atomic_inc(&(_b)->refcnt))
 #define xen_blkif_put(_b)				\
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index bb66178c432b..e34219ea2b05 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -81,7 +81,7 @@ static void xen_update_blkif_status(struct xen_blkif *blkif)
 	int i;
 
 	/* Not ready to connect? */
-	if (!blkif->rings || !blkif->rings[0].irq || !blkif->vbd.bdev)
+	if (!blkif->rings || !blkif->rings[0].irq || !blkif->vbd.bdev_handle)
 		return;
 
 	/* Already connected? */
@@ -99,12 +99,13 @@ static void xen_update_blkif_status(struct xen_blkif *blkif)
 		return;
 	}
 
-	err = sync_blockdev(blkif->vbd.bdev);
+	err = sync_blockdev(blkif->vbd.bdev_handle->bdev);
 	if (err) {
 		xenbus_dev_error(blkif->be->dev, err, "block flush");
 		return;
 	}
-	invalidate_inode_pages2(blkif->vbd.bdev->bd_inode->i_mapping);
+	invalidate_inode_pages2(
+			blkif->vbd.bdev_handle->bdev->bd_inode->i_mapping);
 
 	for (i = 0; i < blkif->nr_rings; i++) {
 		ring = &blkif->rings[i];
@@ -472,9 +473,9 @@ static void xenvbd_sysfs_delif(struct xenbus_device *dev)
 
 static void xen_vbd_free(struct xen_vbd *vbd)
 {
-	if (vbd->bdev)
-		blkdev_put(vbd->bdev, NULL);
-	vbd->bdev = NULL;
+	if (vbd->bdev_handle)
+		bdev_release(vbd->bdev_handle);
+	vbd->bdev_handle = NULL;
 }
 
 static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
@@ -482,7 +483,7 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 			  int cdrom)
 {
 	struct xen_vbd *vbd;
-	struct block_device *bdev;
+	struct bdev_handle *bdev_handle;
 
 	vbd = &blkif->vbd;
 	vbd->handle   = handle;
@@ -491,17 +492,17 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 
 	vbd->pdevice  = MKDEV(major, minor);
 
-	bdev = blkdev_get_by_dev(vbd->pdevice, vbd->readonly ?
+	bdev_handle = bdev_open_by_dev(vbd->pdevice, vbd->readonly ?
 				 BLK_OPEN_READ : BLK_OPEN_WRITE, NULL, NULL);
 
-	if (IS_ERR(bdev)) {
+	if (IS_ERR(bdev_handle)) {
 		pr_warn("xen_vbd_create: device %08x could not be opened\n",
 			vbd->pdevice);
 		return -ENOENT;
 	}
 
-	vbd->bdev = bdev;
-	if (vbd->bdev->bd_disk == NULL) {
+	vbd->bdev_handle = bdev_handle;
+	if (vbd->bdev_handle->bdev->bd_disk == NULL) {
 		pr_warn("xen_vbd_create: device %08x doesn't exist\n",
 			vbd->pdevice);
 		xen_vbd_free(vbd);
@@ -509,14 +510,14 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 	}
 	vbd->size = vbd_sz(vbd);
 
-	if (cdrom || disk_to_cdi(vbd->bdev->bd_disk))
+	if (cdrom || disk_to_cdi(vbd->bdev_handle->bdev->bd_disk))
 		vbd->type |= VDISK_CDROM;
-	if (vbd->bdev->bd_disk->flags & GENHD_FL_REMOVABLE)
+	if (vbd->bdev_handle->bdev->bd_disk->flags & GENHD_FL_REMOVABLE)
 		vbd->type |= VDISK_REMOVABLE;
 
-	if (bdev_write_cache(bdev))
+	if (bdev_write_cache(bdev_handle->bdev))
 		vbd->flush_support = true;
-	if (bdev_max_secure_erase_sectors(bdev))
+	if (bdev_max_secure_erase_sectors(bdev_handle->bdev))
 		vbd->discard_secure = true;
 
 	pr_debug("Successful creation of handle=%04x (dom=%u)\n",
@@ -569,7 +570,7 @@ static void xen_blkbk_discard(struct xenbus_transaction xbt, struct backend_info
 	struct xen_blkif *blkif = be->blkif;
 	int err;
 	int state = 0;
-	struct block_device *bdev = be->blkif->vbd.bdev;
+	struct block_device *bdev = be->blkif->vbd.bdev_handle->bdev;
 
 	if (!xenbus_read_unsigned(dev->nodename, "discard-enable", 1))
 		return;
@@ -930,15 +931,16 @@ static void connect(struct backend_info *be)
 		goto abort;
 	}
 	err = xenbus_printf(xbt, dev->nodename, "sector-size", "%lu",
-			    (unsigned long)
-			    bdev_logical_block_size(be->blkif->vbd.bdev));
+			    (unsigned long)bdev_logical_block_size(
+					be->blkif->vbd.bdev_handle->bdev));
 	if (err) {
 		xenbus_dev_fatal(dev, err, "writing %s/sector-size",
 				 dev->nodename);
 		goto abort;
 	}
 	err = xenbus_printf(xbt, dev->nodename, "physical-sector-size", "%u",
-			    bdev_physical_block_size(be->blkif->vbd.bdev));
+			    bdev_physical_block_size(
+					be->blkif->vbd.bdev_handle->bdev));
 	if (err)
 		xenbus_dev_error(dev, err, "writing %s/physical-sector-size",
 				 dev->nodename);
-- 
2.35.3

