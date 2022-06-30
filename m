Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8FB562485
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 22:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237433AbiF3UnQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 16:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237421AbiF3UnD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:43:03 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0753186D1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:43:02 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UGoxG7001290
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:43:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=MLry2TNqyft+XNkOpEGpBVNauRHTTVwTy2e0E5j67+M=;
 b=DwxWtWwGgFomaFybjRMT97ik8YpL3s0/Qz6AgnhYRPFdXHvpkrJYEUV+9TvUsaOOJ0Mb
 p7uhsvXOnQX5abwLNjBZmaoRllu8kdF7+iHyZJiqHsz2ynI9ZJjx5mp77leIIe5V6TuE
 xnQ+LuJ3WkELTNC7lZEayKWJ7LZw3IOhF8E= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h150eebe6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:43:02 -0700
Received: from twshared5640.09.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 13:43:00 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 228B15932DC4; Thu, 30 Jun 2022 13:42:30 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <willy@infradead.org>, <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 12/12] block: export and document bit_bucket attribute
Date:   Thu, 30 Jun 2022 13:42:12 -0700
Message-ID: <20220630204212.1265638-13-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220630204212.1265638-1-kbusch@fb.com>
References: <20220630204212.1265638-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: WWhVOv2Gp7-CbuKHmw7tvU8RLJFKexsN
X-Proofpoint-ORIG-GUID: WWhVOv2Gp7-CbuKHmw7tvU8RLJFKexsN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_14,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Now that user space applications can make use of partial sector reads,
export and document the queue attribute that indicates if the capability
is supported.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 Documentation/ABI/stable/sysfs-block | 9 +++++++++
 block/blk-sysfs.c                    | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/sta=
ble/sysfs-block
index cd14ecb3c9a5..defc056690d0 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -142,6 +142,15 @@ Description:
 		Default value of this file is '1'(on).
=20
=20
+What:		/sys/block/<disk>/queue/bit_bucket
+Date:		June 2022
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] This file indicates if the device supports partial sector
+		reads.  If set to '1', user space can issue direct IO reads at
+		dma_alignment granularity.
+
+
 What:		/sys/block/<disk>/queue/chunk_sectors
 Date:		September 2016
 Contact:	Hannes Reinecke <hare@suse.com>
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 85ea43eff094..0c1f1c2fbb30 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -309,6 +309,7 @@ QUEUE_SYSFS_BIT_FNS(nonrot, NONROT, 1);
 QUEUE_SYSFS_BIT_FNS(random, ADD_RANDOM, 0);
 QUEUE_SYSFS_BIT_FNS(iostats, IO_STAT, 0);
 QUEUE_SYSFS_BIT_FNS(stable_writes, STABLE_WRITES, 0);
+QUEUE_SYSFS_BIT_FNS(bit_bucket, BIT_BUCKET, 0);
 #undef QUEUE_SYSFS_BIT_FNS
=20
 static ssize_t queue_zoned_show(struct request_queue *q, char *page)
@@ -627,6 +628,7 @@ QUEUE_RW_ENTRY(queue_nonrot, "rotational");
 QUEUE_RW_ENTRY(queue_iostats, "iostats");
 QUEUE_RW_ENTRY(queue_random, "add_random");
 QUEUE_RW_ENTRY(queue_stable_writes, "stable_writes");
+QUEUE_RW_ENTRY(queue_bit_bucket, "bit_bucket");
=20
 static struct attribute *queue_attrs[] =3D {
 	&queue_requests_entry.attr,
@@ -653,6 +655,7 @@ static struct attribute *queue_attrs[] =3D {
 	&queue_zone_append_max_entry.attr,
 	&queue_zone_write_granularity_entry.attr,
 	&queue_nonrot_entry.attr,
+	&queue_bit_bucket_entry.attr,
 	&queue_zoned_entry.attr,
 	&queue_nr_zones_entry.attr,
 	&queue_max_open_zones_entry.attr,
--=20
2.30.2

