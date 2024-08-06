Return-Path: <linux-fsdevel+bounces-25191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FD0949B50
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 00:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77AD8282877
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 22:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3811741C3;
	Tue,  6 Aug 2024 22:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJJ2xgZN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3298913C809;
	Tue,  6 Aug 2024 22:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722983554; cv=none; b=QOSqdBQR7uaenmQi1UoBMjgwnESNCXA9kBWZBQPWrWiIPZk5C5KIC5qVoT+VRIaYVuizICP/VELSaUybkgqYjXbFwfDsTEIWItL4LQo3RrNZXdRr4ynFXroxiMkyyKiYyN5KvuypBbQWsDnVvksqsCMPAFWX0Rc067dn8lq9FpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722983554; c=relaxed/simple;
	bh=leEYgUvoPvWJnLdNfwt5o7egZWNN2kQLjZpPsubAb6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ai8ysmAOD+MuBcGrNRx3RhiJv9WT++oAxdK+ab+CvE24KrHh/pYBXXpiWdvlfrLEGBzThjtS2CR+0Z7NsO+JvXOoCSrZxrFXdN0M+B3nmyfsBjXot7FUPnvl3oIIySa6eRadi+qtEJMH/CaVwIK+W+Ut4rYtkzdYfo6LXgV/PDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJJ2xgZN; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2cb4b7fef4aso881460a91.0;
        Tue, 06 Aug 2024 15:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722983552; x=1723588352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvxS0dtaG39iN3MDbCHCO5j0u4dk9U4/Rq1cmGTMqE4=;
        b=XJJ2xgZNaZnzxKDgLXym1FQk1VExQCTP2Ib0r6WFFP8iwFcQk3+9/mCNlzE087IOXY
         oeL9Q3wNE2rJul8T77Q6h/Lwj4q3lnJETSmDDBuKnNRHNolBp4UfK03cPw6QSIEaXaVq
         teiH4X0SM1zdkGRSc3/LBShGHmUb2G/sDJTPl5Kt40lvYZ81C+DbiEqm0PXyx140HllM
         1Re2ii1sqG6nr8JR0bM4Ukd+pyn2nD3JgNnzqhXkaGPnbkL2qlFOlLWZ/Tgm4NcutZD2
         SO2LH2BoLNFomXEbwVBqK4ZoGaBkRv6OujfABNDI7k4gn9kz4v7nQvv9zVkY8ozw9NFT
         w1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722983552; x=1723588352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvxS0dtaG39iN3MDbCHCO5j0u4dk9U4/Rq1cmGTMqE4=;
        b=vW+r8hrf0h95pCBTQVo3j2LzO6DhpklfPYzZvSM56hWyT7r0WQX70m4iS/x6RSTLV6
         6r/PY2x253E6jCPwD1o7rp3cGUVV1ZLaLtaqJ9qfSGjY4qQK+D9dC83u5HyeIDYY3bUs
         2yUIIQrgg9reBB5ErLkJsYPffe6V/5IhEx0MZ0HuhJBWnZS9PMQnn5+osz/iXQyw8D70
         FA/+8l9jz6CICUUqPUDuAaLOwh2+WvECBTYjPmIdjsq/BbLm1FmZFh85GpIri9dcGMW7
         3JwBXB/uYyuPSk0qXtq1PKFDi7WTC970NrUP4cHUQZgyQdomMdKxJVCxm5kpFEDO3YN8
         BhAA==
X-Forwarded-Encrypted: i=1; AJvYcCUYqI6/HABR0evgbKCkUPwH1Gyz3tHXYHp7LePjRQulrWzfbHIsXwhz5V1hoc0Bt0uvi96cgLC3JEp6nYVjfvJhK5EhdLRsT1P0NW22528bjMLQTJZu/FKJGlabRkBfKxrqwylNEqK6ja4flq7gihgp8vwiZvFiYqQIGDo58FbHWSCF+290BEy2AA==
X-Gm-Message-State: AOJu0YwFmlOpb7spsSyl13jwshAgRp553xKgV/xEsxZhTOHj35mc8uA5
	3nPXKaDxUnbv988WPDfVKJSv1KWX/NCxxW30fyXyDRiqZ+sqkEEQK11PY3H1Av0X5q0/W7Cj1k2
	Pf8idtZ8zHUKNB4EOKMUi0kcf6FkSJTHg
X-Google-Smtp-Source: AGHT+IEtlEPVqCq+xX4ug5f2DuXvupAmSeX/5y+TmwkIXkpruMTgXasxCkPgpCT7eJcqS5qs9i5wkJ05VWorf2T0nT0=
X-Received: by 2002:a17:90a:fe88:b0:2c9:7fba:d88b with SMTP id
 98e67ed59e1d1-2cff9419943mr19926118a91.14.1722983552377; Tue, 06 Aug 2024
 15:32:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730050927.GC5334@ZenIV> <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-17-viro@kernel.org>
