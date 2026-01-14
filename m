Return-Path: <linux-fsdevel+bounces-73617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A1BD1CB6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 07:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D7FCF30092B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 06:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6A736CDF2;
	Wed, 14 Jan 2026 06:47:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559CC36E463;
	Wed, 14 Jan 2026 06:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768373270; cv=none; b=WdltS8KfLzkHWnMBY6cWIGIT5jBklBNcBWhLqEXopqec+aE807KBH/+vztXt46oyHKaPa7iZKj6/sElpIh6Nm46H//YQb0VaH7I+7LExGqWKr1wbHN7SdefrCtO776XRHSYVK7VFIOjEKwk1i8PP1THkQ+aSuqSehwvU9gQI14k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768373270; c=relaxed/simple;
	bh=LDAkt1tMxJVXmMz+fqZ+LFnrWWUemPCfMg6j3gIiGQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=co1mTXCZBve/m08/vfTdU+tWDv80/mJ7B8CjsFXKsTqhQxUwQrHHdKuaOFWPPHgMgQIIbIxMnZboyBWwRUaGkWUxVPb6aYmhI3ZR7mVdk/LqM7v/1BYCGOqwXnFkvWfeDUoQlNvxRT5gkmjbCdCxuclcE65zvbUJiGVJveHGiLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E164967373; Wed, 14 Jan 2026 07:47:35 +0100 (CET)
Date: Wed, 14 Jan 2026 07:47:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, aalbersh@kernel.org,
	david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 13/22] xfs: introduce XFS_FSVERITY_REGION_START
 constant
Message-ID: <20260114064735.GD10876@lst.de>
References: <cover.1768229271.patch-series@thinky> <qwtd222f5dtszwvacl5ywnommg2xftdtunco2eq4sni4pyyps7@ritrh57jm2eg> <20260112224631.GO15551@frogsfrogsfrogs> <5ax7476dl472kpg3djnlojoxo2k4pmfbzwzsw4mo4jnaoqumeh@t3l4aesjfhwz> <20260113180655.GY15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113180655.GY15551@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 13, 2026 at 10:06:55AM -0800, Darrick J. Wong wrote:
> > hmm right, check in begin_enable() will be probably enough
> 
> I think that would probably be more of a mount-time prohibition?
> 
> Which would be worse -- any fsverity filesystem refuses to mount on
> 32-bit; or it mounts but none of the fsverity files are readable?
> 
> Alternately I guess for 32-bit you could cheat in ->iomap_begin
> by loading the fsverity artifacts into the pagecache at 1<<39 instead of
> 1<<53, provided the file is smaller than 1<<39 bytes.  Writing the
> fsverity metadata would perform the reverse translation.
> 
> (Or again we just don't allow mounting of fsverity on 32-bit kernels.)

What are the other file systems doing here?  Unless we have a good
reason to differ we should just follow the precedence.


