Return-Path: <linux-fsdevel+bounces-20243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 604818D0513
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 17:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9293C1C21944
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 15:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2487F16C45E;
	Mon, 27 May 2024 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amW0V4La"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF3316C451;
	Mon, 27 May 2024 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716820326; cv=none; b=MjMjF3X5hdtWB9qem2iKmgWWvl9E1nqM+kWVTvqXzgx68FM1f3UpPr541oI0s3JVQsX58twttort2RQhgIMIW+A9KvalIe6E3rp80/3pjCigvXWdsHcpEUvou6BBFnXwmDMAmgvxOYO9TihByrZYfv8yAYDTEzbhUZOVZCpvNpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716820326; c=relaxed/simple;
	bh=B2/Yvpu3lTcYaIYRID1VS9dR4on3H8GQNYqMd3PwIPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCKGgFH7Gsk97kHup1w/YzIODBVRXWCPYN35QIfXFA+pUE1exASzHpQfJdsXerohysBWpTBg3fKu4T48eIDH+gUhDSWZQpD6q/16D77AFarr/ZCcizvWojw7+ZGMoOYKufEdkRtAwLm7SvVrGHKgXa7D45d+/eDUqspVdNAp83I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amW0V4La; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A4EC32781;
	Mon, 27 May 2024 14:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716820326;
	bh=B2/Yvpu3lTcYaIYRID1VS9dR4on3H8GQNYqMd3PwIPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=amW0V4La5Lk+nOQaRuEglYwpsivvj5lAvv6YV85kriBK04+xrx4A3BjM7J3o2Odpy
	 /2z3/jXr5oMo5H6fn59rgni7yLCbOff7eCfVjgaetIxk2O9wCBbGiNR0CI6bhA81Bd
	 ++mEz47jVATIXVDfc1LiUM5hepyQkWxYhcQGgBS5ozczyx7fvxeiq7OYjwdUkuudid
	 zhro1ODBYti+hnOgR//S/k7/4Q6O0zdMw/sppG05WBYFgiuDNSgev9NWfZdM8pzVPj
	 61UWRgx2HzZaPJSBkwZ23xzEPNQMKXQ5wkgQhnAMZpVd+ybbTWvtz656oYMvY8SfIw
	 chEFTUfYieD/w==
Date: Mon, 27 May 2024 16:32:00 +0200
From: Christian Brauner <brauner@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, tytso@mit.edu, 
	adilger.kernel@dilger.ca, lczerner@redhat.com, cmaiolino@redhat.com, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH v2 2/4] fs: add path parser for filesystem mount option.
Message-ID: <20240527-groll-mythisch-8580c32ab296@brauner>
References: <20240527075854.1260981-1-lihongbo22@huawei.com>
 <20240527075854.1260981-3-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240527075854.1260981-3-lihongbo22@huawei.com>

On Mon, May 27, 2024 at 03:58:52PM +0800, Hongbo Li wrote:
> `fsparam_path` uses `fs_param_is_path` to parse the option, but it
> is currently empty. The new mount api has considered this option in
> `fsconfig`(that is FSCONFIG_SET_PATH). Here we add general path parser
> in filesystem layer. Currently, no filesystem uses this function to
> parse parameters, we add `void *ptr` in `fs_parse_result` to point to
> the target structure(such as `struct inode *`).
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  fs/fs_parser.c            | 18 ++++++++++++++++++
>  include/linux/fs_parser.h |  1 +
>  2 files changed, 19 insertions(+)
> 
> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> index 2aa208cf2027..5d0adcc514d8 100644
> --- a/fs/fs_parser.c
> +++ b/fs/fs_parser.c
> @@ -367,6 +367,24 @@ EXPORT_SYMBOL(fs_param_is_blockdev);
>  int fs_param_is_path(struct p_log *log, const struct fs_parameter_spec *p,
>  		     struct fs_parameter *param, struct fs_parse_result *result)
>  {
> +	int ret;
> +	struct filename *f;
> +	struct path path;
> +
> +	if (param->type != fs_value_is_filename)
> +		return fs_param_bad_value(log, param);
> +	if (!*param->string && (p->flags & fs_param_can_be_empty))
> +		return 0;
> +
> +	f = param->name;
> +	ret = filename_lookup(param->dirfd, f, LOOKUP_FOLLOW, &path, NULL);
> +	if (ret < 0) {
> +		error_plog(log, "%s: Lookup failure for '%s'", param->key, f->name);
> +		return fs_param_bad_value(log, param);
> +	}
> +	result->ptr = d_backing_inode(path.dentry);
> +	path_put(&path);

That smells like a UAF:

dfd = open("/bla");
fsconfig(FSCONFIG_SET_PATH, dfd, "blub", 0);
close(dfd);
umount("/bla");

and that result->ptr now has a dangling pointer which will be triggered by:

fsconfig(FSCONFIG_CMD_CREATE);

