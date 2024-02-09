Return-Path: <linux-fsdevel+bounces-10887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6B384F27F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82C828BDA2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 09:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FDA67E60;
	Fri,  9 Feb 2024 09:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gV5hsKuy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5661D664A3;
	Fri,  9 Feb 2024 09:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707471945; cv=none; b=pS5Mvjvmw42xxt76g31zwX9gFTw1lscqNe0sXV0+06U7an3rvG1rrRW7ABxeBQ9Mn39s6SKtf3rVZ3E4TRdQRjO+V0A/XdsI9eMGm3mAvm/1uiFoYV9GnYdIrngPSnH0aBo2063+4GU5D7lgFay1vhPWS4kZmP6VmmChF2q/48E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707471945; c=relaxed/simple;
	bh=XTXqRfUyPr9yWhoo/YdxJVLsEINDyd7wbqRVK/40Huo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2t1mSVwSmdoKyzvwIT3dqgLAJ9TNILgFCzEIwYtib8i/z/hpjAVK/nY1TaEUdt327CMlTJfnwodVct1K974ICNcQLm+nZXSlBftt32GVDc5AOL6uuBrTrHYEaFzoJWxLP0FPR93Xi7kB3n1jacTcxrvRvRIgp/TY3TjDOSTR/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gV5hsKuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B33C433F1;
	Fri,  9 Feb 2024 09:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707471944;
	bh=XTXqRfUyPr9yWhoo/YdxJVLsEINDyd7wbqRVK/40Huo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gV5hsKuy6kT4l1bW8GZQNbBAOcQ5vrq9TCkNC4UkHaVG8K5YdmTb7Rljqylfgd5b+
	 2s9p+kfOyecmgRJzJG7s/swPntcVrYHyLfgg9BacyhQ5j85Tbc/Srp5jtabGK3h/jv
	 di2qzjjAy1T5Yy5qimr+TqM+cee7u3/ZVQz46v9ijl/vslb531JM+z/Q6PE1iNRF2D
	 a13Rt/M+jVUdTAdXGsZTaFn8piYBphLPWfDe53a+UOTDl2CJlzrvKDBinuwO9V9MTc
	 JG22L/hmv3iJll4DQE3t+L9z9dt0K0IQnQB9gqAFiprn4ZZxO3fVQcPH+FiWTW/IvQ
	 pFSSNKDpbPo0g==
Date: Fri, 9 Feb 2024 10:45:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, chuck.lever@oracle.com, jlayton@kernel.org, 
	neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, dhowells@redhat.com, jarkko@kernel.org, 
	stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, shuah@kernel.org, 
	mic@digikod.net, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>, 
	Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 21/25] ima: Move IMA-Appraisal to LSM infrastructure
Message-ID: <20240209-chancenreich-albatros-4dad750ab5f8@brauner>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-22-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240115181809.885385-22-roberto.sassu@huaweicloud.com>

On Mon, Jan 15, 2024 at 07:18:05PM +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> A few additional IMA hooks are needed to reset the cached appraisal
> status, causing the file's integrity to be re-evaluated on next access.
> Register these IMA-appraisal only functions separately from the rest of IMA
> functions, as appraisal is a separate feature not necessarily enabled in
> the kernel configuration.
> 
> Reuse the same approach as for other IMA functions, move hardcoded calls
> from various places in the kernel to the LSM infrastructure. Declare the
> functions as static and register them as hook implementations in
> init_ima_appraise_lsm(), called by init_ima_lsm().
> 
> Also move the inline function ima_inode_remove_acl() from the public ima.h
> header to ima_appraise.c.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  fs/attr.c                             |  2 -
>  include/linux/ima.h                   | 55 ---------------------------
>  security/integrity/ima/ima.h          |  5 +++
>  security/integrity/ima/ima_appraise.c | 38 +++++++++++++-----
>  security/integrity/ima/ima_main.c     |  1 +
>  security/security.c                   | 13 -------
>  6 files changed, 35 insertions(+), 79 deletions(-)
> 
> diff --git a/fs/attr.c b/fs/attr.c
> index 221d2bb0a906..38841f3ebbcb 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -17,7 +17,6 @@
>  #include <linux/filelock.h>
>  #include <linux/security.h>
>  #include <linux/evm.h>
> -#include <linux/ima.h>
>  
>  #include "internal.h"
>  
> @@ -503,7 +502,6 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
>  	if (!error) {
>  		fsnotify_change(dentry, ia_valid);
>  		security_inode_post_setattr(idmap, dentry, ia_valid);
> -		ima_inode_post_setattr(idmap, dentry, ia_valid);
>  		evm_inode_post_setattr(idmap, dentry, ia_valid);
>  	}

Acked-by: Christian Brauner <brauner@kernel.org>

