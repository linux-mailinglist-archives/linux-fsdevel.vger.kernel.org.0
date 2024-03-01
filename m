Return-Path: <linux-fsdevel+bounces-13276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3B586E24A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 14:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61FFE287545
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 13:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3DD6EF1B;
	Fri,  1 Mar 2024 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbgCCjSc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7986A8B2;
	Fri,  1 Mar 2024 13:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709299915; cv=none; b=ARV7BJDmvtj338Oi4nlxlxh3QTuZTtV8gjUZxNIPUXXZ9GPK3eGV0O+bkVLZlitgOyexMbAdu0mzFoD7als/RHFbYKl1Q1PUdq9CGOy4ZNnb52CVIyT4f2TOfLAYsnMYZz5iHnAFqh8RJP3m3qmh+kh9plPIqggb7MBbXtGaZ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709299915; c=relaxed/simple;
	bh=dQyZF6cnjxG23aYWxc0Nq5QEcuXNbcVMw/uErjobCGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVYb37tdt261BeDGa2WT5kday7I351yQXd+ABl4qVaym2avYxGqSzTcKTNgYgdCIWPrH2W9CggsvAZwC1/6HtcjRKIfbJ/aWV59pulZtzDgGtjkdEmQDy+TjzzMbltrRy9RwcMvsEEAjpvKd15fhl9Pz4vxD/OZkDVGTjDieKWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbgCCjSc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39CDC433C7;
	Fri,  1 Mar 2024 13:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709299914;
	bh=dQyZF6cnjxG23aYWxc0Nq5QEcuXNbcVMw/uErjobCGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UbgCCjScpBlhVfa4UT0tOzBQUZsXay2ZXTvixeyhvxAvbr7lKqzJxIkAPl8nhkfl7
	 KIz3+ULdKXZsFM216VqR8LirLPYS2/Kt69ZqmNrWnz4oe/Bp4ab+QRI3lPj0OylNiN
	 Qrw0ggG4pEJJITYMNRl4sSJHP3ynofA74kxBXUytmfYR1oHym75ILxIXHMKHYyLxDo
	 ewsRFeCmIzAWdTkHduBrhpMZ7gsHmR47MZHJeYQS5PvsoW18QQ8rsrcQe7ukt4BOS4
	 VQrTw9v2iQFD9xQlWa1yGX9qqHfvmWykNYNTv3WpGS6k8dM0OoxhiiNPQuIEEan2Fv
	 zaz7f2KUepKgg==
Date: Fri, 1 Mar 2024 14:31:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: Luis Henriques <lhenriques@suse.de>
Cc: Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs_parser: handle parameters that can be empty and
 don't have a value
Message-ID: <20240301-gegossen-seestern-683681ea75d1@brauner>
References: <20240229163011.16248-1-lhenriques@suse.de>
 <20240229163011.16248-2-lhenriques@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240229163011.16248-2-lhenriques@suse.de>

On Thu, Feb 29, 2024 at 04:30:08PM +0000, Luis Henriques wrote:
> Currently, only parameters that have the fs_parameter_spec 'type' set to
> NULL are handled as 'flag' types.  However, parameters that have the
> 'fs_param_can_be_empty' flag set and their value is NULL should also be
> handled as 'flag' type, as their type is set to 'fs_value_is_flag'.
> 
> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> ---
>  fs/fs_parser.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> index edb3712dcfa5..53f6cb98a3e0 100644
> --- a/fs/fs_parser.c
> +++ b/fs/fs_parser.c
> @@ -119,7 +119,8 @@ int __fs_parse(struct p_log *log,
>  	/* Try to turn the type we were given into the type desired by the
>  	 * parameter and give an error if we can't.
>  	 */
> -	if (is_flag(p)) {
> +	if (is_flag(p) ||
> +	    (!param->string && (p->flags & fs_param_can_be_empty))) {
>  		if (param->type != fs_value_is_flag)
>  			return inval_plog(log, "Unexpected value for '%s'",
>  				      param->key);

If the parameter was derived from FSCONFIG_SET_STRING in fsconfig() then
param->string is guaranteed to not be NULL. So really this is only
about:

FSCONFIG_SET_FD
FSCONFIG_SET_BINARY
FSCONFIG_SET_PATH
FSCONFIG_SET_PATH_EMPTY

and those values being used without a value. What filesystem does this?
I don't see any.

The tempting thing to do here is to to just remove fs_param_can_be_empty
from every helper that isn't fs_param_is_string() until we actually have
a filesystem that wants to use any of the above as flags. Will lose a
lot of code that isn't currently used.

