Return-Path: <linux-fsdevel+bounces-20016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 594CA8CC612
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 20:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F2D2843E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 18:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C880146002;
	Wed, 22 May 2024 18:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="w4GG+Zk5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380BC145B1D;
	Wed, 22 May 2024 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716401138; cv=none; b=VXe+q0EJdEHIFtK/Zjhc63rcyUR0KrPGuUr3EzmVmUj+/PYJu4yPkkxvuK9dWPYwmI5v8+YyQsv2cWOJ23kgoLoj5bli9ohx5AHCXJj5phjo1PVxqK5+QRhf8CYj8yFivMyqbpjiP32uPK6VaHHwsYgUPyQjf+91rKxBN4zjZr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716401138; c=relaxed/simple;
	bh=luEwbZp5k3nkrHj86wxSaPapUg/Y1fNnfoeZAYeQvfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=byQi1sB9fc5AKcPLDq4w9f1u8UcKVLZNgw1C/V/zR6PRsMusKYuMEqbb8vrwAdKmDHEvvCQCeUtzntRhNsTaTe1F4JcEbmHFkW6sD6fYhfkgxHuneehsRVVG+s0UlppZ3ZePoonh8xzhyyMt0PxJOwu9Q5GnHCEK4+ycbm7rjPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=w4GG+Zk5; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Vkzk83zW8zlgMVN;
	Wed, 22 May 2024 18:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1716401127; x=1718993128; bh=L/Z8Mp/V6Xlw6wkYa899vAJP
	gD1/fbki4rEqLMN5kt0=; b=w4GG+Zk5K8I/0oN1UncHTyKd/Gk3/mstQgMKWu5t
	Ny7lWh1SNsdH2k/eerNIDbR63ln2fHwadLSxbN26wlaOya/Eb7PeDC2wO1wQKjb9
	3Kv/JR7I2jGtvACEHUtbbltKIsewEnPsGTXlFkdHY5VQDRMbOzG2Cwd8N6o6Kglt
	VAATPhWT8TLmUPmX550QPPAX33B17Mu07oRnRQwIO7d7FhOlbWoNQaN1AFJr+alO
	tSKLeozFvhzoY0vF+hxn0Q0phgYjUm0983n3BJ3WEMUeCawbvbeOWfDl6EKHKFRy
	nODt7HOx9vbzAwF9c3bzRHWDHD+tlt4k1IYNX1Ev1w+wxg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id F51LBj9xAtLQ; Wed, 22 May 2024 18:05:27 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Vkzjx0WdLzlgMVL;
	Wed, 22 May 2024 18:05:24 +0000 (UTC)
Message-ID: <97966085-d7a4-4238-a413-4cdac77af8bd@acm.org>
Date: Wed, 22 May 2024 11:05:24 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: martin.petersen@oracle.com, david@fromorbit.com, hare@suse.de,
 damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com>
 <20240520102033.9361-3-nj.shetty@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240520102033.9361-3-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/24 03:20, Nitesh Shetty wrote:
> We add two new opcode REQ_OP_COPY_DST, REQ_OP_COPY_SRC.
> Since copy is a composite operation involving src and dst sectors/lba,
> each needs to be represented by a separate bio to make it compatible
> with device mapper.
> We expect caller to take a plug and send bio with destination information,
> followed by bio with source information.
> Once the dst bio arrives we form a request and wait for source
> bio. Upon arrival of source bio we merge these two bio's and send
> corresponding request down to device driver.
> Merging non copy offload bio is avoided by checking for copy specific
> opcodes in merge function.

Plugs are per task. Can the following happen?
* Task A calls blk_start_plug()
* Task B calls blk_start_plug()
* Task A submits a REQ_OP_COPY_DST bio and a REQ_OP_COPY_SRC bio.
* Task B submits a REQ_OP_COPY_DST bio and a REQ_OP_COPY_SRC bio.
* Task A calls blk_finish_plug()
* Task B calls blk_finish_plug()
* The REQ_OP_COPY_DST bio from task A and the REQ_OP_COPY_SRC bio from
   task B are combined into a single request.
* The REQ_OP_COPY_DST bio from task B and the REQ_OP_COPY_SRC bio from
   task A are combined into a single request.

Thanks,

Bart.


