Return-Path: <linux-fsdevel+bounces-26009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBB29524DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 23:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DFE21F22856
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 21:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908881C822D;
	Wed, 14 Aug 2024 21:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDd/iiy3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011E31B0125;
	Wed, 14 Aug 2024 21:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723671562; cv=none; b=EtB2SVeKitgsJhald8tGuBBqW62CXP3mUa1RqEzQAv7vcHsmkydUOunS4836N6J4Of7v1A+2QKRIH1aVIaASY/KN3zRZwJhWHIRSyDa4rHpXRH1tqOSSJoxwhjDeItNVfo4Qr+G/c8CNR0FSkPFIZLLBazT6CY4MD7n1JLP9nUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723671562; c=relaxed/simple;
	bh=dA6/RIbNfVoxAv2rCnpJowe5R4vgP+9+noX60k78waQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUi8KeTekxUh7oRBmsxIhB1ZpbnZjNWcq4rz+JFtwWTjp1X/xUoQQCKWi9KWe4oFqx0VV5JmnaSUYCdIriSK9aT+YM8zqY4aa+rkiS00DIm+d/YPN+KRnv0FXDv1cXdMPHUOMZj0j3Sw2eXjfMgqACpA1aOs4v2N6U/tcbAwLLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDd/iiy3; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7a8caef11fso53479766b.0;
        Wed, 14 Aug 2024 14:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723671558; x=1724276358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2SDFpbnECADPFyvkgdNqXcebn6JuMp/xNwa+MVKPDR4=;
        b=hDd/iiy3TgvdyD6cHuvWhCP/w4VSVNYjvJKc1AydN8h/3275mkuvSqD0G4+F3ix7JI
         iTst63hZg8LJQwc4bmA0IGijmXZQk6MfxIEEsSw+FNpkx+Xb+SMUN7ZU1CYRhRfe1gCp
         ErfOf+v0uvnzFn6eg+VE5ErumUXl7CfSw7ostx9qI4krT5m4BFu3+/o1jeWIrmnsaIx2
         Ayjbe1C4iVGa9HMT0KtapFMNr8EY9/e1I8MiGQUeS/awtITs634NsVI2azcdD6qK9x9D
         gwQ2vf218YAYh+BMmU27ua98MezVPXVEkZY74CYktKQ2m/w4TM2VxfpmPYIeTFAWEy/a
         MJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723671558; x=1724276358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SDFpbnECADPFyvkgdNqXcebn6JuMp/xNwa+MVKPDR4=;
        b=WkNh+gXlp8GpZM3xK/T78qLT9MxZoG5DcyA5qLRFpAHtapIY3si4nVKyVTt6burY6X
         Zf4eWsd3v6MzmEc07Diz6KQHJOthCFTbSW4V5YW+0PBfAdWCWzq0e4NS/UW6wuUW6K4m
         /g7HZ/bPuJWJVHNQxoeJHmMOskQ7AN5BS9WRwIZB92tepFZ27sTupXril/2e/IM0qE8Z
         zVzEnhnjzgQqfeDAMBiYCKv4yPxbtwhHNvHGovPDawsp/mdBgl5cMVGJ7+C5ShE9b5tv
         qCzrkIvE8n6z5hOJuSDkcITuKPWlkXPr9f/gT5AUdAgKaQxgQGZRNjCH4/ASt3IW1/VN
         cqtw==
X-Forwarded-Encrypted: i=1; AJvYcCWPMa6TD5G1iTA1X59YtJgQXotMOrTRgDXjHnpUZZNIXAhM1wc2b50DOX+JI8MDsmkRWIdxUXXROk7ceGKjr7WwFU8cFpJldoldNSVPeQ==
X-Gm-Message-State: AOJu0YxwqJ2dO2fz2J0Pyo57Dp2GE0T3SNBR19jshtSP/PjfPL2lv7eZ
	dIbzvGgH4EIGd+eUXzPYXVk/qtgy4VdwAsbzafW4Yocplh+a9NOvfNiaZg==
X-Google-Smtp-Source: AGHT+IEHs0oluRQ/Y7PW1OS3tKHXhJfiyXwwYPm1d2IknWkeX+VL2fp/9H7v++DRgimdZPR9WTyIlA==
X-Received: by 2002:a17:907:f146:b0:a7a:a960:99ee with SMTP id a640c23a62f3a-a8366d49011mr310377166b.32.1723671558020;
        Wed, 14 Aug 2024 14:39:18 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383947245sm4141966b.179.2024.08.14.14.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 14:39:17 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 14 Aug 2024 23:39:10 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, viro@kernel.org,
	linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	torvalds@linux-foundation.org
