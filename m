Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C982572F06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 09:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbiGMHVt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 03:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbiGMHVm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:21:42 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2066.outbound.protection.outlook.com [40.107.96.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F51BC444D;
        Wed, 13 Jul 2022 00:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ces1hp0VphY/+rM5L3o9xzMQHPwM5zeCkdEj+vYtHnXQFvJg88kHs2BZMXAQjqGHE4PVrzEp12KPWIwCKz6+UFFJRyS7vFF2ZeFHFUYfTSu5FLMxmpU7bDRv6hLcBMe+eqx/GqUihUqXSJnnobI8AuRdTspXNZtc+Nq/2AtmJEYf/0A0r84VCyJ7dDqxES0Dl2gP+mg2w/1aV2kssm6ro/AsBS9gwZJDuPdwYfqY/gUDCL6ckC94nWfLpn3vCYmB+2UxykPxiRe6RIpxsW1mG8E5x35+RGyu19+S/2aeZQ/QEayUh43NDsO6wUcUFUoICdU+GTz20CsdT3ux84IoAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VE7jo1aPoWeVsjqVruNOXX2q9+W6F6XYr+aNXAjKYvI=;
 b=A5Ea6hXgd/1m4tCRVDpDjJtYq7qlKW7XvZA0Ud2xjmCRgQyu8JApSJxJtOzDq/obcNWPxN3Aw/43zNT6aSJxc1k/UKMYG7BGwGR/38+pep9CaAUdIcg67ghYCPThN+2yCnwV4yc2nTYVe8WeH9j6Uwh/dYQqlS42lZqwOhZZRWXnup5a7G36AQfoa0HidpKc3qYt1WPUgbiWKe/hFF9vnUzGTJbeu5ZJ3Z/3zXANpFe9+XQQmZmH7Spn+AO1pMNjolr9k1CzbPfvzZxaplwC1tBY16KO5wMzq1FUi7dpJ2mA0VhbNoVNamus29peAvtazg7NxRh8ZRhJgiANDsD9tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.dk smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VE7jo1aPoWeVsjqVruNOXX2q9+W6F6XYr+aNXAjKYvI=;
 b=tJ3gk24kFle6zQ9g776L5FFyCv3+3hfXI3Gr8QPB+FbcTSZaEGFUarg02ZyGPZHwN612xsDQ6WVnKDPC7yc7r33gW9kM9Mgi/PLk0TUa/bXEaZE2M+NEdWotxwrwepLPKd27hCzE2XvBjnwAT4OZXBlaSBsr2M+DEaCBhByfrVQK6qzkYKObRG/VVwh28s+ABNxUdSSlnGTSWav08vWlikHmKg2Rn7kWQUF6n4qDyVzVqhqac3Jh038uPzUCX+xyeLe5UKM1Ty8gitE98/LoLE7n+7HX1Oka0AYpPnAzFLmAewUL6j9PvwVgJKLm5+LCSpt6T2GRIxWbb8tOgZLnCw==
Received: from MW4PR03CA0212.namprd03.prod.outlook.com (2603:10b6:303:b9::7)
 by PH0PR12MB5500.namprd12.prod.outlook.com (2603:10b6:510:ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 07:21:28 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::3f) by MW4PR03CA0212.outlook.office365.com
 (2603:10b6:303:b9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12 via Frontend
 Transport; Wed, 13 Jul 2022 07:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 07:21:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 13 Jul
 2022 07:21:26 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 13 Jul
 2022 00:21:23 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <agk@redhat.com>, <song@kernel.org>,
        <djwong@kernel.org>, <kbusch@kernel.org>, <hch@lst.de>,
        <sagi@grimberg.me>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <viro@zeniv.linux.org.uk>,
        <javier@javigon.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <dongli.zhang@oracle.com>,
        <ming.lei@redhat.com>, <willy@infradead.org>,
        <jefflexu@linux.alibaba.com>, <josef@toxicpanda.com>, <clm@fb.com>,
        <dsterba@suse.com>, <jack@suse.com>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jlayton@kernel.org>,
        <idryomov@gmail.com>, <danil.kipnis@cloud.ionos.com>,
        <ebiggers@google.com>, <jinpu.wang@cloud.ionos.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 1/6] block: add support for REQ_OP_VERIFY
Date:   Wed, 13 Jul 2022 00:20:14 -0700
Message-ID: <20220713072019.5885-2-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220713072019.5885-1-kch@nvidia.com>
References: <20220713072019.5885-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2c2658e-557d-43dc-2b7b-08da64a04d5d
X-MS-TrafficTypeDiagnostic: PH0PR12MB5500:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IxDilZGDEvnPvZXc+IvRv0MQzex8wMun98eqtA7kdd+SFvAcPr0Ol7gjZJYuhserY00wuGDzTmtO71GoEPB9L7FyBtqan5NEOw5jzOOvALmBM19shQGvBygUr5FZiGS1lSPud+8VWg1hQvXh7EUoFCQt6zgjeUPbxoXekNiubGQKAe4CNG9qZrDBR5fw0B2QHCl0VJZmkOo39C1DDl2leMATnWJFERZG9uO5MHZLqyKdp4oDT8tR7o7VmyYTMwFdShs4F0qRzY7dA8geM3y9wgWg4BLhxhZU9/DxYt9agr9u2Ylp6R4/CgN/XPZ2m4VufCcU5BNDFvnCqLygZwYVHXkWIIGAtRbBwxmalYi6QMRpp+yeJawgwKgKzktYWMH44BBHCVycSDrN1WFMKlZNIR7cMLbThoWq2msHuotbf7MBE0mPliKQkm7tFl4IXfcVZT19YIGhXIWCA5xRO/2B/nU86dokMLqPLiCYiXVuQwdQmEPsJ39SAbyd0LsYSl4/Ap8xBF1PBxnKO5XykiShfX4cjC/RQzaMLSiMbHhukkJqbUG8ftT6rftVFJjz0BjRzXhD2GNMs0rtNaSZGpNx2S2KyHXOzFTVpJYx3hwZqXkCD9vygY0qedocKhOODoqIHXxn8V/7L3qWoC18tLLqQMRQpdz0wAQnzgzDpQr6rNL61aTeg9nncy2HuDRRhH1oARCWKjxhND76TkwEs3y+d4PA/CnU+JYPHqAAEcRsP91OyyUnyv+4OmrNlFBuLs62BvxLlKyHGj8d0YuN0Yip1Jts2X8eUijhekzr0xSQ+9GmAw4yhiZHxOZJD2KRAbLdPoSK60HhFq0UyyDL8TX5wiFsQMVtbUjBGRSLhefKRZqO8k2WvzYaUIDWSuzMZEMq
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(346002)(396003)(36840700001)(40470700004)(46966006)(1076003)(70586007)(186003)(8676002)(2616005)(16526019)(7416002)(316002)(107886003)(426003)(336012)(70206006)(4326008)(81166007)(6666004)(82310400005)(7696005)(47076005)(40480700001)(36756003)(41300700001)(478600001)(82740400003)(40460700003)(110136005)(54906003)(8936002)(356005)(2906002)(7406005)(30864003)(36860700001)(83380400001)(26005)(5660300002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 07:21:28.0593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c2658e-557d-43dc-2b7b-08da64a04d5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5500
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds a new block layer operation to offload verifying a range of
LBAs. This support is needed in order to provide file systems and
fabrics, kernel components to offload LBA verification when it is
supported by the hardware controller. In case hardware offloading is
not supported then we provide API to emulate the same. The prominent
example of that is SCSI and NVMe Verify command. Block layer API also
provide an emulation of the same operation that can be used in case H/W
does not support verify. This is still useful when block device is
remotely attached e.g. using NVMeOF.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 Documentation/ABI/stable/sysfs-block |  12 +++
 block/blk-core.c                     |   5 +
 block/blk-lib.c                      | 155 +++++++++++++++++++++++++++
 block/blk-merge.c                    |  18 ++++
 block/blk-settings.c                 |  17 +++
 block/blk-sysfs.c                    |   8 ++
 block/blk.h                          |   7 ++
 block/ioctl.c                        |  35 ++++++
 include/linux/bio.h                  |   9 +-
 include/linux/blk_types.h            |   2 +
 include/linux/blkdev.h               |  19 ++++
 include/uapi/linux/fs.h              |   1 +
 12 files changed, 285 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index cd14ecb3c9a5..e3a10ed1f955 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -666,6 +666,18 @@ Description:
 		in a single write zeroes command. If write_zeroes_max_bytes is
 		0, write zeroes is not supported by the device.
 
+What:		/sys/block/<disk>/queue/verify_max_bytes
+Date:		July 2022
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
 
 What:		/sys/block/<disk>/queue/zone_append_max_bytes
 Date:		May 2020
diff --git a/block/blk-core.c b/block/blk-core.c
index b530ce7b370c..a77975b8ae60 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -123,6 +123,7 @@ static const char *const blk_op_name[] = {
 	REQ_OP_NAME(ZONE_FINISH),
 	REQ_OP_NAME(ZONE_APPEND),
 	REQ_OP_NAME(WRITE_ZEROES),
+	REQ_OP_NAME(VERIFY),
 	REQ_OP_NAME(DRV_IN),
 	REQ_OP_NAME(DRV_OUT),
 };
@@ -785,6 +786,10 @@ void submit_bio_noacct(struct bio *bio)
 		if (!q->limits.max_write_zeroes_sectors)
 			goto not_supported;
 		break;
+	case REQ_OP_VERIFY:
+		if (!q->limits.max_verify_sectors)
+			goto not_supported;
+		break;
 	default:
 		break;
 	}
diff --git a/block/blk-lib.c b/block/blk-lib.c
index 09b7e1200c0f..df2e2bc092b3 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -340,3 +340,158 @@ int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
 	return ret;
 }
 EXPORT_SYMBOL(blkdev_issue_secure_erase);
