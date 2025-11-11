Return-Path: <linux-fsdevel+bounces-67853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C043C4C08C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 08:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC6018C17C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 07:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88AA34CFDE;
	Tue, 11 Nov 2025 06:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ILJjHSPw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08C73446C9;
	Tue, 11 Nov 2025 06:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844394; cv=none; b=Lj+PrKG00CNYLSbLze+09Q2SBWZao9ySdvTY8g5xjWhEHJ4qd8VMTC4Twz4uTkLOmXH/NQgDSFFK63Nc1//4hhD+06nbFx2Q2RaF9vftoLz7VxCihq1HnKSIlw73ZhVO3OlrTksfjhfBqiYua4WcYkcQjUt666rrw2Mkalm7zIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844394; c=relaxed/simple;
	bh=KXbNrpd88hbqWGfOnpAgOcqiOgMLVEFg/BXrRpn7SDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYFUErbv0bVLmOw2Y+dCyqlFQTC3Fbzj0Z6np1Jc6h2obly/AVdurnIBbmsCW2uANsABVjb9Wjc1BJRCwgl7uAH5BJqvnObFpK61vKP+WqJBfQHJv+JeQIe5VnvC+xpP/iWwtBMjbXmoDlbEp9si91gna+8y+rwNY7HvsDEb+E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ILJjHSPw; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jTo/7HW0fMEf/Vfs0TCX1T3dx4XWddC6frEPExjNGak=; b=ILJjHSPwgpn+EBErmHtTA46REk
	foDuSkvfbUCcvDLatDODkRAAakZ4/Nl3JC6jCLzlPfjBpSlJISdERo+M+sm18Et4h9H+0rs/jj+N3
	JvT8ghEY1SqXmRtpDRJp7aWqKpN4bsWfxXnr0bzIeH1SVRcXM06MN1nloiBTy0/Wm9h/lTIEcNE/w
	nXruBmrkMfKBo31piym1bjkeBXbhqkb6CAiZ9WqzUh7cyqqfAoi6CIoP/8S8ObzcbPZRHXNvV43gy
	4j/afeuJW1Ctmr6XA6xtUJwI3RsDZShYg6ZNO2XBZUyL4hDeSmySxbT6dAAEz4Z0SgMj5R8mE/T4S
	KfeQaaRg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIiM3-0000000C3Ak-2WNY;
	Tue, 11 Nov 2025 06:59:51 +0000
Date: Tue, 11 Nov 2025 06:59:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ian Kent <raven@themaw.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	autofs mailing list <autofs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/2] autofs: dont trigger mount if it cant succeed
Message-ID: <20251111065951.GQ2441659@ZenIV>
References: <20251111060439.19593-1-raven@themaw.net>
 <20251111060439.19593-3-raven@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111060439.19593-3-raven@themaw.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Nov 11, 2025 at 02:04:39PM +0800, Ian Kent wrote:

> diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
> index f5c16ffba013..0a29761f39c0 100644
> --- a/fs/autofs/inode.c
> +++ b/fs/autofs/inode.c
> @@ -251,6 +251,7 @@ static struct autofs_sb_info *autofs_alloc_sbi(void)
>  	sbi->min_proto = AUTOFS_MIN_PROTO_VERSION;
>  	sbi->max_proto = AUTOFS_MAX_PROTO_VERSION;
>  	sbi->pipefd = -1;
> +	sbi->owner = current->nsproxy->mnt_ns;
>  
>  	set_autofs_type_indirect(&sbi->type);
>  	mutex_init(&sbi->wq_mutex);
> diff --git a/fs/autofs/root.c b/fs/autofs/root.c
> index 174c7205fee4..8cce86158f20 100644
> --- a/fs/autofs/root.c
> +++ b/fs/autofs/root.c
> @@ -341,6 +341,14 @@ static struct vfsmount *autofs_d_automount(struct path *path)
>  	if (autofs_oz_mode(sbi))
>  		return NULL;
>  
> +	/* Refuse to trigger mount if current namespace is not the owner
> +	 * and the mount is propagation private.
> +	 */
> +	if (sbi->owner != current->nsproxy->mnt_ns) {
> +		if (vfsmount_to_propagation_flags(path->mnt) & MS_PRIVATE)
> +			return ERR_PTR(-EPERM);
> +	}
> +

Huh?  What's to guarantee that superblock won't outlive the namespace?

That looks seriously bogus.

