Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061B9606962
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 22:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJTUOc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 16:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJTUOa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 16:14:30 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3D0DF70
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Oct 2022 13:14:28 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KHaNx9032002
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Oct 2022 13:14:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=mFU1o2ySXjzzqBmVhAPGcgBA5E8ICj3yJbiyiw2H+30=;
 b=ie/wG1pQhhNHR25UHYoGRQuHq7D1YbzExV4S9CoBzgUEiHirN/FiNjp3N6LnuCEVcneK
 XUYLfGSlQjN95PDKWFC2ShT4sPBNCPMglBjJ57CBJK1AWiKe6xOYh8m6euQSocDR0c7N
 Sm18n1tFebPveSaAU/NVapqFdWg//gX1LJY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kag06amdt-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Oct 2022 13:14:27 -0700
Received: from twshared25017.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 13:14:18 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id B9A7CF4634CA; Thu, 20 Oct 2022 13:14:13 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     Miklos Szeredi <miklos@szeredi.hu>,
        kernel-team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2] fuse: Rearrange fuse_allow_current_process checks
Date:   Thu, 20 Oct 2022 13:14:09 -0700
Message-ID: <20221020201409.1815316-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: zu6A1xSEwksUepGE6NmP1r0N7VE4n9GF
X-Proofpoint-GUID: zu6A1xSEwksUepGE6NmP1r0N7VE4n9GF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_11,2022-10-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
hatch' is checked last. Previously, if allow_other is set on the
fuse_conn, uid/gid checking doesn't happen as current_in_userns result
is returned. It's necessary to add a 'goto' here to skip past uid/gid
check to maintain those semantics here.

  [0]: commit 9ccf47b26b73 ("fuse: Add module param for CAP_SYS_ADMIN acc=
ess bypassing allow_other")

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
---
v1 -> v2: lore.kernel.org/linux-fsdevel/20221020183830.1077143-1-davemarc=
hevsky@fb.com

  * Add missing brackets to allow_other if statement (Andrii)

 fs/fuse/dir.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 2c4b08a6ec81..2f14e90907a2 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1254,11 +1254,11 @@ int fuse_allow_current_process(struct fuse_conn *=
fc)
 {
 	const struct cred *cred;
=20
-	if (allow_sys_admin_access && capable(CAP_SYS_ADMIN))
-		return 1;
-
-	if (fc->allow_other)
-		return current_in_userns(fc->user_ns);
+	if (fc->allow_other) {
+		if (current_in_userns(fc->user_ns))
+			return 1;
+		goto skip_cred_check;
+	}
=20
 	cred =3D current_cred();
 	if (uid_eq(cred->euid, fc->user_id) &&
@@ -1269,6 +1269,10 @@ int fuse_allow_current_process(struct fuse_conn *f=
c)
 	    gid_eq(cred->gid,  fc->group_id))
 		return 1;
=20
+skip_cred_check:
+	if (allow_sys_admin_access && capable(CAP_SYS_ADMIN))
+		return 1;
+
 	return 0;
 }
=20
--=20
2.30.2