+
+/**
+ * __blkdev_emulate_verify - emulate number of verify operations
+ *				asynchronously
+ * @bdev:	blockdev to issue
+ * @sector:	start sector
+ * @nr_sects:	number of sectors to verify
+ * @gfp_mask:	memory allocation flags (for bio_alloc)
+ * @biop:	pointer to anchor bio
+ * @buf:	data buffer to mapped on bio
+ *
+ * Description:
+ *  Verify a block range by emulating REQ_OP_VERIFY into REQ_OP_READ,
+ *  use this when H/W offloading is not supported asynchronously.
+ *  Caller is responsible to handle anchored bio.
+ */
+static int __blkdev_emulate_verify(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop, char *buf)
+{
+	struct bio *bio = *biop;
+	unsigned int sz;
+	int bi_size;
+
+	while (nr_sects != 0) {
+		bio = blk_next_bio(bio, bdev,
+				__blkdev_sectors_to_bio_pages(nr_sects),
+				REQ_OP_READ, gfp_mask);
+		bio->bi_iter.bi_sector = sector;
+
+		while (nr_sects != 0) {
+			bool is_vaddr = is_vmalloc_addr(buf);
+			struct page *p;
+
+			p = is_vaddr ? vmalloc_to_page(buf) : virt_to_page(buf);
+			sz = min((sector_t) PAGE_SIZE, nr_sects << 9);
+
+			bi_size = bio_add_page(bio, p, sz, offset_in_page(buf));
+			if (bi_size < sz)
+				return -EIO;
+
+			nr_sects -= bi_size >> 9;
+			sector += bi_size >> 9;
+			buf += bi_size;
+		}
+		cond_resched();
+	}
+
+	*biop = bio;
+	return 0;
+}
+
+/**
+ * __blkdev_issue_verify - generate number of verify operations
+ * @bdev:	blockdev to issue
+ * @sector:	start sector
+ * @nr_sects:	number of sectors to verify
+ * @gfp_mask:	memory allocation flags (for bio_alloc())
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
+	unsigned int max_verify_sectors = bdev_verify_sectors(bdev);
+	sector_t min_io_sect = (BIO_MAX_VECS << PAGE_SHIFT) >> 9;
+	struct bio *bio = *biop;
+	sector_t curr_sects;
+	char *buf;
+
+	if (!max_verify_sectors) {
+		int ret = 0;
+
+		buf = kmalloc(min_io_sect << 9, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+
+		while (nr_sects > 0) {
+			curr_sects = min_t(sector_t, nr_sects, min_io_sect);
+			ret = __blkdev_emulate_verify(bdev, sector, curr_sects,
+						      gfp_mask, &bio, buf);
+			if (ret)
+				break;
+
+			if (bio) {
+				ret = submit_bio_wait(bio);
+				bio_put(bio);
+				bio = NULL;
+			}
+
+			nr_sects -= curr_sects;
+			sector += curr_sects;
+
+		}
+		/* set the biop to NULL since we have alrady completed above */
+		*biop = NULL;
+		kfree(buf);
+		return ret;
+	}
+
+	while (nr_sects) {
+		bio = blk_next_bio(bio, bdev, 0, REQ_OP_VERIFY, gfp_mask);
+		bio->bi_iter.bi_sector = sector;
+
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
+	*biop = bio;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__blkdev_issue_verify);
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
+	sector_t bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
+	struct bio *bio = NULL;
+	struct blk_plug plug;
+	int ret = 0;
+
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
+EXPORT_SYMBOL_GPL(blkdev_issue_verify);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 5abf5aa5a5f0..f19668c1b7bf 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -153,6 +153,20 @@ static struct bio *blk_bio_write_zeroes_split(struct request_queue *q,
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
 /*
  * Return the maximum number of sectors from the start of a bio that may be
  * submitted as a single request to a block device. If enough sectors remain,
@@ -346,6 +360,10 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
 		split = blk_bio_write_zeroes_split(q, *bio, &q->bio_split,
 				nr_segs);
 		break;
+	case REQ_OP_VERIFY:
+		split = blk_bio_verify_split(q, *bio, &q->bio_split,
+				nr_segs);
+		break;
 	default:
 		split = blk_bio_segment_split(q, *bio, &q->bio_split, nr_segs);
 		break;
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 8bb9eef5310e..83fb42d42a91 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -43,6 +43,7 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->max_dev_sectors = 0;
 	lim->chunk_sectors = 0;
 	lim->max_write_zeroes_sectors = 0;
+	lim->max_verify_sectors = 0;
 	lim->max_zone_append_sectors = 0;
 	lim->max_discard_sectors = 0;
 	lim->max_hw_discard_sectors = 0;
@@ -80,6 +81,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
 	lim->max_sectors = UINT_MAX;
 	lim->max_dev_sectors = UINT_MAX;
 	lim->max_write_zeroes_sectors = UINT_MAX;
+	lim->max_verify_sectors = UINT_MAX;
 	lim->max_zone_append_sectors = UINT_MAX;
 }
 EXPORT_SYMBOL(blk_set_stacking_limits);
@@ -202,6 +204,19 @@ void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
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
@@ -554,6 +569,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	t->max_dev_sectors = min_not_zero(t->max_dev_sectors, b->max_dev_sectors);
 	t->max_write_zeroes_sectors = min(t->max_write_zeroes_sectors,
 					b->max_write_zeroes_sectors);
+	t->max_verify_sectors = min(t->max_verify_sectors,
+				    b->max_verify_sectors);
 	t->max_zone_append_sectors = min(t->max_zone_append_sectors,
 					b->max_zone_append_sectors);
 	t->bounce = max(t->bounce, b->bounce);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index c0303026752d..bae72999a230 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -113,6 +113,12 @@ queue_ra_store(struct request_queue *q, const char *page, size_t count)
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
@@ -593,6 +599,7 @@ QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
 
 QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
 QUEUE_RO_ENTRY(queue_write_zeroes_max, "write_zeroes_max_bytes");
+QUEUE_RO_ENTRY(queue_verify_max, "verify_max_bytes");
 QUEUE_RO_ENTRY(queue_zone_append_max, "zone_append_max_bytes");
 QUEUE_RO_ENTRY(queue_zone_write_granularity, "zone_write_granularity");
 
@@ -650,6 +657,7 @@ static struct attribute *queue_attrs[] = {
 	&queue_discard_zeroes_data_entry.attr,
 	&queue_write_same_max_entry.attr,
 	&queue_write_zeroes_max_entry.attr,
+	&queue_verify_max_entry.attr,
 	&queue_zone_append_max_entry.attr,
 	&queue_zone_write_granularity_entry.attr,
 	&queue_nonrot_entry.attr,
diff --git a/block/blk.h b/block/blk.h
index b71e22c97d77..af0a4942812f 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -132,6 +132,9 @@ static inline bool rq_mergeable(struct request *rq)
 	if (req_op(rq) == REQ_OP_WRITE_ZEROES)
 		return false;
 
+	if (req_op(rq) == REQ_OP_VERIFY)
+		return false;
+
 	if (req_op(rq) == REQ_OP_ZONE_APPEND)
 		return false;
 
@@ -169,6 +172,9 @@ static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
 	if (unlikely(op == REQ_OP_WRITE_ZEROES))
 		return q->limits.max_write_zeroes_sectors;
 
+	if (unlikely(op == REQ_OP_VERIFY))
+		return q->limits.max_verify_sectors;
+
 	return q->limits.max_sectors;
 }
 
@@ -299,6 +305,7 @@ static inline bool blk_may_split(struct request_queue *q, struct bio *bio)
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
 	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_VERIFY:
 		return true; /* non-trivial splitting decisions */
 	default:
 		break;
diff --git a/block/ioctl.c b/block/ioctl.c
index 60121e89052b..31094e14f42a 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -192,6 +192,39 @@ static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
 	return err;
 }
 
