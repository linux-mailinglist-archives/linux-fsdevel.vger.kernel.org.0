Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FB9740A6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 10:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjF1IGO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 04:06:14 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:16863 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbjF1IDf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:03:35 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230628064459epoutp039f523bbe9d10a764a2fd7354808d83f5~sv6qCVMLp0425604256epoutp03B
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 06:44:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230628064459epoutp039f523bbe9d10a764a2fd7354808d83f5~sv6qCVMLp0425604256epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687934699;
        bh=kSunFsCYmbL+fZnS1g1aUFPpWAVuxrnXDZ3DH0imMyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WYsHuHMKKI5Ul3vxnw1SDQnMI8JEJrPwoEm4Gme9vEJXHPClwt3fhYZVtaZU28Lhs
         hd+319CR3o2p+puav3/Tcn7Wq05acJLoJnCES4mAMkRqxJDdmY2fRiNZ2EIPQBg9yZ
         pwGrDf+Il9eZ2s89e9Eb+ViNvoRWRlbgfgSBoOV4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230628064458epcas5p4dfb71fabb7e845688f0d0544b68a650b~sv6pV6pjj2985329853epcas5p4d;
        Wed, 28 Jun 2023 06:44:58 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QrXBd0qW5z4x9QG; Wed, 28 Jun
        2023 06:44:57 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.36.44250.8E6DB946; Wed, 28 Jun 2023 15:44:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230627184117epcas5p3a9102988870743b20127422928f072bd~smCx4nFGU0780707807epcas5p3z;
        Tue, 27 Jun 2023 18:41:17 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230627184117epsmtrp2812d3ec232f11f2b039cfc76bf06bdf1~smCx3iv1i2845228452epsmtrp22;
        Tue, 27 Jun 2023 18:41:17 +0000 (GMT)
X-AuditID: b6c32a4a-ec1fd7000000acda-1a-649bd6e8b64d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.0D.64355.C4D2B946; Wed, 28 Jun 2023 03:41:16 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230627184112epsmtip21d03faeb240fce47dbdf754dc4660d97~smCt8YCRz0383003830epsmtip2k;
        Tue, 27 Jun 2023 18:41:12 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        willy@infradead.org, hare@suse.de, djwong@kernel.org,
        bvanassche@acm.org, ming.lei@redhat.com, dlemoal@kernel.org,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Anuj Gupta <anuj20.g@samsung.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 9/9] null_blk: add support for copy offload
