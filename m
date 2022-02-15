Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F86C4B76CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 21:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242821AbiBOSDq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 13:03:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242809AbiBOSDp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:03:45 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5F1111DE7
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 10:03:35 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21FHtGgV030247
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 10:03:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=htXtNxyUAjQQ07Xq7tQ90zVTmkJEw5VAkMhbwWGqWwY=;
 b=AMwHXzrUujVhzi9o8wzk5k4LY5jJ4S40wutsC5s6zU4TOeQ8xVWqfOJiatRpeJ0TJsfz
 GgFK5p+JhpQ1pooEuuplbmvR+/ZeYCo3zOUOw/xq+cGFd8clDav6poY9KJJqU8hYekA9
 k0UcaxQ2ekQ/Hu9HKgQ8HThi9rp8+FzKI8M= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e8fmu0v0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 10:03:34 -0800
Received: from twshared12416.02.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 10:03:33 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id D5625AC8C96A; Tue, 15 Feb 2022 10:03:29 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <io-uring@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <kernel-team@fb.com>
CC:     <viro@zeniv.linux.org.uk>, <shr@fb.com>
Subject: [PATCH v3 1/2] fs: replace const char* parameter in vfs_statx and do_statx with struct filename
Date:   Tue, 15 Feb 2022 10:03:27 -0800
Message-ID: <20220215180328.2320199-2-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220215180328.2320199-1-shr@fb.com>
References: <20220215180328.2320199-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: dxtsWbbCJO90OJ6CzM5kDbBy3Ki3cxY7
X-Proofpoint-ORIG-GUID: dxtsWbbCJO90OJ6CzM5kDbBy3Ki3cxY7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_05,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 mlxlogscore=934 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202150105
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 fs/stat.c     | 47 ++++++++++++++++++++++++++++++++++-------------
 2 files changed, 37 insertions(+), 14 deletions(-)

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
index 28d2020ba1f4..f0a9702cee67 100644
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
@@ -240,8 +247,15 @@ static int vfs_statx(int dfd, const char __user *fil=
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
+	putname(name);
+
+	return ret;
 }
=20
 #ifdef __ARCH_WANT_OLD_STAT
@@ -602,7 +616,7 @@ cp_statx(const struct kstat *stat, struct statx __use=
r *buffer)
 	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
=20
-int do_statx(int dfd, const char __user *filename, unsigned flags,
+int do_statx(int dfd, struct filename *filename, unsigned int flags,
 	     unsigned int mask, struct statx __user *buffer)
 {
 	struct kstat stat;
@@ -636,7 +650,14 @@ SYSCALL_DEFINE5(statx,
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
+	putname(name);
+
+	return ret;
 }
=20
 #ifdef CONFIG_COMPAT
--=20
2.30.2

