Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB9B444F21
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 07:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhKDGuI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 02:50:08 -0400
Received: from mail-co1nam11on2075.outbound.protection.outlook.com ([40.107.220.75]:34753
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231167AbhKDGtq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 02:49:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PO4Gk6y37C/w6wp4T6pOhprTHJUPN1BK57KwWE5wLWouWiUQJ+78ZbNOKubPKzE84dTcsNBqt6SAI8CMUdymoajTZC8jRMW2mF4pi4RkGzouutzjihTPd2CacLy4bftP4FuEliEGqhFlHR1ZRHSSiqhygesoBs12N2ZbHYAyn3wtaYufdRUmusxpsO7V31sDxbenRmIO25GQTGO8neWrMu1UD1Zlhepnvcm7lz/72VTfnup7R/hHjfrr9jP9804PTE5s7nwfPHfocNcvC71DDj2s1C1WqFC/i5YZZzLdSUZDZ62NiJAP0w2vfHwlKRRpVPQhWZW1nzcjNJX45Yjp4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9/n85uRMtEAqqhZcZra8ByjnymyEAumgi1ZtMtTccc=;
 b=QiYgZu7BDxBs8sStZxlWj+/5IfiAU8Vy2f/WJ6aErNBJFn+KBzGUR95AWHYpPAPVtc7PsfkYm5Nk/Fa5U00UbCP+qfuUIsQufkDqaNWLwspPGHjftaMcxBdqLbZGNPG6TOHyjiPmkq2hO6vTi1BFOzQXvl0hUXkD2fZLlu8G5aIXivhxyIU3Ttdu/NLsMlB1wbhiljMwyO4Nj565fRTRFBrzT7/kHjmwGPi6YTLoIgfknxS4NpJrFgNg/sA7fMparrL2nZoUdiSyskVXT/IBqkNLJ6VR7n0cAocoPkVnVP9dxHuPVYHhwdJnw2SJfgKCwMTze6zeWgJq0iwBqMrZ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9/n85uRMtEAqqhZcZra8ByjnymyEAumgi1ZtMtTccc=;
 b=aON+bvVQUI4S1tsrfKR4Mlzy54YSloqWvUnDQ1408v8edY0X4nLavx5kfOmeMh8NAeHZfIAoZtOyz35ejjBOENFpzMucypgSQNqpUjqiLSm8sqN95KdcJsH6Rdhv4Pgi4rE3gG/fPbmMQzNmuSoYQTo6qozDwLppl4W38wiVd0mRLiXLMZQA1P+UVb/hkDVVs6en8umlaVUMY6RRwznJUCGX/0t+y//GzL+jNQAHVsEf47LX+7EodW7P/IaaFiweq+K5ZCszFDHwciU00UFebzZPoO2vzRBio5cWKjaptMDA/4vK8/naklKgUX7yAOD+Ua63qVzpWWknz7Wky5zmBQ==
Received: from MWHPR14CA0013.namprd14.prod.outlook.com (2603:10b6:300:ae::23)
 by DM5PR12MB1881.namprd12.prod.outlook.com (2603:10b6:3:10f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 4 Nov
 2021 06:47:05 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ae:cafe::e9) by MWHPR14CA0013.outlook.office365.com
 (2603:10b6:300:ae::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 4 Nov 2021 06:47:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 06:47:04 +0000
Received: from dev.nvidia.com (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 4 Nov
 2021 06:47:00 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-scsi@vger.kernel.org>,
        <target-devel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <dm-devel@redhat.com>
CC:     <axboe@kernel.dk>, <agk@redhat.com>, <snitzer@redhat.com>,
        <song@kernel.org>, <djwong@kernel.org>, <kbusch@kernel.org>,
        <hch@lst.de>, <sagi@grimberg.me>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <viro@zeniv.linux.org.uk>,
        <javier@javigon.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <dongli.zhang@oracle.com>,
        <ming.lei@redhat.com>, <osandov@fb.com>, <willy@infradead.org>,
        <jefflexu@linux.alibaba.com>, <josef@toxicpanda.com>, <clm@fb.com>,
        <dsterba@suse.com>, <jack@suse.com>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jlayton@kernel.org>,
        <idryomov@gmail.com>, <danil.kipnis@cloud.ionos.com>,
        <ebiggers@google.com>, <jinpu.wang@cloud.ionos.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [RFC PATCH 1/8] block: add support for REQ_OP_VERIFY
Date:   Wed, 3 Nov 2021 23:46:27 -0700
Message-ID: <20211104064634.4481-2-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211104064634.4481-1-chaitanyak@nvidia.com>
References: <20211104064634.4481-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af4a8b2d-4d89-4c2f-2fcc-08d99f5ee9dd
X-MS-TrafficTypeDiagnostic: DM5PR12MB1881:
X-Microsoft-Antispam-PRVS: <DM5PR12MB188143254186350EAF60AF68A38D9@DM5PR12MB1881.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F7ZwzjHgLOQ7Nu8vxFgbZBFBwBCrSfh3BwRqepbl9hggNZtn8c3KI/PLWTXY+RyDZ1J8yHhJvnSe/9YW1/FW+EKckMsaDOUQDPey1zxcxCH4WFGNPpj6wbyE91FSFW5m9/17EuLkiQ/5W7yTgOvNl9UyJXlEUfx0Z2b5sZK38pOQHAwCiSi8KEJvs/PKD1BcLYVdbZV8+Lda0+cIOuHQKn1PJSkJhqv50KgXstxKRDqEMqIFnVVwKUrnA9mYktl55BJK2DNPPKaWPOg5m7LaklKvRAxa9hQmlYIVmDCllzp7sX+AP5W4LFimNrKm88o9SH3i3K1h2e6FWNQXWeu4Hk3XbR02pEZNA+EeS0++cxDNjn3zs1ld/B13UTIz5pKQud0kE5rOCH4fp/I9ZMXeGegIx57uXPm7hUrpU+Cs9WtnJZ+0cNzNSSRcPFlZQhAZqYz/CtI5IQxwxmoCMI2HSEZaMwgVcUXCipxybkTsdIC8OWGyQ1XT3xPpmM5XkPjxQPwJ35RsRVabB0yHMKh+Fec/nfDIkTPcjNBsD2j4u7qTjy5O46a0hPJ0RMvQy33ZLkL7rtKTUQfi3ZouSQ+YWsdkhhkaTunYfVPVcJrTc234Ejwysthquih8dJ7ZuWZP8m+p4mAQRqehAfBmjMeqfYBjyVGP6S8+XxJiOLneS5TlLnLiTLvk/Jtp6Em37SokjHmHk6xX7xMOUY7fAhYI2L7zuZsAyiRq+MZB9Wo0ExI=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(8676002)(6666004)(36860700001)(107886003)(316002)(82310400003)(30864003)(8936002)(7636003)(4326008)(426003)(70586007)(508600001)(1076003)(70206006)(7406005)(83380400001)(2616005)(356005)(16526019)(186003)(36756003)(26005)(336012)(54906003)(110136005)(47076005)(7416002)(5660300002)(2906002)(86362001)(7696005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 06:47:04.7755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af4a8b2d-4d89-4c2f-2fcc-08d99f5ee9dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1881
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chaitanya Kulkarni <kch@nvidia.com>

This adds a new block layer operation to offload verifying a range of
LBAs. This support is needed in order to provide file systems and
fabrics, kernel components to offload LBA verification when it is
supported by the hardware controller. In case hardware offloading is
not supported then we provide APIs to emulate the same. The prominent
example of that is NVMe Verify command. We also provide an emulation of
the same operation which can be used in case H/W does not support
verify. This is still useful when block device is remotely attached e.g.
using NVMeOF.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 Documentation/ABI/testing/sysfs-block |  14 ++
 block/blk-core.c                      |   5 +
 block/blk-lib.c                       | 192 ++++++++++++++++++++++++++
 block/blk-merge.c                     |  19 +++
 block/blk-settings.c                  |  17 +++
 block/blk-sysfs.c                     |   8 ++
 block/blk-zoned.c                     |   1 +
 block/bounce.c                        |   1 +
 block/ioctl.c                         |  35 +++++
 include/linux/bio.h                   |  10 +-
 include/linux/blk_types.h             |   2 +
 include/linux/blkdev.h                |  31 +++++
 include/uapi/linux/fs.h               |   1 +
 13 files changed, 332 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
index e34cdeeeb9d4..ba97f7a9cbec 100644
--- a/Documentation/ABI/testing/sysfs-block
+++ b/Documentation/ABI/testing/sysfs-block
@@ -252,6 +252,20 @@ Description:
 		write_zeroes_max_bytes is 0, write zeroes is not supported
 		by the device.
 
+What:		/sys/block/<disk>/queue/verify_max_bytes
+Date:		Nov 2021
+Contact:	Chaitanya Kulkarni <kch@nvidia.com>
+Description:
+		Devices that support verify operation in which a single
+		request can be issued to verify the range of the contiguous
+		blocks on the storage without any payload in the request.
+		This can be used to optimize verifying LBAs on the device
+		without reading by offloading functionality. verify_max_bytes
+		indicates how many bytes can be written in a single verify
+		command. If verify_max_bytes is 0, verify operation is not
+		supported by the device.
+
+
 What:		/sys/block/<disk>/queue/zoned
 Date:		September 2016
 Contact:	Damien Le Moal <damien.lemoal@wdc.com>
diff --git a/block/blk-core.c b/block/blk-core.c
index 5e752840b41a..62160e729e7d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -141,6 +141,7 @@ static const char *const blk_op_name[] = {
 	REQ_OP_NAME(ZONE_APPEND),
 	REQ_OP_NAME(WRITE_SAME),
 	REQ_OP_NAME(WRITE_ZEROES),
+	REQ_OP_NAME(VERIFY),
 	REQ_OP_NAME(SCSI_IN),
 	REQ_OP_NAME(SCSI_OUT),
 	REQ_OP_NAME(DRV_IN),
@@ -851,6 +852,10 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 		if (!q->limits.max_write_same_sectors)
 			goto not_supported;
 		break;
+	case REQ_OP_VERIFY:
+		if (!q->limits.max_verify_sectors)
+			goto not_supported;
+		break;
 	case REQ_OP_ZONE_APPEND:
 		status = blk_check_zone_append(q, bio);
 		if (status != BLK_STS_OK)
diff --git a/block/blk-lib.c b/block/blk-lib.c
index 752f9c722062..fdbb765b369e 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -439,3 +439,195 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 	return ret;
 }
 EXPORT_SYMBOL(blkdev_issue_zeroout);
+
+/**
+ * __blkdev_emulate_verify - emulate number of verify operations
+ * 				asynchronously
+ * @bdev:	blockdev to issue
+ * @sector:	start sector
+ * @nr_sects:	number of sectors to verify
+ * @gfp_mask:	memory allocation flags (for bio_alloc)
+ * @biop:	pointer to anchor bio
+ * @buf:	data buffer to mapped on bio
+ *
+ * Description:
+ *  Verify a block range by emulating REQ_OP_VERIFY, use this when H/W
+ *  offloading is not supported asynchronously. Caller is responsible to
+ *  handle anchored bio.
+ */
+int __blkdev_emulate_verify(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop, char *buf)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+	struct bio *bio = *biop;
+	unsigned int sz;
+	int bi_size;
+
+	if (!q)
+		return -ENXIO;
+
+	if (bdev_read_only(bdev))
+		return -EPERM;
+
+	while (nr_sects != 0) {
+		bio = blk_next_bio(bio, __blkdev_sectors_to_bio_pages(nr_sects),
+				gfp_mask);
+		bio->bi_iter.bi_sector = sector;
+		bio_set_dev(bio, bdev);
+		bio_set_op_attrs(bio, REQ_OP_READ, 0);
+
+		while (nr_sects != 0) {
+			bool is_vaddr = is_vmalloc_addr(buf);
+			struct page *p;
+
+			p = is_vaddr ? vmalloc_to_page(buf) : virt_to_page(buf);
+			sz = min((sector_t) PAGE_SIZE, nr_sects << 9);
+			bi_size = bio_add_page(bio, p, sz, offset_in_page(buf));
+			nr_sects -= bi_size >> 9;
+			sector += bi_size >> 9;
+			buf += bi_size;
+
+			if (bi_size < sz)
+				break;
+		}
+		cond_resched();
+	}
+
+	*biop = bio;
+	return 0;
+}
+EXPORT_SYMBOL(__blkdev_emulate_verify);
+
+/**
+ * blkdev_emulate_verify - emulate number of verify operations synchronously
+ * @bdev:	blockdev to issue
+ * @sector:	start sector
+ * @nr_sects:	number of sectors to verify
+ * @gfp_mask:	memory allocation flags (for bio_alloc)
+ *
+ * Description:
+ *  Verify a block range by emulating REQ_OP_VERIFY, use this when H/W
+ *  offloading is not supported synchronously.
+ */
+int blkdev_emulate_verify(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp_mask)
+{
+	sector_t min_io_sect = (BIO_MAX_VECS << PAGE_SHIFT) >> 9;
+	int ret = 0;
+	char *buf;
+
+	/* allows pages in buffer to be == BIO_MAX_VECS */
+	buf = kzalloc(min_io_sect << 9, GFP_KERNEL);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	while (nr_sects > 0) {
+		sector_t curr_sects = min_t(sector_t, nr_sects, min_io_sect);
+		struct bio *bio = NULL;
+
+		ret = __blkdev_emulate_verify(bdev, sector, curr_sects,
+				GFP_KERNEL, &bio, buf);
+
+		if (!(ret == 0 && bio))
+			break;
+
+		ret = submit_bio_wait(bio);
+		bio_put(bio);
+
+		nr_sects -= curr_sects;
+		sector += curr_sects;
+	}
+out:
+	kfree(buf);
+	return ret;
+}
+EXPORT_SYMBOL(blkdev_emulate_verify);
+
+/**
+ * __blkdev_issue_verify - generate number of verify operations
+ * @bdev:	blockdev to issue
+ * @sector:	start sector
+ * @nr_sects:	number of sectors to verify
+ * @gfp_mask:	memory allocation flags (for bio_alloc)
+ * @biop:	pointer to anchor bio
+ *
+ * Description:
+ *  Verify a block range using hardware offload.
+ *
+ * The function will emulate verify operation if no explicit hardware
+ * offloading for verifying is provided.
+ */
+int __blkdev_issue_verify(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+	unsigned int max_verify_sectors;
+	struct bio *bio = *biop;
+
+	if (!q)
+		return -ENXIO;
+
+	if (bdev_read_only(bdev))
+		return -EPERM;
+
+	max_verify_sectors = bdev_verify_sectors(bdev);
+
+	if (max_verify_sectors == 0)
+		return blkdev_emulate_verify(bdev, sector, nr_sects, gfp_mask);
+
+	while (nr_sects) {
+		bio = blk_next_bio(bio, 0, gfp_mask);
+		bio->bi_iter.bi_sector = sector;
+		bio_set_dev(bio, bdev);
+		bio->bi_opf = REQ_OP_VERIFY;
+		if (nr_sects > max_verify_sectors) {
+			bio->bi_iter.bi_size = max_verify_sectors << 9;
+			nr_sects -= max_verify_sectors;
+			sector += max_verify_sectors;
+		} else {
+			bio->bi_iter.bi_size = nr_sects << 9;
+			nr_sects = 0;
+		}
+		cond_resched();
+	}
+
+	*biop = bio;
+	return 0;
+}
+EXPORT_SYMBOL(__blkdev_issue_verify);
+
+/**
+ * blkdev_issue_verify - verify a block range
+ * @bdev:	blockdev to verify
+ * @sector:	start sector
+ * @nr_sects:	number of sectors to verify
+ * @gfp_mask:	memory allocation flags (for bio_alloc)
+ *
+ * Description:
+ *  Verify a block range using hardware offload.
+ */
+int blkdev_issue_verify(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp_mask)
+{
+	int ret = 0;
+	sector_t bs_mask;
+	struct bio *bio = NULL;
+	struct blk_plug plug;
+
+	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
+	if ((sector | nr_sects) & bs_mask)
+		return -EINVAL;
+
+	blk_start_plug(&plug);
+	ret = __blkdev_issue_verify(bdev, sector, nr_sects, gfp_mask, &bio);
+	if (ret == 0 && bio) {
+		ret = submit_bio_wait(bio);
+		bio_put(bio);
+	}
+	blk_finish_plug(&plug);
+
+	return ret;
+}
+EXPORT_SYMBOL(blkdev_issue_verify);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index ffb4aa0ea68b..c28632cb936b 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -117,6 +117,20 @@ static struct bio *blk_bio_write_zeroes_split(struct request_queue *q,
 	return bio_split(bio, q->limits.max_write_zeroes_sectors, GFP_NOIO, bs);
 }
 
+static struct bio *blk_bio_verify_split(struct request_queue *q,
+		struct bio *bio, struct bio_set *bs, unsigned *nsegs)
+{
+	*nsegs = 0;
+
+	if (!q->limits.max_verify_sectors)
+		return NULL;
+
+	if (bio_sectors(bio) <= q->limits.max_verify_sectors)
+		return NULL;
+
+	return bio_split(bio, q->limits.max_verify_sectors, GFP_NOIO, bs);
+}
+
 static struct bio *blk_bio_write_same_split(struct request_queue *q,
 					    struct bio *bio,
 					    struct bio_set *bs,
@@ -316,6 +330,10 @@ void __blk_queue_split(struct bio **bio, unsigned int *nr_segs)
 		split = blk_bio_write_zeroes_split(q, *bio, &q->bio_split,
 				nr_segs);
 		break;
+	case REQ_OP_VERIFY:
+		split = blk_bio_verify_split(q, *bio, &q->bio_split,
+				nr_segs);
+		break;
 	case REQ_OP_WRITE_SAME:
 		split = blk_bio_write_same_split(q, *bio, &q->bio_split,
 				nr_segs);
@@ -383,6 +401,7 @@ unsigned int blk_recalc_rq_segments(struct request *rq)
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
 	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_VERIFY:
 		return 0;
 	case REQ_OP_WRITE_SAME:
 		return 1;
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 4c974340f1a9..f34cbd3678b6 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -48,6 +48,7 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->chunk_sectors = 0;
 	lim->max_write_same_sectors = 0;
 	lim->max_write_zeroes_sectors = 0;
+	lim->max_verify_sectors = 0;
 	lim->max_zone_append_sectors = 0;
 	lim->max_discard_sectors = 0;
 	lim->max_hw_discard_sectors = 0;
@@ -84,6 +85,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
 	lim->max_dev_sectors = UINT_MAX;
 	lim->max_write_same_sectors = UINT_MAX;
 	lim->max_write_zeroes_sectors = UINT_MAX;
+	lim->max_verify_sectors = UINT_MAX;
 	lim->max_zone_append_sectors = UINT_MAX;
 }
 EXPORT_SYMBOL(blk_set_stacking_limits);
@@ -227,6 +229,19 @@ void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
 }
 EXPORT_SYMBOL(blk_queue_max_write_zeroes_sectors);
 
+/**
+ * blk_queue_max_verify_sectors - set max sectors for a single verify
+ *
+ * @q:  the request queue for the device
+ * @max_verify_sectors: maximum number of sectors to verify per command
+ **/
+void blk_queue_max_verify_sectors(struct request_queue *q,
+		unsigned int max_verify_sectors)
+{
+	q->limits.max_verify_sectors = max_verify_sectors;
+}
+EXPORT_SYMBOL(blk_queue_max_verify_sectors);
+
 /**
  * blk_queue_max_zone_append_sectors - set max sectors for a single zone append
  * @q:  the request queue for the device
@@ -514,6 +529,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 					b->max_write_same_sectors);
 	t->max_write_zeroes_sectors = min(t->max_write_zeroes_sectors,
 					b->max_write_zeroes_sectors);
+	t->max_verify_sectors = min(t->max_verify_sectors,
+				    b->max_verify_sectors);
 	t->max_zone_append_sectors = min(t->max_zone_append_sectors,
 					b->max_zone_append_sectors);
 	t->bounce_pfn = min_not_zero(t->bounce_pfn, b->bounce_pfn);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index b513f1683af0..f918c83dd8d4 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -108,6 +108,12 @@ queue_ra_store(struct request_queue *q, const char *page, size_t count)
 	return ret;
 }
 
+static ssize_t queue_verify_max_show(struct request_queue *q, char *page)
+{
+	return sprintf(page, "%llu\n",
+		(unsigned long long)q->limits.max_verify_sectors << 9);
+}
+
 static ssize_t queue_max_sectors_show(struct request_queue *q, char *page)
 {
 	int max_sectors_kb = queue_max_sectors(q) >> 1;
@@ -584,6 +590,7 @@ QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
 
 QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
 QUEUE_RO_ENTRY(queue_write_zeroes_max, "write_zeroes_max_bytes");
+QUEUE_RO_ENTRY(queue_verify_max, "verify_max_bytes");
 QUEUE_RO_ENTRY(queue_zone_append_max, "zone_append_max_bytes");
 
 QUEUE_RO_ENTRY(queue_zoned, "zoned");
@@ -638,6 +645,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_discard_zeroes_data_entry.attr,
 	&queue_write_same_max_entry.attr,
 	&queue_write_zeroes_max_entry.attr,
+	&queue_verify_max_entry.attr,
 	&queue_zone_append_max_entry.attr,
 	&queue_nonrot_entry.attr,
 	&queue_zoned_entry.attr,
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 7a68b6e4300c..c9c51ee22a49 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -73,6 +73,7 @@ bool blk_req_needs_zone_write_lock(struct request *rq)
 
 	switch (req_op(rq)) {
 	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_VERIFY:
 	case REQ_OP_WRITE_SAME:
 	case REQ_OP_WRITE:
 		return blk_rq_zone_is_seq(rq);
diff --git a/block/bounce.c b/block/bounce.c
index fc55314aa426..86cdb900b88f 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -259,6 +259,7 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
 	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_VERIFY:
 		break;
 	case REQ_OP_WRITE_SAME:
 		bio->bi_io_vec[bio->bi_vcnt++] = bio_src->bi_io_vec[0];
diff --git a/block/ioctl.c b/block/ioctl.c
index d61d652078f4..5e1b3c4660bf 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -168,6 +168,39 @@ static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
 			BLKDEV_ZERO_NOUNMAP);
 }
 
+static int blk_ioctl_verify(struct block_device *bdev, fmode_t mode,
+		unsigned long arg)
+{
+	uint64_t range[2];
+	struct address_space *mapping;
+	uint64_t start, end, len;
+
+	if (!(mode & FMODE_WRITE))
+		return -EBADF;
+
+	if (copy_from_user(range, (void __user *)arg, sizeof(range)))
+		return -EFAULT;
+
+	start = range[0];
+	len = range[1];
+	end = start + len - 1;
+
+	if (start & 511)
+		return -EINVAL;
+	if (len & 511)
+		return -EINVAL;
+	if (end >= (uint64_t)i_size_read(bdev->bd_inode))
+		return -EINVAL;
+	if (end < start)
+		return -EINVAL;
+
+	/* Invalidate the page cache, including dirty pages */
+	mapping = bdev->bd_inode->i_mapping;
+	truncate_inode_pages_range(mapping, start, end);
+
+	return blkdev_issue_verify(bdev, start >> 9, len >> 9, GFP_KERNEL);
+}
+
 static int put_ushort(unsigned short __user *argp, unsigned short val)
 {
 	return put_user(val, argp);
@@ -460,6 +493,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
 				BLKDEV_DISCARD_SECURE);
 	case BLKZEROOUT:
 		return blk_ioctl_zeroout(bdev, mode, arg);
+	case BLKVERIFY:
+		return blk_ioctl_verify(bdev, mode, arg);
 	case BLKREPORTZONE:
 		return blkdev_report_zones_ioctl(bdev, mode, cmd, arg);
 	case BLKRESETZONE:
diff --git a/include/linux/bio.h b/include/linux/bio.h
index c74857cf1252..d660c37b7d6c 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -63,7 +63,8 @@ static inline bool bio_has_data(struct bio *bio)
 	    bio->bi_iter.bi_size &&
 	    bio_op(bio) != REQ_OP_DISCARD &&
 	    bio_op(bio) != REQ_OP_SECURE_ERASE &&
-	    bio_op(bio) != REQ_OP_WRITE_ZEROES)
+	    bio_op(bio) != REQ_OP_WRITE_ZEROES &&
+	    bio_op(bio) != REQ_OP_VERIFY)
 		return true;
 
 	return false;
