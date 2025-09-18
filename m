Return-Path: <linux-fsdevel+bounces-62166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C850DB86BE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 21:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56AF8487CFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 19:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117322EAB60;
	Thu, 18 Sep 2025 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="QAFLoDk4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from e3i308.smtp2go.com (e3i308.smtp2go.com [158.120.85.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C0C227EB9
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 19:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224735; cv=none; b=b+C5s6HJC7J8epVlF1MeMyIrDee7tSBj924UvlebsEFWWwTl4+2IIrICDGkqsd/k72AYHoTCC6+QtZXbslD8ncs4GvBdYexY+g0ao07PIKghOOf6OCrqan80cXf9K5j/WXh+5SbsA5JLwzZBva9mKOFttlqF7B5ePSetAE08eEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224735; c=relaxed/simple;
	bh=l3pzda/Ga0u32pP2y0Ol8CiPoveeaHvhSiHYIF3et5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6ykrC9E+VDYSk3QB116c3XTRakq8+Qu/0qRvrYNI3djH07CCM78gB8JJ5BQb3zPnbpnoXzFrwPg7N+7ehqgDps8lzEH0eZrIV/GHBIqoKIvGMBAcCyxntgOr2+wN3ezr209e4aL51Hed9L/XJ6dgJPkOERDdDQvXx9Kv6eYERk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=QAFLoDk4; arc=none smtp.client-ip=158.120.85.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1758223821; h=from : subject
 : to : message-id : date;
 bh=Hw7yQi+sLehXHDsSGjLvuOxcP7o6dr9w07jZ+nXXLQ4=;
 b=QAFLoDk4rqcDI0fF29R4J16qGHG6vsderKQJCCg32J3Uvzb/jPGwid1OI05de2Ma5C9Qf
 OflGpabJg37XlwOk/VeIUOrpP/5cgKYsoZwd++PlUYsh10SbTtbJq3OQFGOtv+zmOG2HJq8
 wFt5uEM3wMTg6LvbuuVq6KfiHD24Fwoa2tVYnqzFMmNiJRzjoCbUvgYspjRsN19GohFvXdf
 BF1C+csl6qDvAAtwNG/JadKh705Q8hSV2M2bFPCr6w7Y1JQJRbLC9xgv2h74YIBoQQ0DMZq
 xHLx8OCn1VZOrUYad9OaOoYDkPB5EOi9WZlAMqObmlsztkec82tgTI0oiVCg==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1uzKKd-4o5NDgrhR1L-rWjP;
	Thu, 18 Sep 2025 19:30:15 +0000
Date: Thu, 18 Sep 2025 21:17:33 +0200
From: Remi Pommarel <repk@triplefau.lt>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [RFC PATCH 0/5] 9p: Performance improvements for build workloads
Message-ID: <aMxazb_dcK3hTATI@pilgrim>
References: <cover.1756635044.git.repk@triplefau.lt>
 <aMa2Q_BUNonUSOjA@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMa2Q_BUNonUSOjA@codewreck.org>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sC45X5161K
X-smtpcorp-track: DA-UgnMlYLnT.dT4ARwfG9SXh.omjyWQ3gtYX

Hi Dominique,

On Sun, Sep 14, 2025 at 09:34:11PM +0900, Dominique Martinet wrote:
> Remi Pommarel wrote on Sun, Aug 31, 2025 at 09:03:38PM +0200:
> > This patchset introduces several performance optimizations for the 9p
> > filesystem when used with cache=loose option (exclusive or read only
> > mounts). These improvements particularly target workloads with frequent
> > lookups of non-existent paths and repeated symlink resolutions.
> 
> Sorry for slow reply, I think a negative cache and symlink cache make
> sense.
> I haven't tested these yet, and there's a conversion to the "new" mount
> API that's brewing and will conflict with 2nd patch, but I'll be happy
> to take these patches as time allows.
> What was the reason this was sent as RFC, does something require more work?
> 
> I can't comment on io_wait_event_killable, it makes sense to me as well
> but it's probably more appropriate to send through the scheduler tree.
> 

RFC was mainly here to know if a io_wait_event_killable() would made
sense before getting the scheduler tree involved. Also as it is my first
contribution in v9fs (and fs subsystem) wanted to be sure I wasn't
missing something obvious, caching could be a complex subject to grasp.
This also comes with some drawbacks, if for example server removes a
shared file or modify a symlink the client will be desynchronized, so I
wanted first to be sure we were ok with that when using cache=loose.

I'll try to monitor the new mount API and rebase the series when that
get merged. I'll probably separate the io_wait_event_killable() in its
own patchset though.

> 
> > The third patch extends page cache usage to symlinks by allowing
> > p9_client_readlink() results to be cached. Resolving symlink is
> > apparently something done quite frequently during the build process and
> > avoiding the cost of a 9P RPC call round trip for already known symlinks
> > helps reduce the build time to 1m26.602s, outperforming the virtiofs
> > setup.
> 
> That's rather impressive!
> (I assume virtiofs does not have such negative lookup or symlink cache so
> they'll catch up soon enough if someone cares? But that's no reason to
> refuse this with cache=loose)
> 

virtiofs does have negative lookup (when used with cache=always) and
symlink caches (this serie is even quite a bit inspired by what fuse
does). I don't really know what makes virtiofs a bit slower here, I
haven't dig into it either though but won't be surprised it could easily
catch up.

> > Further investigation may be needed to address the remaining gap with
> > native build performance. Using the last two patches it appears there is
> > still a fair amount of time spent waiting for I/O, though. This could be
> > related to the two systematic RPC calls made when opening a file (one to
> > clone the fid and another one to open the file). Maybe reusing fids or
> > openned files could potentially reduce client/server transactions and
> > bring performance even closer to native levels ? But that are just
> > random thoughs I haven't dig enough yet.
> 
> Another thing I tried ages ago was making clunk asynchronous,
> but that didn't go well;
> protocol-wise clunk errors are ignored so I figured it was safe enough
> to just fire it in the background, but it caused some regressions I
> never had time to look into...
> 
> As for reusing fids, I'm not sure it's obvious because of things like
> locking that basically consider one open file = one fid;
> I think we're already re-using fids when we can, but I guess it's
> technically possible to mark a fid as shared and only clone it if an
> operation that requires an exclusive fid is done...?
> I'm not sure I want to go down that hole though, sounds like an easy way
> to mess up and give someone access to data they shouldn't be able to
> access by sharing a fid opened by another user or something more
> subtle..

Yes I gave that a bit more thinking and came up with quite the same
conclusion, I then gave up on this idea. The asynchronous clunk seems
interesting though, maybe I'll take a look into that.

Thanks for your time.

-- 
Remi

