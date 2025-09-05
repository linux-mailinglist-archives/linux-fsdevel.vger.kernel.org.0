Return-Path: <linux-fsdevel+bounces-60326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ECFB44B43
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 03:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A508348832A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 01:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D451EB5F8;
	Fri,  5 Sep 2025 01:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKcHXJVl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EBA290F
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 01:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757035748; cv=none; b=kTT7JqN++vhChaBsVYczqnCtJRRRqmtkeLkbD7dOlTrN2C82wCBJAdAmhZaNwomxPx+I5aPOtCfB0yQDshjRDw7kmvUXjHJdbCGfP/6ggWuiT4V/NdRLSyUKH1UmrsNPGTII2+hHPGTwXUPXhMFR8JWVZkClZdzUXM6FtfaM6XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757035748; c=relaxed/simple;
	bh=apYt/RuG1dxwC+vaFYcQvngOjxhlr0AR0XVwImYctrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxoGVKSQPC3kK34dFszoJsV5yW1CfszjvFzkWKMEcQNOOTvEsOiZ3Q8opkWxezQ0Osx8ctAmWrIYX0jxUnIwvlbdBVCz8p9iEtmS4VAaepshx7oy39+gc5BHAJ1Ffr0Lwx6CyOamdkh7MshY+8xtbdqvsO8nEPOU1acTlLdSP74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKcHXJVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0E4C4CEF0;
	Fri,  5 Sep 2025 01:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757035747;
	bh=apYt/RuG1dxwC+vaFYcQvngOjxhlr0AR0XVwImYctrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SKcHXJVlV7XomvDlKGybrlDD5pWL8JgdnXdUcYghyAZq39520QYZ6+0Jv59Z5zh6/
	 790Xx00mtCHAWJC3i/DiHi8AZwx99V5ehGItKH3uDAYeJjNSKAYn79Crlfr/gGROKz
	 TEMuxRJp6y7bi497KVjQ4pbJadhUEyX8CAtYcn3+GGHW/OyOfn8EmsiXJod4kOEm0e
	 0t5Oqh0uq/hjOLEnTeBhJlPFGFAOI+A7XfaJHRPMIVhFq+Msx0BK2ZA4hiXHodrgfW
	 0Z1Di4DfSqem1OfUyUq2jSHeCn7kvOl/KSTx9K1b17gZTgJ8GCqpcOMv0F3uYq4FRv
	 VxLNDXXgj3LiA==
Date: Thu, 4 Sep 2025 18:29:07 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Subject: Re: [PATCH 5/7] fuse: update file mode when updating acls
Message-ID: <20250905012907.GB1587915@frogsfrogsfrogs>
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708651.15537.17340709280148279543.stgit@frogsfrogsfrogs>
 <CAJfpegtz01gBmGAEaO3cO-HLg+QwFegx2euBrzG=TKViZgzGCQ@mail.gmail.com>
 <20250903175114.GG1587915@frogsfrogsfrogs>
 <CAJfpegvJYudgPE4NFrqmg4bLmNmmBmKOgXJWq7pRq8bfMXbRBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvJYudgPE4NFrqmg4bLmNmmBmKOgXJWq7pRq8bfMXbRBA@mail.gmail.com>

On Thu, Sep 04, 2025 at 12:49:23PM +0200, Miklos Szeredi wrote:
> On Wed, 3 Sept 2025 at 19:51, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > As suggested in the thread for the next patch, maybe I should just hide
> > this new acl behavior behind (fc->iomap || sb->s_bdev != NULL)?
> 
> Okay, but please create a fc->is_local_fs that is set on the above
> condition to make this more readable.

Done.

--D

> Thanks,
> Miklos
> 

