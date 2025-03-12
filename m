Return-Path: <linux-fsdevel+bounces-43758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60829A5D5A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 06:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82843B2018
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 05:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E361DF754;
	Wed, 12 Mar 2025 05:41:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ACA1DE4D5;
	Wed, 12 Mar 2025 05:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741758061; cv=none; b=M8JFBZ8xE8YMHNnXBxi8SDIpPu0HgDBGZRC2StWnqePM3gv3keMecKfq/nco4eSwxJXsyL9XqeQ62p+A0CHQ6DEoGhojWNLCI6pkDcFeMAqnOu3bFp0SIIveCjq5XbDgwQNFuQcHiyL41vbmjQLKg/30Ewaxl317NtYwfpk0x3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741758061; c=relaxed/simple;
	bh=YR6+58OeVkHdsVvzYqgy2lN8KgjcbpEngNCeGaFoAVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNnK/pdgg3smFNWxsLpMQIkPKHapm9GQAmEqeh7qE/ooD3MSITjdkInUsN5OhHvmYkJ3Otxl+ZF7sOmHzR4jiB7PG9CB6Hc+i27T+xxsByFV6V/FGQVuhjFldm+9d7GiIz9SL+tj4c0LyU87IZlq+Us7HY4rkpZQmgScE3FCxMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 11CD668C7B; Wed, 12 Mar 2025 06:40:54 +0100 (CET)
Date: Wed, 12 Mar 2025 06:40:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, liwang@redhat.com, brauner@kernel.org,
	hare@suse.de, willy@infradead.org, david@fromorbit.com,
	djwong@kernel.org, kbusch@kernel.org, john.g.garry@oracle.com,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, ltp@lists.linux.it, lkp@intel.com,
	oliver.sang@intel.com, oe-lkp@lists.linux.dev, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
Subject: Re: [PATCH] block: add BLK_FEAT_LBS to check for PAGE_SIZE limit
Message-ID: <20250312054053.GA12234@lst.de>
References: <20250312050028.1784117-1-mcgrof@kernel.org> <20250312052155.GA11864@lst.de> <Z9Edl05uSrNfgasu@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9Edl05uSrNfgasu@bombadil.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 11, 2025 at 10:37:27PM -0700, Luis Chamberlain wrote:
> > If you need extra per-driver validatation, do it in the driver.
> 
> Are you suggesting we just move back the PAGE_SIZE check,

PAGE_SIZE now is a consumer (i.e. file system) limitation.  Having
a flag in the provider (driver) does not make sense.

> or to keep
> the checks for the block driver limits into each driver?

Most drivers probably don't have a limit other than than that implicit
by the field width used for reporting.  So in general the driver should
not need any checks.  The only exceptions might be for virtual drivers
where the value comes from userspace, but even then it is a bit doubtful.


