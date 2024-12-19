Return-Path: <linux-fsdevel+bounces-37865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8889C9F82E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 19:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE26A1633BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5771A2541;
	Thu, 19 Dec 2024 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="d9CIaDWJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CAp5VtBH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A475A936
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 18:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734631488; cv=none; b=TwOD/pFMPGNDYcRVl7GO4F0FizJcXIIMgzaZacnI5yQLi6jYkQO3KfgNIjFXRI8+iFaZzewpE+0Vn2BTBAhnsIvQB/r6JZioNkZg/WxEiJ0/My1fd/WoXCjwG0z0Tuwdcq3bOOGoapRuxxLfT37swoVb/mz+6pmCp1OsjMdsCts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734631488; c=relaxed/simple;
	bh=eVX/EueBbOxSUK1vET8HbrqvHvV+qLy8Rv1D+1Gpr8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CSfzxt/WNSk5b4/mkgLRM5NSXARQkKX7iSZafTqeWa3A9/1gEARDNHnAhWoQnZAFkV5VUX86IhDNBSU7KzP6vX6HasFdL3uKRlZSHJZT6kzP6FR//koF6NCI81yb9XQy/xgD6sGfv/0oiBfQ6ckzel/vx0NIdIp5NN+CVo+Ncu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=d9CIaDWJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CAp5VtBH; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 7498413800CF;
	Thu, 19 Dec 2024 13:04:44 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 19 Dec 2024 13:04:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1734631484;
	 x=1734717884; bh=sWjATxaJ8q3eyt4L+jK5qOE2YdkkkJ/AyEsTG/OuyMk=; b=
	d9CIaDWJEyigZUwnTrzSJR7+7U9cRXDVUwVXFzWcpt3cXiJse8agNeG0NHsxIE0l
	5U1bnRAafnk4qNCzscpfVe+0ZB523ZVRlsHbkO02GhtUhef7yUrcW8xt+ZTxje7d
	502xiH+0RIVc65ycD6cplbd0wYCpFFsFcgEvme9NK3y6Kzq5KkmpQPSWi61hFew9
	XEcrzhCmEMcwrLW0H5VX4ANz2EpYWKCjce5ewVCKaOKDaBRJ41nC08rN5Ayjq/9p
	T32+lx+YcpcZE4qYdQItYBh/ZhTMG/VMhwhQseHDG1A3tmpuS8Jz0G8Xb1EnzWB+
	9avZgwiPakmfr07MIUc3Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734631484; x=
	1734717884; bh=sWjATxaJ8q3eyt4L+jK5qOE2YdkkkJ/AyEsTG/OuyMk=; b=C
	Ap5VtBHYLpzaqQDrx8VHvMJFFhzzNrFkl5myiJPZzyHllcC82Xm8PF8m0K/EtM66
	h26YjQVOW+fb/VFoaYzxsdkrKWK61FDif6C9nMGGzGFOU073TA1MW/lEDagFtxKV
	RQIEe+XmYXjr+efs/dh4MkgEwwWHaCdI3U+DCMkSmUzysZG0e+0A9zTYkwSft2sb
	eEx9cqTNoBAKn/e51aamwJ4QzsdWKEiai1rYANxxvuiC7oNTOkw5YLC+6OYiijyJ
	bIfmsJ6uYevlCNU6OgQHoSsCraoI8CN5jARMKcUDNjV2Ps49GJFLQPUfIzJ7BBEO
	ac+qR7ipo+DNKeiPCB2sQ==
X-ME-Sender: <xms:O2BkZ0-ncvLj44jg5ClizzJo5wyoOURDr2CRF4gk8fbxH8jkaZqpcg>
    <xme:O2BkZ8tS7ENPAp1DYNNUcFwfVASATEsLXno2VXEbwwM66ue5v5GXdEqbaEYz0ik5a
    x60JUnEOZDBaFVB>
X-ME-Received: <xmr:O2BkZ6D6hZIgq-I0GUqa_-qlx7SnzFQ9ZD1gIQDCX8Xnh_8U3_Nr_ut-oLBESfRxqlFY0nqnoVfpLewLF0YJjaDK5BPwpxqRNInXk9x1GOKBGnRsm1vq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddttddguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeduleefvdduvedu
    veelgeelffffkedukeegveelgfekleeuvdehkeehheehkefhfeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdp
    rhgtphhtthhopegurghvihgusehrvgguhhgrthdrtghomhdprhgtphhtthhopehshhgrkh
    gvvghlrdgsuhhttheslhhinhhugidruggvvhdprhgtphhtthhopeiiihihsehnvhhiughi
    rgdrtghomhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpth
    htoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjvghffhhlvgiguheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtph
    htthhopehjohhsvghfsehtohigihgtphgrnhgurgdrtghomhdprhgtphhtthhopehlihhn
    uhigqdhmmheskhhvrggtkhdrohhrgh
