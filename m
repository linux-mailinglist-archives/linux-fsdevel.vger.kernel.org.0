Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1383202CD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Feb 2021 03:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhBTCCy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Feb 2021 21:02:54 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:52701 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhBTCCW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Feb 2021 21:02:22 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210220020137epoutp04cd69ba73cf50677d54a436e86abc1771~lUkTlGByf3213232132epoutp04V
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Feb 2021 02:01:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210220020137epoutp04cd69ba73cf50677d54a436e86abc1771~lUkTlGByf3213232132epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613786497;
        bh=nm9Be2Mj5YhN9iVG1NFsxmGk7Z67xf3xcsdp1ACfgXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bSXGnbOzKAdmVAbLu8Z4/2GbAZRzV0r+SXShTOIZ+ClYJTR3lskTMXNOvWh92WoO4
         s7u8MoNciJs44Ava0cHfg4k3hbVu5opuDCQxdosmgp6HfNUBQnFLbH1zgVSiV9rW3G
         ti9MUmosWLAevErQWQOjj50iN4oOwbJFP2T9Puw8=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20210220020136epcas5p23b0d0ac0ffe81071b128801281325613~lUkSuW6IX2074420744epcas5p2H;
        Sat, 20 Feb 2021 02:01:36 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3F.00.33964.08D60306; Sat, 20 Feb 2021 11:01:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20210219124603epcas5p33add0f2c1781b2a4d71bf30c9e1ac647~lJtsTBwGS2180821808epcas5p3U;
        Fri, 19 Feb 2021 12:46:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210219124603epsmtrp2a11a7eecd63661b39966509251e4c546~lJtsR-xll0558405584epsmtrp2M;
        Fri, 19 Feb 2021 12:46:03 +0000 (GMT)
X-AuditID: b6c32a4b-eb7ff700000184ac-89-60306d80115f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.7A.13470.B03BF206; Fri, 19 Feb 2021 21:46:03 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210219124600epsmtip2cef97ec901cf921191559d0649f864c9~lJtpisV4e1410414104epsmtip2Y;
        Fri, 19 Feb 2021 12:46:00 +0000 (GMT)
From:   SelvaKumar S <selvakuma.s1@samsung.com>
To:     linux-nvme@lists.infradead.org
Cc:     kbusch@kernel.org, axboe@kernel.dk, damien.lemoal@wdc.com,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        snitzer@redhat.com, selvajove@gmail.com, joshiiitr@gmail.com,
        nj.shetty@samsung.com, joshi.k@samsung.com,
        javier.gonz@samsung.com, kch@kernel.org,
        linux-fsdevel@vger.kernel.org,
        SelvaKumar S <selvakuma.s1@samsung.com>
