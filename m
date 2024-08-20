Return-Path: <linux-fsdevel+bounces-26327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6827E957A3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 02:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 207E9283C02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 00:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845EC4C9D;
	Tue, 20 Aug 2024 00:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnHyozwM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5684B23BF;
	Tue, 20 Aug 2024 00:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724112178; cv=none; b=WBkNbz+s0siwA4yhq5Dg9cT0qlB1uH1me4Mx5wShhgT1CMR9AnNR3/OSdl5shxgmKGfg9FSxHNhHINvn0R1ztduvZCpwlMIqYuYmIFXsL93unm4gjc/w0pbTCJlxAiP/CkfGZAWmCyviZIDYuWqIV3NJBUYleVs/Y0LrZUh0Bhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724112178; c=relaxed/simple;
	bh=gsEyl/35PxKqUwY83k+Ml4u4iQeYFAEAD9BT2YbPGr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DydBiVCDtuf0FlUUyVp6Wmz6ynhoxBa5vtzotgU6PGCMqn2ajlTee/6RCK/jsZhK4vqhGX+MgsXfif3BPx0f5YuYrV/RVqSAP/iorTKVUes1VyfFZbCzYYILk3scf9z2RvIynesuSabgceOryHUv/UcM7AXREykus0VW8WoJJHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnHyozwM; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37198a6da58so2691853f8f.0;
        Mon, 19 Aug 2024 17:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724112174; x=1724716974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5qU1SAQVHVazii1bSXv2tYRfm2ITBmJg84ilEUHKC4o=;
        b=YnHyozwMPgTc8SFhG5L7EXT8P1YnWOjfomD23PPTRUZFSVGqL4tjHiJa5WBgHCmGHk
         Hkg1hrNyyMWKb+a2cnsoefKUlcvT/H2HxqxK61hw/uEqjVavkMR/s+Ia+qFr3PjlykUS
         0B+r5iZ38sCvUAnEZwcskdtfbyyy8O+aVB7tZ/20TlNFDIbuZFQ9iuf3s2z5a/kQtsDq
         kca20fItLPRj1oMDXprCA1N1AWIf53qLiizgadxD1WdMi8HVDmLp1VX63w4ag2+j6s1U
         VDCLvVST2YJ5ya7775ngQoffAJQwKOAd2w6NRFBtovWRxOs8aupqOCuaRXzF2mMk1s/T
         BXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724112174; x=1724716974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qU1SAQVHVazii1bSXv2tYRfm2ITBmJg84ilEUHKC4o=;
        b=P5YPtzOX4u/np2fyw8bzy6G3ZtzwZRyvzZOJlPwcLEIPoSFkpIOOf1gvE+9ojyBws9
         DSoare+dorjV2HvkoAK2Eo07CQq0VUMjnNvqnd572QWZQ+y7lQiSx7fnhvkiBiLWRxdw
         pJbYOgjxhH9g3RN2jC9SBZTKQXKRiZYY4+Cv3ZgxnbhOu5Dr9IAHceYq/QwRfIAtWmnL
         gCmMWONTJKCPOOhL6J7S2CDA+TRF0VcWzXzuS9+uGGAgpIDt0iOa7WsWI7gRO5leCppS
         6g7MJ2gAwRSQEOIFiFkY/kJz8yxUrf3pGqnaZcJ05om1bxb/WUq0qMcdwVbcWIGt7wQo
         gOGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkoewUl3YkwR4+nSS03cqOJCmmutA3yCPV8CEqAkS9uv1a5QdL6kQP2XKBNpio222HgYE0yrb1KXmCrssO72gCqDO1jcclRMPqrZDloEeNv3lkksfqPIfw3XT+D5bE2p+7/T82/eSNRpjCT3um5PPHPQb+EJ3N/VZSAAx16rtei8nNJ4VMv2lhkRRmaxE5fDMz5CUljJZSEQZmiupxEnfiZN8EpgpSR040bc4350AXXUX1s81w4MqqNj04LDJwF2wMScikcUvNuUHp8rTKPJkScep4amh9AqYcfvToFx+23AVwAbd4zX34Ba+vr95IRFzo2Ut5xGvd0qOGK9tTq13YTZvNUywzWGDxZ7LM1kAisX30snfaQFIf29M5EJ4jdw==
