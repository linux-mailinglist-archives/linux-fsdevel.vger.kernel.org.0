Return-Path: <linux-fsdevel+bounces-26315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D607B9573CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 20:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 104261C23646
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 18:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E415518B497;
	Mon, 19 Aug 2024 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjVZ/OCH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E555189F35;
	Mon, 19 Aug 2024 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724093008; cv=none; b=TcKpHdn+3yqtyVSWet2IjfLWKY1gfCVEEsWX4wFiL0qKeFsOr2OIItXkIQ/hJbtW8xkRoFq0JvrjUPanHRVDN+izW4IZcRMiR9vh+A4dfI3Ux7ZF3UrNHkT1asDbCxO8LNikrIkce7EOz8nheI7zZHmJXb2RmIpbZIF/IBM3py0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724093008; c=relaxed/simple;
	bh=JhEOVkGBltKhcShIFPIXP8AEPFe0YELlu+zvIKqHvj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XM/tmB5nStUPGs3lj26g8/qh17vmsXoWgibAv6L4/2FEyn4UU6gZmCcm0konICtApNBg6aR+agThKYijxodrAG/Fl0HDV9r4N35A5r5NuwTNjhR5ftw88Iw8LJo3Ugt8vfLvvwl4GyBmIQK3VIGc0tRL7oXTNmJpOpFUhWjoAII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjVZ/OCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EEEFC32782;
	Mon, 19 Aug 2024 18:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724093007;
	bh=JhEOVkGBltKhcShIFPIXP8AEPFe0YELlu+zvIKqHvj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AjVZ/OCHuNBGnPvZvyBD/nhN1/y3NwHoPuJTG8PoKs23pGK31RLU3h1niU4HrrjFk
	 7PI2kzpDBdn8VMH0Ofc4TnPLdDLVTN35kcu4BoVoMj8NZY0cFvxAs9Fxp7mPQ3fLEz
	 ax1Vf0kSvuB3vcQRqR4oJWHoHSWFVN5v40x6y/g6KZquXbhiGif6oOMotdw4CIxzlQ
	 YRq0Qrx16TkSUm2nfiByo6uGFt1WZ7jUyNdaOjHl7kVaA0a2WSOx9hSuR8wlS6XfVN
	 DrtCLM2QWq8TJZjvej56QVc/VKqziDVJhadEWFADCqmrcn2KKO5pG7h3wlWBEuS5fe
	 UFQ/elEODEE9g==
Date: Mon, 19 Aug 2024 14:43:26 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Neil Brown <neilb@suse.de>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v12 00/24] nfs/nfsd: add support for localio
Message-ID: <ZsOSTg57EtsBlH50@kernel.org>
References: <20240819181750.70570-1-snitzer@kernel.org>
 <D42F5EA1-5C20-4576-A85E-1183AA192448@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D42F5EA1-5C20-4576-A85E-1183AA192448@oracle.com>

On Mon, Aug 19, 2024 at 06:29:57PM +0000, Chuck Lever III wrote:
> 
> 
> > On Aug 19, 2024, at 2:17 PM, Mike Snitzer <snitzer@kernel.org> wrote:
> > 
> > Testing:
> > - Chuck's kdevops NFS testing has been operating against the
> >  nfs-localio-for-next branch for a while now (not sure if LOCALIO is
> >  enabled or if Chuck is just verifying the branch works with LOCALIO
> >  disabled).
> 
> LOCALIO is enabled, but the tests I run (except for pynfs, which
> uses a synthetic client) all target a remote NFS server .
> 
> There wasn't a convenient way to hack the workflows to run the
> NFS server locally. So, these tests act as a regression test with
> LOCALIO enabled and a remote NFS server -- ie, the traditional
> NFS deployment scenario. I thought this would be OK because
> Kent's rig is already handling LOCALIO-specific testing.

Makes sense, thanks for clarifying.  
 
> When I re-enable the ltp NFS suite, that does use a local NFS
> server. That suite hasn't ever been reliable for me, so I don't
> use it for now.

OK.

