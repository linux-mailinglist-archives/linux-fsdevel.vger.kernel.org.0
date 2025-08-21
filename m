Return-Path: <linux-fsdevel+bounces-58701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77898B30930
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 00:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AEF11CC72DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C2F2E173F;
	Thu, 21 Aug 2025 22:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wj0EmRg/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D63F21765B
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 22:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755815347; cv=none; b=aPkSdWLe9gxZeEvMaZmQR8B5l65GREH5Xiq5YHsPmt+ykKKh+WxF6OBfIBMkqLQEdFNI3Y/l43YSs2dv896io/5hXyMiKrFneFrqoYMBjy6c10tC0RNHM5feHwMj01u9eR7ib/tZyuVF3m878m6qLwam8SzPvlk9HUd4uTChB1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755815347; c=relaxed/simple;
	bh=jN8QKITiflgJ/zNZ9FblNQ7j/P9/MK27SRPrAS/S8ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUAGqQ8oqvdXP04JLCflB3O1dUKVu0TEbg9kzzjTKixaZuQAku7UgMspT4lRaHj22XdAPHUYiVpV7EvYmRRnkhmrD46MsTBsjYpeKLZi849ONzd/mMMA7SjoGbE/2cjT/GBW8faB+RMify2h/kpvHDaNjnQMEqxfZkDIfdjthZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wj0EmRg/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F3BC4CEEB;
	Thu, 21 Aug 2025 22:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755815346;
	bh=jN8QKITiflgJ/zNZ9FblNQ7j/P9/MK27SRPrAS/S8ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wj0EmRg/8OdHB1nIkd6+b6rj9Rfu9jZtHsEOsoP7WMJ/ytljk8e3+vYdgFywvwaCX
	 oIYGB9sqNTKBIXc+98LL+FJ6Yaf3NNEJZkJJm/uDkboRUorSpX7+JGTxr6psOyMxXZ
	 RQbT4MLy5UoPkPJ3qvfqJ8nYm5gLm8wmotztLIomvkptPFNDDkKU2CD/8mYvg7pYVy
	 HYTHmENSzmhVFPJd7oAxbd4Ci7SPUHsSd+crNCLznmLfyCHP+ss31ZnSgvfRue+/nd
	 YkeJNf2dAolG6cX3D7LnV96gu35hZRoMKbIaWh5X9+CmZF+dCV6lA4xp2lFxwSvOPY
	 6feIjZ0XpbKaw==
Date: Thu, 21 Aug 2025 15:29:05 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: bschubert@ddn.com, John@groves.net, joannelkoong@gmail.com,
	linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Subject: Re: [PATCHSET RFC v4 4/4] libfuse: implement syncfs
Message-ID: <20250821222905.GR7981@frogsfrogsfrogs>
References: <20250821003720.GA4194186@frogsfrogsfrogs>
 <175573712188.20121.2758227627402346100.stgit@frogsfrogsfrogs>
 <3d9daf0b-2dd6-48cb-9495-76b2b73a5113@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d9daf0b-2dd6-48cb-9495-76b2b73a5113@bsbernd.com>

On Thu, Aug 21, 2025 at 11:41:54PM +0200, Bernd Schubert wrote:
> 
> 
> On 8/21/25 02:49, Darrick J. Wong wrote:
> > Hi all,
> > 
> > Implement syncfs in libfuse so that iomap-compatible fuse servers can
> > receive syncfs commands.
> > 
> > If you're going to start using this code, I strongly recommend pulling
> > from my git trees, which are linked below.
> > 
> > With a bit of luck, this should all go splendidly.
> > Comments and questions are, as always, welcome.
> > 
> > --D
> > 
> > kernel git tree:
> > https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-attrs
> > ---
> > Commits in this patchset:
> >  * libfuse: wire up FUSE_SYNCFS to the low level library
> >  * libfuse: add syncfs support to the upper library
> > ---
> >  include/fuse.h          |    5 +++++
> >  include/fuse_lowlevel.h |   16 ++++++++++++++++
> >  lib/fuse.c              |   31 +++++++++++++++++++++++++++++++
> >  lib/fuse_lowlevel.c     |   19 +++++++++++++++++++
> >  4 files changed, 71 insertions(+)
> > 
> 
> Thank you, both look good to me. This is independent of io-map - we can
> apply it immediately?

Yes, please!  Note that we'll have to decide if the kernel is going to
enable sending syncfs for all servers, not just the virtiofs ones.

--D

> 
> Thanks,
> Bernd

