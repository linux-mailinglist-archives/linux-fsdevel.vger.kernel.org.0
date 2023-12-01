Return-Path: <linux-fsdevel+bounces-4598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015E5801300
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 19:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3286F1C2030B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 18:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9487151021
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jh1ch6A6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E3924213;
	Fri,  1 Dec 2023 17:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE76C433C8;
	Fri,  1 Dec 2023 17:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701450181;
	bh=sXjXaBvFhx+/CtKXYxToECUN8YYuv4D897MDwp3vLf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jh1ch6A6+kAKLnu3qBATlucOO4fbgwy9c//Zu5vQ8sGKG1C+vvz2n1sOkJsJ0KKIv
	 sJQfE20WLnP3sG5ler/x4cqKkn7ZgOsBOs8C/ksyvebxieGtKwsgqwELYZ5x+JrD7o
	 724kbJ8agY4F8yupZUTdHvx9hNRCF3qj6nExJLRLpxjDF+tDhBeTId4TNoWs0zdXyc
	 LQXv9N0KTsOHllIYclzm2GT/dOkLgAX95zHafoxGcoWhq2Sz76Qez78AUShA1/6cN5
	 JjXwG/Iyjpw6JYPb4jC0SyPC9IvLngfkdtZjq9YG3h2O9DZIvJ9KD93UnsCkwj3VPg
	 +PmjGYG+PbL9A==
Date: Fri, 1 Dec 2023 18:02:55 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Cc: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, audit@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 07/16] fs: add inode operations to get/set/remove fscaps
Message-ID: <20231201-drohnen-ausverkauf-61e5c94364ca@brauner>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
 <20231129-idmap-fscap-refactor-v1-7-da5a26058a5b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129-idmap-fscap-refactor-v1-7-da5a26058a5b@kernel.org>

On Wed, Nov 29, 2023 at 03:50:25PM -0600, Seth Forshee (DigitalOcean) wrote:
> Add inode operations for getting, setting and removing filesystem
> capabilities rather than passing around raw xattr data. This provides
> better type safety for ids contained within xattrs.
> 
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---
>  include/linux/fs.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 98b7a7a8c42e..a0a77f67b999 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2002,6 +2002,11 @@ struct inode_operations {
>  				     int);
>  	int (*set_acl)(struct mnt_idmap *, struct dentry *,
>  		       struct posix_acl *, int);
> +	int (*get_fscaps)(struct mnt_idmap *, struct dentry *,
> +			  struct vfs_caps *);
> +	int (*set_fscaps)(struct mnt_idmap *, struct dentry *,
> +			  const struct vfs_caps *, int flags);

If it's really a flags argument, then unsigned int, please,
Reviewed-by: Christian Brauner <brauner@kernel.org>

> +	int (*remove_fscaps)(struct mnt_idmap *, struct dentry *);
>  	int (*fileattr_set)(struct mnt_idmap *idmap,
>  			    struct dentry *dentry, struct fileattr *fa);
>  	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);

Ofc we managed to add get/set_foo() and bar_get/set().

