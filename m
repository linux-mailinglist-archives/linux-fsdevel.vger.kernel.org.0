Return-Path: <linux-fsdevel+bounces-21045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 637668FD0EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 16:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E66AE282CD6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 14:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C7219D8A5;
	Wed,  5 Jun 2024 14:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOcTFCwF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E716B19D889
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jun 2024 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717598116; cv=none; b=iDnOYeoR29u/4j7EzdR47RgPCBCdJkwDSHAprNuNg7VxEiE335a3Mjq7JBiiux+W2A8mhSJjiYhte+8eQ4Uj9fmoPwlHWoYIy8AWV4I9SPTaGJQhJivuRHbGQDnHbO+gAXPcq5XnZrXsoKbWY+v4fgLOFupU8ckAijwmcFEttmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717598116; c=relaxed/simple;
	bh=/fet2UeWm25ZxPho3bAu0pIIVpQrXujF6LqEGdqVTZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgxRwq3QUkli1JQuSM+ryYiMjPCLDP+GmpQ2DHPh8UNfj3WfZLP5aaigrwPv4wVdHOZSM4Bv/zG4Md6bbE+R6YSVYco54lOXiqu2jd9zvNTSo6Bv2IjETaPWsEjmV+AhNBDxgDVUvrCMh+65w/dKSzxHA1W9ffLi2rYOET+zUdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOcTFCwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D66FC2BD11;
	Wed,  5 Jun 2024 14:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717598115;
	bh=/fet2UeWm25ZxPho3bAu0pIIVpQrXujF6LqEGdqVTZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oOcTFCwF1JVUQMUyepz+r/Nstgb3KQoXIC0h9EXHUhT03ZEtF4mRHTeme07SY5HL/
	 8jnNNytst8i+WoR3TVsbHwe86OJEjx4GpUyxRqPB9s5GlMjRhKNN7z1CmzAErkyvhc
	 Iwlrk3tytdJhZjzf5zSa8Vr/lXXiF3H/0HHGA23JdWw+dJx2UGGONYZUmWIpdi+mn1
	 K9zl54aSnS76mqHDEo+1Njnj67RVDV81ZK2U0w7kU35cckQc6cYqHWYPQiWocxdVjy
	 jhi5uyM5+Zs8gX7ikm5vwTDry+C2mBLJDMWH2VFX6yv3h3X0whFWeUZjV7lbBy8D3m
	 QXiiNhptBTA6g==
Date: Wed, 5 Jun 2024 16:35:11 +0200
From: Christian Brauner <brauner@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>, 
	Bill O'Donnell <billodo@redhat.com>
Subject: Re: [PATCH RFC] fs_parse: add uid & gid option parsing helpers
Message-ID: <20240605-moralisieren-nahegehen-90101b576679@brauner>
References: <8b06d4d4-3f99-4c16-9489-c6cc549a3daf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8b06d4d4-3f99-4c16-9489-c6cc549a3daf@redhat.com>

On Tue, Jun 04, 2024 at 12:17:39PM -0500, Eric Sandeen wrote:
> Multiple filesystems take uid and gid as options, and the code to
> create the ID from an integer and validate it is standard boilerplate
> that can be moved into common parsing helper functions, so do that for
> consistency and less cut&paste.
> 
> This also helps avoid the buggy pattern noted by Seth Jenkins at
> https://lore.kernel.org/lkml/CALxfFW4BXhEwxR0Q5LSkg-8Vb4r2MONKCcUCVioehXQKr35eHg@mail.gmail.com/
> because uid/gid parsing will fail before any assignment in most
> filesystems.
> 
> With this in place, filesystem parsing is simplified, as in
> the patch at
> https://git.kernel.org/pub/scm/linux/kernel/git/sandeen/linux.git/commit/?h=mount-api-uid-helper&id=480d0d3c6699abfbb174b1bf2ab2bbeeec4fe911
> 
> Note that FS_USERNS_MOUNT filesystems still need to do additional
> checking with k[ug]id_has_mapping(), I think.
> 
> Thoughts? Is this useful / worthwhile? If so I can send a proper
> 2-patch series ccing the dozen or so filesystems the 2nd patch will
> touch. :)
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---

Seems worthwhile to me. Ideally you'd funnel through the fc->user_ns smh
so we can do the k[ug]id_has_mapping() checks right in these parsing
helpers.

