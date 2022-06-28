Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722F155E9BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 18:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbiF1QaS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 12:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347635AbiF1Q3L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 12:29:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4FF3A191;
        Tue, 28 Jun 2022 09:20:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD946617CB;
        Tue, 28 Jun 2022 16:20:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748AFC341CD;
        Tue, 28 Jun 2022 16:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656433202;
        bh=uBHpOboY6y9w+HwMF5AuSrCFXcv/uOgB4BTVB2oGngo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cnvuNN2i97ReGHjMPkFMfNtPeC9XLQ+9qYt9/BMZH9jj3tbFvd15y6pnVHVmS+Gnd
         swrPLE6ii2PsVrcsKhuJDmM+BVf24MKm2HXptqOk38QMgkT7IZZdU3xzjCBiLErZqE
         Gs/u2PZT342n388LeTUOi3nUcKnrMLgMxWqj5zOyaZ3diE+Oexnz9zusWPNQeprYt8
         0+w+p2FNodbJhhNxFwaMNkpIFXZ8sHPIf9krSQ4/w6nj9sgQP+yCnK/K964dJVX5PD
         vAtQe/sewg5GrDmYG1MJ7hZxZKAugAV11pKqcVnFpc7OnrSinfmtGiI/Ji82tsXj3z
         rELaR4IyoM+zg==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     KP Singh <kpsingh@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH v5 bpf-next 4/5] bpf: Add a bpf_getxattr kfunc
Date:   Tue, 28 Jun 2022 16:19:47 +0000
Message-Id: <20220628161948.475097-5-kpsingh@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220628161948.475097-1-kpsingh@kernel.org>
References: <20220628161948.475097-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

LSMs like SELinux store security state in xattrs. bpf_getxattr enables
BPF LSM to implement similar functionality. In combination with
bpf_local_storage, xattrs can be used to develop more complex security
policies.

This kfunc wraps around __vfs_getxattr which can sleep and is,
therefore, limited to sleepable programs using the newly added
sleepable_set for kfuncs.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 kernel/trace/bpf_trace.c | 42 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4be976cf7d63..87496d57b099 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -20,6 +20,7 @@
 #include <linux/fprobe.h>
 #include <linux/bsearch.h>
 #include <linux/sort.h>
+#include <linux/xattr.h>
 
 #include <net/bpf_sk_storage.h>
 
@@ -1181,6 +1182,47 @@ static const struct bpf_func_proto bpf_get_func_arg_cnt_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 };
 
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "kfuncs that are used in tracing/LSM BPF programs");
+
+ssize_t bpf_getxattr(struct dentry *dentry, struct inode *inode,
+		     const char *name, void *value, int value__sz)
+{
+	return __vfs_getxattr(dentry, inode, name, value, value__sz);
+}
+
+__diag_pop();
+
+BTF_SET_START(bpf_trace_kfunc_ids)
+BTF_ID(func, bpf_getxattr)
+BTF_SET_END(bpf_trace_kfunc_ids)
+
+BTF_SET_START(bpf_trace_sleepable_kfunc_ids)
+BTF_ID(func, bpf_getxattr)
+BTF_SET_END(bpf_trace_sleepable_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_trace_kfunc_set = {
+	.owner = THIS_MODULE,
+	.check_set = &bpf_trace_kfunc_ids,
+	.sleepable_set = &bpf_trace_sleepable_kfunc_ids,
+};
+
+static int __init bpf_trace_kfunc_init(void)
+{
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
+					&bpf_trace_kfunc_set);
+	if (!ret)
+		return ret;
+
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
+					&bpf_trace_kfunc_set);
+
+}
+late_initcall(bpf_trace_kfunc_init);
+
 static const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
-- 
2.37.0.rc0.161.g10f37bed90-goog

