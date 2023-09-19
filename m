Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DA37A6D29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 23:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjISVsm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 17:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbjISVsl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 17:48:41 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC04C4
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 14:48:35 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JL5Bnj024758
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 14:48:35 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3t7hnhhj9p-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 14:48:34 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 19 Sep 2023 14:48:23 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id C8AA6385A5F87; Tue, 19 Sep 2023 14:48:21 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v5 bpf-next 10/13] libbpf: add BPF token support to bpf_map_create() API
Date:   Tue, 19 Sep 2023 14:47:57 -0700
Message-ID: <20230919214800.3803828-11-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919214800.3803828-1-andrii@kernel.org>
References: <20230919214800.3803828-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: XuQtgc4HLh3DWOoaqrDRb9s6SACYhvY7
X-Proofpoint-ORIG-GUID: XuQtgc4HLh3DWOoaqrDRb9s6SACYhvY7
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

Add ability to provide token_fd for BPF_MAP_CREATE command through
bpf_map_create() API.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c | 4 +++-
 tools/lib/bpf/bpf.h | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 593ff9ea120d..f9ee7608a96a 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -169,7 +169,7 @@ int bpf_map_create(enum bpf_map_type map_type,
 		   __u32 max_entries,
 		   const struct bpf_map_create_opts *opts)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, map_extra);
+	const size_t attr_sz = offsetofend(union bpf_attr, map_token_fd);
 	union bpf_attr attr;
 	int fd;
 
@@ -198,6 +198,8 @@ int bpf_map_create(enum bpf_map_type map_type,
 	attr.numa_node = OPTS_GET(opts, numa_node, 0);
 	attr.map_ifindex = OPTS_GET(opts, map_ifindex, 0);
 
+	attr.map_token_fd = OPTS_GET(opts, token_fd, 0);
+
 	fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
 	return libbpf_err_errno(fd);
 }
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index a5ddb0393fee..304e24b5a1ae 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -51,8 +51,10 @@ struct bpf_map_create_opts {
 
 	__u32 numa_node;
 	__u32 map_ifindex;
+
+	__u32 token_fd;
 };
-#define bpf_map_create_opts__last_field map_ifindex
+#define bpf_map_create_opts__last_field token_fd
 
 LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
 			      const char *map_name,
-- 
2.34.1

