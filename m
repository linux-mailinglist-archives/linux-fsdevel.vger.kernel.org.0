Return-Path: <linux-fsdevel+bounces-3660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 028937F6EB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 09:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349211C20E8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 08:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AAA4685;
	Fri, 24 Nov 2023 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7ETAzkL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745CB3D67;
	Fri, 24 Nov 2023 08:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9ECC433C8;
	Fri, 24 Nov 2023 08:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700815482;
	bh=s+Ab82UKYxmKk5JidzINa6y6S+4Ktv+WPgG2GtKZMyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d7ETAzkLMzDtSnkGvNCEHKeuOeMM742zmlQA7VJ4x8rKw7+fUV2yhB3FuhConM/dW
	 4d21k5G//Dmy/UT5gZjPLfeOCi53E7Y9PhBz7/P5Cr+v+0kSEPe1UMSlIHsPllwfUL
	 m/WBcZE/wEKq4AEXOeq/fgtEBovpUcJoNxodiRh51vdxpoHGuw1yN27g1xqRtAAkCg
	 /sLCMsRxOp87S4uQp6NYYECrw+Uhu2jDauA96rQ74Pve+TWPnzy5RvW1tC5f4rtrow
	 af++iinkj+G5nBsO3TDVuuY2mwcf3PQaeUTFDWWu4054QPqC9vDNaLhqOnFNpNTI7T
	 2uTBk8eY4E2xg==
Date: Fri, 24 Nov 2023 09:44:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
	ebiggers@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, viro@zeniv.linux.org.uk,
	casey@schaufler-ca.com, amir73il@gmail.com, kpsingh@kernel.org,
	roberto.sassu@huawei.com
Subject: Re: [PATCH v13 bpf-next 1/6] bpf: Add kfunc bpf_get_file_xattr
Message-ID: <20231124-heilung-wohnumfeld-6b7797c4d41a@brauner>
References: <20231123233936.3079687-1-song@kernel.org>
 <20231123233936.3079687-2-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231123233936.3079687-2-song@kernel.org>

On Thu, Nov 23, 2023 at 03:39:31PM -0800, Song Liu wrote:
> It is common practice for security solutions to store tags/labels in
> xattrs. To implement similar functionalities in BPF LSM, add new kfunc
> bpf_get_file_xattr().
> 
> The first use case of bpf_get_file_xattr() is to implement file
> verifications with asymmetric keys. Specificially, security applications
> could use fsverity for file hashes and use xattr to store file signatures.
> (kfunc for fsverity hash will be added in a separate commit.)
> 
> Currently, only xattrs with "user." prefix can be read with kfunc
> bpf_get_file_xattr(). As use cases evolve, we may add a dedicated prefix
> for bpf_get_file_xattr().
> 
> To avoid recursion, bpf_get_file_xattr can be only called from LSM hooks.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---

Looks ok to me. But see below for a question.

If you ever allow the retrieval of additional extended attributes
through bfs_get_file_xattr() or other bpf interfaces we would like to be
Cced, please. The xattr stuff is (/me looks for suitable words)...

Over the last months we've moved POSIX_ACL retrieval out of these
low-level functions. They now have a dedicated api. The same is going to
happen for fscaps as well.

But even with these out of the way we would want the bpf helpers to
always maintain an allowlist of retrievable attributes.

>  kernel/trace/bpf_trace.c | 63 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index f0b8b7c29126..55758a6fbe90 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -24,6 +24,7 @@
>  #include <linux/key.h>
>  #include <linux/verification.h>
>  #include <linux/namei.h>
> +#include <linux/fileattr.h>
>  
>  #include <net/bpf_sk_storage.h>
>  
> @@ -1431,6 +1432,68 @@ static int __init bpf_key_sig_kfuncs_init(void)
>  late_initcall(bpf_key_sig_kfuncs_init);
>  #endif /* CONFIG_KEYS */
>  
> +/* filesystem kfuncs */
> +__bpf_kfunc_start_defs();
> +
> +/**
> + * bpf_get_file_xattr - get xattr of a file
> + * @file: file to get xattr from
> + * @name__str: name of the xattr
> + * @value_ptr: output buffer of the xattr value
> + *
> + * Get xattr *name__str* of *file* and store the output in *value_ptr*.
> + *
> + * For security reasons, only *name__str* with prefix "user." is allowed.
> + *
> + * Return: 0 on success, a negative value on error.
> + */
> +__bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
> +				   struct bpf_dynptr_kern *value_ptr)
> +{
> +	struct dentry *dentry;
> +	u32 value_len;
> +	void *value;
> +
> +	if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
> +		return -EPERM;
> +
> +	value_len = __bpf_dynptr_size(value_ptr);
> +	value = __bpf_dynptr_data_rw(value_ptr, value_len);
> +	if (!value)
> +		return -EINVAL;
> +
> +	dentry = file_dentry(file);
> +	return __vfs_getxattr(dentry, dentry->d_inode, name__str, value, value_len);

By calling __vfs_getxattr() from bpf_get_file_xattr() you're skipping at
least inode_permission() from xattr_permission(). I'm probably just
missing or forgot the context. But why is that ok?

> +}
> +
> +__bpf_kfunc_end_defs();
> +
> +BTF_SET8_START(fs_kfunc_set_ids)
> +BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
> +BTF_SET8_END(fs_kfunc_set_ids)
> +
> +static int bpf_get_file_xattr_filter(const struct bpf_prog *prog, u32 kfunc_id)
> +{
> +	if (!btf_id_set8_contains(&fs_kfunc_set_ids, kfunc_id))
> +		return 0;
> +
> +	/* Only allow to attach from LSM hooks, to avoid recursion */
> +	return prog->type != BPF_PROG_TYPE_LSM ? -EACCES : 0;
> +}
> +
> +const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
> +	.owner = THIS_MODULE,
> +	.set = &fs_kfunc_set_ids,
> +	.filter = bpf_get_file_xattr_filter,
> +};
> +
> +static int __init bpf_fs_kfuncs_init(void)
> +{
> +	return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
> +}
> +
> +late_initcall(bpf_fs_kfuncs_init);
> +
>  static const struct bpf_func_proto *
>  bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  {
> -- 
> 2.34.1
> 

