Return-Path: <linux-fsdevel+bounces-29174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 488DE9769E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 15:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B1171C23569
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 13:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1281AD24C;
	Thu, 12 Sep 2024 13:02:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA559476;
	Thu, 12 Sep 2024 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146162; cv=none; b=LuB1Ouxvs4mTDe9DkmuzaDXCw8UCkHIGO/p6d0e3QDmu9sXO+lTZOzQvWA/gh5uHhmf7BKO/Sd9NsD/MnYyqvdzkrMPz0FpcO2PVmZRjXVI9Apg4PxtPegHxn0Y8BvHD77pm09Y/uF9TLMX0dk23xhyuyhW2ljYIQ48+mh1zYXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146162; c=relaxed/simple;
	bh=QwAHdTQJHs6W72c/INk3Cz2vhGcrWt0wrNUpAIllwL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYuqdeExz2YnsKzOXcGyYnXq7aflqbKD6MIsrYhFq4pnQdr0GoZG+MFbzKhtHYg6itF7KMzs6KveVL2E4ZpIf5lgtkWpSwZw+nrXfpe1r7Zaz6or4iWWvpXIs1BDC2oueHBlWPycDdJbWDzhC8RWSDTDq7Vw2f37VKYrxqe2bVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 61F9A227AB7; Thu, 12 Sep 2024 15:02:36 +0200 (CEST)
Date: Thu, 12 Sep 2024 15:02:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com,
	bvanassche@acm.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com,
	vishak.g@samsung.com, javier.gonz@samsung.com,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v5 4/5] sd: limit to use write life hints
Message-ID: <20240912130235.GB28535@lst.de>
References: <20240910150200.6589-1-joshi.k@samsung.com> <CGME20240910151057epcas5p3369c6257a6f169b4caa6dd59548b538c@epcas5p3.samsung.com> <20240910150200.6589-5-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910150200.6589-5-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 10, 2024 at 08:31:59PM +0530, Kanchan Joshi wrote:
> From: Nitesh Shetty <nj.shetty@samsung.com>
> 
> The incoming hint value maybe either lifetime hint or placement hint.

.. may either be .. ?

> Make SCSI interpret only temperature-based write lifetime hints.
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
>  drivers/scsi/sd.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index dad3991397cf..82bd4b07314e 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -1191,8 +1191,8 @@ static u8 sd_group_number(struct scsi_cmnd *cmd)
>  	if (!sdkp->rscs)
>  		return 0;
>  
> -	return min3((u32)rq->write_hint, (u32)sdkp->permanent_stream_count,
> -		    0x3fu);
> +	return min3((u32)WRITE_LIFETIME_HINT(rq->write_hint),

No fan of the screaming WRITE_LIFETIME_HINT.    Or the fact that multiple
things are multiplexed into the single rq->write_hint field to
start with.

This code could also use a bit of documentation already in the existing
version, but even more so now.


