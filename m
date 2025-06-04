Return-Path: <linux-fsdevel+bounces-50579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D89DACD748
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 06:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EAEB176834
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 04:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A85523817A;
	Wed,  4 Jun 2025 04:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ddtig1ze"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DADC2609F5
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 04:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749012247; cv=none; b=HUiYDw+20iXB8jBbsMkdRBpCQpgti8f4AfnSDf34xv7RspK21IDoOIsJwbJPTNIy5rxi8eYAiTgQesgx/ccOPKfSpp9V8devJQ8RSjE417jBXMJ3WHMmqRw5wfHZxGEdPlCGsggTP756pKr9j3Fj2zbl5/orYGaTUgnI48xgTk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749012247; c=relaxed/simple;
	bh=XhzwIRurZkYyWEwOyZnbEDyk82dQjwS259RrNEn38cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uv15p+tEASOyO2Dbe4QTgHfmP9FVXV2CksYd7xT8CPp8bboATdZjTkPR5GXYWwwXbU66WRT1ctsrmOFFzu5yHR7cBF+j56KqSXyFvx/i+RCpM/yaMEbtfq7X1FqO8Q5tU5v9zI1g9Qxucq1SOub+F3mloM/dUwBuR1BpGWsTuHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ddtig1ze; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 4 Jun 2025 00:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749012230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/qBak1RL9RSBzIoGDReLWOn6k/RJqKbVgrygIfQlFlE=;
	b=ddtig1zeKBB5HGtAyjNhWDHMf/H/eRUf5utse8QAw9iLiNg3kfsb2w3TFWTgb7NEXKls6I
	KDgVwIiw2SnxpIwSPhQPeacV/nEaNoRfqqJwLXKd/NnTd5ChL3NYMjt+UxX12at+2qWHCj
	YQUIxLpNba0x2C7AC6ImX5KGpCb4ZPo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v3] ovl: support layers on case-folding capable
 filesystems
Message-ID: <wj2n4gnyqj46ohfcwlfdginc2ulropbljrx5e6xmnrexnbaafp@y2ygcwsdoa5o>
References: <20250602171702.1941891-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602171702.1941891-1-amir73il@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 02, 2025 at 07:17:02PM +0200, Amir Goldstein wrote:
> Case folding is often applied to subtrees and not on an entire
> filesystem.
> 
> Disallowing layers from filesystems that support case folding is over
> limiting.
> 
> Replace the rule that case-folding capable are not allowed as layers
> with a rule that case folded directories are not allowed in a merged
> directory stack.
> 
> Should case folding be enabled on an underlying directory while
> overlayfs is mounted the outcome is generally undefined.
> 
> Specifically in ovl_lookup(), we check the base underlying directory
> and fail with -ESTALE and write a warning to kmsg if an underlying
> directory case folding is enabled.
> 
> Suggested-by: Kent Overstreet <kent.overstreet@linux.dev>
> Link: https://lore.kernel.org/linux-fsdevel/20250520051600.1903319-1-kent.overstreet@linux.dev/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Miklos,
> 
> This is my solution to Kent's request to allow overlayfs mount on
> bcachefs subtrees that do not have casefolding enabled, while other
> subtrees do have casefolding enabled.
> 
> I have written a test to cover the change of behavior [1].
> This test does not run on old kernel's where the mount always fails
> with casefold capable layers.
> 
> Let me know what you think.
> 
> Kent,
> 
> I have tested this on ext4.
> Please test on bcachefs.

This one fails with the proper error message in dmesg, and no other
errors :)

Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>

