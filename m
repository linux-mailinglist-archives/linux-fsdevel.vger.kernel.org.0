Return-Path: <linux-fsdevel+bounces-21087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A50F98FDE63
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 07:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581001F25DF4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 05:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCC540BE5;
	Thu,  6 Jun 2024 05:56:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EF938384;
	Thu,  6 Jun 2024 05:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717653378; cv=none; b=mPb+PD2U3BlbScu7MEgdtj7vhYng+n90/SJTerJQ+qy0Yu8OwhzDIYmraDvRBPPArTXe/kaIpe8gM1vZlRE4uVrXI0id64/SFP5HBSRhyXkih8h7XUE1rcB67sucxR+/a2sZpIEFJPRaQm6z+IlSIHlcQjuB2bD91FDZ5QTE2gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717653378; c=relaxed/simple;
	bh=+onNZkVXBC2e2U49WLtGBQYSo60QizKXolbb1+gx7Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JbmjnJwbkG76VQ89e3p11pDc7Zw2ZObt9DwTmBjljgS0YnEgDyoZrOGABvdnf6b9b3wui+NpYJadCT88HigJqzKqk+h4ScNrvDxoa2IqxFaicTvGt3gX5p6/SBM4KbVFT/11LzS4qOaeFq0NqMw9X9RZsr2dcbxWkqJpZRXtkZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6AACE68CFE; Thu,  6 Jun 2024 07:56:11 +0200 (CEST)
Date: Thu, 6 Jun 2024 07:56:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
	hare@suse.de, damien.lemoal@opensource.wdc.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
	gost.dev@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 03/12] block: add copy offload support
Message-ID: <20240606055611.GA9404@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 04, 2024 at 10:50:26AM +0000, Nitesh Shetty wrote:
>>> +	if (!cio)
>>> +		return -ENOMEM;
>>> +	atomic_set(&cio->refcount, 1);
>>> +	cio->waiter = current;
>>> +	cio->endio = endio;
>>> +	cio->private = private;
>>
>> For the main use this could be allocated on-stack.  Is there any good
>> reason to not let callers that really want an async version to implement
>> the async behavior themselves using suitable helpers?
>>
> We cannot do on-stack allocation of cio as we use it in endio handler.
> cio will be used to track partial IO completion as well.
> Callers requiring async implementation would need to manage all this
> bookkeeping themselves, leading to duplication of code. We felt it is
> better to do it here onetime.
> Do you see it any differently ?

We don't really to these async variants for other in-kernel I/O,
so unless we have a really good reason I'd not do here.  The usual
approach is to just have a submission helper for async in-kernel
special bios types, and the let the caller handle the rest.


