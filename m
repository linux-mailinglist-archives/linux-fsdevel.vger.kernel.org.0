Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28B1531D3D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 23:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiEWVBu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 17:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbiEWVBo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 17:01:44 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0A139BBB
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 14:01:43 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NKGmMu007165
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 14:01:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=5fMjlk145vpbIKp77AqFBrgeVY3SvIMRB4KWULUSKNY=;
 b=B2C3kj7/87URDm1YVOadEpPJFu0LUeaf3B6rcFiQw3EeVLEgXmpyMO1B0gpzIuh7B9ka
 qTaHIs1qQGn4R9r74YTd5FEg1ErGNAbcIuCVWzd+gupGs3cLNqJM6OTHTLpm9CWmXzSl
 gCaO2Z4RJLC/ggl0ommT0hBehoL6TSfbbeY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g7g6d0my9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 14:01:43 -0700
Received: from twshared8508.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 23 May 2022 14:01:39 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 5CB19446414C; Mon, 23 May 2022 14:01:34 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 0/6] direct io dma alignment
Date:   Mon, 23 May 2022 14:01:13 -0700
Message-ID: <20220523210119.2500150-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: GBNEy7JQL2kF0OZ3v7qdQ8leCmFBZ_i3
X-Proofpoint-GUID: GBNEy7JQL2kF0OZ3v7qdQ8leCmFBZ_i3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-23_09,2022-05-23_01,2022-02-23_01
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Here is the 3rd version enabling non-block aligned user space addresses
for O_DIRECT.

Changes since v2:

  Folded in improvements cleanin gup zone append pages (Christoph)

  Added documentation the exported attribute (Bart)

  Split bdev_dma_alignment() into its own patch (Christoph)

  Removed fs/ from implementing support for these address offsets for
  now

  Fixed up a couple places assuming SECTOR_SIZE multiple bv_len

On that last point, I searched through much of the code and found a few
other places that also assumed this bv_len size, but they didn't apply
to this change since they don't set 'dma_alignment'. This got me
thinking, though, should this be a new attribute, 'dio_alignment',
instead of using the pre-existing 'dma_alignment' for this purpose? Or
is it clear enough that drivers setting the existing attribute ought to
know what they're getting into?

Keith Busch (6):
  block/bio: remove duplicate append pages code
  block: export dma_alignment attribute
  block: introduce bdev_dma_alignment helper
  block/merge: count bytes instead of sectors
  block/bounce: count bytes instead of sectors
  block: relax direct io memory alignment

 Documentation/ABI/stable/sysfs-block |   9 ++
 block/bio.c                          | 118 +++++++++++++--------------
 block/blk-merge.c                    |  35 ++++----
 block/blk-sysfs.c                    |   7 ++
 block/bounce.c                       |   5 +-
 block/fops.c                         |  41 +++++++---
 include/linux/blkdev.h               |   5 ++
 7 files changed, 127 insertions(+), 93 deletions(-)

--=20
2.30.2

