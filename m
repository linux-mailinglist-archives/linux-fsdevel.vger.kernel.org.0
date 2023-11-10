Return-Path: <linux-fsdevel+bounces-2680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0137E7864
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 04:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B5D3281759
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 03:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F4423DC;
	Fri, 10 Nov 2023 03:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150CC1876
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 03:49:06 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57229469A
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 19:49:06 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9MZAuM002434
	for <linux-fsdevel@vger.kernel.org>; Thu, 9 Nov 2023 19:49:06 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u91swwk3x-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 09 Nov 2023 19:49:05 -0800
Received: from twshared15991.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 19:49:00 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id B697E3B41DC27; Thu,  9 Nov 2023 19:48:52 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <keescook@chromium.org>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v10 bpf-next 07/17] bpf: take into account BPF token when fetching helper protos
Date: Thu, 9 Nov 2023 19:48:28 -0800
Message-ID: <20231110034838.1295764-8-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110034838.1295764-1-andrii@kernel.org>
References: <20231110034838.1295764-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: CalRasZjIX5LL88QCTIKmP9ukMjUWqPK
X-Proofpoint-ORIG-GUID: CalRasZjIX5LL88QCTIKmP9ukMjUWqPK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_17,2023-11-09_01,2023-05-22_02

Instead of performing unconditional system-wide bpf_capable() and
perfmon_capable() calls inside bpf_base_func_proto() function (and other
similar ones) to determine eligibility of a given BPF helper for a given
program, use previously recorded BPF token during BPF_PROG_LOAD command
handling to inform the decision.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 drivers/media/rc/bpf-lirc.c |  2 +-
 include/linux/bpf.h         |  5 +++--
 kernel/bpf/cgroup.c         |  6 +++---
 kernel/bpf/helpers.c        |  6 +++---
 kernel/bpf/syscall.c        |  5 +++--
 kernel/trace/bpf_trace.c    |  2 +-
 net/core/filter.c           | 32 ++++++++++++++++----------------
 net/ipv4/bpf_tcp_ca.c       |  2 +-
 net/netfilter/nf_bpf_link.c |  2 +-
 9 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
index fe17c7f98e81..6d07693c6b9f 100644
--- a/drivers/media/rc/bpf-lirc.c
+++ b/drivers/media/rc/bpf-lirc.c
@@ -110,7 +110,7 @@ lirc_mode2_func_proto(enum bpf_func_id func_id, const=
 struct bpf_prog *prog)
 	case BPF_FUNC_get_prandom_u32:
 		return &bpf_get_prandom_u32_proto;
 	case BPF_FUNC_trace_printk:
-		if (perfmon_capable())
+		if (bpf_token_capable(prog->aux->token, CAP_PERFMON))
 			return bpf_get_trace_printk_proto();
 		fallthrough;
 	default:
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4c9a93a6df2a..226f74712dc0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2475,7 +2475,8 @@ const char *btf_find_decl_tag_value(const struct bt=
f *btf, const struct btf_type
 struct bpf_prog *bpf_prog_by_id(u32 id);
 struct bpf_link *bpf_link_by_id(u32 id);
=20
-const struct bpf_func_proto *bpf_base_func_proto(enum bpf_func_id func_i=
d);
+const struct bpf_func_proto *bpf_base_func_proto(enum bpf_func_id func_i=
d,
+						 const struct bpf_prog *prog);
 void bpf_task_storage_free(struct task_struct *task);
 void bpf_cgrp_storage_free(struct cgroup *cgroup);
 bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
@@ -2735,7 +2736,7 @@ static inline int btf_struct_access(struct bpf_veri=
fier_log *log,
 }
=20
 static inline const struct bpf_func_proto *
-bpf_base_func_proto(enum bpf_func_id func_id)
+bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *pro=
g)
 {
 	return NULL;
 }
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 491d20038cbe..98e0e3835b28 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1630,7 +1630,7 @@ cgroup_dev_func_proto(enum bpf_func_id func_id, con=
st struct bpf_prog *prog)
 	case BPF_FUNC_perf_event_output:
 		return &bpf_event_output_data_proto;
 	default:
-		return bpf_base_func_proto(func_id);
+		return bpf_base_func_proto(func_id, prog);
 	}
 }
=20
@@ -2191,7 +2191,7 @@ sysctl_func_proto(enum bpf_func_id func_id, const s=
truct bpf_prog *prog)
 	case BPF_FUNC_perf_event_output:
 		return &bpf_event_output_data_proto;
 	default:
-		return bpf_base_func_proto(func_id);
+		return bpf_base_func_proto(func_id, prog);
 	}
 }
=20
@@ -2348,7 +2348,7 @@ cg_sockopt_func_proto(enum bpf_func_id func_id, con=
st struct bpf_prog *prog)
 	case BPF_FUNC_perf_event_output:
 		return &bpf_event_output_data_proto;
 	default:
