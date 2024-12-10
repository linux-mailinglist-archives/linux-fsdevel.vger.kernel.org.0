Return-Path: <linux-fsdevel+bounces-36946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD4E9EB345
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 15:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E99161EE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 14:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9301B0F3C;
	Tue, 10 Dec 2024 14:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NS/BKt2z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0521AC450;
	Tue, 10 Dec 2024 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840934; cv=none; b=frf/JwLOLmNFhmRkuhvMzMrS5Zu3R0UZEH2vSkf24Ki32JYIafnWr/Diq84mQvL76sowHhEPHvUPa44yhtqkx6WB8QoCEw1v1avsr04Xn9N+WbjRC/ZVpnQgS2mHFZQHSV1DFZtUhQQvekMq3fCcoTQ5AbfjQh8bIpYTM9J42FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840934; c=relaxed/simple;
	bh=DWw+OzWlI6/cQMJTTEn2TJpQIXKtWjVxENKvKMYJO3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nes6Bzmr169vo31g2vYaFtm2p1X+5MqS6j1OvD/Op6IkDoqgpBC/tdWk7V5olMewIFSK2hZzN5iLLWF2bs8cZTDKEr+24/ICkkLg+/4iHN4r/9Ok58wUkB1MR/BIVgnh/CWuk28CS3NO2yRV7+7oIkHZoYjnlA0i87gLyK4Yn5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NS/BKt2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B7FC4CEDE;
	Tue, 10 Dec 2024 14:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733840933;
	bh=DWw+OzWlI6/cQMJTTEn2TJpQIXKtWjVxENKvKMYJO3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NS/BKt2z0DwgNBbYwpyNnXmyHwVVmU8+1f13iFzBxYW6gJ7qcm0WIZMM/g01BACtw
	 AxrbeLL+PuvcI/Xp0nIQzpwAeO1vTbUy0VC2lyt5gkC3lTqMr/Q6fp3zI/vjnjhBm2
	 zZxH5y2JU6Uk9sFUbColjCdhXzXCcS/BL8+4e8n2WlV9Eu15l6p6WbCPBrsQWKPgLv
	 r2N6HKOUnNK6wfRLIezXBkFHefI2+ZYEmndzY6iHec621ikP3HgdJJD5dRtagC+wDE
	 9JNsodmXGrjSNFHtK6Qjfci0Tj+jBzL/DhZOSi9mMdTajiXnHIa61p69/5m8Mp+JNl
	 G3+Trw/6emUmg==
Date: Tue, 10 Dec 2024 15:28:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 3/5] bpf: Add bpf_fget_task() kfunc
Message-ID: <20241210-elastisch-flamingo-9271dc82c3a0@brauner>
References: <AM6PR03MB508010982C37DF735B1EAA0E993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080CD2C2C0EFC01082EC582993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM6PR03MB5080CD2C2C0EFC01082EC582993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>

On Tue, Dec 10, 2024 at 02:03:52PM +0000, Juntong Deng wrote:
> This patch adds bpf_fget_task() kfunc.
> 
> bpf_fget_task() is used to get a pointer to the struct file
> corresponding to the task file descriptor. Note that this function
> acquires a reference to struct file.
> 
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
>  fs/bpf_fs_kfuncs.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 3fe9f59ef867..19a9d45c47f9 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -152,6 +152,26 @@ __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
>  	return bpf_get_dentry_xattr(dentry, name__str, value_p);
>  }
>  
> +/**
> + * bpf_fget_task() - Get a pointer to the struct file corresponding to
> + * the task file descriptor
> + *
> + * Note that this function acquires a reference to struct file.
> + *
> + * @task: the specified struct task_struct
> + * @fd: the file descriptor
> + *
> + * @returns the corresponding struct file pointer if found,
> + * otherwise returns NULL
> + */
> +__bpf_kfunc struct file *bpf_fget_task(struct task_struct *task, unsigned int fd)
> +{
> +	struct file *file;
> +
> +	file = fget_task(task, fd);
> +	return file;

Why the local variable?

