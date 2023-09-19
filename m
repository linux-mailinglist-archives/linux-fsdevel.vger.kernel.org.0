Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43557A6D3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 23:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbjISVtH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 17:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbjISVsw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 17:48:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6919C11A
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 14:48:44 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JL5GHn021184
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 14:48:44 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3t76krcyc7-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 14:48:43 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 19 Sep 2023 14:48:35 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id E779E385A5F9D; Tue, 19 Sep 2023 14:48:25 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v5 bpf-next 12/13] libbpf: add BPF token support to bpf_prog_load() API
Date:   Tue, 19 Sep 2023 14:47:59 -0700
Message-ID: <20230919214800.3803828-13-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919214800.3803828-1-andrii@kernel.org>
References: <20230919214800.3803828-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 03fIRU7Nq9IB3KO1eChh5EPHBLTAqzLK
X-Proofpoint-GUID: 03fIRU7Nq9IB3KO1eChh5EPHBLTAqzLK
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

Wire through token_fd into bpf_prog_load().

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c | 3 ++-
 tools/lib/bpf/bpf.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 4547ae1037af..5a238831b4ff 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -234,7 +234,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 		  const struct bpf_insn *insns, size_t insn_cnt,
 		  struct bpf_prog_load_opts *opts)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, log_true_size);
+	const size_t attr_sz = offsetofend(union bpf_attr, prog_token_fd);
 	void *finfo = NULL, *linfo = NULL;
 	const char *func_info, *line_info;
 	__u32 log_size, log_level, attach_prog_fd, attach_btf_obj_fd;
@@ -263,6 +263,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 	attr.prog_flags = OPTS_GET(opts, prog_flags, 0);
 	attr.prog_ifindex = OPTS_GET(opts, prog_ifindex, 0);
 	attr.kern_version = OPTS_GET(opts, kern_version, 0);
+	attr.prog_token_fd = OPTS_GET(opts, token_fd, 0);
 
 	if (prog_name && kernel_supports(NULL, FEAT_PROG_NAME))
 		libbpf_strlcpy(attr.prog_name, prog_name, sizeof(attr.prog_name));
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index e090115af06b..cca1d3cd4c72 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -104,9 +104,10 @@ struct bpf_prog_load_opts {
 	 * If kernel doesn't support this feature, log_size is left unchanged.
 	 */
 	__u32 log_true_size;
+	__u32 token_fd;
 	size_t :0;
 };
-#define bpf_prog_load_opts__last_field log_true_size
+#define bpf_prog_load_opts__last_field token_fd
 
 LIBBPF_API int bpf_prog_load(enum bpf_prog_type prog_type,
 			     const char *prog_name, const char *license,
-- 
2.34.1

