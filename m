Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848E952C7BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 01:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiERXiJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 19:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbiERXhr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 19:37:47 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494F480236
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 16:37:40 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IN6GY7013654
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 16:37:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=YjR6bHdDemShrFnRSFoy0SU6vrzP5IeqvXhPCERFUGY=;
 b=Vj84wixRIzTnyHpWspgB0LqWOEa3kEBDkIN2GPDg1axkr+4mlCqzGxYxuTQekvkAuC7f
 uhj6Wa7ItvBct86J1Y/Lab7Iaeq+7Xy0LRtsNKQAXTKwr2aXETCmbbPAhubBEactY4Ke
 A0FmkwAv+xzeq45zTlaehPwhpn28aYQNIrY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g4dea3tkx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 16:37:39 -0700
Received: from twshared8307.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 18 May 2022 16:37:38 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id DD709F3ED863; Wed, 18 May 2022 16:37:12 -0700 (PDT)
From:   Stefan Roesch <shr@fb.com>
To:     <io-uring@vger.kernel.org>, <kernel-team@fb.com>,
        <linux-mm@kvack.org>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <shr@fb.com>, <david@fromorbit.com>, <jack@suse.cz>
Subject: [RFC PATCH v3 09/18] fs: Optimization for concurrent file time updates.
Date:   Wed, 18 May 2022 16:37:00 -0700
Message-ID: <20220518233709.1937634-10-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220518233709.1937634-1-shr@fb.com>
References: <20220518233709.1937634-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Gk7U6rbLdfClBmNJ5zhjjsFfLJoAp-p9
X-Proofpoint-GUID: Gk7U6rbLdfClBmNJ5zhjjsFfLJoAp-p9
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
index 3a5d0fa468ab..5c5021787780 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2184,10 +2184,17 @@ int file_modified_async(struct file *file, int fl=
ags)
 	ret =3D file_needs_update_time(inode, file, &now);
 	if (ret <=3D 0)
 		return ret;
-	if (flags & IOCB_NOWAIT)
+	if (flags & IOCB_NOWAIT) {
+		if (IS_PENDING_TIME(inode))
+			return 0;
+
+		inode->i_flags |=3D S_PENDING_TIME;
 		return -EAGAIN;
+	}
=20
-	return __file_update_time(inode, file, &now, ret);
+	ret =3D __file_update_time(inode, file, &now, ret);
+	inode->i_flags &=3D ~S_PENDING_TIME;
+	return ret;
 }
 EXPORT_SYMBOL(file_modified_async);
=20
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9760283af7dc..5f3aaf61fb4b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2141,6 +2141,8 @@ struct super_operations {
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
@@ -2183,6 +2185,7 @@ static inline bool sb_rdonly(const struct super_blo=
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

