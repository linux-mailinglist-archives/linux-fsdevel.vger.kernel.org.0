Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0052A2B4706
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 15:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbgKPO7p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 09:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731013AbgKPO7n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:59:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59476C0613D1;
        Mon, 16 Nov 2020 06:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=AZC0zIud/sy36HL3UqpdhruuJxaP+dAsE+XWl7N2xio=; b=hC2kUAEWCYh9OryEptbmVZ4ebz
        NJfypqCrjvekFThEDQHeAH+KnX3FgqoOh2oFdElpy2UOUU8OYvMVMyDtZx5PgsNNgO5KvLRJtcx2F
        8Z2wJ6ZAecQ/tCcYHLbAlAGK62e/LPO1anzZqXyhoiZcnyM456rb6Ib/pV9REehr8DlazH4amfdur
        a7V1kHvqoU8gZ+KDoDs23F8OiOCpjlxcgAWIv7ZpBKEh+7hc5sOGW+853KLP0z+7cruWtWsL7L99a
        DSrjRt5uLPvZTcUNxbnqe7Ie7DIj2M7MWaG8rzW38nm4RM1CwtXe4KSgUM8q+WHYxhoTnZfd7fBBR
        Uej9O+GQ==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kefyd-000470-B8; Mon, 16 Nov 2020 14:59:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 57/78] init: refactor devt_from_partuuid
Date:   Mon, 16 Nov 2020 15:57:48 +0100
Message-Id: <20201116145809.410558-58-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The code in devt_from_partuuid is very convoluted.  Refactor a bit by
sanitizing the goto and variable name usage.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/do_mounts.c | 68 ++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 37 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index aef2f24461c7f1..afa26a4028d25e 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -105,13 +105,10 @@ static int match_dev_by_uuid(struct device *dev, const void *data)
  */
 static dev_t devt_from_partuuid(const char *uuid_str)
 {
-	dev_t res = 0;
 	struct uuidcmp cmp;
 	struct device *dev = NULL;
-	struct gendisk *disk;
-	struct hd_struct *part;
+	dev_t devt = 0;
 	int offset = 0;
-	bool clear_root_wait = false;
 	char *slash;
 
 	cmp.uuid = uuid_str;
@@ -120,52 +117,49 @@ static dev_t devt_from_partuuid(const char *uuid_str)
 	/* Check for optional partition number offset attributes. */
 	if (slash) {
 		char c = 0;
+
 		/* Explicitly fail on poor PARTUUID syntax. */
-		if (sscanf(slash + 1,
-			   "PARTNROFF=%d%c", &offset, &c) != 1) {
-			clear_root_wait = true;
-			goto done;
-		}
+		if (sscanf(slash + 1, "PARTNROFF=%d%c", &offset, &c) != 1)
+			goto clear_root_wait;
 		cmp.len = slash - uuid_str;
 	} else {
 		cmp.len = strlen(uuid_str);
 	}
 
-	if (!cmp.len) {
-		clear_root_wait = true;
-		goto done;
-	}
+	if (!cmp.len)
+		goto clear_root_wait;
 
-	dev = class_find_device(&block_class, NULL, &cmp,
-				&match_dev_by_uuid);
+	dev = class_find_device(&block_class, NULL, &cmp, &match_dev_by_uuid);
 	if (!dev)
-		goto done;
-
-	res = dev->devt;
+		return 0;
 
-	/* Attempt to find the partition by offset. */
-	if (!offset)
-		goto no_offset;
+	if (offset) {
+		/*
+		 * Attempt to find the requested partition by adding an offset
+		 * to the partition number found by UUID.
+		 */
+		struct hd_struct *part;
 
-	res = 0;
-	disk = part_to_disk(dev_to_part(dev));
-	part = disk_get_part(disk, dev_to_part(dev)->partno + offset);
-	if (part) {
-		res = part_devt(part);
-		put_device(part_to_dev(part));
+		part = disk_get_part(dev_to_disk(dev),
+				     dev_to_part(dev)->partno + offset);
+		if (part) {
+			devt = part_devt(part);
+			put_device(part_to_dev(part));
+		}
+	} else {
+		devt = dev->devt;
 	}
 
-no_offset:
 	put_device(dev);
-done:
-	if (clear_root_wait) {
-		pr_err("VFS: PARTUUID= is invalid.\n"
-		       "Expected PARTUUID=<valid-uuid-id>[/PARTNROFF=%%d]\n");
-		if (root_wait)
-			pr_err("Disabling rootwait; root= is invalid.\n");
-		root_wait = 0;
-	}
-	return res;
+	return devt;
+
+clear_root_wait:
+	pr_err("VFS: PARTUUID= is invalid.\n"
+	       "Expected PARTUUID=<valid-uuid-id>[/PARTNROFF=%%d]\n");
+	if (root_wait)
+		pr_err("Disabling rootwait; root= is invalid.\n");
+	root_wait = 0;
+	return 0;
 }
 
 /**
-- 
2.29.2

