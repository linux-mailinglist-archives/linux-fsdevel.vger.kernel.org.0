Return-Path: <linux-fsdevel+bounces-48930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4901AB60E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 04:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E566E1893FE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 02:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FB91E5213;
	Wed, 14 May 2025 02:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BGI/NLMM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C704AC2C9;
	Wed, 14 May 2025 02:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747190630; cv=none; b=S/A3qUf9qi+L++AQX/8sKEpQnAYYE4UmCa2vl/Q+Gz0eWmmzVJiG5QTGKn4Grq+bJMDwJ90FMgsTfe5vjcitsaz6UGsVV2IeDCDjEsbL4LiCwTm9mfmjzrmXDfwHPHp+kEyiyGs5M54aR09QmIpuSy83rfYL5060nymCxRit9+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747190630; c=relaxed/simple;
	bh=X+R3TUc5JpW7ZheWbPg3gGWYQNCtyjJ/C52nIZS/ReQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvrxJSJhjN4hAme3PFy1bpcsU/Wv/YGs93Sby/Io8UHCoNdmbkkoWUUMAN3nC1FafhCBWxLPPRAwWfQRkqf443oGn8lpJpeW6QeVHXQ8+g/zxugAZW11eUSOtqfF8pbPajKXRW9JWl/Z88nTZtFRb2aMJrq/dQl7oUeIrwtIPec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BGI/NLMM; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=ekrSkmFgoDsdtOcT6xL5mDsbDjgvMv4Zcrtj2UMz7jQ=; b=BGI/NLMMXA+1WPMRyTAOsXiONe
	tbVhFF0A1HXb8+Af6kI+UWkcSHc/ZiOP3uN09hCvJXbzQ+0hz5kVQ7/mQwSSCEHeFtivcbaSj6FNg
	XhCRnl7aIVLK3C9C+ca1CuP9pq1lM0nQ4d1vy32aN+bm7iyugZujpIhiplNk+W8jtLmHy3Lo13Phy
	L1WXvCkB50/nkILQuguz4hu/ZdgKSYzY5kYBPz0A0/NvLT7OPOCCXuqv7uF7JWgUMebwGhdre/wuG
	w88SnBj2O98n69ahNd3A0sYast2OViKs2t2UcTGktgtJwXTnVfzf5Gx0UE0O8G5YXl/7/u999O8rB
	iOnEoSIQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uF25u-00000005pyh-329G;
	Wed, 14 May 2025 02:43:42 +0000
Date: Wed, 14 May 2025 03:43:42 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: KONDO =?utf-8?B?S0FaVU1BKOi/keiXpOOAgOWSjOecnyk=?= <kazuma-kondo@nec.com>
Cc: "brauner@kernel.org" <brauner@kernel.org>,
	"jack@suse.cz" <jack@suse.cz>,
	"mike@mbaynton.com" <mike@mbaynton.com>,
	"miklos@szeredi.hu" <miklos@szeredi.hu>,
	"amir73il@gmail.com" <amir73il@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: allow clone_private_mount() for a path on real rootfs
Message-ID: <20250514024342.GL2023217@ZenIV>
References: <20250514002650.118278-1-kazuma-kondo@nec.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250514002650.118278-1-kazuma-kondo@nec.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, May 14, 2025 at 12:25:58AM +0000, KONDO KAZUMA(近藤 和真) wrote:

> @@ -2482,17 +2482,13 @@ struct vfsmount *clone_private_mount(const struct path *path)
>  	if (IS_MNT_UNBINDABLE(old_mnt))
>  		return ERR_PTR(-EINVAL);
>  
> -	if (mnt_has_parent(old_mnt)) {
> +	if (!is_mounted(&old_mnt->mnt))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (mnt_has_parent(old_mnt) || !is_anon_ns(old_mnt->mnt_ns)) {
>  		if (!check_mnt(old_mnt))
>  			return ERR_PTR(-EINVAL);
>  	} else {
> -		if (!is_mounted(&old_mnt->mnt))
> -			return ERR_PTR(-EINVAL);
> -
> -		/* Make sure this isn't something purely kernel internal. */
> -		if (!is_anon_ns(old_mnt->mnt_ns))
> -			return ERR_PTR(-EINVAL);
> -
>  		/* Make sure we don't create mount namespace loops. */
>  		if (!check_for_nsfs_mounts(old_mnt))
>  			return ERR_PTR(-EINVAL);

Not the right way to do that.  What we want is

	/* ours are always fine */
	if (!check_mnt(old_mnt)) {
		/* they'd better be mounted _somewhere */
		if (!is_mounted(old_mnt))
			return -EINVAL;
		/* no other real namespaces; only anon */
		if (!is_anon_ns(old_mnt->mnt_ns))
			return -EINVAL;
		/* ... and root of that anon */
		if (mnt_has_parent(old_mnt))
			return -EINVAL;
		/* Make sure we don't create mount namespace loops. */
		if (!check_for_nsfs_mounts(old_mnt))
			return ERR_PTR(-EINVAL);
	}

