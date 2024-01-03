Return-Path: <linux-fsdevel+bounces-7287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCB78237D6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6A4CB23D52
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A521F608;
	Wed,  3 Jan 2024 22:21:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7617B1EB4D
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 22:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403GiT83026621
	for <linux-fsdevel@vger.kernel.org>; Wed, 3 Jan 2024 14:21:53 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3vd5324sc7-17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 14:21:51 -0800
Received: from twshared38604.02.prn6.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 3 Jan 2024 14:21:02 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 2CEE83DF9EAC2; Wed,  3 Jan 2024 14:20:52 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>, <torvalds@linuxfoundation.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <kernel-team@meta.com>
Subject: [PATCH bpf-next 08/29] bpf: consistently use BPF token throughout BPF verifier logic
Date: Wed, 3 Jan 2024 14:20:13 -0800
Message-ID: <20240103222034.2582628-9-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103222034.2582628-1-andrii@kernel.org>
References: <20240103222034.2582628-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: yE1sbSswO3Mpa5l0SaHo4Ocsq8xXEZiI
X-Proofpoint-GUID: yE1sbSswO3Mpa5l0SaHo4Ocsq8xXEZiI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_08,2024-01-03_01,2023-05-22_02

Remove remaining direct queries to perfmon_capable() and bpf_capable()
in BPF verifier logic and instead use BPF token (if available) to make
decisions about privileges.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h    | 16 ++++++++--------
 include/linux/filter.h |  2 +-
 kernel/bpf/arraymap.c  |  2 +-
 kernel/bpf/core.c      |  2 +-
 kernel/bpf/verifier.c  | 13 ++++++-------
 net/core/filter.c      |  4 ++--
 6 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f7c5aa01bb7b..d1023cd67f65 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2231,24 +2231,24 @@ extern int sysctl_unprivileged_bpf_disabled;
=20
 bool bpf_token_capable(const struct bpf_token *token, int cap);
=20
-static inline bool bpf_allow_ptr_leaks(void)
+static inline bool bpf_allow_ptr_leaks(const struct bpf_token *token)
 {
-	return perfmon_capable();
+	return bpf_token_capable(token, CAP_PERFMON);
 }
=20
-static inline bool bpf_allow_uninit_stack(void)
+static inline bool bpf_allow_uninit_stack(const struct bpf_token *token)
 {
-	return perfmon_capable();
+	return bpf_token_capable(token, CAP_PERFMON);
 }
=20
-static inline bool bpf_bypass_spec_v1(void)
+static inline bool bpf_bypass_spec_v1(const struct bpf_token *token)
 {
-	return cpu_mitigations_off() || perfmon_capable();
+	return cpu_mitigations_off() || bpf_token_capable(token, CAP_PERFMON);
 }
=20
-static inline bool bpf_bypass_spec_v4(void)
+static inline bool bpf_bypass_spec_v4(const struct bpf_token *token)
 {
-	return cpu_mitigations_off() || perfmon_capable();
+	return cpu_mitigations_off() || bpf_token_capable(token, CAP_PERFMON);
 }
=20
 int bpf_map_new_fd(struct bpf_map *map, int flags);
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 68fb6c8142fe..12d907f17d36 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1139,7 +1139,7 @@ static inline bool bpf_jit_blinding_enabled(struct =
bpf_prog *prog)
 		return false;
 	if (!bpf_jit_harden)
 		return false;
-	if (bpf_jit_harden =3D=3D 1 && bpf_capable())
+	if (bpf_jit_harden =3D=3D 1 && bpf_token_capable(prog->aux->token, CAP_=
BPF))
 		return false;
=20
 	return true;
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 0bdbbbeab155..13358675ff2e 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -82,7 +82,7 @@ static struct bpf_map *array_map_alloc(union bpf_attr *=
attr)
 	bool percpu =3D attr->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY;
 	int numa_node =3D bpf_map_attr_numa_node(attr);
 	u32 elem_size, index_mask, max_entries;
-	bool bypass_spec_v1 =3D bpf_bypass_spec_v1();
+	bool bypass_spec_v1 =3D bpf_bypass_spec_v1(NULL);
 	u64 array_size, mask64;
 	struct bpf_array *array;
=20
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 62e21ba90230..14ace23d517b 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -682,7 +682,7 @@ static bool bpf_prog_kallsyms_candidate(const struct =
bpf_prog *fp)
 void bpf_prog_kallsyms_add(struct bpf_prog *fp)
 {
 	if (!bpf_prog_kallsyms_candidate(fp) ||
-	    !bpf_capable())
+	    !bpf_token_capable(fp->aux->token, CAP_BPF))
 		return;
=20
 	bpf_prog_ksym_set_addr(fp);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d4e31f61de0e..edf93a1c2cee 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20732,7 +20732,12 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr, __u3
 	env->prog =3D *prog;
 	env->ops =3D bpf_verifier_ops[env->prog->type];
 	env->fd_array =3D make_bpfptr(attr->fd_array, uattr.is_kernel);
-	is_priv =3D bpf_capable();
+
+	env->allow_ptr_leaks =3D bpf_allow_ptr_leaks(env->prog->aux->token);
+	env->allow_uninit_stack =3D bpf_allow_uninit_stack(env->prog->aux->toke=
n);
+	env->bypass_spec_v1 =3D bpf_bypass_spec_v1(env->prog->aux->token);
+	env->bypass_spec_v4 =3D bpf_bypass_spec_v4(env->prog->aux->token);
+	env->bpf_capable =3D is_priv =3D bpf_token_capable(env->prog->aux->toke=
n, CAP_BPF);
=20
 	bpf_get_btf_vmlinux();
=20
@@ -20764,12 +20769,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr, __u3
 	if (attr->prog_flags & BPF_F_ANY_ALIGNMENT)
 		env->strict_alignment =3D false;
=20
-	env->allow_ptr_leaks =3D bpf_allow_ptr_leaks();
-	env->allow_uninit_stack =3D bpf_allow_uninit_stack();
-	env->bypass_spec_v1 =3D bpf_bypass_spec_v1();
-	env->bypass_spec_v4 =3D bpf_bypass_spec_v4();
-	env->bpf_capable =3D bpf_capable();
-
 	if (is_priv)
 		env->test_state_freq =3D attr->prog_flags & BPF_F_TEST_STATE_FREQ;
 	env->test_reg_invariants =3D attr->prog_flags & BPF_F_TEST_REG_INVARIAN=
TS;
diff --git a/net/core/filter.c b/net/core/filter.c
index 46ab1d9378dd..3cc52b82bab8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8580,7 +8580,7 @@ static bool cg_skb_is_valid_access(int off, int siz=
e,
 		return false;
 	case bpf_ctx_range(struct __sk_buff, data):
 	case bpf_ctx_range(struct __sk_buff, data_end):
-		if (!bpf_capable())
+		if (!bpf_token_capable(prog->aux->token, CAP_BPF))
 			return false;
 		break;
 	}
@@ -8592,7 +8592,7 @@ static bool cg_skb_is_valid_access(int off, int siz=
e,
 		case bpf_ctx_range_till(struct __sk_buff, cb[0], cb[4]):
 			break;
 		case bpf_ctx_range(struct __sk_buff, tstamp):
-			if (!bpf_capable())
+			if (!bpf_token_capable(prog->aux->token, CAP_BPF))
 				return false;
 			break;
 		default:
--=20
2.34.1


