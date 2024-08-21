Return-Path: <linux-fsdevel+bounces-26479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 570CA959F77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 16:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF811F25E57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 14:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F811B1D5F;
	Wed, 21 Aug 2024 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="t3ghOWnz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cO/zNLbS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E5E18C348
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 14:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724249743; cv=none; b=akOT7BYcKEfXe2ySuYvGHlZ2cd3En484UrT+ylWqJSR5HzQmeChIFHH6Ms5F4h5qoJuEGjkJ4iir3XIlL7M06x5e9cpNT4zpNYZdUCPG/o/NepevvA+29OV7dntUXm6Gm+9GhnQLGLLWYBeeZXBiYZBtKIBpVYQbX9Sc9zOVh6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724249743; c=relaxed/simple;
	bh=hNUwvyg5Vo30h6c3SUt+oXfIyCjPpV2IzN/KppmUVT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LOpgbiwuIqg9c5uuuJn5AUMlx0G7frlnf14Xkt4ynnIg0Geb6q8/wJssUN4xLw1cgW1oYiMwTpGsArYr9dIk6iEkRBzXqi4fLmmYQWYcCg8dpj9dbzfRpvOiC82qhWrK3rEkwHWrARQHZ+brojrcQcVH8Pm9pP2tBdQ8n52sqxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=t3ghOWnz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cO/zNLbS; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 49D3B138FF76;
	Wed, 21 Aug 2024 10:15:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 21 Aug 2024 10:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1724249740;
	 x=1724336140; bh=GUXB9oyLEykgVFVjJL/TukD608jcVTVKgOeVjq96iEc=; b=
	t3ghOWnzd8iOMhw3hqJb82ntLBY1JasMwuZeKk4wPxAKjfusA80uoN8dlHlQSbl9
	9uMkHPtYrQveKds3YbdijL4rd/PAejEUAz6IpwYYZ+NRBlJGTepGlTthr30VA+yP
	pKXgv2uBpYINurx3uDPRg2ecsgpVH2sCQSWJwxs9WAwAKeS2R4K0zQF75VDlsrzs
	vXCqbjTDjFOM6bXz8Jp174qEQKNti78KyOm0s60BkMxU2hni9NgqD+e9Dxi0wuXc
	MLYVGqinolrfvqVnpqhIBpBAjBLSaFnqI4r9n2LOBI2NH2edcf8c2OcS9qfDey5L
	QAHGdGNlqT0mUbeB8o3CqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724249740; x=
	1724336140; bh=GUXB9oyLEykgVFVjJL/TukD608jcVTVKgOeVjq96iEc=; b=c
	O/zNLbSBUkcMozWzGVOQn9dxHaZx8HB18BizJbRJtcqQlnjtv5ZmwfPYg+YD3A3e
	awBd1QPKxuPHFA6qYEZwfxKaQwzae6BxlGpLgnadrztFRsowiV4cOoNnI0JhDKC3
	4XUU890r5bvkO+n6zT9glqSDlaEkB2y1f9gFiEolfXbs2MHTDVJ2+xZ3ulJ0KH6R
	hyW/fhdQ1zjixlxTwAlurRvL0SQo23QRjXHI/n7hX2Q3TjmLXH1cTHEQz88NY6nI
	FvgfGMh/OrmL78xH7WkM1Py8NG+t8rwX4f4nyMx4jYbM+nHJz0U5eq9ghnypQspX
	J2L75KO2kuujstwv9+/jw==
X-ME-Sender: <xms:i_bFZkhjYZRyKFIBjxnr4ZHGsQ14M9D-LaoKnhY7v_ZEGdFjm8EjDw>
    <xme:i_bFZtARAOv5a0yblQP_pkjDyvuyd_IR90WA4314Y95JVA1vYUUtCnj2MRZIurub5
    D6FFH_QZKQ18F6y>
