Return-Path: <linux-fsdevel+bounces-67895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A13FC4D140
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 11:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A237B421C22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34518348883;
	Tue, 11 Nov 2025 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrQkFEjz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEBD2FD7A7;
	Tue, 11 Nov 2025 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762856403; cv=none; b=Y4tzCUeJrW7QdeQpQ/F20lZ0aCYpPV1aADY+LbhQkBT0elWIcLejVl+ShCQNCbFF18f5S2RTE36f/GZpqcipe7/IAnMOQw+OQPIz697Eit8GbJluciaihhtCSGtajOApE/UYSV+iKXi8NzIQb5BxymssQPe3rghHHIh+wQdJyvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762856403; c=relaxed/simple;
	bh=BmshZqf1TcN87/HY8Wmil4MG8V25/dRU6AtLyHKwAYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=au83wpL8nBI0Yt57PI6UtAqczXw9v4vi9kzS8wrXcTVCU/nF5Dl4w1duEAOzu57SGmBzMLyWlzXjHNTV6RZvQ6rtIQD1pinrDApi074MjpUF3z7aTbvpNGoGkHGeYe08htuQtzF164s9SdYCnrR+TNwdJdRM0BLJJKtHKE0uXlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrQkFEjz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13ACC19424;
	Tue, 11 Nov 2025 10:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762856403;
	bh=BmshZqf1TcN87/HY8Wmil4MG8V25/dRU6AtLyHKwAYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YrQkFEjzqmgn6Ctk5g4U/9HVMW8Da6zf836mdQ4iMQXqViKVrVsPKycEIcacmVgHf
	 /nLScwB++tz4KtFw41BMno0sWRdc2sxhckDERkDqyzD6gM830pRdEf5LbsHtTQJzCG
	 EuYsJB5y09HEOVLI5keTMqi8ZojpgRBr2aJb8bMfPiCza4idtuyLPaABG+fKpJL84Z
	 GQmcIp/Vnxdvoyk5jcPuMOJ1FkBaxh4dZXkGsiAd1H+/rtP6Ft4bWX2QR8gIj9jRMU
	 qcm7eeNIK4RM/LeGKQJ7N+Vz/WI48cU67S7PrJMY90NyPO5rNFOXAs0LoMhFVqfhQG
	 6myfPvNxhI8ig==
Date: Tue, 11 Nov 2025 11:19:59 +0100
From: Christian Brauner <brauner@kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/2] autofs: dont trigger mount if it cant succeed
Message-ID: <20251111-zunahm-endeffekt-c8fb3f90a365@brauner>
References: <20251111060439.19593-1-raven@themaw.net>
 <20251111060439.19593-3-raven@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251111060439.19593-3-raven@themaw.net>

On Tue, Nov 11, 2025 at 02:04:39PM +0800, Ian Kent wrote:
> If a mount namespace contains autofs mounts, and they are propagation
> private, and there is no namespace specific automount daemon to handle
> possible automounting then attempted path resolution will loop until
> MAXSYMLINKS is reached before failing causing quite a bit of noise in
> the log.
> 
> Add a check for this in autofs ->d_automount() so that the VFS can
> immediately return an error in this case. Since the mount is propagation
> private an EPERM return seems most appropriate.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---
>  fs/autofs/autofs_i.h | 4 ++++
>  fs/autofs/inode.c    | 1 +
>  fs/autofs/root.c     | 8 ++++++++
>  fs/namespace.c       | 6 ++++++
>  include/linux/fs.h   | 1 +
>  5 files changed, 20 insertions(+)
> 
> diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
> index 23cea74f9933..34533587c66b 100644
> --- a/fs/autofs/autofs_i.h
> +++ b/fs/autofs/autofs_i.h
> @@ -16,6 +16,7 @@
>  #include <linux/wait.h>
>  #include <linux/sched.h>
>  #include <linux/sched/signal.h>
> +#include <uapi/linux/mount.h>
>  #include <linux/mount.h>
>  #include <linux/namei.h>
>  #include <linux/uaccess.h>
> @@ -109,11 +110,14 @@ struct autofs_wait_queue {
>  #define AUTOFS_SBI_STRICTEXPIRE 0x0002
>  #define AUTOFS_SBI_IGNORE	0x0004
>  
> +struct mnt_namespace;
> +
>  struct autofs_sb_info {
>  	u32 magic;
>  	int pipefd;
>  	struct file *pipe;
>  	struct pid *oz_pgrp;
> +	struct mnt_namespace *owner;
>  	int version;
>  	int sub_version;
>  	int min_proto;
> diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
> index f5c16ffba013..0a29761f39c0 100644
> --- a/fs/autofs/inode.c
> +++ b/fs/autofs/inode.c
> @@ -251,6 +251,7 @@ static struct autofs_sb_info *autofs_alloc_sbi(void)
>  	sbi->min_proto = AUTOFS_MIN_PROTO_VERSION;
>  	sbi->max_proto = AUTOFS_MAX_PROTO_VERSION;
>  	sbi->pipefd = -1;
> +	sbi->owner = current->nsproxy->mnt_ns;

ns_ref_get()
Can be called directly on the mount namespace.