>  Documentation/filesystems/mount_api.rst |  9 +++++++--
>  fs/fs_parser.c                          | 34 +++++++++++++++++++++++++++++++++
>  include/linux/fs_parser.h               |  6 +++++-
>  3 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/filesystems/mount_api.rst b/Documentation/filesystems/mount_api.rst
> index 9aaf6ef75eb53b..317934c9e8fcac 100644
> --- a/Documentation/filesystems/mount_api.rst
> +++ b/Documentation/filesystems/mount_api.rst
> @@ -645,6 +645,8 @@ The members are as follows:
>  	fs_param_is_blockdev	Blockdev path		* Needs lookup
>  	fs_param_is_path	Path			* Needs lookup
>  	fs_param_is_fd		File descriptor		result->int_32
> +	fs_param_is_uid		User ID (u32)           result->uid
> +	fs_param_is_gid		Group ID (u32)          result->gid
>  	=======================	=======================	=====================
>  
>       Note that if the value is of fs_param_is_bool type, fs_parse() will try
> @@ -678,6 +680,8 @@ The members are as follows:
>  	fsparam_bdev()		fs_param_is_blockdev
>  	fsparam_path()		fs_param_is_path
>  	fsparam_fd()		fs_param_is_fd
> +	fsparam_uid()		fs_param_is_uid
> +	fsparam_gid()		fs_param_is_gid
>  	=======================	===============================================
>  
>       all of which take two arguments, name string and option number - for
> @@ -784,8 +788,9 @@ process the parameters it is given.
>       option number (which it returns).
>  
>       If successful, and if the parameter type indicates the result is a
> -     boolean, integer or enum type, the value is converted by this function and
> -     the result stored in result->{boolean,int_32,uint_32,uint_64}.
> +     boolean, integer, enum, uid, or gid type, the value is converted by this
> +     function and the result stored in
> +     result->{boolean,int_32,uint_32,uint_64,uid,gid}.
>  
>       If a match isn't initially made, the key is prefixed with "no" and no
>       value is present then an attempt will be made to look up the key with the
> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> index a4d6ca0b8971e6..9c4e4984aae8a4 100644
> --- a/fs/fs_parser.c
> +++ b/fs/fs_parser.c
> @@ -308,6 +308,40 @@ int fs_param_is_fd(struct p_log *log, const struct fs_parameter_spec *p,
>  }
>  EXPORT_SYMBOL(fs_param_is_fd);
>  
> +int fs_param_is_uid(struct p_log *log, const struct fs_parameter_spec *p,
> +		    struct fs_parameter *param, struct fs_parse_result *result)
> +{
> +	kuid_t uid;
> +
> +	if (fs_param_is_u32(log, p, param, result) != 0)
> +		return fs_param_bad_value(log, param);
> +
> +	uid = make_kuid(current_user_ns(), result->uint_32);
> +	if (!uid_valid(uid))
> +		return inval_plog(log, "Bad uid '%s'", param->string);
> +
> +	result->uid = uid;
> +	return 0;
> +}
> +EXPORT_SYMBOL(fs_param_is_uid);
> +
> +int fs_param_is_gid(struct p_log *log, const struct fs_parameter_spec *p,
> +		    struct fs_parameter *param, struct fs_parse_result *result)
> +{
> +	kgid_t gid;
> +
> +	if (fs_param_is_u32(log, p, param, result) != 0)
> +		return fs_param_bad_value(log, param);
> +
> +	gid = make_kgid(current_user_ns(), result->uint_32);
> +	if (!gid_valid(gid))
> +		return inval_plog(log, "Bad gid '%s'", param->string);
> +
> +	result->gid = gid;
> +	return 0;
> +}
> +EXPORT_SYMBOL(fs_param_is_gid);
> +
>  int fs_param_is_blockdev(struct p_log *log, const struct fs_parameter_spec *p,
>  		  struct fs_parameter *param, struct fs_parse_result *result)
>  {
> diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
> index d3350979115f0a..6cf713a7e6c6fc 100644
> --- a/include/linux/fs_parser.h
> +++ b/include/linux/fs_parser.h
> @@ -28,7 +28,7 @@ typedef int fs_param_type(struct p_log *,
>   */
>  fs_param_type fs_param_is_bool, fs_param_is_u32, fs_param_is_s32, fs_param_is_u64,
>  	fs_param_is_enum, fs_param_is_string, fs_param_is_blob, fs_param_is_blockdev,
> -	fs_param_is_path, fs_param_is_fd;
> +	fs_param_is_path, fs_param_is_fd, fs_param_is_uid, fs_param_is_gid;
>  
>  /*
>   * Specification of the type of value a parameter wants.
> @@ -57,6 +57,8 @@ struct fs_parse_result {
>  		int		int_32;		/* For spec_s32/spec_enum */
>  		unsigned int	uint_32;	/* For spec_u32{,_octal,_hex}/spec_enum */
>  		u64		uint_64;	/* For spec_u64 */
> +		kuid_t		uid;
> +		kgid_t		gid;
>  	};
>  };
>  
> @@ -131,6 +133,8 @@ static inline bool fs_validate_description(const char *name,
>  #define fsparam_bdev(NAME, OPT)	__fsparam(fs_param_is_blockdev, NAME, OPT, 0, NULL)
>  #define fsparam_path(NAME, OPT)	__fsparam(fs_param_is_path, NAME, OPT, 0, NULL)
>  #define fsparam_fd(NAME, OPT)	__fsparam(fs_param_is_fd, NAME, OPT, 0, NULL)
> +#define fsparam_uid(NAME, OPT) __fsparam(fs_param_is_uid, NAME, OPT, 0, NULL)
> +#define fsparam_gid(NAME, OPT) __fsparam(fs_param_is_gid, NAME, OPT, 0, NULL)
>  
>  /* String parameter that allows empty argument */
>  #define fsparam_string_empty(NAME, OPT) \
> -- 
> cgit 1.2.3-korg
> 

