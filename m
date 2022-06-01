Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DD453ACF7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 20:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiFASo1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 14:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiFASo0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 14:44:26 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12767AEE06
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jun 2022 11:44:24 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 251DIMN4030833
        for <linux-fsdevel@vger.kernel.org>; Wed, 1 Jun 2022 11:44:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=PvaN0SC4qFzZD21PuBqJmqzLZXx7bb9ZBgJH4uQhJHI=;
 b=ciQmLj/PYJQUcYqn946K7R7892luncv+Me/ax2X9wO0JFY1Xjmm/++KM34dqIHjfTE/z
 Rkw9itwZbznndbjlklqoXlbsUOGmvmyvGT1vAg5MjgCY5eWinxF1NEEVBLxolnbpPK0L
 9CFwjPZWBAC6HIlmeBUNgG+Zr7K2AD9bLyY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3gdv755s99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jun 2022 11:44:23 -0700
Received: from twshared5413.23.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 1 Jun 2022 11:44:23 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id B40E5875BFA4; Wed,  1 Jun 2022 11:44:09 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Seth Forshee <sforshee@digitalocean.com>,
        kernel-team <kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>, <clm@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2] fuse: Add module param for non-descendant userns access to allow_other
Date:   Wed, 1 Jun 2022 11:44:07 -0700
Message-ID: <20220601184407.2086986-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: isySsTk9a7yajUfROkeZSGdWk1ytnDZa
X-Proofpoint-GUID: isySsTk9a7yajUfROkeZSGdWk1ytnDZa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-01_07,2022-06-01_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since commit 73f03c2b4b52 ("fuse: Restrict allow_other to the
superblock's namespace or a descendant"), access to allow_other FUSE
filesystems has been limited to users in the mounting user namespace or
descendants. This prevents a process that is privileged in its userns -
but not its parent namespaces - from mounting a FUSE fs w/ allow_other
that is accessible to processes in parent namespaces.

While this restriction makes sense overall it breaks a legitimate
usecase: I have a tracing daemon which needs to peek into
process' open files in order to symbolicate - similar to 'perf'. The
daemon is a privileged process in the root userns, but is unable to peek
into FUSE filesystems mounted with allow_other by processes in child
namespaces.

This patch adds a module param, allow_other_parent_userns, to act as an
escape hatch for this descendant userns logic. Setting
allow_other_parent_userns allows non-descendant-userns processes to
access FUSEs mounted with allow_other. A sysadmin setting this param
must trust allow_other FUSEs on the host to not DoS processes as
described in 73f03c2b4b52.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---

This is a followup to a previous attempt to solve same problem in a
different way: "fuse: allow CAP_SYS_ADMIN in root userns to access
allow_other mount" [0].

v1 -> v2:
  * Use module param instead of capability check

  [0]: lore.kernel.org/linux-fsdevel/20211111221142.4096653-1-davemarchev=
sky@fb.com

 fs/fuse/dir.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 9dfee44e97ad..3d593ae7dc66 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -11,6 +11,7 @@
 #include <linux/pagemap.h>
 #include <linux/file.h>
 #include <linux/fs_context.h>
+#include <linux/moduleparam.h>
 #include <linux/sched.h>
 #include <linux/namei.h>
 #include <linux/slab.h>
@@ -21,6 +22,12 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
=20
+static bool __read_mostly allow_other_parent_userns;
+module_param(allow_other_parent_userns, bool, 0644);
+MODULE_PARM_DESC(allow_other_parent_userns,
+ "Allow users not in mounting or descendant userns "
+ "to access FUSE with allow_other set");
+
 static void fuse_advise_use_readdirplus(struct inode *dir)
 {
 	struct fuse_inode *fi =3D get_fuse_inode(dir);
@@ -1230,7 +1237,7 @@ int fuse_allow_current_process(struct fuse_conn *fc=
)
 	const struct cred *cred;
=20
 	if (fc->allow_other)
-		return current_in_userns(fc->user_ns);
+		return current_in_userns(fc->user_ns) || allow_other_parent_userns;
=20
 	cred =3D current_cred();
 	if (uid_eq(cred->euid, fc->user_id) &&
--=20
2.30.2

