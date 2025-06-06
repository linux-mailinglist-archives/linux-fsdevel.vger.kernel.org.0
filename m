Return-Path: <linux-fsdevel+bounces-50807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C206ACFC0F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 06:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2F0173BA5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 04:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1101DFD8B;
	Fri,  6 Jun 2025 04:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="u6wInBK/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8AC1C27
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 04:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749185687; cv=none; b=u4PAJhvTAyWjmFIn96ROhdPGRDO/pczNxFw/RkEFOFeiswWGxKDNuqPR6Ox8yymw87gDC6EwRqIVWm8MeqWyCIEVDyOTM7677CdMdavH6kdy/3Xq2jAqy/MSI6dsTPkfdMfLR7IijWMyjLCJgK9D2hrtzeOI0p5UBS24dOLnkrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749185687; c=relaxed/simple;
	bh=I/67Izeoqk/ajmpqTzUxOsCIFmEsmJctwjxPgXnUHUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8P63f0HGC4XaQMdDVP2q5lM0kER5w4674/M+SP3usf9IoX3JMQxPGcIocTlJEKdu8UCKe2lhHf7zUQ3ZbC0p+h/wvNKeF1m5HOrr4JlWeAz2gmaY/kkKrUsP5AgniClMKMAzKGzivX+450rgx9KEEAyQOu45seb8gNHrXbMqHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=u6wInBK/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dUkWrORO+o0fSkMzQRT6SvdJR2LvjgOhg1/ATju8QMo=; b=u6wInBK/lQvXCDblPC7PLItVCx
	w/z8Fk0iFK8SEmlfMu0oOSGGfSxgQCFupmy1eQQIzDgMSslI9hI/tV82O2A01mt6L2cuuYmVwS5BR
	A1IJ6gblVxKN9ou6BouofxYNZAnzUyrDcdRPo5cKpjsc7Y0BMv/+TUjESHgoiYEQCMkxK7MUSPSTf
	4KYD1Zn8aZtm/J6GBF129lhUwOY30f+/86enDW/2zCbv6aY8H0bWXaz2NF0XXENscr5+K6KK0fbt7
	3dHMuzSUtN2HkGeR1ItUij+G65jzfYTIo8MmtN+G9jHD+40jedDIs6bmUNhJMaqNwnj2o3AuW+Oi0
	GC/1AtcA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNP6H-0000000ByZR-1pfv;
	Fri, 06 Jun 2025 04:54:41 +0000
Date: Fri, 6 Jun 2025 05:54:41 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>, Allison Karlitskaya <lis@redhat.com>
Subject: Re: [PATCH 1/2] mount: fix detached mount regression
Message-ID: <20250606045441.GS299672@ZenIV>
References: <20250605-work-mount-regression-v1-0-60c89f4f4cf5@kernel.org>
 <20250605-work-mount-regression-v1-1-60c89f4f4cf5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605-work-mount-regression-v1-1-60c89f4f4cf5@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jun 05, 2025 at 02:50:53PM +0200, Christian Brauner wrote:
> When we disabled mount propagation into detached trees again this
> accidently broke mounting detached mount trees onto other detached mount
> trees. The mount_setattr_tests selftests fail and Allison reported it as
> well. Fix the regression.
> 
> Fixes: 3b5260d12b1f ("Don't propagate mounts into detached trees")
> Reported-by: Allison Karlitskaya <lis@redhat.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/namespace.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 2f2e93927f46..cc08eab031db 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3634,22 +3634,22 @@ static int do_move_mount(struct path *old_path,
>  	if (!(attached ? check_mnt(old) : is_anon_ns(ns)))
>  		goto out;
>  
> -	if (is_anon_ns(ns) && ns == p->mnt_ns) {
> -		/*
> -		 * Ending up with two files referring to the root of the
> -		 * same anonymous mount namespace would cause an error
> -		 * as this would mean trying to move the same mount
> -		 * twice into the mount tree which would be rejected
> -		 * later. But be explicit about it right here.
> -		 */
> +	/*
> +	 * Ending up with two files referring to the root of the
> +	 * as this would mean trying to move the same mount
> +	 * twice into the mount tree which would be rejected
> +	 * later. But be explicit about it right here.
> +	 */
> +	if (is_anon_ns(ns) && ns == p->mnt_ns)
>  		goto out;
> -	} else if (is_anon_ns(p->mnt_ns)) {
> -		/*
> -		 * Don't allow moving an attached mount tree to an
> -		 * anonymous mount tree.
> -		 */
> +
> +	/*
> +	 * Don't allow moving an attached mount tree to an
> +	 * anonymous mount tree.
> +	 */
> +	if (!is_anon_ns(ns) && is_anon_ns(p->mnt_ns))
>  		goto out;

UGH...

This is much too convoluted.  How about this:

        /* The thing moved must be mounted... */
	if (!is_mounted(&old->mnt))
		goto out;

	/* ... and either ours or the root of anon namespace */
	if (check_mnt(old)) {
		/* should be detachable from parent */
		if (!mnt_has_parent(old) || IS_MNT_LOCKED(old))
			goto out;
		/* target should be ours */
		if (!check_mount(p))
			goto out;
	} else {
		if (!is_anon_ns(ns) || mnt_has_parent(old))
			goto out;
		/* not into the same anon ns - bail early in that case */
		if (p->mnt_ns == ns)
			goto out;
		/* target should be ours or in an acceptable anon */
		if (!may_use_mount(p))
			goto out;
	}

Would that work for all cases?

