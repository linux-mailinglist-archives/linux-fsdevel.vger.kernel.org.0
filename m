Return-Path: <linux-fsdevel+bounces-37178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDA49EEA2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 16:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86DCD1886C50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 15:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03632163AE;
	Thu, 12 Dec 2024 15:07:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C410215773;
	Thu, 12 Dec 2024 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016033; cv=none; b=EXbFUCOkIlJYB4nOdEo5vcOlZxDcX1s0H97lBtgTYBvo7/DMeXUd3r4zhuBaKM5aosgXXHtkOb0Z8EvDgNdjygbCQHBjRzbXyMKKbg4YyPWH4tlo3BJYDzE9mPWXVxuX5w4I0qck598b+LysXd35Ye9EG/ahVFhN/LT2WWQ7k94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016033; c=relaxed/simple;
	bh=LjTLvbqjsiuatp7t2FvGi35+vfAXJ996lz7oXFuN8IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQJBad1y69N2XpTTSVNjA8U0FjZs9ERHr6t8MNO8fcgulWtTu503HCg81/Q6IqnIF3vx+MSWbwYCay92I529hkyZS4Krc+UptQd3knjqZN7luOng5kudWApgzgEIdgIB2vyV5EQcGvEdpwcivkJZIiXmQoGxpF4Bzhwv4Q1NjTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1D2E368D34; Thu, 12 Dec 2024 16:07:08 +0100 (CET)
Date: Thu, 12 Dec 2024 16:07:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/8] iomap: split bios to zone append limits in the
 submission handlers
Message-ID: <20241212150707.GB6840@lst.de>
References: <20241211085420.1380396-1-hch@lst.de> <20241211085420.1380396-5-hch@lst.de> <c84e84c2-7705-47e3-bb2a-35175bddadd6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c84e84c2-7705-47e3-bb2a-35175bddadd6@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 12, 2024 at 02:21:32PM +0000, John Garry wrote:
> On 11/12/2024 08:53, Christoph Hellwig wrote:
>> +	if (is_append) {
>> +		struct queue_limits *lim = bdev_limits(bio->bi_bdev);
>> +
>> +		sector_offset = bio_split_rw_at(bio, lim, &nr_segs,
>> +			min(lim->max_zone_append_sectors << SECTOR_SHIFT,
>> +			    *alloc_len));
>> +		if (!sector_offset)
>
> Should this be:
>
> 		if (sector_offset <= 0)

No support for REQ_ATOMIC and REQ_NOWAIT in this path right now,
but we might as well future prove it by checking for a negative
error value.  But we'll then need to propagate the error as well.
I'll see what I can do.