+static int blk_ioctl_verify(struct block_device *bdev, fmode_t mode,
+		unsigned long arg)
+{
+	uint64_t range[2];
+	struct address_space *mapping;
+	uint64_t start, end, len;
+
+	if (!(mode & FMODE_READ))
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
@@ -483,6 +516,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
 		return blk_ioctl_secure_erase(bdev, mode, argp);
 	case BLKZEROOUT:
 		return blk_ioctl_zeroout(bdev, mode, arg);
+	case BLKVERIFY:
+		return blk_ioctl_verify(bdev, mode, arg);
 	case BLKGETDISKSEQ:
 		return put_u64(argp, bdev->bd_disk->diskseq);
 	case BLKREPORTZONE:
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 992ee987f273..31fa66c23485 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -55,7 +55,8 @@ static inline bool bio_has_data(struct bio *bio)
 	    bio->bi_iter.bi_size &&
 	    bio_op(bio) != REQ_OP_DISCARD &&
 	    bio_op(bio) != REQ_OP_SECURE_ERASE &&
-	    bio_op(bio) != REQ_OP_WRITE_ZEROES)
+	    bio_op(bio) != REQ_OP_WRITE_ZEROES &&
+	    bio_op(bio) != REQ_OP_VERIFY)
 		return true;
 
 	return false;
