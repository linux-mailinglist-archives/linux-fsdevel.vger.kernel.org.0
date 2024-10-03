Return-Path: <linux-fsdevel+bounces-30879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8420798EFEC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 15:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 834FC1C20ACD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 13:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A741993A9;
	Thu,  3 Oct 2024 13:03:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC0714D6ED;
	Thu,  3 Oct 2024 13:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727960586; cv=none; b=PxAVJku9goLuUKz3hU8JnO8dDCh2M6r3inYHCVMCadc1s4w9o2qmqugOt5rhSC5+zVCmTwbwy5fH2hp5qXXDtMwxs+BiH2cKVagPJdIj5OMI3wmHiVS2rwB8qlrE6AEjXLLfAmtOE6+VmUe2gQgbH4HBSBC3fmTDCm9Fd40qklU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727960586; c=relaxed/simple;
	bh=6tk8uHOm+fbBYCYxJ4bTeoO0K6O3UBI0CimSVl1/7T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9xP9awc+9pjTRQ3xN/+MykHDYfcmGFreCdDiKFrY1bcxeSww0JuAXa80J4gpiy4WdbfguwE0P0v/H638e6T8V5MG+oBPtl7ndTQ4KZs+ba0frWhG3623jPLHdUDT+iFyt2lVAOKs/Es1BUULj907cu7Y+abSN+p9uf0/s/fRbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 124CC227A88; Thu,  3 Oct 2024 15:02:59 +0200 (CEST)
Date: Thu, 3 Oct 2024 15:02:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com,
	hch@lst.de, cem@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	martin.petersen@oracle.com, catherine.hoang@oracle.com,
	mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH v6 4/7] xfs: Support FS_XFLAG_ATOMICWRITES
Message-ID: <20241003130258.GA18099@lst.de>
References: <20240930125438.2501050-1-john.g.garry@oracle.com> <20240930125438.2501050-5-john.g.garry@oracle.com> <06344e9f-a625-4f6e-8b23-329ee8ebf67f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06344e9f-a625-4f6e-8b23-329ee8ebf67f@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 03, 2024 at 01:48:41PM +0100, John Garry wrote:
> On 30/09/2024 13:54, John Garry wrote:
>> @@ -352,11 +352,15 @@ xfs_sb_has_compat_feature(
>>   #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
>>   #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
>>   #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
>> +#define XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES (1 << 31)	/* atomicwrites enabled */
>> +
>
> BTW, Darrick, as you questioned previously, this does make xfs/270 fail... 
> until the change to a not use the top bit.

With the large block size based atomic writes we shoudn't even need
a feature flag, or am I missing something?


