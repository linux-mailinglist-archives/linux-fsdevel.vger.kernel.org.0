Return-Path: <linux-fsdevel+bounces-22230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9416914801
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 13:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37C86B203E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 11:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABCE1384B9;
	Mon, 24 Jun 2024 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JLflTxBU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215D713791F
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719226992; cv=none; b=FQB8hw+q39aApGlzBMq+97Bkoa+vxytDjNolxzyQGTwGuLmLHQZtKCWnMvmgA6iNusuXoYYfLauhm+R9WH+CIC20dPsB9khY5S6jGgTCR97ct1NvlbvwpEw27gqRpVTnuvKqwNHtvRs/Zm5Dt2B5pGItTk4whYfNOYKCnAYgT4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719226992; c=relaxed/simple;
	bh=aBpS1pkDlNpJM7K9xxkzLUHegsLBeWyXpD5uLOOeVhE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=NzOyvEFoBCG2lHSu5fDm4BvXjxQutrx2x2OHCxU76oudPrpGTZuoBDZg137Eu00W/f2xoSThc0lLj0S4WpiTcYejdN+atVCErQVzZwMgZ6jKopF8rY8mRiA3e9Uav/Te21yCa5Bz5MXwn6udcmxrw8VCvWpuY02r1IZ7VIefBY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JLflTxBU; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240624110306epoutp02e1d9a569bee7634dc24c19c6632704eb~b69XL_B6n0369403694epoutp02I
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 11:03:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240624110306epoutp02e1d9a569bee7634dc24c19c6632704eb~b69XL_B6n0369403694epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719226986;
	bh=uxpMOuA3IRgLqQWXX8+eqtJkWwddlx/GN7rdVWV2/6g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JLflTxBU070L20Ugm/A+/Dt0F7x6DQp5L5lpX/pqEyk0zue6JVzb0+f1K50kGRwIF
	 zOeDFNP1CNgOc1JkJCWsvapVrdeL2DSGMYsVVplCj6UNquW+ZgaIJcXBbeU7kio2Yz
	 dmx8omQMkOOG2og1ZnMCbWcIR9nHh0fdSitznPU4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240624110304epcas5p4c8ab6937c499617cbbaaa96fc5a4769f~b69Vn-po40506905069epcas5p4q;
	Mon, 24 Jun 2024 11:03:04 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4W74nL5C7Kz4x9Pt; Mon, 24 Jun
	2024 11:03:02 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	24.C9.09989.66259766; Mon, 24 Jun 2024 20:03:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240624105121epcas5p3a5a8c73bd5ef19c02e922e5829a4dff0~b6zG9Ypk82450824508epcas5p3C;
	Mon, 24 Jun 2024 10:51:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240624105121epsmtrp130aa2d7a4474a6eba09309959ab71409~b6zG3AObb1223312233epsmtrp1c;
	Mon, 24 Jun 2024 10:51:21 +0000 (GMT)
