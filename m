Return-Path: <linux-fsdevel+bounces-34621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 900169C6CB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 11:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9731F220AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 10:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FD4290F;
	Wed, 13 Nov 2024 10:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/yZkrUW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09C12AE90;
	Wed, 13 Nov 2024 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731493170; cv=none; b=ZPWVtRUdXaBjJxODlhUbEagQiTzg09tKhdZF7FeG6n8UaMcTiBeUUzL0Z61go4XjFEy9l0YIKrAaKqwa9OfzyILnSo0YnXeGHVguGRIDfbviiXk5nQxSZ3ka28tAV1YmJUra9rdU0rzjBpJZze7FN5AAoh4YkiZeqUvHA2ofSCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731493170; c=relaxed/simple;
	bh=pU6pB26ySh8saykSDK55Zekt0Hffao3oKz0ODlb9rwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PV4sQbXiQ0PUi+h6Ekng87MHXqWhUg5XVmxFpxVR0XbG8hNN308bA4W/mkI1IziCJlK/1A/2KmC7/775z0PBkqqDJNXrs1XUX/wkEjKdcIp3tv5AY3Qzt7G3qP44BJ1SKYpPE6rU5/SWKl/isws+0y/S+GeERC5H83jb0CzQQd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/yZkrUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35D8C4CECD;
	Wed, 13 Nov 2024 10:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731493169;
	bh=pU6pB26ySh8saykSDK55Zekt0Hffao3oKz0ODlb9rwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R/yZkrUWUvToi2+LtTxf2a/fPltRPGO+/ty4021M9ZAtKNdlaNa9Vp7vJJ9geLzZB
	 9m0/squq+pWy8pCIqOr9Uo06uoFUNAoAQbkCElGhB15bgTIDioSNMpx6+PSYYu3jbr
	 RDMJRZkHJRdBusYp6s8a7RNzU/Gb4gg/FjMEjzAonbSxNdSo+smBBtBN734t6tWvAD
	 hSEt0Po4oAQGGQJcMRWdOkvF+ab8rfz8yamb2matfsD78hV0tKPAKmJXQRQ8+Tu5ga
	 WCMLJiJa3zOlXtuzkcU48roxDhuSEEzp0cEBIAOHeeXNe57s0PritQVqFEw2S8g2ok
	 8/xZIBD5dysRg==
Date: Wed, 13 Nov 2024 11:19:20 +0100
From: Christian Brauner <brauner@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, viro@zeniv.linux.org.uk, jack@suse.cz, kpsingh@kernel.org, 
	mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com, jlayton@kernel.org, 
	josef@toxicpanda.com, mic@digikod.net, gnoack@google.com
Subject: Re: [PATCH bpf-next 2/4] bpf: Make bpf inode storage available to
 tracing program
Message-ID: <20241113-sensation-morgen-852f49484fd8@brauner>
References: <20241112082600.298035-1-song@kernel.org>
 <20241112082600.298035-3-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241112082600.298035-3-song@kernel.org>

