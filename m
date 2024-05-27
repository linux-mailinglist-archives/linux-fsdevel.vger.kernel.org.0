Return-Path: <linux-fsdevel+bounces-20224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 770D88CFF05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 13:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4491C21D49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 11:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD7F15B155;
	Mon, 27 May 2024 11:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LeuM16C7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4B515B138
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 11:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716809522; cv=none; b=ljR+yN+NXG7ThRqGM2n/ZP/SDkQy8jVy3FVEuYWUqj0oJJdnjfL9yymfLwxGgvrcv94LYTxbnPOSOCMz03jgbC44IRqW/43RJD19hm5HSN0fVdbQIxzsnlw7m3OULVB3YRjAa21YT7GBuZZuRNny9K52ww1wF3hfIbwVJu8u3eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716809522; c=relaxed/simple;
	bh=3u475GSf3hiVfSJCycRmuj3kIeOQr7tMbFg/brmknqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPDONwWR3YBmWdSfvz2vpaSmSXKQIEgse6NLMSBzpvY4TUasz8oVzIZ5aC5qpPRak4Y+bdjucPcbFpOHWXfCKYm/Rqg6DIbKLZ8ooPAK4wa1NdITOXvqez2ukz+ySY2ffOMm8TtViIT0W5B1c0woQFr3NIGmaRkbBVSGSk3ejyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LeuM16C7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ppd0JL3xn6nS58hWSVxFMuvx8O8JPcfxh7sJwYTl7AM=; b=LeuM16C7eZcnuYDzzUg+Z9xxpN
	kHY5yFbOc3D3lkg4LYGzwzqIufp3KPuMur+7TLt/BlIRAko6EaHCTGvbRFOgFJo7ZblC2KvGnb05U
	vhydyT2DnhgQG84heNJuXj9CD1R9yYbWN2SC5a7FebdiSrp3OX1DQTFBXMO9DOYjlFSf+GZ4rRxKq
	sHd0qtYxPx++P7GjhZ/3AH1gs2xdN4kxM5lgOkYGGkrn83uotz7errtLKB/C4nWRKnPVcHdHGEJEs
	YvG3ZGbhDCHWqscnt3df8BqB8jN4qFIr/O2J2pbyeeQbazftqP0NdTYsWT+SsXeci7cmm6qclhRfz
	piJOlzQQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBYa7-0000000EiLL-0FYR;
	Mon, 27 May 2024 11:31:59 +0000
Date: Mon, 27 May 2024 04:31:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] : fhandle: relax open_by_handle_at() permission
 checks
Message-ID: <ZlRvL93BmKAXfIYm@infradead.org>
References: <20240524-vfs-open_by_handle_at-v1-1-3d4b7d22736b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524-vfs-open_by_handle_at-v1-1-3d4b7d22736b@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, May 24, 2024 at 12:19:39PM +0200, Christian Brauner wrote:
> (2) Opening file handles when the caller has privileges over a subtree
>     (2.1) The caller is able to reach the file from the provided mount fd.
>     (2.2) The caller has permissions to construct an unobstructed path to the
>           file handle.
>     (2.3) The caller has permissions to follow a path to the file handle.

These are OR conditions, not AND, right?

> The relaxed permission checks are currently restricted to directory file
> handles which are what both cgroupfs and fanotify need. Handling disconnected
> non-directory file handles would lead to a potentially non-deterministic api.
> If a disconnected non-directory file handle is provided we may fail to decode
> a valid path that we could use for permission checking. That in itself isn't a
> problem as we would just return EACCES in that case. However, confusion may
> arise if a non-disconnected dentry ends up in the cache later and those opening
> the file handle would suddenly succeed.

That feels like a pretty odd adhoc API.

> * An unrelated note (IOW, these are thoughts that apply to
>   open_by_handle_at() generically and are unrelated to the changes here):
>   Jann pointed out that we should verify whether deleted files could
>   potentially be reopened through open_by_handle_at(). I don't think that's
>   possible though.

What do you mean with "deleted"?  If it is open but unlinked, yes open
by handle allows to get a referene to them.  If it is unlinked and
evicted open by handle should not allow to open it, but it's up to the
file systems to enforce this.

>  struct dentry *
>  exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
> -		       int fileid_type,
> +		       int fileid_type, bool directory,

This is a reall a only_directories flag, right?  Maybe spell that out,
and preferably do that as a flag in a flags paramter so that it also
is obvious in the callers, which a plain true/false is not.

> +struct handle_to_path_ctx {
> +	struct path root;
> +	enum handle_to_path_flags flags;
> +	bool directory;

This and the bool directory passed in a few places 

> +};
> +


> -	path->dentry = exportfs_decode_fh(path->mnt,
> +	path->dentry = exportfs_decode_fh_raw(mnt,

Given that plain exportfs_decode_fh calles are basically dying out
can we just kill it and move the errno gymnastics into the callers
instead of the exportfs_decode_fh vs exportfs_decode_fh_raw
confusion (I still don't understand what's raw about it..)

>  	if (!capable(CAP_DAC_READ_SEARCH)) {
> +		/*
> +		 * Allow relaxed permissions of file handles if the caller has
> +		 * the ability to mount the filesystem or create a bind-mount
> +		 * of the provided @mountdirfd.
> +		 *
> +		 * In both cases the caller may be able to get an unobstructed
> +		 * way to the encoded file handle. If the caller is only able
> +		 * to create a bind-mount we need to verify that there are no
> +		 * locked mounts on top of it that could prevent us from
> +		 * getting to the encoded file.
> +		 *
> +		 * In principle, locked mounts can prevent the caller from
> +		 * mounting the filesystem but that only applies to procfs and
> +		 * sysfs neither of which support decoding file handles.
> +		 *
> +		 * This is currently restricted to O_DIRECTORY to provide a
> +		 * deterministic API that avoids a confusing api in the face of
> +		 * disconnected non-dir dentries.
> +		 */
> +
>  		retval = -EPERM;
> -		goto out_err;
> +		if (!(o_flags & O_DIRECTORY))
> +			goto out_path;
> +
> +		if (ns_capable(ctx.root.mnt->mnt_sb->s_user_ns, CAP_SYS_ADMIN))
> +			ctx.flags = HANDLE_CHECK_PERMS;
> +		else if (ns_capable(real_mount(ctx.root.mnt)->mnt_ns->user_ns, CAP_SYS_ADMIN) &&
> +			   !has_locked_children(real_mount(ctx.root.mnt), ctx.root.dentry))
> +			ctx.flags = HANDLE_CHECK_PERMS | HANDLE_CHECK_SUBTREE;
> +		else
> +			goto out_path;
> +
> +		/* Are we able to override DAC permissions? */
> +		if (!ns_capable(current_user_ns(), CAP_DAC_READ_SEARCH))
> +			goto out_path;
> +
> +		ctx.directory = true;

Can you split this into a separate helper to keep it readable?

And maybe add a comment oon the real_mount because as-is I don't really
understand it at all.


