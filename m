Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D383A52C7C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 01:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiERXiK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 19:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiERXhr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 19:37:47 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A95770915
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 16:37:39 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IN6DJa006231
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 16:37:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=LWT7/rgVKJvUBvBuLFTZOcg1EE8pCJNmk5mdhmfBzd4=;
 b=i6RESA2kBFbZf2YcYKS9NClp2rdwS4z3e5YrkTDrp5aQB3JPLVdlytwpVGLaoojFgIFG
 fOUNWAAU+p9M23iJxh3uuhMsjYlkvF+SRyBlyCNt0jLDi1Sv6Nr8XAD0gZrBAN1rVLay
 VV1wCr4qjitYxB6F7cIAO1jZh82uTcaZ7Ec= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g3yq0g84g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 16:37:39 -0700
Received: from twshared4937.07.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 18 May 2022 16:37:38 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id E5A10F3ED865; Wed, 18 May 2022 16:37:12 -0700 (PDT)
From:   Stefan Roesch <shr@fb.com>
To:     <io-uring@vger.kernel.org>, <kernel-team@fb.com>,
        <linux-mm@kvack.org>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <shr@fb.com>, <david@fromorbit.com>, <jack@suse.cz>
Subject: [RFC PATCH v3 10/18] xfs: Add async buffered write support
Date:   Wed, 18 May 2022 16:37:01 -0700
Message-ID: <20220518233709.1937634-11-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220518233709.1937634-1-shr@fb.com>
References: <20220518233709.1937634-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: YULpAGAIrk-OwLpyrTMJIRVBLQbPfjh_
X-Proofpoint-ORIG-GUID: YULpAGAIrk-OwLpyrTMJIRVBLQbPfjh_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_06,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the async buffered write support to XFS. For async buffered
write requests, the request will return -EAGAIN if the ilock cannot be
obtained immediately.

This splits off a new helper xfs_ilock_inode from the existing helper
xfs_ilock_iocb so it can be used for this function. The exising helper
cannot be used as it hardcoded the inode to be used.

Signed-off-by: Stefan Roesch <shr@fb.com>
---
 fs/xfs/xfs_file.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 793918c83755..ad3175b7d366 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -190,14 +190,13 @@ xfs_file_fsync(
 	return error;
 }
=20
-static int
-xfs_ilock_iocb(
-	struct kiocb		*iocb,
+static inline int
+xfs_ilock_xfs_inode(
+	struct xfs_inode	*ip,
+	int			flags,
 	unsigned int		lock_mode)
 {
-	struct xfs_inode	*ip =3D XFS_I(file_inode(iocb->ki_filp));
-
-	if (iocb->ki_flags & IOCB_NOWAIT) {
+	if (flags & IOCB_NOWAIT) {
 		if (!xfs_ilock_nowait(ip, lock_mode))
 			return -EAGAIN;
 	} else {
@@ -222,7 +221,7 @@ xfs_file_dio_read(
=20
 	file_accessed(iocb->ki_filp);
=20
-	ret =3D xfs_ilock_iocb(iocb, XFS_IOLOCK_SHARED);
+	ret =3D xfs_ilock_xfs_inode(ip, iocb->ki_flags, XFS_IOLOCK_SHARED);
 	if (ret)
 		return ret;
 	ret =3D iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL, 0, 0);
@@ -244,7 +243,7 @@ xfs_file_dax_read(
 	if (!iov_iter_count(to))
 		return 0; /* skip atime */
=20
-	ret =3D xfs_ilock_iocb(iocb, XFS_IOLOCK_SHARED);
+	ret =3D xfs_ilock_xfs_inode(ip, iocb->ki_flags, XFS_IOLOCK_SHARED);
 	if (ret)
 		return ret;
 	ret =3D dax_iomap_rw(iocb, to, &xfs_read_iomap_ops);
@@ -264,7 +263,7 @@ xfs_file_buffered_read(
=20
 	trace_xfs_file_buffered_read(iocb, to);
=20
-	ret =3D xfs_ilock_iocb(iocb, XFS_IOLOCK_SHARED);
+	ret =3D xfs_ilock_xfs_inode(ip, iocb->ki_flags, XFS_IOLOCK_SHARED);
 	if (ret)
 		return ret;
 	ret =3D generic_file_read_iter(iocb, to);
@@ -343,7 +342,7 @@ xfs_file_write_checks(
 	if (*iolock =3D=3D XFS_IOLOCK_SHARED && !IS_NOSEC(inode)) {
 		xfs_iunlock(ip, *iolock);
 		*iolock =3D XFS_IOLOCK_EXCL;
-		error =3D xfs_ilock_iocb(iocb, *iolock);
+		error =3D xfs_ilock_xfs_inode(ip, iocb->ki_flags, *iolock);
 		if (error) {
 			*iolock =3D 0;
 			return error;
@@ -516,7 +515,7 @@ xfs_file_dio_write_aligned(
 	int			iolock =3D XFS_IOLOCK_SHARED;
 	ssize_t			ret;
=20
-	ret =3D xfs_ilock_iocb(iocb, iolock);
+	ret =3D xfs_ilock_xfs_inode(ip, iocb->ki_flags, iolock);
 	if (ret)
 		return ret;
 	ret =3D xfs_file_write_checks(iocb, from, &iolock);
@@ -583,7 +582,7 @@ xfs_file_dio_write_unaligned(
 		flags =3D IOMAP_DIO_FORCE_WAIT;
 	}
=20
-	ret =3D xfs_ilock_iocb(iocb, iolock);
+	ret =3D xfs_ilock_xfs_inode(ip, iocb->ki_flags, iolock);
 	if (ret)
 		return ret;
=20
@@ -659,7 +658,7 @@ xfs_file_dax_write(
 	ssize_t			ret, error =3D 0;
 	loff_t			pos;
=20
-	ret =3D xfs_ilock_iocb(iocb, iolock);
+	ret =3D xfs_ilock_xfs_inode(ip, iocb->ki_flags, iolock);
 	if (ret)
 		return ret;
 	ret =3D xfs_file_write_checks(iocb, from, &iolock);
@@ -702,12 +701,11 @@ xfs_file_buffered_write(
 	bool			cleared_space =3D false;
 	int			iolock;
=20
-	if (iocb->ki_flags & IOCB_NOWAIT)
-		return -EOPNOTSUPP;
-
 write_retry:
 	iolock =3D XFS_IOLOCK_EXCL;
-	xfs_ilock(ip, iolock);
+	ret =3D xfs_ilock_xfs_inode(ip, iocb->ki_flags, iolock);
+	if (ret)
+		return ret;
=20
 	ret =3D xfs_file_write_checks(iocb, from, &iolock);
 	if (ret)
--=20
2.30.2

