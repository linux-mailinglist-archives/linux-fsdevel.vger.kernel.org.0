Return-Path: <linux-fsdevel+bounces-30804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2C998E59A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 23:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EA791F226E7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 21:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BF8199935;
	Wed,  2 Oct 2024 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="d4U2rxUZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e0Mbwi2I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0602A19924A
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727906046; cv=none; b=cHh1XPP84nCH8ytOmhG0UqB28yALxcKTsZKSEzV6uR6LieMgfqUxAWQ7rXuTTRbFpJpgcgv1O0b/Ebv81W74Cro7g2LNhv2GPdj6iXpxpwvuJAmya8cvtXNy4o1Xjst0/Y0YOwPT8yQ2DIJEKKbh8WCjv99Cma6VG9JE3g4bZj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727906046; c=relaxed/simple;
	bh=XI7X6GEJFMA2pmcpUW57EQ4VqJgI1dJBPMYzthNGm4I=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=hU3iLtxgXrjuUnBek+RrMRwKMzu4LlTDcz1Pxqm5oRLTdngTrZLba3M1s2pdRqN8XZeG/wvzRHoQW5V201aAOavDxLvGt8qETmNI0t1V+4zAr2ndZTTkNnRnAZMVydsmoZlYbRCYaodyu8/HVWEwjf32JrhF5NcBgYoJGCIJcVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=d4U2rxUZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e0Mbwi2I; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 06E1F1380667;
	Wed,  2 Oct 2024 17:54:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 02 Oct 2024 17:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1727906043; x=1727992443; bh=0g
	ipNZLzMQP1nZV9eKtPW1SHeVPGCHkFwjJf9d93kwA=; b=d4U2rxUZvqOuFVmm7o
	+4QjoG0QR9IJPmfBFt7npccuVva4BbyG3NOeqO68duqGklGSSvP+552/8dHkzfo3
	jogKLDa79OJhJo2PQxo6x9xQaZKygtjyfi7/Q5GH2ZnoY5i/3SwRW30eQigHMDvO
	RE3YravjCW5oXoqNOawZKVK2TkPwJPraxE2SGcet9iOqjmP1Kxq8x8JbAPFPdoWb
	UPCcyCixJ0mGADo4hXMF5nmRy+7sydfjUQfkw965eQG4v1exeG8YN2HyE1Xl4g6p
	ISg1M2ZBDchy8jBY6PTiSNfsR+VhbL1i69qWm7+wIhQCo2YtxcVA59lfzRS4DnRb
	hGfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1727906043; x=1727992443; bh=0gipNZLzMQP1n
	ZV9eKtPW1SHeVPGCHkFwjJf9d93kwA=; b=e0Mbwi2IqDD6P9svmNMrwYzkTOPSZ
	ZN7myuZdNBsdHLpUIRxhuAjIu5gN/86oS8U3sF6oQgb6ZHGD/lNu6sN6GxDZWUF0
	lwIZ6oq1fiecCUzyV1x1u9LltlFNxdhrI6jWSGTDjFLkwiZQiZiB4vTZwoMQLoj3
	fntaoblhP6VDgbssnce0vRRiK4UqekngJGful29prliMhLt1IPEt6ZhHQCLLRjKe
	9mTJmLv3ooAiGnyiCFRC8y9blSRzlc8ze5RKf9yj57GMixMxd8s0lqYJXpLdWt+9
	PYcfwaRDq5yC2bm1zGH8++uP7HdQkW7n5fp2Ol9OBOGAYkU05pKVQD3dg==
X-ME-Sender: <xms:-sD9Zk_yqv0nVTqf16QAbC3tFQ4yFMbTDsovKwi5UUMm4aW4L-7AYA>
    <xme:-sD9ZstBRsKPzPBNqWReykfICyUoXzgY8FJCYarClf0IjupkGRHC43oqQGzCtpihy
    nnPEIMJTGchZfup>
X-ME-Received: <xmr:-sD9ZqC9in_s7L5CLFmvKGv16BXwZo7ZFrgTX6jMVneHIg3JfyxdRDaM4NC8hrxUKf_PwJRkyQnoPnEEnFADaXTBlugHzPQgzaXBJpsP7-KZ7Y-r5o3I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvtddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfhffvvefutgfgsehtjeertddtvdejnecu
    hfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrth
    esfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepheejheetjeevffejjeet
    hfehveeugfejgfeuiedvhedttddtgfegteejtdfhkedvnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehf
    rghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhope
    hjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehjohhsvghf
    sehtohigihgtphgrnhgurgdrtghomh
X-ME-Proxy: <xmx:-sD9Zkfp08gfoVuh9ZOXpfLhGhoekmvHq8723-TeIt4LwB4k9aTURQ>
    <xmx:-sD9ZpPhh8F2gq-W2yftbMxLsyfROiX3OCWwqdZ7N4GkHAHEFkFcQg>
    <xmx:-sD9Zum572kDork1L8nU9WxLuo6E7F43ntsniUUNVRmlHypPSQAgZw>
    <xmx:-sD9ZrsPg18VykwhJQmtxLX-WNI4bgxbL3h2XNXIFNUU_vj-G-nBaQ>
    <xmx:-sD9Zuq6onb3kksWvjBFEUGiHhlhk6vnfqq0nQL00Xn6vQROvIKgskTx>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 17:54:01 -0400 (EDT)
Message-ID: <e3a4e7a8-a40f-495f-9c7c-1f296c306a35@fastmail.fm>
Date: Wed, 2 Oct 2024 23:54:00 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>
Subject: fuse-io-uring: We need to keep the tag/index
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Miklos,

in the discussion we had you asked to avoid an entry tag/index,
in the mean time I don't think we can. 
In fuse_uring_cmd(), i.e. the function that gets 
'struct io_uring_cmd *cmd' we need identify the corresponding fuse
data structure ('struct fuse_ring_ent'). Basically same as in
as in do_write(), which calls request_find() and does a list search.
With a large queue size that would be an issue (and even for smaller
queue sizes not beautiful, imho).

I'm now rewriting code to create an index in
FUSE_URING_REQ_FETCH and return that later on with the request
to userspace. That needs to do realloc the array as we do know the
exact queue size anymore.


Please let me know if you should have another suggestion.


Thanks,
Bernd


PS: In code review Joanne didn't like 'tag' too much (I took that 
over from ublk). I personally find index/idx too generic - any naming
suggestion is appreciated :)


