Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3656E562478
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 22:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbiF3Umq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 16:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237175AbiF3Umo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:42:44 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EE3646F
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:43 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UG18kI032059
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=0xc3C+DXiwfPrlt4XSU9WIovS0CAm1/2e62U38mNxyc=;
 b=ZFsXMrTM1X8gcmIiwcWiyqIlNCU3OO7An8JzvXGBgo6qoY9vJ2Ppys7HzRhDjgYR+yWO
 6jhppSbO0mJgQMbW00nHDiuoGtvZDHizQIrblgYllWZ4C7FY6Cym9lBxA4KPZKpY/V+I
 SWCVmaNgEh0KIx/QGhr+ZfQETEGAZnAX2UU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h12ug6fyd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:42 -0700
Received: from twshared14577.08.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 13:42:41 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 1293D5932DB4; Thu, 30 Jun 2022 13:42:29 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <willy@infradead.org>, <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 00/12] block: support for partial sector reads
Date:   Thu, 30 Jun 2022 13:42:00 -0700
Message-ID: <20220630204212.1265638-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: mOcD79MxsZaEdRkhXrkJ6RgLbzXFNDoD
X-Proofpoint-ORIG-GUID: mOcD79MxsZaEdRkhXrkJ6RgLbzXFNDoD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_14,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

At LSFMM nearly 2 months ago, I discussed how some storage hardware
supports the ability to read at granularities smaller than a sector, and
the nvme protocol feature that enables this capability, "bit buckets".
This is useful in scenarios where only parts of sectors are used by the
application, and the primary benefits to support this are:

  * Improved link bandwidth usage
  * Reduced memory utilization

This series enables the block layer and nvme to set up bit bucket
descriptors for read commands, then enables user space direct-io to make
use of this capability by allowing the user to specify an arbitrary
offset and length. This allows truncating an arbitrary number of bytes
off sectors from the front and end of the transfer. =20

There are no current in-kernel users beyond the direct-io cases, but
this could also be used for to truncate bytes out of the middle of a
transfer as well. For example, if you wanted to read a page and knew you
wer going to immediately dirty some number of bytes in the middle, you
could set up a read request to skip those in the data transfer.

Keith Busch (12):
  block: move direct io alignment check to common
  iomap: save copy of bdev for direct io
  iomap: get logical block size directly
  iomap: use common blkdev alignment check
  block: add bit bucket capabilities
  nvme: add support for bit buckets
  block: allow copying pre-registered bvecs
  block: add bio number of vecs helper for partials
  block: add partial sector parameter helper
  block: add direct-io partial sector read support
  iomap: add direct io partial sector read support
  block: export and document bit_bucket attribute

 Documentation/ABI/stable/sysfs-block |  9 +++
 block/bio.c                          | 42 +++++++++++-
 block/blk-core.c                     |  5 ++
 block/blk-merge.c                    |  3 +-
 block/blk-mq.c                       |  2 +
 block/blk-sysfs.c                    |  3 +
 block/fops.c                         | 97 ++++++++++++++++++----------
 drivers/nvme/host/core.c             |  3 +
 drivers/nvme/host/nvme.h             |  6 ++
 drivers/nvme/host/pci.c              | 17 ++++-
 fs/iomap/direct-io.c                 | 43 ++++++++----
 include/linux/bio.h                  | 11 ++++
 include/linux/blk-mq.h               |  2 +
 include/linux/blk_types.h            |  1 +
 include/linux/blkdev.h               | 41 ++++++++++++
 include/linux/nvme.h                 |  2 +
 16 files changed, 236 insertions(+), 51 deletions(-)

--=20
2.30.2

