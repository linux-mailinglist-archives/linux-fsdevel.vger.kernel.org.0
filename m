Return-Path: <linux-fsdevel+bounces-49003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2E6AB74FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 21:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02AC84C7CBE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 19:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305D528CF53;
	Wed, 14 May 2025 19:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jPoHdPPb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D76527FD7F;
	Wed, 14 May 2025 19:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747249379; cv=none; b=QG9/vReSHHY8518EbRp4AKNKuNlxTcUz9w+b+v5pDpPBvY54qjFaX0kwq56nzV53/0PQDIxRWvGc9FaVqZ7ABpXpVSrfbioV+5ZtyqcpRNT6hnkclFo1bgHGmwDqwjDubztFHV9pMuwpFI70Mq6juZZ2EDuvzqpKp4vkS5s7H3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747249379; c=relaxed/simple;
	bh=e1kFLsWsjOgJNn0ezdU4lHTQcKMPos7678Em5zA6uZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFD4Kcgeiru6ruQUkH3YkGJdURrOdKLJqJ6IpBH3Ye3Ac932M4aLEeF0+JWnYWUdV4PqZt6d0hvL2uH2jHS/tBLJ1elSSh/kuT2dIhgzoxSr/LtGADEkzelNeKgPbtRgGCsN12wbW+mAM3/YE74EpW5IISwpF3DycwAo9r8pRBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jPoHdPPb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=EyvoC+BoMEsog5EnsZn8ty0g3sydlFdjmKsZ32Oi8qA=; b=jPoHdPPb17iVxQDAHmtYTav7SL
	3FIUTzpMnR+8YNwwfMlKzvDvPqYbrVcOe8tSg7P70o90fSUSIjTmjXxeou0KuBvXIB0qZN6YA9102
	tNio0liHEWdI7FHlKvIZXCcDgeIyTJr5Tm41WMZXqmgw+mNj5O+7lH/JHZ74RVrVpWOldnz6DyH8H
	Aq65Hf9a/b3eoRU8LfP0GjL5lwRdvujKUPTrXqxECOERz6nr+fLbYUxCNvueVBvByCnn9FKdKY0Yr
	PcKUZXCbiBTCc0CNrpZmxJSVg8UjhFeaVXsfrhqYSrBnuJYNEvBO5zOjs5PVCoUsCW7yY93nDxFic
	yPr1L6Mw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFHNU-00000009eB1-43Nw;
	Wed, 14 May 2025 19:02:53 +0000
Date: Wed, 14 May 2025 20:02:52 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: KONDO =?utf-8?B?S0FaVU1BKOi/keiXpOOAgOWSjOecnyk=?= <kazuma-kondo@nec.com>
Cc: "brauner@kernel.org" <brauner@kernel.org>,
	"jack@suse.cz" <jack@suse.cz>,
	"mike@mbaynton.com" <mike@mbaynton.com>,
	"miklos@szeredi.hu" <miklos@szeredi.hu>,
	"amir73il@gmail.com" <amir73il@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: allow clone_private_mount() for a path on real rootfs
Message-ID: <20250514190252.GQ2023217@ZenIV>
References: <20250514002650.118278-1-kazuma-kondo@nec.com>
 <20250514024342.GL2023217@ZenIV>
 <9138a96b-3df0-455a-9059-287a98356c4c@nec.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9138a96b-3df0-455a-9059-287a98356c4c@nec.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, May 14, 2025 at 08:37:54AM +0000, KONDO KAZUMA(近藤 和真) wrote:
> On 2025/05/14 11:43, Al Viro wrote:
> > On Wed, May 14, 2025 at 12:25:58AM +0000, KONDO KAZUMA(近藤 和真) wrote:
> > 
> >> @@ -2482,17 +2482,13 @@ struct vfsmount *clone_private_mount(const struct path *path)
> >>  	if (IS_MNT_UNBINDABLE(old_mnt))
> >>  		return ERR_PTR(-EINVAL);
> >>  
> >> -	if (mnt_has_parent(old_mnt)) {
> >> +	if (!is_mounted(&old_mnt->mnt))
> >> +		return ERR_PTR(-EINVAL);
> >> +
> >> +	if (mnt_has_parent(old_mnt) || !is_anon_ns(old_mnt->mnt_ns)) {
> >>  		if (!check_mnt(old_mnt))
> >>  			return ERR_PTR(-EINVAL);
> >>  	} else {
> >> -		if (!is_mounted(&old_mnt->mnt))
> >> -			return ERR_PTR(-EINVAL);
> >> -
> >> -		/* Make sure this isn't something purely kernel internal. */
> >> -		if (!is_anon_ns(old_mnt->mnt_ns))
> >> -			return ERR_PTR(-EINVAL);
> >> -
> >>  		/* Make sure we don't create mount namespace loops. */
> >>  		if (!check_for_nsfs_mounts(old_mnt))
> >>  			return ERR_PTR(-EINVAL);
> > 
> > Not the right way to do that.  What we want is
> > 
> > 	/* ours are always fine */
> > 	if (!check_mnt(old_mnt)) {
> > 		/* they'd better be mounted _somewhere */
> > 		if (!is_mounted(old_mnt))
> > 			return -EINVAL;
> > 		/* no other real namespaces; only anon */
> > 		if (!is_anon_ns(old_mnt->mnt_ns))
> > 			return -EINVAL;
> > 		/* ... and root of that anon */
> > 		if (mnt_has_parent(old_mnt))
> > 			return -EINVAL;
> > 		/* Make sure we don't create mount namespace loops. */
> > 		if (!check_for_nsfs_mounts(old_mnt))
> > 			return ERR_PTR(-EINVAL);
> > 	}
> 
> Hello Al Viro,
> 
> Thank you for your comment.
> That code can solve my problem, and it seems to be better!

BTW, see https://lore.kernel.org/all/20250506194849.GT2023217@ZenIV/ for
discussion about a week ago when that got noticed:

|| In case of clone_private_mount(), though, there's nothing wrong
|| with "clone me a subtree of absolute root", so it has to be
|| done other way round - check if it's ours first, then in "not
|| ours" case check that it's a root of anon namespace.
||
|| Failing btrfs mount has ended up with upper layer pathname
|| pointing to initramfs directory where btrfs would've been
|| mounted, which had walked into that corner case.  In your
|| case the problem has already happened by that point, but on
|| a setup a-la X Terminal it would cause trouble...

Looks like such setups are less theoretical than I thought.

> So, I will revise my patch and resend it.

Probably worth gathering the comments in one place.  Something like
	/*
	 * Check if the source is acceptable; anything mounted in
	 * our namespace is fine, otherwise it must be the root of
	 * some anon namespace and we need to make sure no namespace
	 * loops get created.
	 */
	if (!check_mnt(old_mnt)) {
		if (!is_mounted(&old_mnt->mnt) ||
		    !is_anon_ns(old_mnt->mnt_ns) ||
		    mnt_has_parent(old_mnt))
			return ERR_PTR(-EINVAL);
		if (!check_for_nsfs_mounts(old_mnt))
			return ERR_PTR(-EINVAL);
	}
might be easier to follow.