Subject: Re: [PATCH bpf-next 3/8] bpf: factor out fetching bpf_map from FD
 and adding it to used_maps list
Message-ID: <Zr0j_mYCtM-P-vlK@krava>
References: <20240813230300.915127-1-andrii@kernel.org>
 <20240813230300.915127-4-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813230300.915127-4-andrii@kernel.org>

On Tue, Aug 13, 2024 at 04:02:55PM -0700, Andrii Nakryiko wrote:
> Factor out the logic to extract bpf_map instances from FD embedded in
> bpf_insns, adding it to the list of used_maps (unless it's already
> there, in which case we just reuse map's index). This simplifies the
> logic in resolve_pseudo_ldimm64(), especially around `struct fd`
> handling, as all that is now neatly contained in the helper and doesn't
> leak into a dozen error handling paths.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/verifier.c | 115 ++++++++++++++++++++++++------------------
>  1 file changed, 66 insertions(+), 49 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index df3be12096cf..14e4ef687a59 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18865,6 +18865,58 @@ static bool bpf_map_is_cgroup_storage(struct bpf_map *map)
>  		map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
>  }
>  
> +/* Add map behind fd to used maps list, if it's not already there, and return
> + * its index. Also set *reused to true if this map was already in the list of
> + * used maps.
> + * Returns <0 on error, or >= 0 index, on success.
> + */
> +static int add_used_map_from_fd(struct bpf_verifier_env *env, int fd, bool *reused)
> +{
> +	struct fd f = fdget(fd);

using 'CLASS(fd, f)(fd)' would remove few fdput lines below?

jirka

> +	struct bpf_map *map;
> +	int i;
> +
> +	map = __bpf_map_get(f);
> +	if (IS_ERR(map)) {
> +		verbose(env, "fd %d is not pointing to valid bpf_map\n", fd);
> +		return PTR_ERR(map);
> +	}
> +
> +	/* check whether we recorded this map already */
> +	for (i = 0; i < env->used_map_cnt; i++) {
> +		if (env->used_maps[i] == map) {
> +			*reused = true;
> +			fdput(f);
> +			return i;
> +		}
> +	}
> +
> +	if (env->used_map_cnt >= MAX_USED_MAPS) {
> +		verbose(env, "The total number of maps per program has reached the limit of %u\n",
> +			MAX_USED_MAPS);
> +		fdput(f);
> +		return -E2BIG;
> +	}
> +
> +	if (env->prog->sleepable)
> +		atomic64_inc(&map->sleepable_refcnt);
> +
> +	/* hold the map. If the program is rejected by verifier,
> +	 * the map will be released by release_maps() or it
> +	 * will be used by the valid program until it's unloaded
> +	 * and all maps are released in bpf_free_used_maps()
> +	 */
> +	bpf_map_inc(map);
> +
> +	*reused = false;
> +	env->used_maps[env->used_map_cnt++] = map;
> +
> +	fdput(f);
> +
> +	return env->used_map_cnt - 1;
> +
> +}
> +
>  /* find and rewrite pseudo imm in ld_imm64 instructions:
>   *
>   * 1. if it accesses map FD, replace it with actual map pointer.
> @@ -18876,7 +18928,7 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
>  {
>  	struct bpf_insn *insn = env->prog->insnsi;
>  	int insn_cnt = env->prog->len;
> -	int i, j, err;
> +	int i, err;
>  
>  	err = bpf_prog_calc_tag(env->prog);
>  	if (err)
> @@ -18893,9 +18945,10 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
>  		if (insn[0].code == (BPF_LD | BPF_IMM | BPF_DW)) {
>  			struct bpf_insn_aux_data *aux;
>  			struct bpf_map *map;
> -			struct fd f;
> +			int map_idx;
>  			u64 addr;
>  			u32 fd;
> +			bool reused;
>  
>  			if (i == insn_cnt - 1 || insn[1].code != 0 ||
>  			    insn[1].dst_reg != 0 || insn[1].src_reg != 0 ||
> @@ -18956,20 +19009,18 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
>  				break;
>  			}
>  
> -			f = fdget(fd);
> -			map = __bpf_map_get(f);
> -			if (IS_ERR(map)) {
> -				verbose(env, "fd %d is not pointing to valid bpf_map\n", fd);
> -				return PTR_ERR(map);
> -			}
> +			map_idx = add_used_map_from_fd(env, fd, &reused);
> +			if (map_idx < 0)
> +				return map_idx;
> +			map = env->used_maps[map_idx];
> +
> +			aux = &env->insn_aux_data[i];
> +			aux->map_index = map_idx;
>  
>  			err = check_map_prog_compatibility(env, map, env->prog);
> -			if (err) {
> -				fdput(f);
> +			if (err)
>  				return err;
> -			}
>  
> -			aux = &env->insn_aux_data[i];
>  			if (insn[0].src_reg == BPF_PSEUDO_MAP_FD ||
>  			    insn[0].src_reg == BPF_PSEUDO_MAP_IDX) {
>  				addr = (unsigned long)map;
> @@ -18978,13 +19029,11 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
>  
>  				if (off >= BPF_MAX_VAR_OFF) {
>  					verbose(env, "direct value offset of %u is not allowed\n", off);
> -					fdput(f);
>  					return -EINVAL;
>  				}
>  
>  				if (!map->ops->map_direct_value_addr) {
>  					verbose(env, "no direct value access support for this map type\n");
> -					fdput(f);
>  					return -EINVAL;
>  				}
>  
> @@ -18992,7 +19041,6 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
>  				if (err) {
>  					verbose(env, "invalid access to map value pointer, value_size=%u off=%u\n",
>  						map->value_size, off);
> -					fdput(f);
>  					return err;
>  				}
>  
> @@ -19003,70 +19051,39 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
>  			insn[0].imm = (u32)addr;
>  			insn[1].imm = addr >> 32;
>  
> -			/* check whether we recorded this map already */
> -			for (j = 0; j < env->used_map_cnt; j++) {
> -				if (env->used_maps[j] == map) {
> -					aux->map_index = j;
> -					fdput(f);
> -					goto next_insn;
> -				}
> -			}
> -
> -			if (env->used_map_cnt >= MAX_USED_MAPS) {
> -				verbose(env, "The total number of maps per program has reached the limit of %u\n",
> -					MAX_USED_MAPS);
> -				fdput(f);
> -				return -E2BIG;
> -			}
> -
> -			if (env->prog->sleepable)
> -				atomic64_inc(&map->sleepable_refcnt);
> -			/* hold the map. If the program is rejected by verifier,
> -			 * the map will be released by release_maps() or it
> -			 * will be used by the valid program until it's unloaded
> -			 * and all maps are released in bpf_free_used_maps()
> -			 */
> -			bpf_map_inc(map);
> -
> -			aux->map_index = env->used_map_cnt;
> -			env->used_maps[env->used_map_cnt++] = map;
> +			/* proceed with extra checks only if its newly added used map */
> +			if (reused)
> +				goto next_insn;
>  
>  			if (bpf_map_is_cgroup_storage(map) &&
>  			    bpf_cgroup_storage_assign(env->prog->aux, map)) {
>  				verbose(env, "only one cgroup storage of each type is allowed\n");
> -				fdput(f);
>  				return -EBUSY;
>  			}
>  			if (map->map_type == BPF_MAP_TYPE_ARENA) {
>  				if (env->prog->aux->arena) {
>  					verbose(env, "Only one arena per program\n");
> -					fdput(f);
>  					return -EBUSY;
>  				}
>  				if (!env->allow_ptr_leaks || !env->bpf_capable) {
>  					verbose(env, "CAP_BPF and CAP_PERFMON are required to use arena\n");
> -					fdput(f);
>  					return -EPERM;
>  				}
>  				if (!env->prog->jit_requested) {
>  					verbose(env, "JIT is required to use arena\n");
> -					fdput(f);
>  					return -EOPNOTSUPP;
>  				}
>  				if (!bpf_jit_supports_arena()) {
>  					verbose(env, "JIT doesn't support arena\n");
> -					fdput(f);
>  					return -EOPNOTSUPP;
>  				}
>  				env->prog->aux->arena = (void *)map;
>  				if (!bpf_arena_get_user_vm_start(env->prog->aux->arena)) {
>  					verbose(env, "arena's user address must be set via map_extra or mmap()\n");
> -					fdput(f);
>  					return -EINVAL;
>  				}
>  			}
>  
> -			fdput(f);
>  next_insn:
>  			insn++;
>  			i++;
> -- 
> 2.43.5
> 
> 

