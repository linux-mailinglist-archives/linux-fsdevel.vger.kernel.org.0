Return-Path: <linux-fsdevel+bounces-20136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5F68CEAE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 22:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC82D281AFA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 20:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACB183A0D;
	Fri, 24 May 2024 20:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="M27wMpgp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCB241C67;
	Fri, 24 May 2024 20:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716582840; cv=none; b=THlLnB5Ewb9NSPjf64PtuTkNcF8b2V5USVNQDicA7VH8eGZT0XY+bMuN86lkJjICipRiIP/I+yWteKMbLhsxo94Q1RMc8qo/fzWb75pSnvBwIVksyRz5wg+2y/waZZUv+xIKRes5cv4TkSU2mrFrtpiVJ+297FYHw9yXRe3Yl3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716582840; c=relaxed/simple;
	bh=89lfuEma9nN+jYDLe/Yu26+hMarY1kIWqJc2bu+34j0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQPkgAZCemcK4f976JPNpIK3OuI8sqevPqc8etUwEQNBxqmQyNtZEyHnh1jlEc9+/pmNOVexab+8mn3wYHjVNWV5BGliWRFbU5z5xQ/5gmZrCC1fn1pYQHRpGrX+DQpusedRQOlEjODzlFJXjOwS9B4t4xgk7EWj1xxAHfDwL0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=M27wMpgp; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VmGwQ4PPNz6Cnk9V;
	Fri, 24 May 2024 20:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1716582828; x=1719174829; bh=89lfuEma9nN+jYDLe/Yu26+h
	MarY1kIWqJc2bu+34j0=; b=M27wMpgpOKeNFIAKHVb8suAHfQt17wAx1wt9QoRm
	Nu/5Ed/S7hBQizyRp4kEdJtAe1OXTegKp0LVily/w/yqNA5af1r/IOtEm+Do5cli
	GjpGy8R80rvjzpvxfK8avBD5h8vt9GMJPTx0KXZDIEtytnIcbNxNaIy/aV67bLUu
	92p0S1cfx2fxEvK2F0qQDbmdTRK/6B2Ksd97L3xZZ77G8tq4ngIQ5UpkH+JULSMA
	1w5/OxmTDX1UXdo99vpNIqeHi81k2KrC9JTmdsFdbSvwihwhtXyZwUHyJaAYQpVa
	I7MpY8HfIJeUIkrhcXJBwXuth555oIdftO5h2Yxo484Ejg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9ySzBQtH-Jqr; Fri, 24 May 2024 20:33:48 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VmGw54jRCz6Cnk9B;
	Fri, 24 May 2024 20:33:41 +0000 (UTC)
Message-ID: <eda6c198-3a29-4da4-94db-305cfe28d3d6@acm.org>
Date: Fri, 24 May 2024 13:33:39 -0700
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

In this patch I don't see any changes for blk_attempt_bio_merge(). Does
this mean that combining REQ_OP_COPY_DST and REQ_OP_COPY_SRC will never
happen if the QUEUE_FLAG_NOMERGES request queue flag has been set?

Can it happen that the REQ_NOMERGE flag is set by __bio_split_to_limits()
for REQ_OP_COPY_DST or REQ_OP_COPY_SRC bios? Will this happen if the
following condition is met?

dst_bio->nr_phys_segs + src_bio->nr_phys_segs > max_segments

Is it allowed to set REQ_PREFLUSH or REQ_FUA for REQ_OP_COPY_DST or
REQ_OP_COPY_SRC bios? I'm asking this because these flags disable merging.

 From include/linux/blk_types.h:

#define REQ_NOMERGE_FLAGS (REQ_NOMERGE | REQ_PREFLUSH | REQ_FUA)

Thanks,

Bart.