X-Gm-Message-State: AOJu0YynyB+tTX8WJa8Rdf2fkfq7pwqr1AlxF/6jPKs9zLm9La22Ku3j
	tvLU0hMzkKsOqw7SGWs78pV4YXQuxSNU2CAEvqku1VLGR6OCqVgHFFT/XkcB
X-Google-Smtp-Source: AGHT+IGTKKQJxuwuxszbBfonRMkQNG6HN3gfrmxU0H6E6otd3YbEkek87NfMz7RceHt6MhIUit6PJA==
X-Received: by 2002:adf:b1c3:0:b0:371:8e85:c58e with SMTP id ffacd0b85a97d-37194651b45mr9278891f8f.33.1724112174023;
        Mon, 19 Aug 2024 17:02:54 -0700 (PDT)
Received: from teknoraver-mbp.fritz.box ([151.72.56.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189896c50sm11681892f8f.85.2024.08.19.17.02.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Aug 2024 17:02:53 -0700 (PDT)
From: Matteo Croce <technoboy85@gmail.com>
To: bpf@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Shuah Khan <shuah@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-doc@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev,
	cgroups@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>
Subject: [PATCH bpf-next] bpf: use kfunc hooks instead of program types
Date: Tue, 20 Aug 2024 02:02:45 +0200
Message-ID: <20240820000245.61787-1-technoboy85@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matteo Croce <teknoraver@meta.com>

Pass to register_btf_kfunc_id_set() a btf_kfunc_hook directly, instead
of a bpf_prog_type.
Many program types share the same kfunc hook, so some calls to
register_btf_kfunc_id_set() can be removed.

Tested compiling the kernel with -Werror=enum-conversion to catch all
the occourrences.

Signed-off-by: Matteo Croce <teknoraver@meta.com>
---
 Documentation/bpf/kfuncs.rst                  |  2 +-
 drivers/hid/bpf/hid_bpf_dispatch.c            |  4 +--
 fs/bpf_fs_kfuncs.c                            |  2 +-
 fs/verity/measure.c                           |  2 +-
 include/linux/btf.h                           | 22 ++++++++++++++--
 kernel/bpf/arena.c                            |  2 +-
 kernel/bpf/btf.c                              | 23 +----------------
 kernel/bpf/cpumask.c                          |  6 ++---
 kernel/bpf/crypto.c                           |  8 +++---
 kernel/bpf/helpers.c                          | 15 +++++------
 kernel/bpf/map_iter.c                         |  2 +-
 kernel/cgroup/rstat.c                         |  2 +-
 kernel/trace/bpf_trace.c                      |  4 +--
 net/bpf/test_run.c                            |  6 ++---
 net/core/filter.c                             | 25 ++++++++-----------
 net/core/xdp.c                                |  2 +-
 net/ipv4/bpf_tcp_ca.c                         |  2 +-
 net/ipv4/fou_bpf.c                            |  2 +-
 net/ipv4/tcp_bbr.c                            |  2 +-
 net/ipv4/tcp_cubic.c                          |  2 +-
 net/ipv4/tcp_dctcp.c                          |  2 +-
 net/netfilter/nf_conntrack_bpf.c              |  4 +--
 net/netfilter/nf_flow_table_bpf.c             |  2 +-
 net/netfilter/nf_nat_bpf.c                    |  4 +--
 net/xfrm/xfrm_interface_bpf.c                 |  2 +-
 net/xfrm/xfrm_state_bpf.c                     |  2 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  8 +++---
 27 files changed, 76 insertions(+), 83 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index a8f5782bd833..136c449b26d4 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -359,7 +359,7 @@ type. An example is shown below::
 
         static int init_subsystem(void)
         {
-                return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_task_kfunc_set);
+                return register_btf_kfunc_id_set(BTF_KFUNC_HOOK_TRACING, &bpf_task_kfunc_set);
         }
         late_initcall(init_subsystem);
 
diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index a272a086c950..37a87d70a382 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -660,13 +660,13 @@ static int __init hid_bpf_init(void)
 	 * This is not a big deal: nobody will be able to use the functionality.
 	 */
 
-	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &hid_bpf_kfunc_set);
+	err = register_btf_kfunc_id_set(BTF_KFUNC_HOOK_STRUCT_OPS, &hid_bpf_kfunc_set);
 	if (err) {
 		pr_warn("error while setting HID BPF tracing kfuncs: %d", err);
 		return 0;
 	}
 
