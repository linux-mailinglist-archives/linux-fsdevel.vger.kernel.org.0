Return-Path: <linux-fsdevel+bounces-47081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C423EA985BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 11:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C2823BD466
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 09:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD91263F52;
	Wed, 23 Apr 2025 09:36:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB3925CC54;
	Wed, 23 Apr 2025 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745401002; cv=none; b=pVcwWufsHfP5+3A5wWJdHqAnhp3LSvKtCk+cdaMOAYF1o54t06/Qrw+LAXzpIkXFl3SKxhUJYYguag55b3iGf4/VzGE7O0AaAV/9xZLP3l0ZFaBmZD8BidQLfjJ/QU9NlNNQjs82mkmwzuZhjGVb8PJl8vzCuSW20e7n2BYaSjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745401002; c=relaxed/simple;
	bh=ZoxpxyhXtsPNypA2hqQjiFLs7VljOLOOJXls54dQevA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXRNuPC+RSymnSMq9v4GJ0+4DkLHU1tBC2GUI0O4TpdVjPCdaD16fEAIqQRxTO7w2PvOCGtELBRoIOdU1oV7TOO2vZDnUiHdX4yfWTgbu/N/diBGLZA40z+H7ni+nDj6FW4aE/TJHztJQA0+jijpXxG7nMEURZfTcEixj2/ypsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7C33268AFE; Wed, 23 Apr 2025 11:36:36 +0200 (CEST)
Date: Wed, 23 Apr 2025 11:36:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, linux-bcache@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-btrfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 02/17] block: add a bdev_rw_virt helper
Message-ID: <20250423093636.GB2578@lst.de>
References: <20250422142628.1553523-1-hch@lst.de> <20250422142628.1553523-3-hch@lst.de> <af8353ec-3648-457c-aa68-99af6392a74c@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af8353ec-3648-457c-aa68-99af6392a74c@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Apr 23, 2025 at 08:07:19AM +0200, Hannes Reinecke wrote:
>>   +int submit_bio_wait(struct bio *bio);
>> +int bdev_rw_virt(struct block_device *bdev, sector_t sector, void *data,
>> +		size_t len, enum req_op op);
>> +
>>   int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
>>   void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter);
>>   void __bio_release_pages(struct bio *bio, bool mark_dirty);
>
> Any specific reason why the declaration of 'submit_bio_wait()' is moved?

To keep the related declarations together.


