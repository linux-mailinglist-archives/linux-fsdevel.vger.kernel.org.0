Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAE53EEBAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 13:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239752AbhHQL3n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 07:29:43 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:41834 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbhHQL3l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 07:29:41 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210817112907epoutp014510d12b3138695e3c266ae394d6be89~cFIne3E0g2619926199epoutp019
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 11:29:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210817112907epoutp014510d12b3138695e3c266ae394d6be89~cFIne3E0g2619926199epoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1629199747;
        bh=bJCtbBa6L0JIXNd1NmoxdOdob35u4fPJVTOVrtL8lKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LLGmUsztrjZH9oTXXVa0czwhxbbU2VsOqT8yo6fHSwl5XWjYP4IywljFRyekVPdaD
         cde4XeVoP0P5SMKyHVA6qj3NyKbf22cEGbJrSPXjMFxkPF4yZPcVQqSTvJNc/H4Qrp
         ooicdRtv9w39DCrewfzfQObcUsTvpyJu102DvVNs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210817112906epcas5p1a9aafa18c5d6e13a6ce843903ffa7d0f~cFIm3BqwY0478504785epcas5p18;
        Tue, 17 Aug 2021 11:29:06 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4GpphF42j2z4x9Pt; Tue, 17 Aug
        2021 11:29:01 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.7B.09595.D7D9B116; Tue, 17 Aug 2021 20:29:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20210817101758epcas5p1ec353b3838d64654e69488229256d9eb~cEKflp_Yi1790617906epcas5p1I;
        Tue, 17 Aug 2021 10:17:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210817101758epsmtrp27b65d2a71ea6a8093a18f110e2c8b214~cEKfkTALz2821228212epsmtrp2F;
        Tue, 17 Aug 2021 10:17:58 +0000 (GMT)
X-AuditID: b6c32a4a-eebff7000000257b-fe-611b9d7df523
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.5E.08394.6DC8B116; Tue, 17 Aug 2021 19:17:58 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210817101754epsmtip2241477dc9632667b7a94aa0f84b4d014~cEKbzz4q70132301323epsmtip2e;
        Tue, 17 Aug 2021 10:17:54 +0000 (GMT)
From:   SelvaKumar S <selvakuma.s1@samsung.com>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc:     linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        kbusch@kernel.org, axboe@kernel.dk, damien.lemoal@wdc.com,
        asml.silence@gmail.com, johannes.thumshirn@wdc.com, hch@lst.de,
        willy@infradead.org, kch@kernel.org, martin.petersen@oracle.com,
        mpatocka@redhat.com, bvanassche@acm.org, djwong@kernel.org,
        snitzer@redhat.com, agk@redhat.com, selvajove@gmail.com,
        joshiiitr@gmail.com, nj.shetty@samsung.com,
        nitheshshetty@gmail.com, joshi.k@samsung.com,
        javier.gonz@samsung.com, SelvaKumar S <selvakuma.s1@samsung.com>