-	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &hid_bpf_syscall_kfunc_set);
+	err = register_btf_kfunc_id_set(BTF_KFUNC_HOOK_SYSCALL, &hid_bpf_syscall_kfunc_set);
 	if (err) {
 		pr_warn("error while setting HID BPF syscall kfuncs: %d", err);
 		return 0;
diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 3fe9f59ef867..2661c9a4f858 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -179,7 +179,7 @@ static const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
 
 static int __init bpf_fs_kfuncs_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
+	return register_btf_kfunc_id_set(BTF_KFUNC_HOOK_TRACING, &bpf_fs_kfunc_set);
 }
 
 late_initcall(bpf_fs_kfuncs_init);
diff --git a/fs/verity/measure.c b/fs/verity/measure.c
index 175d2f1bc089..00f1a6077a77 100644
--- a/fs/verity/measure.c
+++ b/fs/verity/measure.c
@@ -181,7 +181,7 @@ static const struct btf_kfunc_id_set bpf_fsverity_set = {
 
 void __init fsverity_init_bpf(void)
 {
-	register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fsverity_set);
+	register_btf_kfunc_id_set(BTF_KFUNC_HOOK_TRACING, &bpf_fsverity_set);
 }
 
 #endif /* CONFIG_BPF_SYSCALL */
diff --git a/include/linux/btf.h b/include/linux/btf.h
index cffb43133c68..2da205e0f923 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -114,6 +114,24 @@ struct bpf_prog;
 
 typedef int (*btf_kfunc_filter_t)(const struct bpf_prog *prog, u32 kfunc_id);
 
+enum btf_kfunc_hook {
+	BTF_KFUNC_HOOK_COMMON,
+	BTF_KFUNC_HOOK_XDP,
+	BTF_KFUNC_HOOK_TC,
+	BTF_KFUNC_HOOK_STRUCT_OPS,
+	BTF_KFUNC_HOOK_TRACING,
+	BTF_KFUNC_HOOK_SYSCALL,
+	BTF_KFUNC_HOOK_FMODRET,
+	BTF_KFUNC_HOOK_CGROUP,
+	BTF_KFUNC_HOOK_SCHED_ACT,
+	BTF_KFUNC_HOOK_SK_SKB,
+	BTF_KFUNC_HOOK_SOCKET_FILTER,
+	BTF_KFUNC_HOOK_LWT,
+	BTF_KFUNC_HOOK_NETFILTER,
+	BTF_KFUNC_HOOK_KPROBE,
+	BTF_KFUNC_HOOK_MAX,
+};
+
 struct btf_kfunc_id_set {
 	struct module *owner;
 	struct btf_id_set8 *set;
@@ -566,7 +584,7 @@ u32 *btf_kfunc_id_set_contains(const struct btf *btf, u32 kfunc_btf_id,
 			       const struct bpf_prog *prog);
 u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
 				const struct bpf_prog *prog);
-int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
+int register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 			      const struct btf_kfunc_id_set *s);
 int register_btf_fmodret_id_set(const struct btf_kfunc_id_set *kset);
 s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id);
@@ -620,7 +638,7 @@ static inline u32 *btf_kfunc_id_set_contains(const struct btf *btf,
 {
 	return NULL;
 }
-static inline int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
+static inline int register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 					    const struct btf_kfunc_id_set *s)
 {
 	return 0;
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index e52b3ad231b9..07bafb9327ec 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -576,6 +576,6 @@ static const struct btf_kfunc_id_set common_kfunc_set = {
 
 static int __init kfunc_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &common_kfunc_set);
+	return register_btf_kfunc_id_set(BTF_KFUNC_HOOK_COMMON, &common_kfunc_set);
 }
 late_initcall(kfunc_init);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index b12db397303e..975c1d61aa2d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -204,24 +204,6 @@
 DEFINE_IDR(btf_idr);
 DEFINE_SPINLOCK(btf_idr_lock);
 
