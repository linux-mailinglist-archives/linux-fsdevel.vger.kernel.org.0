Return-Path: <linux-fsdevel+bounces-68979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A554CC6A74F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 481832C8D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6C5368295;
	Tue, 18 Nov 2025 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ztv3Bbdn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699FE35E526
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481555; cv=none; b=n3/x5yWGk3/tKgF5q/2qFPqyFmjoWbH5GUrZ5sIQVrtvNm5zgXHqRZ9pt93xhoU1I+5sTbATzpEa1nkrx8LeYcOlVpLwMkFGhCZLLWnLAINdNFxSJrGiR8NIrP6UD2UCYNt+VioKLiNOZz9TaDY36jg8PSnUw7GMqR2NZDUMsh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481555; c=relaxed/simple;
	bh=jVCC6yzwtEMgCezqeWpRYGcBu4Hqa63F6lOKk5v7UTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmN4BzZjYHspJuLWcHIhCNkgXD4LdTywQpdXSpkGOCxHKzrre5C8o/4fxaAY6flYJsUl6KTdy1l9kdEFzMqcorXybamyL3UxiqSn/zIBbnGO6lZ6ItLVLV50ERCR4M+amvzifq3dhpXqLPHUxxGTucvNXd4mNKqziHnm+cMi8UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ztv3Bbdn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBCCC2BCAF;
	Tue, 18 Nov 2025 15:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763481555;
	bh=jVCC6yzwtEMgCezqeWpRYGcBu4Hqa63F6lOKk5v7UTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ztv3BbdnMZaGNctJ5H0oe6UO0gkRXtYhFy8f00AaEiE/JjcwsR2+Zj4qYlhXRK+Po
	 vUy/OlqvmWbcGOitciiVHMIegzsGRJ/KQsyDzov7mJcieO+dpiFOZgtcb/qJ81PDyh
	 TFHCn4QKwQgLi24vT65hnEG53hfsUMmAV/qSSRTl379gC8d+8z0hzPNVk/mYpvchla
	 MTeEjE2ht6bUlImljLEJOpZHhU4QlHUid2ynyctv6kKdsNjMpZlxZZjNBYwBU30atK
	 KRyZGkiWmUqiXjuZOsLKD/br4shhUoI2JsXDWF6A7mY+GkUTZ2RT8763rd2SOCPzhq
	 Ng0XXOV9aakig==
Date: Tue, 18 Nov 2025 07:59:13 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: unexport ioctl_getflags
Message-ID: <20251118155913.GD196362@frogsfrogsfrogs>
References: <20251118070941.2368011-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118070941.2368011-1-hch@lst.de>

On Tue, Nov 18, 2025 at 08:09:41AM +0100, Christoph Hellwig wrote:
> No modular users, nor should there be any for a dispatcher like this.

Does the same logic apply to the EXPORT_SYMBOLs of ioctl_setflags /
ioctl_fs[gs]etxattr?

--D

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/file_attr.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> index 1dcec88c0680..63d62742fbb1 100644
> --- a/fs/file_attr.c
> +++ b/fs/file_attr.c
> @@ -316,7 +316,6 @@ int ioctl_getflags(struct file *file, unsigned int __user *argp)
>  		err = put_user(fa.flags, argp);
>  	return err;
>  }
> -EXPORT_SYMBOL(ioctl_getflags);
>  
>  int ioctl_setflags(struct file *file, unsigned int __user *argp)
>  {
> -- 
> 2.47.3
> 
> 

