Return-Path: <linux-fsdevel+bounces-19846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7962A8CA4CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 00:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343B4280C9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 22:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368CC13A3F2;
	Mon, 20 May 2024 22:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="N76ds2Vd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19989139562;
	Mon, 20 May 2024 22:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245674; cv=none; b=Sudlx/+eDac3JGSsMcz+h4ks6tc8RNGXYfX/l/9tt2Qiqtni2iHkDyPg+i+2rEiMaiIH2tn6ic1efJbSefKKWjGCXBVm/xnCO1FoG/h+nVYuKY+vilhbXyJfoGxmmZ9VnM19oK++ueLPmVGFtSLHL6lIF2b0IUw/abo8b6Yv7Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245674; c=relaxed/simple;
	bh=ECRSw6YGQVTPe0gy0dYCsLe8oTWHc9F2P3oJ7mZ9HJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q6ugkNXMuHZIx5Sg8EmEsRi9XZVfjVEOnf0oWNkE4OVcWnWlJLhfTvfn73YaEPmB+1Al3IKMTL5qrPIMnjK+mEKD0m4bZOvMZvS6GH7G5VqzDSU00fCuSasIG+W0hL2oxAh8sx8CbNVVUzW3X/sKGvQJTg5XMqNSub2Tl7r/FHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=N76ds2Vd; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VjtDS1LFmz6Cnk8t;
	Mon, 20 May 2024 22:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1716245664; x=1718837665; bh=ditZiWOn7hLJUcVL8ZGmOB5K
	Frac2puNeESvY7Sy76I=; b=N76ds2VdkoJmHd1jG09JVM0JcdkE4e8L/BR83/0u
	cH1cBSsqz73IdPb13CN2jkZ1TxKhGzjF7KpzQKYU4Jfzcf6sC/RDGQJ/BPLgh/mF
	UQ7mu0Rpcr8kINyu6mA3/XZL0KRNO/YLyH9Cqd8NNKmFVk9EAKPIz4PKqDyiljLs
	T6hX7k66/7ckCKqP+3Nd0t7czRyRhfDIjbCa2KoV+v6kmiY4bglg5iKxBJRJvy5V
	jBGqqWIweAoEnGOAcRt3yADoAdBj7+nghVxqqCh0rjL7BtrdX5VcA3Q9vfRLVXor
	3Tao430X8PGm+xlT0M2i6oao9GfyD6XGmA0vS5cLE1KzFg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id hlmfe--IqVC7; Mon, 20 May 2024 22:54:24 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VjtD956Wjz6Cnk8s;
	Mon, 20 May 2024 22:54:17 +0000 (UTC)
Message-ID: <87f92553-04dc-48c9-be8b-f7fd4cd259b2@acm.org>
Date: Mon, 20 May 2024 15:54:15 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 00/12] Implement copy offload support
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
References: <CGME20240520102747epcas5p33497a911ca70c991e5da8e22c5d1336b@epcas5p3.samsung.com>
 <20240520102033.9361-1-nj.shetty@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240520102033.9361-1-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/24 03:20, Nitesh Shetty wrote:
> 4. This bio is merged with the request containing the destination info.

bios with different operation types must never be merged. From attempt_merge():

	if (req_op(req) != req_op(next))
		return NULL;

Thanks,

Bart.