@@ -65,7 +66,8 @@ static inline bool bio_no_advance_iter(const struct bio *bio)
 {
 	return bio_op(bio) == REQ_OP_DISCARD ||
 	       bio_op(bio) == REQ_OP_SECURE_ERASE ||
-	       bio_op(bio) == REQ_OP_WRITE_ZEROES;
+	       bio_op(bio) == REQ_OP_WRITE_ZEROES ||
+	       bio_op(bio) == REQ_OP_VERIFY;
 }
 
 static inline void *bio_data(struct bio *bio)
@@ -176,7 +178,7 @@ static inline unsigned bio_segments(struct bio *bio)
 	struct bvec_iter iter;
 
 	/*
-	 * We special case discard/write same/write zeroes, because they
+	 * We special case discard/write same/write zeroes/verify, because they
 	 * interpret bi_size differently:
 	 */
 
@@ -184,6 +186,7 @@ static inline unsigned bio_segments(struct bio *bio)
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
 	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_VERIFY:
 		return 0;
 	default:
 		break;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index a24d4078fb21..0d5383fc84ed 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -363,6 +363,8 @@ enum req_opf {
 	REQ_OP_FLUSH		= 2,
 	/* discard sectors */
 	REQ_OP_DISCARD		= 3,
+	/* Verify the sectors */
+	REQ_OP_VERIFY		= 6,
 	/* securely erase sectors */
 	REQ_OP_SECURE_ERASE	= 5,
 	/* write the zero filled sector many times */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 22c477fadc0f..8a44f442af9d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -296,6 +296,7 @@ struct queue_limits {
 	unsigned int		max_hw_discard_sectors;
 	unsigned int		max_secure_erase_sectors;
 	unsigned int		max_write_zeroes_sectors;
+	unsigned int		max_verify_sectors;
 	unsigned int		max_zone_append_sectors;
 	unsigned int		discard_granularity;
 	unsigned int		discard_alignment;
@@ -930,6 +931,8 @@ extern void blk_queue_max_discard_sectors(struct request_queue *q,
 		unsigned int max_discard_sectors);
 extern void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
 		unsigned int max_write_same_sectors);
+extern void blk_queue_max_verify_sectors(struct request_queue *q,
+		unsigned int max_verify_sectors);
 extern void blk_queue_logical_block_size(struct request_queue *, unsigned int);
 extern void blk_queue_max_zone_append_sectors(struct request_queue *q,
 		unsigned int max_zone_append_sectors);
@@ -1079,6 +1082,12 @@ extern int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 extern int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, unsigned flags);
 
+extern int __blkdev_issue_verify(struct block_device *bdev,
+		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
+		struct bio **biop);
+extern int blkdev_issue_verify(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp_mask);
+
 static inline int sb_issue_discard(struct super_block *sb, sector_t block,
 		sector_t nr_blocks, gfp_t gfp_mask, unsigned long flags)
 {
@@ -1253,6 +1262,16 @@ static inline unsigned int bdev_write_zeroes_sectors(struct block_device *bdev)
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
 static inline bool bdev_nonrot(struct block_device *bdev)
 {
 	return blk_queue_nonrot(bdev_get_queue(bdev));
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index bdf7b404b3e7..ad0e5cb5cac4 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -185,6 +185,7 @@ struct fsxattr {
 #define BLKROTATIONAL _IO(0x12,126)
 #define BLKZEROOUT _IO(0x12,127)
 #define BLKGETDISKSEQ _IOR(0x12,128,__u64)
+#define BLKVERIFY _IO(0x12,129)
 /*
  * A jump here: 130-136 are reserved for zoned block devices
  * (see uapi/linux/blkzoned.h)
-- 
2.29.0