Date:   Wed, 28 Jun 2023 00:06:23 +0530
Message-Id: <20230627183629.26571-10-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230627183629.26571-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TeVBTVxTGe99LHsE29hGoXGhFDJUpe4IBLggFlTpvtNOhU9s67bTwSp6A
        CSGTBETUkUUsssuibUABpVQCI5VNIGApCsjWWDaHWIta6KCU1c5IB5EmRKz//c53v3vOPefO
        4eC8ajNbTpRMxShktJRPbGA13nBycns0WiQW5G5GNb1dOErOXcFR1b0cAk3fWATo7Py/OJpo
        /xag5QEdjoYmNqL7PweittkiNhprb8ZQ68U8DFVWdWIor2MUoMkRNYba9C6o7FQ5C7W29bDQ
        UEsxgUoqJs1Qxp0mAv3Y/RxDHfkpGGqaSAKocbkER1em51jolv5t9GdGGkC6lW42Wl4qJoLs
        qKHhfVSz+p4ZpfvjKouqu+xMDQ3EUrWa0wRVV36C0o4lEtSl7Hw2lZUyS1DNqeNsamFSz6Lm
        ro8QVHa9BlB1fUepJ7V2IRZfSPwjGVrMKOwZWXiMOEoWEcDf90no7lAvb4HQTeiLfPj2Mjqa
        CeAHfxjitidKahgT3z6OlsYapBBaqeR7vO+viIlVMfaRMUpVAJ+Ri6VykdxdSUcrY2UR7jJG
        5ScUCDy9DMYwSeTT0cdsuc43/uTwCEgENYJ0wOFAUgT704+mgw0cHqkFsDe9mEgH5oZgEcCp
        U/AlZ5QfWveXd1mb/M0AXuu9gpmCVAw+UOvMjCaCdIF9qxyjbkUm4vAn7SVgDHCyjAXv/pUJ
        jFktyUCo7ctnGZlFboOlqX1sI3PJHfB86TTLVM0D5oxbGGVzg6zV3XxhsYA930+sXcXJLTCl
        oQg3MiQHzeGZpGMmDobDLTqWiS3h4+56MxPbwiezbYSJD8PKgsuE8W2QPAmg+o4amA4CYWpv
        Dm58A046wZoWD5O8GRauNWysuxFmLU9gJp0Lmy6sswOsril9kd8Gjj5NIkytUPBqtp1pVtkA
        Pk9OA7nAXv1KO+pX2lH/X7kU4Bpgw8iV0RGM0kvuKWMOv/zh8JjoWrC2Ns57m8CD+/PuHQDj
        gA4AOTjfirtp6ZyYxxXTRxIYRUyoIlbKKDuAl2HcZ3Dbt8JjDHsnU4UKRb4Ckbe3t8h3u7eQ
        b82tGM4S88gIWsVIGEbOKNbvYRxz20TMZmAlIdnRtvzrhyqHLJ/b8cG835TvOClCz9qZaSpn
        +neWmPsJHN+onCo5UH087jvgVf7Dewf3q6475u6lfZqvjS5v5cWRQW86vWstGXC+23DAYiZv
        ML6963VPdSR2flPfjkK6DR7U4mHzZb9bb/2y87NGq2LKITPz2K3BOPfJv+cOLeSmwV+Dduur
        tj1znSm2XHXddbNClqaqF5WVfro9LOK0rHN/auuJfz7eIvXv/OWrWv/jq/23L5a6cL2O1NV4
        FIzrNVPx+rQ9kmfTuyQlrQ/1TnYF6Vnc2EL7R83hwsUPXKdWNIvU590LvOKGnnm/1745J5Ur
        Fy98RNdFsyOsE8Y6lir5LGUkLXTGFUr6P2P8Gfm/BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzHfZ/nuaen7OzpUn0LZXciNXFm9tW1ypr1XYyY3/l1c4+iK+eu
        LDKlJB2Ja5R+EE66jJuO6iR0+iGxY9exrnHhkmkrv2Pt/LiazX/vz+v9fn/2+ePDkII3lD+z
        MzWNU6ZK5ULag6p/IAycs2xOuWxeS40E6R+1kyjnpJNEV18W0WjwwWeAznz8SSLH/XyARp+Y
        SWRxTEJ996JQ81A5D/XcNxLozkUNgXRX2wikMT0HqN9aRqBmWyi6cERLoTvNnRSy3K6g0fnq
        fjd07EUjja50/CKQqTiXQI2OQwDVj54n0fXBYQo9tE1Bb48dBcjs7OCh0R8VdHQAtnQvxcay
        l27Y/OoGhQ01IdjyJB3X1RbQ2KDNwk092TS+dKKYhwtzh2hszLPz8Kd+G4WH71ppfOJmLcCG
        rkz8pS4g3nOjR4SMk+/cyynnRm7zSBp5/oGnMC/KONxtBdlAP08NGAayC6C23VcNPBgB2wBg
        fUMloQbuf7kfrHa2kuPaC+p+DbiNh3IJWHHcSbrKNBsKu34zLj6ZVZOwwDhEuQaSbaCgVn+Z
        52p7sVGwqauYcmmKDYJVeV1jnM9KYGXVIDV+xVxYZPd0Yfe/uMncynNhARsOhzvix9OesPOs
        Y2wLyQbC3Fvl5EnAlv1nlf1nVQGiFnhzClVKYsp2hThMJU1Rpacmhm3fnVIHxt4gZFUjqNY7
        w0yAYIAJQIYUTub7/CiRCfgy6b79nHL3VmW6nFOZwBSGEvryRfICmYBNlKZxyRyn4JT/XIJx
        988m8t8XZmyIjD10esWE5OrhGkvpp3BNW6nAbmQEpX0Hgld2T024FrPrG92Z1mIKiCZFanFO
        4bT3JT9n2D+sm1qrQoMiw5qv0QnxcRGyhIEgW9wLXar+S1aiKNYPPz1cuWAhaRhauUkyO1rT
        Lt8YK5lvzEyy5G1evIsvTBYZ3ozEBTHeTyfF0D49JTrv9e881+/JQeEXPvoEWi3FURnLpWEj
        2PeW40aIFuolPAnM85odyxSdaytc9SzCP5iJC8p/7Readi1A+3hz72PrxArx/tffhTbxgH3Z
        loPS6Zn06h37NL26mTGP+j9HnlW0rGUCZ/W23vU5vY3tcxdkLQk+VaMXUqokqTiEVKqkfwCP
        aevHdQMAAA==
