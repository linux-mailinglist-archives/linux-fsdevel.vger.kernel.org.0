Return-Path: <linux-fsdevel+bounces-59044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DC4B34005
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BC1A4E01DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F263F1E521B;
	Mon, 25 Aug 2025 12:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7rf8VXS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4001C6B4
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126195; cv=none; b=XE6RMURpVa38bIN4fsEZghlj0Si2t/L/qO8hqK/gvr7IIk2czAxFWX6FFQuFKCCQCkqLnMtguVw9GK0aOiMPqKKBngAbwpbmWJTTeK1VLA30YrI8X3j/gxfXFCRpSAciANOsRLSEhOH+mS6sjHzmiv2seAtcYTTZnpPprmWxdyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126195; c=relaxed/simple;
	bh=oRY8IWgozkZCR/Z67qwwcfGXzMwWRJ1t/Ybx/f8sKD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exhkq7aRaHL1UuqynBYP3tyIcXdaoCFPk+Po9q3ozmlOvs8wlx5Trf8YqFA0axmY6n4uUj4BQsUwZpm/Yrmrretf/pfl3wfrsmvHFkgkngLXZw0UgCqo3xlql2dXDaYvUWeelVa0TEnvAWxZ1ZFE6HkVyQco7CCEzcs89DlEjpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7rf8VXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CA2C116D0;
	Mon, 25 Aug 2025 12:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756126194;
	bh=oRY8IWgozkZCR/Z67qwwcfGXzMwWRJ1t/Ybx/f8sKD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W7rf8VXSSMNHkRHyMGtkPnJ1CpIj9rUm06QP9xQ8v7w/HRKF4rTYyCH42LnCLWRqU
	 Nu/sTU5YF/0fr6zKcN1p9KPxb3RIRfSdC5CuwBe+Ua4MtXS1m6lFHoF/y2SwbxzcLt
	 7gId++Sq/fg9bzlu0PkWtJQLXHRnJtpdMKvG4seDyl1rluRedY82fs2ijOfyD5S9SN
	 0OI5T3ZAJmLC+hvgWPeKefgABrlE1qEdnjBLoo0NeMp80qf4OMtrZCIMVXR9NHqko9
	 hNP3VESfFPYxsJSjeXBu0cqD0aR+l492FQkwSlRdtNH/NkC9Hz6EjfZ32kCBaEEAfg
	 csvl0c7X21zQA==
Date: Mon, 25 Aug 2025 14:49:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 13/52] has_locked_children(): use guards
Message-ID: <20250825-aufbau-annimmt-169522e5df40@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-13-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-13-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:16AM +0100, Al Viro wrote:
> ... and document the locking requirements of __has_locked_children()
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/namespace.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 59948cbf9c47..eabb0d996c6a 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2373,6 +2373,7 @@ void dissolve_on_fput(struct vfsmount *mnt)
>  	}
>  }
>  
> +/* locks: namespace_shared && pinned(mnt) || mount_locked_reader */
>  static bool __has_locked_children(struct mount *mnt, struct dentry *dentry)
>  {
>  	struct mount *child;
> @@ -2389,12 +2390,8 @@ static bool __has_locked_children(struct mount *mnt, struct dentry *dentry)
>  
>  bool has_locked_children(struct mount *mnt, struct dentry *dentry)
>  {
> -	bool res;
> -
> -	read_seqlock_excl(&mount_lock);
> -	res = __has_locked_children(mnt, dentry);
> -	read_sequnlock_excl(&mount_lock);
> -	return res;
> +	scoped_guard(mount_locked_reader)
> +		return __has_locked_children(mnt, dentry);

Agree with Linus, this should just use a plain guard().

