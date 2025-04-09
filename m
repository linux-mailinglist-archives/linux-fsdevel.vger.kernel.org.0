Return-Path: <linux-fsdevel+bounces-46040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A85FFA81B93
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 05:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76FB24A9120
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 03:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E141E1E06;
	Wed,  9 Apr 2025 03:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="AAT+Jk5P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QTbYPhMs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0374C1C3F0C;
	Wed,  9 Apr 2025 03:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744169708; cv=none; b=qehne4wlVtlO5AW+ilQrXBVGwgRCwDN4k9a3bYrzOwLbGiRx0ImT3tuLxy++0cy8thptH9H8rFYRi0XfeLHgC5Nb+17aOwLr6fQJQbOLTqQbVg5D9N2KWFMF5ZGUq0qznsX8tPPsmJ9nzVHYkJFDiroIeMfUMx+fH16kWqrgsv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744169708; c=relaxed/simple;
	bh=n5IosBv2Zad0YnsHKN8TpO8KLEQyqQVSLQxhTsZpKms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/tkqIbGZLp+bRTXjfn5VpimLthJbnuaJ8Foq4zD+Qgp0fyKbpgjRlNfVVcLSHZKrHArsOhkapuXP+abO/cPGWdcl1nChj9BSaePKkpljOt5bpp7xJQYK3s0ECuszpNYMcMewnJfekTqtbi9H5dpYtHUz6/byCk/H35cxbqxZeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=AAT+Jk5P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QTbYPhMs; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id E68AA2001D0;
	Tue,  8 Apr 2025 23:35:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 08 Apr 2025 23:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1744169702; x=
	1744176902; bh=XDeVFVuyYFTjPVaGwO2YPsFAoYZ0on0V1liEOaC13SY=; b=A
	AT+Jk5Pg6a09ZcAG5ZYmIP5iKL5j+1mV7Xb58ahK58s4u/o1P50NBeWy0NrREMVv
	UKdUKdI01T7TwGZvFAGG69ZB/qwmGkhHeKbO6OqkfloAkZNoeJfcHOU5cbaQIMtG
	3bJxdR1gobLfG06JLr9b1OSpeJ5MZXQgyT07GhyDlby2Sj8hQfP6gw39DXSiO1v6
	qxRLpPypF++BvyL2QXZqG5l1WLxn1cLnfP4T6B+J8qTr5ltRr+TBcg6g/Wd/BFUF
	4r6/rQhzTYSTEDyqAoq6S5WL2J32wOY4BidGOrO9D4CmhbdIVUuJqfanI4yLFD9Y
	TEqcVvLx7s5I4/XSJ1Gww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744169702; x=1744176902; bh=X
	DeVFVuyYFTjPVaGwO2YPsFAoYZ0on0V1liEOaC13SY=; b=QTbYPhMsi79NwVnaa
	Q97AFodLii5oRdmXufv2V0s8hxi8a4q+4fy7SU8vNZukgXuA+MoXeSWom4EDWrwS
	UtmxnMCavnkBPkM/3+snXVYmAOtySgXMigOs2K1zX84USS/umrlaA/1ZRoS31yv3
	ZFgHrI9nhrDFTNYUqEt2Br+xdDBkc6FJtTmzr4Y2OUa84eM/lZWEHPQn1AsRE5eO
	aAFVQqx9XvYb2GY4xJKzu85lKR4E20bDR9+Yz+K1ndldPH/4qCOibyo4cEaDw9o+
	iWZQiA1EUeUwGi1R1zeu++D7qNuoOAQbdhm/JBZF+sxeGERA87PFObd5ERZFEu4v
	3lRIw==
X-ME-Sender: <xms:5er1Z_3SIQm3-aiPou4Oh-qo4gcDVeAjjAu5Y-lgICSLTJNCSdjDCg>
    <xme:5er1Z-E_KHbSuedxl7H_so9w2V-LvA8VdxNSLs8Q1yvfjLWJ54nYxkP0Vyg6cyv77
    AoXrFYEtIgxo2CBlQ>
X-ME-Received: <xmr:5er1Z_6wU3HGWO8kdpOw-y4htpyUXYVdwCdrCARSHcfkCWiH3mcfC0VAygHw9NjQUAvtHYPzDTB6v1W3DoAZwkqD3idMgOlnXqXlF2FryExF98deknW2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdegledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffuc
    dljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhm
    peffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvg
    hrnhepgfefgfegjefhudeikedvueetffelieefuedvhfehjeeljeejkefgffeghfdttdet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepugiguh
    esugiguhhuuhdrgiihiidpnhgspghrtghpthhtohepheehpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopeihohhnghhhohhnghdrshhonhhgsehlihhnuhigrdguvghvpdhrtg
    hpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepughsrghhvghrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhoshhtvgguth
    esghhoohgumhhishdrohhrghdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhn
    uhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepqhhmoheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgv
    rheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunh
    gurghtihhonhdrohhrgh
X-ME-Proxy: <xmx:5er1Z038sSSyWXNMh36kcFeivK3EKjNNveXeZyPf9dGuedaekjEA3A>
    <xmx:5er1ZyFftSGExGkKB6XdsSfM-JXKHWp0GN_V81WYPgebwRCcCFdKVw>
    <xmx:5er1Z1_DAx9y4Y3CmHrK2EqDmKgvKeKt6VZBIz80-ysCU4n3BMoVVA>
    <xmx:5er1Z_kaU4aADlBazp4kxxcya1W_Oj4ZoRRloInF3NifvTL-cPI4AQ>
    <xmx:5ur1Z4kHIFRZetDOsqxjzBdNkog5AIA2NXDdDK_F3nPdq8V-2SYUbsEk>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 23:34:56 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	dsahern@kernel.org,
	rostedt@goodmis.org,
	dave.hansen@linux.intel.com,
	qmo@kernel.org,
	ast@kernel.org,
	brauner@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	kuba@kernel.org,
	kadlec@netfilter.org,
	hawk@kernel.org,
	peterz@infradead.org,
	daniel@iogearbox.net,
	namhyung@kernel.org,
	edumazet@google.com,
	sean@mess.org,
	x86@kernel.org,
	viro@zeniv.linux.org.uk,
	mhiramat@kernel.org,
	mattbobrowski@google.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	acme@kernel.org,
	kpsingh@kernel.org,
	tglx@linutronix.de,
	song@kernel.org,
	andrii@kernel.org,
	bp@alien8.de,
	pablo@netfilter.org,
	mchehab@kernel.org,
	mingo@redhat.com,
	martin.lau@linux.dev
Cc: eddyz87@gmail.com,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	hpa@zytor.com,
	jack@suse.cz,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	mathieu.desnoyers@efficios.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: [RFC bpf-next 11/13] treewide: bpf: Export symbols used by verifier
Date: Tue,  8 Apr 2025 21:34:06 -0600
Message-ID: <5b3433d942eaecdbcc92876c9ed8b7d17f7e1086.1744169424.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1744169424.git.dxu@dxuuu.xyz>
References: <cover.1744169424.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit EXPORT_SYMBOL_GPL()'s all the unresolved symbols from verifier.o.
This is necessary to support loads and reloads of the verifier at
runtime.

The list of symbols was generated using:

    nm -u kernel/bpf/verifier.o | grep -ve "__asan\|__ubsan\|__kasan" | awk '{print $2}'

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 arch/x86/net/bpf_jit_comp.c |  2 ++
 drivers/media/rc/bpf-lirc.c |  1 +
 fs/bpf_fs_kfuncs.c          |  4 ++++
 kernel/bpf/bpf_iter.c       |  1 +
 kernel/bpf/bpf_lsm.c        |  5 +++++
 kernel/bpf/bpf_struct_ops.c |  2 ++
 kernel/bpf/btf.c            | 40 +++++++++++++++++++++++++++++++++++++
 kernel/bpf/cgroup.c         |  4 ++++
 kernel/bpf/core.c           | 29 +++++++++++++++++++++++++++
 kernel/bpf/disasm.c         |  4 ++++
 kernel/bpf/helpers.c        |  2 ++
 kernel/bpf/local_storage.c  |  2 ++
 kernel/bpf/log.c            | 12 +++++++++++
 kernel/bpf/map_iter.c       |  1 +
 kernel/bpf/memalloc.c       |  3 +++
 kernel/bpf/offload.c        | 10 ++++++++++
 kernel/bpf/syscall.c        |  7 +++++++
 kernel/bpf/tnum.c           | 20 +++++++++++++++++++
 kernel/bpf/token.c          |  1 +
 kernel/bpf/trampoline.c     |  5 +++++
 kernel/events/callchain.c   |  3 +++
 kernel/trace/bpf_trace.c    |  9 +++++++++
 lib/error-inject.c          |  2 ++
 net/core/filter.c           | 26 ++++++++++++++++++++++++
 net/core/xdp.c              |  2 ++
 net/netfilter/nf_bpf_link.c |  1 +
 26 files changed, 198 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 9e5fe2ba858f..1319e9e47540 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3704,6 +3704,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 					   tmp : orig_prog);
 	return prog;
 }