Subject: [PATCH 3/7] block: copy offload support infrastructure
Date:   Tue, 17 Aug 2021 15:44:19 +0530
Message-Id: <20210817101423.12367-4-selvakuma.s1@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210817101423.12367-1-selvakuma.s1@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTZxTnu/dye3FWSmXyDd1k3RgCFiiP8qE85sTlBowhI5Fg1HoD10Io
        bdMW2NRNDHEqTBClEF7DMB0K23gKCJQRWOWhogPBYGDTUDYfvBmgQ+ZaLm7+9zvn/M75fef3
        5VC4MIfnSMUrdaxGyShE5BqivsPVTfxl8UbGq3lpA6rsuYGjovJ6gCpGskiUO/0CRydPLWCo
        37QOGSYLrdHVCiOGRofneGg5/TcMGV9NkOjORAeGzrcPAtRSk0Og2sXTJDI8cEcthm4ClXw/
        xkMZ9xtJVNb5D4ayTw9gqNF0AqD6pRIc3cspxdHDqfs89Ox5N4m+rp4HaOl5EfnxJrr/Xjh9
        vWCER9decaP7byfRNeVnSLr20nG6eSiVpGfGHhD0VOsASWfWlQN6ruY9+lRbBhaxdl9CYBzL
        xLIaJ1YZo4qNV8qDROGRsp0yP6mXRCwJQP4iJyWTyAaJQndHiD+NV5jNEDklM4okcyqC0WpF
        nsGBGlWSjnWKU2l1QSJWHatQ+6o9tEyiNkkp91Cyum0SLy9vPzPxUELclOECqS46/nnByCKR
        Cm4eTgcUBQW+8GybTTpYQwkFzQBmnb/L44JZAMdf9pBcsADgcJoevO4Yuq7i8gYAq29P4Fww
        B2Bx67R1OrChSIEYDl6qISzYXhACr74ot7aQcEEPAfOmSnmWwnpz4emIAbNgQuAM/+r9ZQXz
        BUGwbyZtBUPBZpjft8izKNsIgmHTrDNHsYPd+aaV+biZknatcOURUFBpA/X6lyTXGwobFp+t
        zlkPn3bW8TjsCOcmDaucFPjHmdxVTiqAmVMpHA6Bv7YsYxZdXOAKK5s8ufS7UN/zE8bproNn
        l0yrrXzY+K0J4wz6CPY0SLn0Jjjd0bSqRMOBugFrzqtsAI11k8Q54FTwxjoFb6xT8L/yRYCX
        g3dYtTZRzmr91N5KNuW/P45RJdaAlfNwC2sEjx5Oe7QDjALtAFK4yJ7vQjkyQn4s88URVqOS
        aZIUrLYd+JntzsYd345Rme9LqZNJfAO8fKVSqW+Aj1QicuDv372REQrkjI5NYFk1q3ndh1E2
        jqmYd3x+8odbf5+fsQqc6HJocwmU8yuyHvOx7Xrr6Br95s+uVSffaarIay6sij7pT+CVIT8e
        1flFRR7bH83e2prctNBqvOsQOBuj6S2+uK/s8BPj8qEfrBpyt1yevmnb3DSxbXy571h78Ac+
        tRFHhg4YtdJw6Dva8+pAXhUdlSn7aodi1zdd/e//vFdsq1gQdb51qzbqxMHw3jSXivrM4Sjc
        J2yPj+fBR0JZ2YXLYmfXPsruRtuWYd2elFH5YyD8O84uQwbHvLTFjiWmqvnIZfs/TW3+iifi
        Pv+cnbapYXuFVq5r3UujVdXb9evGJgmq1fqT0isxkzs2DFq5d30nDB2P3HXURURo4xiJG67R
        Mv8CfPz2C6cEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02RfUgTcRzG+d1dd+dycU3LSyVtJaGmaS/4q1YriLgMoijslfKq0yQ319bM
        7G0hla4XTV21OVRCLGcvtOnybRXTLF8qUZutWkUplmXTrKymllOC/vvwPB94vvAlUUEz5ksm
        SA9wcimbKMR5mLlWGBBmO+vHRuR0ecFbjfUo1BvMAJY6MnF4se8XCk+e/oHAts5J0PIlbwIs
        KX2AwPevBgg4rH6NwAd/enH4tLcWgdlWG4A1xlwMmgbTcWh5EQprLA0YLCjuIuCZjgocXn04
        gsAL6c8QWNF5AkCzqwCF7blXUPjW2UHATz8bcHjq9ncAXT/1+HJ/pq19DVOpcxCM6VoI0/ZY
        yRgNGThjKjrOVNtVONPf9QJjnHef4cz5MgNgBozTmdP3zyDrPLfyRHu4xIRkTj53WSxvr9OS
        g8v0x1N0jkFMBZri1IAkaWoBba9MUgMeKaCqAX2yZ4hQA4/R3J++4cjAx9mLLhnpJsalfkBf
        ttaj7gKnwmhbkRFzsze1gm76akbcEkr1YPRrR/WY5EWJ6R6HBXEzRgXR357UjTGfWkq39qch
        4wsBtLZ1kHBf5EEto6u+Brljwahyr0ZDjOuT6QZt59gWOqqnleehWYDS/Vfp/qsKAWIA0ziZ
        QhIvUUTKIqXcwXAFK1EopfHhu5MkRjD28JDgCnDH0BduBQgJrIAmUaE3fzbpywr4e9hDqZw8
        aadcmcgprMCPxIQ+/BZ1w04BFc8e4PZxnIyT/2sR0sNXhbBqp3aosmll2vNVw9aIOKxJMuNy
        VnlN9EirUrjY73CH7V3gzVTdLGVjVPMSr1MJiWXbFpTnVc2vO1e19ocrdSToY8zvAhHJt9d/
        1AeXdNvDtWIXP1aOFZdlF52YED0xf/3w6kWH0eyg0ptvgpcKNkw17fIMcRbCHR5ldmHOfIFJ
        /HK4N9bnUstQ+sre8nlSVcH+mUjjwkhz8zGNMaawdY3/Et5G1YXAz/lYnGLwaXC3Zwv/d7LI
        9c4mz/igfxQqC9gSetC7Ej3ah96o2zTrCJiYabtTGiVarxXGRr8amLZITKTszxBpNJaI61Pm
        cOJV5zbbi73rBMX52wM/a9Q8XIgp9rKRIahcwf4FnFbyz18DAAA=
