Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811AD595F12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 17:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbiHPPcO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 11:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiHPPcN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:32:13 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542872CDC2
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 08:32:12 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27G9iUZm007814
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 08:32:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=/KaIcMcV84Dg4vZ2PiA0ZIN1zYSdvpwEuPossdWMqTI=;
 b=ijdZyR89a7aE5D6XqE6FfEvxxKWcqtTW3pDpC1KzIZoHcypizIcx0hgV7pmc9TwcZe9/
 scEGCNjV0vFei+WF/fK2xYNJY4kF9BRME0bTXb/2NW38Eng/hSAyd+3b++sZccqKhsH7
 BqI4eHr2QC4A9QAbrLwb5k2piqLkdutIL2k= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3j08vdt2d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 08:32:11 -0700
Received: from twshared7570.37.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 16 Aug 2022 08:32:09 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id E6BA212BD9495; Tue, 16 Aug 2022 08:32:02 -0700 (PDT)
From:   Stefan Roesch <shr@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>, <jack@suse.cz>, <hch@lst.de>, <axboe@kernel.dk>,
        <djwong@kernel.org>, <brauner@kernel.org>
Subject: [PATCH v1] fs: __file_remove_privs(): restore call to inode_has_no_xattr()
Date:   Tue, 16 Aug 2022 08:31:58 -0700
Message-ID: <20220816153158.1925040-1-shr@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 6zxHlY5Axz22Q2re9UToP374TizbFst2
X-Proofpoint-ORIG-GUID: 6zxHlY5Axz22Q2re9UToP374TizbFst2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This restores the call to inode_has_no_xattr() in the function
__file_remove_privs(). In case the dentry_meeds_remove_privs() returned
0, the function inode_has_no_xattr() was not called.

Signed-off-by: Stefan Roesch <shr@fb.com>
---
 fs/inode.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 6462276dfdf0..ba1de23c13c1 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2018,23 +2018,25 @@ static int __file_remove_privs(struct file *file,=
 unsigned int flags)
 {
 	struct dentry *dentry =3D file_dentry(file);
 	struct inode *inode =3D file_inode(file);
-	int error;
+	int error =3D 0;
 	int kill;
=20
 	if (IS_NOSEC(inode) || !S_ISREG(inode->i_mode))
 		return 0;
=20
 	kill =3D dentry_needs_remove_privs(dentry);
-	if (kill <=3D 0)
+	if (kill < 0)
 		return kill;
=20
-	if (flags & IOCB_NOWAIT)
-		return -EAGAIN;
+	if (kill) {
+		if (flags & IOCB_NOWAIT)
+			return -EAGAIN;
+
+		error =3D __remove_privs(file_mnt_user_ns(file), dentry, kill);
+	}
=20
-	error =3D __remove_privs(file_mnt_user_ns(file), dentry, kill);
 	if (!error)
 		inode_has_no_xattr(inode);
-
 	return error;
 }
=20
--=20
2.30.2