X-ME-Received: <xmr:i_bFZsHNKOKFTNACm23CKwJFnLAbS4PfSFggvpaazucpF0TJ4Za5gDZ9CIOky87dLf6FizION9eI53Vp8EJ4tHyaNyK5uSjhyAiN4TlMkESZcAKwyX4OzTj1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddukedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepffejveeffeejgffh
    fefhieeuffffteeltdfghffhtddtfeeuveelvdelteefvedtnecuffhomhgrihhnpehkvg
    hrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmhdpnhgspg
    hrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhikhhlohhs
    sehsiigvrhgvughirdhhuhdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrg
    hilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhoshgvfhesthhogihitghprghnuggrrdgtoh
    hmpdhrtghpthhtohepjhgvfhhflhgvgihusehlihhnuhigrdgrlhhisggrsggrrdgtohhm
    pdhrtghpthhtoheplhgrohgrrhdrshhhrghosehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtohhm
X-ME-Proxy: <xmx:i_bFZlRtCkWYic8DZJPAcgSOZu_28zB3EdbDUJfYJk38WJIrefGnjQ>
    <xmx:i_bFZhzJXaFTgkGsIsx0SH49ofoo8UxWClu9j9xrtYsVUdOf2SUU_A>
    <xmx:i_bFZj5lVCb9l-k2nCb7r0Ue5ea_MtAdeojqp7rJe9btMKPJ-0Y0Jw>
    <xmx:i_bFZuxgqrCnvHUgwwEAzMSjrOLcPQ1JXmAEW_4AwYU0HfEV4jb6rw>
    <xmx:jPbFZgyw0a--fi8ZL_WI2cEa8N5m7Y9ULHdTpKw_nf8vJwIN_-CMYqAQ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Aug 2024 10:15:37 -0400 (EDT)
Message-ID: <aad61081-524e-4c67-a6b7-441cca5003ab@fastmail.fm>
Date: Wed, 21 Aug 2024 16:15:35 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] fuse: add timeout option for requests
To: Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
 jefflexu@linux.alibaba.com, laoar.shao@gmail.com, kernel-team@meta.com
References: <20240813232241.2369855-1-joannelkoong@gmail.com>
 <CAJfpegvPMEsHFUCzV6rZ9C3hE7zyhMmCnhO6bUZk7BtG8Jt70w@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegvPMEsHFUCzV6rZ9C3hE7zyhMmCnhO6bUZk7BtG8Jt70w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/21/24 15:47, Miklos Szeredi wrote:
> On Wed, 14 Aug 2024 at 01:23, Joanne Koong <joannelkoong@gmail.com> wrote:
>>
>> There are situations where fuse servers can become unresponsive or take
>> too long to reply to a request. Currently there is no upper bound on
>> how long a request may take, which may be frustrating to users who get
>> stuck waiting for a request to complete.
>>
>> This patchset adds a timeout option for requests and two dynamically
>> configurable fuse sysctls "default_request_timeout" and "max_request_timeout"
>> for controlling/enforcing timeout behavior system-wide.
>>
>> Existing fuse servers will not be affected unless they explicitly opt into the
>> timeout.
> 
> I sort of understand the motivation, but do not clearly see why this
> is required.
> 
> A well written server will be able to do request timeouts properly,
> without the kernel having to cut off requests mid flight without the
> knowledge of the server.  The latter could even be dangerous because
> locking guarantees previously provided by the kernel do not apply
> anymore.
> 
> Can you please explain why this needs to be done by the client
> (kernel) instead of the server (userspace)?

I don't know about Joannes motivation, I see two use cases

- You suggested yourself that timeouts might be a (non-ideal) 
solution to avoid page copies on writeback
https://lore.kernel.org/linux-mm/CAJfpegt_mEYOeeTo2bWS3iJfC38t5bf29mzrxK68dhMptrgamg@mail.gmail.com/raw

- Would probably be a solution for this LXCFS issue
https://lore.kernel.org/lkml/a8d0c5da-6935-4d28-9380-68b84b8e6e72@shopee.com/
(although I don't fully understand the issue there yet)


Thanks,
Bernd

