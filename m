Return-Path: <linux-fsdevel+bounces-3989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D03D7FA9D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 20:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF661C20C1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 19:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A272A3EA7A;
	Mon, 27 Nov 2023 19:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2954D59
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 11:06:39 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARICjAn024175
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 11:06:39 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3umpj7407q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 11:04:23 -0800
Received: from twshared51573.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 11:04:22 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id E8FE33C35FB70; Mon, 27 Nov 2023 11:04:11 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <keescook@chromium.org>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v11 bpf-next 01/17] bpf: align CAP_NET_ADMIN checks with bpf_capable() approach
Date: Mon, 27 Nov 2023 11:03:53 -0800
Message-ID: <20231127190409.2344550-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127190409.2344550-1-andrii@kernel.org>
References: <20231127190409.2344550-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: RGSEfxGF5GPk_Qah0WByd9t9ojN4I8Qb
X-Proofpoint-ORIG-GUID: RGSEfxGF5GPk_Qah0WByd9t9ojN4I8Qb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_17,2023-11-27_01,2023-05-22_02

Within BPF syscall handling code CAP_NET_ADMIN checks stand out a bit
compared to CAP_BPF and CAP_PERFMON checks. For the latter, CAP_BPF or
CAP_PERFMON are checked first, but if they are not set, CAP_SYS_ADMIN
takes over and grants whatever part of BPF syscall is required.

Similar kind of checks that involve CAP_NET_ADMIN are not so consistent.
One out of four uses does follow CAP_BPF/CAP_PERFMON model: during
BPF_PROG_LOAD, if the type of BPF program is "network-related" either
CAP_NET_ADMIN or CAP_SYS_ADMIN is required to proceed.

But in three other cases CAP_NET_ADMIN is required even if CAP_SYS_ADMIN
is set:
  - when creating DEVMAP/XDKMAP/CPU_MAP maps;
  - when attaching CGROUP_SKB programs;
  - when handling BPF_PROG_QUERY command.

This patch is changing the latter three cases to follow BPF_PROG_LOAD
model, that is allowing to proceed under either CAP_NET_ADMIN or
CAP_SYS_ADMIN.

This also makes it cleaner in subsequent BPF token patches to switch
wholesomely to a generic bpf_token_capable(int cap) check, that always
falls back to CAP_SYS_ADMIN if requested capability is missing.

Cc: Jakub Kicinski <kuba@kernel.org>
Acked-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/syscall.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 5e43ddd1b83f..c7419e55ddba 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1096,6 +1096,11 @@ static int map_check_btf(struct bpf_map *map, cons=
t struct btf *btf,
 	return ret;
 }
=20
+static bool bpf_net_capable(void)
+{
+	return capable(CAP_NET_ADMIN) || capable(CAP_SYS_ADMIN);
+}
+
 #define BPF_MAP_CREATE_LAST_FIELD map_extra
 /* called via syscall */
 static int map_create(union bpf_attr *attr)
@@ -1199,7 +1204,7 @@ static int map_create(union bpf_attr *attr)
 	case BPF_MAP_TYPE_DEVMAP:
 	case BPF_MAP_TYPE_DEVMAP_HASH:
 	case BPF_MAP_TYPE_XSKMAP:
-		if (!capable(CAP_NET_ADMIN))
+		if (!bpf_net_capable())
 			return -EPERM;
 		break;
 	default:
@@ -2600,7 +2605,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfp=
tr_t uattr, u32 uattr_size)
 	    !bpf_capable())
 		return -EPERM;
=20
-	if (is_net_admin_prog_type(type) && !capable(CAP_NET_ADMIN) && !capable=
(CAP_SYS_ADMIN))
+	if (is_net_admin_prog_type(type) && !bpf_net_capable())
 		return -EPERM;
 	if (is_perfmon_prog_type(type) && !perfmon_capable())
 		return -EPERM;
@@ -3752,7 +3757,7 @@ static int bpf_prog_attach_check_attach_type(const =
struct bpf_prog *prog,
 	case BPF_PROG_TYPE_SK_LOOKUP:
 		return attach_type =3D=3D prog->expected_attach_type ? 0 : -EINVAL;
 	case BPF_PROG_TYPE_CGROUP_SKB:
-		if (!capable(CAP_NET_ADMIN))
+		if (!bpf_net_capable())
 			/* cg-skb progs can be loaded by unpriv user.
 			 * check permissions at attach time.
 			 */
@@ -3955,7 +3960,7 @@ static int bpf_prog_detach(const union bpf_attr *at=
tr)
 static int bpf_prog_query(const union bpf_attr *attr,
 			  union bpf_attr __user *uattr)
 {
-	if (!capable(CAP_NET_ADMIN))
+	if (!bpf_net_capable())
 		return -EPERM;
 	if (CHECK_ATTR(BPF_PROG_QUERY))
 		return -EINVAL;
--=20
2.34.1