+EXPORT_SYMBOL_GPL(bpf_int_jit_compile);
 
 bool bpf_jit_supports_kfunc_call(void)
 {
@@ -3762,6 +3763,7 @@ void bpf_jit_free(struct bpf_prog *prog)
 
 	bpf_prog_unlock_free(prog);
 }
+EXPORT_SYMBOL_GPL(bpf_jit_free);
 
 bool bpf_jit_supports_exceptions(void)
 {
diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
index 2f7564f26445..c9d421c3ee6f 100644
--- a/drivers/media/rc/bpf-lirc.c
+++ b/drivers/media/rc/bpf-lirc.c
@@ -131,6 +131,7 @@ const struct bpf_verifier_ops lirc_mode2_verifier_ops = {
 	.get_func_proto  = lirc_mode2_func_proto,
 	.is_valid_access = lirc_mode2_is_valid_access
 };
+EXPORT_SYMBOL_GPL(lirc_mode2_verifier_ops);
 
 #define BPF_MAX_PROGS 64
 
diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 08412532db1b..55ee6e79de3c 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -6,6 +6,7 @@
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
 #include <linux/dcache.h>
+#include <linux/export.h>
 #include <linux/fs.h>
 #include <linux/fsnotify.h>
 #include <linux/file.h>
@@ -231,6 +232,7 @@ int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
 	}
 	return ret;
 }
+EXPORT_SYMBOL_GPL(bpf_set_dentry_xattr_locked);
 
 /**
  * bpf_remove_dentry_xattr_locked - remove a xattr of a dentry
@@ -266,6 +268,7 @@ int bpf_remove_dentry_xattr_locked(struct dentry *dentry, const char *name__str)
 	}
 	return ret;
 }
+EXPORT_SYMBOL_GPL(bpf_remove_dentry_xattr_locked);
 
 __bpf_kfunc_start_defs();
 
@@ -373,6 +376,7 @@ bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog)
 {
 	return btf_id_set_contains(&d_inode_locked_hooks, prog->aux->attach_btf_id);
 }
+EXPORT_SYMBOL_GPL(bpf_lsm_has_d_inode_locked);
 
 static const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
 	.owner = THIS_MODULE,
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 380e9a7cac75..2e015b08c6cc 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -366,6 +366,7 @@ int bpf_iter_prog_supported(struct bpf_prog *prog)
 	return bpf_prog_ctx_arg_info_init(prog, tinfo->reg_info->ctx_arg_info,
 					  tinfo->reg_info->ctx_arg_info_size);
 }
+EXPORT_SYMBOL_GPL(bpf_iter_prog_supported);
 
 const struct bpf_func_proto *
 bpf_iter_get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 0a59df1c550a..417790c4b0f7 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -8,6 +8,7 @@
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/binfmts.h>
+#include <linux/export.h>
 #include <linux/lsm_hooks.h>
 #include <linux/bpf_lsm.h>
 #include <linux/kallsyms.h>
@@ -137,6 +138,7 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(bpf_lsm_verify_prog);
 
 /* Mask for all the currently supported BPRM option flags */
 #define BPF_F_BRPM_OPTS_MASK	BPF_F_BPRM_SECUREEXEC
@@ -399,6 +401,7 @@ bool bpf_lsm_is_sleepable_hook(u32 btf_id)
 {
 	return btf_id_set_contains(&sleepable_lsm_hooks, btf_id);
 }
