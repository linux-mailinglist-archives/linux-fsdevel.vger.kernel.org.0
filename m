Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3627A6D2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 23:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjISVsn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 17:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbjISVsm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 17:48:42 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FF4C6
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 14:48:36 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JL5Sod023498
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 14:48:35 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3t73uye643-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 14:48:35 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 19 Sep 2023 14:48:13 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 47174385A5F09; Tue, 19 Sep 2023 14:48:02 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v5 bpf-next 01/13] bpf: align CAP_NET_ADMIN checks with bpf_capable() approach
Date:   Tue, 19 Sep 2023 14:47:48 -0700
Message-ID: <20230919214800.3803828-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919214800.3803828-1-andrii@kernel.org>
References: <20230919214800.3803828-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 2yt99fhE89DD5UHn1f6ID77xbykWrihP
X-Proofpoint-GUID: 2yt99fhE89DD5UHn1f6ID77xbykWrihP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_12,2023-09-19_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/syscall.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 85c1d908f70f..f024caee0bba 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1097,6 +1097,11 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 	return ret;
 }
 
+static bool bpf_net_capable(void)
+{
+	return capable(CAP_NET_ADMIN) || capable(CAP_SYS_ADMIN);
+}
+
 #define BPF_MAP_CREATE_LAST_FIELD map_extra
 /* called via syscall */
 static int map_create(union bpf_attr *attr)
@@ -1200,7 +1205,7 @@ static int map_create(union bpf_attr *attr)
 	case BPF_MAP_TYPE_DEVMAP:
 	case BPF_MAP_TYPE_DEVMAP_HASH:
 	case BPF_MAP_TYPE_XSKMAP:
-		if (!capable(CAP_NET_ADMIN))
+		if (!bpf_net_capable())
 			return -EPERM;
 		break;
 	default:
@@ -2595,7 +2600,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	    !bpf_capable())
 		return -EPERM;
 
-	if (is_net_admin_prog_type(type) && !capable(CAP_NET_ADMIN) && !capable(CAP_SYS_ADMIN))
+	if (is_net_admin_prog_type(type) && !bpf_net_capable())
 		return -EPERM;
 	if (is_perfmon_prog_type(type) && !perfmon_capable())
 		return -EPERM;
@@ -3738,7 +3743,7 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
 	case BPF_PROG_TYPE_SK_LOOKUP:
 		return attach_type == prog->expected_attach_type ? 0 : -EINVAL;
 	case BPF_PROG_TYPE_CGROUP_SKB:
-		if (!capable(CAP_NET_ADMIN))
+		if (!bpf_net_capable())
 			/* cg-skb progs can be loaded by unpriv user.
 			 * check permissions at attach time.
 			 */
@@ -3922,7 +3927,7 @@ static int bpf_prog_detach(const union bpf_attr *attr)
 static int bpf_prog_query(const union bpf_attr *attr,
 			  union bpf_attr __user *uattr)
 {
-	if (!capable(CAP_NET_ADMIN))
+	if (!bpf_net_capable())
 		return -EPERM;
 	if (CHECK_ATTR(BPF_PROG_QUERY))
 		return -EINVAL;
-- 
2.34.1

