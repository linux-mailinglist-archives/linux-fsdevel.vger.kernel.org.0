Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C56531D40
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 23:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiEWVCA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 17:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiEWVB4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 17:01:56 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D821544CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 14:01:53 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24NKGTX0006564
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 14:01:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ilot6pF2tnHcFgaXZ5dBLN2SL/JleYqHLnnHZG/ZMrY=;
 b=NWzM4z0yrVK6M8HqzbubslSNH2njepeMor6vTNfJmpMugXHZG/qU+JJMG2OluNSrD8+4
 AwYYYrkmiRYidvqJ0PFUM4OnJWaVXloKlO7p2XTs3NfGQMgadmFz7DvEHQ9AYTsADl1r
 czGI9FOdENUF+EUH+1jtI/nU8ly0HrA6egA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3g6uk7m7cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 14:01:52 -0700
Received: from twshared8508.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 23 May 2022 14:01:51 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 8C8934464152; Mon, 23 May 2022 14:01:34 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 2/6] block: export dma_alignment attribute
Date:   Mon, 23 May 2022 14:01:15 -0700
Message-ID: <20220523210119.2500150-3-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220523210119.2500150-1-kbusch@fb.com>
References: <20220523210119.2500150-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: FxErUe1wQQuvBldbX_tPib8-qKO8cnkx
X-Proofpoint-GUID: FxErUe1wQQuvBldbX_tPib8-qKO8cnkx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-23_09,2022-05-23_01,2022-02-23_01
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

User space may want to know how to align their buffers to avoid
bouncing. Export the queue attribute.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v2->v3:

  Added Documentation (Bart)

 Documentation/ABI/stable/sysfs-block | 9 +++++++++
 block/blk-sysfs.c                    | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/sta=
ble/sysfs-block
index e8797cd09aff..08f6d00df138 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -142,6 +142,15 @@ Description:
 		Default value of this file is '1'(on).
=20
=20
+What:		/sys/block/<disk>/queue/dma_alignment
+Date:		May 2022
+Contact:	linux-block@vger.kernel.org
+Description:
+		Reports the alignment that user space addresses must have to be
+		used for raw block device access with O_DIRECT and other driver
+		specific passthrough mechanisms.
+
+
 What:		/sys/block/<disk>/queue/chunk_sectors
 Date:		September 2016
 Contact:	Hannes Reinecke <hare@suse.com>
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 88bd41d4cb59..14607565d781 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -274,6 +274,11 @@ static ssize_t queue_virt_boundary_mask_show(struct =
request_queue *q, char *page
 	return queue_var_show(q->limits.virt_boundary_mask, page);
 }
=20
+static ssize_t queue_dma_alignment_show(struct request_queue *q, char *p=
age)
+{
+	return queue_var_show(queue_dma_alignment(q), page);
+}
+
 #define QUEUE_SYSFS_BIT_FNS(name, flag, neg)				\
 static ssize_t								\
 queue_##name##_show(struct request_queue *q, char *page)		\
@@ -606,6 +611,7 @@ QUEUE_RO_ENTRY(queue_dax, "dax");
 QUEUE_RW_ENTRY(queue_io_timeout, "io_timeout");
 QUEUE_RW_ENTRY(queue_wb_lat, "wbt_lat_usec");
 QUEUE_RO_ENTRY(queue_virt_boundary_mask, "virt_boundary_mask");
+QUEUE_RO_ENTRY(queue_dma_alignment, "dma_alignment");
=20
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 QUEUE_RW_ENTRY(blk_throtl_sample_time, "throttle_sample_time");
@@ -667,6 +673,7 @@ static struct attribute *queue_attrs[] =3D {
 	&blk_throtl_sample_time_entry.attr,
 #endif
 	&queue_virt_boundary_mask_entry.attr,
+	&queue_dma_alignment_entry.attr,
 	NULL,
 };
=20
--=20
2.30.2