Subject: [RFC PATCH v5 2/4] block: add simple copy support
Date:   Fri, 19 Feb 2021 18:15:15 +0530
Message-Id: <20210219124517.79359-3-selvakuma.s1@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219124517.79359-1-selvakuma.s1@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTVwDGPfdebm+7lF1alh3ZnKYTMiAWXLU72QbsyS7R7OGDPXSDqndA
        Rh9pYaibsWEDh6NYO1i1OHAdIQJKQ8dqgXYjReJKsgmo7RRryuwwCBQyNhUJ22hvzfzvO98j
        v5yTQ+GiybgkqkRVxmpVilIJKSAcA6lp6/TKzMJMQ6sYdQSOkKjq0G0MucONcaitYxBDN67N
        89DgvzMkujAzgCGTxweQy15PIPfVdORyewl0sfcEiZpb/+Ahx2Izji7VW3HUOTVLoOCsn4em
        7npJVN31N3hBzPRYAjzmwvUugrn4Szljb68hme9bDjJ9V/QkM/vjZZKp624HzLz9CeZQ/5fY
        m4L3BM/vYUtLPma1GdmFguLavmFS81MP2Ds55yf1oOkYOAz4FKQ3wLbfvoo7DASUiO4D8M6J
        dpI7/Amg6dRYLLkNYE3VNeL+xNPVE52LaDeAv16Wc6V5AM3/WKMBSa+DvhZ7dJBIS+CSrZKI
        lHDaiEOD/xs8EojpZ+HPV2ewiCboZGheuBn1hXQWdBosJEdbDY+P3uFFNJ/Oho5pX6yTAL3H
        Q1EAvtz57IdGPAKA9F8UNHsXMW78ChwMXYppMbx1vpvH6SQ4H3bHABVwoubrWEcPYN1sBadz
        4IhradmnlgGp0NabwdmrYMNQJ8Zx46FhMRSbCqGzKRStQzoFDp2Vc/bjcG6gN0ZioP+6keAe
        6yiAp47eIIxgjeWB61geuI7lf/JJgLeDlaxGpyxidRs1MhVbIdUplLpyVZF0t1ppB9HfmLbJ
        CX4Pzkk9AKOAB0AKlyQKz96UFoqEexT79rNadYG2vJTVecBjFCF5VOjMDBaI6CJFGfsRy2pY
        7f0Uo/hJeux03mSj8xFFx5Gs17y3KAco3nBG9gEiz51faHsGZgkqHdM7Dsj6noTf7tydVJVb
        a1OM8tnWRPMnvgbH2hVWw6eWMss7KfKQMLX/3I6UanWuWKXJ25+jdslstv7QrntB2jpUJaV0
        JqOsvzMgCoxM+1/9biM4yGwuSxAGr/BrTc7q1xvceVNO5bhvu3Vvd/rwlu43JozKrW55cUuq
        8WTDopmID4+ued8/vBRelf6ievqt3LpA6DnBu8nWp+8WtK3VrqjMt30xVv/hU0vGfJPic7jl
        tHDi4Zf3jbTszFxZMx4fzm7C721OWP9Sc8nCOCkvsW97+yHXWD5JHUjOWL0rR0LoihXr03Ct
        TvEfzxR6JvwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsWy7bCSvC73Zv0Eg8b5mhar7/azWbS2f2Oy
        2PtuNqvFytVHmSwe3/nMbnH0/1s2i/NvDzNZTDp0jdFiz6YpLBZ7b2lb7Nl7ksXi8q45bBbz
        lz1lt9j2ez6zxZUpi5gt1r1+z2Lx4P11dovXP06yWbRt/MroIOyxc9Zddo/z9zayeFw+W+qx
        aVUnm8fmJfUeu282sHm833eVzaNvyypGj8+b5DzaD3QzBXBFcdmkpOZklqUW6dslcGX07L7A
        VrB/J2PFyw/X2RoY581g7GLk5JAQMJE4tHEnkM3FISSwm1Fid/9kZoiEjMTau51sELawxMp/
        z9khij4yShzffQCsm01AV+Lakk0sILaIgJLE3/VNYDazwDJmiUczFUFsYQEriRO33jKB2CwC
        qhLTfz4HW8ArYCuxo3cW1AJ5iZmXvrOD2JwCdhLb3lwDqxECqvnwfRobRL2gxMmZT4DmcwDN
        V5dYP08IYpW8RPPW2cwTGAVnIamahVA1C0nVAkbmVYySqQXFuem5xYYFhnmp5XrFibnFpXnp
        esn5uZsYwbGqpbmDcfuqD3qHGJk4GA8xSnAwK4nwbn+ulyDEm5JYWZValB9fVJqTWnyIUZqD
        RUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QDU9HKsJTbKTENM3rdpoe9mFtXrLiT1YbpBUvu
        OVFGxyOSGcuPSE+8F3VKeVqYy4/Syb1iqe51AYte/rFh+yDP8YKNS2/eqkNP9bKjXoju8pz0
        6NzV19/OvJ3ZIbffqjT2ed7HAw0KXo+rd0058mHlwcbeG+eNzqQHrojPOtz7eJNl/qH99o27
        FWbLnFNkvHD3mGryghfSgXJZCzazzi108qtvtVFoX/5RVG/6g2sC2Wr/1Jx8uYx+xSTuZ93S
        0LlT8La7ZHxXRZA/x/Nwh38VP/TeHbezW7ZufoOH2Cmhu6Fbt1hvYZ3x9unvAyvfHLr/3+DL
        faFr/x69qhbRNVj/8Upd13qnhJezbjkq/Srt/a/EUpyRaKjFXFScCADnVkOPRAMAAA==
X-CMS-MailID: 20210219124603epcas5p33add0f2c1781b2a4d71bf30c9e1ac647
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210219124603epcas5p33add0f2c1781b2a4d71bf30c9e1ac647
References: <20210219124517.79359-1-selvakuma.s1@samsung.com>
        <CGME20210219124603epcas5p33add0f2c1781b2a4d71bf30c9e1ac647@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add new BLKCOPY ioctl that offloads copying of one or more sources