X-CMS-MailID: 20210817101758epcas5p1ec353b3838d64654e69488229256d9eb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210817101758epcas5p1ec353b3838d64654e69488229256d9eb
References: <20210817101423.12367-1-selvakuma.s1@samsung.com>
        <CGME20210817101758epcas5p1ec353b3838d64654e69488229256d9eb@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Nitesh Shetty <nj.shetty@samsung.com>

Introduce REQ_OP_COPY, a no-merge copy offload operation. Create
bio with control information as payload and submit to the device.
Larger copy operation may be divided if necessary by looking at device
limits. REQ_OP_COPY(19) is a write op and takes zone_write_lock when
submitted to zoned device.
Native copy offload is not supported for stacked devices.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
---
 block/blk-core.c          |  84 ++++++++++++-
 block/blk-lib.c           | 252 ++++++++++++++++++++++++++++++++++++++
 block/blk-zoned.c         |   1 +
 block/bounce.c            |   1 +
 include/linux/bio.h       |   1 +
 include/linux/blk_types.h |  20 +++
 include/linux/blkdev.h    |  13 ++
 include/uapi/linux/fs.h   |  12 ++
 8 files changed, 378 insertions(+), 6 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d2722ecd4d9b..541b1561b4af 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -704,6 +704,17 @@ static noinline int should_fail_bio(struct bio *bio)
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
@@ -723,6 +734,61 @@ static inline int bio_check_eod(struct bio *bio)
 	return 0;
 }
 
