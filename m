Return-Path: <linux-fsdevel+bounces-36090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381A09DB8B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 14:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21072824E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 13:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149891A9B52;
	Thu, 28 Nov 2024 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9kD2gsg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647FA1A29A;
	Thu, 28 Nov 2024 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732800646; cv=none; b=ry/i7lLBPU9rI6WanZxb/RHl5FhFQDwQvQcP0fzAuOfgStJpwyjC3G9m0YjsbkEBXzRBStw4MXJ3fs2wneeQBCW1TdU1eJN/Tbh17l72jUINZidiNyt//Al7aFCyIwX+EqIl2PfSjCZ5/CWdLpoF0j+e0+I/XKsHXgp03QJqXnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732800646; c=relaxed/simple;
	bh=JpZS4FF550dzKCgDGO2V/Wz3U56JkSdEw4snUvHW594=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPul1c0WilnBvW8xGbkk7VNBm9Patq4QHE8Jn29qoh2veWQCYc7DAf35B8Am1Og0tG0FNZY94023YSxh54VQMk8yaWrrvQQM2Os6FPLDysZvPsF8aOehTXwR7XfPXHYvawOhCEZu+Nx87+g0CvUPU3bvAMuMoEwgdZ0M7N7ye2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9kD2gsg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBC4C4CECE;
	Thu, 28 Nov 2024 13:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732800645;
	bh=JpZS4FF550dzKCgDGO2V/Wz3U56JkSdEw4snUvHW594=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d9kD2gsg9gze1xa3oXCwl3j9Tc763cOPdG6SgpeZTIOgBBV0PChwhnB3zSLK2Ircn
	 rbO8xMGVreYpvV4LQAT7EsprJvp9L3r/3K7sM5D5GLq8xjenTlAdGGPFpNkcl33BgO
	 ufeFiCPEEnAuadD30Tj/KtOyyd9ux4nie7DPbQPCsA8InoVlcb9LpvBqSuL7ox/Idq
	 fmcU3ldzQjhaMuHpkZM72ypLZ79/qq2SP+iS+61hpnf8SQHZjzSo7+tfhY2gjIgPsr
	 Kq+s/CUUMBCOn5g27ear2jB7JZrDI2XM7bMoGdtCG/e62Clax9/p2vmyxrpR8/2PxR
	 MgiSJlT9GliJA==
Date: Thu, 28 Nov 2024 14:30:39 +0100
From: Christian Brauner <brauner@kernel.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, zohar@linux.ibm.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, Shu Han <ebpqwerty472123@gmail.com>
Subject: Re: [PATCH v2 1/7] fs: ima: Remove S_IMA and IS_IMA()
Message-ID: <20241128-pokal-langweilen-8071fe2ad394@brauner>
References: <20241128100621.461743-1-roberto.sassu@huaweicloud.com>
 <20241128100621.461743-2-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241128100621.461743-2-roberto.sassu@huaweicloud.com>

On Thu, Nov 28, 2024 at 11:06:14AM +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Commit 196f518128d2e ("IMA: explicit IMA i_flag to remove global lock on
> inode_delete") introduced the new S_IMA inode flag to determine whether or
> not an inode was processed by IMA. In that way, it was not necessary to
> take the global lock on inode delete.
> 
> Since commit 4de2f084fbff ("ima: Make it independent from 'integrity'
> LSM"), the pointer of the inode integrity metadata managed by IMA has been
> moved to the inode security blob, from the rb-tree. The pointer is not NULL
> only if the inode has been processed by IMA, i.e. ima_inode_get() has been
> called for that inode.
> 
> Thus, since the IS_IMA() check can be now implemented by trivially testing
> whether or not the pointer of inode integrity metadata is NULL, remove the
> S_IMA definition in include/linux/fs.h and also the IS_IMA() macro.
> 
> Remove also the IS_IMA() invocation in ima_rdwr_violation_check(), since
> whether the inode was processed by IMA will be anyway detected by a
> subsequent call to ima_iint_find(). It does not have an additional overhead
> since the decision can be made in constant time, as opposed to logarithm
> when the inode integrity metadata was stored in the rb-tree.
> 
> Suggested-by: Shu Han <ebpqwerty472123@gmail.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/fs.h                | 3 +--
>  security/integrity/ima/ima_iint.c | 5 -----
>  security/integrity/ima/ima_main.c | 2 +-
>  3 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3559446279c1..b33363becbdd 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2261,7 +2261,7 @@ struct super_operations {
>  #define S_NOCMTIME	(1 << 7)  /* Do not update file c/mtime */
>  #define S_SWAPFILE	(1 << 8)  /* Do not truncate: swapon got its bmaps */
>  #define S_PRIVATE	(1 << 9)  /* Inode is fs-internal */
> -#define S_IMA		(1 << 10) /* Inode has an associated IMA struct */
> +/* #define S_IMA	(1 << 10) Inode has an associated IMA struct (unused) */

As Jan said, that line should be deleted. Otherwise,
Reviewed-by: Christian Brauner <brauner@kernel.org>

