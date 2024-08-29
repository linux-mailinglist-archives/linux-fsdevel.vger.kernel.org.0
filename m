Return-Path: <linux-fsdevel+bounces-27760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D789F96392F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 06:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0AF51C22D1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 04:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118794F20C;
	Thu, 29 Aug 2024 04:01:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F93A28685
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 04:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724904062; cv=none; b=r0rhrukidtz5uitnBryxn/XIc1YcvpRWM6SesFC+oG5BNKAFWBxFrc6zdlh4KowC0QDVsmnEFKyy4wqV8TaQjNjxHCHAmGYAY+AGjsTdntwBchtOIiu0wiznispZ2LrY6LX/BWSThf5ONUvI0Pdz0w70cQKSwa1uVLvbkYiunvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724904062; c=relaxed/simple;
	bh=CcNQTQdn/qv/Vr02zI1/Fy/E68AA1RkxsUrHy1BjkFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMbww/GidkMKGvmstbX/aTVWZjHRsBhvFc4XJOW4KAobvqzcTuOygFfi5od4HuRCCi4SHeH9Vj2M97Ap7TZ1RjDGif28VMd/VBz8gsJGUl7zMcNpq4i0k7GS1u1Ijxo6MjbCgSphpUgw3meZLiR0Fh3XrmKwysBAUfsxBXlkokI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2682768AA6; Thu, 29 Aug 2024 06:00:57 +0200 (CEST)
Date: Thu, 29 Aug 2024 06:00:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	Dave Chinner <david@fromorbit.com>,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>
Subject: Re: VFS caching of file extents
Message-ID: <20240829040056.GA4142@lst.de>
References: <Zs97qHI-wA1a53Mm@casper.infradead.org> <20240829015750.GB6216@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829015750.GB6216@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

> Wouldn't readplus (and maybe a sparse copy program) rather have
> something that is "SEEK_DATA, fill the buffer with data from that file
> position, and tell me what pos the data came from"?

Or rather a read operation that returns a length but no data if there
is a hole.  Either way a potentially incoherent VFS cache is the wrong
way to implement it.

> I also suspect that devising a "simple" mapping tree for simple
> filesystems will quickly devolve into a mess of figuring out their adhoc
> locking and making that work.

Heh.  If simple really is the file systems just using the buffer_head
helpers without any magic it might actually not be that bad, but once
it gets a little more complicated I tend to agree.

But the first thing would be to establish if we actually need it at all,
or if the buffer_head caching of their metadata is actually enough for
the file systems.


