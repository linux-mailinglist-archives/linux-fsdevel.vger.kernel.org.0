Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BC055E9C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 18:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbiF1QaY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 12:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347466AbiF1Q3J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 12:29:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581603A182;
        Tue, 28 Jun 2022 09:19:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16A83B81F15;
        Tue, 28 Jun 2022 16:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1614EC341CD;
        Tue, 28 Jun 2022 16:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656433195;
        bh=uZ0a5aDXW8MZkIEq0XmbcRjUTh8YkwmgzJs6XG0ENok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qCz6rDAbKU0oO71+34+lZjqNMXkCbW6WI+5/itTKjwMCcKz6Ukno9pgLnu0CrrQdQ
         YbGOa/8PMeu2M8Nw+G3b7CGJ9Pp71MEMY/lJw/O/yNuL1FjP/8D3aX5ooyUx+Qgxbf
         1Z/aOr0tbvoOwvEzuaN3ViIWWLBloc+fRcDinX58eTrzolVw6LS5ac3XVX8pi6JQXg
         Mb/puUcabKhLRL22bKcJU6JlqPv0Vo4T9mZqmHB2v4LhQQ4la68DtBV5FdKe772o6y
         UQ4lrA4OM796Ud5f4deH88uo6gKU1LKnjFAvdSBtvCHassLxWROhMpodfqUqA+eH5X
         G9c2WfOI3xFgA==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     KP Singh <kpsingh@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH v5 bpf-next 1/5] btf: Add a new kfunc set which allows to mark a function to be sleepable
Date:   Tue, 28 Jun 2022 16:19:44 +0000
Message-Id: <20220628161948.475097-2-kpsingh@kernel.org>
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

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

This allows to declare a kfunc as sleepable and prevents its use in
a non sleepable program.

Acked-by: KP Singh <kpsingh@kernel.org>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/btf.h |  2 ++
 kernel/bpf/btf.c    | 12 ++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 1bfed7fa0428..6e7517573d9e 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -18,6 +18,7 @@ enum btf_kfunc_type {
 	BTF_KFUNC_TYPE_RELEASE,
 	BTF_KFUNC_TYPE_RET_NULL,
 	BTF_KFUNC_TYPE_KPTR_ACQUIRE,
+	BTF_KFUNC_TYPE_SLEEPABLE,
 	BTF_KFUNC_TYPE_MAX,
 };
 
@@ -37,6 +38,7 @@ struct btf_kfunc_id_set {
 			struct btf_id_set *release_set;
 			struct btf_id_set *ret_null_set;
 			struct btf_id_set *kptr_acquire_set;
+			struct btf_id_set *sleepable_set;
 		};
 		struct btf_id_set *sets[BTF_KFUNC_TYPE_MAX];
 	};
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2e2066d6af94..37bc77b3b499 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6171,7 +6171,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 	struct bpf_verifier_log *log = &env->log;
 	u32 i, nargs, ref_id, ref_obj_id = 0;
 	bool is_kfunc = btf_is_kernel(btf);
-	bool rel = false, kptr_get = false;
+	bool rel = false, kptr_get = false, sleepable = false;
 	const char *func_name, *ref_tname;
 	const struct btf_type *t, *ref_t;
 	const struct btf_param *args;
@@ -6202,9 +6202,10 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 	}
 
 	if (is_kfunc) {
-		/* Only kfunc can be release func */
 		rel = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
 						BTF_KFUNC_TYPE_RELEASE, func_id);
+		sleepable = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
+						      BTF_KFUNC_TYPE_SLEEPABLE, func_id);
 		kptr_get = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
 						     BTF_KFUNC_TYPE_KPTR_ACQUIRE, func_id);
 	}
@@ -6404,6 +6405,13 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 			func_name);
 		return -EINVAL;
 	}
+
+	if (sleepable && !env->prog->aux->sleepable) {
+		bpf_log(log, "kernel function %s is sleepable but the program is not\n",
+			func_name);
+		return -EINVAL;
+	}
+
 	/* returns argument register number > 0 in case of reference release kfunc */
 	return rel ? ref_regno : 0;
 }
-- 
2.37.0.rc0.161.g10f37bed90-goog

