Return-Path: <linux-fsdevel+bounces-66928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 552E0C30C1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 12:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129EF1897A99
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 11:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1515F2E972A;
	Tue,  4 Nov 2025 11:35:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D562D8DA3;
	Tue,  4 Nov 2025 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762256142; cv=none; b=g34cXEF7NK4AZ/oHroNRTbCoA73tp7nXDrwFgedHimqNqDTbAMGw5Hmh6SNUq2AiZ/t2jSfVOYnB06EvnnPWrdvJrQuHJCTdthM/JeyIdUgh9IWLW1I31XUMqyIazsh58CQ4MiYxCJtXrA25m7XQKi5mplwKuLdx0tUp0fNzNg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762256142; c=relaxed/simple;
	bh=/2+/x3sO/+F7ImXUwtGE8QJTGQj23rd60LUxSwDhPuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETC1P4xOd4Wth1fMkO8yf+Ij4V7E/VXSPZ3xR7z3QF+wbjniFM4MgaC/QdYPVAjxdjkgbMKAvhT06hSmnMrlwwMPeWymbzRQkMyu3q2l8yaax5b5AXcwyGcfrQHFPUjeWnUuLXKUgCk3jtsJK03oxkV9M9lcrTBNBB26/5LGLk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 11D27227A8E; Tue,  4 Nov 2025 12:35:36 +0100 (CET)
Date: Tue, 4 Nov 2025 12:35:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Carlos Llamas <cmllamas@google.com>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	axboe@kernel.dk, Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv4 5/8] iomap: simplify direct io validity check
Message-ID: <20251104113535.GA14479@lst.de>
References: <aP-c5gPjrpsn0vJA@google.com> <aP-hByAKuQ7ycNwM@kbusch-mbp> <aQFIGaA5M4kDrTlw@google.com> <20251028225648.GA1639650@google.com> <20251028230350.GB1639650@google.com> <20251029070618.GA29697@lst.de> <20251030174015.GC1624@sol> <20251031091820.GA9508@lst.de> <20251103181031.GI1735@sol> <aQjzwh3iAQREjndH@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQjzwh3iAQREjndH@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 03, 2025 at 11:26:10AM -0700, Keith Busch wrote:
> I've been using these memory alignment capabilities in production for
> quite some time without issue on real hardware, and it's proven very
> useful at reducing memory and cpu utilization because that's really how
> the data alignment comes into the services responisble for running the
> disk io, and the alignment is outside the service's control.
> 
> Christoph is testing different use cases with check summing and finding
> much of the infrastructure wasn't ready to accept the more arbitrary
> memory offsets and lengths.

Well, I've mostly just wired up the alignment reporting to the legacy
XFS ioctl, and now xfstests actually tried it.  Which found breakage
in the PI code and in null_blk pretty quickly, and I suspect it might
find more in drivers that access the data in software and don't just
DMA map it.


