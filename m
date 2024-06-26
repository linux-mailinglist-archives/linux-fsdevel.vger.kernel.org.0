Return-Path: <linux-fsdevel+bounces-22476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9321F917803
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 07:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F58F284B15
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 05:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194E914830C;
	Wed, 26 Jun 2024 05:22:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF9B28DDF;
	Wed, 26 Jun 2024 05:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719379366; cv=none; b=e0HtLqusZeoomQQYgUzu0UNakTdokgv4R/WfEC4P3+uI+SHV+1hpgZsBkyDbzTKqv1rCFx0GgzVFvNy+D1pxzcwxkZDztyC27kbR5qFBNyaruTsB+lrn0S8QougkWxtJ/NRPrWjDTueRivccsouPsxtHi3uGKo7yYcWAIRtgQFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719379366; c=relaxed/simple;
	bh=4J1gRg7GEgUIDrpBJA7ovYIvxdiLeq8+P2V7QmUaA58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2ShHy2pLiRs59nDL+vl32hO/uja16Hzfy7/w8qvi74qUdMWWo6LAoFCgs2M821dklrvrV3DYmMJyOFvQ4lEgDK58Jj9/VONdV16JsIAPBXOnaDz8weDKS8Pqpe+H308KGOd/+V62tv0YMff1GYtrqxKCEkIQR+WuBUEnDTW8dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 04B43227A87; Wed, 26 Jun 2024 07:22:39 +0200 (CEST)
Date: Wed, 26 Jun 2024 07:22:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, david@fromorbit.com, hare@suse.de,
	damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
	joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
Message-ID: <20240626052238.GC21996@lst.de>
References: <d7ae00c8-c038-4bed-937e-222251bc627a@acm.org> <20240604044042.GA29094@lst.de> <4ffad358-a3e6-4a88-9a40-b7e5d05aa53c@acm.org> <20240605082028.GC18688@lst.de> <CGME20240624105121epcas5p3a5a8c73bd5ef19c02e922e5829a4dff0@epcas5p3.samsung.com> <6679526f.170a0220.9ffd.aefaSMTPIN_ADDED_BROKEN@mx.google.com> <4ea90738-afd1-486c-a9a9-f7e2775298ff@acm.org> <de54c406-9270-4145-ab96-5fc3dd51765e@kernel.org> <b5d93f2c-29fc-4ee4-9936-0f134abc8063@acm.org> <05c7c08d-f512-4727-ae3c-aba6e8f2973f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05c7c08d-f512-4727-ae3c-aba6e8f2973f@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 26, 2024 at 06:18:18AM +0900, Damien Le Moal wrote:
> 
> DM can deal with "abnormal" BIOs on its own. There is code for that.
> See is_abnormal_io() and __process_abnormal_io(). Sure, that will need more code
> compared to a bio sector+size based simple split, but I do not think it is a big
> deal given the potential benefits of the offloading.

It's not just dm.  You also need it in the partition remapping code
(mandatory), md (nice to have), etc.

And then we have the whole mess of what is in the payload for the I/O
stack vs what is in the payload for the on the wire protocol, which
will have different formatting and potentially also different sizes.

