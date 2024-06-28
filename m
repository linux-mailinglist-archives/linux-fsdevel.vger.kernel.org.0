Return-Path: <linux-fsdevel+bounces-22743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223A091BA33
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 10:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B55C6B24E38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 08:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4E614EC4D;
	Fri, 28 Jun 2024 08:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anDmr6k0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBC714D43E
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719563843; cv=none; b=svT8KNcZJDkJo4oaGoA9vfxoA8PmyYABpX2zHj1sHpSBjQgVntsLb4ZpMylUfJqhkCooqjiAb9uikNaAVS+NObk0ngp4f2cAbOs8R7H5pXpT+CosAv8Lk+5sUr9heinH4me7a+9OWrlrpPNTzJ6qhY45rxThy6CQhbOcWLNaGN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719563843; c=relaxed/simple;
	bh=+tMHy1F5UASmZJXF+8oFs7YsYVHLN55xClKbm9Yexhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0PrCLEfTyLHDol862oMEosHtiIapYrrGhnW0Hw5R5xQ60oF1Ik1JT7M5Kco6x1w2N/eIk6wvYMABUVuk5SuwIfEgqBlCZZWkI01HN77TIKB8K4sGBURI6eGweq9RHlpo1girxrwVucKgtCLyCfGAJXkYQMnaC57KAHnPzPh4+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anDmr6k0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D44C2BD10;
	Fri, 28 Jun 2024 08:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719563843;
	bh=+tMHy1F5UASmZJXF+8oFs7YsYVHLN55xClKbm9Yexhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=anDmr6k0oQmGtP1eveVNGgLSCZxMHfrShu+0cKdgG+psVl6tsQAKXpzZTaWxPdKt4
	 ufGMvPCOUiQXPfsK/8ah0cUbaGjQTJx9GerZCcOre1jWgClgOUe0x1tq/jMt2Wvj0u
	 NkS/D2OEHOU9OYeGCeaC5I3vizL8/Ada8bgNOTTLzw1Udfha9G0AhV6dSQXS4dG9gL
	 bkdz+dVPmS4b24H4hLLiZYz/024xHUYTHqji3Hd/hYU40tb5el2D98CzOtmB1KPs6J
	 Hcp4gxAgt7M7JO47Zoj1httjkQWqNxLsEt4GrXh9ttDE7QDDsDhdqxOB1Ssbb1ugwC
	 EnLxDqiSPEksw==
Date: Fri, 28 Jun 2024 10:37:18 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Stephane Graber <stgraber@stgraber.org>, Jeff Layton <jlayton@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [PATCH RFC 1/4] file: add take_fd() cleanup helper
Message-ID: <20240628-abfragen-inbetriebnahme-c6b35e3bcb17@brauner>
References: <20240627-work-pidfs-v1-0-7e9ab6cc3bb1@kernel.org>
 <20240627-work-pidfs-v1-1-7e9ab6cc3bb1@kernel.org>
 <20240627172448.GA4050905@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240627172448.GA4050905@perftesting>

On Thu, Jun 27, 2024 at 01:24:48PM GMT, Josef Bacik wrote:
> On Thu, Jun 27, 2024 at 04:11:39PM +0200, Christian Brauner wrote:
> > Add a helper that returns the file descriptor and ensures that the old
> > variable contains a negative value. This makes it easy to rely on
> > CLASS(get_unused_fd).
> > 
> 
> Can we get an extra bit of explanation here, because I had to go read a bunch of
> code to figure out what exactly was happening here.  Something like
> 
> This makes it easy to rely on CLASS(get_unused_fd) for success, as the fd will
> be returned and the cleanup will not occur.

Yes, absolutely.

