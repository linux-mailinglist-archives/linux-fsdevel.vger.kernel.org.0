Return-Path: <linux-fsdevel+bounces-20368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C926C8D22EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 20:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13071C22EBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 18:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55875481DD;
	Tue, 28 May 2024 18:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="u5KdfSxa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795CC31A89;
	Tue, 28 May 2024 18:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716919435; cv=none; b=EUq6VYFHy1+a6oy7o09Atv2vEOuTPUUQ0kOLa4Gie8kSRU7OVdtOwx07emeX+8L5d7iclH374IimXZWBU6/pE7Bewao06v27gLrp0KwAqCOY77s2hE9vxeqPqdKvPnbZll+4dHpm4GrgrQ0aVMJn8aLRrQ1WD3oI6uIqUL5Ly1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716919435; c=relaxed/simple;
	bh=/j1IUjr35lFJqMmnOuoDoQFcoTuliNZna5PrE9w03YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzbAyUvp2jrk2Zy7gkztAehiiiiQHPgqGJST3S1AUw8aSelhNYqCn5ky6lGV0vJCafHe2oocJ/40vrflIBNH9vXJKVcqFJ8svQ/mjQGY0JF+Ltef79O4ZWOWql2L7DG0jpQnF1lrXFhCgDGgdxmuQiDy/KSX988Dxrr7Rg1CAzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=u5KdfSxa; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PQA5T3SuEDuXN0oaw3uvLJ8JZyZw0rtYCLSIm8NIRPc=; b=u5KdfSxa4k6ljBqG3fGTcMGRGu
	HN+tG+VleU9vWJMJsAsYGG8/1kN/n2NFvVprfYtDvC32WaItYAT5vYlclWk4k4zA0cKAK6UvIORJ0
	B2fdm/zsCk3cz91zf/R7ffPZJMYMbFXyzDl68Hq6MBVZzHGXovquugPH2Sr8namfxaSR/LoJQ4Nvk
	cHXPtuIQyuPMXpN0fBTUhfN535/Yn/10pfGvxW+9MpKGXrYul9+u2gWBlshmh7NhydDwptbNfpe0y
	oMFyp8z0HsrljZeYpGQRS0R5KxouQFhtuxeM4Xk48DgAtJt3jAj7nAot15iUp4AEDDvYcPrhnQcBD
	5TYyP7Rw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sC1Ao-000u1L-0I;
	Tue, 28 May 2024 18:03:46 +0000
Date: Tue, 28 May 2024 19:03:46 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, linux-fsdevel@vger.kernel.org,
	autofs@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] fs: autofs: add MODULE_DESCRIPTION()
Message-ID: <20240528180346.GG2118490@ZenIV>
References: <20240527-md-fs-autofs-v1-1-e06db1951bd1@quicinc.com>
 <20240528-ausnimmt-leise-4feb91054db2@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528-ausnimmt-leise-4feb91054db2@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 28, 2024 at 01:39:03PM +0200, Christian Brauner wrote:
> On Mon, 27 May 2024 12:22:16 -0700, Jeff Johnson wrote:
> > Fix the 'make W=1' warning:
> > WARNING: modpost: missing MODULE_DESCRIPTION() in fs/autofs/autofs4.o
> > 
> > 
> 
> Applied to the v6.10-rc1 branch of the vfs/vfs.git tree.
> Patches in the v6.10-rc1 branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: v6.10-rc1

*Ugh*

Free advice: avoid mixing tag and branch names.  git tries to do the
right thing when it runs into ambiguities, but it's really asking for
headache.

