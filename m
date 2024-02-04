Return-Path: <linux-fsdevel+bounces-10226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1851A848F65
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 17:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7FBB28381B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 16:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8480222F14;
	Sun,  4 Feb 2024 16:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Urvtlx4+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACA323747;
	Sun,  4 Feb 2024 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707064911; cv=none; b=Mhtgg9NvU5RvrK3uJvfhN19XQxSvC95sOIfTQMNPA/nwTjSEQW2pcvyCY0s4qyWlNNVAO6sBDzTNMyR017RySm7azqAeallyzXqZEp+iy8r5vZj8ifhbLZcl2ZV6TVT1iSEIh/n8MoC8qUcVpQl7Bbl/Myk8a7GYJyRFuI5c2J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707064911; c=relaxed/simple;
	bh=Z+i8ZnLnu+yuCUsTgI/p9zrFwjfvBrXRwMGnykiUOVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fy24vviQrhCUN3anSnyCiIwpwhR2FlvFrm7BigePLAy0RjYewAKEoL5HNl8p+bZOfilHe8XOOP23y78Mfgzdf5bLHsOJztJzoROGL5hU50rDGc8x4ho8aok2x0PmuGhW1LAO+APRZlGN7UjDcjfxtAjTQN2TRDZNEYkoWcfSsDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Urvtlx4+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wv7P0rVm2KXkPgPl8p9VAbf4b3ShCucsZuYwZ4OooIA=; b=Urvtlx4+K9Z4QSk4/uWv+PPdmF
	PhHTvsf6KM2LiTmx3BOLnDSr7qwGOvTKMv6Ya7a79LEDhrMJKbaVq1ClgwzHxoiq9kmvq5QNMwt2g
	ludzZTU9YP4oU6uZmxzsB3r7FpOucewKJUaL641nF9uQeiEFG6pnz4MNj9GH7fAFqIT7zjj1JmNww
	itrb4+1t+yP6hQZ++OelA/zrjwbRogMmnKgF9Lt5yTxNphguv1XOhtQPiwE8f/dGnYhDM5J9dPKf7
	Qysc6tUD0qSMzld5t4jvMnSXbx828/h0E0U+AiTQ2ivEOzDA5K1KtzXx9UKHRXtwLMpEymOTRFneF
	k8Xqcp8g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rWfYv-005BhY-0l;
	Sun, 04 Feb 2024 16:41:45 +0000
Date: Sun, 4 Feb 2024 16:41:45 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Steve French <smfrench@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-cifs@vger.kernel.org
Subject: Re: [PATCH 12/13] cifs_get_link(): bail out in unsafe case
Message-ID: <20240204164145.GK2087318@ZenIV>
References: <20240204021436.GH2087318@ZenIV>
 <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
 <20240204021739.1157830-12-viro@zeniv.linux.org.uk>
 <CAH2r5muOY-K6AEG_fMgTLfc5LBa1x291kCjb3C4Q_TKS8yn1xw@mail.gmail.com>
 <20240204162558.GJ2087318@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204162558.GJ2087318@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Feb 04, 2024 at 04:25:58PM +0000, Al Viro wrote:

> *IF* you can tell the symlink body without blocking (e.g. you
> have some cached information from the last time you've asked
> the server and have reasons to trust it to be still valid),
> sure, you can return it without dropping out of RCU mode.
> 
> It would be fairly useless for CIFS, since ->d_revalidate() of
> CIFS dentries would reject RCU mode anyway.  That's what normally
> saves you from having ->get_link() called that way, but it's not
> guaranteed - there are convoluted setups that avoid having
> ->d_revalidate() called first.
> 
> See the description of RCU mode filesystem exposure in the
> last posting in this thread for more details.

PS: if you decide to go for handling RCU pathwalk mode in CIFS,
you definitely want to read the first half of
https://lore.kernel.org/linux-fsdevel/20240204022743.GI2087318@ZenIV/
or whatever it eventually turns into.  It obviously needs quite
a bit of massage before it starts to resemble proper docs -
currently it's just the summary I'd put together while going through
the audit: which methods are exposed, how can they tell,
what is and what is not guaranteed for them, etc., with a bit of
"why does VFS bother with something that unpleasant" thrown into the mix
as an explanation.

Any assistance with turning that into a coherent text would be
very welcome - I think that description of RCU pathwalk regarding
its impact on the filesystems would be useful.