X-AuditID: b6c32a4a-bffff70000002705-3d-6679526612e3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E4.9B.29940.9AF49766; Mon, 24 Jun 2024 19:51:21 +0900 (KST)
Received: from nj.shetty?samsung.com (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240624105114epsmtip2b4e30650a5edb6427c3e9344921bba5e~b6zAu4Mi31228012280epsmtip2c;
	Mon, 24 Jun 2024 10:51:14 +0000 (GMT)
Date: Mon, 24 Jun 2024 16:14:07 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>, Damien Le Moal
	<dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>, Jonathan Corbet
	<corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer
	<snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Keith Busch
	<kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, david@fromorbit.com, hare@suse.de,
	damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
	nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
Message-ID: <20240624103212.2donuac5apwwqaor@nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240605082028.GC18688@lst.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA02TezBcdxTH53fv3buXic56lB8aNTeTZCReKx4/EZI2hlvRjKnRaZsRNvay
	Brs7ux5lmnqE1CPeCWMboZh6pQyhg41SaiUEI0JCSyWlJSJIUn1k0OXSyX+f8z2P3++cM4fC
	Ddr4ZlS4NJpVSEWRNKlLfN9rZWUT+lF8qL36AY0aBzQ4SsnbwFH9dC6JlnpfAFS0+g+O5rq/
	Auj10AiOWjQzAM12nUTlFaUEmuxux9DtigIM1db3Yejr4ksY6ttaJlFBzwRA8+MqDHVOHUXf
	XK4i0O3OuwQa67hOorJv5/moun8TQ/np4xhqm0sGqGFphUB3pszRyEY/79Q7zNiDM8xABWTa
	VdN8ZmSmiWDGhmKY5roMkrlVlcgs3CoBjHoyiWQqcwp5TPal5yTTnvYrj1mbnyKYlR/GSSan
	pQ4w98p/4vsZfhZxQsKKxKzCkpWGyMTh0jB3+ox/0OkgJ2d7oY3QFbnQllJRFOtOe/r62XiF
	R2oHRFvGiiJjtJKfSKmk7TxOKGQx0aylRKaMdqdZuThS7ii3VYqilDHSMFspG31caG/v4KQN
	DI6QPKzr48snLT5fy7rPSwIq00ygQ0GBI/z7+hQvE+hSBgI1gBnDMxhnvACwsbCd5Ix1AOsr
	urG9lCcNVbtRnQC+nMgDnPESwP5Hs+R2FCE4CDc0an4moChScBQOblHbspGAhvNPh3biccEw
	CTNUi/i2w1AQDJcH8nnbrCc4DRueP+JzrA/vlswR26wjsIbFqYM7yVDwuw4saV3BuS95wt6y
	Nh7HhvBpfwufYzO4mHt5l+Ng7dUakktOBVD1UAU4x0mYNpC7UwgXSOCf7RW7hfbDawMNGKe/
	BbNfz+32rwfbbuzxAXizsZzk2BRO/JW8ywxc6lojuLF8R8AbeXP8PGCheqMj1RvvcXwcZqym
	aJnSsjms3qQ42Rj+PNZMcLIVbOywKwdkHTBl5cqoMFbpJHeQsnH/7zxEFtUMdk7oiE8beDy7
	atsDMAr0AEjhtJFecWJsqIGeWBSfwCpkQYqYSFbZA5y028rHzd4OkWlvUBodJHR0tXd0dnZ2
	dD3mLKRN9JbSSsUGgjBRNBvBsnJWsZeHUTpmSViryuXxoXsL+rUf+L6XzE9/NhJS16V+FXjB
	7tr7M+fjE0BA+NRFz4yFL0267cStg8fKhgJ6fvF3e/KhxPKL0Ua3aqGJcSl12NvbxKLoj+HZ
	bM+O0voLqfir3qIf/bxaazSTBz2dmvwT9xeMBGY7eI9nBRSfX3Itai431WgS0yvfDRqc8Lji
	bxVXzRwIoD2fxQ8e9vDgZyxWjpjonjvrsFXKD6uB+r5SbFQhLfx3dH2fzELswpu56Y6bNzcl
	ZeWqvTOTw+yj9k0nSGM/7lodDUw4t6zc8nEzu5KCZfetR2Sfihu2u+9l/UlHs91Fec7Z2uBu
	v08PGY0vxltvsoXGv6kTfe7QhFIiEh7BFUrRfzJEnsTLBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xTZxzG855zejjFoMdTL29pRdNpIqAo0W3vB68x6IvGeIlfqovQ2SMQ
	oUJL6XTZQAG5TAXUQSzIXZQyQS4y7kqhMOgIItYIBkYZDQ6E4iXLFCla2DK+PXl+z/N/vvwZ
	kosVuDMhqkherVKEymhXqrpFtnpj8aFzpze3TolRWWcbiS6mzpCoZCCFRuMtbwBKn3pPopFH
	CQBNd3WTqKptEKChhztRbv4tCvU9qiVQQ/41AhWXmAiUmRFLINPsBI2uGZ8BZLPoCdTY743y
	LhVSqKGxg0K9dVk0yimyuaA77Q4CpSVaCFQzcgGg0nE7hX7rl6DumXbBLinufXoAd+ZDXKsf
	cMHdg+UU7u3S4gpDEo0rC6Pxy8qbANf3xdC44Op1Ab4SO0nj2vg/BPi1rZ/C9iYLja9WGQD+
	PbfV5bDouOs2JR8aEsWrN+0IdA22FpRQ4W8l383eeyiIAT0rkoGQgexWOFxaSDg1x9YDmG3n
	530xLJppJee1CBY7Rl2SgevnzGsAe5rMlBNQ7Do401b/GTAMzXpD8yzjtJexMmgb6wLOPMk+
	oWHjg0yBE4jYQDjRmTan3dg9sHTy+b9H+0jYOhVHzIOlsOPmyNwAyX4Fsyut5LxeAV/0VlDO
	MZKVwDuOuTEhuwFmxJlBKliqX9DWL2jrF7T1/7dzAWUAYj5cExYUpvEN91XxOh+NIkyjVQX5
	nDobVgHm/sTLswb8apjyMQKCAUYAGVK2zC0jOuo056ZUnDvPq88GqLWhvMYIJAwlW+m28uUV
	JccGKSL5Mzwfzqv/owQjdI8hKkwmd6tw2hKR5/FjkviLA8bpg7QuoTs7aktdAs+M9r/bZjpx
	+YglxCw5KVovlZd/neZ312N3k277t2aD3+hs+2K5yfCD50FlYAkTcXvfPb/OBNhSdLQOJh+r
	Pp/FLTekZy1xVJX/aU+ps8n3x9vE/2SO+W+Rft9jTdG+WPX4ho5jh/ePld33ePVL9cdF9T+T
	uqyLggGHPEpIK4+mNhxrnvQY3rAx3hNX2Q0dlYnyDuUhf+6D9q61OW5iyJH5tC/RXMCtvRDR
	tHc7aX0VII0cbNM/qJFvHvJeI/a6/KW03b9Z8CY4qWxc+fYv9u9vcuDeZz8Ne93Wr1FFB3B7
	RM/TZZQmWOHrRao1ik966v6UlgMAAA==
X-CMS-MailID: 20240624105121epcas5p3a5a8c73bd5ef19c02e922e5829a4dff0
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_b15cc_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240624105121epcas5p3a5a8c73bd5ef19c02e922e5829a4dff0
References: <eda6c198-3a29-4da4-94db-305cfe28d3d6@acm.org>
	<9f1ec1c1-e1b8-48ac-b7ff-8efb806a1bc8@kernel.org>
	<a866d5b5-5b01-44a2-9ccb-63bf30aa8a51@acm.org>
	<665850bd.050a0220.a5e6b.5b72SMTPIN_ADDED_BROKEN@mx.google.com>
	<abe8c209-d452-4fb5-90eb-f77b5ec1a2dc@acm.org>
	<20240601055931.GB5772@lst.de>
	<d7ae00c8-c038-4bed-937e-222251bc627a@acm.org>
	<20240604044042.GA29094@lst.de>
	<4ffad358-a3e6-4a88-9a40-b7e5d05aa53c@acm.org>
	<20240605082028.GC18688@lst.de>
	<CGME20240624105121epcas5p3a5a8c73bd5ef19c02e922e5829a4dff0@epcas5p3.samsung.com>

------atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_b15cc_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
Content-Description: 

On 05/06/24 10:20AM, Christoph Hellwig wrote:
>On Tue, Jun 04, 2024 at 04:44:34AM -0700, Bart Van Assche wrote:
>> On 6/3/24 21:40, Christoph Hellwig wrote:
>>> There is no requirement to process them synchronously, there is just
>>> a requirement to preserve the order.  Note that my suggestion a few
>>> arounds ago also included a copy id to match them up.  If we don't
>>> need that I'm happy to leave it away.  If need it it to make stacking
>>> drivers' lifes easier that suggestion still stands.
>>
>> Including an ID in REQ_OP_COPY_DST and REQ_OP_COPY_SRC operations sounds
>> much better to me than abusing the merge infrastructure for combining
>> these two operations into a single request. With the ID-based approach
>> stacking drivers are allowed to process copy bios asynchronously and it
>> is no longer necessary to activate merging for copy operations if
>> merging is disabled (QUEUE_FLAG_NOMERGES).
>
>Again, we can decided on QUEUE_FLAG_NOMERGES per request type.  In fact
>I think we should not use it for discards as that just like copy
>is a very different kind of "merge".
>
>I'm in fact much more happy about avoiding the copy_id IFF we can.  It
>it a fair amout of extra overhead, so we should only add it if there
>is a real need for it

Christoph, Martin, Bart, Hannes, Damien

We have iterated over couple of designs for copy offload, but ended up
with changing them owing to some drawbacks. I would like to take your
opinion on how we can plumb copy offload in block and dm layer.

For reference, I have listed the approaches we have taken in the past.

a. Token/payload based approach:
1. Here we allocate a buffer/payload.
2. First source BIO is sent along with the buffer.
3. Once the buffer reaches driver, it is filled with the source LBA
and length and namespace info. And the request is completed.
4. Then destination BIO is sent with same buffer.
5. Once the buffer reaches driver, it retrieves the source information from
the BIO and forms a copy command and sends it down to device.

We received feedback that putting anything inside payload which is not
data, is not a good idea[1].


b. Plug based approach:
1. We take a plug.
2. Send a destination BIO, this forms a copy request and waits for source BIO
to arrive.
3. Send a source BIO, this merges with the copy request which was formed
by destination BIO.
4. We release the plug, then copy request reaches driver layer and forms
a copy command.

This approach won't work with stacked devices which has asynchronous
submission.
Overall taking plug and merging BIOs received not so good feedback from
community.

c. List/ctx based approach:
A new member is added to bio, bio_copy_ctx, which will a union with
bi_integrity. Idea is once a copy bio reaches blk_mq_submit_bio, it will
add the bio to this list.
1. Send the destination BIO, once this reaches blk_mq_submit_bio, this
will add the destination BIO to the list inside bi_copy_ctx and return
without forming any request.
2. Send source BIO, once this reaches blk_mq_submit_bio, this will
retrieve the destination BIO from bi_copy_ctx and form a request with
destination BIO and source BIO. After this request will be sent to
driver.

This work is still in POC phase[2]. But this approach makes lifetime
management of BIO complicated, especially during failure cases.

Thank You,
Nitesh Shetty

[1] https://lore.kernel.org/linux-block/20230605121732.28468-1-nj.shetty@samsung.com/
[2] https://github.com/SamsungDS/linux/tree/feat/co/v21/ctx

------atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_b15cc_
Content-Type: text/plain; charset="utf-8"


------atUsqPFm-1W_PDIhMRaVeMNpJ8wr1jcbO3GdUizRktR65zpR=_b15cc_--

