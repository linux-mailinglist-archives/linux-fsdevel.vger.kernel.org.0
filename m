Return-Path: <linux-fsdevel+bounces-50092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E882AC81EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 19:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2946C16DF75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 17:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B9F230273;
	Thu, 29 May 2025 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fca5W3M5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C59422D4F1;
	Thu, 29 May 2025 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748541577; cv=none; b=n9cBpvc5zJeNeTHAvSSfZshConC/JeSlupJTmOVb+HhefS3nIBJyQAqe29Exq97xFhu7xDMCd59bo7nDphB5FuWWPuOwf3Nf473TtvbLLw9mWUxc8YR5ixqyR3pm4ZdrcFFUuxAMhaf1HpuS80N4h6wjhz7o36GpT0ibk+baH9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748541577; c=relaxed/simple;
	bh=ZW2tfBQelVZkdy5J7YvgyQhVUxy9mAiO4Cq3y2pflG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tnb2hrT2MxxnCzeb2l5Z0rDsppZzNUhFaeOpjR6wm78SMW/d8vr7gHaKErYdUfdqd61BiWSAptA5jg2hLiMfKSIYon7HnVe7rXCy14SNtZI/ZluuDj8j0meMygqCqW2XSZCxUDUriR6q304dWh3OUbgs5tloClP3ynBI8PbQtdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fca5W3M5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A043C4CEE7;
	Thu, 29 May 2025 17:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748541576;
	bh=ZW2tfBQelVZkdy5J7YvgyQhVUxy9mAiO4Cq3y2pflG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fca5W3M5TIXGdK6VszjqbDgakEsx+wuFDKD+RcbaA7IsG2kB9uzAme9vusmJPrJQ9
	 79fo+py5LxG4TWnNcZIeL9eDtAHMq/byaQ4dQmXLuI1sQdRrpCTGvJWOwWbom+XDaY
	 Ku8AxdPoady8vHtGFocyYTPYHy4sYmmvswttwBurIzd6mU2Db4TKqoU20rUdx0eEXN
	 sa3bceXmBcBLYM83HYuIagAyUjuUpZhWAFmuRVGPWQzEIU+BpJT8bWAict+JeZbUoJ
	 CTOhfc5mDZBAkrXbAIQSaPvpgNYb/UUXuzSWapzEfaPT7+xkDj979FxCMKQv1sUEtk
	 0aGxELR2rD8Gg==
Date: Thu, 29 May 2025 17:59:34 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, jack@suse.cz,
	anuj1072538@gmail.com, axboe@kernel.dk, viro@zeniv.linux.org.uk,
	brauner@kernel.org, hch@infradead.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com
Subject: Re: [RFC] fs: add ioctl to query protection info capabilities
Message-ID: <20250529175934.GB3840196@google.com>
References: <CGME20250527105950epcas5p1b53753ab614bf6bde4ffbf5165c7d263@epcas5p1.samsung.com>
 <20250527104237.2928-1-anuj20.g@samsung.com>
 <yq1jz60gmyv.fsf@ca-mkp.ca.oracle.com>
 <fec86763-dd0e-4099-9347-e85aa4a22277@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fec86763-dd0e-4099-9347-e85aa4a22277@samsung.com>

On Thu, May 29, 2025 at 12:42:45PM +0530, Anuj Gupta/Anuj Gupta wrote:
> On 5/29/2025 8:32 AM, Martin K. Petersen wrote:
> > 
> > Hi Anuj!
> > 
> > Thanks for working on this!
> > 
> Hi Martin,
> Thanks for the feedback!
> 
> >> 4. tuple_size: size (in bytes) of the protection information tuple.
> >> 6. pi_offset: offset of protection info within the tuple.
> > 
> > I find this a little confusing. The T10 PI tuple is <guard, app, ref>.
> > 
> > I acknowledge things currently are a bit muddy in the block layer since
> > tuple_size has been transmogrified to hold the NVMe metadata size.
> > 
> > But for a new user-visible interface I think we should make the
> > terminology clear. The tuple is the PI and not the rest of the metadata.
> > 
> > So I think you'd want:
> > 
> > 4. metadata_size: size (in bytes) of the metadata associated with each interval.
> > 6. pi_offset: offset of protection information tuple within the metadata.
> > 
> 
> Yes, this representation looks better. Will make this change.
> 
> >> +#define	FILE_PI_CAP_INTEGRITY		(1 << 0)
> >> +#define	FILE_PI_CAP_REFTAG		(1 << 1)
> > 
> > You'll also need to have corresponding uapi defines for:
> > 
> > enum blk_integrity_checksum {
> >          BLK_INTEGRITY_CSUM_NONE         = 0,
> >          BLK_INTEGRITY_CSUM_IP           = 1,
> >          BLK_INTEGRITY_CSUM_CRC          = 2,
> >          BLK_INTEGRITY_CSUM_CRC64        = 3,
> > } __packed ;
> >
> 
> Right, I'll add these definitions to the UAPI.

Would it make sense to give the CRCs clearer names?  For example CRC16_T10DIF
and CRC64_NVME.

- Eric

