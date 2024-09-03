Return-Path: <linux-fsdevel+bounces-28353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6591B969BE8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 13:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21BD3284398
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 11:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1171A42B3;
	Tue,  3 Sep 2024 11:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5WWNVDR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4414E15382F
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 11:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363277; cv=none; b=rD4Ry1vmHfUPm9f/l4/Vq7zzOnhTeG35IdqpFvwolY3eAPteU4vybxJeg9aYASDqbVK72oGvmOJ4FiK2VoHPcIE9xS6H/qk35hh6UEZnfcoRnyao8ZRo5+SDEUw5KvM+pfOGMU/lX6tRsR9QAn17vqciheJFkvXt0yUFWSAknf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363277; c=relaxed/simple;
	bh=f3uI6M9uJSXblxpkBjYvuYOcclvPWGSUQy67+ZAektI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tieVMN2tgc5IfKJhVx5mzkL3WKMDes8SUcekTXU8eSdFS+XT15k3B7T1PpiqZ+VxOZrh/nGAKe59BbD2S/b2+snj3CylAj5pToW8CFXMV0go9ujxp8mhbVXzQ+kJDz+RKIHri1+iRphHMia/o6dQquwhHiukXHSN6r9EYYzv/zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5WWNVDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9D6C4CEC4;
	Tue,  3 Sep 2024 11:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725363275;
	bh=f3uI6M9uJSXblxpkBjYvuYOcclvPWGSUQy67+ZAektI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p5WWNVDRgrO0BVI9/pGlasAIz6C1GyouzcYnbEO2i9ahHy/fwDEJd+eBbWdoHBbow
	 RA1gQ3oSKapMSaaFr/wgnKhrV8mfsOzVY53qmDkAd0JfV529b3PMufhfMaD6qhjdRO
	 VI1+NAd635gXQ/BvMecI449+4QiKAhMpvkqeW5wGWvETHEa9U5I27CnBuBTI/VSwGl
	 rHNsU6aH8YBifECauJdSA9CR7xJgVig5WYUS+JJy8hRXBz2Wp5PF3agRzBCV0lg2BI
	 4HWPBiCr40SU4p7TqFxcamuG+hnsjIiZqKG8eYok26VUpG42cem1z/ktK12AHDTFqI
	 OvmfDBzE3EAwQ==
Date: Tue, 3 Sep 2024 13:34:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 14/20] proc: store cookie in private data
Message-ID: <20240903-zierpflanzen-rohkost-aabf97c6a049@brauner>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-14-6d3e4816aa7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240830-vfs-file-f_version-v1-14-6d3e4816aa7b@kernel.org>

On Fri, Aug 30, 2024 at 03:04:55PM GMT, Christian Brauner wrote:
> Store the cookie to detect concurrent seeks on directories in
> file->private_data.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/proc/base.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 72a1acd03675..8a8aab6b9801 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -3870,12 +3870,12 @@ static int proc_task_readdir(struct file *file, struct dir_context *ctx)
>  	if (!dir_emit_dots(file, ctx))
>  		return 0;
>  
> -	/* f_version caches the tgid value that the last readdir call couldn't
> -	 * return. lseek aka telldir automagically resets f_version to 0.
> +	/* We cache the tgid value that the last readdir call couldn't
> +	 * return and lseek resets it to 0.
>  	 */
>  	ns = proc_pid_ns(inode->i_sb);
> -	tid = (int)file->f_version;
> -	file->f_version = 0;
> +	tid = (int)(intptr_t)file->private_data;
> +	file->private_data = NULL;
>  	for (task = first_tid(proc_pid(inode), tid, ctx->pos - 2, ns);
>  	     task;
>  	     task = next_tid(task), ctx->pos++) {
> @@ -3890,7 +3890,7 @@ static int proc_task_readdir(struct file *file, struct dir_context *ctx)
>  				proc_task_instantiate, task, NULL)) {
>  			/* returning this tgid failed, save it as the first
>  			 * pid for the next readir call */
> -			file->f_version = (u64)tid;
> +			file->private_data = (void *)(intptr_t)tid;
>  			put_task_struct(task);
>  			break;
>  		}
> @@ -3915,6 +3915,12 @@ static int proc_task_getattr(struct mnt_idmap *idmap,
>  	return 0;
>  }
>  
> +static loff_t proc_dir_llseek(struct file *file, loff_t offset, int whence)
> +{
> +	return generic_llseek_cookie(file, offset, whence,
> +				     (u64 *)(uintptr_t)&file->private_data);

Btw, this is fixed in-tree (I did send out an unfixed version):

static loff_t proc_dir_llseek(struct file *file, loff_t offset, int whence)
{
	u64 cookie = 1;
	loff_t off;

	off = generic_llseek_cookie(file, offset, whence, &cookie);
	if (!cookie)
		file->private_data = NULL; /* serialized by f_pos_lock */
	return off;
}

