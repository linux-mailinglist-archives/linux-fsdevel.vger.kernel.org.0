Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A96253AEC0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jun 2022 00:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiFAVIM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 17:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiFAVIK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:08:10 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E2F4D603
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jun 2022 14:08:08 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 251KQDXi028690
        for <linux-fsdevel@vger.kernel.org>; Wed, 1 Jun 2022 14:08:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=UYSVIRU3OqHDXp36Z+9UaO8Gk0kt2REYQWE1ANvgX7U=;
 b=keoA+bCwpvGGQ1fvUj6GcBQX1BHxuhWSDiLo4Tmnx/ljZ8LiieXiVZqgCD2ps9ArT8EY
 gcqVboNEm4BG1v0IQ6EAs7E8Sr9FPdRDNdPfe5JNLIgMyNSaBfqXZSYN5vuEX4CsDV6s
 GgNCOmmUeyLvyfJpuPwMC/i53PfXILMmum0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gdt5jqgua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jun 2022 14:08:08 -0700
Received: from twshared19572.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 1 Jun 2022 14:08:07 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 167ACFEB23B1; Wed,  1 Jun 2022 14:01:43 -0700 (PDT)
From:   Stefan Roesch <shr@fb.com>
To:     <io-uring@vger.kernel.org>, <kernel-team@fb.com>,
        <linux-mm@kvack.org>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <shr@fb.com>, <david@fromorbit.com>, <jack@suse.cz>,
        <hch@infradead.org>, <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 14/15] xfs: Specify lockmode when calling xfs_ilock_for_iomap()
Date:   Wed, 1 Jun 2022 14:01:40 -0700
Message-ID: <20220601210141.3773402-15-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220601210141.3773402-1-shr@fb.com>
References: <20220601210141.3773402-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: _GedpGgVXpoFI-KcodA1_7xPe8qpMSdB
X-Proofpoint-ORIG-GUID: _GedpGgVXpoFI-KcodA1_7xPe8qpMSdB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-01_08,2022-06-01_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch changes the helper function xfs_ilock_for_iomap such that the
lock mode must be passed in.

Signed-off-by: Stefan Roesch <shr@fb.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_iomap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 5a393259a3a3..bcf7c3694290 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -664,7 +664,7 @@ xfs_ilock_for_iomap(
 	unsigned		flags,
 	unsigned		*lockmode)
 {
-	unsigned		mode =3D XFS_ILOCK_SHARED;
+	unsigned int		mode =3D *lockmode;
 	bool			is_write =3D flags & (IOMAP_WRITE | IOMAP_ZERO);
=20
 	/*
@@ -742,7 +742,7 @@ xfs_direct_write_iomap_begin(
 	int			nimaps =3D 1, error =3D 0;
 	bool			shared =3D false;
 	u16			iomap_flags =3D 0;
-	unsigned		lockmode;
+	unsigned int		lockmode =3D XFS_ILOCK_SHARED;
=20
 	ASSERT(flags & (IOMAP_WRITE | IOMAP_ZERO));
=20
@@ -1172,7 +1172,7 @@ xfs_read_iomap_begin(
 	xfs_fileoff_t		end_fsb =3D xfs_iomap_end_fsb(mp, offset, length);
 	int			nimaps =3D 1, error =3D 0;
 	bool			shared =3D false;
-	unsigned		lockmode;
+	unsigned int		lockmode =3D XFS_ILOCK_SHARED;
=20
 	ASSERT(!(flags & (IOMAP_WRITE | IOMAP_ZERO)));
=20
--=20
2.30.2

