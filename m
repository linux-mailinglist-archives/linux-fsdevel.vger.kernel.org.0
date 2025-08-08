Return-Path: <linux-fsdevel+bounces-57121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245BAB1EEA6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 21:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF10B5A2C4C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 19:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8DF21CFEF;
	Fri,  8 Aug 2025 19:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b="nc59GdLP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YzzovIUn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A433FE4
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 19:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754679721; cv=none; b=UQD9NayIiKmNBQiG44SdESKMH0Q71YCDFMbntSJey62E5qRSIgXbdj7fEIeXMMLaPkX0++G+hly2MoBhPMU1RvMUQGWYsYqJn2LlRDis7RRD/f0OIUOvQcYRiu6tY9R+mEj9RGRkwQjdoAfXPyz/Pdwt8a7c6CA9uiA6SXJRDXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754679721; c=relaxed/simple;
	bh=KpOf/z+hA/Ma+vMJlvC5wl1ky7VslBtVmPxbm1aowqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeoVmCYiA7e1JGCvy2KyZPdm3Non31GCCd0J9x9C7SUTUphgm1jW5B7cagMnw9XVdJcWdL+SiVLB9EsN8fr2nLAP8YhuSBWUUEmZmVJGKpoNTqu9UuxmGMBdDMXogMrBRv84HGqKFsDu2xHyZZLkp7JhfvUaIo3H1ebsOgVL0Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org; spf=pass smtp.mailfrom=joshtriplett.org; dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b=nc59GdLP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YzzovIUn; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joshtriplett.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id D4B131D000B3;
	Fri,  8 Aug 2025 15:01:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 08 Aug 2025 15:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	joshtriplett.org; h=cc:cc:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754679718;
	 x=1754766118; bh=4dKRhAb42Fr/AWEa/2uFDJBJyPWfAWMqMEuwH80e8Mg=; b=
	nc59GdLPEn2d5YQeo2qJ8lsIVvswuZPKPiN6HO4TwranD3DiHjKZ5D+riebzVDeo
	mxEEFuvn1gYNhQ5/PLc5MISw9LeB3a1sZG0lZK7tsBiaXJrsOMlm1yQ6X5ScyJ0F
	34JnJVLWFoekc5EmWQA4A6MtK3VucNBq7SlfHiDELBBpet4OhqWEqHkLawtTgR0U
	YlFcKc8M7TWZpmsOEFdGgKMJ1fIytNE4+a1ZBJ8xXpwXJYsjTwYZidJnHLKpAKOI
	oGNLPaLcrlbfpOgUsh/lmMFqbJnguOPMu4UtPrM1xUE+P0lNiJaWbLyx9X9tfWdJ
	o+6u9/FNbUJh7mxw1ZIVDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754679718; x=1754766118; bh=4dKRhAb42Fr/AWEa/2uFDJBJyPWfAWMqMEu
	wH80e8Mg=; b=YzzovIUnGA3eDgQNo1nds44Koq/vakvPBq85S5R/NS0/s/2lrtS
	28x0N53P+ieCgDYPjxSbLSIAj5e1HCEyle+mTpcNnRRLyHishWvWvIMucyWpeTuN
	LAHNOSNLxWPBDzQg7+OsbHcm+nS/kTLdWkGqnwfy/wz2wkBif3TSxWhJB/2WbxP9
	4fzi3XUSkT92uim8HTOqZa6fnUI/FHYzudLopts71yiONdINfMy3s6JZ09MO01so
	Ff1HRUogN8JStS/I8/WNjpUNHyuA6q9eTZUxY/kjwoinFXjf022HeUzYKklTTcGp
	et35tOtat1l8lCpwJX4VPJPxyKiukEk1gTw==
X-ME-Sender: <xms:pkmWaMw3cUn6CHUTOld60FgoXk0OK0gCPQOsmBS6ThSnoU7MiAQvVQ>
    <xme:pkmWaAcAr4m0VUhsfIXS8RKEEFaGoLgRjoKBfc3k00949bQKUwFNCgct1jxVKRFlz
    lpOnozG1eb3YXaXhvg>
X-ME-Received: <xmr:pkmWaAKW1xkwiRQxIXoQ1qe5Y7nKkYxM1r2LyXODzB9G--rMDTDjXmu99w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdegiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheplfhoshhhucfv
    rhhiphhlvghtthcuoehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhgqeenucggtf
    frrghtthgvrhhnpeduieegheeijeeuvdetudefvedtjeefgeeufefghfekgfelfeetteel
    vddtffetgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhgpdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:pkmWaJEoL6FyiDVZFZuBxPQwtOiSjjmmCe3Lj8nxDtgKXD8GAaRx_g>
    <xmx:pkmWaCp3ysAUPOGFRAIzMUKsZt8PLtEIrn_nTgzxBYxhwBG9cCLs2A>
    <xmx:pkmWaKQrkR9OjfNHkgV0_DSpqAEV7OJE6MgcH7bhoipABLyEGbUo_Q>
    <xmx:pkmWaHPkBgMs0Xjx3o6Iyp0czXipHV6qIztSCiIoRB1HMcQL6UrcIg>
    <xmx:pkmWaPWHBPEhx31A-BGUYXrw-t4fnVgs_vDd5k78laKbQCtyqdji1VQO>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Aug 2025 15:01:57 -0400 (EDT)
Date: Fri, 8 Aug 2025 12:01:56 -0700
From: Josh Triplett <josh@joshtriplett.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: futimens use of utimensat does not support O_PATH fds
Message-ID: <aJZJpIEJB2R0x-Hh@localhost>
References: <aJUUGyJJrWLgL8xv@localhost>
 <20250808-ziert-erfanden-15e6d972ae43@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808-ziert-erfanden-15e6d972ae43@brauner>

On Fri, Aug 08, 2025 at 03:22:58PM +0200, Christian Brauner wrote:
> On Thu, Aug 07, 2025 at 02:01:15PM -0700, Josh Triplett wrote:
> > I just discovered that opening a file with O_PATH gives an fd that works
> > with
> > 
> > utimensat(fd, "", times, O_EMPTY_PATH)
> > 
> > but does *not* work with what futimens calls, which is:
> > 
> > utimensat(fd, NULL, times, 0)
> 
> It's in line with what we do for fchownat() and fchmodat2() iirc.
> O_PATH as today is a broken concept imho. O_PATH file descriptors
> should've never have gained the ability to meaningfully alter state. I
> think it's broken that they can be used to change ownership or mode and
> similar.

In the absence of having O_PATH file descriptors, what would be the way
to modify the properties of a symlink using race-free
file-descriptor-based calls rather than filenames? AFAICT, there's no
way to get a file descriptor corresponding to a symbolic link without
using `O_PATH | O_NOFOLLOW`.

It makes sense that a file descriptor for a symbolic link would be able
to do inode operations but not file operations.