+/*
+ * check for eod limits and remap ranges if needed
+ */
+static int blk_check_copy(struct bio *bio)
+{
+	struct blk_copy_payload *payload = bio_data(bio);
+	sector_t dst_max_sect, dst_start_sect, copy_size = 0;
+	sector_t src_max_sect, src_start_sect;
+	struct block_device *bd_part;
+	int i, ret = -EIO;
+
+	rcu_read_lock();
+
+	bd_part = bio->bi_bdev;
+	if (unlikely(!bd_part))
+		goto err;
+
+	dst_max_sect =  bdev_nr_sectors(bd_part);
+	dst_start_sect = bd_part->bd_start_sect;
+
+	src_max_sect = bdev_nr_sectors(payload->src_bdev);
+	src_start_sect = payload->src_bdev->bd_start_sect;
+
+	if (unlikely(should_fail_request(bd_part, bio->bi_iter.bi_size)))
+		goto err;
+
+	if (unlikely(bio_check_ro(bio)))
+		goto err;
+
+	rcu_read_unlock();
+
+	for (i = 0; i < payload->copy_nr_ranges; i++) {
+		ret = bio_check_copy_eod(bio, payload->range[i].src,
+				payload->range[i].len, src_max_sect);
+		if (unlikely(ret))
+			goto out;
+
+		payload->range[i].src += src_start_sect;
+		copy_size += payload->range[i].len;
+	}
+
+	/* check if copy length crosses eod */
+	ret = bio_check_copy_eod(bio, bio->bi_iter.bi_sector,
+				copy_size, dst_max_sect);
+	if (unlikely(ret))
+		goto out;
+
+	bio->bi_iter.bi_sector += dst_start_sect;
+	return 0;
+err:
+	rcu_read_unlock();
+out:
+	return ret;
+}
+
 /*
  * Remap block n of partition p to block n+start(p) of the disk.
  */
@@ -799,13 +865,15 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 
 	if (should_fail_bio(bio))
 		goto end_io;
