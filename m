Return-Path: <linux-fsdevel+bounces-16786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B301D8A2A41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 11:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C2882891A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 09:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386AF548EF;
	Fri, 12 Apr 2024 08:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrGHyAgq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923CF5465D;
	Fri, 12 Apr 2024 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712912181; cv=none; b=fjjCy6BXnYcLm+74Uh8zZ6oVmsv5gJrmZ8ynW7M5+koBWDWaGVgmf5uk1ir/GfNqIdSn5VBpjVnV9DjznozEPY7sY4vcFXVR3Qk515dHEkyF/2/FdQ/GlBsQk/mWB2zWupMCwwzvo/QwhQuBG1wy0cT6WxqTp7C9ukvDKy/XPo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712912181; c=relaxed/simple;
	bh=/VwKN2hy8yRBMxRAHW+2C5momHBRbHcRDyWc7uaVzjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrcVqXwZ987k62aqdzx5anHjLv1b2sc3V5h3dOFH/8sIfN5YdXrh5v1PgCy7ykev48J2hhhVAtPUDqwaqRvUG1PCyZbg0A5DS2Ztie7tVne2z3Bmh9DrlDPMGdw10KjLBzoOW4WJnSN6uK3SvEfHEojzHZ08IxX+ve1lUohi8J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrGHyAgq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A065C113CC;
	Fri, 12 Apr 2024 08:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712912180;
	bh=/VwKN2hy8yRBMxRAHW+2C5momHBRbHcRDyWc7uaVzjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mrGHyAgqxEr0L+ZbsXI3zhBCzrogewHTHc4QEX0YswovqORrIMcDsMykZqQ+QHIJV
	 g9PeLDTc4Lmp1Qr08YJzfke2lau9ixHweNLHaJv4sKlkNkllOzeAQ2YnVb5SIfPLmX
	 NSB3K1yubH4UEOi7iUdH1TW46/TG0aePd1GLUuOizuvS4KAfpk6j3YwZwHHfO6mJMR
	 sgwBAZlSoURzm7xEbf6oeOvxqBoLjMWDwhMRlALL/ajPRS+pP/bqR9nhUNK3wsmXzP
	 hsn9hqClj7p5hXAVRZhE7/I5hkeD6F717Jzdz/XV7muTf3ZHJHOG3J1/GqbytuPmAB
	 PJR3jWNr+vg6g==
Date: Fri, 12 Apr 2024 10:56:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() -
 requirements
Message-ID: <20240412-orangen-liedchen-8b662d023db0@brauner>
References: <20240411001012.12513-1-torvalds@linux-foundation.org>
 <CAHk-=wiaoij30cnx=jfvg=Br3YTxhQjp4VWRc6=xYE2=+EVRPg@mail.gmail.com>
 <20240411-alben-kocht-219170e9dc99@brauner>
 <20240411-adressieren-preschen-9ed276614069@brauner>
 <CAHk-=wj+8Cq82exnjf1HMsDODHwtnTOmfnGPMUf12ck9F-pyLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj+8Cq82exnjf1HMsDODHwtnTOmfnGPMUf12ck9F-pyLA@mail.gmail.com>

On Thu, Apr 11, 2024 at 09:21:27AM -0700, Linus Torvalds wrote:
> On Thu, 11 Apr 2024 at 05:25, Christian Brauner <brauner@kernel.org> wrote:
> >
> > Btw, I think we should try to avoid putting this into path_init() and
> > confine this to linkat() itself imho. The way I tried to do it was by
> > presetting a root for filename_lookup(); means we also don't need a
> > LOOKUP_* flag for this as this is mostly a linkat thing.
> 
> So I had the exact reverse reaction to your patch - I felt that using

Fun. I really disliked the idea of having to somehow wrangle this into
lookup itself and that the root argument just happened to not be used
for non-kernel internal use-cases yet. But I'm not married to this so
fine by me.

