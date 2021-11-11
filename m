Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9B444DDBE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 23:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhKKWOk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 17:14:40 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:13128 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229520AbhKKWOk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 17:14:40 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ABM3eGe026361
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Nov 2021 14:11:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=l5p+QKPTs/IoO/o0Y5PlCyzJsGwDnfnGOqu6KL74/Pg=;
 b=RgmCyG/dxR312TmYyqf6GeL+JMK66Un+QuYg5orWviL2erviSmpNbABkrpz55kxsar0k
 JfeBBvP80uXg2BuR+LqoNC7EhHhamWyZckdsKCkITSqXtnDW/STdvfDHaNOXw0dtmdm+
 4RD32t1uD+sdNizOA/5d2kuYBfQ4sNbEjMA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c9bmu02gr-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Nov 2021 14:11:50 -0800
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 11 Nov 2021 14:11:49 -0800
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id 653BE969CA13; Thu, 11 Nov 2021 14:11:43 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     Dave Marchevsky <davemarchevsky@fb.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <sforshee@digitalocean.com>,
        Rik van Riel <riel@surriel.com>, <kernel-team@fb.com>
Subject: [PATCH] fuse: allow CAP_SYS_ADMIN in root userns to access allow_other mount
Date:   Thu, 11 Nov 2021 14:11:42 -0800
Message-ID: <20211111221142.4096653-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 69Ax1kaOY4G-7ikC1vhyLxP0sia_kWh8
X-Proofpoint-GUID: 69Ax1kaOY4G-7ikC1vhyLxP0sia_kWh8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_07,2021-11-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 malwarescore=0 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111110114
X-FB-Internal: deliver
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
usecase for me. I have a tracing daemon which needs to peek into
process' open files in order to symbolicate - similar to 'perf'. The
daemon is a privileged process in the root userns, but is unable to peek
into FUSE filesystems mounted with allow_other by processes in child
namespaces.

This patch adds an escape hatch to the descendant userns logic
specifically for processes with CAP_SYS_ADMIN in the root userns. Such
processes can already do many dangerous things regardless of namespace,
and moreover could fork and setns into any child userns with a FUSE
mount, so it's reasonable to allow them to interact with all allow_other
FUSE filesystems.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: kernel-team@fb.com
---

Note: I was unsure whether CAP_SYS_ADMIN or CAP_SYS_PTRACE was the best
choice of capability here. Went with the former as it's checked
elsewhere in fs/fuse while CAP_SYS_PTRACE isn't.

 fs/fuse/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 0654bfedcbb0..2524eeb0f35d 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1134,7 +1134,7 @@ int fuse_allow_current_process(struct fuse_conn *fc=
)
 	const struct cred *cred;
=20
 	if (fc->allow_other)
-		return current_in_userns(fc->user_ns);
+		return current_in_userns(fc->user_ns) || capable(CAP_SYS_ADMIN);
=20
 	cred =3D current_cred();
 	if (uid_eq(cred->euid, fc->user_id) &&
--=20
2.30.2

