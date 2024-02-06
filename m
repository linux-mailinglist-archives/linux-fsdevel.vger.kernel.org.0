Return-Path: <linux-fsdevel+bounces-10494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F389984BA29
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 16:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C341C24394
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 15:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C230D134747;
	Tue,  6 Feb 2024 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pct5Mhdc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3E2133404;
	Tue,  6 Feb 2024 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707234833; cv=none; b=okgFNJadfPzHl6FAz0Xa6TBNC91C983yhPgJ7i7le8RgjM9kPhSoCpOEDd6BXQpPXxWUrenc1ZpMaY5A1e5pBs4mSYfEkp4gWFgEKlFQEHDuT48/8utoDGxufSRmFBDqf9cXQ/5MyZQ3bB3NXW6TtV9X9JVdUZSU0uRI6tM+9gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707234833; c=relaxed/simple;
	bh=KWVPbxpiVimSom6U4FTCRDp7dNBNtmzt2ba14XgYyZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TT+udUq9av0qODjHuEuCH/AIJz18AwlHKX9/I1I/1qcpP1LdEQonwDUWz7BsgsNNnSlAsklQpI3TNTSZE6x0a60MZhVuxVwtJ1CVOofG8Cn04fafXTJbJKdA2WiZTG0AHGI+kjCo9ul3IhiO4crzcbtu2K+03u6jwAc227UVPv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pct5Mhdc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B16C433C7;
	Tue,  6 Feb 2024 15:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707234832;
	bh=KWVPbxpiVimSom6U4FTCRDp7dNBNtmzt2ba14XgYyZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pct5MhdcYimMGSl6Lf0KApR/SqK8z7ABOVTWvwtaPrtbaBd41xBI5sD3IGMtAbUAv
	 uxrEZBdMvdX3MXGxZ8jNZcYnew1MtxzKSfn0BEWQZAN+ITfuwBZJMxB+RWxctQdFGj
	 3a1rwYDnYDi08C2ZH1BX6KMbbV0ZSvhcE+s8pPRVmweSei8SNEO/tGkZSrVkvqBF0c
	 nRM9oTSaavTtVHq297qbsSJ9Js2NDCalnp3tk0dDWAcARYV2Che6z8A+zWXh414439
	 n841fjjdgkzIm8s11NjXdcbhFAtYkfCf0EkyE3N5PBCdKhKCCW/VfqdQNhaiu4GwmP
	 +AGMp01V3RI9g==
Date: Tue, 6 Feb 2024 16:53:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Jan Kara <jack@suse.cz>, linux-block <linux-block@vger.kernel.org>, 
	Linux-Next Mailing List <linux-next@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>, linux-fsdevel@vger.kernel.org, lkft-triage@lists.linaro.org, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Anders Roxell <anders.roxell@linaro.org>
Subject: Re: next: /dev/root: Can't open blockdev
Message-ID: <20240206-haarpracht-teehaus-8c3d56b411ea@brauner>
References: <CA+G9fYttTwsbFuVq10igbSvP5xC6bf_XijM=mpUqrJV=uvUirQ@mail.gmail.com>
 <20240206101529.orwe3ofwwcaghqvz@quack3>
 <CA+G9fYup=QzTAhV2Bh_p8tujUGYNzGYKBHXkcW7jhhG6QFUo_g@mail.gmail.com>
 <20240206122857.svm2ptz2hsvk4sco@quack3>
 <CA+G9fYvKfeRHfY3d_Df+9V+4tE_ZcvMGVJ-acewmgfjxb1qtpg@mail.gmail.com>
 <20240206-ahnen-abnahmen-73999e173927@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240206-ahnen-abnahmen-73999e173927@brauner>

> On it.

Ok, can you try:
git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.super.debug
please?

