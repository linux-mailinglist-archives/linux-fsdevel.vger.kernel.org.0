Return-Path: <linux-fsdevel+bounces-22771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C1D91C002
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 15:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52F97B21BFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 13:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019451BE86E;
	Fri, 28 Jun 2024 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="cPu8Yqjz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094321E89A;
	Fri, 28 Jun 2024 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719582842; cv=none; b=SiSSM2AW41AVebeWh2YvMWwidBIZsZxc6BVuj8nsKQ5Q6PlOgVUCK+cdxVWJttNgzAqbFQBDMs+mBYJV34WAMfBmxAntzR/uM1+cyxBP9cxTHQ/lXwu138tHXUz5G44YARv5HCxjwjG1JSBvrkUyRv54uNqHXuySx+ps+/erFbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719582842; c=relaxed/simple;
	bh=hlCxSbXY/zYRj0hehwmqLqtkVoKWHqJrAMGLXDfKaQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ld9Z4s0GO+SUYwz5I0aGpEPSmYd2XyykrutfzKp/czI4zBSHphzMWvfhNIRxaihJE9x5paVs1FpmsTsqA7wb3+3DnVZWVeH4mW7tK7Zc7ovxsFQ3teufqyQktuAnrlOarlk4v07d4938Is8B5LwevFyouF1wcbpewPI0l+Es7TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=cPu8Yqjz; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4W9cNf08FXz6Cnv3Q;
	Fri, 28 Jun 2024 13:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1719582824; x=1722174825; bh=VbKwt14gFQqPYlFlJyY3C86g
	+aG7f2ya06N7n4GnsqM=; b=cPu8YqjzwECf6/Cvud2z6XgE7OuVVZpV4zNBFDKq
	Qnz6dXkmXMG2hdXwgF0J3DCK5KFzyBzii2dwcGWleHWJ0WrScYadFKPOir+f0Aft
	/nFDLgOsb+aUTixwvE92CC+CZi0xZcge2zzA/ZdpZorE/6XyzkqpmdRbSOiEXzIc
	AIoi+BoRmjAPh7VWDnm7wd1TEmcZFp4uUjTW7gHOGaZ6dZHjoce+WokXQ0w2ipzx
	If5KRynp2k6se3CDq+a3umpwSLVrJOttaF4yociv9RlGG09v7sScsKMkWi+zxTb6
	eStAs+EBoGJELvA9i2svY+GIP9bm/QSbqgSdu3JoyhFI3Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id d1VM3CVtcbxI; Fri, 28 Jun 2024 13:53:44 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4W9cNJ4zk2z6Cnk9Y;
	Fri, 28 Jun 2024 13:53:36 +0000 (UTC)
Message-ID: <4c7f30af-9fbc-4f19-8f48-ad741aa557c4@acm.org>
Date: Fri, 28 Jun 2024 06:53:32 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
To: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Cc: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
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
References: <d7ae00c8-c038-4bed-937e-222251bc627a@acm.org>
 <20240604044042.GA29094@lst.de>
 <4ffad358-a3e6-4a88-9a40-b7e5d05aa53c@acm.org>
 <20240605082028.GC18688@lst.de>
 <CGME20240624105121epcas5p3a5a8c73bd5ef19c02e922e5829a4dff0@epcas5p3.samsung.com>
 <6679526f.170a0220.9ffd.aefaSMTPIN_ADDED_BROKEN@mx.google.com>
 <4ea90738-afd1-486c-a9a9-f7e2775298ff@acm.org>
 <de54c406-9270-4145-ab96-5fc3dd51765e@kernel.org>
 <b5d93f2c-29fc-4ee4-9936-0f134abc8063@acm.org>
 <05c7c08d-f512-4727-ae3c-aba6e8f2973f@kernel.org>
 <20240626052238.GC21996@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240626052238.GC21996@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/24 10:22 PM, Christoph Hellwig wrote:
> It's not just dm.  You also need it in the partition remapping code
> (mandatory), md (nice to have), etc.
> 
> And then we have the whole mess of what is in the payload for the I/O
> stack vs what is in the payload for the on the wire protocol, which
> will have different formatting and potentially also different sizes.

Drivers like dm-linear rely on bio splitting. If the COPY_SRC and
COPY_DST operations travel independently down a stacked block driver
hierarchy, a separate data structure is needed to keep track of which
operations have been split and to combine the split operations into
requests. Isn't this an argument in favor of storing the source and
destination parameters in a single bio?

Thanks,

Bart.

