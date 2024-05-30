Return-Path: <linux-fsdevel+bounces-20547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54C18D50AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 19:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4181C21C3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 17:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3584F4E1CF;
	Thu, 30 May 2024 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="pDdrsLN3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC3A45BE4;
	Thu, 30 May 2024 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717089091; cv=none; b=gUdfIh8OT6X+brsgPk2x0c3TdubG9/HbDpT8UpSDJvhh+ofIIw8GTFpnVPkBP8yoyu5kY392HVG9uiLaAlyIup/OWUDnXuu9/FUrNHIGsTqn8yKjadnllQnGn02CGYP16Df0CI3MzGuYtoPCZEMX1yoB3oku19byljw6zlYq0HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717089091; c=relaxed/simple;
	bh=go0cYzcDqydRtutKma5FUwv79zZ3P7zOWhGl/8O+3OI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkVKFvLxaJsigiQ7RfCmp0CXKIatuPkMJ3ptN6HMGuXul6xUF3h6XZFT1jHUaR6QgZO1oJBnnDcvNGr2MwLexL2u2SSiL3EE1Wb4fjSoNtOt9UZ93vUqwPEym7NshI0Mupmx6sh1vEQm7l5bnukrFtMHSfyCSP2xsoPooxj65Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=pDdrsLN3; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Vqt812W1wz6Cnk9F;
	Thu, 30 May 2024 17:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717089079; x=1719681080; bh=Ul8tShPV3DUMrLj4E7kNdLyB
	ZmST2o57Jd5aN0FDWYg=; b=pDdrsLN3JZPbFaUtLRbj37cnYuTv29wYsaoWbWPX
	0jAfS4sWOekodOat3cJMbqn2RuFn9uq1dvv60rD84RsGZNOhy608uxLLU+fhbyly
	eKTbCc9wykATpOsmXQs1/utBwypcCkWl3KNU2MCRI5q96GhEKAOJtbitLN7/YNmG
	3Mn9taXV/EfZN1zWvkxJYjfq7QJgcsxlE8NwOH4KI1q7OAQMt6CrARV53oLIJ5CE
	jigej7/3tFmHOi5xt9zZPOhIruRk26PiBfPzT3bdqB0Juw5GHorv14poLk5Hg7m/
	4sx7azLGVHPrQJdDegiabUIRkEKLqqQMji0NKTMLKSNjWA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id T0Ifl3ssZIoq; Thu, 30 May 2024 17:11:19 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Vqt7l6w1zz6Cnk97;
	Thu, 30 May 2024 17:11:15 +0000 (UTC)
Message-ID: <abe8c209-d452-4fb5-90eb-f77b5ec1a2dc@acm.org>
Date: Thu, 30 May 2024 10:11:15 -0700
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
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 martin.petersen@oracle.com, david@fromorbit.com, hare@suse.de,
 damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com>
 <20240520102033.9361-3-nj.shetty@samsung.com>
 <eda6c198-3a29-4da4-94db-305cfe28d3d6@acm.org>
 <20240529061736.rubnzwkkavgsgmie@nj.shetty@samsung.com>
 <9f1ec1c1-e1b8-48ac-b7ff-8efb806a1bc8@kernel.org>
 <a866d5b5-5b01-44a2-9ccb-63bf30aa8a51@acm.org>
 <665850bd.050a0220.a5e6b.5b72SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <665850bd.050a0220.a5e6b.5b72SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 5/30/24 00:16, Nitesh Shetty wrote:
> +static inline bool blk_copy_offload_attempt_combine(struct request_que=
ue *q,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
struct bio *bio)
> +{
> +=C2=A0=C2=A0=C2=A0 struct blk_plug *plug =3D current->plug;
> +=C2=A0=C2=A0=C2=A0 struct request *rq;
> +
> +=C2=A0=C2=A0=C2=A0 if (!plug || rq_list_empty(plug->mq_list))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> +
> +=C2=A0=C2=A0=C2=A0 rq_list_for_each(&plug->mq_list, rq) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rq->q =3D=3D q) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(!blk_copy_offload_combine(rq, bio))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return true;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Only keep iterating=
 plug list for combines if we have multiple
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * queues
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!plug->multiple_queues)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
> +=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 return false;
> +}

This new approach has the following two disadvantages:
* Without plug, REQ_OP_COPY_SRC and REQ_OP_COPY_DST are not combined. The=
se two
   operation types are the only operation types for which not using a plu=
g causes
   an I/O failure.
* A loop is required to combine the REQ_OP_COPY_SRC and REQ_OP_COPY_DST o=
perations.

Please switch to the approach Hannes suggested, namely bio chaining. Chai=
ning
REQ_OP_COPY_SRC and REQ_OP_COPY_DST bios before these are submitted elimi=
nates the
two disadvantages mentioned above.

Thanks,

Bart.