@@ -73,8 +74,8 @@ static inline bool bio_no_advance_iter(const struct bio *bio)
 {
 	return bio_op(bio) == REQ_OP_DISCARD ||
 	       bio_op(bio) == REQ_OP_SECURE_ERASE ||
-	       bio_op(bio) == REQ_OP_WRITE_SAME ||
-	       bio_op(bio) == REQ_OP_WRITE_ZEROES;
+	       bio_op(bio) == REQ_OP_WRITE_ZEROES ||
+	       bio_op(bio) == REQ_OP_VERIFY;
 }
 
 static inline bool bio_mergeable(struct bio *bio)
@@ -198,7 +199,7 @@ static inline unsigned bio_segments(struct bio *bio)
 	struct bvec_iter iter;
 
 	/*
-	 * We special case discard/write same/write zeroes, because they
+	 * We special case discard/write same/write zeroes/verify, because they
 	 * interpret bi_size differently:
 	 */
 
@@ -206,6 +207,7 @@ static inline unsigned bio_segments(struct bio *bio)
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
 	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_VERIFY:
 		return 0;
 	case REQ_OP_WRITE_SAME:
 		return 1;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 1bc6f6a01070..8877711c4c56 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -366,6 +366,8 @@ enum req_opf {
 	REQ_OP_SECURE_ERASE	= 5,
 	/* write the same sector many times */
 	REQ_OP_WRITE_SAME	= 7,
+	/* verify the sectors */
+	REQ_OP_VERIFY		= 8,
 	/* write the zero filled sector many times */
 	REQ_OP_WRITE_ZEROES	= 9,
 	/* Open a zone */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0dea268bd61b..99c41d90584b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -334,6 +334,7 @@ struct queue_limits {
 	unsigned int		max_hw_discard_sectors;
 	unsigned int		max_write_same_sectors;
 	unsigned int		max_write_zeroes_sectors;
+	unsigned int		max_verify_sectors;
 	unsigned int		max_zone_append_sectors;
 	unsigned int		discard_granularity;
 	unsigned int		discard_alignment;
@@ -621,6 +622,7 @@ struct request_queue {
 #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
 #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
 #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
+#define QUEUE_FLAG_VERIFY	30	/* supports Verify */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP) |		\
@@ -667,6 +669,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
 #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
 #define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_flags)
+#define blk_queue_verify(q)	test_bit(QUEUE_FLAG_VERIFY, &(q)->queue_flags)
 
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
@@ -814,6 +817,9 @@ static inline bool rq_mergeable(struct request *rq)
 	if (req_op(rq) == REQ_OP_WRITE_ZEROES)
 		return false;
 
+	if (req_op(rq) == REQ_OP_VERIFY)
+		return false;
+
 	if (req_op(rq) == REQ_OP_ZONE_APPEND)
 		return false;
 
@@ -1072,6 +1078,9 @@ static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
 	if (unlikely(op == REQ_OP_WRITE_ZEROES))
 		return q->limits.max_write_zeroes_sectors;
 
+	if (unlikely(op == REQ_OP_VERIFY))
+		return q->limits.max_verify_sectors;
+
 	return q->limits.max_sectors;
 }
 
@@ -1154,6 +1163,8 @@ extern void blk_queue_max_discard_sectors(struct request_queue *q,
 		unsigned int max_discard_sectors);
 extern void blk_queue_max_write_same_sectors(struct request_queue *q,
 		unsigned int max_write_same_sectors);
+extern void blk_queue_max_verify_sectors(struct request_queue *q,
+		unsigned int max_verify_sectors);
 extern void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
 		unsigned int max_write_same_sectors);
 extern void blk_queue_logical_block_size(struct request_queue *, unsigned int);
@@ -1348,6 +1359,16 @@ extern int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 		unsigned flags);
 extern int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, unsigned flags);