-	if (unlikely(bio_check_ro(bio)))
-		goto end_io;
-	if (!bio_flagged(bio, BIO_REMAPPED)) {
-		if (unlikely(bio_check_eod(bio)))
-			goto end_io;
-		if (bdev->bd_partno && unlikely(blk_partition_remap(bio)))
+	if (likely(!op_is_copy(bio->bi_opf))) {
+		if (unlikely(bio_check_ro(bio)))
 			goto end_io;
+		if (!bio_flagged(bio, BIO_REMAPPED)) {
+			if (unlikely(bio_check_eod(bio)))
+				goto end_io;
+			if (bdev->bd_partno && unlikely(blk_partition_remap(bio)))
+				goto end_io;
+		}
 	}
 
 	/*
@@ -829,6 +897,10 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
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
index 9f09beadcbe3..7fee0ae95c44 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -151,6 +151,258 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 }
 EXPORT_SYMBOL(blkdev_issue_discard);
 
+/*
+ * Wait on and process all in-flight BIOs.  This must only be called once
+ * all bios have been issued so that the refcount can only decrease.
+ * This just waits for all bios to make it through cio_bio_end_io.  IO
+ * errors are propagated through cio->io_error.
+ */
+static int cio_await_completion(struct cio *cio)
+{
+	int ret = 0;
+
+	while (atomic_read(&cio->refcount)) {
+		cio->waiter = current;
+		__set_current_state(TASK_UNINTERRUPTIBLE);
+		blk_io_schedule();
+		/* wake up sets us TASK_RUNNING */
+		cio->waiter = NULL;
+		ret = cio->io_err;
+	}
+	kvfree(cio);
+
+	return ret;
+}
+
+/*
+ * The BIO completion handler simply decrements refcount.
+ * Also wake up process, if this is the last bio to be completed.
+ *
+ * During I/O bi_private points at the cio.
+ */
+static void cio_bio_end_io(struct bio *bio)
+{
+	struct cio *cio = bio->bi_private;
+
+	if (bio->bi_status)
+		cio->io_err = bio->bi_status;
+	kvfree(page_address(bio_first_bvec_all(bio)->bv_page) +
+			bio_first_bvec_all(bio)->bv_offset);
+	bio_put(bio);
+
+	if (atomic_dec_and_test(&cio->refcount) && cio->waiter)
+		wake_up_process(cio->waiter);
+}
+
+int blk_copy_offload_submit_bio(struct block_device *bdev,
+		struct blk_copy_payload *payload, int payload_size,
+		struct cio *cio, gfp_t gfp_mask)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+	struct bio *bio;
+
+	bio = bio_map_kern(q, payload, payload_size, gfp_mask);
+	if (IS_ERR(bio))
+		return PTR_ERR(bio);
+
+	bio_set_dev(bio, bdev);
+	bio->bi_opf = REQ_OP_COPY | REQ_NOMERGE;
+	bio->bi_iter.bi_sector = payload->dest;
+	bio->bi_end_io = cio_bio_end_io;
+	bio->bi_private = cio;
+	atomic_inc(&cio->refcount);
+	submit_bio(bio);
+
+	return 0;
+}
+
+/* Go through all the enrties inside user provided payload, and determine the
+ * maximum number of entries in a payload, based on device's scc-limits.
+ */
+static inline int blk_max_payload_entries(int nr_srcs, struct range_entry *rlist,
+		int max_nr_srcs, sector_t max_copy_range_sectors, sector_t max_copy_len)
+{
+	sector_t range_len, copy_len = 0, remaining = 0;
+	int ri = 0, pi = 1, max_pi = 0;
+
+	for (ri = 0; ri < nr_srcs; ri++) {
+		for (remaining = rlist[ri].len; remaining > 0; remaining -= range_len) {
+			range_len = min3(remaining, max_copy_range_sectors,
+								max_copy_len - copy_len);
+			pi++;
+			copy_len += range_len;
+
+			if ((pi == max_nr_srcs) || (copy_len == max_copy_len)) {
+				max_pi = max(max_pi, pi);
+				pi = 1;
+				copy_len = 0;
+			}
+		}
+	}
+
+	return max(max_pi, pi);
+}
+
+/*
+ * blk_copy_offload_scc	- Use device's native copy offload feature
+ * Go through user provide payload, prepare new payload based on device's copy offload limits.
+ */
+int blk_copy_offload_scc(struct block_device *src_bdev, int nr_srcs,
+		struct range_entry *rlist, struct block_device *dest_bdev,
+		sector_t dest, gfp_t gfp_mask)
+{
+	struct request_queue *q = bdev_get_queue(dest_bdev);
+	struct cio *cio = NULL;
+	struct blk_copy_payload *payload;
+	sector_t range_len, copy_len = 0, remaining = 0;
+	sector_t src_blk, cdest = dest;
+	sector_t max_copy_range_sectors, max_copy_len;
+	int ri = 0, pi = 0, ret = 0, payload_size, max_pi, max_nr_srcs;
+
+	cio = kzalloc(sizeof(struct cio), GFP_KERNEL);
+	if (!cio)
+		return -ENOMEM;
+	atomic_set(&cio->refcount, 0);
+
+	max_nr_srcs = q->limits.max_copy_nr_ranges;
+	max_copy_range_sectors = q->limits.max_copy_range_sectors;
+	max_copy_len = q->limits.max_copy_sectors;
+
+	max_pi = blk_max_payload_entries(nr_srcs, rlist, max_nr_srcs,
+					max_copy_range_sectors, max_copy_len);
+	payload_size = struct_size(payload, range, max_pi);
+
+	payload = kvmalloc(payload_size, gfp_mask);
+	if (!payload) {
+		ret = -ENOMEM;
+		goto free_cio;
+	}
+	payload->src_bdev = src_bdev;
+
+	for (ri = 0; ri < nr_srcs; ri++) {
+		for (remaining = rlist[ri].len, src_blk = rlist[ri].src; remaining > 0;
+						remaining -= range_len, src_blk += range_len) {
+
+			range_len = min3(remaining, max_copy_range_sectors,
+								max_copy_len - copy_len);
+			payload->range[pi].len = range_len;
+			payload->range[pi].src = src_blk;
+			pi++;
+			copy_len += range_len;
+
+			/* Submit current payload, if crossing device copy limits */
+			if ((pi == max_nr_srcs) || (copy_len == max_copy_len)) {
+				payload->dest = cdest;
+				payload->copy_nr_ranges = pi;
+				ret = blk_copy_offload_submit_bio(dest_bdev, payload,
+								payload_size, cio, gfp_mask);
+				if (ret)
+					goto free_payload;
+
+				/* reset index, length and allocate new payload */
+				pi = 0;
+				cdest += copy_len;
+				copy_len = 0;
+				payload = kvmalloc(payload_size, gfp_mask);
+				if (!payload) {
+					ret = -ENOMEM;
+					goto free_cio;
+				}
+				payload->src_bdev = src_bdev;
+			}
+		}
+	}
+
+	if (pi) {
+		payload->dest = cdest;
+		payload->copy_nr_ranges = pi;
+		ret = blk_copy_offload_submit_bio(dest_bdev, payload, payload_size, cio, gfp_mask);
+		if (ret)
+			goto free_payload;
+	}
+
+	/* Wait for completion of all IO's*/
+	ret = cio_await_completion(cio);
+
+	return ret;
+
+free_payload:
+	kvfree(payload);
+free_cio:
+	cio_await_completion(cio);
+	return ret;
+}
+
+static inline sector_t blk_copy_len(struct range_entry *rlist, int nr_srcs)
+{
+	int i;
+	sector_t len = 0;
+
+	for (i = 0; i < nr_srcs; i++) {
+		if (rlist[i].len)
+			len += rlist[i].len;
+		else
+			return 0;
+	}
+
+	return len;
+}
+
+static inline bool blk_check_offload_scc(struct request_queue *src_q,
+		struct request_queue *dest_q)
+{
+	if (src_q == dest_q && src_q->limits.copy_offload == BLK_COPY_OFFLOAD_SCC)
+		return true;
+
+	return false;
+}
+
+/*
+ * blkdev_issue_copy - queue a copy
+ * @src_bdev:	source block device
+ * @nr_srcs:	number of source ranges to copy
+ * @src_rlist:	array of source ranges
+ * @dest_bdev:	destination block device
+ * @dest:	destination in sector
+ * @gfp_mask:   memory allocation flags (for bio_alloc)
+ * @flags:	BLKDEV_COPY_* flags to control behaviour
+ *
+ * Description:
+ *	Copy source ranges from source block device to destination block device.
+ *	length of a source range cannot be zero.
+ */
+int blkdev_issue_copy(struct block_device *src_bdev, int nr_srcs,
+		struct range_entry *src_rlist, struct block_device *dest_bdev,
+		sector_t dest, gfp_t gfp_mask, int flags)
+{
+	struct request_queue *src_q = bdev_get_queue(src_bdev);
+	struct request_queue *dest_q = bdev_get_queue(dest_bdev);
+	sector_t copy_len;
+	int ret = -EINVAL;
+
+	if (!src_q || !dest_q)
+		return -ENXIO;
+
+	if (!nr_srcs)
+		return -EINVAL;
+
+	if (nr_srcs >= MAX_COPY_NR_RANGE)
+		return -EINVAL;
+
+	copy_len = blk_copy_len(src_rlist, nr_srcs);
+	if (!copy_len && copy_len >= MAX_COPY_TOTAL_LENGTH)
+		return -EINVAL;
+
+	if (bdev_read_only(dest_bdev))
+		return -EPERM;
+
+	if (blk_check_offload_scc(src_q, dest_q))
+		ret = blk_copy_offload_scc(src_bdev, nr_srcs, src_rlist, dest_bdev, dest, gfp_mask);
+
+	return ret;
+}
+EXPORT_SYMBOL(blkdev_issue_copy);
+
 /**
  * __blkdev_issue_write_same - generate number of bios with same page
  * @bdev:	target blockdev
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 86fce751bb17..7643fc868521 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -67,6 +67,7 @@ bool blk_req_needs_zone_write_lock(struct request *rq)
 	case REQ_OP_WRITE_ZEROES:
 	case REQ_OP_WRITE_SAME:
 	case REQ_OP_WRITE:
+	case REQ_OP_COPY:
 		return blk_rq_zone_is_seq(rq);
 	default:
 		return false;
diff --git a/block/bounce.c b/block/bounce.c
index 05fc7148489d..d9b05aaf6e56 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -176,6 +176,7 @@ static struct bio *bounce_clone_bio(struct bio *bio_src)
 	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
 
 	switch (bio_op(bio)) {
+	case REQ_OP_COPY:
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
 	case REQ_OP_WRITE_ZEROES:
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 3d67d0fbc868..068fa2e8896a 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -73,6 +73,7 @@ static inline bool bio_has_data(struct bio *bio)
 static inline bool bio_no_advance_iter(const struct bio *bio)
 {
 	return bio_op(bio) == REQ_OP_DISCARD ||
+	       bio_op(bio) == REQ_OP_COPY ||
 	       bio_op(bio) == REQ_OP_SECURE_ERASE ||
 	       bio_op(bio) == REQ_OP_WRITE_SAME ||
 	       bio_op(bio) == REQ_OP_WRITE_ZEROES;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 9e392daa1d7f..1ab77176cb46 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -347,6 +347,8 @@ enum req_opf {
 	REQ_OP_ZONE_RESET	= 15,
 	/* reset all the zone present on the device */
 	REQ_OP_ZONE_RESET_ALL	= 17,
