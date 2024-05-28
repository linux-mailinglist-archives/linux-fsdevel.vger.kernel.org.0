Return-Path: <linux-fsdevel+bounces-20353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5598D1DFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 16:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4AE8283E46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 14:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A180A16F85A;
	Tue, 28 May 2024 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="J54Gsd09"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C0C16F287;
	Tue, 28 May 2024 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716905299; cv=none; b=B54j4kq4CNJ6SCu5B07eysL3ocFYD+IPQk8YZ9k658wGWSpm8+ubdgH1oJwoIHyObZtJFIBzKrXlB/TG+ju+ZKzlGO5m2Lywrbqz2PSWFkRby0qfD4z8MAjM5zmDsXL3erKx8N330bO279r/+86ZOd4VNPmofs5v3RFWBeyALtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716905299; c=relaxed/simple;
	bh=kH6YiGjqeAZHMKBYiAmbjv7Lv6+d0htVBeb25bHqzbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=avtcfjkyMb9o58A44xN1+kxhD4xPwxO9wDqkyYiw/aaEPhFEKdo1HdKJLQsKlRnd3v/vSurZfl/vx4PHkTmRtsKRXlbbKPF+Wrlp8FlvPpKahpP4+qY6T9BxJ/76HoRuhm+cVpAeLRXP/ZnfZzS+yz8kGsGC19D+CWyro3o8Yyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=J54Gsd09; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VpZ9R1Qx6z6Cnk95;
	Tue, 28 May 2024 14:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1716905278; x=1719497279; bh=dR3ZvbYbJLA8JqSMp6syi4ns
	5+ck4oQr0inj5+NavnA=; b=J54Gsd09VOPGv6hpJCmRRt25qr85iKrjgG3itku7
	MkGP8xjPTJudQuNLFqJT1JMHsU8/nRRl7T+v+gR/WZdE/ooloV46oTdCczd1PYjU
	wPiT6Td9kKxgYjXw9gxIJ7oiywUY/Tdd9iXUMdXjgW8Jg3BHd4dZZiR5a/35/iCR
	XgavrtZrjswPTxAARrsP5h+llv5vBIU8M6SO4EMsyY+t3fOuJjopWi00f28/NAlJ
	4ewCx06Ky7FFI9iqLsHXAKKc2C5EhbXaAOd2MoXnTXVLKYeAWQhIdC1kr1m2cjyr
	WvHFrsXHqBmEClwusPD2KBTERNjrTGi6oqa4aiXhx4oEKg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 5YpJGIeKyzj2; Tue, 28 May 2024 14:07:58 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VpZ974X95z6Cnk94;
	Tue, 28 May 2024 14:07:55 +0000 (UTC)
Message-ID: <95bcfe6a-f179-443a-92b6-98e512fec4fc@acm.org>
Date: Tue, 28 May 2024 07:07:51 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
To: Hannes Reinecke <hare@suse.de>, Nitesh Shetty <nj.shetty@samsung.com>,
 Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>
Cc: martin.petersen@oracle.com, david@fromorbit.com,
 damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com>
 <20240520102033.9361-3-nj.shetty@samsung.com>
 <f54c770c-9a14-44d3-9949-37c4a08777e7@suse.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <f54c770c-9a14-44d3-9949-37c4a08777e7@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/21/24 00:01, Hannes Reinecke wrote:
> On 5/20/24 12:20, Nitesh Shetty wrote:
>> We add two new opcode REQ_OP_COPY_DST, REQ_OP_COPY_SRC.
>> Since copy is a composite operation involving src and dst sectors/lba,
>> each needs to be represented by a separate bio to make it compatible
>> with device mapper.
>> We expect caller to take a plug and send bio with destination 
>> information,
>> followed by bio with source information.
>> Once the dst bio arrives we form a request and wait for source
>> bio. Upon arrival of source bio we merge these two bio's and send
>> corresponding request down to device driver.
>> Merging non copy offload bio is avoided by checking for copy specific
>> opcodes in merge function.
>>
> I am a bit unsure about leveraging 'merge' here. As Bart pointed out, 
> this is arguably as mis-use of the 'merge' functionality as we don't
> actually merge bios, but rather use the information from these bios to
> form the actual request.
> Wouldn't it be better to use bio_chain here, and send out the eventual
> request from the end_io function of the bio chain?

Let me formulate this a bit stronger: I think this patch series abuses
the merge functionality and also that it should use another mechanism
for combining REQ_OP_COPY_DST and REQ_OP_COPY_SRC. See also my email
with concerns about using the merge functionality:
https://lore.kernel.org/linux-block/eda6c198-3a29-4da4-94db-305cfe28d3d6@acm.org/.

Thanks,

Bart.


