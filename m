Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE555346B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 00:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343784AbiEYWhF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 18:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345505AbiEYWfD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 18:35:03 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DBE101F3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 15:35:01 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24PGtZ5A009395
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 15:35:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=BE5eLO5Z7AZICxMCDTAcJeiKudbeydb7d4UMFp50BLA=;
 b=I2su/43ctP7xinp5heyI+ieMK5r2Aa9OkURbSwM+dAE8k7Mb3x6fOD61S0gdvEcdg/Bh
 MuF36VB4cZWS2A+fvxnRbpgPddhdop/wFcEFMIt1mH0n/6BSZptJMARdlk4U5eGA1Fgz
 xGCt07tFT5Su2+LeYS4VgZF5YfYArBg9UWk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3g93tx1dpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 15:35:00 -0700
Received: from twshared4937.07.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 25 May 2022 15:34:53 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 2AD47F9E1B6C; Wed, 25 May 2022 15:34:35 -0700 (PDT)
From:   Stefan Roesch <shr@fb.com>
To:     <io-uring@vger.kernel.org>, <kernel-team@fb.com>,
        <linux-mm@kvack.org>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <shr@fb.com>, <david@fromorbit.com>, <jack@suse.cz>,
        <hch@infradead.org>
Subject: [PATCH v5 10/16] fs: Optimization for concurrent file time updates.
Date:   Wed, 25 May 2022 15:34:26 -0700
Message-ID: <20220525223432.205676-11-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220525223432.205676-1-shr@fb.com>
References: <20220525223432.205676-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TVm8hcsiRkRuePL_V8eLdSFKsp-RswUp
X-Proofpoint-GUID: TVm8hcsiRkRuePL_V8eLdSFKsp-RswUp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-25_06,2022-05-25_02,2022-02-23_01
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

This introduces the S_PENDING_TIME flag. If an async buffered write
needs to update the time, it cannot be processed in the fast path of
io-uring. When a time update is pending this flag is set for async
buffered writes. Other concurrent async buffered writes for the same
file do not need to wait while this time update is pending.

This reduces the number of async buffered writes that need to get punted
to the io-workers in io-uring.

Signed-off-by: Stefan Roesch <shr@fb.com>
---
 fs/inode.c         | 11 +++++++++--
 include/linux/fs.h |  3 +++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 4503bed063e7..7185d860d423 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2150,10 +2150,17 @@ static int file_modified_flags(struct file *file,=
 int flags)
 	ret =3D inode_needs_update_time(inode, &now);
 	if (ret <=3D 0)
 		return ret;
-	if (flags & IOCB_NOWAIT)
+	if (flags & IOCB_NOWAIT) {
+		if (IS_PENDING_TIME(inode))
+			return 0;
+
+		inode_set_flags(inode, S_PENDING_TIME, S_PENDING_TIME);
 		return -EAGAIN;
+	}
=20
-	return __file_update_time(file, &now, ret);
+	ret =3D __file_update_time(file, &now, ret);
+	inode_set_flags(inode, 0, S_PENDING_TIME);
+	return ret;
 }
=20
 /**
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2d9b3afcb4a5..5924c90eab1d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2143,6 +2143,8 @@ struct super_operations {
 #define S_CASEFOLD	(1 << 15) /* Casefolded file */
 #define S_VERITY	(1 << 16) /* Verity file (using fs/verity/) */
 #define S_KERNEL_FILE	(1 << 17) /* File is in use by the kernel (eg. fs/=
cachefiles) */
+#define S_PENDING_TIME (1 << 18) /* File update time is pending */
+
=20
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-syst=
em
@@ -2185,6 +2187,7 @@ static inline bool sb_rdonly(const struct super_blo=
ck *sb) { return sb->s_flags
 #define IS_ENCRYPTED(inode)	((inode)->i_flags & S_ENCRYPTED)
 #define IS_CASEFOLDED(inode)	((inode)->i_flags & S_CASEFOLD)
 #define IS_VERITY(inode)	((inode)->i_flags & S_VERITY)
+#define IS_PENDING_TIME(inode) ((inode)->i_flags & S_PENDING_TIME)
=20
 #define IS_WHITEOUT(inode)	(S_ISCHR(inode->i_mode) && \
 				 (inode)->i_rdev =3D=3D WHITEOUT_DEV)
--=20
2.30.2

