Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F8552C174
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 19:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240902AbiERRL5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 13:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240901AbiERRLr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 13:11:47 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4AF60D87
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 10:11:46 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IFhqb3001870
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 10:11:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=OcInhUsRx51dXvL17G/5A7NhO4ajDUxZ85f5+B1xdbA=;
 b=PbNufXDWABvlfxQOFXSHGbenva9/dp8YRVuBL1Nv9NFqfZgp4IylJ8xY56K5Ds+jem9z
 Zp+QH/oarBKr9cBGDHh+vWToNSb3OarXXJwIiVbSJkbs9Am0hJgl2XVHLIQT2QdI4SWu
 iN9sRzoImRJ++o/z5fMQbHH/4e8/uJpIs7w= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g4p9gd56r-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 10:11:45 -0700
Received: from twshared13345.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 10:11:44 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 28FE0414B925; Wed, 18 May 2022 10:11:32 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/3] direct io alignment relax
Date:   Wed, 18 May 2022 10:11:28 -0700
Message-ID: <20220518171131.3525293-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: F_9nYRp-MTxo5UDxzE1YofhfCXzvCQ-L
X-Proofpoint-GUID: F_9nYRp-MTxo5UDxzE1YofhfCXzvCQ-L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_06,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Including the fs list this time.

I am still working on a better interface to report the dio alignment to
an application. The most recent suggestion of using statx is proving to
be less straight forward than I thought, but I don't want to hold this
series up for that.

Changes from v1:

  Included a prep patch to unify rw with zone append (Damien)

  Using ALIGN macro instead of reimplementing it (Bart)

  Squashed the segment size alignment patch into the "relax" patch since
  the check is only needed because of that patch.

  Fixed a check for short r/w in the _simple case.=20

Keith Busch (3):
  block/bio: remove duplicate append pages code
  block: export dma_alignment attribute
  block: relax direct io memory alignment

 block/bio.c            | 93 +++++++++++++++++++-----------------------
 block/blk-sysfs.c      |  7 ++++
 block/fops.c           | 20 ++++++---
 fs/direct-io.c         | 11 +++--
 fs/iomap/direct-io.c   |  3 +-
 include/linux/blkdev.h |  5 +++
 6 files changed, 76 insertions(+), 63 deletions(-)

--=20
2.30.2

