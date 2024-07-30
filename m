Return-Path: <linux-fsdevel+bounces-24624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9992941AA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 18:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAEF01C20E34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 16:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6FC18801A;
	Tue, 30 Jul 2024 16:46:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9687E1A6166;
	Tue, 30 Jul 2024 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357964; cv=none; b=W2SUP4ICTxD1i4ZtGddX8pba2mTwIjUwN1uX0WYTX6FCgb7z3DTtJbTy8X8qPp9iGk/bWsh8iedEFkATKrcv9PQurEy6DrAY+O3sgDoNCGQkeJV7jBskztABDzWEHjhvktMW+Hyqh/zFb72w45eUkfohaqu0EoWyYAfD2L2AUxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357964; c=relaxed/simple;
	bh=GKoqSlvPjpjkXxO95eFdftWUqJBC1IEiCl+9pph3zDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRjJUzWtscKuJmioINvnXLrpHewPO3r5S5FxNIQ6AcHPD4tV3uQLvUOuVnYSSEl/wjAOvUhrVfm3jHIRfGje9By47pq6tQNJM83Z3IUPWqq/fxWcupA1ZnhRVps5hfZCgR+tt2ZMllXCSSGVP5GAZ0buaF8zRE/YviJ0aG8zgwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 8D0F072C90D;
	Tue, 30 Jul 2024 19:45:54 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 7E6F47CCB3A; Tue, 30 Jul 2024 19:45:54 +0300 (IDT)
Date: Tue, 30 Jul 2024 19:45:54 +0300
From: "Dmitry V. Levin" <ldv@strace.io>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 7/8] fs: add an ioctl to get the mnt ns id from nsfs
Message-ID: <20240730164554.GA18486@altlinux.org>
References: <cover.1719243756.git.josef@toxicpanda.com>
 <180449959d5a756af7306d6bda55f41b9d53e3cb.1719243756.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <180449959d5a756af7306d6bda55f41b9d53e3cb.1719243756.git.josef@toxicpanda.com>

Hi,

On Mon, Jun 24, 2024 at 11:49:50AM -0400, Josef Bacik wrote:
> In order to utilize the listmount() and statmount() extensions that
> allow us to call them on different namespaces we need a way to get the
> mnt namespace id from user space.  Add an ioctl to nsfs that will allow
> us to extract the mnt namespace id in order to make these new extensions
> usable.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/nsfs.c                 | 14 ++++++++++++++
>  include/uapi/linux/nsfs.h |  2 ++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/fs/nsfs.c b/fs/nsfs.c
> index 07e22a15ef02..af352dadffe1 100644
> --- a/fs/nsfs.c
> +++ b/fs/nsfs.c
> @@ -12,6 +12,7 @@
>  #include <linux/nsfs.h>
>  #include <linux/uaccess.h>
>  
> +#include "mount.h"
>  #include "internal.h"
>  
>  static struct vfsmount *nsfs_mnt;
> @@ -143,6 +144,19 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
>  		argp = (uid_t __user *) arg;
>  		uid = from_kuid_munged(current_user_ns(), user_ns->owner);
>  		return put_user(uid, argp);
> +	case NS_GET_MNTNS_ID: {
> +		struct mnt_namespace *mnt_ns;
> +		__u64 __user *idp;
> +		__u64 id;
> +
> +		if (ns->ops->type != CLONE_NEWNS)
> +			return -EINVAL;
> +
> +		mnt_ns = container_of(ns, struct mnt_namespace, ns);
> +		idp = (__u64 __user *)arg;
> +		id = mnt_ns->seq;
> +		return put_user(id, idp);
> +	}
>  	default:
>  		return -ENOTTY;
>  	}
> diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
> index a0c8552b64ee..56e8b1639b98 100644
> --- a/include/uapi/linux/nsfs.h
> +++ b/include/uapi/linux/nsfs.h
> @@ -15,5 +15,7 @@
>  #define NS_GET_NSTYPE		_IO(NSIO, 0x3)
>  /* Get owner UID (in the caller's user namespace) for a user namespace */
>  #define NS_GET_OWNER_UID	_IO(NSIO, 0x4)
> +/* Get the id for a mount namespace */
> +#define NS_GET_MNTNS_ID		_IO(NSIO, 0x5)

As the kernel is writing an object of type __u64,
this has to be defined to _IOR(NSIO, 0x5, __u64) instead,
see the corresponding comments in uapi/asm-generic/ioctl.h file.


-- 
ldv

