Return-Path: <linux-fsdevel+bounces-20011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4749B8CC5E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 19:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B322854EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 17:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81CA145B35;
	Wed, 22 May 2024 17:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="p2pHGKlT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64CB145B02;
	Wed, 22 May 2024 17:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716400348; cv=none; b=qc6U99tYOwiiXuUTdwo0YWl2ZUtGSugxD726X3dkRkJbeGoCXWJkeIcnVgzB2H5IuZYVNmS6iGxzS2JMqW2NhoVCJhd1mA5Ut2/O8IYAfS2Z/wpNTrlkPm8nqnL9/TTtezdvvdG/+bMcbIJD1XyTjdnplEIeH/RI87Ghdt+M0Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716400348; c=relaxed/simple;
	bh=aA3DKznaBT1BfNeUkAE6FwQ0W4IHdJ7XzpJGKtXI/6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ja6LSKSfe3Nlp56nuFBr546uewCtvKshoJnMgCdk4YrOM5fneTy5g6znBmCtx7oYq3kXGuNvgniFgaawDktThOMWomWJzdcQLvRzfmv1gpw0WcBY+OgTS4hfvV5esGWlXcZ7gGqLQH78MRSqwQ/N9RGCAZBwT16SFzEpOaon10M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=p2pHGKlT; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VkzQy08jwz6Cnk9V;
	Wed, 22 May 2024 17:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1716400336; x=1718992337; bh=aA3DKznaBT1BfNeUkAE6FwQ0
	W4IHdJ7XzpJGKtXI/6s=; b=p2pHGKlTGN1n79gxy2b/GyEl+HkP0bgyc2UeYFM/
	GXSzKzNN1hhVyWYWt36+Lp/wge77YnUp3UTBQCCs5mnMacRLMOcgij5X6fN65Wej
	8KE9Kc0EFuDdd4BXiOu3B/ASQKyk8frkif00MA86DIrCWQvv4TL86jA6U4fYWUZo
	pAeT3gs6lohVfoM8VXD757F87uEZlLe8RGe3dO6Y619fpHFuOke+evLOcDOq98DH
	RTyPuQLqHjXoK/xBROHDvP9Iy+XKZ1Mj4yQ1DKWMguuVjseOFLaV2CCHYGnIZaV4
	Lgjk/nUaA+7ZTeyoDv8HIjuDr+QSK8ehLX5M3WFoaFZOXA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id SYpxkEZJmixc; Wed, 22 May 2024 17:52:16 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VkzQg1dXmz6Cnk9X;
	Wed, 22 May 2024 17:52:11 +0000 (UTC)
Message-ID: <631c55b9-8b0a-4ac0-81bd-acf82c4a7602@acm.org>
Date: Wed, 22 May 2024 10:52:10 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 12/12] null_blk: add support for copy offload
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
 Vincent Fu <vincent.fu@samsung.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520103039epcas5p4373f7234162a32222ac225b976ae30ce@epcas5p4.samsung.com>
 <20240520102033.9361-13-nj.shetty@samsung.com>
 <2433bc0d-3867-475d-b472-0f6725f9a296@acm.org>
 <20240521144629.reyeiktaj72p4lzd@green245>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240521144629.reyeiktaj72p4lzd@green245>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 5/21/24 07:46, Nitesh Shetty wrote:
> On 20/05/24 04:42PM, Bart Van Assche wrote:
>> On 5/20/24 03:20, Nitesh Shetty wrote:
>>> +=C2=A0=C2=A0=C2=A0 __rq_for_each_bio(bio, req) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (seg =3D=3D blk_rq_nr_=
phys_segments(req)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
ector_in =3D bio->bi_iter.bi_sector;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (rem !=3D bio->bi_iter.bi_size)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return status;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
ector_out =3D bio->bi_iter.bi_sector;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
em =3D bio->bi_iter.bi_size;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seg++;
>>> +=C2=A0=C2=A0=C2=A0 }
>>
>> _rq_for_each_bio() iterates over the bios in a request. Does a copy
>> offload request always have two bios - one copy destination bio and
>> one copy source bio? If so, is 'seg' a bio counter? Why is that bio
>> counter compared with the number of physical segments in the request?
>>
> Yes, your observation is right. We are treating first bio as dst and
> second as src. If not for that comparision, we might need to store the
> index in a temporary variable and parse based on index value.

I'm still wondering why 'seg' is compared with blk_rq_nr_phys_segments(re=
q).

Thanks,

Bart.


