Return-Path: <linux-fsdevel+bounces-50810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02712ACFC23
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 07:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42B067A92A2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 05:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABBB1E0DFE;
	Fri,  6 Jun 2025 05:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="C1rf+Cn1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAC586347
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 05:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749186872; cv=none; b=WxdvIXzmJhwn32ohvrRgffN6jxN18K5Y8db9wWAQ0i2QxFDycjh2VBoOUU0Hd5tym7SPOJd0TP44qKUwlYJgLGQnNrsjpS5/Dnve49YZIIrlmLoq8WgyE/Kk7cKDg2DwLICtEyppWHAkZS57VOCsz7/BJAtLEayRoE+t39TJUlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749186872; c=relaxed/simple;
	bh=nOXMIRP4o2SBHK5T+tez1WyyLHvtuPSwGTvl1lnXLDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjnE7bhhHJN2gfcN+mAJwanVCCcOewC3Gv1ApvKS1fMr4YXiAKUMdjo91f2MUGmsoxFKM9Cn44ybSg5s7T+KCadvzo1l43SJu2ZHcJHo72aIVt0kMgbPjNE7n3DBz1BWHLKNmymd+dL9WvwCuinsqAlilSEeVCdBF2I269uOVBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=C1rf+Cn1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YJEZu/rXldmUnOx+ZMuuYTBaQ1dGeItNCZr0iAWFTKw=; b=C1rf+Cn15DKyfGRccZR7YRMbqM
	jlaiHB1nCPBXYYqc2vkXHoX5nvEY/iYaCU0en3dZ3tp5M7kPMkxG1bq1ALGBxPdBC8ACVqZpSJMEz
	efho1vpFs4K4nES/q3X1ajDEqdSAyRu0WfD4yvr2jFv6njoZDxZt6DzZsaUassQzjyCHd76h10WIZ
	Zo/kwSXcyG40rq8yhoDdEoiSxZ0di2vSWvLbYTV4YI9o4Y/rfQLyN0KbXDP1gV7AFYqy6wVbp/sJy
	EYwzSYHetmHXsxUT3YSP3D0wMrNYk7mk1qtijrPl5MLflB8U/6RvXVJ73TTIPaxSk4V5wJnI+P8yl
	3/YOwS8Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNPPQ-0000000C9ul-31AU;
	Fri, 06 Jun 2025 05:14:28 +0000
Date: Fri, 6 Jun 2025 06:14:28 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>, Allison Karlitskaya <lis@redhat.com>
Subject: Re: [PATCH 1/2] mount: fix detached mount regression
Message-ID: <20250606051428.GT299672@ZenIV>
References: <20250605-work-mount-regression-v1-0-60c89f4f4cf5@kernel.org>
 <20250605-work-mount-regression-v1-1-60c89f4f4cf5@kernel.org>
 <20250606045441.GS299672@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606045441.GS299672@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jun 06, 2025 at 05:54:41AM +0100, Al Viro wrote:
> UGH...
> 
> This is much too convoluted.  How about this:
> 
>         /* The thing moved must be mounted... */
> 	if (!is_mounted(&old->mnt))
> 		goto out;
> 
> 	/* ... and either ours or the root of anon namespace */
> 	if (check_mnt(old)) {
> 		/* should be detachable from parent */
> 		if (!mnt_has_parent(old) || IS_MNT_LOCKED(old))
> 			goto out;
> 		/* target should be ours */
> 		if (!check_mount(p))

		     check_mnt, obviously

> 			goto out;
> 	} else {
> 		if (!is_anon_ns(ns) || mnt_has_parent(old))
> 			goto out;
> 		/* not into the same anon ns - bail early in that case */
> 		if (p->mnt_ns == ns)
> 			goto out;
> 		/* target should be ours or in an acceptable anon */
> 		if (!may_use_mount(p))
> 			goto out;
> 	}
> 
> Would that work for all cases?

The thing is, the real split is not on "has parent"; it's "is the
source in our namespace".

	If it is, we must
* have 'attached' to be true (check_mnt() is incompatible with is_anon_ns())
IOW, mnt_has_parent(old) should be true.
* have no MNT_LOCKED on the source (we check it later, and it really belongs
here - we do *not* want to check it in move-from-anon case, since there we
accept only root and we never have MNT_LOCKED on the roots of anon namespaces
* have the target to be not in anon namespace.  Which, combined with may_use_mount(p)
means that it should be in *our* namespace, so simply check_mnt(p).  And that
subsumes may_use_mount(p), so no need to check it earlier.
* check for is_anon_ns(ns) && ns == p->mnt_ns obviously does not apply.

	Otherwise, we know that 'attached' must be false and is_anon_ns(ns) - true.
Which means that we want the root of anon namespace.
* check for is_anon_ns(ns) && ns == p->mnt_ns turns into simply p->mnt_ns == ns
* check for target not being in anon namespace should be removed in this case -
that's the fix we are after.
* check for may_use_mount() is needed in this case.
* check for MNT_LOCKED is not needed afterwards - again, it's never set on the
root of anon

So everything prior to checking path_mounted() should be covered by the variant
above, and IMO it's easier to follow in that form - restrictions in 'move a
subtree of our namespace' and 'move the entire contents of anon namespace' are
rather different.  Better keep them textually separate...