On Tue, Nov 12, 2024 at 12:25:56AM -0800, Song Liu wrote:
> inode storage can be useful for non-LSM program. For example, file* tools
> from bcc/libbpf-tools can use inode storage instead of hash map; fanotify
> fastpath [1] can also use inode storage to store useful data.
> 
> Make inode storage available for tracing program. Move bpf inode storage
> from a security blob to inode->i_bpf_storage, and adjust related code
> accordingly.
> 
> [1] https://lore.kernel.org/linux-fsdevel/20241029231244.2834368-1-song@kernel.org/
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  fs/inode.c                     |  1 +
>  include/linux/bpf.h            |  9 +++++++++
>  include/linux/bpf_lsm.h        | 29 -----------------------------
>  include/linux/fs.h             |  4 ++++
>  kernel/bpf/Makefile            |  3 +--
>  kernel/bpf/bpf_inode_storage.c | 32 +++++---------------------------
>  kernel/bpf/bpf_lsm.c           |  4 ----
>  kernel/trace/bpf_trace.c       |  4 ++++
>  security/bpf/hooks.c           |  6 ------
>  9 files changed, 24 insertions(+), 68 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 8dabb224f941..3c679578169f 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -286,6 +286,7 @@ static struct inode *alloc_inode(struct super_block *sb)
>  void __destroy_inode(struct inode *inode)
>  {
>  	BUG_ON(inode_has_buffers(inode));
> +	bpf_inode_storage_free(inode);
>  	inode_detach_wb(inode);
>  	security_inode_free(inode);
>  	fsnotify_inode_delete(inode);
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 1b84613b10ac..0b31d2e74df6 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2672,6 +2672,7 @@ struct bpf_link *bpf_link_by_id(u32 id);
>  const struct bpf_func_proto *bpf_base_func_proto(enum bpf_func_id func_id,
>  						 const struct bpf_prog *prog);
>  void bpf_task_storage_free(struct task_struct *task);
> +void bpf_inode_storage_free(struct inode *inode);
>  void bpf_cgrp_storage_free(struct cgroup *cgroup);
>  bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
>  const struct btf_func_model *
> @@ -2942,6 +2943,10 @@ static inline void bpf_task_storage_free(struct task_struct *task)
>  {
>  }
>  
> +static inline void bpf_inode_storage_free(struct inode *inode)
> +{
> +}
> +
>  static inline bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
>  {
>  	return false;
> @@ -3305,6 +3310,10 @@ extern const struct bpf_func_proto bpf_task_storage_get_recur_proto;
>  extern const struct bpf_func_proto bpf_task_storage_get_proto;
>  extern const struct bpf_func_proto bpf_task_storage_delete_recur_proto;
>  extern const struct bpf_func_proto bpf_task_storage_delete_proto;
> +extern const struct bpf_func_proto bpf_inode_storage_get_proto;
> +extern const struct bpf_func_proto bpf_inode_storage_get_recur_proto;
> +extern const struct bpf_func_proto bpf_inode_storage_delete_proto;
> +extern const struct bpf_func_proto bpf_inode_storage_delete_recur_proto;
>  extern const struct bpf_func_proto bpf_for_each_map_elem_proto;
>  extern const struct bpf_func_proto bpf_btf_find_by_name_kind_proto;
>  extern const struct bpf_func_proto bpf_sk_setsockopt_proto;
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> index aefcd6564251..a819c2f0a062 100644
> --- a/include/linux/bpf_lsm.h
> +++ b/include/linux/bpf_lsm.h
> @@ -19,31 +19,12 @@
>  #include <linux/lsm_hook_defs.h>
>  #undef LSM_HOOK
>  
> -struct bpf_storage_blob {
> -	struct bpf_local_storage __rcu *storage;
> -};
> -
> -extern struct lsm_blob_sizes bpf_lsm_blob_sizes;
> -
>  int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
>  			const struct bpf_prog *prog);
>  
>  bool bpf_lsm_is_sleepable_hook(u32 btf_id);
>  bool bpf_lsm_is_trusted(const struct bpf_prog *prog);
>  
> -static inline struct bpf_storage_blob *bpf_inode(
> -	const struct inode *inode)
> -{
> -	if (unlikely(!inode->i_security))
> -		return NULL;
> -
> -	return inode->i_security + bpf_lsm_blob_sizes.lbs_inode;
> -}
> -
> -extern const struct bpf_func_proto bpf_inode_storage_get_proto;
> -extern const struct bpf_func_proto bpf_inode_storage_delete_proto;
> -void bpf_inode_storage_free(struct inode *inode);
> -
>  void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog, bpf_func_t *bpf_func);
>  
>  int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
> @@ -66,16 +47,6 @@ static inline int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
>  	return -EOPNOTSUPP;
>  }
>  
> -static inline struct bpf_storage_blob *bpf_inode(
> -	const struct inode *inode)
> -{
> -	return NULL;
> -}
> -
> -static inline void bpf_inode_storage_free(struct inode *inode)
> -{
> -}
> -
>  static inline void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
>  					   bpf_func_t *bpf_func)
>  {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3559446279c1..479097e4dd5b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -79,6 +79,7 @@ struct fs_context;
>  struct fs_parameter_spec;
>  struct fileattr;
>  struct iomap_ops;
> +struct bpf_local_storage;
>  
>  extern void __init inode_init(void);
>  extern void __init inode_init_early(void);
> @@ -648,6 +649,9 @@ struct inode {
>  #ifdef CONFIG_SECURITY
>  	void			*i_security;
>  #endif
> +#ifdef CONFIG_BPF_SYSCALL
> +	struct bpf_local_storage __rcu *i_bpf_storage;
> +#endif

Sorry, we're not growing struct inode for this. It just keeps getting
bigger. Last cycle we freed up 8 bytes to shrink it and we're not going
to waste them on special-purpose stuff. We already NAKed someone else's
pet field here.

