Return-Path: <linux-fsdevel+bounces-20010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC8B8CC5D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 19:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC739282CE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 17:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7874D145B10;
	Wed, 22 May 2024 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="I8jCgEEs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596A146BF;
	Wed, 22 May 2024 17:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716400168; cv=none; b=qSbG7amuK21vg4vyMGmkM3Q2dgApZ1/q43IZll03/CNk7pf3HIbJ9XK40vWWFa/T1OUt6OVMu9zn51p2/aPOxqoBB1J+9jkJEAXUcbQzRkWrXMTwYPV2zfmg8dyJJaqzWoao3xUkHYIHcJv/o16F/WTSI10ObvHgP0HxZwCbbGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716400168; c=relaxed/simple;
	bh=Y82gHOSBDAaIbjj/OTmygzVjJRYdomrp2Yr813oI4eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eMD6WIG5XdLBcxmjQgdeYSxDhesdBdT5GwtfsyXLvfuj6rOU7UrsFDawMDg8YwYl1U7NPV+BWtW+mPdRvlHyU9Og4blW6sSgYJNfLdLcxgjx9wr+nTVM9b6m/L41hjpUtezJeVli9MK4ppHWvfk+rCuk1hvU0Z/0ZTL9w7BnHbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=I8jCgEEs; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VkzMN4FYyz6Cnk9W;
	Wed, 22 May 2024 17:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1716400151; x=1718992152; bh=Y82gHOSBDAaIbjj/OTmygzVj
	JRYdomrp2Yr813oI4eg=; b=I8jCgEEs6RWhiaz3FOJ4qw6gwFlxnoo6V4I5ICCN
	B5iRUSrU9bDloP1vUs/ZZRT1c6mbr95AFTkXe93u3OnQUfIFrTz8PTmpidYdbu7S
	0Bg3sgdGkeJMtnBddXcOirP1nx1xBrwmSxOhJATHwYJv/cFB1VNg9FXMu8ZSUGq2
	ee9Oidgxj3+Es0TMkPh1+qnqp5rL4XfUlOwukJ/fgpJoJCS1yfDy2K5z4asOizgM
	NlJtvReL+/iJDMukLD0QK96UB3R+vdoRu/ncZFDz9DH/zX+r9h8Uu5q7ilNjr38V
	IHwEowjgHCSLcLltTrVv87ydDlAD/tm6VjB9NOXZFga0Tg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cGFB4tzVV1GF; Wed, 22 May 2024 17:49:11 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VkzM86DnRz6Cnk9V;
	Wed, 22 May 2024 17:49:08 +0000 (UTC)
Message-ID: <174d4908-b81c-4775-9b99-b0941451cb0e@acm.org>
Date: Wed, 22 May 2024 10:49:08 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 01/12] block: Introduce queue limits and sysfs for
 copy-offload support
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
 <CGME20240520102830epcas5p27274901f3d0c2738c515709890b1dec4@epcas5p2.samsung.com>
 <20240520102033.9361-2-nj.shetty@samsung.com>
 <d47b55ac-b986-4bb0-84f4-e193479444e3@acm.org>
 <20240521142509.o7fu7gpxcvsrviav@green245>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240521142509.o7fu7gpxcvsrviav@green245>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 5/21/24 07:25, Nitesh Shetty wrote:
> On 20/05/24 03:42PM, Bart Van Assche wrote:
>> On 5/20/24 03:20, Nitesh Shetty wrote:
>>> +=C2=A0=C2=A0=C2=A0 if (max_copy_bytes & (queue_logical_block_size(q)=
 - 1))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>
>> Wouldn't it be more user-friendly if this check would be left out? Doe=
s any code
>> depend on max_copy_bytes being a multiple of the logical block size?
>>
> In block layer, we use max_copy_bytes to split larger copy into
> device supported copy size.
> Simple copy spec requires length to be logical block size aligned.
> Hence this check.

Will blkdev_copy_sanity_check() reject invalid copy requests even if this
check is left out?

Thanks,

Bart.