+	/* copy ranges within device */
+	REQ_OP_COPY		= 19,
 
 	/* Driver private requests */
 	REQ_OP_DRV_IN		= 34,
@@ -470,6 +472,11 @@ static inline bool op_is_discard(unsigned int op)
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
@@ -529,4 +536,17 @@ struct blk_rq_stat {
 	u64 batch;
 };
 
+struct cio {
+	atomic_t refcount;
+	blk_status_t io_err;
+	struct task_struct *waiter;     /* waiting task (NULL if none) */
+};
+
+struct blk_copy_payload {
+	struct block_device	*src_bdev;
+	sector_t		dest;
+	int			copy_nr_ranges;
+	struct range_entry	range[];
+};
+
 #endif /* __LINUX_BLK_TYPES_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index fd4cfaadda5b..38369dff6a36 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -52,6 +52,12 @@ struct blk_keyslot_manager;
 /* Doing classic polling */
 #define BLK_MQ_POLL_CLASSIC -1
 
+/* Define copy offload options */
+enum blk_copy {
+	BLK_COPY_OFFLOAD_EMULATE = 0,
+	BLK_COPY_OFFLOAD_SCC,
+};
+
 /*
  * Maximum number of blkcg policies allowed to be registered concurrently.
  * Defined here to simplify include dependency.
@@ -1051,6 +1057,9 @@ static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
 		return min(q->limits.max_discard_sectors,
 			   UINT_MAX >> SECTOR_SHIFT);
 
+	if (unlikely(op == REQ_OP_COPY))
+		return q->limits.max_copy_sectors;
+
 	if (unlikely(op == REQ_OP_WRITE_SAME))
 		return q->limits.max_write_same_sectors;
 
@@ -1326,6 +1335,10 @@ extern int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, int flags,
 		struct bio **biop);
 
+int blkdev_issue_copy(struct block_device *src_bdev, int nr_srcs,
+		struct range_entry *src_rlist, struct block_device *dest_bdev,
+		sector_t dest, gfp_t gfp_mask, int flags);
+
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
 
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index bdf7b404b3e7..7a97b588d892 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -64,6 +64,18 @@ struct fstrim_range {
 	__u64 minlen;
 };
 
+/* Maximum no of entries supported */
+#define MAX_COPY_NR_RANGE	(1 << 12)
+
+/* maximum total copy length */
+#define MAX_COPY_TOTAL_LENGTH	(1 << 21)
+
+/* Source range entry for copy */
+struct range_entry {
+	__u64 src;
+	__u64 len;
+};
+
 /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
 #define FILE_DEDUPE_RANGE_SAME		0
 #define FILE_DEDUPE_RANGE_DIFFERS	1
-- 
2.25.1

