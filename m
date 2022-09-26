Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8245EB56A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 01:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiIZXTK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 19:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiIZXSs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:18:48 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56EDD1EBD
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:18:35 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-349e6acbac9so75359287b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=+3nCXVZAYG4mqX6ZDGtT6coN8KDHIN70JcHyKcO3Xz4=;
        b=AojhQSI5G47LbYs2kHQdKu7TIAGVTlql5llog6A1Ll6zJBY843G9XX45AQCXPojVS9
         DL08jJDrXz1NW4967Y1SlTiEpxWi62ncWgvjXBa2Yqg1UDIvg2CZqvk0rpsSoGa7Do99
         3xAgLgsxRNU5z1hSZb+rUIqzSABH2SkBtYc72/W+73uVe8x9V3YAKUUg4AYF0OrGR/E9
         KGKp0VERStrni/QkAf1MpZX1CEDnr1XXWUt8/y0EFQTg4qCwQ5DQbQKPST6+VF65CmaR
         ykx7rkbHl7Q7oyCfeFsMjBHYX5u3ZuOs3WYWUWaHDrQKIpjhxsE6DasV64C30MfvSfZ8
         ZcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=+3nCXVZAYG4mqX6ZDGtT6coN8KDHIN70JcHyKcO3Xz4=;
        b=FwKM5OvfEU3oxOqCBTmkNfossrETdAsKy1CAhV41y9uBKWr+TkQ0vflXRfX7wDdlu0
         4cWKAoIFkIKc4nRbqjXmiQG7wuGv3SKgLDe3tw+3lN+NWE7qVwgRBgzXOusA8CNpvrL9
         HTmfItickwHxgKkpMRuQL1Sp3EST7lruAdQZ3WNWnY0Bkib8tusjX1XwAa6zY6NoB2UK
         RlKwCKXG38vwOuzWOMHKOi8RSF/Hehp3BunsEt84+EheHzsVePLeqlDqojOifupupmqQ
         NhZno7jJYa6mhz4Yhy5btA6HToRcDDlds8m+l+vflXvfSm0+ZOlTHVZ0HltRBHAzxOk9
         9sEw==
X-Gm-Message-State: ACrzQf3C2MmI+vTiHySETNwaFPaehBrJnPCSXRKW9KEXv5hPC+2lJkpI
        hzoIlbQPTz6Wke8m/ih/kJrFcdSOK2k=
X-Google-Smtp-Source: AMsMyM4b7LNOFEYk7rEYc+A6dJ5mvMwNFOwDG4T9GAwqLqP0bGAF6w7dQoaFM7Bkdh167Xx+2q7mQ8bZWUk=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:4643:a68e:2b7:f873])
 (user=drosen job=sendgmr) by 2002:a25:928a:0:b0:6b8:2459:879f with SMTP id
 y10-20020a25928a000000b006b82459879fmr15948386ybl.96.1664234314297; Mon, 26
 Sep 2022 16:18:34 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:17:58 -0700
In-Reply-To: <20220926231822.994383-1-drosen@google.com>
Mime-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926231822.994383-3-drosen@google.com>
Subject: [PATCH 02/26] bpf: verifier: Allow single packet invalidation
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@google.com>,
        David Anderson <dvander@google.com>,
        Sandeep Patil <sspatil@google.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Previously there could only be one packet. Helper functions that may
modify the packet could simply invalidate all packets. Now that we
support multiple packets, we should allow helpers to invalidate specific
packets.

This is leaving the default global invalidation in place in case that's
still useful. All existing packets use the default id of '0', and could
be transitioned to the specific packet code with no change in behavior.

