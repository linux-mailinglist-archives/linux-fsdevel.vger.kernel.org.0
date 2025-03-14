Return-Path: <linux-fsdevel+bounces-44099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81C7A620D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 23:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C83C3BAEBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 22:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3961EDA1E;
	Fri, 14 Mar 2025 22:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="k7ZFeEXM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F04J0QQM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F420D1922DE
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 22:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741992677; cv=none; b=XcRwz9fcml2pacCuzJjh1rqh/M6cqi4qssCxb10gd6MGiYz+nC10mc1b4Jx3XH3HBiCUYcXdZBcTDQc93/iIMeBwDiZJt4Pxq0Ie7HlpSEHW0v6DumnU3YxxpJveEBmoiYWYol5ZmRcdsBxBovfZWR3Kzg8/clXfyp8VO6UgLVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741992677; c=relaxed/simple;
	bh=3TcN9kpH/uUo2kZ3WMTYue3hXWUwVDmTQA+8GldgydU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2FlzdMAc41SjB7XXR5AxxfgNC5IemL2rLqtC/89VR3A1jxtprAEbuCuc0O5Ph87ZV7EIcEfcy3yWTe+VXB6K8axlREV+6wfoIUXi+TsLtph1E/veeA5J8EkiQmcBgPS+KfC4jqzPyia3+Z9BbTtkesKDCUOLF06UNY8sC6z+LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=k7ZFeEXM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F04J0QQM; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1569B1140227;
	Fri, 14 Mar 2025 18:51:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 14 Mar 2025 18:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741992663;
	 x=1742079063; bh=/H2z9zZ1NjXBjD9mzNoutVE9pVmbUb0TW1oqd2AEALg=; b=
	k7ZFeEXMntbLYkj4EXkZlUlWfZGKVOj7Q03JEnox8TRR3CiX6URXDsJh6hcZUUo6
	Hl8crJAUMAsN06/Hy/uIxLrUQphf2Hyg6nxmbCrR/gxERAMHYHrLUl2oqvpVCUjo
	E+qlYujmczN+etFI1yUG1iysR1Dkhvi4Vnyuz0jTgr0zjX7IcdiUCprtJ9Q9rGBG
	kP1FvlsfPJVO2KCsNQw13WTZnY5XLibU5EQzfnCtD4JmFz0gl0KcMbEh6IvDaiQf
	ZNSdtyg49aSkFGOH0vmIQ7iYmMBAGThycLI9GAM1s/GRFtAG0/lCswZoDb7qf2v+
	bzsgsrlhjYoUy621eXRT1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741992663; x=
	1742079063; bh=/H2z9zZ1NjXBjD9mzNoutVE9pVmbUb0TW1oqd2AEALg=; b=F
	04J0QQMmt8aWC7FLiFTtPDEmWBvxeWR6xO7kduLLuQH9YM951O6+VLdU3/F6gpYa
	UZIyKqrH9rFskfRSNvliUfq5ijuOita7J3b8H77BEjq0F3kiHCvCr+gIRD78MSqM
	7QMeUSKqTnteaOolVxgybN4tuxFA8wJ4Y4suPsVmd4OPR3CWaB0/sy3ebBqG1GE1
	OP/5h7vAiQCSSvZHmmjzhOiNUsu+mJZdW55ZagvJZZYBY67R8pAWM9oCxulvMwIo
	yVz6WVGug8CFaylDhPuAfhp+tgXyINe0sHNyzgDtPpdiZL6pdvYPd+6vzVy8F6nf
	VMdWN5btEQSkwgmTG/JFA==
X-ME-Sender: <xms:1bLUZynO3pbLFB9CVe4GIFn8gVZd1ZLUi2P_L95PEr7cz1chFBcJaA>
    <xme:1bLUZ5252E2RQx08XtRFi25an0KUwq4lsfu0qmw93dqhCmH4RWzFeSYRDnVHHo-zy
    LSYDN85DdOhsbH1>
X-ME-Received: <xmr:1bLUZwpuJhbfztVGr7Qg2i0uM7pOD6CghssS9TTMfVlryMN3orV6uNCmujSY2fueRJEFqQjxosY8UVB6TyaFPFFHKBS95iRM_ohqXyEpBeoj2hobLogb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedvtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuh
    gsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledt
    udfgtdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggv
    rhhtsehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinh
    hugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehk
    vghrnhgvlhdqthgvrghmsehmvghtrgdrtghomh
X-ME-Proxy: <xmx:1bLUZ2lCVVez3mUPrWvmU1yrxcplCXPMG8fE-Iw5MufRtFkcCau5wQ>
    <xmx:1bLUZw1hB0x8vSTjkd8kS5HNioOdbk9eB2zHGS8W-V7a3mY6ZV4Mrw>
    <xmx:1bLUZ9ucOD81BrXm9GgHd5fDsgjLCxbRkne820CH57wjNWKnBpDasw>
    <xmx:1bLUZ8Ucib4-Z1446fhPFGhYITPRpOUMPhaf4my22dRUKBCZ4IrdGA>
    <xmx:17LUZzSf9ZAtCWPwkqUz2YeHHzx-YhRLDDZBDRBeFQXYF5OrvwFwNK6E>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 18:51:00 -0400 (EDT)
Message-ID: <2e6bb462-159f-4e7c-af7c-53f2eb44270d@fastmail.fm>
Date: Fri, 14 Mar 2025 23:51:00 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fuse: fix uring race condition for null dereference of
 fc
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: kernel-team@meta.com
References: <20250314205033.762641-1-joannelkoong@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250314205033.762641-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/14/25 21:50, Joanne Koong wrote:
> There is a race condition leading to a kernel crash from a null
> dereference when attemping to access fc->lock in
> fuse_uring_create_queue(). fc may be NULL in the case where another
> thread is creating the uring in fuse_uring_create() and has set
> fc->ring but has not yet set ring->fc when fuse_uring_create_queue()
> reads ring->fc.
> 
> This fix passes fc to fuse_uring_create_queue() instead of accessing it
> through ring->fc.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Fixes: 24fe962c86f5 ("fuse: {io-uring} Handle SQEs - register commands")
> ---
>  fs/fuse/dev_uring.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index ab8c26042aa8..64f1ae308dc4 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -250,10 +250,10 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
>  	return res;
>  }
>  
> -static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
> +static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_conn *fc,
> +						       struct fuse_ring *ring,
>  						       int qid)
>  {
> -	struct fuse_conn *fc = ring->fc;
>  	struct fuse_ring_queue *queue;
>  	struct list_head *pq;
>  
> @@ -1088,7 +1088,7 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
>  
>  	queue = ring->queues[qid];
>  	if (!queue) {
> -		queue = fuse_uring_create_queue(ring, qid);
> +		queue = fuse_uring_create_queue(fc, ring, qid);
>  		if (!queue)
>  			return err;
>  	}

I wonder if we could get more issues, 
fuse_uring_register()
{
	struct fuse_ring *ring = smp_load_acquire(&fc->ring);
	...
	if (qid >= ring->nr_queues) {

...
}

In fuse_uring_create()
{
...
	fc->ring = ring;
	ring->nr_queues = nr_queues;
	ring->fc = fc;
	ring->max_payload_sz = max_payload_size;
...
}


I.e. we cannot trust any of the values assigned after fc->ring? 
Sorry about this, I should have noticed before :(


Thanks,
Bernd

