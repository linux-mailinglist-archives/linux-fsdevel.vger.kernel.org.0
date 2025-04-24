Return-Path: <linux-fsdevel+bounces-47211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96564A9A72F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 10:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DCD7921DBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 08:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4B120102B;
	Thu, 24 Apr 2025 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2Vp0YuS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BE820A5C4
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 08:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745485007; cv=none; b=d01VtapiUZSnZ3TQmzX62kOnQhk1tmxR3MLp1iB6KQKckVk4Xcu2x1BafDHP1H7jURjRh6y3ceeNEAWrkdjPtodR7VXO7x/vA8LT8jY8Y1RT/y41r8DP2irDki3eAIdhTCLBdYYQ3Rk+BIczioz3qapiXVKxP9hXEXvZurNgLoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745485007; c=relaxed/simple;
	bh=RiscfL7W8wGdv2JeNkZYvlk90g6Q2YY47fwYc+lnxWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QU2Yj+pAxgGyE928VaEZ+rVb3GwZQs3SENCXUOVfeB6QjKOo3pmQlM+97MsHC6Qpe+Qr8i7yrwWOFTC3LnrNfsn10IS+NJKpM2HnWME0Hm5sYS/cJCNjmuWqCT1qOU/CbMD6/JRoNw2edQDTN7dI4Aw1WDtZo6UC5K7Qx98gIcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2Vp0YuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC5BC4CEEB;
	Thu, 24 Apr 2025 08:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745485006;
	bh=RiscfL7W8wGdv2JeNkZYvlk90g6Q2YY47fwYc+lnxWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e2Vp0YuSiXcJF0ki+0NBG5PkQDanIrQhp1ueh2hbHXlEw7/QGuUznaWUlxtBrfZ0h
	 HXoDXXBbVOdy3SyqoTZDv2wcmjysZ6QELddut7Yfhsjh2G/LjNfS96cNvJmTVDQpP+
	 q39oMr7xMHvg4CTv8Sm0DuXZeSSpOR5Hec4DLmQT411x8KykOjIPOWnwYgto84jKJE
	 DSQySwf+VG+jEkllI5FSpTFRS2Ds6raCwMnOt+7+FwGl991A2xnLuANncaMXoNkQY3
	 ev9Hr09ytGvdSF0pV1G9e4+l7zpgRDDOhnz2B/uKVd5bmO4r/+5wtHJU36EF0pd52N
	 qKOZ3qsD9+mfg==
Date: Thu, 24 Apr 2025 10:56:43 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][RFC] ->mnt_devname is never NULL
Message-ID: <20250424-poren-lauffeuer-93a7ef365f47@brauner>
References: <20250421033509.GV2023217@ZenIV>
 <20250421-annehmbar-fotoband-eb32f31f6124@brauner>
 <20250421162947.GW2023217@ZenIV>
 <20250423222045.GF2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250423222045.GF2023217@ZenIV>

On Wed, Apr 23, 2025 at 11:20:45PM +0100, Al Viro wrote:
> On Mon, Apr 21, 2025 at 05:29:47PM +0100, Al Viro wrote:
> > On Mon, Apr 21, 2025 at 09:56:20AM +0200, Christian Brauner wrote:
> > > On Mon, Apr 21, 2025 at 04:35:09AM +0100, Al Viro wrote:
> > > > Not since 8f2918898eb5 "new helpers: vfs_create_mount(), fc_mount()"
> > > > back in 2018.  Get rid of the dead checks...
> > > >     
> > > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > > ---
> > > 
> > > Good idea. Fwiw, I've put this into vfs-6.16.mount with some other minor
> > > stuff. If you're keeping it yourself let me know.
> > 
> > Not sure...  I'm going through documenting the struct mount lifecycle/locking/etc.
> > and it already looks like there will be more patches, but then some are going
> > to be #fixes fodder.
> 
> BTW, could you explain what this is about?
>         /*
>          * If this is an attached mount make sure it's located in the callers
>          * mount namespace. If it's not don't let the caller interact with it.
>          *
>          * If this mount doesn't have a parent it's most often simply a
>          * detached mount with an anonymous mount namespace. IOW, something
>          * that's simply not attached yet. But there are apparently also users
>          * that do change mount properties on the rootfs itself. That obviously
>          * neither has a parent nor is it a detached mount so we cannot
>          * unconditionally check for detached mounts.
>          */
>         if ((mnt_has_parent(mnt) || !is_anon_ns(mnt->mnt_ns)) && !check_mnt(mnt))
>                 goto out;
> 
> Why do you care about mnt_has_parent() here?  mnt is the root of subtree you
> are operating on, so that condition means
> 	* any subtree (including the entire tree) of caller's mount tree is OK
> (fair enough)
> 	* full mount tree of anon namespace is OK
> 	* nothing else is acceptable
> What about partial subtrees of anon namespaces?  Restriction looks odd...

No one has ever cared about that ever so far so I specifically only
allowed the root of an anonymous mount namespace and this also keeps it
in line with other calls. I'm not against opening that up if this is a
use-case but so far we haven't had anyone care about mount properties in
detached mount subtrees.

