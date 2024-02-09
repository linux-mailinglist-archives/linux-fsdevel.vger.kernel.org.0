Return-Path: <linux-fsdevel+bounces-10901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2078A84F305
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60653B28D16
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404CE69943;
	Fri,  9 Feb 2024 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQjpBvPK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D66AA2A;
	Fri,  9 Feb 2024 10:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707473582; cv=none; b=alT/olZXHiCuESAvt0+UezaTE9wU5Qzc4UVhWPpM/RlxAFnWefVqCHRmsDPkYEG/XC4gE+NROvHjDn0bKRz7Z/2M37ytLrl9AAh4KDuC4wOAUN99tNfsyVwbO0kGBxKnTVgnLZQuyok59Z3K4w6Fuh4BOTSownQxtZWe3lNLcLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707473582; c=relaxed/simple;
	bh=H0y37gda2ZDnmJWj/UJIDPUg2JgDXz6/cSxRRvWmyOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BImmXq9/C7mt8ryKnSsEahjnRZjkgpCWHyJDbV9KFVnTRRbeXxr00GTg7AHoCGRIzq50rYOuKcK2mgwEJrSS+E9jPFbyovTkL9pzWufHgzhFEbMw6dGbneUC38J8f8aCbzMuHtyCFQAPAYpzf1zolVApzBD5vhssnFv+JMn0mRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQjpBvPK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A794BC433C7;
	Fri,  9 Feb 2024 10:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707473582;
	bh=H0y37gda2ZDnmJWj/UJIDPUg2JgDXz6/cSxRRvWmyOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gQjpBvPKCvzhpYFRJo8TGy9M5ZB/fjFlw/xS0ExMQuhsPsUbFvlrQexg8S5lXxFmq
	 08A16PS6yvmjmuHAR8Y5qf5twkBHIeTt4LzWBFhSXIIvwwNUAI1Fnelpws+pLJmUeb
	 v1E+3llJGdcYoCYWSx+7kHQD4lIPD7dQqwlqDWTCuCPn5RLRtLMEkpXyYAFRuiKSJm
	 uEyCt3UvH5+2nCuX0CRVTvRmp7u3abJXC1G3JkGP6sgiZBSSUOXLguJf45J+yRPvKK
	 sIqlbjAM7WL5MNaCWwzctcconq8T62POGa6bVnIy0DjFC1jlx/hgK2XPqHmrNPmRYj
	 zdA3i3crniH/w==
Date: Fri, 9 Feb 2024 11:12:52 +0100
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
Subject: Re: [PATCH v9 12/25] security: Introduce file_post_open hook
Message-ID: <20240209-luftleer-jobangebote-6d6ab29b7191@brauner>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-13-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240115181809.885385-13-roberto.sassu@huaweicloud.com>

On Mon, Jan 15, 2024 at 07:17:56PM +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> In preparation to move IMA and EVM to the LSM infrastructure, introduce the
> file_post_open hook. Also, export security_file_post_open() for NFS.
> 
> Based on policy, IMA calculates the digest of the file content and
> extends the TPM with the digest, verifies the file's integrity based on
> the digest, and/or includes the file digest in the audit log.
> 
> LSMs could similarly take action depending on the file content and the
> access mask requested with open().
> 
> The new hook returns a value and can cause the open to be aborted.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  fs/namei.c                    |  2 ++
>  fs/nfsd/vfs.c                 |  6 ++++++
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  6 ++++++
>  security/security.c           | 17 +++++++++++++++++
>  5 files changed, 32 insertions(+)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 71c13b2990b4..fb93d3e13df6 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3620,6 +3620,8 @@ static int do_open(struct nameidata *nd,
>  	error = may_open(idmap, &nd->path, acc_mode, open_flag);
>  	if (!error && !(file->f_mode & FMODE_OPENED))
>  		error = vfs_open(&nd->path, file);
> +	if (!error)
> +		error = security_file_post_open(file, op->acc_mode);

What does it do for O_CREAT? IOW, we managed to create that thing and we
managed to open that thing. Can security_file_post_open() and
ima_file_check() fail afterwards even for newly created files?