ranges to a destination in the device. Accepts a 'copy_range' structure
that contains destination (in sectors), no of sources and pointer to the
array of source ranges. Each source range is represented by 'range_entry'
that contains start and length of source ranges (in sectors).

Introduce REQ_OP_COPY, a no-merge copy offload operation. Create
bio with control information as payload and submit to the device.
REQ_OP_COPY(19) is a write op and takes zone_write_lock when submitted
to zoned device.

If the device doesn't support copy or copy offload is disabled, then
copy operation is emulated by default. However, the copy-emulation is an
opt-in feature. Caller can choose not to use the copy-emulation by
specifying a flag 'BLKDEV_COPY_NOEMULATION'.

Copy-emulation is implemented by allocating memory of total copy size.
The source ranges are read into memory by chaining bio for each source
ranges and submitting them async and the last bio waits for completion.
After data is read, it is written to the destination.

bio_map_kern() is used to allocate bio and add pages of copy buffer to
bio. As bio->bi_private and bio->bi_end_io are needed for chaining the
bio and gets over-written, invalidate_kernel_vmap_range() for read is
called in the caller.

Introduce queue limits for simple copy and other helper functions.
Add device limits as sysfs entries.
	- copy_offload
	- max_copy_sectors
	- max_copy_ranges_sectors
	- max_copy_nr_ranges

copy_offload(= 0) is disabled by default. This needs to be enabled if
copy-offload needs to be used.
max_copy_sectors = 0 indicates the device doesn't support native copy.

Native copy offload is not supported for stacked devices and is done via
copy emulation.

Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Javier González <javier.gonz@samsung.com>
Signed-off-by: Chaitanya Kulkarni <kch@kernel.org>
---
 block/blk-core.c          | 102 ++++++++++++++++--
 block/blk-lib.c           | 222 ++++++++++++++++++++++++++++++++++++++
 block/blk-merge.c         |   2 +
 block/blk-settings.c      |  10 ++
 block/blk-sysfs.c         |  47 ++++++++
 block/blk-zoned.c         |   1 +
 block/bounce.c            |   1 +
 block/ioctl.c             |  33 ++++++
 include/linux/bio.h       |   1 +
 include/linux/blk_types.h |  14 +++
 include/linux/blkdev.h    |  15 +++
 include/uapi/linux/fs.h   |  13 +++
 12 files changed, 453 insertions(+), 8 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 7663a9b94b80..23e646e5ae43 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -720,6 +720,17 @@ static noinline int should_fail_bio(struct bio *bio)
 }
 ALLOW_ERROR_INJECTION(should_fail_bio, ERRNO);
 
+static inline int bio_check_copy_eod(struct bio *bio, sector_t start,
+		sector_t nr_sectors, sector_t max_sect)
+{
+	if (nr_sectors && max_sect &&
+	    (nr_sectors > max_sect || start > max_sect - nr_sectors)) {
+		handle_bad_sector(bio, max_sect);
+		return -EIO;
+	}
+	return 0;
+}
+
 /*
  * Check whether this bio extends beyond the end of the device or partition.
  * This may well happen - the kernel calls bread() without checking the size of
@@ -738,6 +749,75 @@ static inline int bio_check_eod(struct bio *bio, sector_t maxsector)
 	return 0;
 }
 
+/*
+ * Check for copy limits and remap source ranges if needed.
+ */
+static int blk_check_copy(struct bio *bio)
+{
+	struct blk_copy_payload *payload = bio_data(bio);
+	struct request_queue *q = bio->bi_disk->queue;
+	sector_t max_sect, start_sect, copy_size = 0;
+	sector_t src_max_sect, src_start_sect;
+	struct block_device *bd_part;
+	int i, ret = -EIO;
+
+	rcu_read_lock();
+
+	bd_part = __disk_get_part(bio->bi_disk, bio->bi_partno);
+	if (unlikely(!bd_part)) {
+		rcu_read_unlock();
+		goto out;
+	}
+
+	max_sect =  bdev_nr_sectors(bd_part);
+	start_sect = bd_part->bd_start_sect;
+
+	src_max_sect = bdev_nr_sectors(payload->src_bdev);
+	src_start_sect = payload->src_bdev->bd_start_sect;
+
+	if (unlikely(should_fail_request(bd_part, bio->bi_iter.bi_size)))
+		goto out;
+
+	if (unlikely(bio_check_ro(bio, bd_part)))
+		goto out;
+
+	rcu_read_unlock();
+
+	/* cannot handle copy crossing nr_ranges limit */
+	if (payload->copy_nr_ranges > q->limits.max_copy_nr_ranges)
+		goto out;
+
+	for (i = 0; i < payload->copy_nr_ranges; i++) {
+		ret = bio_check_copy_eod(bio, payload->range[i].src,
+				payload->range[i].len, src_max_sect);
+		if (unlikely(ret))
+			goto out;
+
+		/* single source range length limit */
+		if (payload->range[i].len > q->limits.max_copy_range_sectors)
+			goto out;
+
+		payload->range[i].src += src_start_sect;
+		copy_size += payload->range[i].len;
+	}
+
+	/* check if copy length crosses eod */
+	ret = bio_check_copy_eod(bio, bio->bi_iter.bi_sector,
+				copy_size, max_sect);
+	if (unlikely(ret))
+		goto out;
+
+	/* cannot handle copy more than copy limits */
+	if (copy_size > q->limits.max_copy_sectors)
+		goto out;
+
+	bio->bi_iter.bi_sector += start_sect;
+	bio->bi_partno = 0;
+	ret = 0;
+out:
+	return ret;
+}
+
 /*
  * Remap block n of partition p to block n+start(p) of the disk.
  */