This also adds ARG_PTR_TO_PACKET, to allow packets to be passed to
helper functions at all. This is required to inform the verifier which
packets should be invalidated. Currenly only one packet is allowed per
helper.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 include/linux/bpf.h      |  1 +
 include/linux/bpf_fuse.h | 11 ++++++
 kernel/bpf/core.c        |  5 +++
 kernel/bpf/verifier.c    | 83 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 98 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/bpf_fuse.h

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 07086e375487..4e6bfcfd8fea 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -456,6 +456,7 @@ enum bpf_arg_type {
 	ARG_PTR_TO_TIMER,	/* pointer to bpf_timer */
 	ARG_PTR_TO_KPTR,	/* pointer to referenced kptr */
 	ARG_PTR_TO_DYNPTR,      /* pointer to bpf_dynptr. See bpf_type_flag for dynptr type */
+	ARG_PTR_TO_PACKET,	/* pointer to packet */
 	__BPF_ARG_TYPE_MAX,
 
 	/* Extended arg_types. */
diff --git a/include/linux/bpf_fuse.h b/include/linux/bpf_fuse.h
new file mode 100644
index 000000000000..18e2ec5bf453
--- /dev/null
+++ b/include/linux/bpf_fuse.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2022 Google LLC.
+ */
+
+#ifndef _BPF_FUSE_H
+#define _BPF_FUSE_H
+
+bool bpf_helper_changes_one_pkt_data(void *func);
+
+#endif /* _BPF_FUSE_H */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3d9eb3ae334c..2ac3597ec932 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2685,6 +2685,11 @@ bool __weak bpf_helper_changes_pkt_data(void *func)
 	return false;
 }
 
+bool __weak bpf_helper_changes_one_pkt_data(void *func)
+{
+	return false;
+}
+
 /* Return TRUE if the JIT backend wants verifier to enable sub-register usage
  * analysis code and wants explicit zero extension inserted by verifier.
  * Otherwise, return FALSE.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d28cb22d5ee5..2884650904fe 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23,6 +23,7 @@
 #include <linux/error-injection.h>
 #include <linux/bpf_lsm.h>
 #include <linux/btf_ids.h>
+#include <linux/bpf_fuse.h>
 
 #include "disasm.h"
 
@@ -263,6 +264,7 @@ struct bpf_call_arg_meta {
 	u32 subprogno;
 	struct bpf_map_value_off_desc *kptr_off_desc;
 	u8 uninit_dynptr_regno;
+	u32 data_id;
 };
 
 struct btf *btf_vmlinux;
@@ -1396,6 +1398,12 @@ static bool reg_is_pkt_pointer_any(const struct bpf_reg_state *reg)
 	       reg->type == PTR_TO_PACKET_END;
 }
 
+static bool reg_is_specific_pkt_pointer_any(const struct bpf_reg_state *reg, u32 id)
+{
+	return (reg_is_pkt_pointer(reg) ||
+	       reg->type == PTR_TO_PACKET_END) && reg->data_id == id;
+}
+
 /* Unmodified PTR_TO_PACKET[_META,_END] register from ctx access. */
 static bool reg_is_init_pkt_pointer(const struct bpf_reg_state *reg,
 				    enum bpf_reg_type which)
@@ -5664,6 +5672,7 @@ static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK }
 static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
 static const struct bpf_reg_types timer_types = { .types = { PTR_TO_MAP_VALUE } };
 static const struct bpf_reg_types kptr_types = { .types = { PTR_TO_MAP_VALUE } };
+static const struct bpf_reg_types packet_ptr_types = { .types = { PTR_TO_PACKET } };
 
 static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_MAP_KEY]		= &map_key_value_types,
@@ -5691,6 +5700,7 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_TIMER]		= &timer_types,
 	[ARG_PTR_TO_KPTR]		= &kptr_types,
 	[ARG_PTR_TO_DYNPTR]		= &stack_ptr_types,
+	[ARG_PTR_TO_PACKET]		= &packet_ptr_types,
 };
 
 static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
@@ -5800,7 +5810,8 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 		/* Some of the argument types nevertheless require a
 		 * zero register offset.
 		 */
