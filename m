Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8AE60D155
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 18:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbiJYQKd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 12:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiJYQKc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:10:32 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DBC4CA3A
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 09:10:28 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PAeRZ5024110
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 09:10:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=cnJAlRNjjZ1/Vws6zXuXdLgYHM8iDjJgG8N5E8KWuLo=;
 b=lmPFyqx2Yz+S9BgDBpGPNuUhqf7jPLkRgNSIBChjNek79BtPc1LQcELhxVIRANX9rR7F
 kEjW7qKDSeRsbTlD/wxg+mpXmnYg7PaVktKK2phvXoEuhMDu8qQkYuy+0DqKWnhbu2Or
 W4VehZonYNoEpsPNEJuX7GW838HB/my4ebA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kee8ckghn-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 09:10:27 -0700
Received: from twshared19720.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 09:10:25 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 02550F87696A; Tue, 25 Oct 2022 09:10:18 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     Miklos Szeredi <miklos@szeredi.hu>,
        kernel-team <kernel-team@fb.com>,
        Seth Forshee <sforshee@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH v3] fuse: Rearrange fuse_allow_current_process checks
Date:   Tue, 25 Oct 2022 09:10:17 -0700
Message-ID: <20221025161017.3548254-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9otbSETEWONMgyxVl_E9HLy7oPJngGoU
X-Proofpoint-GUID: 9otbSETEWONMgyxVl_E9HLy7oPJngGoU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_09,2022-10-25_01,2022-06-22_01
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a followup to a previous commit of mine [0], which added the
allow_sys_admin_access && capable(CAP_SYS_ADMIN) check. This patch
rearranges the order of checks in fuse_allow_current_process without
changing functionality.

[0] added allow_sys_admin_access && capable(CAP_SYS_ADMIN) check to the
beginning of the function, with the reasoning that
allow_sys_admin_access should be an 'escape hatch' for users with
CAP_SYS_ADMIN, allowing them to skip any subsequent checks.

However, placing this new check first results in many capable() calls whe=
n
allow_sys_admin_access is set, where another check would've also
returned 1. This can be problematic when a BPF program is tracing
capable() calls.

At Meta we ran into such a scenario recently. On a host where
allow_sys_admin_access is set but most of the FUSE access is from
processes which would pass other checks - i.e. they don't need
CAP_SYS_ADMIN 'escape hatch' - this results in an unnecessary capable()
call for each fs op. We also have a daemon tracing capable() with BPF and
doing some data collection, so tracing these extraneous capable() calls
has the potential to regress performance for an application doing many
FUSE ops.

So rearrange the order of these checks such that CAP_SYS_ADMIN 'escape
hatch' is checked last. Add a small helper, fuse_permissible_uidgid, to
make the logic easier to understand. Previously, if allow_other is set
on the fuse_conn, uid/git checking doesn't happen as current_in_userns
result is returned. These semantics are maintained here:
fuse_permissible_uidgid check only happens if allow_other is not set.

  [0]: commit 9ccf47b26b73 ("fuse: Add module param for CAP_SYS_ADMIN acc=
ess bypassing allow_other")

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
---
v2 -> v3: lore.kernel.org/linux-fsdevel/20221020201409.1815316-1-davemarc=
hevsky@fb.com

  * Add fuse_permissible_uidgid, rearrange fuse_allow_current_process to
    not use 'goto' (Christian)

v1 -> v2: lore.kernel.org/linux-fsdevel/20221020183830.1077143-1-davemarc=
hevsky@fb.com

  * Add missing brackets to allow_other if statement (Andrii)

 fs/fuse/dir.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 2c4b08a6ec81..cfd857754c75 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1237,6 +1237,18 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc,=
 u64 parent_nodeid,
 	return err;
 }
=20
+static inline bool fuse_permissible_uidgid(struct fuse_conn *fc)
+{
+	const struct cred *cred =3D current_cred();
+
+	return (uid_eq(cred->euid, fc->user_id) &&
+		uid_eq(cred->suid, fc->user_id) &&
+		uid_eq(cred->uid,  fc->user_id) &&
+		gid_eq(cred->egid, fc->group_id) &&
+		gid_eq(cred->sgid, fc->group_id) &&
+		gid_eq(cred->gid,  fc->group_id));
+}
+
 /*
  * Calling into a user-controlled filesystem gives the filesystem
  * daemon ptrace-like capabilities over the current process.  This
@@ -1252,24 +1264,17 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc=
, u64 parent_nodeid,
  */
 int fuse_allow_current_process(struct fuse_conn *fc)
 {
-	const struct cred *cred;
-
-	if (allow_sys_admin_access && capable(CAP_SYS_ADMIN))
-		return 1;
+	int ret;
=20
 	if (fc->allow_other)
-		return current_in_userns(fc->user_ns);
+		ret =3D current_in_userns(fc->user_ns);
+	else
+		ret =3D fuse_permissible_uidgid(fc);
=20
-	cred =3D current_cred();
-	if (uid_eq(cred->euid, fc->user_id) &&
-	    uid_eq(cred->suid, fc->user_id) &&
-	    uid_eq(cred->uid,  fc->user_id) &&
-	    gid_eq(cred->egid, fc->group_id) &&
-	    gid_eq(cred->sgid, fc->group_id) &&
-	    gid_eq(cred->gid,  fc->group_id))
-		return 1;
+	if (!ret && allow_sys_admin_access && capable(CAP_SYS_ADMIN))
+		ret =3D 1;
=20
-	return 0;
+	return ret;
 }
=20
 static int fuse_access(struct inode *inode, int mask)
--=20
2.30.2

