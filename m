Return-Path: <linux-fsdevel+bounces-20946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BA58FB151
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 13:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A811C222D1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 11:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310B5145A09;
	Tue,  4 Jun 2024 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="PH0bzoil"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3867114535B;
	Tue,  4 Jun 2024 11:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717501490; cv=none; b=Vg0TsuFQZuVdEsXaElUHq6F2dReGBMgNZGhR2ejoPwpmkJdWYK79vELAlMD9uDftp0ey6oZisY+M4ck/eORHW8tgGXyDHct6SiyvtRfPcUnEkkL+e9j8pVLwwM5ZXwQKIb5sP5qvqWFOHA1eON1bgstgFiT9g32HUS+wMHZAxTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717501490; c=relaxed/simple;
	bh=Zq3tmv7wVyTPDUnP6zcuF5O5k4OJprRbePrkTV4mQxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecf6kZihT9zvo5YVMk1ipovHSk4KjolV/bzzev4QM1D3km2VtT7npd4i+cQSyyWlWQeZVbBO5Tz/A2iGkCL3DAr6TS/832IaaGr3031xeSaLePqA+AG70rqD8IakaKo7/YOrnYzRWncwpHnFa9yBr2BMlSWAfSQ4iCAjoYlarGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=PH0bzoil; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Vtpfm2nCnz6CmM6L;
	Tue,  4 Jun 2024 11:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717501479; x=1720093480; bh=7qUm0UAjYUpYgELaUp3vQTyR
	sNCZFqUKF3YsXC9VPcI=; b=PH0bzoilwBKbtI0CATbVi7YcINf9EkEcm2c2N0CV
	1/oVwONzbegPfpgoEMQNU3394kaNh4ZWcqz6bVyW5zyutvi2Xq9VBgu24G8pIM65
	vc4hx0zpbsrSh7Y9GrAgZKutiC2V9wqzzVN99yfwWnHRIuyclYn7hDFRE96oz8Wq
	JaAttVggwSu/Djpga3VWgX3kj7CUtYmZqBGYkPXR6AuvhT78LjHBQDX7UYpSsnHC
	Tgn6ypj7ceaWO8DuUcqBb/5GdadTFhcBUfAwr6Uo6TykNn+CPNk5jEy07Wisb1Gq
	5Mj52lkVrD41PtszHYQi/5R/4HaVA1eHn9rVUidXnlwTOw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id JJ_f4sfDEmwz; Tue,  4 Jun 2024 11:44:39 +0000 (UTC)
Received: from [192.168.132.235] (unknown [65.117.37.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VtpfX0Smkz6CmQvG;
	Tue,  4 Jun 2024 11:44:35 +0000 (UTC)
Message-ID: <4ffad358-a3e6-4a88-9a40-b7e5d05aa53c@acm.org>
Date: Tue, 4 Jun 2024 04:44:34 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
To: Christoph Hellwig <hch@lst.de>
Cc: Nitesh Shetty <nj.shetty@samsung.com>, Damien Le Moal
 <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
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
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com>
 <20240520102033.9361-3-nj.shetty@samsung.com>
 <eda6c198-3a29-4da4-94db-305cfe28d3d6@acm.org>
 <9f1ec1c1-e1b8-48ac-b7ff-8efb806a1bc8@kernel.org>
 <a866d5b5-5b01-44a2-9ccb-63bf30aa8a51@acm.org>
 <665850bd.050a0220.a5e6b.5b72SMTPIN_ADDED_BROKEN@mx.google.com>
 <abe8c209-d452-4fb5-90eb-f77b5ec1a2dc@acm.org> <20240601055931.GB5772@lst.de>
 <d7ae00c8-c038-4bed-937e-222251bc627a@acm.org>
 <20240604044042.GA29094@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240604044042.GA29094@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/3/24 21:40, Christoph Hellwig wrote:
> There is no requirement to process them synchronously, there is just
> a requirement to preserve the order.  Note that my suggestion a few
> arounds ago also included a copy id to match them up.  If we don't
> need that I'm happy to leave it away.  If need it it to make stacking
> drivers' lifes easier that suggestion still stands.

Including an ID in REQ_OP_COPY_DST and REQ_OP_COPY_SRC operations sounds
much better to me than abusing the merge infrastructure for combining
these two operations into a single request. With the ID-based approach
stacking drivers are allowed to process copy bios asynchronously and it
is no longer necessary to activate merging for copy operations if
merging is disabled (QUEUE_FLAG_NOMERGES).

Thanks,

Bart.