> 
> Thanks,
> Amir.
> 
> Changes since v1,v2:
> - Add ratelimited warnings for the lookup error cases
> - Add helper ovl_dentry_casefolded()
> - Write fstest [1]
> 
> [1] https://github.com/amir73il/xfstests/commits/ovl-casefold/
> 
>  fs/overlayfs/namei.c     | 31 ++++++++++++++++++++++++++++---
>  fs/overlayfs/overlayfs.h |  6 ++++++
>  fs/overlayfs/params.c    | 10 ++++------
>  fs/overlayfs/util.c      | 15 +++++++++++----
>  4 files changed, 49 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index d489e80feb6f..733beef7b810 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -230,13 +230,26 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
>  			     struct dentry **ret, bool drop_negative)
>  {
>  	struct ovl_fs *ofs = OVL_FS(d->sb);
> -	struct dentry *this;
> +	struct dentry *this = NULL;
> +	const char *warn;
>  	struct path path;
>  	int err;
>  	bool last_element = !post[0];
>  	bool is_upper = d->layer->idx == 0;
>  	char val;
>  
> +	/*
> +	 * We allow filesystems that are case-folding capable but deny composing
> +	 * ovl stack from case-folded directories. If someone has enabled case
> +	 * folding on a directory on underlying layer, the warranty of the ovl
> +	 * stack is voided.
> +	 */
> +	if (ovl_dentry_casefolded(base)) {
> +		warn = "case folded parent";
> +		err = -ESTALE;
> +		goto out_warn;
> +	}
> +
>  	this = ovl_lookup_positive_unlocked(d, name, base, namelen, drop_negative);
>  	if (IS_ERR(this)) {
>  		err = PTR_ERR(this);
> @@ -246,10 +259,17 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
>  		goto out_err;
>  	}
>  
> +	if (ovl_dentry_casefolded(this)) {
> +		warn = "case folded child";
> +		err = -EREMOTE;
> +		goto out_warn;
> +	}
> +
>  	if (ovl_dentry_weird(this)) {
>  		/* Don't support traversing automounts and other weirdness */
> +		warn = "unsupported object type";
>  		err = -EREMOTE;
> -		goto out_err;
> +		goto out_warn;
>  	}
>  
>  	path.dentry = this;
> @@ -283,8 +303,9 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
>  	} else {
>  		if (ovl_lookup_trap_inode(d->sb, this)) {
>  			/* Caught in a trap of overlapping layers */
> +			warn = "overlapping layers";
>  			err = -ELOOP;
> -			goto out_err;
> +			goto out_warn;
>  		}
>  
>  		if (last_element)
> @@ -316,6 +337,10 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
>  	this = NULL;
>  	goto out;
>  
> +out_warn:
> +	pr_warn_ratelimited("failed lookup in %s (%pd2, name='%.*s', err=%i): %s\n",
> +			    is_upper ? "upper" : "lower", base,
> +			    namelen, name, err, warn);
>  out_err:
>  	dput(this);
>  	return err;
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index aef942a758ce..6c51103d9305 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -446,6 +446,12 @@ void ovl_dentry_init_reval(struct dentry *dentry, struct dentry *upperdentry,
>  void ovl_dentry_init_flags(struct dentry *dentry, struct dentry *upperdentry,
>  			   struct ovl_entry *oe, unsigned int mask);
>  bool ovl_dentry_weird(struct dentry *dentry);
> +
> +static inline bool ovl_dentry_casefolded(struct dentry *dentry)
> +{
> +	return sb_has_encoding(dentry->d_sb) && IS_CASEFOLDED(d_inode(dentry));
> +}
> +
>  enum ovl_path_type ovl_path_type(struct dentry *dentry);
>  void ovl_path_upper(struct dentry *dentry, struct path *path);
>  void ovl_path_lower(struct dentry *dentry, struct path *path);
> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> index f42488c01957..2b9b31524c38 100644
> --- a/fs/overlayfs/params.c
> +++ b/fs/overlayfs/params.c
> @@ -282,13 +282,11 @@ static int ovl_mount_dir_check(struct fs_context *fc, const struct path *path,
>  		return invalfc(fc, "%s is not a directory", name);
>  
>  	/*
> -	 * Root dentries of case-insensitive capable filesystems might
> -	 * not have the dentry operations set, but still be incompatible
> -	 * with overlayfs.  Check explicitly to prevent post-mount
> -	 * failures.
> +	 * Allow filesystems that are case-folding capable but deny composing
> +	 * ovl stack from case-folded directories.
>  	 */
> -	if (sb_has_encoding(path->mnt->mnt_sb))
> -		return invalfc(fc, "case-insensitive capable filesystem on %s not supported", name);
> +	if (ovl_dentry_casefolded(path->dentry))
> +		return invalfc(fc, "case-insensitive directory on %s not supported", name);
>  
>  	if (ovl_dentry_weird(path->dentry))
>  		return invalfc(fc, "filesystem on %s not supported", name);
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index dcccb4b4a66c..593c4da107d6 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -206,10 +206,17 @@ bool ovl_dentry_weird(struct dentry *dentry)
>  	if (!d_can_lookup(dentry) && !d_is_file(dentry) && !d_is_symlink(dentry))
>  		return true;
>  
> -	return dentry->d_flags & (DCACHE_NEED_AUTOMOUNT |
> -				  DCACHE_MANAGE_TRANSIT |
> -				  DCACHE_OP_HASH |
> -				  DCACHE_OP_COMPARE);
> +	if (dentry->d_flags & (DCACHE_NEED_AUTOMOUNT | DCACHE_MANAGE_TRANSIT))
> +		return true;
> +
> +	/*
> +	 * Allow filesystems that are case-folding capable but deny composing
> +	 * ovl stack from case-folded directories.
> +	 */
> +	if (sb_has_encoding(dentry->d_sb))
> +		return IS_CASEFOLDED(d_inode(dentry));
> +
> +	return dentry->d_flags & (DCACHE_OP_HASH | DCACHE_OP_COMPARE);
>  }
>  
>  enum ovl_path_type ovl_path_type(struct dentry *dentry)
> -- 
> 2.34.1
> 

