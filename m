Return-Path: <linux-fsdevel+bounces-13886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6948751EC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 15:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EFA4B285A1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 14:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC7A1EB21;
	Thu,  7 Mar 2024 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbC0xNQQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462501C6AD;
	Thu,  7 Mar 2024 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709821878; cv=none; b=JLTMofrpG0vu0KdX45+x1wwonHgyZF4IzuzjASSQBXvZRbBVkJH8b6mIjX43wUI8P/TEYgE9WacgZHa7fk/SlnjnIXRzsd322fw8j9QxLnpJJwQVEOeIH91c3KRCRsbrEKbgy9lLTaKLsDxyZ0V//cURJhN2OUsXPMU9tgE8bzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709821878; c=relaxed/simple;
	bh=BoCuQpnKvXZmgHfTbdIlDgZOctJUi4njjxRSp+4CH5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGqIl3yr7+IWt1DEOeu9qZRzgggzbrGdPVNsXTsyzP5SHoMcUnVkb7aHoGlpksow2r0lUNbwsc6YM6of17o+JmCO7ieavRXPPo5Grx12tZO2IXM37QclyL8QT164n4JPmp68/8zauH5Dxt0Yi82UuFdlm/3n/tsA3KGaryrOp2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbC0xNQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15B7C433C7;
	Thu,  7 Mar 2024 14:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709821877;
	bh=BoCuQpnKvXZmgHfTbdIlDgZOctJUi4njjxRSp+4CH5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pbC0xNQQrGejHQ2bitaJqqjSkMc3ngNCgVrKc4lmct9ZugZ4DVuNDalUqhOcmAfoB
	 6fb3JKk/IYaOyPrqxkA5sNEZYYIpkwxcT8jt1fbFlcadr4RyVWEI9mz0lih8Fp01Kd
	 uZ6nzAfci7WUsMGdOgDiNZKFx4zD2j3t+FvGKStRleoiz5tPTH83HX5pxO6+P8CTtN
	 0ujkoGBENcgy6n0Az2w3IC/eH0XBg3+MCgnpnVSsWwHPXBHZ3IAVDv8nm9/bdmBw6C
	 /YawpO4sw+i+UQ8k7YDcO2dOMO4IJ/r10vfitQxgRLLcadLplEQujRsmwV+RBhqLVR
	 oMu7jY1yZUVeA==
Date: Thu, 7 Mar 2024 08:31:16 -0600
From: Seth Forshee <sforshee@kernel.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>, stable@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] evm: Change vfs_getxattr() with __vfs_getxattr() in
 evm_calc_hmac_or_hash()
Message-ID: <ZenPtCfh6CyD2xz5@do-x1extreme>
References: <20240307122240.3560688-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307122240.3560688-1-roberto.sassu@huaweicloud.com>

On Thu, Mar 07, 2024 at 01:22:39PM +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Use __vfs_getxattr() instead of vfs_getxattr(), in preparation for
> deprecating using the vfs_ interfaces for retrieving fscaps.
> 
> __vfs_getxattr() is only used for debugging purposes, to check if kernel
> space and user space see the same xattr value.

__vfs_getxattr() won't give you the value as seen by userspace though.
Userspace goes through vfs_getxattr() -> xattr_getsecurity() ->
cap_inode_getsecurity(), which does the conversion to the value
userspace sees. __vfs_getxattr() just gives the raw disk data.

I'm also currently working on changes to my fscaps series that will make
it so that __vfs_getxattr() also cannot be used to read fscaps xattrs.
I'll fix this and other code in EVM which will be broken by that change
as part of the next version too.

> 
> Cc: stable@vger.kernel.org # 5.14.x
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> Fixes: 907a399de7b0 ("evm: Check xattr size discrepancy between kernel and user")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/evm/evm_crypto.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> index b1ffd4cc0b44..168d98c63513 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -278,8 +278,8 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
>  		if (size < 0)
>  			continue;
>  
> -		user_space_size = vfs_getxattr(&nop_mnt_idmap, dentry,
> -					       xattr->name, NULL, 0);
> +		user_space_size = __vfs_getxattr(dentry, inode, xattr->name,
> +						 NULL, 0);
>  		if (user_space_size != size)
>  			pr_debug("file %s: xattr %s size mismatch (kernel: %d, user: %d)\n",
>  				 dentry->d_name.name, xattr->name, size,
> -- 
> 2.34.1
> 

