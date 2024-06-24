Return-Path: <linux-fsdevel+bounces-22255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9139153A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 18:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB64E286CBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 16:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167EE19DFB8;
	Mon, 24 Jun 2024 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ikAL02jY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD69136995;
	Mon, 24 Jun 2024 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246348; cv=none; b=X7CZ+tg0GPxGFnFrQhWuII1ocEzv9bOG8krc1l0BHz6AmUQ09oU/YvC0Yj5CxPWyVPjk+wzhLtIBdbvT/JD+I7eEj8O+JjfEgxsOueYl2be1qKJuQuUgzYuRoH4KEUe7Za3WqQvio3YDpGOxw2i5rJ2IMPyAKr2Lp1tIDfWqmno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246348; c=relaxed/simple;
	bh=zc7081Y21FlTdwB7r1y80IdIKdEYx/IpzSp3yAgMxRY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FW3RKJMMA+n8u/f7LhiJvR2tJ6h4yf4/iEDIug2t9oWXtq4hIb2E0gqdEU2aD/wGB0vP+ax3WvSXh8oWAFL6HET9R3QH+7c8fOyWCgUFmaWoI20w03oQbQGkKpsMirYMKnSuZNL1QgUUcd6IPWoLxvynM3+xEuQ1rWYDzQtweys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ikAL02jY; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4W7Cxc1b4Czll9bs;
	Mon, 24 Jun 2024 16:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:content-language:references:subject:subject:from:from
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1719246327; x=1721838328; bh=5YRbJCfER9/t7o2py5oZPcEO
	b9O2alYeZUroDpPtXOU=; b=ikAL02jYcnW8oADCx4MyOFEykz3GGfzi6eWwiW9Z
	qiD+dR0/fHNfI+Q6K0nONWMiiVlJ+aAomIKaZSKGu22m5ca76dqZkTNzCzXVftDr
	j0DYgelboKWwKWHnBg+NV9g5B+h9mdpeKGFBC9vYwx6dye62o4gF7YLMcCV3+xMy
	cnnlClziVI0W0ib/ncr7xzIVqTP/82AlTek/vbofMTYNyQaw7t5/parPScAR+eIs
	ZWUEAB6AU5kfaH2lpyKjHEugC6rLSzGQualGEX1d9T5ytrnrpbdAE0IzQvz6FYTd
	0ng0XDcORkIuLC53eCL7RCfIuhaNHKotvbEgrm+nv0kfJg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id fRVPZY9Z3RGh; Mon, 24 Jun 2024 16:25:27 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4W7CxF1FMyzll9br;
	Mon, 24 Jun 2024 16:25:20 +0000 (UTC)
Message-ID: <4ea90738-afd1-486c-a9a9-f7e2775298ff@acm.org>
Date: Mon, 24 Jun 2024 09:25:19 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
To: Nitesh Shetty <nj.shetty@samsung.com>, Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, martin.petersen@oracle.com, david@fromorbit.com,
 hare@suse.de, damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
 joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <eda6c198-3a29-4da4-94db-305cfe28d3d6@acm.org>
 <9f1ec1c1-e1b8-48ac-b7ff-8efb806a1bc8@kernel.org>
 <a866d5b5-5b01-44a2-9ccb-63bf30aa8a51@acm.org>
 <665850bd.050a0220.a5e6b.5b72SMTPIN_ADDED_BROKEN@mx.google.com>
 <abe8c209-d452-4fb5-90eb-f77b5ec1a2dc@acm.org> <20240601055931.GB5772@lst.de>
 <d7ae00c8-c038-4bed-937e-222251bc627a@acm.org>
 <20240604044042.GA29094@lst.de>
 <4ffad358-a3e6-4a88-9a40-b7e5d05aa53c@acm.org>
 <20240605082028.GC18688@lst.de>
 <CGME20240624105121epcas5p3a5a8c73bd5ef19c02e922e5829a4dff0@epcas5p3.samsung.com>
 <6679526f.170a0220.9ffd.aefaSMTPIN_ADDED_BROKEN@mx.google.com>
Content-Language: en-US
In-Reply-To: <6679526f.170a0220.9ffd.aefaSMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/24 3:44 AM, Nitesh Shetty wrote:
> For reference, I have listed the approaches we have taken in the past.
> 
> a. Token/payload based approach:
> 1. Here we allocate a buffer/payload.
> 2. First source BIO is sent along with the buffer.
> 3. Once the buffer reaches driver, it is filled with the source LBA
> and length and namespace info. And the request is completed.
> 4. Then destination BIO is sent with same buffer.
> 5. Once the buffer reaches driver, it retrieves the source information from
> the BIO and forms a copy command and sends it down to device.
> 
> We received feedback that putting anything inside payload which is not
> data, is not a good idea[1].

A token-based approach (pairing copy_src and copy_dst based on a token)
is completely different from a payload-based approach (copy offload
parameters stored in the bio payload). From [1] (I agree with what has
been quoted): "In general every time we tried to come up with a request
payload that is not just data passed to the device it has been a
nightmare." [ ... ] "The only thing we'd need is a sequence number / idr
/ etc to find an input and output side match up, as long as we
stick to the proper namespace scope."

> c. List/ctx based approach:
> A new member is added to bio, bio_copy_ctx, which will a union with
> bi_integrity. Idea is once a copy bio reaches blk_mq_submit_bio, it will
> add the bio to this list.
> 1. Send the destination BIO, once this reaches blk_mq_submit_bio, this
> will add the destination BIO to the list inside bi_copy_ctx and return
> without forming any request.
> 2. Send source BIO, once this reaches blk_mq_submit_bio, this will
> retrieve the destination BIO from bi_copy_ctx and form a request with
> destination BIO and source BIO. After this request will be sent to
> driver.
> 
> This work is still in POC phase[2]. But this approach makes lifetime
> management of BIO complicated, especially during failure cases.

Associating src and dst operations by embedding a pointer to a third
data structure in struct bio is an implementation choice and is not the
only possibility for assocating src and dst operations. Hence, the
bio lifetime complexity mentioned above is not inherent to the list
based approach but is a result of the implementation choice made for
associating src and dst operations.

Has it been considered to combine the list-based approach for managing
unpaired copy operations with the token based approach for pairing copy
src and copy dst operations?

Thanks,

Bart.

