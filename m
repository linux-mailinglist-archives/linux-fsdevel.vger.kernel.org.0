Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C933F77BB85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 16:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjHNO1D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 10:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjHNO0o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:26:44 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8F0E4;
        Mon, 14 Aug 2023 07:26:40 -0700 (PDT)
Received: from [127.0.1.1] ([91.67.199.65]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MBBCI-1qcfXN31gM-00Ci0I; Mon, 14 Aug 2023 16:26:15 +0200
From:   =?utf-8?q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Date:   Mon, 14 Aug 2023 16:26:09 +0200
Subject: [PATCH RFC 1/4] bpf: add cgroup device guard to flag a cgroup
 device prog
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230814-devcg_guard-v1-1-654971ab88b1@aisec.fraunhofer.de>
References: <20230814-devcg_guard-v1-0-654971ab88b1@aisec.fraunhofer.de>
In-Reply-To: <20230814-devcg_guard-v1-0-654971ab88b1@aisec.fraunhofer.de>
To:     Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, gyroidos@aisec.fraunhofer.de,
        =?utf-8?q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
X-Mailer: b4 0.12.3
X-Provags-ID: V03:K1:0cXxcmdgmClBD4GPMdMTPagr2itnvAUiDtQcsv8MxFS6hE07CYQ
 BeojX5oXPIPVsWXg8FGVsg2nAXIeCSqU70B8yFYo2t841na+NM2vD4GebfRs3ESXUqOyxfq
 iWSfseZ18CHeWFu1Izn2mMmrccgCe52Gq7OkjltVIt49/NlPPe2K2h0XDJsfCl0ESt//0M5
 8QTkixGVHRT2s3YuaM21A==
UI-OutboundReport: notjunk:1;M01:P0:NddmDHLVZyw=;qsT8AXUoHtD7PW1/NyA4rUt3YMp
 ylwjpt+PAIzcM283QbCvuzZ72TtkhK80xTbNCQskNMQHFG/Rp9D7eF6lgrWhxRB0fLTBRpvT9
 5ThI+pXRVs2ox2KhrINecSUftwLyWEPiKtdjn6sb4YqxeSntR/LOfQGFkE1prO98O/ssOP/Z7
 jcXSdLwaLWoVbCV79jx6S4J82GhE2H9fxLs44O/Nm0Hu4xNnWkL0ocy6uZ2sSILuqZPTl8+Bl
 9RUjQA0aoCwBl3F4aK1MCMq14UZ6cQ6qtoSlXzYmbS7J6mLPLNMe28F9AoijWh+tYnNFaITfb
 jSLkvpuSEPMDeGyWtiDdXC+0sV0lKJ4mDWMARx/dh5U84Hxcs7VYZKMh9UiXHTlSENH1/Jwhz
 SR5mbvzVMJPRdgwbt2HaFw5ybajmbicIUtBLdXQVlAUCUQ/IqjQJQzM6k0NB86bUDLNMwt4eT
 Vf9QXTluSMDI+KNXDMpTr3DDq9qcp+93IN8qFx+sKV2n3WbvQypKo+5k+islmLIr9sZEmZrwy
 kxS5GhrQgfu0lIIYwJJyMV9f8aUBbnyAZCP1De0/K6u4lgVrilWV7KpD2g1oTEcKgF2gLH8E2
 gPQOjI0lI6AInRUBEPem+ajayq9+2Nt7Rd8VeKzLNyjwCKito0tBhAj/n6/RgJYipe59mFx5Z
 Nng32yZyfnFrPpSQt2d2JcF5MRrMVYffJr9wmihm22xDahO2a/AHumdOwv9S+X6fdnvRiShZU
 NjS95U+RK78Jjg3SWz7FYCXeoQ3DPsvHsb3fTvP5jpAtErAn3tTEVm8Z65kClEBpAE/QPPlhg
 giQI9xP/dcNUXdYzBl5pqT0DbM7Wsvg48PGhZNuzUk3kG2TPC9TQ8KwSs0L9SMguv9Yrw2N48
 rpx7BIZEIK8Jf+xqIc2Y8VEb2YoC2C/fQf/c=
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce the BPF_F_CGROUP_DEVICE_GUARD flag for BPF_PROG_LOAD
which allows to set a cgroup device program to be a device guard.
Later this may be used to guard actions on device nodes in
non-initial userns. For this reason we provide the helper function
cgroup_bpf_device_guard_enabled() to check if a task has a cgroups
device program which is a device guard in its effective set of bpf
programs.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 include/linux/bpf-cgroup.h     |  7 +++++++
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  5 +++++
 kernel/bpf/cgroup.c            | 30 ++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           |  5 ++++-
 tools/include/uapi/linux/bpf.h |  5 +++++
 6 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 57e9e109257e..112b6093f9fd 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -184,6 +184,8 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 	return array != &bpf_empty_prog_array.hdr;
 }
 
