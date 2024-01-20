Return-Path: <linux-fsdevel+bounces-8357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F74B833536
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jan 2024 16:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6102819EF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jan 2024 15:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBE4101FB;
	Sat, 20 Jan 2024 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMvxFZ7d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D837CFC10;
	Sat, 20 Jan 2024 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705764074; cv=none; b=h6iH+whMMovYwcH8F0iBHk4UnMZXBjeMaisYQtECzPe8DiXL7wwD2/HC0DPx0sObVsaum5EStoN51nzRPYqiGYTHAH3lFAKF1COvzGE2X52DLyiOfLFI4mUbO3Hju/9F+yEeqxhqmS2rJ3qzbBtvEQUbRqS5b8vEPyrIZLzh9VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705764074; c=relaxed/simple;
	bh=5z7U1o57Gu1WTDoGz/uRuPiQ6c81rmMNzFzUsulq3iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8Jk4O9iuSkPvUY4v54Cp8D0tGflfYaZjuAFAi+8rTJ7Qnj5g+Ml2uqshZXEOv0LRIcoNxQMoK/XjAUFiXpJT0QWDzz5G55T5LqcRSfQvLJ5THRyRbr21O99K8QDQB3FhoQ+vwrMJYy7lyaCs8h8sv7I25eRR2Axvi5D0isHN5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMvxFZ7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFBD4C433F1;
	Sat, 20 Jan 2024 15:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705764074;
	bh=5z7U1o57Gu1WTDoGz/uRuPiQ6c81rmMNzFzUsulq3iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vMvxFZ7d8lJqZDqqjngAJ4u+mUCzCdOGEjpz8fgDlzdnn9Q8yT4Qy06ewrOoypyUV
	 cPYn6fRRD1x7yOK8MYDZZlEaD6cutlImO1DOAGSEqhEb/HjSoyxSAabfSIDoHHjIzf
	 jE75UPLx5mGzgfFyu4bp5GzbfqwIw5Si52vTyJdJ5JMzXLaDQQM/BROZyAFoGNFs7O
	 Z0kfBLFPmTs6Wz3neameDBZpKUlePWb4t0Ntxli6dCv/L/SRQzlAVhJB3CLeS+fMPH
	 MrNRj8MmRnL4Zx2ItWDQl1yunOtld9A90qsGMyoOSVHr/ATWn8Tl9mQthzE+ObnU9L
	 KRc1Ce0bmNQKQ==
Date: Sat, 20 Jan 2024 16:21:08 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: mszeredi@redhat.com, stgraber@stgraber.org, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/9] fs/fuse: support idmapped getattr inode op
Message-ID: <20240120-heult-applaudieren-d6449392b497@brauner>
References: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
 <20240108120824.122178-5-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240108120824.122178-5-aleksandr.mikhalitsyn@canonical.com>

>  int fuse_update_attributes(struct inode *inode, struct file *file, u32 mask)
>  {
> -	return fuse_update_get_attr(inode, file, NULL, mask, 0);
> +	return fuse_update_get_attr(&nop_mnt_idmap, inode, file, NULL, mask, 0);
>  }
>  
>  int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
> @@ -1506,7 +1510,7 @@ static int fuse_perm_getattr(struct inode *inode, int mask)
>  		return -ECHILD;
>  
>  	forget_all_cached_acls(inode);
> -	return fuse_do_getattr(inode, NULL, NULL);
> +	return fuse_do_getattr(&nop_mnt_idmap, inode, NULL, NULL);
>  }
>  
>  /*
> @@ -2062,7 +2066,7 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
>  			 * ia_mode calculation may have used stale i_mode.
>  			 * Refresh and recalculate.
>  			 */
> -			ret = fuse_do_getattr(inode, NULL, file);
> +			ret = fuse_do_getattr(&nop_mnt_idmap, inode, NULL, file);
>  			if (ret)
>  				return ret;

These are internal getattr requests that don't originate from a specific mount?
Can you please add a comment about this in the commit message so it's
clear why it's ok to not pass the idmapping?