-		return bpf_base_func_proto(func_id);
+		return bpf_base_func_proto(func_id, prog);
 	}
 }
=20
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 3f79bc87b70f..a25b2b3dc098 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1669,7 +1669,7 @@ const struct bpf_func_proto bpf_probe_read_kernel_s=
tr_proto __weak;
 const struct bpf_func_proto bpf_task_pt_regs_proto __weak;
=20
 const struct bpf_func_proto *
-bpf_base_func_proto(enum bpf_func_id func_id)
+bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *pro=
g)
 {
 	switch (func_id) {
 	case BPF_FUNC_map_lookup_elem:
@@ -1720,7 +1720,7 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		break;
 	}
=20
-	if (!bpf_capable())
+	if (!bpf_token_capable(prog->aux->token, CAP_BPF))
 		return NULL;
=20
 	switch (func_id) {
@@ -1778,7 +1778,7 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		break;
 	}
=20
-	if (!perfmon_capable())
+	if (!bpf_token_capable(prog->aux->token, CAP_PERFMON))
 		return NULL;
=20
 	switch (func_id) {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 615b5ad18c61..c4de25af8607 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5681,7 +5681,7 @@ static const struct bpf_func_proto bpf_sys_bpf_prot=
o =3D {
 const struct bpf_func_proto * __weak
 tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog =
*prog)
 {
-	return bpf_base_func_proto(func_id);
+	return bpf_base_func_proto(func_id, prog);
 }
=20
 BPF_CALL_1(bpf_sys_close, u32, fd)
@@ -5731,7 +5731,8 @@ syscall_prog_func_proto(enum bpf_func_id func_id, c=
onst struct bpf_prog *prog)
 {
 	switch (func_id) {
 	case BPF_FUNC_sys_bpf:
-		return !perfmon_capable() ? NULL : &bpf_sys_bpf_proto;
+		return !bpf_token_capable(prog->aux->token, CAP_PERFMON)
+		       ? NULL : &bpf_sys_bpf_proto;
 	case BPF_FUNC_btf_find_by_name_kind:
 		return &bpf_btf_find_by_name_kind_proto;
 	case BPF_FUNC_sys_close:
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d525a22b8d56..1e92db682931 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1561,7 +1561,7 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, co=
nst struct bpf_prog *prog)
 	case BPF_FUNC_trace_vprintk:
 		return bpf_get_trace_vprintk_proto();
 	default:
-		return bpf_base_func_proto(func_id);
+		return bpf_base_func_proto(func_id, prog);
 	}
 }
=20
diff --git a/net/core/filter.c b/net/core/filter.c
index 21d75108c2e9..cd2ef9fb4f1e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -86,7 +86,7 @@
 #include "dev.h"
=20
 static const struct bpf_func_proto *
-bpf_sk_base_func_proto(enum bpf_func_id func_id);
+bpf_sk_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *=
prog);
=20
 int copy_bpf_fprog_from_user(struct sock_fprog *dst, sockptr_t src, int =
len)
 {
@@ -7839,7 +7839,7 @@ sock_filter_func_proto(enum bpf_func_id func_id, co=
nst struct bpf_prog *prog)
 	case BPF_FUNC_ktime_get_coarse_ns:
 		return &bpf_ktime_get_coarse_ns_proto;
 	default:
-		return bpf_base_func_proto(func_id);
+		return bpf_base_func_proto(func_id, prog);
 	}
 }
=20
@@ -7932,7 +7932,7 @@ sock_addr_func_proto(enum bpf_func_id func_id, cons=
t struct bpf_prog *prog)
 			return NULL;
 		}
 	default:
-		return bpf_sk_base_func_proto(func_id);
+		return bpf_sk_base_func_proto(func_id, prog);
 	}
 }
=20
@@ -7951,7 +7951,7 @@ sk_filter_func_proto(enum bpf_func_id func_id, cons=
t struct bpf_prog *prog)
 	case BPF_FUNC_perf_event_output:
 		return &bpf_skb_event_output_proto;
 	default:
-		return bpf_sk_base_func_proto(func_id);
+		return bpf_sk_base_func_proto(func_id, prog);
 	}
 }
=20
@@ -8138,7 +8138,7 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, con=
st struct bpf_prog *prog)
 #endif
 #endif
 	default:
-		return bpf_sk_base_func_proto(func_id);
+		return bpf_sk_base_func_proto(func_id, prog);
 	}
 }
=20
@@ -8197,7 +8197,7 @@ xdp_func_proto(enum bpf_func_id func_id, const stru=
ct bpf_prog *prog)
 #endif
 #endif
 	default:
-		return bpf_sk_base_func_proto(func_id);
+		return bpf_sk_base_func_proto(func_id, prog);
 	}