+extern int __blkdev_emulate_verify(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop,
+		char *buf);
+extern int blkdev_emulate_verify(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp_mask);
+extern int __blkdev_issue_verify(struct block_device *bdev,
+		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
+		struct bio **biop);
+extern int blkdev_issue_verify(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp_mask);
 
 static inline int sb_issue_discard(struct super_block *sb, sector_t block,
 		sector_t nr_blocks, gfp_t gfp_mask, unsigned long flags)
@@ -1553,6 +1574,16 @@ static inline unsigned int bdev_write_same(struct block_device *bdev)
 	return 0;
 }
 
+static inline unsigned int bdev_verify_sectors(struct block_device *bdev)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	if (q)
+		return q->limits.max_verify_sectors;
+
+	return 0;
+}
+
 static inline unsigned int bdev_write_zeroes_sectors(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index f44eb0a04afd..5eda16bd2c3d 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -184,6 +184,7 @@ struct fsxattr {
 #define BLKSECDISCARD _IO(0x12,125)
 #define BLKROTATIONAL _IO(0x12,126)
 #define BLKZEROOUT _IO(0x12,127)
+#define BLKVERIFY _IO(0x12,128)
 /*
  * A jump here: 130-131 are reserved for zoned block devices
  * (see uapi/linux/blkzoned.h)
-- 
2.22.1

