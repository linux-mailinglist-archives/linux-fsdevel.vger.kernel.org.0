Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4E14AFDA8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 20:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiBITqE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 14:46:04 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiBITqD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 14:46:03 -0500
X-Greylist: delayed 1526 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 11:46:01 PST
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1345E01B0C7
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 11:46:01 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 219HJAaO019579
        for <linux-fsdevel@vger.kernel.org>; Wed, 9 Feb 2022 11:04:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=fZvcR926EtNpnnZ9VWlpiAHVZXDMxwKgWPyBPNM1S2Q=;
 b=R92NQnyUePL1kWo4TynEXRnt0VfK7WUuNvGaFJ4W6Ql4MUVEJkmNkkafrPJwnidvvsad
 GvS5r9LNNQb/ve37X5wGhnaN5HvKyOUXfZHJb3nBJtODgL0yJUui+MXJgCAaHu5j9Yj1
 omBOX9ApPYoW5pqtu8hoGuOS/7VKMpPQuws= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3e4ha094vj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Feb 2022 11:04:02 -0800
Received: from twshared14630.35.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Feb 2022 11:03:59 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 37A10A855532; Wed,  9 Feb 2022 11:03:52 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <io-uring@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <kernel-team@fb.com>
CC:     <viro@zeniv.linux.org.uk>, <shr@fb.com>
Subject: [PATCH v1 1/2] fs: replace const char* parameter in vfs_statx and do_statx with struct filename
Date:   Wed, 9 Feb 2022 11:03:44 -0800
Message-ID: <20220209190345.2374478-2-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220209190345.2374478-1-shr@fb.com>
References: <20220209190345.2374478-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: B0A6Dl3RzCNjiL-qYM181SDjIM-v6zI0
X-Proofpoint-GUID: B0A6Dl3RzCNjiL-qYM181SDjIM-v6zI0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-09_10,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 impostorscore=0 clxscore=1011 mlxlogscore=924 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202090101
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This replaces the const char* __user filename parameter in the two
functions do_statx and vfs_statx with a struct filename *. In addition
to be able to correctly construct a filename object a new helper
function getname_statx_lookup_flags is introduced. The function makes
sure that do_statx and vfs_statx is invoked with the correct lookup flags=
.

Signed-off-by: Stefan Roesch <shr@fb.com>
---
 fs/internal.h |  4 +++-
 fs/stat.c     | 49 ++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 8590c973c2f4..56c0477f4215 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -184,7 +184,9 @@ int sb_init_dio_done_wq(struct super_block *sb);
 /*
  * fs/stat.c:
  */
-int do_statx(int dfd, const char __user *filename, unsigned flags,
+
+int getname_statx_lookup_flags(int flags);
+int do_statx(int dfd, struct filename *filename, unsigned int flags,
 	     unsigned int mask, struct statx __user *buffer);
=20
 /*
diff --git a/fs/stat.c b/fs/stat.c
index 28d2020ba1f4..6a11cfe6a849 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -184,6 +184,20 @@ int vfs_fstat(int fd, struct kstat *stat)
 	return error;
 }
=20
+int getname_statx_lookup_flags(int flags)
+{
+	int lookup_flags =3D 0;
+
+	if (!(flags & AT_SYMLINK_NOFOLLOW))
+		lookup_flags |=3D LOOKUP_FOLLOW;
+	if (!(flags & AT_NO_AUTOMOUNT))
+		lookup_flags |=3D LOOKUP_AUTOMOUNT;
+	if (flags & AT_EMPTY_PATH)
+		lookup_flags |=3D LOOKUP_EMPTY;
+
+	return lookup_flags;
+}
+
 /**
  * vfs_statx - Get basic and extra attributes by filename
  * @dfd: A file descriptor representing the base dir for a relative file=
name
@@ -199,7 +213,7 @@ int vfs_fstat(int fd, struct kstat *stat)
  *
  * 0 will be returned on success, and a -ve error code if unsuccessful.
  */
-static int vfs_statx(int dfd, const char __user *filename, int flags,
+static int vfs_statx(int dfd, struct filename *filename, int flags,
 	      struct kstat *stat, u32 request_mask)
 {
 	struct path path;
@@ -210,15 +224,8 @@ static int vfs_statx(int dfd, const char __user *fil=
ename, int flags,
 		      AT_STATX_SYNC_TYPE))
 		return -EINVAL;
=20
-	if (!(flags & AT_SYMLINK_NOFOLLOW))
-		lookup_flags |=3D LOOKUP_FOLLOW;
-	if (!(flags & AT_NO_AUTOMOUNT))
-		lookup_flags |=3D LOOKUP_AUTOMOUNT;
-	if (flags & AT_EMPTY_PATH)
-		lookup_flags |=3D LOOKUP_EMPTY;
-
 retry:
-	error =3D user_path_at(dfd, filename, lookup_flags, &path);
+	error =3D filename_lookup(dfd, filename, flags, &path, NULL);
 	if (error)
 		goto out;
=20
@@ -240,8 +247,16 @@ static int vfs_statx(int dfd, const char __user *fil=
ename, int flags,
 int vfs_fstatat(int dfd, const char __user *filename,
 			      struct kstat *stat, int flags)
 {
-	return vfs_statx(dfd, filename, flags | AT_NO_AUTOMOUNT,
-			 stat, STATX_BASIC_STATS);
+	int ret;
+	int statx_flags =3D flags | AT_NO_AUTOMOUNT;
+	struct filename *name;
+
+	name =3D getname_flags(filename, getname_statx_lookup_flags(statx_flags=
), NULL);
+	ret =3D vfs_statx(dfd, name, statx_flags, stat, STATX_BASIC_STATS);
+	if (name)
+		putname(name);
+
+	return ret;
 }
=20
 #ifdef __ARCH_WANT_OLD_STAT
@@ -602,7 +617,7 @@ cp_statx(const struct kstat *stat, struct statx __use=
r *buffer)
 	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
=20
-int do_statx(int dfd, const char __user *filename, unsigned flags,
+int do_statx(int dfd, struct filename *filename, unsigned int flags,
 	     unsigned int mask, struct statx __user *buffer)
 {
 	struct kstat stat;
@@ -636,7 +651,15 @@ SYSCALL_DEFINE5(statx,
 		unsigned int, mask,
 		struct statx __user *, buffer)
 {
-	return do_statx(dfd, filename, flags, mask, buffer);
+	int ret;
+	struct filename *name;
+
+	name =3D getname_flags(filename, getname_statx_lookup_flags(flags), NUL=
L);
+	ret =3D do_statx(dfd, name, flags, mask, buffer);
+	if (name)
+		putname(name);
+
+	return ret;
 }
=20
 #ifdef CONFIG_COMPAT
--=20
2.30.2