In-Reply-To: <20240730051625.14349-17-viro@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 6 Aug 2024 15:32:20 -0700
Message-ID: <CAEf4BzZipqBVhoY-S+WdeQ8=MhpKk-2dE_ESfGpV-VTm31oQUQ@mail.gmail.com>
Subject: Re: [PATCH 17/39] bpf: resolve_pseudo_ldimm64(): take handling of a
 single ldimm64 insn into helper
To: viro@kernel.org, bpf@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, brauner@kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 10:20=E2=80=AFPM <viro@kernel.org> wrote:
>
> From: Al Viro <viro@zeniv.linux.org.uk>
>
> Equivalent transformation.  For one thing, it's easier to follow that way=
.
> For another, that simplifies the control flow in the vicinity of struct f=
d
> handling in there, which will allow a switch to CLASS(fd) and make the
> thing much easier to verify wrt leaks.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  kernel/bpf/verifier.c | 342 +++++++++++++++++++++---------------------
>  1 file changed, 172 insertions(+), 170 deletions(-)
>

This looks unnecessarily intrusive. I think it's best to extract the
logic of fetching and adding bpf_map by fd into a helper and that way
contain fdget + fdput logic nicely. Something like below, which I can
send to bpf-next.

commit b5eec08241cc0263e560551de91eda73ccc5987d
Author: Andrii Nakryiko <andrii@kernel.org>
Date:   Tue Aug 6 14:31:34 2024 -0700

    bpf: factor out fetching bpf_map from FD and adding it to used_maps lis=
t

    Factor out the logic to extract bpf_map instances from FD embedded in
    bpf_insns, adding it to the list of used_maps (unless it's already
    there, in which case we just reuse map's index). This simplifies the
    logic in resolve_pseudo_ldimm64(), especially around `struct fd`
    handling, as all that is now neatly contained in the helper and doesn't
    leak into a dozen error handling paths.

    Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index df3be12096cf..14e4ef687a59 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18865,6 +18865,58 @@ static bool bpf_map_is_cgroup_storage(struct
bpf_map *map)
         map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
 }