-enum btf_kfunc_hook {
-	BTF_KFUNC_HOOK_COMMON,
-	BTF_KFUNC_HOOK_XDP,
-	BTF_KFUNC_HOOK_TC,
-	BTF_KFUNC_HOOK_STRUCT_OPS,
-	BTF_KFUNC_HOOK_TRACING,
-	BTF_KFUNC_HOOK_SYSCALL,
-	BTF_KFUNC_HOOK_FMODRET,
-	BTF_KFUNC_HOOK_CGROUP,
-	BTF_KFUNC_HOOK_SCHED_ACT,
-	BTF_KFUNC_HOOK_SK_SKB,
-	BTF_KFUNC_HOOK_SOCKET_FILTER,
-	BTF_KFUNC_HOOK_LWT,
-	BTF_KFUNC_HOOK_NETFILTER,
-	BTF_KFUNC_HOOK_KPROBE,
-	BTF_KFUNC_HOOK_MAX,
-};
-
 enum {
 	BTF_KFUNC_SET_MAX_CNT = 256,
 	BTF_DTOR_KFUNC_MAX_CNT = 256,
@@ -8389,11 +8371,9 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 }
 
 /* This function must be invoked only from initcalls/module init functions */
-int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
+int register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 			      const struct btf_kfunc_id_set *kset)
 {
-	enum btf_kfunc_hook hook;
-
 	/* All kfuncs need to be tagged as such in BTF.
 	 * WARN() for initcall registrations that do not check errors.
 	 */
@@ -8402,7 +8382,6 @@ int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
 		return -EINVAL;
 	}
 
-	hook = bpf_prog_type_to_kfunc_hook(prog_type);
 	return __register_btf_kfunc_id_set(hook, kset);
 }
 EXPORT_SYMBOL_GPL(register_btf_kfunc_id_set);
diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index 33c473d676a5..1a34689b2c3d 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -472,9 +472,9 @@ static int __init cpumask_kfunc_init(void)
 	};
 
 	ret = bpf_mem_alloc_init(&bpf_cpumask_ma, sizeof(struct bpf_cpumask), false);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &cpumask_kfunc_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &cpumask_kfunc_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &cpumask_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BTF_KFUNC_HOOK_TRACING, &cpumask_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BTF_KFUNC_HOOK_STRUCT_OPS, &cpumask_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BTF_KFUNC_HOOK_SYSCALL, &cpumask_kfunc_set);
 	return  ret ?: register_btf_id_dtor_kfuncs(cpumask_dtors,
 						   ARRAY_SIZE(cpumask_dtors),
 						   THIS_MODULE);
diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
index 94854cd9c4cc..1010ffbffa10 100644
--- a/kernel/bpf/crypto.c
+++ b/kernel/bpf/crypto.c
@@ -380,10 +380,10 @@ static int __init crypto_kfunc_init(void)
 		},
 	};
 
-	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &crypt_kfunc_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &crypt_kfunc_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &crypt_kfunc_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
+	ret = register_btf_kfunc_id_set(BTF_KFUNC_HOOK_TC, &crypt_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BTF_KFUNC_HOOK_SCHED_ACT, &crypt_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BTF_KFUNC_HOOK_XDP, &crypt_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BTF_KFUNC_HOOK_SYSCALL,
 					       &crypt_init_kfunc_set);
 	return  ret ?: register_btf_id_dtor_kfuncs(bpf_crypto_dtors,
 						   ARRAY_SIZE(bpf_crypto_dtors),
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 12e3aa40b180..3f3b68207941 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3070,16 +3070,17 @@ static int __init kfunc_init(void)
 #endif
 	};
 
-	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &generic_kfunc_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &generic_kfunc_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &generic_kfunc_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &generic_kfunc_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &generic_kfunc_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &generic_kfunc_set);
+
+	ret = register_btf_kfunc_id_set(BTF_KFUNC_HOOK_TRACING, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BTF_KFUNC_HOOK_TC, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BTF_KFUNC_HOOK_XDP, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BTF_KFUNC_HOOK_STRUCT_OPS, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BTF_KFUNC_HOOK_SYSCALL, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BTF_KFUNC_HOOK_CGROUP, &generic_kfunc_set);
 	ret = ret ?: register_btf_id_dtor_kfuncs(generic_dtors,
 						  ARRAY_SIZE(generic_dtors),
 						  THIS_MODULE);
-	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &common_kfunc_set);
+	return ret ?: register_btf_kfunc_id_set(BTF_KFUNC_HOOK_COMMON, &common_kfunc_set);
 }
 
 late_initcall(kfunc_init);
diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index 9575314f40a6..60f8133abd05 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -224,6 +224,6 @@ static const struct btf_kfunc_id_set bpf_map_iter_kfunc_set = {
 
 static int init_subsystem(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &bpf_map_iter_kfunc_set);
+	return register_btf_kfunc_id_set(BTF_KFUNC_HOOK_COMMON, &bpf_map_iter_kfunc_set);
 }
 late_initcall(init_subsystem);
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index a06b45272411..afaa9a437c1b 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -649,7 +649,7 @@ static const struct btf_kfunc_id_set bpf_rstat_kfunc_set = {
 
 static int __init bpf_rstat_kfunc_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
+	return register_btf_kfunc_id_set(BTF_KFUNC_HOOK_TRACING,
 					 &bpf_rstat_kfunc_set);
 }
 late_initcall(bpf_rstat_kfunc_init);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index b69a39316c0c..c30264e9c3cb 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1408,7 +1408,7 @@ static const struct btf_kfunc_id_set bpf_key_sig_kfunc_set = {
 
 static int __init bpf_key_sig_kfuncs_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
+	return register_btf_kfunc_id_set(BTF_KFUNC_HOOK_TRACING,
 					 &bpf_key_sig_kfunc_set);
 }
 
@@ -3473,7 +3473,7 @@ static const struct btf_kfunc_id_set bpf_kprobe_multi_kfunc_set = {
 
 static int __init bpf_kprobe_multi_kfuncs_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_kprobe_multi_kfunc_set);
+	return register_btf_kfunc_id_set(BTF_KFUNC_HOOK_KPROBE, &bpf_kprobe_multi_kfunc_set);
 }
 
 late_initcall(bpf_kprobe_multi_kfuncs_init);
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 6d7a442ceb89..2ce805125cb2 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1753,9 +1753,9 @@ static int __init bpf_prog_test_run_init(void)
 	int ret;
 
 	ret = register_btf_fmodret_id_set(&bpf_test_modify_return_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_prog_test_kfunc_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_prog_test_kfunc_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_prog_test_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BTF_KFUNC_HOOK_TC, &bpf_prog_test_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BTF_KFUNC_HOOK_TRACING, &bpf_prog_test_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BTF_KFUNC_HOOK_SYSCALL, &bpf_prog_test_kfunc_set);
 	return ret ?: register_btf_id_dtor_kfuncs(bpf_prog_test_dtor_kfunc,
 						  ARRAY_SIZE(bpf_prog_test_dtor_kfunc),
 						  THIS_MODULE);
diff --git a/net/core/filter.c b/net/core/filter.c
index 78a6f746ea0b..ce764c31240c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12095,20 +12095,15 @@ static int __init bpf_kfunc_init(void)
 {
 	int ret;
 
-	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_skb);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &bpf_kfunc_set_skb);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SK_SKB, &bpf_kfunc_set_skb);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCKET_FILTER, &bpf_kfunc_set_skb);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &bpf_kfunc_set_skb);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_OUT, &bpf_kfunc_set_skb);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_IN, &bpf_kfunc_set_skb);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_XMIT, &bpf_kfunc_set_skb);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_SEG6LOCAL, &bpf_kfunc_set_skb);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER, &bpf_kfunc_set_skb);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
-					       &bpf_kfunc_set_sock_addr);
-	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
+	ret = register_btf_kfunc_id_set(BTF_KFUNC_HOOK_TC, &bpf_kfunc_set_skb);
+	ret = ret ?: register_btf_kfunc_id_set(BTF_KFUNC_HOOK_SCHED_ACT, &bpf_kfunc_set_skb);
+	ret = ret ?: register_btf_kfunc_id_set(BTF_KFUNC_HOOK_SK_SKB, &bpf_kfunc_set_skb);
+	ret = ret ?: register_btf_kfunc_id_set(BTF_KFUNC_HOOK_SOCKET_FILTER, &bpf_kfunc_set_skb);
+	ret = ret ?: register_btf_kfunc_id_set(BTF_KFUNC_HOOK_CGROUP, &bpf_kfunc_set_skb);
+	ret = ret ?: register_btf_kfunc_id_set(BTF_KFUNC_HOOK_LWT, &bpf_kfunc_set_skb);
+	ret = ret ?: register_btf_kfunc_id_set(BTF_KFUNC_HOOK_NETFILTER, &bpf_kfunc_set_skb);
+	ret = ret ?: register_btf_kfunc_id_set(BTF_KFUNC_HOOK_XDP, &bpf_kfunc_set_xdp);
+	return ret ?: register_btf_kfunc_id_set(BTF_KFUNC_HOOK_TC, &bpf_kfunc_set_tcp_reqsk);
 }
 late_initcall(bpf_kfunc_init);
 
