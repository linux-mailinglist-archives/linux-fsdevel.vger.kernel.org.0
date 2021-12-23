Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892CF47E890
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 20:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350189AbhLWT5j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 14:57:39 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7246 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242793AbhLWT5j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 14:57:39 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BNIWh2E002070
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 11:57:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=sfgxVwJ9IP6g1wkkUcez7qG7wz4P+WMthgIrdf2aTOs=;
 b=nzshbt42Q2fgW+WR92OuUeMfbUFhlB193akhGpG3BQEWlKXKFOQjt+GnIJfEPZetl65w
 alnLgJU9qtGzl9+1vboKnMCjWLtcxVhqOnzGksDhoFBSMOHNUxddUE0MY4g9i9F4OZMy
 DgJlmkYFcqzYLksw7iHi0GtIQZePIot5QOE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d4ftd5se6-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 11:57:39 -0800
Received: from twshared7572.23.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 23 Dec 2021 11:57:12 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id BDB7887A0749; Thu, 23 Dec 2021 11:57:08 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <io-uring@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <kernel-team@fb.com>
CC:     <torvalds@linux-foundation.org>, <christian.brauner@ubuntu.com>,
        <shr@fb.com>
Subject: [PATCH v7 1/5] fs: split off do_user_path_at_empty from user_path_at_empty()
Date:   Thu, 23 Dec 2021 11:56:54 -0800
Message-ID: <20211223195658.2805049-2-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211223195658.2805049-1-shr@fb.com>
References: <20211223195658.2805049-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: cEWi27fGdZ5F3C_oKjArqED7FxJS8dvR
X-Proofpoint-GUID: cEWi27fGdZ5F3C_oKjArqED7FxJS8dvR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-23_04,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=632 impostorscore=0 clxscore=1015
 phishscore=0 mlxscore=0 adultscore=1 priorityscore=1501 spamscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112230102
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This splits off a do_user_path_at_empty function from the
user_path_at_empty_function. This is required so it can be
called from io_uring.

Signed-off-by: Stefan Roesch <shr@fb.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/namei.c            | 10 ++++++++--
 include/linux/namei.h |  2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 1f9d2187c765..d988e241b32c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2794,12 +2794,18 @@ int path_pts(struct path *path)
 }
 #endif
=20
+int do_user_path_at_empty(int dfd, struct filename *filename, unsigned i=
nt flags,
+		       struct path *path)
+{
+	return filename_lookup(dfd, filename, flags, path, NULL);
+}
+
 int user_path_at_empty(int dfd, const char __user *name, unsigned flags,
-		 struct path *path, int *empty)
+		struct path *path, int *empty)
 {
 	struct filename *filename =3D getname_flags(name, flags, empty);
-	int ret =3D filename_lookup(dfd, filename, flags, path, NULL);
=20
+	int ret =3D do_user_path_at_empty(dfd, filename, flags, path);
 	putname(filename);
 	return ret;
 }
diff --git a/include/linux/namei.h b/include/linux/namei.h
index e89329bb3134..8f3ef38c057b 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -49,6 +49,8 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
=20
 extern int path_pts(struct path *path);
=20
+extern int do_user_path_at_empty(int dfd, struct filename *filename,
+				unsigned int flags, struct path *path);
 extern int user_path_at_empty(int, const char __user *, unsigned, struct=
 path *, int *empty);
=20
 static inline int user_path_at(int dfd, const char __user *name, unsigne=
d flags,
--=20
2.30.2

