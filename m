Return-Path: <linux-fsdevel+bounces-20012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB2A8CC5F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 19:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3F2A1F22070
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 17:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148BC145B3B;
	Wed, 22 May 2024 17:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="2NXb5bWG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA6282877;
	Wed, 22 May 2024 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716400727; cv=none; b=Hs0QEzdOhQWmbG8p9nQEIv7GaAidlgihz58UYKStVic6Q9aWfAp7g3wxWe4jXTvlRyazqhK+/3vZcfFThSA+M8xjY91XVm/AoycClm7KGiEM2parhCT4Gj/Nu3aZkn7WPhViVaVhXaYNd78tznh/wnpKDri/Y3vpyyHTrZD83DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716400727; c=relaxed/simple;
	bh=/fUnCyL4rXX2AQtUspHQvGeVSI9WBvUN5ojnjLO8HQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K2nM1n8VhxLPDYzb4oIufbWjoWxQyeLgqIt+wopOelZWXvphZaWq9+bUU4ljLmX8T4ix3ViLppDHmdHW3kQZGZshlJAwAW+0dw0VxZZFZu6T/k4NUUpmHLULYbrqbCBTx4pAZl6m1HwKeKZYZWxtoafl61he5N0mlGWT8cCMaTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=2NXb5bWG; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VkzZF3LmfzlgMVN;
	Wed, 22 May 2024 17:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1716400717; x=1718992718; bh=/fUnCyL4rXX2AQtUspHQvGeV
	SI9WBvUN5ojnjLO8HQA=; b=2NXb5bWGOG3VkvoOW/1AJ/knPpCcKds88i+1padz
	gFfE5fJ7PzdLZoQbo81PtZWYvVj1Q2FaHh1UQLiTDNI2ukoCNAbJ+Nl4g0u0NxC1
	VFMGvH9ZW6chjnwY+pnV3bx1kPOLj3pBNscI2CIVjtcFel083RWJglTIwGpbB4pJ
	bJhkKlRV4JZQ+dsHgKmxqRXb6ji4hq4XRfi27/mhn23bow5S9+pZ6h5Fg3QEfT+b
	2LzHrguzq2mNP2MJ9Y2iMxIvL5pwEWYwp0kdwPm7JldrbYn5lI2FL0SSqRhARbEU
	uLSMvifOyC0AND8nUQGjb/uPQ0TgHhjqr9UemL6WR7fA0Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9NZjL2GE8PQb; Wed, 22 May 2024 17:58:37 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VkzZ21dlYzlgMVL;
	Wed, 22 May 2024 17:58:33 +0000 (UTC)
Message-ID: <53b30f65-6b0f-4c05-8372-023e5e61a035@acm.org>
Date: Wed, 22 May 2024 10:58:33 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, martin.petersen@oracle.com, david@fromorbit.com,
 hare@suse.de, damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
 joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com>
 <20240520102033.9361-3-nj.shetty@samsung.com>
 <086804a4-daa4-48a3-a7db-1d38385df0c1@acm.org>
 <20240521111756.w4xckwbecfyjtez7@green245>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240521111756.w4xckwbecfyjtez7@green245>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 5/21/24 04:17, Nitesh Shetty wrote:
> On 20/05/24 04:00PM, Bart Van Assche wrote:
>> On 5/20/24 03:20, Nitesh Shetty wrote:
>>> +static inline bool blk_copy_offload_mergable(struct request *req,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 struct bio *bio)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 return (req_op(req) =3D=3D REQ_OP_COPY_DST &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bio_op(bio) =3D=3D REQ_OP=
_COPY_SRC);
>>> +}
>>
>> bios with different operation types must not be merged. Please rename =
this function.
>>
> As far as function renaming, we followed discard's naming. But open to
> any suggestion.

req_attempt_discard_merge() checks whether two REQ_OP_DISCARD bios can be=
 merged.
The above function checks something else, namely whether REQ_OP_COPY_DST =
and
REQ_OP_COPY_SRC can be combined into a copy offload operation. Hence my r=
equest
not to use the verb "merge" for combining REQ_OP_COPY_SRC and REQ_OP_COPY=
_DST
operations.

Thanks,

Bart.

