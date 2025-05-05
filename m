Return-Path: <linux-fsdevel+bounces-48028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2024BAA8E48
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 10:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29CC2189677D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 08:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E9C1F4617;
	Mon,  5 May 2025 08:31:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA3A6D17;
	Mon,  5 May 2025 08:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746433860; cv=none; b=AAtp1hBq8/T39wi7YgV4jwlcWkZ9eq6bWdFFv4JGf+MfsIATl/I+DulTmI3L/XpNslSBJvx15yrOfZR0K7u0Y9/JCYCJ37r83nRqmO/n5Mscoon2mCJIxBXDOHeQUJGlV1b7z5Ne/aSnTQX1I5r6hOlozLt+tyhP4MZo+cn2vvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746433860; c=relaxed/simple;
	bh=avsB5C1tOBNRNOe12OtD/H35rQoWEFfqz4R6mW733HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWV9JtpuZqIkhNnSZ4F8J/pITXsANaDqbGtkYudhZQiDdK/PM9q2tw8wP56apVHaklAqIt7oEN00VE6XZrY8kJ2E60mSgY3ra5Vh8W7bJRv739K+93ggMMrDMvvYsIgC2Yr1btEU2P6D4gGfDwXjOtUBj156f2jei18jsQJg1IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EE3E968BFE; Mon,  5 May 2025 10:30:50 +0200 (CEST)
Date: Mon, 5 May 2025 10:30:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org, djwong@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v11 06/16] xfs: ignore HW which cannot atomic write a
 single block
Message-ID: <20250505083050.GA31587@lst.de>
References: <20250504085923.1895402-1-john.g.garry@oracle.com> <20250504085923.1895402-7-john.g.garry@oracle.com> <20250505054310.GB20925@lst.de> <1d0e85d5-5e5c-4a8c-ae97-d90092c2c296@oracle.com> <0b0d61e9-68e6-4eb0-a7bd-6e256e6d45f8@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b0d61e9-68e6-4eb0-a7bd-6e256e6d45f8@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 05, 2025 at 09:12:53AM +0100, John Garry wrote:
> On 05/05/2025 06:45, John Garry wrote:
>> On 05/05/2025 06:43, Christoph Hellwig wrote:
>>> I think this subject line here is left from an earlier version and
>>> doesn't quite seem to summarize what this patch is doing now?
>
> How about we just split this patch into 2 patches:
> part 1 re-org with new helper xfs_configure_buftarg_atomic_writes()
> part 2 ignore HW which cannot atomic write a single FS block

Fine with me.  Although just fixing up the subject sounds fine as well.