X-ME-Proxy: <xmx:O2BkZ0fimtISMzBSTo32bs5eRLXZACHdTZJ8VLl0ZTWIQx2bQF-AXw>
    <xmx:O2BkZ5Pm9ToX9XTd2mjsfaNsA7gf2cC8m4M1hI66Q4LeH9E3Z_qxSA>
    <xmx:O2BkZ-naRZKshQCA2YWLa4uvtYNXqNDjDvyiDV7XOb8Z2zVPpI3PrQ>
    <xmx:O2BkZ7sc1Vnm3LPQb47glgtd9M5zjIFZojQjkhEuIkiFaKn5hpZRrQ>
    <xmx:PGBkZ_v6YQ0hYeownCasDwBRaJRsHB1jFqYaWuvWVuZFtwV2qDz0cw9p>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Dec 2024 13:04:41 -0500 (EST)
Message-ID: <7810ab2c-1f80-4c78-9b75-db20a78af5e3@fastmail.fm>
Date: Thu, 19 Dec 2024 19:04:40 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Joanne Koong <joannelkoong@gmail.com>,
 David Hildenbrand <david@redhat.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Zi Yan <ziy@nvidia.com>,
 miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org,
 kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>,
 Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
References: <20241122232359.429647-5-joannelkoong@gmail.com>
 <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
 <hltxbiupl245ea7b4rzpcyz3d62mzs6igcx42g7zsksanbxqb3@sho3dzzht3rx>
 <f30fba5f-b2ca-4351-8c8f-3ac120b2d227@redhat.com>
 <gdu7kmz4nbnjqenj5vea4rjwj7v67kjw6ggoyq7ok4la2uosqa@i5gxpmoopuii>
 <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
 <onnjsfrlgyv6blttpmfn5yhbv5q7niteiwbhoze3qnz2zuwldc@seooqlssrpvx>
 <43e13556-18a4-4250-b4fe-7ab736ceba7d@redhat.com>
 <ggm2n6wqpx4pnlrkvgzxclm7o7luqmzlv4655yf2huqaxrebkl@2qycr6dhcpcd>
 <968d3543-d8ac-4b5a-af8e-e6921311d5cf@redhat.com>
 <ssc3bperkpjyqdrlmdbh2woxlghua2t44tg4cywj5pkwwdcpdo@2jpzqfy5zyzf>
 <7b6b8143-d7a4-439f-ae35-a91055f9d62a@redhat.com>
 <CAJnrk1YFix0W5OW6351UsKujFYLcXnwZJaWYSJTYZMpQWwk5kA@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1YFix0W5OW6351UsKujFYLcXnwZJaWYSJTYZMpQWwk5kA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/19/24 18:55, Joanne Koong wrote:
> On Thu, Dec 19, 2024 at 9:26 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 19.12.24 18:14, Shakeel Butt wrote:
>>> On Thu, Dec 19, 2024 at 05:41:36PM +0100, David Hildenbrand wrote:
>>>> On 19.12.24 17:40, Shakeel Butt wrote:
>>>>> On Thu, Dec 19, 2024 at 05:29:08PM +0100, David Hildenbrand wrote:
>>>>> [...]
>>>>>>>
>>>>>>> If you check the code just above this patch, this
>>>>>>> mapping_writeback_indeterminate() check only happen for pages under
>>>>>>> writeback which is a temp state. Anyways, fuse folios should not be
>>>>>>> unmovable for their lifetime but only while under writeback which is
>>>>>>> same for all fs.
>>>>>>
>>>>>> But there, writeback is expected to be a temporary thing, not possibly:
>>>>>> "AS_WRITEBACK_INDETERMINATE", that is a BIG difference.
>>>>>>
>>>>>> I'll have to NACK anything that violates ZONE_MOVABLE / ALLOC_CMA
>>>>>> guarantees, and unfortunately, it sounds like this is the case here, unless
>>>>>> I am missing something important.
>>>>>>
>>>>>
>>>>> It might just be the name "AS_WRITEBACK_INDETERMINATE" is causing
>>>>> the confusion. The writeback state is not indefinite. A proper fuse fs,
>>>>> like anyother fs, should handle writeback pages appropriately. These
>>>>> additional checks and skips are for (I think) untrusted fuse servers.
>>>>
>>>> Can unprivileged user space provoke this case?
>>>
>>> Let's ask Joanne and other fuse folks about the above question.
>>>
>>> Let's say unprivileged user space can start a untrusted fuse server,
>>> mount fuse, allocate and dirty a lot of fuse folios (within its dirty
>>> and memcg limits) and trigger the writeback. To cause pain (through
>>> fragmentation), it is not clearing the writeback state. Is this the
>>> scenario you are envisioning?
>>
> 
> This scenario can already happen with temp pages. An untrusted
> malicious fuse server may allocate and dirty a lot of fuse folios
> within its dirty/memcg limits and never clear writeback on any of them
> and tie up system resources. This certainly isn't the common case, but
> it is a possibility. However, request timeouts can be set by the
> system admin [1] to protect against malicious/buggy fuse servers that
> try to do this. If the request isn't replied to by a certain amount of
> time, then the connection will be aborted and writeback state and
> other resources will be cleared/freed.
> 

I think what Zi points out that that is a current implementation issue
and these temp pages should be in a continues range. 
Obviously better to avoid a tmp copy at all.


Thanks,
Bernd