+/* Add map behind fd to used maps list, if it's not already there, and ret=
urn
+ * its index. Also set *reused to true if this map was already in the list=
 of
+ * used maps.
+ * Returns <0 on error, or >=3D 0 index, on success.
+ */
+static int add_used_map_from_fd(struct bpf_verifier_env *env, int fd,
bool *reused)
+{
+    struct fd f =3D fdget(fd);
+    struct bpf_map *map;
+    int i;
+
+    map =3D __bpf_map_get(f);
+    if (IS_ERR(map)) {
+        verbose(env, "fd %d is not pointing to valid bpf_map\n", fd);
+        return PTR_ERR(map);
+    }
+
+    /* check whether we recorded this map already */
+    for (i =3D 0; i < env->used_map_cnt; i++) {
+        if (env->used_maps[i] =3D=3D map) {
+            *reused =3D true;
+            fdput(f);
+            return i;
+        }
+    }
+
+    if (env->used_map_cnt >=3D MAX_USED_MAPS) {
+        verbose(env, "The total number of maps per program has
reached the limit of %u\n",
+            MAX_USED_MAPS);
+        fdput(f);
+        return -E2BIG;
+    }
+
+    if (env->prog->sleepable)
+        atomic64_inc(&map->sleepable_refcnt);
+
+    /* hold the map. If the program is rejected by verifier,
+     * the map will be released by release_maps() or it
+     * will be used by the valid program until it's unloaded
+     * and all maps are released in bpf_free_used_maps()
+     */
+    bpf_map_inc(map);
+
+    *reused =3D false;
+    env->used_maps[env->used_map_cnt++] =3D map;
+
+    fdput(f);
+
+    return env->used_map_cnt - 1;
+
+}
+
 /* find and rewrite pseudo imm in ld_imm64 instructions:
  *
  * 1. if it accesses map FD, replace it with actual map pointer.
@@ -18876,7 +18928,7 @@ static int resolve_pseudo_ldimm64(struct
bpf_verifier_env *env)
 {
     struct bpf_insn *insn =3D env->prog->insnsi;
     int insn_cnt =3D env->prog->len;
-    int i, j, err;
+    int i, err;

     err =3D bpf_prog_calc_tag(env->prog);
     if (err)
@@ -18893,9 +18945,10 @@ static int resolve_pseudo_ldimm64(struct
bpf_verifier_env *env)
         if (insn[0].code =3D=3D (BPF_LD | BPF_IMM | BPF_DW)) {
             struct bpf_insn_aux_data *aux;
             struct bpf_map *map;
-            struct fd f;
+            int map_idx;
             u64 addr;
             u32 fd;
+            bool reused;

             if (i =3D=3D insn_cnt - 1 || insn[1].code !=3D 0 ||
                 insn[1].dst_reg !=3D 0 || insn[1].src_reg !=3D 0 ||
@@ -18956,20 +19009,18 @@ static int resolve_pseudo_ldimm64(struct
bpf_verifier_env *env)
                 break;
             }

-            f =3D fdget(fd);
-            map =3D __bpf_map_get(f);
-            if (IS_ERR(map)) {
-                verbose(env, "fd %d is not pointing to valid bpf_map\n", f=
d);
-                return PTR_ERR(map);
-            }
+            map_idx =3D add_used_map_from_fd(env, fd, &reused);
+            if (map_idx < 0)
+                return map_idx;
+            map =3D env->used_maps[map_idx];
+
+            aux =3D &env->insn_aux_data[i];
+            aux->map_index =3D map_idx;

             err =3D check_map_prog_compatibility(env, map, env->prog);
-            if (err) {
-                fdput(f);
+            if (err)
                 return err;
-            }

-            aux =3D &env->insn_aux_data[i];
             if (insn[0].src_reg =3D=3D BPF_PSEUDO_MAP_FD ||
                 insn[0].src_reg =3D=3D BPF_PSEUDO_MAP_IDX) {
                 addr =3D (unsigned long)map;
@@ -18978,13 +19029,11 @@ static int resolve_pseudo_ldimm64(struct
bpf_verifier_env *env)

                 if (off >=3D BPF_MAX_VAR_OFF) {
                     verbose(env, "direct value offset of %u is not
allowed\n", off);
-                    fdput(f);
                     return -EINVAL;
                 }

                 if (!map->ops->map_direct_value_addr) {
                     verbose(env, "no direct value access support for
this map type\n");
-                    fdput(f);
                     return -EINVAL;
                 }

@@ -18992,7 +19041,6 @@ static int resolve_pseudo_ldimm64(struct
bpf_verifier_env *env)
                 if (err) {
                     verbose(env, "invalid access to map value
pointer, value_size=3D%u off=3D%u\n",
                         map->value_size, off);
-                    fdput(f);
                     return err;
                 }

@@ -19003,70 +19051,39 @@ static int resolve_pseudo_ldimm64(struct
bpf_verifier_env *env)
             insn[0].imm =3D (u32)addr;
             insn[1].imm =3D addr >> 32;

-            /* check whether we recorded this map already */
-            for (j =3D 0; j < env->used_map_cnt; j++) {
-                if (env->used_maps[j] =3D=3D map) {
-                    aux->map_index =3D j;
-                    fdput(f);
-                    goto next_insn;
-                }
-            }
-
-            if (env->used_map_cnt >=3D MAX_USED_MAPS) {
-                verbose(env, "The total number of maps per program
has reached the limit of %u\n",
-                    MAX_USED_MAPS);
-                fdput(f);
-                return -E2BIG;
-            }
-
-            if (env->prog->sleepable)
-                atomic64_inc(&map->sleepable_refcnt);
-            /* hold the map. If the program is rejected by verifier,
-             * the map will be released by release_maps() or it
-             * will be used by the valid program until it's unloaded
-             * and all maps are released in bpf_free_used_maps()
-             */
-            bpf_map_inc(map);
-
-            aux->map_index =3D env->used_map_cnt;
-            env->used_maps[env->used_map_cnt++] =3D map;
+            /* proceed with extra checks only if its newly added used map =
*/
+            if (reused)
+                goto next_insn;

             if (bpf_map_is_cgroup_storage(map) &&
                 bpf_cgroup_storage_assign(env->prog->aux, map)) {
                 verbose(env, "only one cgroup storage of each type is
allowed\n");
-                fdput(f);
                 return -EBUSY;
             }
             if (map->map_type =3D=3D BPF_MAP_TYPE_ARENA) {
                 if (env->prog->aux->arena) {
                     verbose(env, "Only one arena per program\n");
-                    fdput(f);
                     return -EBUSY;
                 }
                 if (!env->allow_ptr_leaks || !env->bpf_capable) {
                     verbose(env, "CAP_BPF and CAP_PERFMON are
required to use arena\n");
-                    fdput(f);
                     return -EPERM;
                 }
                 if (!env->prog->jit_requested) {
                     verbose(env, "JIT is required to use arena\n");
-                    fdput(f);
                     return -EOPNOTSUPP;
                 }
                 if (!bpf_jit_supports_arena()) {
                     verbose(env, "JIT doesn't support arena\n");
-                    fdput(f);
                     return -EOPNOTSUPP;
                 }
                 env->prog->aux->arena =3D (void *)map;
                 if (!bpf_arena_get_user_vm_start(env->prog->aux->arena)) {
                     verbose(env, "arena's user address must be set
via map_extra or mmap()\n");
-                    fdput(f);
                     return -EINVAL;
                 }
             }

-            fdput(f);
 next_insn:
             insn++;
             i++;



[...]