+bool cgroup_bpf_device_guard_enabled(struct task_struct *task);
+
 /* Wrappers for __cgroup_bpf_run_filter_skb() guarded by cgroup_bpf_enabled. */
 #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb)			      \
 ({									      \
@@ -476,6 +478,11 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
 	return 0;
 }
 
+static bool cgroup_bpf_device_guard_enabled(struct task_struct *task)
+{
+	return false;
+}
+
 #define cgroup_bpf_enabled(atype) (0)
 #define BPF_CGROUP_RUN_SA_PROG_LOCK(sk, uaddr, atype, t_ctx) ({ 0; })
 #define BPF_CGROUP_RUN_SA_PROG(sk, uaddr, atype) ({ 0; })
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f58895830ada..313cce8aee05 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1384,6 +1384,7 @@ struct bpf_prog_aux {
 	bool sleepable;
 	bool tail_call_reachable;
 	bool xdp_has_frags;
+	bool cgroup_device_guard;
 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
 	const struct btf_type *attach_func_proto;
 	/* function name for valid attach_btf_id */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 60a9d59beeab..3be57f7957b1 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1165,6 +1165,11 @@ enum bpf_link_type {
  */
 #define BPF_F_XDP_DEV_BOUND_ONLY	(1U << 6)
 
+/* If BPF_F_CGROUP_DEVICE_GUARD is used in BPF_PROG_LOAD command, the loaded
+ * program will be allowed to guard device access inside user namespaces.
+ */
+#define BPF_F_CGROUP_DEVICE_GUARD	(1U << 7)
+
 /* link_create.kprobe_multi.flags used in LINK_CREATE command for
  * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
  */
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 5b2741aa0d9b..230693ca4cdb 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2505,6 +2505,36 @@ const struct bpf_verifier_ops cg_sockopt_verifier_ops = {
 const struct bpf_prog_ops cg_sockopt_prog_ops = {
 };
 
+bool
+cgroup_bpf_device_guard_enabled(struct task_struct *task)
+{
+	bool ret;
+	const struct bpf_prog_array *array;
+	const struct bpf_prog_array_item *item;
+	const struct bpf_prog *prog;
+	struct cgroup *cgrp = task_dfl_cgroup(task);
+
+	ret = false;
+
+	array = rcu_access_pointer(cgrp->bpf.effective[CGROUP_DEVICE]);
+	if (array == &bpf_empty_prog_array.hdr)
+		return ret;
+
+	mutex_lock(&cgroup_mutex);
+	array = rcu_dereference_protected(cgrp->bpf.effective[CGROUP_DEVICE],
+					      lockdep_is_held(&cgroup_mutex));
+	item = &array->items[0];
+	while ((prog = READ_ONCE(item->prog))) {
+		if (prog->aux->cgroup_device_guard) {
+			ret = true;
+			break;
+		}
+		item++;
+	}
+	mutex_unlock(&cgroup_mutex);
+	return ret;
+}
+
 /* Common helpers for cgroup hooks. */
 const struct bpf_func_proto *
 cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a2aef900519c..33ea67c702c1 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2564,7 +2564,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 				 BPF_F_SLEEPABLE |
 				 BPF_F_TEST_RND_HI32 |
 				 BPF_F_XDP_HAS_FRAGS |
-				 BPF_F_XDP_DEV_BOUND_ONLY))
+				 BPF_F_XDP_DEV_BOUND_ONLY |
+				 BPF_F_CGROUP_DEVICE_GUARD))
 		return -EINVAL;
 
 	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
@@ -2651,6 +2652,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	prog->aux->dev_bound = !!attr->prog_ifindex;
 	prog->aux->sleepable = attr->prog_flags & BPF_F_SLEEPABLE;
 	prog->aux->xdp_has_frags = attr->prog_flags & BPF_F_XDP_HAS_FRAGS;
+	prog->aux->cgroup_device_guard =
+		attr->prog_flags & BPF_F_CGROUP_DEVICE_GUARD;
 
 	err = security_bpf_prog_alloc(prog->aux);
 	if (err)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 60a9d59beeab..3be57f7957b1 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1165,6 +1165,11 @@ enum bpf_link_type {
  */
 #define BPF_F_XDP_DEV_BOUND_ONLY	(1U << 6)
 
+/* If BPF_F_CGROUP_DEVICE_GUARD is used in BPF_PROG_LOAD command, the loaded
+ * program will be allowed to guard device access inside user namespaces.
+ */
+#define BPF_F_CGROUP_DEVICE_GUARD	(1U << 7)
+
 /* link_create.kprobe_multi.flags used in LINK_CREATE command for
  * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
  */

-- 
2.30.2