-		if (base_type(arg_type) != ARG_PTR_TO_ALLOC_MEM)
+		if (base_type(arg_type) != ARG_PTR_TO_ALLOC_MEM &&
+			base_type(arg_type) != ARG_PTR_TO_PACKET)
 			return 0;
 		break;
 	/* All the rest must be rejected, except PTR_TO_BTF_ID which allows
@@ -6135,6 +6146,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		if (process_kptr_func(env, regno, meta))
 			return -EACCES;
 		break;
+	case ARG_PTR_TO_PACKET:
+		meta->data_id = reg->data_id;
+		break;
 	}
 
 	return err;
@@ -6509,13 +6523,36 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
 	return true;
 }
 
+static bool check_packet_ok(const struct bpf_func_proto *fn)
+{
+	int count = 0;
+
+	if (fn->arg1_type == ARG_PTR_TO_PACKET)
+		count++;
+	if (fn->arg2_type == ARG_PTR_TO_PACKET)
+		count++;
+	if (fn->arg3_type == ARG_PTR_TO_PACKET)
+		count++;
+	if (fn->arg4_type == ARG_PTR_TO_PACKET)
+		count++;
+	if (fn->arg5_type == ARG_PTR_TO_PACKET)
+		count++;
+
+	/* We only support one arg being a packet at the moment,
+	 * which is sufficient for the helper functions we have right now.
+	 */
+	return count <= 1;
+}
+
+
 static int check_func_proto(const struct bpf_func_proto *fn, int func_id,
 			    struct bpf_call_arg_meta *meta)
 {
 	return check_raw_mode_ok(fn) &&
 	       check_arg_pair_ok(fn) &&
 	       check_btf_id_ok(fn) &&
-	       check_refcount_ok(fn, func_id) ? 0 : -EINVAL;
+	       check_refcount_ok(fn, func_id) &&
+	       check_packet_ok(fn) ? 0 : -EINVAL;
 }
 
 /* Packet data might have moved, any old PTR_TO_PACKET[_META,_END]
@@ -6539,6 +6576,25 @@ static void __clear_all_pkt_pointers(struct bpf_verifier_env *env,
 	}
 }
 
+static void __clear_specific_pkt_pointers(struct bpf_verifier_env *env,
+				     struct bpf_func_state *state,
+				     u32 data_id)
+{
+	struct bpf_reg_state *regs = state->regs, *reg;
+	int i;
+
+	for (i = 0; i < MAX_BPF_REG; i++)
+		if (reg_is_specific_pkt_pointer_any(&regs[i], data_id))
+			mark_reg_unknown(env, regs, i);
+
+	bpf_for_each_spilled_reg(i, state, reg) {
+		if (!reg)
+			continue;
+		if (reg_is_specific_pkt_pointer_any(reg, data_id))
+			__mark_reg_unknown(env, reg);
+	}
+}
+
 static void clear_all_pkt_pointers(struct bpf_verifier_env *env)
 {
 	struct bpf_verifier_state *vstate = env->cur_state;
@@ -6548,6 +6604,15 @@ static void clear_all_pkt_pointers(struct bpf_verifier_env *env)
 		__clear_all_pkt_pointers(env, vstate->frame[i]);
 }
 
+static void clear_specific_pkt_pointers(struct bpf_verifier_env *env, u32 data_id)
+{
+	struct bpf_verifier_state *vstate = env->cur_state;
+	int i;
+
+	for (i = 0; i <= vstate->curframe; i++)
+		__clear_specific_pkt_pointers(env, vstate->frame[i], data_id);
+}
+
 enum {
 	AT_PKT_END = -1,
 	BEYOND_PKT_END = -2,
@@ -7187,6 +7252,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	struct bpf_call_arg_meta meta;
 	int insn_idx = *insn_idx_p;
 	bool changes_data;
+	bool changes_specific_data;
 	int i, err, func_id;
 
 	/* find function prototype */
@@ -7224,6 +7290,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return -EINVAL;
 	}
 
+	changes_specific_data = bpf_helper_changes_one_pkt_data(fn->func);
+	if (changes_data && fn->arg1_type != ARG_PTR_TO_PACKET &&
+			    fn->arg2_type != ARG_PTR_TO_PACKET &&
+			    fn->arg3_type != ARG_PTR_TO_PACKET &&
+			    fn->arg4_type != ARG_PTR_TO_PACKET &&
+			    fn->arg5_type != ARG_PTR_TO_PACKET) {
+		verbose(env, "kernel subsystem misconfigured func %s#%d: no packet arg\n",
+			func_id_name(func_id), func_id);
+		return -EINVAL;
+	}
+
 	memset(&meta, 0, sizeof(meta));
 	meta.pkt_access = fn->pkt_access;
 
@@ -7534,6 +7611,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 	if (changes_data)
 		clear_all_pkt_pointers(env);
+	if (changes_specific_data)
+		clear_specific_pkt_pointers(env, meta.data_id);
 	return 0;
 }
 
-- 
2.37.3.998.g577e59143f-goog