@@ -827,14 +907,16 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 	if (should_fail_bio(bio))
 		goto end_io;
 
-	if (bio->bi_partno) {
-		if (unlikely(blk_partition_remap(bio)))
-			goto end_io;
-	} else {
-		if (unlikely(bio_check_ro(bio, bio->bi_disk->part0)))
-			goto end_io;
-		if (unlikely(bio_check_eod(bio, get_capacity(bio->bi_disk))))
-			goto end_io;
+	if (likely(!op_is_copy(bio->bi_opf))) {
+		if (bio->bi_partno) {
+			if (unlikely(blk_partition_remap(bio)))
+				goto end_io;
+		} else {
+			if (unlikely(bio_check_ro(bio, bio->bi_disk->part0)))
+				goto end_io;
+			if (unlikely(bio_check_eod(bio, get_capacity(bio->bi_disk))))
+				goto end_io;
+		}
 	}
 
 	/*
@@ -858,6 +940,10 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 		if (!blk_queue_discard(q))
 			goto not_supported;
 		break;
+	case REQ_OP_COPY:
+		if (unlikely(blk_check_copy(bio)))
+			goto end_io;
+		break;
 	case REQ_OP_SECURE_ERASE:
 		if (!blk_queue_secure_erase(q))
 			goto not_supported;
diff --git a/block/blk-lib.c b/block/blk-lib.c
index 752f9c722062..97ba58d8d9a1 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -150,6 +150,228 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 }
 EXPORT_SYMBOL(blkdev_issue_discard);
 
+int blk_copy_offload(struct block_device *dest_bdev, struct blk_copy_payload *payload,
+		sector_t dest, gfp_t gfp_mask)
+{
+	struct request_queue *q = bdev_get_queue(dest_bdev);
+	struct bio *bio;
+	int ret, payload_size;
+
+	payload_size = struct_size(payload, range, payload->copy_nr_ranges);
+	bio = bio_map_kern(q, payload, payload_size, gfp_mask);
+	if (IS_ERR(bio)) {
+		ret = PTR_ERR(bio);
+		goto err;
+	}
+
+	bio->bi_iter.bi_sector = dest;
+	bio->bi_opf = REQ_OP_COPY | REQ_NOMERGE;
+	bio_set_dev(bio, dest_bdev);
+
+	ret = submit_bio_wait(bio);
+err:
+	bio_put(bio);
+	return ret;
+}
+
+int blk_read_to_buf(struct block_device *src_bdev, struct blk_copy_payload *payload,
+		gfp_t gfp_mask, sector_t copy_size, void **buf_p)
+{
+	struct request_queue *q = bdev_get_queue(src_bdev);
+	struct bio *bio, *parent = NULL;
+	void *buf = NULL;
+	int copy_len = copy_size << SECTOR_SHIFT;
+	int i, nr_srcs, ret, cur_size, t_len = 0;
+	bool is_vmalloc;
+
+	nr_srcs = payload->copy_nr_ranges;
+
+	buf = kvmalloc(copy_len, gfp_mask);
+	if (!buf)
+		return -ENOMEM;
+	is_vmalloc = is_vmalloc_addr(buf);
+
+	for (i = 0; i < nr_srcs; i++) {
+		cur_size = payload->range[i].len << SECTOR_SHIFT;
+
+		bio = bio_map_kern(q, buf + t_len, cur_size, gfp_mask);
+		if (IS_ERR(bio)) {
+			ret = PTR_ERR(bio);
+			goto out;
+		}
+
+		bio->bi_iter.bi_sector = payload->range[i].src;
+		bio->bi_opf = REQ_OP_READ;
+		bio_set_dev(bio, src_bdev);
+		bio->bi_end_io = NULL;
+		bio->bi_private = NULL;
+
+		if (parent) {
+			bio_chain(parent, bio);
+			submit_bio(parent);
+		}
+
+		parent = bio;
+		t_len += cur_size;
+	}
+
+	ret = submit_bio_wait(bio);
+	bio_put(bio);
+	if (is_vmalloc)
+		invalidate_kernel_vmap_range(buf, copy_len);
+	if (ret)
+		goto out;
+
+	*buf_p = buf;
+	return 0;
+out:
+	kvfree(buf);
+	return ret;
+}
+
+int blk_write_from_buf(struct block_device *dest_bdev, void *buf, sector_t dest,
+		sector_t copy_size, gfp_t gfp_mask)
+{
+	struct request_queue *q = bdev_get_queue(dest_bdev);
+	struct bio *bio;
+	int ret, copy_len = copy_size << SECTOR_SHIFT;
+
+	bio = bio_map_kern(q, buf, copy_len, gfp_mask);
+	if (IS_ERR(bio)) {
+		ret = PTR_ERR(bio);
+		goto out;
+	}
+	bio_set_dev(bio, dest_bdev);
+	bio->bi_opf = REQ_OP_WRITE;
+	bio->bi_iter.bi_sector = dest;
+
+	bio->bi_end_io = NULL;
+	ret = submit_bio_wait(bio);
+	bio_put(bio);
+out:
+	return ret;
+}
+
+int blk_prepare_payload(struct block_device *src_bdev, int nr_srcs, struct range_entry *rlist,
+		gfp_t gfp_mask, struct blk_copy_payload **payload_p, sector_t *copy_size)
+{
+
+	struct request_queue *q = bdev_get_queue(src_bdev);
+	struct blk_copy_payload *payload;
+	sector_t bs_mask, total_len = 0;
+	int i, ret, payload_size;
+
+	if (!q)
+		return -ENXIO;
+
+	if (!nr_srcs)
+		return -EINVAL;
+
+	if (bdev_read_only(src_bdev))
+		return -EPERM;
+
+	bs_mask = (bdev_logical_block_size(src_bdev) >> 9) - 1;
+
+	payload_size = struct_size(payload, range, nr_srcs);
+	payload = kmalloc(payload_size, gfp_mask);
+	if (!payload)
+		return -ENOMEM;
+
+	for (i = 0; i < nr_srcs; i++) {
+		if (rlist[i].src & bs_mask || rlist[i].len & bs_mask) {
+			ret = -EINVAL;
+			goto err;
+		}
+
+		payload->range[i].src = rlist[i].src;
+		payload->range[i].len = rlist[i].len;
+
+		total_len += rlist[i].len;
+	}
+
+	payload->copy_nr_ranges = i;
+	payload->src_bdev = src_bdev;
+	*copy_size = total_len;
+
+	*payload_p = payload;
+	return 0;
+err:
+	kfree(payload);
+	return ret;
+}
+
+int blk_copy_emulate(struct block_device *src_bdev, struct blk_copy_payload *payload,
+			struct block_device *dest_bdev, sector_t dest,
+			sector_t copy_size, gfp_t gfp_mask)
+{
+	void *buf = NULL;
+	int ret;
+
+	ret = blk_read_to_buf(src_bdev, payload, gfp_mask, copy_size, &buf);
+	if (ret)
+		goto out;
+
+	ret = blk_write_from_buf(dest_bdev, buf, dest, copy_size, gfp_mask);
+	if (buf)
+		kvfree(buf);
+out:
+	return ret;
+}
+
+/**
+ * blkdev_issue_copy - queue a copy
+ * @src_bdev:	source block device
+ * @nr_srcs:	number of source ranges to copy
+ * @rlist:	array of source ranges in sector
+ * @dest_bdev:	destination block device
+ * @dest:	destination in sector
+ * @gfp_mask:   memory allocation flags (for bio_alloc)
+ * @flags:	BLKDEV_COPY_* flags to control behaviour
+ *
+ * Description:
+ *	Copy array of source ranges from source block device to
+ *	destination block devcie. All source must belong to same bdev and
+ *	length of a source range cannot be zero.
+ */
+
+int blkdev_issue_copy(struct block_device *src_bdev, int nr_srcs,
+		struct range_entry *src_rlist, struct block_device *dest_bdev,
+		sector_t dest, gfp_t gfp_mask, int flags)
+{
+	struct request_queue *q = bdev_get_queue(src_bdev);
+	struct request_queue *dest_q = bdev_get_queue(dest_bdev);
+	struct blk_copy_payload *payload;
+	sector_t bs_mask, copy_size;
+	int ret;
+
+	ret = blk_prepare_payload(src_bdev, nr_srcs, src_rlist, gfp_mask,
+			&payload, &copy_size);
+	if (ret)
+		return ret;
+
+	bs_mask = (bdev_logical_block_size(dest_bdev) >> 9) - 1;
+	if (dest & bs_mask) {
+		return -EINVAL;
+		goto out;
+	}
+
+	if (q == dest_q && q->limits.copy_offload) {
+		ret = blk_copy_offload(src_bdev, payload, dest, gfp_mask);
+		if (ret)
+			goto out;
+	} else if (flags & BLKDEV_COPY_NOEMULATION) {
+		ret = -EIO;
+		goto out;
+	} else
+		ret = blk_copy_emulate(src_bdev, payload, dest_bdev, dest,
+				copy_size, gfp_mask);
+
+out:
+	kvfree(payload);
+	return ret;
+}
+EXPORT_SYMBOL(blkdev_issue_copy);
+
 /**
  * __blkdev_issue_write_same - generate number of bios with same page
  * @bdev:	target blockdev
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 808768f6b174..4e04f24e13c1 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -309,6 +309,8 @@ void __blk_queue_split(struct bio **bio, unsigned int *nr_segs)
 	struct bio *split = NULL;
 
 	switch (bio_op(*bio)) {
+	case REQ_OP_COPY:
+			break;
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
 		split = blk_bio_discard_split(q, *bio, &q->bio_split, nr_segs);
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 43990b1d148b..93c15ba45a69 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -60,6 +60,10 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->io_opt = 0;
 	lim->misaligned = 0;
 	lim->zoned = BLK_ZONED_NONE;
+	lim->copy_offload = 0;
+	lim->max_copy_sectors = 0;
+	lim->max_copy_nr_ranges = 0;
+	lim->max_copy_range_sectors = 0;
 }
 EXPORT_SYMBOL(blk_set_default_limits);
 
@@ -565,6 +569,12 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	if (b->chunk_sectors)
 		t->chunk_sectors = gcd(t->chunk_sectors, b->chunk_sectors);
 
+	/* simple copy not supported in stacked devices */
+	t->copy_offload = 0;
+	t->max_copy_sectors = 0;
+	t->max_copy_range_sectors = 0;
+	t->max_copy_nr_ranges = 0;
+
 	/* Physical block size a multiple of the logical block size? */
 	if (t->physical_block_size & (t->logical_block_size - 1)) {
 		t->physical_block_size = t->logical_block_size;
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index b513f1683af0..625a72541263 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -166,6 +166,44 @@ static ssize_t queue_discard_granularity_show(struct request_queue *q, char *pag
 	return queue_var_show(q->limits.discard_granularity, page);
 }
 
+static ssize_t queue_copy_offload_show(struct request_queue *q, char *page)
+{
+	return queue_var_show(q->limits.copy_offload, page);
+}
+
+static ssize_t queue_copy_offload_store(struct request_queue *q,
+				       const char *page, size_t count)
+{
+	unsigned long copy_offload;
+	ssize_t ret = queue_var_store(&copy_offload, page, count);
+
+	if (ret < 0)
+		return ret;
+
+	if (copy_offload && q->limits.max_copy_sectors == 0)
+		return -EINVAL;
+
+	q->limits.copy_offload = copy_offload;
+	return ret;
+}
+
+static ssize_t queue_max_copy_sectors_show(struct request_queue *q, char *page)
+{
+	return queue_var_show(q->limits.max_copy_sectors, page);
+}
+
+static ssize_t queue_max_copy_range_sectors_show(struct request_queue *q,
+		char *page)
+{
+	return queue_var_show(q->limits.max_copy_range_sectors, page);
+}
+
+static ssize_t queue_max_copy_nr_ranges_show(struct request_queue *q,
+		char *page)
+{
+	return queue_var_show(q->limits.max_copy_nr_ranges, page);
+}
+
 static ssize_t queue_discard_max_hw_show(struct request_queue *q, char *page)
 {
 
@@ -591,6 +629,11 @@ QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
 QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
 QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
 
+QUEUE_RW_ENTRY(queue_copy_offload, "copy_offload");
+QUEUE_RO_ENTRY(queue_max_copy_sectors, "max_copy_sectors");
+QUEUE_RO_ENTRY(queue_max_copy_range_sectors, "max_copy_range_sectors");
+QUEUE_RO_ENTRY(queue_max_copy_nr_ranges, "max_copy_nr_ranges");
+
 QUEUE_RW_ENTRY(queue_nomerges, "nomerges");
 QUEUE_RW_ENTRY(queue_rq_affinity, "rq_affinity");
 QUEUE_RW_ENTRY(queue_poll, "io_poll");
@@ -636,6 +679,10 @@ static struct attribute *queue_attrs[] = {
 	&queue_discard_max_entry.attr,
 	&queue_discard_max_hw_entry.attr,
 	&queue_discard_zeroes_data_entry.attr,
+	&queue_copy_offload_entry.attr,
+	&queue_max_copy_sectors_entry.attr,
+	&queue_max_copy_range_sectors_entry.attr,
+	&queue_max_copy_nr_ranges_entry.attr,
 	&queue_write_same_max_entry.attr,
 	&queue_write_zeroes_max_entry.attr,
 	&queue_zone_append_max_entry.attr,
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 7a68b6e4300c..02069178d51e 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -75,6 +75,7 @@ bool blk_req_needs_zone_write_lock(struct request *rq)
 	case REQ_OP_WRITE_ZEROES:
 	case REQ_OP_WRITE_SAME:
 	case REQ_OP_WRITE:
+	case REQ_OP_COPY:
 		return blk_rq_zone_is_seq(rq);
 	default:
 		return false;
diff --git a/block/bounce.c b/block/bounce.c
index d3f51acd6e3b..5e052afe8691 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -254,6 +254,7 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
 	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
 
 	switch (bio_op(bio)) {
+	case REQ_OP_COPY:
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
 	case REQ_OP_WRITE_ZEROES:
diff --git a/block/ioctl.c b/block/ioctl.c
index d61d652078f4..0e52181657a4 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -133,6 +133,37 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 				    GFP_KERNEL, flags);
 }
 
+static int blk_ioctl_copy(struct block_device *bdev, fmode_t mode,
+		unsigned long arg, unsigned long flags)
+{
+	struct copy_range crange;
+	struct range_entry *rlist;
+	int ret;
+
+	if (!(mode & FMODE_WRITE))
+		return -EBADF;
+
+	if (copy_from_user(&crange, (void __user *)arg, sizeof(crange)))
+		return -EFAULT;
+
+	rlist = kmalloc_array(crange.nr_range, sizeof(*rlist),
+			GFP_KERNEL);
+	if (!rlist)
+		return -ENOMEM;
+
+	if (copy_from_user(rlist, (void __user *)crange.range_list,
+				sizeof(*rlist) * crange.nr_range)) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	ret = blkdev_issue_copy(bdev, crange.nr_range, rlist, bdev, crange.dest,
+			GFP_KERNEL, flags);
+out:
+	kfree(rlist);
+	return ret;
+}
+
 static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
 		unsigned long arg)
 {
@@ -458,6 +489,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
 	case BLKSECDISCARD:
 		return blk_ioctl_discard(bdev, mode, arg,
 				BLKDEV_DISCARD_SECURE);
+	case BLKCOPY:
+		return blk_ioctl_copy(bdev, mode, arg, 0);
 	case BLKZEROOUT:
 		return blk_ioctl_zeroout(bdev, mode, arg);
 	case BLKREPORTZONE:
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 1edda614f7ce..164313bdfb35 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -71,6 +71,7 @@ static inline bool bio_has_data(struct bio *bio)
 static inline bool bio_no_advance_iter(const struct bio *bio)
 {
 	return bio_op(bio) == REQ_OP_DISCARD ||
+	       bio_op(bio) == REQ_OP_COPY ||
 	       bio_op(bio) == REQ_OP_SECURE_ERASE ||
 	       bio_op(bio) == REQ_OP_WRITE_SAME ||
 	       bio_op(bio) == REQ_OP_WRITE_ZEROES;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 866f74261b3b..5a35c02ac0a8 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -380,6 +380,8 @@ enum req_opf {
 	REQ_OP_ZONE_RESET	= 15,
 	/* reset all the zone present on the device */
 	REQ_OP_ZONE_RESET_ALL	= 17,
+	/* copy ranges within device */
+	REQ_OP_COPY		= 19,
 
 	/* SCSI passthrough using struct scsi_request */
 	REQ_OP_SCSI_IN		= 32,
@@ -506,6 +508,11 @@ static inline bool op_is_discard(unsigned int op)
 	return (op & REQ_OP_MASK) == REQ_OP_DISCARD;
 }
 
+static inline bool op_is_copy(unsigned int op)
+{
+	return (op & REQ_OP_MASK) == REQ_OP_COPY;
+}
+
 /*
  * Check if a bio or request operation is a zone management operation, with
  * the exception of REQ_OP_ZONE_RESET_ALL which is treated as a special case
@@ -565,4 +572,11 @@ struct blk_rq_stat {
 	u64 batch;
 };
 
+struct blk_copy_payload {
+	sector_t	dest;
+	int		copy_nr_ranges;
+	struct block_device *src_bdev;
+	struct	range_entry	range[];
+};
+
 #endif /* __LINUX_BLK_TYPES_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 699ace6b25ff..2bb4513d4bb8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -337,10 +337,14 @@ struct queue_limits {
 	unsigned int		max_zone_append_sectors;
 	unsigned int		discard_granularity;
 	unsigned int		discard_alignment;
+	unsigned int		copy_offload;
+	unsigned int		max_copy_sectors;
 
 	unsigned short		max_segments;
 	unsigned short		max_integrity_segments;
 	unsigned short		max_discard_segments;
+	unsigned short		max_copy_range_sectors;
+	unsigned short		max_copy_nr_ranges;
 
 	unsigned char		misaligned;
 	unsigned char		discard_misaligned;
@@ -621,6 +625,7 @@ struct request_queue {
 #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
+#define QUEUE_FLAG_SIMPLE_COPY	30	/* supports simple copy */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP) |		\
@@ -643,6 +648,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_io_stat(q)	test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
 #define blk_queue_add_random(q)	test_bit(QUEUE_FLAG_ADD_RANDOM, &(q)->queue_flags)
 #define blk_queue_discard(q)	test_bit(QUEUE_FLAG_DISCARD, &(q)->queue_flags)
+#define blk_queue_copy(q)	test_bit(QUEUE_FLAG_SIMPLE_COPY, &(q)->queue_flags)
 #define blk_queue_zone_resetall(q)	\
 	test_bit(QUEUE_FLAG_ZONE_RESETALL, &(q)->queue_flags)
 #define blk_queue_secure_erase(q) \
@@ -1069,6 +1075,9 @@ static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
 		return min(q->limits.max_discard_sectors,
 			   UINT_MAX >> SECTOR_SHIFT);
 
+	if (unlikely(op == REQ_OP_COPY))
+		return q->limits.max_copy_sectors;
+
 	if (unlikely(op == REQ_OP_WRITE_SAME))
 		return q->limits.max_write_same_sectors;
 
@@ -1343,6 +1352,12 @@ extern int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, int flags,
 		struct bio **biop);
 
+#define BLKDEV_COPY_NOEMULATION	(1 << 0)	/* do not emulate if copy offload not supported */
+
+extern int blkdev_issue_copy(struct block_device *src_bdev, int nr_srcs,
+		struct range_entry *src_rlist, struct block_device *dest_bdev,
+		sector_t dest, gfp_t gfp_mask, int flags);
+
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
 
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index f44eb0a04afd..5cadb176317a 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -64,6 +64,18 @@ struct fstrim_range {
 	__u64 minlen;
 };
 
+struct range_entry {
+	__u64 src;
+	__u64 len;
+};
+
+struct copy_range {
+	__u64 dest;
+	__u64 nr_range;
+	__u64 range_list;
+	__u64 rsvd;
+};
+
 /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
 #define FILE_DEDUPE_RANGE_SAME		0
 #define FILE_DEDUPE_RANGE_DIFFERS	1
@@ -184,6 +196,7 @@ struct fsxattr {
 #define BLKSECDISCARD _IO(0x12,125)
 #define BLKROTATIONAL _IO(0x12,126)
 #define BLKZEROOUT _IO(0x12,127)
+#define BLKCOPY _IOWR(0x12, 128, struct copy_range)
 /*
  * A jump here: 130-131 are reserved for zoned block devices
  * (see uapi/linux/blkzoned.h)
-- 
2.25.1

