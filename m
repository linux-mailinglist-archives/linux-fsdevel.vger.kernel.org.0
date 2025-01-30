Return-Path: <linux-fsdevel+bounces-40400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB79A23106
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 16:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F9D1888FFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 15:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1191E9B3F;
	Thu, 30 Jan 2025 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toOCjX0p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8613E499;
	Thu, 30 Jan 2025 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738251138; cv=none; b=QU90aqAAjpOhGtqOC/eKLbJrECO3wrnjLB/qyIDhTe7WWYLboGZpag0wfbetf7NLWGzKMod9re/j9mg3aFK8B65Omf/x5u+/T1t3lVkfjh9DKMPn1YSHMZa1rTPgn8845g0x/sTEGDcyeYYTdjQaxKYHm3ahv9uTnvJF7gh5lp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738251138; c=relaxed/simple;
	bh=zEl4qnOpi+U24VlyUxMcMK6bSBm/AbufVlVyWaK6Fx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwIFB8mcJpoFW8/5N4MaBPipR56IhlrG1J1Mohn8Ft048MO0F6OeddU0CKoFSQC4NebzfwRCeaRTDZlO6S8QHaS/EboXGprGu9l4vId84xZCGADKM7ddWmyN5Mm8NsdTR23Vh8QthYdDCQOleYfAooKR36QL6buReyflszprmZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toOCjX0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25A4C4CED2;
	Thu, 30 Jan 2025 15:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738251137;
	bh=zEl4qnOpi+U24VlyUxMcMK6bSBm/AbufVlVyWaK6Fx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=toOCjX0pdb0EGhs4UOV9QWhikIu7/gXt8HGMRNsjr8duUGRMKVkkdl+eiv0jxJyJQ
	 cMnq4lrD3/Ymd071DI0verf9xK5Nib3uAhP3yM2fxlkf9YExbI+kHzWTFisPUsgcMz
	 s1H/3qdRuYZRqnG4zZNnaZ0GFessbr3qeL3lIZHe/q7/ePENEI8WOYV4sLPeK7ip4J
	 x2VOKNtaIgwmp13DZHRBoGtv4M3Ic936I9SnCDh7h5bncn5e02nTotq8vcMzk/xVxD
	 1sTmcCyt+S3HBVyTKVdaAoB136gCfALanXzER+4BD13gKZd8LgJuE0GsmhCoYCUvD1
	 UOEGatBDdFc6g==
Date: Thu, 30 Jan 2025 16:32:11 +0100
From: Christian Brauner <brauner@kernel.org>
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH bpf-next v9 4/5] bpf: Make fs kfuncs available for
 SYSCALL program type
Message-ID: <20250130-dauer-stich-21e0f1f09568@brauner>
References: <AM6PR03MB50801990BD93BFA2297A123599EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB50809BB6156BF239C4AC28C799EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM6PR03MB50809BB6156BF239C4AC28C799EC2@AM6PR03MB5080.eurprd03.prod.outlook.com>

On Mon, Jan 27, 2025 at 11:46:53PM +0000, Juntong Deng wrote:
> Currently fs kfuncs are only available for LSM program type, but fs
> kfuncs are general and useful for scenarios other than LSM.
> 
> This patch makes fs kfuncs available for SYSCALL program type.
> 
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---

I still have a hard time understanding what syscall program types do and
why we should want to allow the usage of all current fs functions that
were added for LSMs specifically to such program types. I can't say
anything about this until I have a rough understanding what a syscall
bpf program allows you to do and what it's used for. Preferably some
example.

>  fs/bpf_fs_kfuncs.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 4a810046dcf3..8a7e9ed371de 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -26,8 +26,6 @@ __bpf_kfunc_start_defs();
>   * acquired by this BPF kfunc will result in the BPF program being rejected by
>   * the BPF verifier.
>   *
> - * This BPF kfunc may only be called from BPF LSM programs.
> - *
>   * Internally, this BPF kfunc leans on get_task_exe_file(), such that calling
>   * bpf_get_task_exe_file() would be analogous to calling get_task_exe_file()
>   * directly in kernel context.
> @@ -49,8 +47,6 @@ __bpf_kfunc struct file *bpf_get_task_exe_file(struct task_struct *task)
>   * passed to this BPF kfunc. Attempting to pass an unreferenced file pointer, or
>   * any other arbitrary pointer for that matter, will result in the BPF program
>   * being rejected by the BPF verifier.
> - *
> - * This BPF kfunc may only be called from BPF LSM programs.
>   */
>  __bpf_kfunc void bpf_put_file(struct file *file)
>  {
> @@ -70,8 +66,6 @@ __bpf_kfunc void bpf_put_file(struct file *file)
>   * reference, or else the BPF program will be outright rejected by the BPF
>   * verifier.
>   *
> - * This BPF kfunc may only be called from BPF LSM programs.
> - *
>   * Return: A positive integer corresponding to the length of the resolved
>   * pathname in *buf*, including the NUL termination character. On error, a
>   * negative integer is returned.
> @@ -184,7 +178,8 @@ BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
>  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
>  {
>  	if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
> -	    prog->type == BPF_PROG_TYPE_LSM)
> +	    prog->type == BPF_PROG_TYPE_LSM ||
> +	    prog->type == BPF_PROG_TYPE_SYSCALL)
>  		return 0;
>  	return -EACCES;
>  }
> @@ -197,7 +192,10 @@ static const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
>  
>  static int __init bpf_fs_kfuncs_init(void)
>  {
> -	return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
> +	int ret;
> +
> +	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
> +	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_fs_kfunc_set);
>  }
>  
>  late_initcall(bpf_fs_kfuncs_init);
> -- 
> 2.39.5
> 