@@ -12168,6 +12163,6 @@ static const struct btf_kfunc_id_set bpf_sk_iter_kfunc_set = {
 
 static int init_subsystem(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_sk_iter_kfunc_set);
+	return register_btf_kfunc_id_set(BTF_KFUNC_HOOK_TRACING, &bpf_sk_iter_kfunc_set);
 }
 late_initcall(init_subsystem);
diff --git a/net/core/xdp.c b/net/core/xdp.c
index bcc5551c6424..d602b9184686 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -797,7 +797,7 @@ bool bpf_dev_bound_kfunc_id(u32 btf_id)
 
 static int __init xdp_metadata_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &xdp_metadata_kfunc_set);
+	return register_btf_kfunc_id_set(BTF_KFUNC_HOOK_XDP, &xdp_metadata_kfunc_set);
 }
 late_initcall(xdp_metadata_init);
 
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 554804774628..a1fc378cc58c 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -341,7 +341,7 @@ static int __init bpf_tcp_ca_kfunc_init(void)
 {
 	int ret;
 
-	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_tcp_ca_kfunc_set);
+	ret = register_btf_kfunc_id_set(BTF_KFUNC_HOOK_STRUCT_OPS, &bpf_tcp_ca_kfunc_set);
 	ret = ret ?: register_bpf_struct_ops(&bpf_tcp_congestion_ops, tcp_congestion_ops);
 
 	return ret;
diff --git a/net/ipv4/fou_bpf.c b/net/ipv4/fou_bpf.c
index 54984f3170a8..f9a68a20cd7c 100644
--- a/net/ipv4/fou_bpf.c
+++ b/net/ipv4/fou_bpf.c
@@ -112,6 +112,6 @@ static const struct btf_kfunc_id_set fou_bpf_kfunc_set = {
 
 int register_fou_bpf(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS,
+	return register_btf_kfunc_id_set(BTF_KFUNC_HOOK_TC,
 					 &fou_bpf_kfunc_set);
 }
diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
index 760941e55153..49d80dbd5f26 100644
--- a/net/ipv4/tcp_bbr.c
+++ b/net/ipv4/tcp_bbr.c
@@ -1177,7 +1177,7 @@ static int __init bbr_register(void)
 
 	BUILD_BUG_ON(sizeof(struct bbr) > ICSK_CA_PRIV_SIZE);
 
-	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &tcp_bbr_kfunc_set);
+	ret = register_btf_kfunc_id_set(BTF_KFUNC_HOOK_STRUCT_OPS, &tcp_bbr_kfunc_set);
 	if (ret < 0)
 		return ret;
 	return tcp_register_congestion_control(&tcp_bbr_cong_ops);
diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index 5dbed91c6178..2ed23f429a8c 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -533,7 +533,7 @@ static int __init cubictcp_register(void)
 	/* divide by bic_scale and by constant Srtt (100ms) */
 	do_div(cube_factor, bic_scale * 10);
 
-	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &tcp_cubic_kfunc_set);
+	ret = register_btf_kfunc_id_set(BTF_KFUNC_HOOK_STRUCT_OPS, &tcp_cubic_kfunc_set);
 	if (ret < 0)
 		return ret;
 	return tcp_register_congestion_control(&cubictcp);
diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
index 8a45a4aea933..b86007e9487d 100644
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -291,7 +291,7 @@ static int __init dctcp_register(void)
 
 	BUILD_BUG_ON(sizeof(struct dctcp) > ICSK_CA_PRIV_SIZE);
 
-	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &tcp_dctcp_kfunc_set);
+	ret = register_btf_kfunc_id_set(BTF_KFUNC_HOOK_STRUCT_OPS, &tcp_dctcp_kfunc_set);
 	if (ret < 0)
 		return ret;
 	return tcp_register_congestion_control(&dctcp);
diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
index 4a136fc3a9c0..356559e5505f 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -531,8 +531,8 @@ int register_nf_conntrack_bpf(void)
 {
 	int ret;
 
-	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &nf_conntrack_kfunc_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &nf_conntrack_kfunc_set);
+	ret = register_btf_kfunc_id_set(BTF_KFUNC_HOOK_XDP, &nf_conntrack_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BTF_KFUNC_HOOK_TC, &nf_conntrack_kfunc_set);
 	if (!ret) {
 		mutex_lock(&nf_conn_btf_access_lock);
 		nfct_btf_struct_access = _nf_conntrack_btf_struct_access;
diff --git a/net/netfilter/nf_flow_table_bpf.c b/net/netfilter/nf_flow_table_bpf.c
index 4a5f5195f2d2..0166882856a2 100644
--- a/net/netfilter/nf_flow_table_bpf.c
+++ b/net/netfilter/nf_flow_table_bpf.c
@@ -115,7 +115,7 @@ static const struct btf_kfunc_id_set nf_flow_kfunc_set = {
 
 int nf_flow_register_bpf(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
+	return register_btf_kfunc_id_set(BTF_KFUNC_HOOK_XDP,
 					 &nf_flow_kfunc_set);
 }
 EXPORT_SYMBOL_GPL(nf_flow_register_bpf);
diff --git a/net/netfilter/nf_nat_bpf.c b/net/netfilter/nf_nat_bpf.c
index 481be15609b1..a3300e3618ab 100644
--- a/net/netfilter/nf_nat_bpf.c
+++ b/net/netfilter/nf_nat_bpf.c
@@ -67,11 +67,11 @@ int register_nf_nat_bpf(void)
 {
 	int ret;
 
-	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
+	ret = register_btf_kfunc_id_set(BTF_KFUNC_HOOK_XDP,
 					&nf_bpf_nat_kfunc_set);
 	if (ret)
 		return ret;
 
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS,
+	return register_btf_kfunc_id_set(BTF_KFUNC_HOOK_TC,
 					 &nf_bpf_nat_kfunc_set);
 }
diff --git a/net/xfrm/xfrm_interface_bpf.c b/net/xfrm/xfrm_interface_bpf.c
index 5ea15037ebd1..4c3149d22712 100644
--- a/net/xfrm/xfrm_interface_bpf.c
+++ b/net/xfrm/xfrm_interface_bpf.c
@@ -105,6 +105,6 @@ static const struct btf_kfunc_id_set xfrm_interface_kfunc_set = {
 
 int __init register_xfrm_interface_bpf(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS,
+	return register_btf_kfunc_id_set(BTF_KFUNC_HOOK_TC,
 					 &xfrm_interface_kfunc_set);
 }
diff --git a/net/xfrm/xfrm_state_bpf.c b/net/xfrm/xfrm_state_bpf.c
index 2248eda741f8..90a3a245c6de 100644
--- a/net/xfrm/xfrm_state_bpf.c
+++ b/net/xfrm/xfrm_state_bpf.c
@@ -129,6 +129,6 @@ static const struct btf_kfunc_id_set xfrm_state_xdp_kfunc_set = {
 
 int __init register_xfrm_state_bpf(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
+	return register_btf_kfunc_id_set(BTF_KFUNC_HOOK_XDP,
 					 &xfrm_state_xdp_kfunc_set);
 }
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 3687a40b61c6..fbb4d739597d 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -1088,10 +1088,10 @@ static int bpf_testmod_init(void)
 	void **tramp;
 	int ret;
 
-	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &bpf_testmod_common_kfunc_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_testmod_kfunc_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_testmod_kfunc_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_testmod_kfunc_set);
+	ret = register_btf_kfunc_id_set(BTF_KFUNC_HOOK_COMMON, &bpf_testmod_common_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BTF_KFUNC_HOOK_TC, &bpf_testmod_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BTF_KFUNC_HOOK_TRACING, &bpf_testmod_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BTF_KFUNC_HOOK_SYSCALL, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_bpf_struct_ops(&bpf_bpf_testmod_ops, bpf_testmod_ops);
 	ret = ret ?: register_bpf_struct_ops(&bpf_testmod_ops2, bpf_testmod_ops2);
 	ret = ret ?: register_btf_id_dtor_kfuncs(bpf_testmod_dtors,
-- 
2.45.2


