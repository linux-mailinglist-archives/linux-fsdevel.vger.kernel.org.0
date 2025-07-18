Return-Path: <linux-fsdevel+bounces-55463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27295B0AA42
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 20:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D481C4E160D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 18:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89FD2E7F0A;
	Fri, 18 Jul 2025 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bwc6RvGA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129731C5D53
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864007; cv=none; b=NcY4x3dJbWUD+IEPsa2GwGgjBxGbKNsjVv19T1uXUdoRrkRsujghiubT2kKFZi5ivCUOSmA2x67+dl6u+VXyS9eh3Y/eGR9xN1FDx/Sstx5/RIEUfpmYewmHvxxHhl7GYr/pQqDFmn2yV2qgg/AuInU/Y/3cGvEMcqUrIW+y+lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864007; c=relaxed/simple;
	bh=Hv1xU7JtH9S/kkaIAU/OaiF6ycCKTwbiV+8uwui9vJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPnx/G41QGeHNp9UuWnA4W0hjopHydHfgFLxyPtkniTiw3yk1fV4BiMbwMiVwzF37j6tWYSMRX/cMtrvNjGkpm6kF6e8ZaqiybnshvHQDcTnh6CVluOUjdYcrVScJ3gbonYB43JHv2oBHgHgbasqfsq2RTaQK/Y1zA+3Jm0sNfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bwc6RvGA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84665C4CEEB;
	Fri, 18 Jul 2025 18:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752864006;
	bh=Hv1xU7JtH9S/kkaIAU/OaiF6ycCKTwbiV+8uwui9vJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bwc6RvGAPXlucQ1u+E/5ZGca8jjQM1hs7JMfCPhoEVGnwgO9Hfe43CSKgo5HPwTdM
	 ExpudZ0NEfkZgRZ6IOXrA/qLswo18jUO8bt262hH2Fw67WBicbPw6O3WfPvn2/PuNO
	 34gJbrCQnqtEITOP1Frna8oN2VP/UP4eqIIIG5tdJ2IiLdwtmq7DQRRu2kWS5b0xPt
	 UUDF5p/yW9haByLz/4WmZ/nIt2galPf8EZPuDuideNS0zDL01i99LyAydXzWtIIHPL
	 Rm2LfCOYjwTwMH2VWSKQMiCnkbjTIMOfdbQbyi8qqlM3/qugkELFM+dNy7F+LkLaJ+
	 tNEFUfe70Ug2Q==
Date: Fri, 18 Jul 2025 11:40:06 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Bernd Schubert <bschubert@ddn.com>, "John@groves.net" <John@groves.net>,
	"joannelkoong@gmail.com" <joannelkoong@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"neal@gompa.dev" <neal@gompa.dev>,
	"miklos@szeredi.hu" <miklos@szeredi.hu>
Subject: Re: [PATCH 1/1] libfuse: enable iomap cache management
Message-ID: <20250718184006.GZ2672029@frogsfrogsfrogs>
References: <175279460162.714730.17358082513177016895.stgit@frogsfrogsfrogs>
 <175279460180.714730.8674508220056498050.stgit@frogsfrogsfrogs>
 <573af180-296d-4d75-a43d-eb0825ed9af8@ddn.com>
 <20250718182213.GX2672029@frogsfrogsfrogs>
 <a0971aee-6f10-4279-b90a-beeb5c3f3637@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0971aee-6f10-4279-b90a-beeb5c3f3637@bsbernd.com>

On Fri, Jul 18, 2025 at 08:35:29PM +0200, Bernd Schubert wrote:
> 
> 
> On 7/18/25 20:22, Darrick J. Wong wrote:
> > On Fri, Jul 18, 2025 at 04:16:28PM +0000, Bernd Schubert wrote:
> >> On 7/18/25 01:38, Darrick J. Wong wrote:
> >>> From: Darrick J. Wong <djwong@kernel.org>
> >>>
> >>> Add the library methods so that fuse servers can manage an in-kernel
> >>> iomap cache.  This enables better performance on small IOs and is
> >>> required if the filesystem needs synchronization between pagecache
> >>> writes and writeback.
> >>
> >> Sorry, if this ready to be merged? I don't see in linux master? Or part
> >> of your other patches (will take some to go through these).
> > 
> > No, everything you see in here is all RFC status and not for merging.
> > We're past -rc6, it's far too late to be trying to get anything new
> > merged in the kernel.
> > 
> > Though I say that as a former iomap maintainer who wouldn't take big
> > core code changes after -rc4 or XFS changes after -rc6.  I think I was
> > much more conservative about that than most maintainers. :)
> > 
> > (The cover letter yells very loudly about do not merge any of this,
> > btw.)
> 
> 
> This is  [PATCH 1/1] and when I wrote the mail it was not sorted in
> threaded form - I didn't see a cover letter for this specific patch.
> Might also be because some mails go to my ddn address and some to 
> my own one. I use the DDN address for patches to give DDN credits 
> for the work, but fastmail provides so much better filtering - I
> prefer my private address for CCs.
> 
> So asked because I was confused about this [1/1] - it made it look
> like it is ready.

Ah, yeah.  My stgit maintainer^Wwrapper scripts only know how to put the
RFC tag on the cover letter, not the patches themselves.  Would you
prefer that I send to your bsbernd.com domain from now on so the emails
all end up in the same place?

--D

> Thanks,
> Bernd
> 

