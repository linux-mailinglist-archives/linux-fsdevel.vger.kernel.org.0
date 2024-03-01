Return-Path: <linux-fsdevel+bounces-13277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F33F86E24F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 14:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21157283B39
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 13:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE7E6D50A;
	Fri,  1 Mar 2024 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYhNoxx8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34474086B;
	Fri,  1 Mar 2024 13:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709300221; cv=none; b=NBdWpdmOUXxrghJUINq/x+ANZ5xsyi3PZe8sGuAL/darc7ViyzZyzI3tq3Nd6+UWElVtPJahipoPpu0p2RYvjRPH9VY0Th5IC7EXgvK3FupfkcwjX8lTDk3JsIbEmBXTeaOT+nJMqOIaD+1zwwLY211sVKFZrJ1u54+TZCyHzBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709300221; c=relaxed/simple;
	bh=wi72/83S5ul2SLiJU9x98yCS+h9zTQektvauzYHFebc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHcE1KUW17g9B1W2mYtvDFcRmeuzKDqUOTAd7rg69XwdTiBVBBuXVkbb5+Sa92RWgKf45MA+ebM1uzQMJb2cAL6G0SsvpGEYIy6g+2fP6Wy2Em8VgCEBCrQhfHQEOBM0mjnIenFyfkb9WqGk1j3F3rD2bjj+0fR9LFaMgrQJbuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYhNoxx8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F14FC433F1;
	Fri,  1 Mar 2024 13:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709300221;
	bh=wi72/83S5ul2SLiJU9x98yCS+h9zTQektvauzYHFebc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oYhNoxx81w2FAoe+AW+crPcUNC1KLA6C1VOdSNFjKKmqO6I5ORXJlSlf2F/Uv7RHE
	 qtBBcDmwWLdmh6xufYK0YUlVa2D0171ZGmI5WT3b5DfKrkmA6J9jWVayOd7rstaJIt
	 YDYXmIL1dadqg5BoXJN7jH3/LDWwfDO4UUjUtyeniMDecdMzB1ZZL+/dP3HUCUiYB5
	 Lsr4EMLJicLRvAu7tY9MnYxTFCsGjAXXXElSUWTtHdhwKcEbIKCtp6bJMDUZIQGluk
	 OMv0mGVFImgavYviaA7Ma/AT87ZYMmL4yOPLfsNCYzNDhVFO7DK9Jmgj3keqhwARmi
	 qA+6MveBa4T3g==
Date: Fri, 1 Mar 2024 14:36:55 +0100
From: Christian Brauner <brauner@kernel.org>
To: Luis Henriques <lhenriques@suse.de>
Cc: Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ext4: fix mount parameters check for empty values
Message-ID: <20240301-spalten-impfschutz-4118b8fcf5b3@brauner>
References: <20240229163011.16248-1-lhenriques@suse.de>
 <20240229163011.16248-3-lhenriques@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240229163011.16248-3-lhenriques@suse.de>

On Thu, Feb 29, 2024 at 04:30:09PM +0000, Luis Henriques wrote:
> Now that parameters that have the flag 'fs_param_can_be_empty' set and
> their value is NULL are handled as 'flag' type, we need to properly check
> for empty (NULL) values.
> 
> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> ---
>  fs/ext4/super.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 0f931d0c227d..44ba2212dfb3 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -2183,12 +2183,12 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  	switch (token) {
>  #ifdef CONFIG_QUOTA
>  	case Opt_usrjquota:
> -		if (!*param->string)
> +		if (!param->string)
>  			return unnote_qf_name(fc, USRQUOTA);

I fail to understand how that can happen. Currently both of these
options are parsed as strings via:

#define fsparam_string_empty(NAME, OPT) \
        __fsparam(fs_param_is_string, NAME, OPT, fs_param_can_be_empty, NULL)


So if someone sets fsconfig(..., FSCONFIG_SET_STRING, "usrquota", NULL, ...)
we give an immediate

        case FSCONFIG_SET_STRING:
                if (!_key || !_value || aux) return -EINVAL;

from fsconfig() so we know that param->string cannot be NULL. If that
were the case we'd NULL deref in fs_param_is_string():

int fs_param_is_string(struct p_log *log, const struct fs_parameter_spec *p,
                       struct fs_parameter *param, struct fs_parse_result *result)
{
        if (param->type != fs_value_is_string ||
            (!*param->string && !(p->flags & fs_param_can_be_empty)))

So you're check above seems wrong. If I'm mistaken, please explain, how
this can happen in detail.

