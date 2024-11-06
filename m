Return-Path: <linux-fsdevel+bounces-33736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F469BE43C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 11:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06C31F234E8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 10:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AC31DDC36;
	Wed,  6 Nov 2024 10:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCL5kK/u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A9A18FDA5
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Nov 2024 10:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730888827; cv=none; b=Pn+h4/ynEvzds9s60pODg1P+6pUyekqVoDwmuS5ONzxT/WTFmPYuhDXAcGgFOBXqGcl8NGL4/pMteVGQ5tgthi+wwEoTXAnPxUS5hSZw5JTQOHutOp7UD52bD5RyMEtb6R7GR3JdGEkaT7PRzAhYxew3G4AHJ0iVeN3Dsmfavjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730888827; c=relaxed/simple;
	bh=wDi00bt1rxgRuSZmKwgJelSXFFvyoXDE8r3bnI7g4No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noKrSOwHjkrPjRuJzwnsUrz714B5TZTn2X6ZypOK3Eb9E3ejiagW489J2gIIAOdM4JZvw0AgwqgHdMCqwOZIHAebG7iIznP3/fZ6rD9KqxtTGTZ6+Ro+tCk76PIEe4R9po5KUeZeMuJFUo8KGhaFMZRdt28x4U+fxVgwg/iwDhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCL5kK/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7C3C4CECD;
	Wed,  6 Nov 2024 10:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730888827;
	bh=wDi00bt1rxgRuSZmKwgJelSXFFvyoXDE8r3bnI7g4No=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iCL5kK/uvg3p/O0DyefGeiySkA2xoVJ2dZmPhEXIfpkoF+r0zZysM5Vs84L1CRUE3
	 j24BA8+9pRTiBeLB9ygkHtKU8IlDiL7NGhqtDJEfH2MiSKFMWZbnIQc+BwCR7L3Dav
	 1TVdjtDHvzoIJwXsH/oHlPLomK3Wjnco9VJd5mZVlQQ/+ciR6b75bCyMMrmYUHIXUX
	 eeBh9lTI88K+xm0kpNrKXRO3bWjXhVLqf2NM80BI9pw1CwKGpTTmDGMioTBT9YtRoq
	 g9t3NFZD1EnagIX9CQeluKtZBqjhotd9z335QsvLXpZnWqiVMrT+GA4ow+2PjvGW7/
	 gEWbXuD1mnN2A==
Date: Wed, 6 Nov 2024 11:27:03 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Stefan Berger <stefanb@linux.ibm.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [WTF?] AT_GETATTR_NOSEC checks
Message-ID: <20241106-besprach-bewandern-b2b4b2534a63@brauner>
References: <20241101011724.GN1350452@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241101011724.GN1350452@ZenIV>

On Fri, Nov 01, 2024 at 01:17:24AM +0000, Al Viro wrote:
> 	AFAICS, since the moment it had been introduced it got passed
> to *ALL* ->getattr() calls.  Unconditionally.  So why are we checking
> it in ecryptfs and overlayfs instances?
> 
> Look: all direct calls of instances are from other instances, with
> query_flags passed unchanged.  There is only one call via method -
> that in vfs_getattr_nosec(), but that caller explicitly adds
> AT_GETATTR_NOSEC to query_flags.
> 
> So what the hell are the checks in ecryptfs and overlayfs for?
> What am I missing here?  What would break if we did the following:

Sounds good. I'm confused why that's a WTF moment though.

Anyway, I'm just slowly getting back to the fray. I caught atypical
pneumonia and that has been going on for a few weeks now. So my replies
are delayed.

