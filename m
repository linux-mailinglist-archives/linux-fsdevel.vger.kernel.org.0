Return-Path: <linux-fsdevel+bounces-36672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 958199E7902
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 20:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5000E2839A1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 19:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554841F37CA;
	Fri,  6 Dec 2024 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7oO9NCG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E3A192B76;
	Fri,  6 Dec 2024 19:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513656; cv=none; b=rYdYfvM2wFynKy/oSH8vIg7zPKE2nFyu7/947y2UYfrL8BlfNFKRBVdiURDr1UfoTLMpr+9fSunlWnSWF1j8KmM6aQkYd9LicHoMtpg4C1VGOuzA9OH+XWbKhwnSzHB7NmgOwyDmAAgD5zMA+jg/EmT2g9K+ID34PlsEDb9zQrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513656; c=relaxed/simple;
	bh=+XeUljgu13umHyxqlguqUcm6zdu0iI06RFYN5kAuhHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpW9fiJrz4nWvcORbRvkloD55K470YCym8cTVCjYO1Sdz5ijtaFNj3LeL+nEGWGv07ShfJnvh+7OpDL71iVeP+rvGHPlKT5q3AuMx3zEAPIpzAhu9A7mnHNcNROqhmxPIwMO5hgNTEixcpRrhZiMCNDmjv4VH04VFDHHQ3hvh30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7oO9NCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19986C4CED1;
	Fri,  6 Dec 2024 19:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733513656;
	bh=+XeUljgu13umHyxqlguqUcm6zdu0iI06RFYN5kAuhHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b7oO9NCG5aDddo9az8JKV/4KUm9Kf/ik6bquysJ8ykGBiUd+eOrkJxEAZfvR4aAZr
	 LgsfEms2WxjhCENOiaRmsFeuJrjgv50z/gMlYJ4reCo6JVQQfA2A1CZMAEpxs+I/q3
	 qNRkni66is1OLLtvjNFXpOHMLV1hGV+Ob5oUvflwAAK/K3XVW4QrqxPCCzGJpN/nD8
	 FafMbAtCjm4zoUFXW+4hublofr8fyp+I4Vmts7asLHDfxdru4wucl+1DWFwxzI5g5z
	 0ICx+Etd+Mc9N4ACYRMp/umPZT2A5Zn5ZyCjnYy5+MHA+sB2d8/lzvEp+4HnqUyoEK
	 VARb4QUzuqUWQ==
Date: Fri, 6 Dec 2024 11:34:14 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, patches@lists.linux.dev,
	fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [PATCH] common/config: use modprobe -w when supported
Message-ID: <Z1NRtmO5gQ8snFDe@bombadil.infradead.org>
References: <20241205002624.3420504-1-mcgrof@kernel.org>
 <0272e083-8915-407a-9d7f-0c1a253c32d7@redhat.com>
 <Z1IuphUjdnnRUWCg@bombadil.infradead.org>
 <14e3c1fd-4c16-4676-8f66-81558febc4dd@sandeen.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14e3c1fd-4c16-4676-8f66-81558febc4dd@sandeen.net>

On Fri, Dec 06, 2024 at 10:38:11AM -0600, Eric Sandeen wrote:
> On 12/5/24 4:52 PM, Luis Chamberlain wrote:
> > On Wed, Dec 04, 2024 at 10:35:45PM -0600, Eric Sandeen wrote:
> >> but that probably has more to do with the test not realizing
> >> /before it starts/ that the module cannot be removed and it
> >> should not even try.
> > 
> > Right.
> > 
> >> Darrick fixed that with:
> >>
> >> [PATCH 2/2] xfs/43[4-6]: implement impatient module reloading
> > 
> > Looks good to me.
> > 
> >> but it's starting to feel like a bit of a complex house of cards
> >> by now. We might need a more robust framework for determining whether
> >> a module is removable /at all/ before we decide to wait patiently
> >> for a thing that cannot ever happen?
> > 
> > I think the above is a good example of knowing userspace and knowing
> > that userspace may be doing something else and we're ok to fail.
> > Essentially, module removal is non-deterministic due to how finicky
> > and easy it is to bump the refcnt for arbitrary reasons which are
> > subsystem specific. The URLs in the commit log I added provide good
> > examples of this. It is up to each subsystem to ensure a proper
> > quiesce makes sense to ensure userspace won't do something stupid
> > later.
> > 
> > If one can control the test environment to quiesce first, then it
> > makes sense to patiently remove the module. Otherwise the optional
> > impatient removal makes sense.
> 
> Not to belabor the point too much, but my gut feeling is there are
> cases where "quiescing" is not the issue at all - if the module is
> in use on the system somewhere outside of xfstests, no amount of
> quiescing or waiting will make it removable.

Yes indeed, that is a good point. Only if the test suite has full
control to ensure the lifetime of the module could it rely on removal.
But there are holes in the assumptions which can be made even on this
front too. I'll explain below.

> Essentially, xfstests
> needs to figure out if it is the sole owner/user of a module before
> it tries to do any sort of waiting for removal, IMHO.

Even if it could do that, it can't prevent the user from poking around,
or for some userspace package to not be present which may proactively
poke around block devices of certain type for example. Such things
will break the assumptions that the test suite has full control.

Test runners, which do full bringup / setup / package installations
have more control for a more deterministic setup, fstests itself
however will have most control, but since this is about flaky tests
failing for stupid reasons, this is all about *improving* from a test
perspective consciosness over this problem and for the tester to make
more appropriate calls for what it thinks it can have control over.

  Luis

