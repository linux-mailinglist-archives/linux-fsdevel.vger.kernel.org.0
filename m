Return-Path: <linux-fsdevel+bounces-21018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A64658FC5BF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 10:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6FE1C212EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 08:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DBC18FDAF;
	Wed,  5 Jun 2024 08:14:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94374965A;
	Wed,  5 Jun 2024 08:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575255; cv=none; b=LtSukyoIV2LzCvnWrfZcywAkm7Az+MOIxrxElTxB/QpCoYKcsODHc36OxZcVJnEMiuDlYFkMJsHNssJyI9g+9ZHMePlXbZe20i6xoRY0b+UFFnrc4MqwPQ8Cek+Ku6SCrNeH1SERHGNQkEWXVyftFlTSpP1eUzcLqNHCeKqu78o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575255; c=relaxed/simple;
	bh=82v2m1L+3skRACTF6tKIP0huvHsWjzrf7dlcSWAmHso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loWXAClV6+IU47xNgLJSo2hpLzGiC22dNIllmXuT8Xko4bVtbcuBkgr/hNfjmPg6E9xONnAfBN7GSqR8yH7VcK+MWwFspS6jgoGURFMs5tz/FAAa/8UyC9XA+xM817jf+xdYrzDt9ImmnTfQrtP18YIMkzdp1o5wMmspRpoqXsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 14B8567373; Wed,  5 Jun 2024 10:14:08 +0200 (CEST)
Date: Wed, 5 Jun 2024 10:14:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
	damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
	joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 00/12] Implement copy offload support
Message-ID: <20240605081407.GA18688@lst.de>
References: <20240604043242.GC28886@lst.de> <393edf87-30c9-48b8-b703-4b8e514ac4d9@suse.de> <5441b256-494a-4344-89fd-ee8c5a073f8b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5441b256-494a-4344-89fd-ee8c5a073f8b@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 04, 2024 at 04:39:25PM +0900, Damien Le Moal wrote:
> > But I wasn't aware that this approach is limited to copying within a 
> > single block devices; that would be quite pointless indeed.
> 
> Not pointless for any FS doing CoW+Rebalancing of block groups (e.g. btrfs) and
> of course GC for FSes on zoned devices. But for this use case, an API allowing
> multiple sources and one destination would be better.

Yes.

