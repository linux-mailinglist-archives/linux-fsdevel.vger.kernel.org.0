Return-Path: <linux-fsdevel+bounces-69210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6347EC72736
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 07:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 4935129620
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 06:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544BD2FFFA8;
	Thu, 20 Nov 2025 06:52:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEA02F5319;
	Thu, 20 Nov 2025 06:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763621531; cv=none; b=ZotGz62ZbhoWRnAWbAWvjmvqcTouXa/9Y1eGafelTsCS/iB6NZDc6cSWK6yB/OIgoYDnL/eP8ZKSTJMGDV/hH3Bd4/w3VxGdzcYdQXuQ2R3m5+0Yf50igaDTiyOklhy/kh6KriwwaXTM1ylBarBVu7C97utW1CRcljHbmaetaD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763621531; c=relaxed/simple;
	bh=i/KihSSX9+LSl5yOgSmW6jRxfVmzCaI0omsaGpIxrIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzzAkZquymIvN1jOUBNl1yCmg2kyOvwY4fg1+z8pR4t95zMZP/LMSTXtYlu5qqUzGfKvSFrVDkrk/CKUC7xjnpCCDGnT5E78vW3u41uOHv3ftA7fNxpqu05hPjUMwY3nU66m3GgLSb7JNexx8x0fqf6pegV4R4JFqlMC5rx2P/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 54563227A88; Thu, 20 Nov 2025 07:52:05 +0100 (CET)
Date: Thu, 20 Nov 2025 07:52:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Christoph Hellwig <hch@lst.de>,
	jlayton@kernel.org, neilb@ownmail.net, okorniev@redhat.com,
	tom@talpey.com, alex.aring@gmail.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 3/3] FSD: Fix NFS server hang when there are
 multiple layout conflicts
Message-ID: <20251120065205.GC30432@lst.de>
References: <20251115191722.3739234-1-dai.ngo@oracle.com> <20251115191722.3739234-4-dai.ngo@oracle.com> <d7888dd6-c238-45e0-94c0-ac82fb90d6b6@oracle.com> <18135047-8695-4190-b7ca-b7575d9e4c6c@oracle.com> <20251119100526.GA25962@lst.de> <dc1e0443-5112-4a5d-9b3c-294e32ab7ed4@oracle.com> <f30bf78c-9bcf-4ed2-a73a-fe8854e19def@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f30bf78c-9bcf-4ed2-a73a-fe8854e19def@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 19, 2025 at 09:06:27AM -0800, Dai Ngo wrote:
> Up until at least 6.15-rc6, this is in xfs_fs_get_uuid:
>
> xfs_warn_experimental(mp, XFS_EXPERIMENTAL_PNFS);

That's really just for the XFS layout exporting.  It just happened
to be placed there and thus was more or less accidentally skipped
for the SCSI layout.


