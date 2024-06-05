Return-Path: <linux-fsdevel+bounces-21019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D8F8FC607
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 10:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEC9B1C22B66
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 08:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C670190071;
	Wed,  5 Jun 2024 08:17:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F21F4963C;
	Wed,  5 Jun 2024 08:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575478; cv=none; b=ubed2u77+zRVcKxZs8pQbh0XxwQsYyB4IbCVUCxsf85Uh4ktGmpu1VJ/QC78/qF7mzx3UhOtJTEnArGOcAAM+60jxyc8+w0f00JPxZ9gVPyVKAiBwjY4UDqxs7lsMw5OpWR3z/9yBGLELjTRLf+VfFWWhNAIraxZZPPQdNXQ7jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575478; c=relaxed/simple;
	bh=juYGrTutr79jdUfWQOt3iuVA7qENFdoWQh8QbQTezE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DT9mtwkBPZiExBDs2PgP4W0izNYUhX2XrR4VU4ClewnAsQi/jew6S/UOpC+10n0ia/23lppBHzrrANzHm2gonT8aykhGE5YKKjOsYKbgfcUrhqzVgg2N0tbks5drlcDHlgQxRXSPHxQ6mD36OVf3zLMJBm2ianAU/yfG3YrtPsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6E1DB67373; Wed,  5 Jun 2024 10:17:49 +0200 (CEST)
Date: Wed, 5 Jun 2024 10:17:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Nitesh Shetty <nj.shetty@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
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
Subject: Re: [PATCH v20 01/12] block: Introduce queue limits and sysfs for
 copy-offload support
Message-ID: <20240605081749.GB18688@lst.de>
References: <20240604043142.GB28886@lst.de> <93f6bb98-e9b4-481e-afae-c2b4d90e686b@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93f6bb98-e9b4-481e-afae-c2b4d90e686b@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 04, 2024 at 09:05:03AM +0200, Hannes Reinecke wrote:
> On 6/4/24 06:31, Christoph Hellwig wrote:
>> On Mon, Jun 03, 2024 at 06:43:56AM +0000, Nitesh Shetty wrote:
>>>> Also most block limits are in kb.  Not that I really know why we are
>>>> doing that, but is there a good reason to deviate from that scheme?
>>>>
>>> We followed discard as a reference, but we can move to kb, if that helps
>>> with overall readability.
>>
>> I'm not really sure what is better.  Does anyone remember why we did
>> the _kb version?  Either way some amount of consistency would be nice.
>>
> If memory serves correctly we introduced the _kb versions as a convenience 
> to the user; exposing values in 512 bytes increments tended
> to be confusing, especially when it comes to LBA values (is the size in 
> units of hardware sector size? 512 increments? kilobytes?)

Maybe.  In the meantime I did a bit more of research, and only
max_sectors and max_hw_sectors are reported in kb.  chunk_sectors is
reported in 512 byte sectors, and everything else is reported in bytes.

So sticking to bytes is probably right, and I was wrong about "most block
limits above".  Sorry.


