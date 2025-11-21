Return-Path: <linux-fsdevel+bounces-69379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8648C79EAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 15:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CCFCE34AA84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 13:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44D134FF4E;
	Fri, 21 Nov 2025 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="AHzsXTMY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6395425F96D;
	Fri, 21 Nov 2025 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763733242; cv=none; b=VB5J2+5KWX840fAt3B/etTDIf3bR0ERO3sHVxJ67+mDtrHsEMD9sbp9RrsGO7lN1yDnocP+ZtW3xU+VrIXF9OinR7vZG89QQTqIEub5YxdBvYKLEocSOmZ62a/k6mHsHzRmcuPRz2SKsMnOPbkR9H8rnQYsfzgCaLBWGPgGLR0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763733242; c=relaxed/simple;
	bh=6aOKUFvI/rROPcJzchZ2XUHheh6FRPpDR/g7aPBpWdY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tMDA1oYecDyFSmPGmdB2LXKO1UV5cuyMH/4RUd6xhS4QpsglBJ71BgufqsD44CrMY8V+WPwjT0skXXwKL9At0Pv9Sf5mEP9d0gR+i+aXH5CK4CQ7Ka2t9UmL8fGFL8XzdIyNOHfyBaPhxAWR9Whg87ROH8YrS8QKNY9/XkbPdco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=AHzsXTMY; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xlj5zr5ZF4MFJ3LrKwSWRL9UcULZKY99NYG9PorymqY=; b=AHzsXTMYlr4PD7nAETBDXfnqpB
	Ye5dFgos9E7a6pR+6nP18rTKSRK5RqvbxRKHuOZvkdgyFAbNANx1h6uw/Owzqpfa8GIahpg7JRL/+
	RFvEWl0KhJ/mR5wIMsmbvfrs75ukVSxHWdRMVbbBTyDF726LGVqyiwnHBekpcZmztipPy5w7KljHO
	3MPrfZ/+FHQ+Ctdq+mlQ1J8HDEWnDlMLp5R+5VDYqYxMeVVZL0obkSd5t8VPvUxoamknXKJOhyyBT
	Mqhkt51YUl9+s1F9NEyC5683hB5w7eEpqFMHdGGydITw+vmIjA3zOm0hjq6MsZggpbQVum5AyP7kh
	mj3T217Q==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vMRa9-003gHd-I1; Fri, 21 Nov 2025 14:53:49 +0100
From: Luis Henriques <luis@igalia.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] fuse: Uninitialized variable in fuse_epoch_work()
In-Reply-To: <aSBqUPeT2JCLDsGk@stanley.mountain> (Dan Carpenter's message of
	"Fri, 21 Nov 2025 16:34:08 +0300")
References: <aSBqUPeT2JCLDsGk@stanley.mountain>
Date: Fri, 21 Nov 2025 13:53:48 +0000
Message-ID: <873467mqz7.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21 2025, Dan Carpenter wrote:

> The "fm" pointer is either valid or uninitialized so checking for NULL
> doesn't work.  Check the "inode" pointer instead.

Hmm?  Why do you say 'fm' isn't initialised?  That's what fuse_ilookup()
is doing, isn't it?

Cheers,
--=20
Lu=C3=ADs

> Fixes: 64becd224ff9 ("fuse: new work queue to invalidate dentries from ol=
d epochs")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  fs/fuse/dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 761f4a14dc95..ec5042b47abb 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -201,7 +201,7 @@ void fuse_epoch_work(struct work_struct *work)
>  	inode =3D fuse_ilookup(fc, FUSE_ROOT_ID, &fm);
>  	iput(inode);
>=20=20
> -	if (fm) {
> +	if (inode) {
>  		/* Remove all possible active references to cached inodes */
>  		shrink_dcache_sb(fm->sb);
>  	} else
> --=20
> 2.51.0
>

