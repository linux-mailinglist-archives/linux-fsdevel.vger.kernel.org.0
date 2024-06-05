Return-Path: <linux-fsdevel+bounces-21020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C07318FC62F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 10:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F11B1F24584
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 08:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C96D193093;
	Wed,  5 Jun 2024 08:20:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5192E193080;
	Wed,  5 Jun 2024 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575636; cv=none; b=pACCY9viVNTzZxRpPVmcZtcDPpSw7rDAmtCNIyY91Uocr+4bJ6jMIFK5u0Tq/mLr6/1d0ZLofjHO++h+JEnv0lCpthrUGnoaKUNeQRmrRARnHCvE54vslraYNNfVm51hRCLPdsdGiCBUflIti/M3hYn9KqKBd0XjnhwaxXj/ndU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575636; c=relaxed/simple;
	bh=196DRXrCJn+tQRx2ZKFZsFFDrXq1ezqD5rJSeNZaSDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXa/PcvValDBgrNS63iRTVcYhDFJ1kER6qyQg8RpJRkhtknIH6fDJp9q9RnmKrfY8zSSRovNgRew4yDjV0xIf8YzEN/RkPv8nt8kW0USt9mNg4T2KlKUTd/wwqcrJomiU9ZPDNCZqQqSz8hYPZ5PjTneJ+z5eM5DfddjlKwrsJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3369B67373; Wed,  5 Jun 2024 10:20:29 +0200 (CEST)
Date: Wed, 5 Jun 2024 10:20:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Nitesh Shetty <nj.shetty@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
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
Message-ID: <20240605082028.GC18688@lst.de>
References: <20240520102033.9361-3-nj.shetty@samsung.com> <eda6c198-3a29-4da4-94db-305cfe28d3d6@acm.org> <9f1ec1c1-e1b8-48ac-b7ff-8efb806a1bc8@kernel.org> <a866d5b5-5b01-44a2-9ccb-63bf30aa8a51@acm.org> <665850bd.050a0220.a5e6b.5b72SMTPIN_ADDED_BROKEN@mx.google.com> <abe8c209-d452-4fb5-90eb-f77b5ec1a2dc@acm.org> <20240601055931.GB5772@lst.de> <d7ae00c8-c038-4bed-937e-222251bc627a@acm.org> <20240604044042.GA29094@lst.de> <4ffad358-a3e6-4a88-9a40-b7e5d05aa53c@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ffad358-a3e6-4a88-9a40-b7e5d05aa53c@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 04, 2024 at 04:44:34AM -0700, Bart Van Assche wrote:
> On 6/3/24 21:40, Christoph Hellwig wrote:
>> There is no requirement to process them synchronously, there is just
>> a requirement to preserve the order.  Note that my suggestion a few
>> arounds ago also included a copy id to match them up.  If we don't
>> need that I'm happy to leave it away.  If need it it to make stacking
>> drivers' lifes easier that suggestion still stands.
>
> Including an ID in REQ_OP_COPY_DST and REQ_OP_COPY_SRC operations sounds
> much better to me than abusing the merge infrastructure for combining
> these two operations into a single request. With the ID-based approach
> stacking drivers are allowed to process copy bios asynchronously and it
> is no longer necessary to activate merging for copy operations if
> merging is disabled (QUEUE_FLAG_NOMERGES).

Again, we can decided on QUEUE_FLAG_NOMERGES per request type.  In fact
I think we should not use it for discards as that just like copy
is a very different kind of "merge".

I'm in fact much more happy about avoiding the copy_id IFF we can.  It
it a fair amout of extra overhead, so we should only add it if there
is a real need for it