=20
 #if IS_MODULE(CONFIG_NF_CONNTRACK) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_M=
ODULES)
@@ -8258,7 +8258,7 @@ sock_ops_func_proto(enum bpf_func_id func_id, const=
 struct bpf_prog *prog)
 		return &bpf_tcp_sock_proto;
 #endif /* CONFIG_INET */
 	default:
-		return bpf_sk_base_func_proto(func_id);
+		return bpf_sk_base_func_proto(func_id, prog);
 	}
 }
=20
@@ -8300,7 +8300,7 @@ sk_msg_func_proto(enum bpf_func_id func_id, const s=
truct bpf_prog *prog)
 		return &bpf_get_cgroup_classid_curr_proto;
 #endif
 	default:
-		return bpf_sk_base_func_proto(func_id);
+		return bpf_sk_base_func_proto(func_id, prog);
 	}
 }
=20
@@ -8344,7 +8344,7 @@ sk_skb_func_proto(enum bpf_func_id func_id, const s=
truct bpf_prog *prog)
 		return &bpf_skc_lookup_tcp_proto;
 #endif
 	default:
-		return bpf_sk_base_func_proto(func_id);
+		return bpf_sk_base_func_proto(func_id, prog);
 	}
 }
=20
@@ -8355,7 +8355,7 @@ flow_dissector_func_proto(enum bpf_func_id func_id,=
 const struct bpf_prog *prog)
 	case BPF_FUNC_skb_load_bytes:
 		return &bpf_flow_dissector_load_bytes_proto;
 	default:
-		return bpf_sk_base_func_proto(func_id);
+		return bpf_sk_base_func_proto(func_id, prog);
 	}
 }
=20
@@ -8382,7 +8382,7 @@ lwt_out_func_proto(enum bpf_func_id func_id, const =
struct bpf_prog *prog)
 	case BPF_FUNC_skb_under_cgroup:
 		return &bpf_skb_under_cgroup_proto;
 	default:
-		return bpf_sk_base_func_proto(func_id);
+		return bpf_sk_base_func_proto(func_id, prog);
 	}
 }
=20
@@ -11213,7 +11213,7 @@ sk_reuseport_func_proto(enum bpf_func_id func_id,
 	case BPF_FUNC_ktime_get_coarse_ns:
 		return &bpf_ktime_get_coarse_ns_proto;
 	default:
-		return bpf_base_func_proto(func_id);
+		return bpf_base_func_proto(func_id, prog);
 	}
 }
=20
@@ -11395,7 +11395,7 @@ sk_lookup_func_proto(enum bpf_func_id func_id, co=
nst struct bpf_prog *prog)
 	case BPF_FUNC_sk_release:
 		return &bpf_sk_release_proto;
 	default:
-		return bpf_sk_base_func_proto(func_id);
+		return bpf_sk_base_func_proto(func_id, prog);
 	}
 }
=20
@@ -11729,7 +11729,7 @@ const struct bpf_func_proto bpf_sock_from_file_pr=
oto =3D {
 };
=20
 static const struct bpf_func_proto *
-bpf_sk_base_func_proto(enum bpf_func_id func_id)
+bpf_sk_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *=
prog)
 {
 	const struct bpf_func_proto *func;
=20
@@ -11758,10 +11758,10 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id=
)
 	case BPF_FUNC_ktime_get_coarse_ns:
 		return &bpf_ktime_get_coarse_ns_proto;
 	default:
-		return bpf_base_func_proto(func_id);
+		return bpf_base_func_proto(func_id, prog);
 	}
=20
-	if (!perfmon_capable())
+	if (!bpf_token_capable(prog->aux->token, CAP_PERFMON))
 		return NULL;
=20
 	return func;
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 39dcccf0f174..c7bbd8f3c708 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -191,7 +191,7 @@ bpf_tcp_ca_get_func_proto(enum bpf_func_id func_id,
 	case BPF_FUNC_ktime_get_coarse_ns:
 		return &bpf_ktime_get_coarse_ns_proto;
 	default:
-		return bpf_base_func_proto(func_id);
+		return bpf_base_func_proto(func_id, prog);
 	}
 }
=20
diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
index e502ec00b2fe..1969facac91c 100644
--- a/net/netfilter/nf_bpf_link.c
+++ b/net/netfilter/nf_bpf_link.c
@@ -314,7 +314,7 @@ static bool nf_is_valid_access(int off, int size, enu=
m bpf_access_type type,
 static const struct bpf_func_proto *
 bpf_nf_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
-	return bpf_base_func_proto(func_id);
+	return bpf_base_func_proto(func_id, prog);
 }
=20
 const struct bpf_verifier_ops netfilter_verifier_ops =3D {
--=20
2.34.1