+EXPORT_SYMBOL_GPL(bpf_lsm_is_sleepable_hook);
 
 bool bpf_lsm_is_trusted(const struct bpf_prog *prog)
 {
@@ -412,6 +415,7 @@ const struct bpf_verifier_ops lsm_verifier_ops = {
 	.get_func_proto = bpf_lsm_func_proto,
 	.is_valid_access = btf_ctx_access,
 };
+EXPORT_SYMBOL_GPL(lsm_verifier_ops);
 
 /* hooks return 0 or 1 */
 BTF_SET_START(bool_lsm_hooks)
@@ -445,3 +449,4 @@ int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(bpf_lsm_get_retval_range);
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index db13ee70d94d..10abed11082e 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -68,6 +68,7 @@ static DEFINE_MUTEX(update_mutex);
 
 const struct bpf_verifier_ops bpf_struct_ops_verifier_ops = {
 };
+EXPORT_SYMBOL_GPL(bpf_struct_ops_verifier_ops);
 
 const struct bpf_prog_ops bpf_struct_ops_prog_ops = {
 #ifdef CONFIG_NET
@@ -327,6 +328,7 @@ int bpf_struct_ops_supported(const struct bpf_struct_ops *st_ops, u32 moff)
 
 	return func_ptr ? 0 : -ENOTSUPP;
 }
+EXPORT_SYMBOL_GPL(bpf_struct_ops_supported);
 
 int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 			     struct btf *btf,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 5b38c90e1184..91cc0fcd29e9 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -9,6 +9,7 @@
 #include <linux/compiler.h>
 #include <linux/ctype.h>
 #include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/anon_inodes.h>
 #include <linux/file.h>
@@ -347,6 +348,7 @@ const char *btf_type_str(const struct btf_type *t)
 {
 	return btf_kind_str[BTF_INFO_KIND(t->info)];
 }
+EXPORT_SYMBOL_GPL(btf_type_str);
 
 /* Chunk size we use in safe copy of data to be shown. */
 #define BTF_SHOW_OBJ_SAFE_SIZE		32
@@ -497,6 +499,7 @@ bool btf_type_is_void(const struct btf_type *t)
 {
 	return t == &btf_void;
 }
+EXPORT_SYMBOL_GPL(btf_type_is_void);
 
 static bool btf_type_is_datasec(const struct btf_type *t)
 {
@@ -542,6 +545,7 @@ u32 btf_nr_types(const struct btf *btf)
 
 	return total;
 }
+EXPORT_SYMBOL_GPL(btf_nr_types);
 
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
 {
@@ -562,6 +566,7 @@ s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
 
 	return -ENOENT;
 }
+EXPORT_SYMBOL_GPL(btf_find_by_name_kind);
 
 struct btf *bpf_get_btf_vmlinux(void)
 {
@@ -635,6 +640,7 @@ const struct btf_type *btf_type_skip_modifiers(const struct btf *btf,
 
 	return t;
 }
+EXPORT_SYMBOL_GPL(btf_type_skip_modifiers);
 
 const struct btf_type *btf_type_resolve_ptr(const struct btf *btf,
 					    u32 id, u32 *res_id)
@@ -647,6 +653,7 @@ const struct btf_type *btf_type_resolve_ptr(const struct btf *btf,
 
 	return btf_type_skip_modifiers(btf, t->type, res_id);
 }
+EXPORT_SYMBOL_GPL(btf_type_resolve_ptr);
 
 const struct btf_type *btf_type_resolve_func_ptr(const struct btf *btf,
 						 u32 id, u32 *res_id)
@@ -659,6 +666,7 @@ const struct btf_type *btf_type_resolve_func_ptr(const struct btf *btf,
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(btf_type_resolve_func_ptr);
 
 /* Types that act only as a source, not sink or intermediate
  * type when resolving.
@@ -855,6 +863,7 @@ const char *btf_name_by_offset(const struct btf *btf, u32 offset)
 {
 	return btf_str_by_offset(btf, offset);
 }
+EXPORT_SYMBOL_GPL(btf_name_by_offset);
 
 const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id)
 {
@@ -1760,11 +1769,13 @@ const char *btf_get_name(const struct btf *btf)
 {
 	return btf->name;
 }
+EXPORT_SYMBOL_GPL(btf_get_name);
 
 void btf_get(struct btf *btf)
 {
 	refcount_inc(&btf->refcnt);
 }
+EXPORT_SYMBOL_GPL(btf_get);
 
 void btf_put(struct btf *btf)
 {
@@ -1773,6 +1784,7 @@ void btf_put(struct btf *btf)
 		call_rcu(&btf->rcu, btf_free_rcu);
 	}
 }
+EXPORT_SYMBOL_GPL(btf_put);
 
 struct btf *btf_base_btf(const struct btf *btf)
 {
@@ -2018,6 +2030,7 @@ btf_resolve_size(const struct btf *btf, const struct btf_type *type,
 {
 	return __btf_resolve_size(btf, type, type_size, NULL, NULL, NULL, NULL);
 }
+EXPORT_SYMBOL_GPL(btf_resolve_size);
 
 static u32 btf_resolved_type_id(const struct btf *btf, u32 type_id)
 {
@@ -3433,6 +3446,7 @@ const char *btf_find_decl_tag_value(const struct btf *btf, const struct btf_type
 
 	return value;
 }
+EXPORT_SYMBOL_GPL(btf_find_decl_tag_value);
 
 static int
 btf_find_graph_root(const struct btf *btf, const struct btf_type *pt,
@@ -5701,6 +5715,7 @@ struct btf_struct_meta *btf_find_struct_meta(const struct btf *btf, u32 btf_id)
 		return NULL;
 	return bsearch(&btf_id, tab->types, tab->cnt, sizeof(tab->types[0]), btf_id_cmp_func);
 }
+EXPORT_SYMBOL_GPL(btf_find_struct_meta);
 
 static int btf_check_type_tags(struct btf_verifier_env *env,
 			       struct btf *btf, int start_id)
@@ -5946,6 +5961,7 @@ bool btf_is_projection_of(const char *pname, const char *tname)
 		return true;
 	return false;
 }
+EXPORT_SYMBOL_GPL(btf_is_projection_of);
 
 bool btf_is_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 			  const struct btf_type *t, enum bpf_prog_type prog_type,
@@ -6023,6 +6039,7 @@ bool btf_is_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 	}
 	return true;
 }
+EXPORT_SYMBOL_GPL(btf_is_prog_ctx_type);
 
 /* forward declarations for arch-specific underlying types of
  * bpf_user_pt_regs_t; this avoids the need for arch-specific #ifdef
@@ -6197,6 +6214,7 @@ int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_ty
 
 	return kctx_type_id;
 }
+EXPORT_SYMBOL_GPL(get_kern_ctx_btf_id);
 
 BTF_ID_LIST(bpf_ctx_convert_btf_id)
 BTF_ID(struct, bpf_ctx_convert)
@@ -6280,6 +6298,7 @@ struct btf *btf_parse_vmlinux(void)
 	btf_verifier_env_free(env);
 	return btf;
 }
+EXPORT_SYMBOL_GPL(btf_parse_vmlinux);
 
 /* If .BTF_ids section was created with distilled base BTF, both base and
  * split BTF ids will need to be mapped to actual base/split ids for
@@ -7257,6 +7276,7 @@ int btf_struct_access(struct bpf_verifier_log *log,
 
 	return -EINVAL;
 }
+EXPORT_SYMBOL_GPL(btf_struct_access);
 
 /* Check that two BTF types, each specified as an BTF object + id, are exactly
  * the same. Trivial ID check is not enough due to module BTFs, because we can
@@ -7272,6 +7292,7 @@ bool btf_types_are_same(const struct btf *btf1, u32 id1,
 		return true;
 	return btf_type_by_id(btf1, id1) == btf_type_by_id(btf2, id2);
 }
+EXPORT_SYMBOL_GPL(btf_types_are_same);
 
 bool btf_struct_ids_match(struct bpf_verifier_log *log,
 			  const struct btf *btf, u32 id, int off,
@@ -7311,6 +7332,7 @@ bool btf_struct_ids_match(struct bpf_verifier_log *log,
 
 	return true;
 }
+EXPORT_SYMBOL_GPL(btf_struct_ids_match);
 
 static int __get_type_size(struct btf *btf, u32 btf_id,
 			   const struct btf_type **ret_type)
@@ -7417,6 +7439,7 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
 	m->nr_args = nargs;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(btf_distill_func_proto);
 
 /* Compare BTFs of two functions assuming only scalars and pointers to context.
  * t1 points to BTF_KIND_FUNC in btf1
@@ -7559,6 +7582,7 @@ int btf_check_type_match(struct bpf_verifier_log *log, const struct bpf_prog *pr
 
 	return btf_check_func_type_match(log, btf1, t1, btf2, t2);
 }
+EXPORT_SYMBOL_GPL(btf_check_type_match);
 
 static bool btf_is_dynptr_ptr(const struct btf *btf, const struct btf_type *t)
 {
@@ -7872,6 +7896,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(btf_prepare_func_args);
 
 static void btf_type_show(const struct btf *btf, u32 type_id, void *obj,
 			  struct btf_show *show)
@@ -7983,6 +8008,7 @@ const struct file_operations btf_fops = {
 #endif
 	.release	= btf_release,
 };
+EXPORT_SYMBOL_GPL(btf_fops);
 
 static int __btf_new_fd(struct btf *btf)
 {
@@ -8028,6 +8054,7 @@ struct btf *btf_get_by_fd(int fd)
 
 	return btf;
 }
+EXPORT_SYMBOL_GPL(btf_get_by_fd);
 
 int btf_get_info_by_fd(const struct btf *btf,
 		       const union bpf_attr *attr,
@@ -8114,16 +8141,19 @@ u32 btf_obj_id(const struct btf *btf)
 {
 	return btf->id;
 }
+EXPORT_SYMBOL_GPL(btf_obj_id);
 
 bool btf_is_kernel(const struct btf *btf)
 {
 	return btf->kernel_btf;
 }
+EXPORT_SYMBOL_GPL(btf_is_kernel);
 
 bool btf_is_module(const struct btf *btf)
 {
 	return btf->kernel_btf && strcmp(btf->name, "vmlinux") != 0;
 }
+EXPORT_SYMBOL_GPL(btf_is_module);
 
 enum {
 	BTF_MODULE_F_LIVE = (1 << 0),
@@ -8289,6 +8319,7 @@ struct module *btf_try_get_module(const struct btf *btf)
 
 	return res;
 }
+EXPORT_SYMBOL_GPL(btf_try_get_module);
 
 /* Returns struct btf corresponding to the struct module.
  * This function can return NULL or ERR_PTR.
@@ -8374,6 +8405,7 @@ BTF_ID_LIST_GLOBAL(btf_tracing_ids, MAX_BTF_TRACING_TYPE)
 #define BTF_TRACING_TYPE(name, type) BTF_ID(struct, type)
 BTF_TRACING_TYPE_xxx
 #undef BTF_TRACING_TYPE
+EXPORT_SYMBOL_GPL(btf_tracing_ids);
 
 /* Validate well-formedness of iter argument type.
  * On success, return positive BTF ID of iter state's STRUCT type.
@@ -8403,6 +8435,7 @@ int btf_check_iter_arg(struct btf *btf, const struct btf_type *func, int arg_idx
 
 	return btf_id;
 }
+EXPORT_SYMBOL_GPL(btf_check_iter_arg);
 
 static int btf_check_iter_kfuncs(struct btf *btf, const char *func_name,
 				 const struct btf_type *func, u32 func_flags)
@@ -8708,12 +8741,14 @@ u32 *btf_kfunc_id_set_contains(const struct btf *btf,
 	hook = bpf_prog_type_to_kfunc_hook(prog_type);
 	return __btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id, prog);
 }
+EXPORT_SYMBOL_GPL(btf_kfunc_id_set_contains);
 
 u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
 				const struct bpf_prog *prog)
 {
 	return __btf_kfunc_id_set_contains(btf, BTF_KFUNC_HOOK_FMODRET, kfunc_btf_id, prog);
 }
+EXPORT_SYMBOL_GPL(btf_kfunc_is_modify_return);
 
 static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 				       const struct btf_kfunc_id_set *kset)
@@ -9311,6 +9346,7 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 	}
 	return err;
 }
+EXPORT_SYMBOL_GPL(bpf_core_apply);
 
 bool btf_nested_type_is_trusted(struct bpf_verifier_log *log,
 				const struct bpf_reg_state *reg,
@@ -9358,6 +9394,7 @@ bool btf_nested_type_is_trusted(struct bpf_verifier_log *log,
 
 	return false;
 }
+EXPORT_SYMBOL_GPL(btf_nested_type_is_trusted);
 
 bool btf_type_ids_nocast_alias(struct bpf_verifier_log *log,
 			       const struct btf *reg_btf, u32 reg_id,
@@ -9413,6 +9450,7 @@ bool btf_type_ids_nocast_alias(struct bpf_verifier_log *log,
 
 	return !strncmp(reg_name, arg_name, cmp_len);
 }
+EXPORT_SYMBOL_GPL(btf_type_ids_nocast_alias);
 
 #ifdef CONFIG_BPF_JIT
 static int
@@ -9502,6 +9540,7 @@ bpf_struct_ops_find(struct btf *btf, u32 type_id)
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(bpf_struct_ops_find);
 
 int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
 {
@@ -9551,3 +9590,4 @@ bool btf_param_match_suffix(const struct btf *btf,
 	param_name += len - suffix_len;
 	return !strncmp(param_name, suffix, suffix_len);
 }
+EXPORT_SYMBOL_GPL(btf_param_match_suffix);
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 84f58f3d028a..3168389a2972 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/atomic.h>
 #include <linux/cgroup.h>
+#include <linux/export.h>
 #include <linux/filter.h>
 #include <linux/slab.h>
 #include <linux/sysctl.h>
@@ -1702,6 +1703,7 @@ const struct bpf_verifier_ops cg_dev_verifier_ops = {
 	.get_func_proto		= cgroup_dev_func_proto,
 	.is_valid_access	= cgroup_dev_is_valid_access,
 };
+EXPORT_SYMBOL_GPL(cg_dev_verifier_ops);
 
 /**
  * __cgroup_bpf_run_filter_sysctl - Run a program on sysctl
@@ -2322,6 +2324,7 @@ const struct bpf_verifier_ops cg_sysctl_verifier_ops = {
 	.is_valid_access	= sysctl_is_valid_access,
 	.convert_ctx_access	= sysctl_convert_ctx_access,
 };
+EXPORT_SYMBOL_GPL(cg_sysctl_verifier_ops);
 
 const struct bpf_prog_ops cg_sysctl_prog_ops = {
 };
@@ -2550,6 +2553,7 @@ const struct bpf_verifier_ops cg_sockopt_verifier_ops = {
 	.convert_ctx_access	= cg_sockopt_convert_ctx_access,
 	.gen_prologue		= cg_sockopt_get_prologue,
 };
+EXPORT_SYMBOL_GPL(cg_sockopt_verifier_ops);
 
 const struct bpf_prog_ops cg_sockopt_prog_ops = {
 };
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 13301a668fe0..6c8bb4cdac0f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -69,6 +69,7 @@
 
 struct bpf_mem_alloc bpf_global_ma;
 bool bpf_global_ma_set;
+EXPORT_SYMBOL_GPL(bpf_global_ma_set);
 
 struct bpf_mem_alloc bpf_global_percpu_ma;
 EXPORT_SYMBOL_GPL(bpf_global_percpu_ma);
@@ -510,6 +511,7 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 
 	return fp;
 }
+EXPORT_SYMBOL_GPL(bpf_prog_alloc_no_stats);
 
 struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
 {
@@ -552,6 +554,7 @@ int bpf_prog_alloc_jited_linfo(struct bpf_prog *prog)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(bpf_prog_alloc_jited_linfo);
 
 void bpf_prog_jit_attempt_done(struct bpf_prog *prog)
 {
@@ -564,6 +567,7 @@ void bpf_prog_jit_attempt_done(struct bpf_prog *prog)
 	kfree(prog->aux->kfunc_tab);
 	prog->aux->kfunc_tab = NULL;
 }
+EXPORT_SYMBOL_GPL(bpf_prog_jit_attempt_done);
 
 /* The jit engine is responsible to provide an array
  * for insn_off to the jited_off mapping (insn_to_jit_off).
@@ -733,6 +737,7 @@ int bpf_prog_calc_tag(struct bpf_prog *fp)
 	vfree(raw);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(bpf_prog_calc_tag);
 
 static int bpf_adj_delta_to_imm(struct bpf_insn *insn, u32 pos, s32 end_old,
 				s32 end_new, s32 curr, const bool probe_pass)
@@ -910,6 +915,7 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 
 	return prog_adj;
 }
+EXPORT_SYMBOL_GPL(bpf_patch_insn_single);
 
 int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
 {
@@ -926,6 +932,7 @@ int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
 	WARN_ON_ONCE(err);
 	return err;
 }
+EXPORT_SYMBOL_GPL(bpf_remove_insns);
 
 static void bpf_prog_kallsyms_del_subprogs(struct bpf_prog *fp)
 {
@@ -1093,6 +1100,7 @@ void bpf_prog_kallsyms_add(struct bpf_prog *fp)
 	bpf_ksym_add(&fp->aux->ksym_prefix);
 #endif
 }
+EXPORT_SYMBOL_GPL(bpf_prog_kallsyms_add);
 
 void bpf_prog_kallsyms_del(struct bpf_prog *fp)
 {
@@ -1238,6 +1246,7 @@ int bpf_jit_add_poke_descriptor(struct bpf_prog *prog,
 
 	return slot;
 }
+EXPORT_SYMBOL_GPL(bpf_jit_add_poke_descriptor);
 
 /*
  * BPF program pack allocator.
@@ -2129,6 +2138,7 @@ bool bpf_opcode_in_insntable(u8 code)
 #undef BPF_INSN_2_TBL
 	return public_insntable[code];
 }
+EXPORT_SYMBOL_GPL(bpf_opcode_in_insntable);
 
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 /**
@@ -3237,6 +3247,7 @@ void __bpf_free_used_maps(struct bpf_prog_aux *aux,
 		bpf_map_put(map);
 	}
 }
+EXPORT_SYMBOL_GPL(__bpf_free_used_maps);
 
 static void bpf_free_used_maps(struct bpf_prog_aux *aux)
 {
@@ -3258,6 +3269,7 @@ void __bpf_free_used_btfs(struct btf_mod_pair *used_btfs, u32 len)
 	}
 #endif
 }
+EXPORT_SYMBOL_GPL(__bpf_free_used_btfs);
 
 static void bpf_free_used_btfs(struct bpf_prog_aux *aux)
 {
@@ -3336,6 +3348,7 @@ void bpf_user_rnd_init_once(void)
 {
 	prandom_init_once(&bpf_user_rnd_state);
 }
+EXPORT_SYMBOL_GPL(bpf_user_rnd_init_once);
 
 BPF_CALL_0(bpf_user_rnd_u32)
 {
@@ -3445,6 +3458,7 @@ bool __weak bpf_helper_changes_pkt_data(enum bpf_func_id func_id)
 {
 	return false;
 }
+EXPORT_SYMBOL_GPL(bpf_helper_changes_pkt_data);
 
 /* Return TRUE if the JIT backend wants verifier to enable sub-register usage
  * analysis code and wants explicit zero extension inserted by verifier.
@@ -3458,6 +3472,7 @@ bool __weak bpf_jit_needs_zext(void)
 {
 	return false;
 }
+EXPORT_SYMBOL_GPL(bpf_jit_needs_zext);
 
 /* Return true if the JIT inlines the call to the helper corresponding to
  * the imm.
@@ -3469,37 +3484,44 @@ bool __weak bpf_jit_inlines_helper_call(s32 imm)
 {
 	return false;
 }
+EXPORT_SYMBOL_GPL(bpf_jit_inlines_helper_call);
 
 /* Return TRUE if the JIT backend supports mixing bpf2bpf and tailcalls. */
 bool __weak bpf_jit_supports_subprog_tailcalls(void)
 {
 	return false;
 }
+EXPORT_SYMBOL_GPL(bpf_jit_supports_subprog_tailcalls);
 
 bool __weak bpf_jit_supports_percpu_insn(void)
 {
 	return false;
 }
+EXPORT_SYMBOL_GPL(bpf_jit_supports_percpu_insn);
 
 bool __weak bpf_jit_supports_kfunc_call(void)
 {
 	return false;
 }
+EXPORT_SYMBOL_GPL(bpf_jit_supports_kfunc_call);
 
 bool __weak bpf_jit_supports_far_kfunc_call(void)
 {
 	return false;
 }
+EXPORT_SYMBOL_GPL(bpf_jit_supports_far_kfunc_call);
 
 bool __weak bpf_jit_supports_arena(void)
 {
 	return false;
 }
+EXPORT_SYMBOL_GPL(bpf_jit_supports_arena);
 
 bool __weak bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 {
 	return false;
 }
+EXPORT_SYMBOL_GPL(bpf_jit_supports_insn);
 
 u64 __weak bpf_arch_uaddress_limit(void)
 {
@@ -3509,6 +3531,7 @@ u64 __weak bpf_arch_uaddress_limit(void)
 	return 0;
 #endif
 }
+EXPORT_SYMBOL_GPL(bpf_arch_uaddress_limit);
 
 /* Return TRUE if the JIT backend satisfies the following two conditions:
  * 1) JIT backend supports atomic_xchg() on pointer-sized words.
@@ -3519,6 +3542,7 @@ bool __weak bpf_jit_supports_ptr_xchg(void)
 {
 	return false;
 }
+EXPORT_SYMBOL_GPL(bpf_jit_supports_ptr_xchg);
 
 /* To execute LD_ABS/LD_IND instructions __bpf_prog_run() may call
  * skb_copy_bits(), so provide a weak definition of it for NET-less config.
@@ -3549,11 +3573,13 @@ bool __weak bpf_jit_supports_exceptions(void)
 {
 	return false;
 }
+EXPORT_SYMBOL_GPL(bpf_jit_supports_exceptions);
 
 bool __weak bpf_jit_supports_private_stack(void)
 {
 	return false;
 }
+EXPORT_SYMBOL_GPL(bpf_jit_supports_private_stack);
 
 void __weak arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie)
 {
@@ -3563,11 +3589,13 @@ bool __weak bpf_jit_supports_timed_may_goto(void)
 {
 	return false;
 }
+EXPORT_SYMBOL_GPL(bpf_jit_supports_timed_may_goto);
 
 u64 __weak arch_bpf_timed_may_goto(void)
 {
 	return 0;
 }
+EXPORT_SYMBOL_GPL(arch_bpf_timed_may_goto);
 
 u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *p)
 {
@@ -3591,6 +3619,7 @@ __weak u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena)
 {
 	return 0;
 }
+EXPORT_SYMBOL_GPL(bpf_arena_get_user_vm_start);
 __weak u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena)
 {
 	return 0;
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 20883c6b1546..ab441a6b8b54 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/bpf.h>
+#include <linux/export.h>
 
 #include "disasm.h"
 
@@ -58,6 +59,7 @@ const char *func_id_name(int id)
 	else
 		return "unknown";
 }
+EXPORT_SYMBOL_GPL(func_id_name);
 
 const char *const bpf_class_string[8] = {
 	[BPF_LD]    = "ld",
@@ -86,6 +88,7 @@ const char *const bpf_alu_string[16] = {
 	[BPF_ARSH >> 4] = "s>>=",
 	[BPF_END >> 4]  = "endian",
 };
+EXPORT_SYMBOL_GPL(bpf_alu_string);
 
 static const char *const bpf_alu_sign_string[16] = {
 	[BPF_DIV >> 4]  = "s/=",
@@ -388,3 +391,4 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 			insn->code, bpf_class_string[class]);
 	}
 }
+EXPORT_SYMBOL_GPL(print_bpf_insn);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e3a2662f4e33..46816949b78f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -5,6 +5,7 @@
 #include <linux/btf.h>
 #include <linux/bpf-cgroup.h>
 #include <linux/cgroup.h>
+#include <linux/export.h>
 #include <linux/rcupdate.h>
 #include <linux/random.h>
 #include <linux/smp.h>
@@ -1041,6 +1042,7 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 		bpf_bprintf_cleanup(data);
 	return err;
 }
+EXPORT_SYMBOL_GPL(bpf_bprintf_prepare);
 
 BPF_CALL_5(bpf_snprintf, char *, str, u32, str_size, char *, fmt,
 	   const void *, args, u32, data_len)
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 3969eb0382af..1743d1f434fc 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -4,6 +4,7 @@
 #include <linux/bpf_local_storage.h>
 #include <linux/btf.h>
 #include <linux/bug.h>
+#include <linux/export.h>
 #include <linux/filter.h>
 #include <linux/mm.h>
 #include <linux/rbtree.h>
@@ -478,6 +479,7 @@ int bpf_cgroup_storage_assign(struct bpf_prog_aux *aux, struct bpf_map *_map)
 	aux->cgroup_storage[stype] = _map;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(bpf_cgroup_storage_assign);
 
 static size_t bpf_cgroup_storage_calculate_size(struct bpf_map *map, u32 *pages)
 {
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 38050f4ee400..0ed4e0b89fdf 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -8,6 +8,7 @@
 #include <linux/types.h>
 #include <linux/bpf.h>
 #include <linux/bpf_verifier.h>
+#include <linux/export.h>
 #include <linux/math64.h>
 #include <linux/string.h>
 
@@ -41,6 +42,7 @@ int bpf_vlog_init(struct bpf_verifier_log *log, u32 log_level,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(bpf_vlog_init);
 
 static void bpf_vlog_update_len_max(struct bpf_verifier_log *log, u32 add_len)
 {
@@ -145,6 +147,7 @@ void bpf_verifier_vlog(struct bpf_verifier_log *log, const char *fmt,
 fail:
 	log->ubuf = NULL;
 }
+EXPORT_SYMBOL_GPL(bpf_verifier_vlog);
 
 void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos)
 {
@@ -176,6 +179,7 @@ void bpf_vlog_reset(struct bpf_verifier_log *log, u64 new_pos)
 	if (pos < log->len_total && put_user(zero, log->ubuf + pos))
 		log->ubuf = NULL;
 }
+EXPORT_SYMBOL_GPL(bpf_vlog_reset);
 
 static void bpf_vlog_reverse_kbuf(char *buf, int len)
 {
@@ -296,6 +300,7 @@ int bpf_vlog_finalize(struct bpf_verifier_log *log, u32 *log_size_actual)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(bpf_vlog_finalize);
 
 /* log_level controls verbosity level of eBPF verifier.
  * bpf_verifier_log_write() is used to dump the verification trace to the log,
@@ -426,6 +431,7 @@ __printf(3, 4) void verbose_linfo(struct bpf_verifier_env *env,
 
 	env->prev_linfo = linfo;
 }
+EXPORT_SYMBOL_GPL(verbose_linfo);
 
 static const char *btf_type_name(const struct btf *btf, u32 id)
 {
@@ -486,6 +492,7 @@ const char *reg_type_str(struct bpf_verifier_env *env, enum bpf_reg_type type)
 		 prefix, str[base_type(type)], postfix);
 	return env->tmp_str_buf;
 }
+EXPORT_SYMBOL_GPL(reg_type_str);
 
 const char *dynptr_type_str(enum bpf_dynptr_type type)
 {
@@ -505,6 +512,7 @@ const char *dynptr_type_str(enum bpf_dynptr_type type)
 		return "<unknown>";
 	}
 }
+EXPORT_SYMBOL_GPL(dynptr_type_str);
 
 const char *iter_type_str(const struct btf *btf, u32 btf_id)
 {
@@ -514,6 +522,7 @@ const char *iter_type_str(const struct btf *btf, u32 btf_id)
 	/* we already validated that type is valid and has conforming name */
 	return btf_type_name(btf, btf_id) + sizeof(ITER_PREFIX) - 1;
 }
+EXPORT_SYMBOL_GPL(iter_type_str);
 
 const char *iter_state_str(enum bpf_iter_state state)
 {
@@ -529,6 +538,7 @@ const char *iter_state_str(enum bpf_iter_state state)
 		return "<unknown>";
 	}
 }
+EXPORT_SYMBOL_GPL(iter_state_str);
 
 static char slot_type_char[] = {
 	[STACK_INVALID]	= '?',
@@ -859,6 +869,7 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 	if (!print_all)
 		mark_verifier_state_clean(env);
 }
+EXPORT_SYMBOL_GPL(print_verifier_state);
 
 static inline u32 vlog_alignment(u32 pos)
 {
@@ -878,3 +889,4 @@ void print_insn_state(struct bpf_verifier_env *env, const struct bpf_verifier_st
 	}
 	print_verifier_state(env, vstate, frameno, false);
 }
+EXPORT_SYMBOL_GPL(print_insn_state);
diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index 9575314f40a6..e6c3142b9e91 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -79,6 +79,7 @@ static const struct seq_operations bpf_map_seq_ops = {
 };
 
 BTF_ID_LIST_GLOBAL_SINGLE(btf_bpf_map_id, struct, bpf_map)
+EXPORT_SYMBOL_GPL(btf_bpf_map_id);
 
 static const struct bpf_iter_seq_info bpf_map_seq_info = {
 	.seq_ops		= &bpf_map_seq_ops,
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 889374722d0a..a35079962965 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -3,6 +3,7 @@
 #include <linux/mm.h>
 #include <linux/llist.h>
 #include <linux/bpf.h>
+#include <linux/export.h>
 #include <linux/irq_work.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/memcontrol.h>
@@ -587,6 +588,7 @@ int bpf_mem_alloc_percpu_init(struct bpf_mem_alloc *ma, struct obj_cgroup *objcg
 	ma->percpu = true;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(bpf_mem_alloc_percpu_init);
 
 int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size)
 {
@@ -623,6 +625,7 @@ int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(bpf_mem_alloc_percpu_unit_init);
 
 static void drain_mem_cache(struct bpf_mem_cache *c)
 {
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 42ae8d595c2c..e20d0e9f5fed 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -16,6 +16,7 @@
 #include <linux/bpf.h>
 #include <linux/bpf_verifier.h>
 #include <linux/bug.h>
+#include <linux/export.h>
 #include <linux/kdev_t.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
@@ -309,6 +310,7 @@ int bpf_prog_offload_verifier_prep(struct bpf_prog *prog)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(bpf_prog_offload_verifier_prep);
 
 int bpf_prog_offload_verify_insn(struct bpf_verifier_env *env,
 				 int insn_idx, int prev_insn_idx)
@@ -325,6 +327,7 @@ int bpf_prog_offload_verify_insn(struct bpf_verifier_env *env,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(bpf_prog_offload_verify_insn);
 
 int bpf_prog_offload_finalize(struct bpf_verifier_env *env)
 {
@@ -343,6 +346,7 @@ int bpf_prog_offload_finalize(struct bpf_verifier_env *env)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(bpf_prog_offload_finalize);
 
 void
 bpf_prog_offload_replace_insn(struct bpf_verifier_env *env, u32 off,
@@ -362,6 +366,7 @@ bpf_prog_offload_replace_insn(struct bpf_verifier_env *env, u32 off,
 	}
 	up_read(&bpf_devs_lock);
 }
+EXPORT_SYMBOL_GPL(bpf_prog_offload_replace_insn);
 
 void
 bpf_prog_offload_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
@@ -378,6 +383,7 @@ bpf_prog_offload_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
 	}
 	up_read(&bpf_devs_lock);
 }
+EXPORT_SYMBOL_GPL(bpf_prog_offload_remove_insns);
 
 void bpf_prog_dev_bound_destroy(struct bpf_prog *prog)
 {
@@ -744,6 +750,7 @@ bool bpf_prog_dev_bound_match(const struct bpf_prog *lhs, const struct bpf_prog
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(bpf_prog_dev_bound_match);
 
 bool bpf_offload_prog_map_match(struct bpf_prog *prog, struct bpf_map *map)
 {
@@ -760,6 +767,7 @@ bool bpf_offload_prog_map_match(struct bpf_prog *prog, struct bpf_map *map)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(bpf_offload_prog_map_match);
 
 int bpf_offload_dev_netdev_register(struct bpf_offload_dev *offdev,
 				    struct net_device *netdev)
@@ -840,6 +848,7 @@ int bpf_dev_bound_kfunc_check(struct bpf_verifier_log *log,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(bpf_dev_bound_kfunc_check);
 
 void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
 {
@@ -869,6 +878,7 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
 
 	return p;
 }
+EXPORT_SYMBOL_GPL(bpf_dev_bound_resolve_kfunc);
 
 static int __init bpf_offload_init(void)
 {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9794446bc8c6..2ef55503ba32 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -8,6 +8,7 @@
 #include <linux/bpf_verifier.h>
 #include <linux/bsearch.h>
 #include <linux/btf.h>
+#include <linux/export.h>
 #include <linux/syscalls.h>
 #include <linux/slab.h>
 #include <linux/sched/signal.h>
@@ -104,6 +105,7 @@ int bpf_check_uarg_tail_zero(bpfptr_t uaddr,
 		return res;
 	return res ? 0 : -E2BIG;
 }
+EXPORT_SYMBOL_GPL(bpf_check_uarg_tail_zero);
 
 const struct bpf_map_ops bpf_map_offload_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
@@ -112,6 +114,7 @@ const struct bpf_map_ops bpf_map_offload_ops = {
 	.map_check_btf = map_check_no_btf,
 	.map_mem_usage = bpf_map_offload_map_mem_usage,
 };
+EXPORT_SYMBOL_GPL(bpf_map_offload_ops);
 
 static void bpf_map_write_active_inc(struct bpf_map *map)
 {
@@ -127,6 +130,7 @@ bool bpf_map_write_active(const struct bpf_map *map)
 {
 	return atomic64_read(&map->writecnt) != 0;
 }
+EXPORT_SYMBOL_GPL(bpf_map_write_active);
 
 static u32 bpf_map_value_size(const struct bpf_map *map)
 {
@@ -642,6 +646,7 @@ struct btf_field *btf_record_find(const struct btf_record *rec, u32 offset,
 		return NULL;
 	return field;
 }
+EXPORT_SYMBOL_GPL(btf_record_find);
 
 void btf_record_free(struct btf_record *rec)
 {
@@ -1145,6 +1150,7 @@ const struct file_operations bpf_map_fops = {
 	.poll		= bpf_map_poll,
 	.get_unmapped_area = bpf_get_unmapped_area,
 };
+EXPORT_SYMBOL_GPL(bpf_map_fops);
 
 int bpf_map_new_fd(struct bpf_map *map, int flags)
 {
@@ -6103,6 +6109,7 @@ const struct bpf_verifier_ops bpf_syscall_verifier_ops = {
 	.get_func_proto  = syscall_prog_func_proto,
 	.is_valid_access = syscall_prog_is_valid_access,
 };
+EXPORT_SYMBOL_GPL(bpf_syscall_verifier_ops);
 
 const struct bpf_prog_ops bpf_syscall_prog_ops = {
 	.test_run = bpf_prog_test_run_syscall,
diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
index 9dbc31b25e3d..2f815447ace7 100644
--- a/kernel/bpf/tnum.c
+++ b/kernel/bpf/tnum.c
@@ -12,11 +12,13 @@
 #define TNUM(_v, _m)	(struct tnum){.value = _v, .mask = _m}
 /* A completely unknown value */
 const struct tnum tnum_unknown = { .value = 0, .mask = -1 };
+EXPORT_SYMBOL_GPL(tnum_unknown);
 
 struct tnum tnum_const(u64 value)
 {
 	return TNUM(value, 0);
 }
+EXPORT_SYMBOL_GPL(tnum_const);
 
 struct tnum tnum_range(u64 min, u64 max)
 {
@@ -33,16 +35,19 @@ struct tnum tnum_range(u64 min, u64 max)
 	delta = (1ULL << bits) - 1;
 	return TNUM(min & ~delta, delta);
 }
+EXPORT_SYMBOL_GPL(tnum_range);
 
 struct tnum tnum_lshift(struct tnum a, u8 shift)
 {
 	return TNUM(a.value << shift, a.mask << shift);
 }
+EXPORT_SYMBOL_GPL(tnum_lshift);
 
 struct tnum tnum_rshift(struct tnum a, u8 shift)
 {
 	return TNUM(a.value >> shift, a.mask >> shift);
 }
+EXPORT_SYMBOL_GPL(tnum_rshift);
 
 struct tnum tnum_arshift(struct tnum a, u8 min_shift, u8 insn_bitness)
 {
@@ -58,6 +63,7 @@ struct tnum tnum_arshift(struct tnum a, u8 min_shift, u8 insn_bitness)
 		return TNUM((s64)a.value >> min_shift,
 			    (s64)a.mask  >> min_shift);
 }
+EXPORT_SYMBOL_GPL(tnum_arshift);
 
 struct tnum tnum_add(struct tnum a, struct tnum b)
 {
@@ -70,6 +76,7 @@ struct tnum tnum_add(struct tnum a, struct tnum b)
 	mu = chi | a.mask | b.mask;
 	return TNUM(sv & ~mu, mu);
 }
+EXPORT_SYMBOL_GPL(tnum_add);
 
 struct tnum tnum_sub(struct tnum a, struct tnum b)
 {
@@ -82,6 +89,7 @@ struct tnum tnum_sub(struct tnum a, struct tnum b)
 	mu = chi | a.mask | b.mask;
 	return TNUM(dv & ~mu, mu);
 }
+EXPORT_SYMBOL_GPL(tnum_sub);
 
 struct tnum tnum_and(struct tnum a, struct tnum b)
 {
@@ -92,6 +100,7 @@ struct tnum tnum_and(struct tnum a, struct tnum b)
 	v = a.value & b.value;
 	return TNUM(v, alpha & beta & ~v);
 }
+EXPORT_SYMBOL_GPL(tnum_and);
 
 struct tnum tnum_or(struct tnum a, struct tnum b)
 {
@@ -101,6 +110,7 @@ struct tnum tnum_or(struct tnum a, struct tnum b)
 	mu = a.mask | b.mask;
 	return TNUM(v, mu & ~v);
 }
+EXPORT_SYMBOL_GPL(tnum_or);
 
 struct tnum tnum_xor(struct tnum a, struct tnum b)
 {
@@ -110,6 +120,7 @@ struct tnum tnum_xor(struct tnum a, struct tnum b)
 	mu = a.mask | b.mask;
 	return TNUM(v & ~mu, mu);
 }
+EXPORT_SYMBOL_GPL(tnum_xor);
 
 /* Generate partial products by multiplying each bit in the multiplier (tnum a)
  * with the multiplicand (tnum b), and add the partial products after
@@ -137,6 +148,7 @@ struct tnum tnum_mul(struct tnum a, struct tnum b)
 	}
 	return tnum_add(TNUM(acc_v, 0), acc_m);
 }
+EXPORT_SYMBOL_GPL(tnum_mul);
 
 /* Note that if a and b disagree - i.e. one has a 'known 1' where the other has
  * a 'known 0' - this will return a 'known 1' for that bit.
@@ -149,6 +161,7 @@ struct tnum tnum_intersect(struct tnum a, struct tnum b)
 	mu = a.mask & b.mask;
 	return TNUM(v & ~mu, mu);
 }
+EXPORT_SYMBOL_GPL(tnum_intersect);
 
 struct tnum tnum_cast(struct tnum a, u8 size)
 {
@@ -156,6 +169,7 @@ struct tnum tnum_cast(struct tnum a, u8 size)
 	a.mask &= (1ULL << (size * 8)) - 1;
 	return a;
 }
+EXPORT_SYMBOL_GPL(tnum_cast);
 
 bool tnum_is_aligned(struct tnum a, u64 size)
 {
@@ -163,6 +177,7 @@ bool tnum_is_aligned(struct tnum a, u64 size)
 		return true;
 	return !((a.value | a.mask) & (size - 1));
 }
+EXPORT_SYMBOL_GPL(tnum_is_aligned);
 
 bool tnum_in(struct tnum a, struct tnum b)
 {
@@ -171,6 +186,7 @@ bool tnum_in(struct tnum a, struct tnum b)
 	b.value &= ~a.mask;
 	return a.value == b.value;
 }
+EXPORT_SYMBOL_GPL(tnum_in);
 
 int tnum_sbin(char *str, size_t size, struct tnum a)
 {
@@ -196,18 +212,22 @@ struct tnum tnum_subreg(struct tnum a)
 {
 	return tnum_cast(a, 4);
 }
+EXPORT_SYMBOL_GPL(tnum_subreg);
 
 struct tnum tnum_clear_subreg(struct tnum a)
 {
 	return tnum_lshift(tnum_rshift(a, 32), 32);
 }
+EXPORT_SYMBOL_GPL(tnum_clear_subreg);
 
 struct tnum tnum_with_subreg(struct tnum reg, struct tnum subreg)
 {
 	return tnum_or(tnum_clear_subreg(reg), tnum_subreg(subreg));
 }
+EXPORT_SYMBOL_GPL(tnum_with_subreg);
 
 struct tnum tnum_const_subreg(struct tnum a, u32 value)
 {
 	return tnum_with_subreg(a, tnum_const(value));
 }
+EXPORT_SYMBOL_GPL(tnum_const_subreg);
diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index 26057aa13503..76936e8cf5af 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -25,6 +25,7 @@ bool bpf_token_capable(const struct bpf_token *token, int cap)
 		return false;
 	return true;
 }
+EXPORT_SYMBOL_GPL(bpf_token_capable);
 
 void bpf_token_inc(struct bpf_token *token)
 {
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index c4b1a98ff726..0ec41c025996 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2019 Facebook */
 #include <linux/hash.h>
 #include <linux/bpf.h>
+#include <linux/export.h>
 #include <linux/filter.h>
 #include <linux/ftrace.h>
 #include <linux/rbtree_latch.h>
@@ -17,6 +18,8 @@
 /* dummy _ops. The verifier will operate on target program's ops. */
 const struct bpf_verifier_ops bpf_extension_verifier_ops = {
 };
+EXPORT_SYMBOL_GPL(bpf_extension_verifier_ops);
+
 const struct bpf_prog_ops bpf_extension_prog_ops = {
 };
 
@@ -114,6 +117,7 @@ bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
 		 eatype == BPF_MODIFY_RETURN)) ||
 		(ptype == BPF_PROG_TYPE_LSM && eatype == BPF_LSM_MAC);
 }
+EXPORT_SYMBOL_GPL(bpf_prog_has_trampoline);
 
 void bpf_image_ksym_init(void *data, unsigned int size, struct bpf_ksym *ksym)
 {
@@ -836,6 +840,7 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
 	mutex_unlock(&tr->mutex);
 	return tr;
 }
+EXPORT_SYMBOL_GPL(bpf_trampoline_get);
 
 void bpf_trampoline_put(struct bpf_trampoline *tr)
 {
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 6c83ad674d01..5b19c4ed0c92 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -21,6 +21,8 @@ struct callchain_cpus_entries {
 };
 
 int sysctl_perf_event_max_stack __read_mostly = PERF_MAX_STACK_DEPTH;
+EXPORT_SYMBOL_GPL(sysctl_perf_event_max_stack);
+
 int sysctl_perf_event_max_contexts_per_stack __read_mostly = PERF_MAX_CONTEXTS_PER_STACK;
 static const int six_hundred_forty_kb = 640 * 1024;
 
@@ -142,6 +144,7 @@ int get_callchain_buffers(int event_max_stack)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(get_callchain_buffers);
 
 void put_callchain_buffers(void)
 {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 187dc37d61d4..fd9c5903605c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -9,6 +9,7 @@
 #include <linux/bpf_verifier.h>
 #include <linux/bpf_perf_event.h>
 #include <linux/btf.h>
+#include <linux/export.h>
 #include <linux/filter.h>
 #include <linux/uaccess.h>
 #include <linux/ctype.h>
@@ -1645,6 +1646,7 @@ const struct bpf_verifier_ops kprobe_verifier_ops = {
 	.get_func_proto  = kprobe_prog_func_proto,
 	.is_valid_access = kprobe_prog_is_valid_access,
 };
+EXPORT_SYMBOL_GPL(kprobe_verifier_ops);
 
 const struct bpf_prog_ops kprobe_prog_ops = {
 };
@@ -1751,6 +1753,7 @@ const struct bpf_verifier_ops tracepoint_verifier_ops = {
 	.get_func_proto  = tp_prog_func_proto,
 	.is_valid_access = tp_prog_is_valid_access,
 };
+EXPORT_SYMBOL_GPL(tracepoint_verifier_ops);
 
 const struct bpf_prog_ops tracepoint_prog_ops = {
 };
@@ -2067,6 +2070,7 @@ const struct bpf_verifier_ops raw_tracepoint_verifier_ops = {
 	.get_func_proto  = raw_tp_prog_func_proto,
 	.is_valid_access = raw_tp_prog_is_valid_access,
 };
+EXPORT_SYMBOL_GPL(raw_tracepoint_verifier_ops);
 
 const struct bpf_prog_ops raw_tracepoint_prog_ops = {
 #ifdef CONFIG_NET
@@ -2078,6 +2082,7 @@ const struct bpf_verifier_ops tracing_verifier_ops = {
 	.get_func_proto  = tracing_prog_func_proto,
 	.is_valid_access = tracing_prog_is_valid_access,
 };
+EXPORT_SYMBOL_GPL(tracing_verifier_ops);
 
 const struct bpf_prog_ops tracing_prog_ops = {
 	.test_run = bpf_prog_test_run_tracing,
@@ -2100,6 +2105,7 @@ const struct bpf_verifier_ops raw_tracepoint_writable_verifier_ops = {
 	.get_func_proto  = raw_tp_prog_func_proto,
 	.is_valid_access = raw_tp_writable_prog_is_valid_access,
 };
+EXPORT_SYMBOL_GPL(raw_tracepoint_writable_verifier_ops);
 
 const struct bpf_prog_ops raw_tracepoint_writable_prog_ops = {
 };
@@ -2183,6 +2189,7 @@ const struct bpf_verifier_ops perf_event_verifier_ops = {
 	.is_valid_access	= pe_prog_is_valid_access,
 	.convert_ctx_access	= pe_prog_convert_ctx_access,
 };
+EXPORT_SYMBOL_GPL(perf_event_verifier_ops);
 
 const struct bpf_prog_ops perf_event_prog_ops = {
 };
@@ -2333,6 +2340,7 @@ struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name)
 
 	return bpf_get_raw_tracepoint_module(name);
 }
+EXPORT_SYMBOL_GPL(bpf_get_raw_tracepoint);
 
 void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
 {
@@ -2342,6 +2350,7 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
 	mod = __module_address((unsigned long)btp);
 	module_put(mod);
 }
+EXPORT_SYMBOL_GPL(bpf_put_raw_tracepoint);
 
 static __always_inline
 void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
diff --git a/lib/error-inject.c b/lib/error-inject.c
index 887acd9a6ea6..10312e487843 100644
--- a/lib/error-inject.c
+++ b/lib/error-inject.c
@@ -2,6 +2,7 @@
 // error-inject.c: Function-level error injection table
 #include <linux/error-injection.h>
 #include <linux/debugfs.h>
+#include <linux/export.h>
 #include <linux/kallsyms.h>
 #include <linux/kprobes.h>
 #include <linux/module.h>
@@ -36,6 +37,7 @@ bool within_error_injection_list(unsigned long addr)
 	mutex_unlock(&ei_mutex);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(within_error_injection_list);
 
 int get_injectable_error_type(unsigned long addr)
 {
diff --git a/net/core/filter.c b/net/core/filter.c
index bc6828761a47..5c4908fd6bf8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -30,6 +30,7 @@
 #include <linux/netdevice.h>
 #include <linux/if_packet.h>
 #include <linux/if_arp.h>
+#include <linux/export.h>
 #include <linux/gfp.h>
 #include <net/inet_common.h>
 #include <net/ip.h>
@@ -7194,6 +7195,7 @@ bool bpf_tcp_sock_is_valid_access(int off, int size, enum bpf_access_type type,
 		return size == sizeof(__u32);
 	}
 }
+EXPORT_SYMBOL_GPL(bpf_tcp_sock_is_valid_access);
 
 u32 bpf_tcp_sock_convert_ctx_access(enum bpf_access_type type,
 				    const struct bpf_insn *si,
@@ -7317,6 +7319,7 @@ u32 bpf_tcp_sock_convert_ctx_access(enum bpf_access_type type,
 
 	return insn - insn_buf;
 }
+EXPORT_SYMBOL_GPL(bpf_tcp_sock_convert_ctx_access);
 
 BPF_CALL_1(bpf_tcp_sock, struct sock *, sk)
 {
@@ -7388,6 +7391,7 @@ bool bpf_xdp_sock_is_valid_access(int off, int size, enum bpf_access_type type,
 		return size == sizeof(__u32);
 	}
 }
+EXPORT_SYMBOL_GPL(bpf_xdp_sock_is_valid_access);
 
 u32 bpf_xdp_sock_convert_ctx_access(enum bpf_access_type type,
 				    const struct bpf_insn *si,
@@ -7413,6 +7417,7 @@ u32 bpf_xdp_sock_convert_ctx_access(enum bpf_access_type type,
 
 	return insn - insn_buf;
 }
+EXPORT_SYMBOL_GPL(bpf_xdp_sock_convert_ctx_access);
 
 static const struct bpf_func_proto bpf_skb_ecn_set_ce_proto = {
 	.func           = bpf_skb_ecn_set_ce,
@@ -8879,6 +8884,7 @@ bool bpf_sock_common_is_valid_access(int off, int size,
 		return bpf_sock_is_valid_access(off, size, type, info);
 	}
 }
+EXPORT_SYMBOL_GPL(bpf_sock_common_is_valid_access);
 
 bool bpf_sock_is_valid_access(int off, int size, enum bpf_access_type type,
 			      struct bpf_insn_access_aux *info)
@@ -8916,6 +8922,7 @@ bool bpf_sock_is_valid_access(int off, int size, enum bpf_access_type type,
 
 	return size == size_default;
 }
+EXPORT_SYMBOL_GPL(bpf_sock_is_valid_access);
 
 static bool sock_filter_is_valid_access(int off, int size,
 					enum bpf_access_type type,
@@ -10156,6 +10163,7 @@ u32 bpf_sock_convert_ctx_access(enum bpf_access_type type,
 
 	return insn - insn_buf;
 }
+EXPORT_SYMBOL_GPL(bpf_sock_convert_ctx_access);
 
 static u32 tc_cls_act_convert_ctx_access(enum bpf_access_type type,
 					 const struct bpf_insn *si,
@@ -11075,6 +11083,7 @@ const struct bpf_verifier_ops sk_filter_verifier_ops = {
 	.convert_ctx_access	= bpf_convert_ctx_access,
 	.gen_ld_abs		= bpf_gen_ld_abs,
 };
+EXPORT_SYMBOL_GPL(sk_filter_verifier_ops);
 
 const struct bpf_prog_ops sk_filter_prog_ops = {
 	.test_run		= bpf_prog_test_run_skb,
@@ -11088,6 +11097,7 @@ const struct bpf_verifier_ops tc_cls_act_verifier_ops = {
 	.gen_ld_abs		= bpf_gen_ld_abs,
 	.btf_struct_access	= tc_cls_act_btf_struct_access,
 };
+EXPORT_SYMBOL_GPL(tc_cls_act_verifier_ops);
 
 const struct bpf_prog_ops tc_cls_act_prog_ops = {
 	.test_run		= bpf_prog_test_run_skb,
@@ -11100,6 +11110,7 @@ const struct bpf_verifier_ops xdp_verifier_ops = {
 	.gen_prologue		= bpf_noop_prologue,
 	.btf_struct_access	= xdp_btf_struct_access,
 };
+EXPORT_SYMBOL_GPL(xdp_verifier_ops);
 
 const struct bpf_prog_ops xdp_prog_ops = {
 	.test_run		= bpf_prog_test_run_xdp,
@@ -11110,6 +11121,7 @@ const struct bpf_verifier_ops cg_skb_verifier_ops = {
 	.is_valid_access	= cg_skb_is_valid_access,
 	.convert_ctx_access	= bpf_convert_ctx_access,
 };
+EXPORT_SYMBOL_GPL(cg_skb_verifier_ops);
 
 const struct bpf_prog_ops cg_skb_prog_ops = {
 	.test_run		= bpf_prog_test_run_skb,
@@ -11120,6 +11132,7 @@ const struct bpf_verifier_ops lwt_in_verifier_ops = {
 	.is_valid_access	= lwt_is_valid_access,
 	.convert_ctx_access	= bpf_convert_ctx_access,
 };
+EXPORT_SYMBOL_GPL(lwt_in_verifier_ops);
 
 const struct bpf_prog_ops lwt_in_prog_ops = {
 	.test_run		= bpf_prog_test_run_skb,
@@ -11130,6 +11143,7 @@ const struct bpf_verifier_ops lwt_out_verifier_ops = {
 	.is_valid_access	= lwt_is_valid_access,
 	.convert_ctx_access	= bpf_convert_ctx_access,
 };
+EXPORT_SYMBOL_GPL(lwt_out_verifier_ops);
 
 const struct bpf_prog_ops lwt_out_prog_ops = {
 	.test_run		= bpf_prog_test_run_skb,
@@ -11141,6 +11155,7 @@ const struct bpf_verifier_ops lwt_xmit_verifier_ops = {
 	.convert_ctx_access	= bpf_convert_ctx_access,
 	.gen_prologue		= tc_cls_act_prologue,
 };
+EXPORT_SYMBOL_GPL(lwt_xmit_verifier_ops);
 
 const struct bpf_prog_ops lwt_xmit_prog_ops = {
 	.test_run		= bpf_prog_test_run_skb,
@@ -11151,6 +11166,7 @@ const struct bpf_verifier_ops lwt_seg6local_verifier_ops = {
 	.is_valid_access	= lwt_is_valid_access,
 	.convert_ctx_access	= bpf_convert_ctx_access,
 };
+EXPORT_SYMBOL_GPL(lwt_seg6local_verifier_ops);
 
 const struct bpf_prog_ops lwt_seg6local_prog_ops = {
 };
@@ -11160,6 +11176,7 @@ const struct bpf_verifier_ops cg_sock_verifier_ops = {
 	.is_valid_access	= sock_filter_is_valid_access,
 	.convert_ctx_access	= bpf_sock_convert_ctx_access,
 };
+EXPORT_SYMBOL_GPL(cg_sock_verifier_ops);
 
 const struct bpf_prog_ops cg_sock_prog_ops = {
 };
@@ -11169,6 +11186,7 @@ const struct bpf_verifier_ops cg_sock_addr_verifier_ops = {
 	.is_valid_access	= sock_addr_is_valid_access,
 	.convert_ctx_access	= sock_addr_convert_ctx_access,
 };
+EXPORT_SYMBOL_GPL(cg_sock_addr_verifier_ops);
 
 const struct bpf_prog_ops cg_sock_addr_prog_ops = {
 };
@@ -11178,6 +11196,7 @@ const struct bpf_verifier_ops sock_ops_verifier_ops = {
 	.is_valid_access	= sock_ops_is_valid_access,
 	.convert_ctx_access	= sock_ops_convert_ctx_access,
 };
+EXPORT_SYMBOL_GPL(sock_ops_verifier_ops);
 
 const struct bpf_prog_ops sock_ops_prog_ops = {
 };
@@ -11188,6 +11207,7 @@ const struct bpf_verifier_ops sk_skb_verifier_ops = {
 	.convert_ctx_access	= sk_skb_convert_ctx_access,
 	.gen_prologue		= sk_skb_prologue,
 };
+EXPORT_SYMBOL_GPL(sk_skb_verifier_ops);
 
 const struct bpf_prog_ops sk_skb_prog_ops = {
 };
@@ -11198,6 +11218,7 @@ const struct bpf_verifier_ops sk_msg_verifier_ops = {
 	.convert_ctx_access	= sk_msg_convert_ctx_access,
 	.gen_prologue		= bpf_noop_prologue,
 };
+EXPORT_SYMBOL_GPL(sk_msg_verifier_ops);
 
 const struct bpf_prog_ops sk_msg_prog_ops = {
 };
@@ -11207,6 +11228,7 @@ const struct bpf_verifier_ops flow_dissector_verifier_ops = {
 	.is_valid_access	= flow_dissector_is_valid_access,
 	.convert_ctx_access	= flow_dissector_convert_ctx_access,
 };
+EXPORT_SYMBOL_GPL(flow_dissector_verifier_ops);
 
 const struct bpf_prog_ops flow_dissector_prog_ops = {
 	.test_run		= bpf_prog_test_run_flow_dissector,
@@ -11547,6 +11569,7 @@ const struct bpf_verifier_ops sk_reuseport_verifier_ops = {
 	.is_valid_access	= sk_reuseport_is_valid_access,
 	.convert_ctx_access	= sk_reuseport_convert_ctx_access,
 };
+EXPORT_SYMBOL_GPL(sk_reuseport_verifier_ops);
 
 const struct bpf_prog_ops sk_reuseport_prog_ops = {
 };
@@ -11759,6 +11782,7 @@ const struct bpf_verifier_ops sk_lookup_verifier_ops = {
 	.is_valid_access	= sk_lookup_is_valid_access,
 	.convert_ctx_access	= sk_lookup_convert_ctx_access,
 };
+EXPORT_SYMBOL_GPL(sk_lookup_verifier_ops);
 
 #endif /* CONFIG_INET */
 
@@ -11773,6 +11797,7 @@ BTF_ID_LIST_GLOBAL(btf_sock_ids, MAX_BTF_SOCK_TYPE)
 #define BTF_SOCK_TYPE(name, type) BTF_ID(struct, type)
 BTF_SOCK_TYPE_xxx
 #undef BTF_SOCK_TYPE
+EXPORT_SYMBOL_GPL(btf_sock_ids);
 
 BPF_CALL_1(bpf_skc_to_tcp6_sock, struct sock *, sk)
 {
@@ -12161,6 +12186,7 @@ int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(bpf_dynptr_from_skb_rdonly);
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_skb)
 BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
diff --git a/net/core/xdp.c b/net/core/xdp.c
index f86eedad586a..a0deb63420a2 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -6,6 +6,7 @@
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
+#include <linux/export.h>
 #include <linux/filter.h>
 #include <linux/types.h>
 #include <linux/mm.h>
@@ -984,6 +985,7 @@ bool bpf_dev_bound_kfunc_id(u32 btf_id)
 {
 	return btf_id_set8_contains(&xdp_metadata_kfunc_ids, btf_id);
 }
+EXPORT_SYMBOL_GPL(bpf_dev_bound_kfunc_id);
 
 static int __init xdp_metadata_init(void)
 {
diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
index 06b084844700..0e714fb36dd7 100644
--- a/net/netfilter/nf_bpf_link.c
+++ b/net/netfilter/nf_bpf_link.c
@@ -326,3 +326,4 @@ const struct bpf_verifier_ops netfilter_verifier_ops = {
 	.is_valid_access	= nf_is_valid_access,
 	.get_func_proto		= bpf_nf_func_proto,
 };
+EXPORT_SYMBOL_GPL(netfilter_verifier_ops);
-- 
2.47.1


