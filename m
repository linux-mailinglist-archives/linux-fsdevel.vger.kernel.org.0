Return-Path: <linux-fsdevel+bounces-48165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B93B6AABA1D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5753A188E9FC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 07:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E37207A16;
	Tue,  6 May 2025 04:39:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575552BD03F;
	Tue,  6 May 2025 04:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746505371; cv=none; b=HSt/selic8ZyCwwwPoMDYiw0f9S4sYRFzv7qKjrHBg7ab+/W0cvR/bhlqWyXt0aXDfUOx1h9qInOFrwAAM22ex+LQ6tXZDXpzbD9M7fA5KF3ChJXzy+bNFZlGwe28xC0ymefoCzTjbCliioRuzylFyMHNyk+AZRcT782++Ns3Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746505371; c=relaxed/simple;
	bh=dUnyonXps9Hj2gJJF9TI4PC9uOAgo51Hbpb/TfEXCBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ls2v2gBnoRlb+pFExutUJVrzvdLnQ/JbAPyuK71ASj/7Oo3GmDMeFxc8Og7uSAU1U8VXYOw9ySgoKICR+ULi/z/UB65NgDxRX7QdnoqjfFibc/62ePneRTsWJRn10C9k5cToSwVXRzNlec/L8zvP0PzOP0nTcPTynINOQqTqdv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BB4C667373; Tue,  6 May 2025 06:22:42 +0200 (CEST)
Date: Tue, 6 May 2025 06:22:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v11 02/16] xfs: only call xfs_setsize_buftarg once per
 buffer target
Message-ID: <20250506042242.GA26378@lst.de>
References: <20250504085923.1895402-1-john.g.garry@oracle.com> <20250504085923.1895402-3-john.g.garry@oracle.com> <20250505054031.GA20925@lst.de> <8ea91e81-9b96-458e-bd4e-64eada31e184@oracle.com> <20250505104901.GA10128@lst.de> <bb8efa28-19e6-42f5-9a26-cdc0bc48926e@oracle.com> <20250505142234.GG1035866@frogsfrogsfrogs> <40def355-38db-4424-b9f0-b82bba62462b@oracle.com> <200d855d-550d-4207-9118-6a0c10d14f8a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200d855d-550d-4207-9118-6a0c10d14f8a@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 05, 2025 at 04:27:56PM +0100, John Garry wrote:
> On 05/05/2025 15:48, John Garry wrote:
>>>> @Darrick, please comment on whether happy with changes discussed.
>>> I put the sync_blockdev calls in a separate function so that the
>>> EIO/ENOSPC/whatever errors that come from the block device sync don't
>>> get morphed into ENOMEM by xfs_alloc_buftarg before being passed up.  I
>>> suppose we could make that function return an ERR_PTR, but I was trying
>>> to avoid making even more changes at the last minute, again.
>>
>> It seems simpler to just have the individual sync_blockdev() calls from 
>> xfs_alloc_buftarg(), rather than adding ERR_PTR() et al handling in both 
>> xfs_alloc_buftarg() and xfs_open_devices().
>
> Which of the following is better:

To me version 2 looks much better.  I had initial reservations as
ERR_PTR doesn't play well with userspace, but none of this code is
in libxfs, so that should be fine.