X-CMS-MailID: 20230627184117epcas5p3a9102988870743b20127422928f072bd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230627184117epcas5p3a9102988870743b20127422928f072bd
References: <20230627183629.26571-1-nj.shetty@samsung.com>
        <CGME20230627184117epcas5p3a9102988870743b20127422928f072bd@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implementaion is based on existing read and write infrastructure.
copy_max_bytes: A new configfs and module parameter is introduced, which
can be used to set hardware/driver supported maximum copy limit.

Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
---
 Documentation/block/null_blk.rst  |  5 ++
 drivers/block/null_blk/main.c     | 85 +++++++++++++++++++++++++++++--
 drivers/block/null_blk/null_blk.h |  1 +
 3 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/Documentation/block/null_blk.rst b/Documentation/block/null_blk.rst
index 4dd78f24d10a..6153e02fcf13 100644
--- a/Documentation/block/null_blk.rst
+++ b/Documentation/block/null_blk.rst
@@ -149,3 +149,8 @@ zone_size=[MB]: Default: 256
 zone_nr_conv=[nr_conv]: Default: 0
   The number of conventional zones to create when block device is zoned.  If
   zone_nr_conv >= nr_zones, it will be reduced to nr_zones - 1.
+
+copy_max_bytes=[size in bytes]: Default: COPY_MAX_BYTES
+  A module and configfs parameter which can be used to set hardware/driver
+  supported maximum copy offload limit.
+  COPY_MAX_BYTES(=128MB at present) is defined in fs.h
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 864013019d6b..e9461bd4dc2c 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -157,6 +157,10 @@ static int g_max_sectors;
 module_param_named(max_sectors, g_max_sectors, int, 0444);
 MODULE_PARM_DESC(max_sectors, "Maximum size of a command (in 512B sectors)");
 
+static unsigned long g_copy_max_bytes = COPY_MAX_BYTES;
+module_param_named(copy_max_bytes, g_copy_max_bytes, ulong, 0444);
+MODULE_PARM_DESC(copy_max_bytes, "Maximum size of a copy command (in bytes)");
+
 static unsigned int nr_devices = 1;
 module_param(nr_devices, uint, 0444);
 MODULE_PARM_DESC(nr_devices, "Number of devices to register");
@@ -409,6 +413,7 @@ NULLB_DEVICE_ATTR(home_node, uint, NULL);
 NULLB_DEVICE_ATTR(queue_mode, uint, NULL);
 NULLB_DEVICE_ATTR(blocksize, uint, NULL);
 NULLB_DEVICE_ATTR(max_sectors, uint, NULL);
+NULLB_DEVICE_ATTR(copy_max_bytes, uint, NULL);
 NULLB_DEVICE_ATTR(irqmode, uint, NULL);
 NULLB_DEVICE_ATTR(hw_queue_depth, uint, NULL);
 NULLB_DEVICE_ATTR(index, uint, NULL);
@@ -550,6 +555,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_queue_mode,
 	&nullb_device_attr_blocksize,
 	&nullb_device_attr_max_sectors,
+	&nullb_device_attr_copy_max_bytes,
 	&nullb_device_attr_irqmode,
 	&nullb_device_attr_hw_queue_depth,
 	&nullb_device_attr_index,
@@ -656,7 +662,8 @@ static ssize_t memb_group_features_show(struct config_item *item, char *page)
 			"poll_queues,power,queue_mode,shared_tag_bitmap,size,"
 			"submit_queues,use_per_node_hctx,virt_boundary,zoned,"
 			"zone_capacity,zone_max_active,zone_max_open,"
-			"zone_nr_conv,zone_offline,zone_readonly,zone_size\n");
+			"zone_nr_conv,zone_offline,zone_readonly,zone_size,"
+			"copy_max_bytes\n");
 }
 
 CONFIGFS_ATTR_RO(memb_group_, features);
@@ -722,6 +729,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->queue_mode = g_queue_mode;
 	dev->blocksize = g_bs;
 	dev->max_sectors = g_max_sectors;
+	dev->copy_max_bytes = g_copy_max_bytes;
 	dev->irqmode = g_irqmode;
 	dev->hw_queue_depth = g_hw_queue_depth;
 	dev->blocking = g_blocking;
@@ -1271,6 +1279,67 @@ static int null_transfer(struct nullb *nullb, struct page *page,
 	return err;
 }
 
