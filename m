Return-Path: <linux-fsdevel+bounces-58313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172F2B2C772
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 16:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F11B11729C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 14:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8130827D780;
	Tue, 19 Aug 2025 14:45:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBD41FF7D7;
	Tue, 19 Aug 2025 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755614756; cv=none; b=qMi62VRIjR8PfEUUDe4G4XBFBaWlNfMaJwaOt8F87ni8MKp6A6fvF89x2y3k+AK32L17OPaHBnWGbtY1Ds391a6kXVxwL9fnvDBfS1oajdAIXSKY0RA1Y8HZlSzN/Mcrhszj8KYTtdHpXKeGRiL0GG8dDjdLgb6dLTKnnQZWrMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755614756; c=relaxed/simple;
	bh=89PhIQ84XYhHOOhPe9ejzVXHuIjs5RuVwqxKjJfeYkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cp5SvTENdIJlV9B1FFqeK7KdCfB7Q1d7MNBW9WPGFJJjA2zgmsjN3lRZyJvV7KL5RvR4ugDNzuo1omTmanq16OYpdrHDp9i1f4mcWEz4wsDMwhZp0ZQSsdEV/DJn9SYu6G3PcXL0NpSUiJtr4IjSFo9Kdu/vswk4qFWHK5hwU48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D9128227A88; Tue, 19 Aug 2025 16:45:45 +0200 (CEST)
Date: Tue, 19 Aug 2025 16:45:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <20250819144545.GA18364@lst.de>
References: <6c3e1c90-1d3d-4567-a392-85870226144f@oracle.com> <aHULEGt3d0niAz2e@infradead.org> <6babdebb-45d1-4f33-b8b5-6b1c4e381e35@oracle.com> <20250715060247.GC18349@lst.de> <072b174d-8efe-49d6-a7e3-c23481fdb3fc@oracle.com> <20250715090357.GA21818@lst.de> <bd7b1eea-18bc-431e-bc29-42b780ff3c31@oracle.com> <20250819133932.GA16857@lst.de> <59a0d2df-a633-4f82-8b11-147ba88b7bcb@oracle.com> <20250819144347.GC7942@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819144347.GC7942@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 19, 2025 at 07:43:47AM -0700, Darrick J. Wong wrote:
> What is the likelihood of convincing the nvme standards folks to add a
> new command for write-untorn that doesn't just silently fail if you get
> the parameters wrong?

In my experience that depends mostly on how much a big customers for
NVMe hardware is asking for it.  Hint:  while Oracle isn't in the
absolute top tier of the influence scale it probably is just below.