+static inline int nullb_setup_copy_write(struct nullb *nullb,
+		struct request *req, bool is_fua)
+{
+	sector_t sector_in, sector_out;
+	void *in, *out;
+	size_t rem, temp;
+	struct bio *bio;
+	unsigned long offset_in, offset_out;
+	struct nullb_page *t_page_in, *t_page_out;
+	int ret = -EIO;
+
+	sector_out = blk_rq_pos(req);
+
+	__rq_for_each_bio(bio, req) {
+		sector_in = bio->bi_iter.bi_sector;
+		rem = bio->bi_iter.bi_size;
+	}
+
+	if (WARN_ON(!rem))
+		return BLK_STS_NOTSUPP;
+
+	spin_lock_irq(&nullb->lock);
+	while (rem > 0) {
+		temp = min_t(size_t, nullb->dev->blocksize, rem);
+		offset_in = (sector_in & SECTOR_MASK) << SECTOR_SHIFT;
+		offset_out = (sector_out & SECTOR_MASK) << SECTOR_SHIFT;
+
+		if (null_cache_active(nullb) && !is_fua)
+			null_make_cache_space(nullb, PAGE_SIZE);
+
+		t_page_in = null_lookup_page(nullb, sector_in, false,
+			!null_cache_active(nullb));
+		if (!t_page_in)
+			goto err;
+		t_page_out = null_insert_page(nullb, sector_out,
+			!null_cache_active(nullb) || is_fua);
+		if (!t_page_out)
+			goto err;
+
+		in = kmap_local_page(t_page_in->page);
+		out = kmap_local_page(t_page_out->page);
+
+		memcpy(out + offset_out, in + offset_in, temp);
+		kunmap_local(out);
+		kunmap_local(in);
+		__set_bit(sector_out & SECTOR_MASK, t_page_out->bitmap);
+
+		if (is_fua)
+			null_free_sector(nullb, sector_out, true);
+
+		rem -= temp;
+		sector_in += temp >> SECTOR_SHIFT;
+		sector_out += temp >> SECTOR_SHIFT;
+	}
+
+	ret = 0;
+err:
+	spin_unlock_irq(&nullb->lock);
+	return ret;
+}
+
 static int null_handle_rq(struct nullb_cmd *cmd)
 {
 	struct request *rq = cmd->rq;
@@ -1280,13 +1349,16 @@ static int null_handle_rq(struct nullb_cmd *cmd)
 	sector_t sector = blk_rq_pos(rq);
 	struct req_iterator iter;
 	struct bio_vec bvec;
+	bool fua = rq->cmd_flags & REQ_FUA;
+
+	if (op_is_copy(req_op(rq)))
+		return nullb_setup_copy_write(nullb, rq, fua);
 
 	spin_lock_irq(&nullb->lock);
 	rq_for_each_segment(bvec, rq, iter) {
 		len = bvec.bv_len;
 		err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
-				     op_is_write(req_op(rq)), sector,
-				     rq->cmd_flags & REQ_FUA);
+				     op_is_write(req_op(rq)), sector, fua);
 		if (err) {
 			spin_unlock_irq(&nullb->lock);
 			return err;
@@ -2042,6 +2114,9 @@ static int null_validate_conf(struct nullb_device *dev)
 		return -EINVAL;
 	}
 
+	if (dev->queue_mode == NULL_Q_BIO)
+		dev->copy_max_bytes = 0;
+
 	return 0;
 }
 
@@ -2161,6 +2236,10 @@ static int null_add_dev(struct nullb_device *dev)
 		dev->max_sectors = queue_max_hw_sectors(nullb->q);
 	dev->max_sectors = min(dev->max_sectors, BLK_DEF_MAX_SECTORS);
 	blk_queue_max_hw_sectors(nullb->q, dev->max_sectors);
+	blk_queue_max_copy_sectors_hw(nullb->q,
+			       dev->copy_max_bytes >> SECTOR_SHIFT);
+	if (dev->copy_max_bytes)
+		blk_queue_flag_set(QUEUE_FLAG_COPY, nullb->disk->queue);
 
 	if (dev->virt_boundary)
 		blk_queue_virt_boundary(nullb->q, PAGE_SIZE - 1);
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 929f659dd255..e82e53a2e2df 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -107,6 +107,7 @@ struct nullb_device {
 	unsigned int queue_mode; /* block interface */
 	unsigned int blocksize; /* block size */
 	unsigned int max_sectors; /* Max sectors per command */
+	unsigned long copy_max_bytes; /* Max copy offload length in bytes */
 	unsigned int irqmode; /* IRQ completion handler */
 	unsigned int hw_queue_depth; /* queue depth */
 	unsigned int index; /* index of the disk, only valid with a disk */
-- 
2.35.1.500.gb896f729e2

