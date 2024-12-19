Return-Path: <linux-fsdevel+bounces-37849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4A59F8245
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4828164C84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BAE1A9B56;
	Thu, 19 Dec 2024 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="h+cllVAO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XFo0tbg2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772911AA781
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630025; cv=none; b=j6Kmd7t7yfP4TVM96zpeD6wpFYsp3d0yhxzBlee1Q9ugc6BW4C465c5RNuvRNc0r+r0jUYo0hC5HXMIm63zS4RPF575Qiof16nbSZL0Inm8gfXN51mUstLKfXbnrABd2CBvJ1iLlkVw9xJRufsFwQBuLMyGGS5AiKzPhN37yqHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630025; c=relaxed/simple;
	bh=4Q50U/xavxT+s/ikNU3VY1+4oG9qYnhJPvvpZopVU9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jII/Z7phikjhW0/bEokUImPB686EhTc2ocN0IM/83xf6ZkJbnfo1ZoErk8MHZIj7wI5yrW6MHn6tMamZQI3BMNAO/QcNiFDSMbv4GB+I43bs5swsXwj/aDALbp1Eq1PoESuu+gKQoDO5VoW6zVp/qOuxqIEqkJJgf5LBJfYNtlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=h+cllVAO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XFo0tbg2; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 419DE114013A;
	Thu, 19 Dec 2024 12:40:22 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 19 Dec 2024 12:40:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1734630022;
	 x=1734716422; bh=Y9Y+kKXxjZpSp8HssmlsmHA5dEiDkW3vB5fHli9Q5Ig=; b=
	h+cllVAOGqTEri6hlKj6YRRwh6MwrC9WVMXJL1fj+IE40nDCL86xDHnY/edNCoJh
	zDlXU8ORctONnh0wAVEhlop1vFtdmFhTvcMi/vyjDc5T4ZcZK4XCSX1K3UUv2p/M
	d/1B6ERCuAHzaPtdeq0H/q6tf6NsN1GGdwa91S3kYMpMUVx59hieWTHXVNl1M0oP
	7c9hlZFn+0r8qYqib38PLJ0xaT8StEzb6VSLzt5ruLd6vY4clApUy8+mvrjzXqiM
	d/3MnmD6FcdTUHHqpPqxtWD42v9Y5T+PO3FK0HWpVDCqaWMBEFwRQbwePKMkhrLB
	qE1+kVxChTq5M0ZtjJtNag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734630022; x=
	1734716422; bh=Y9Y+kKXxjZpSp8HssmlsmHA5dEiDkW3vB5fHli9Q5Ig=; b=X
	Fo0tbg2ek9xd7c4RFkCF5PNO/zjILzW9Lyf8DciwdMcLTFqK7EBmTSgLxaStmNpS
	vTip0DceF6OIMaZRyv2LkALi2DlH3oCQP8FVxd10zFydES6v3iRzkUvlp2uPrIyR
	aEUUC6uNs5sxruvpVVHnvsdmQ9o3XNpC8woxBq679kcQUtZnLz6xjK4Pkih4A22Y
	Yf5GIb3x+vKXIv5TlJ1+Eq6RK3Vy5eICdPJFFZZBHnDH0k076vf4VIuVldIkfKvM
	5tox99XvM0uz25Nc3fFxjDWivAQYQF9hufLMyBQzqcr5w+vlTejeyJiKE8q6AVj3
	FrAmO5PHC17PAu95KGUjQ==
X-ME-Sender: <xms:hVpkZ8NVFWF5svf_UyqTdGXeSkJJHfcFuq8vpyhXe6lV-dBn5_O5Uw>
    <xme:hVpkZy_S3PL4x30C5zVKV_qi9Jrj9YWsU-t6S3Co1PDDn5tfvz7GC331GTKioChSu
    DhnLBEd1UYceK33>
X-ME-Received: <xmr:hVpkZzQQkEl57DIWq9cYbVvpCiu3-pJgrs8NSpOtK-MnDL9sgHmHC5xkRoO2p57-S3bBOTfy3T6n95eHXSfJUbhq98GgMcujT4rmcImPhOkbbV64Px9->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddttddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeduleefvdduvedu
    veelgeelffffkedukeegveelgfekleeuvdehkeehheehkefhfeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehshhgrkhgvvghlrdgsuhhttheslhhinhhugidruggvvhdp
    rhgtphhtthhopegurghvihgusehrvgguhhgrthdrtghomhdprhgtphhtthhopeiiihihse
    hnvhhiughirgdrtghomhdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghi
    lhdrtghomhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpth
    htoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjvghffhhlvgiguheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtph
    htthhopehjohhsvghfsehtohigihgtphgrnhgurgdrtghomhdprhgtphhtthhopehlihhn
    uhigqdhmmheskhhvrggtkhdrohhrgh
X-ME-Proxy: <xmx:hVpkZ0sKuQ26h9qv-XnLGqLllu0tlNoytOoB1ZDDnBnYkq4y_m_rUA>
    <xmx:hVpkZ0eIcNpUTVrfenef0nUgPdL--OlybKHZGMcyBPg7476VfqgoOA>
    <xmx:hVpkZ41stND5xRqRjKDBvYbpDQOBWvjHiy4n6W6fANDdxluB7cG5IA>
    <xmx:hVpkZ4938sBsiQKobwtWagR_5OHgdS8PQO5cBbaxZhRA23gzjSI2aw>
    <xmx:hlpkZz-4jY0cAwUic2GMlskszZ4PruBBhsrNPCWqUaFCu3eoWbBt9LmD>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Dec 2024 12:40:19 -0500 (EST)
Message-ID: <299ba044-265b-4056-ac85-c5680273feba@fastmail.fm>
Date: Thu, 19 Dec 2024 18:40:18 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com,
 josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>
References: <f30fba5f-b2ca-4351-8c8f-3ac120b2d227@redhat.com>
 <gdu7kmz4nbnjqenj5vea4rjwj7v67kjw6ggoyq7ok4la2uosqa@i5gxpmoopuii>
 <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
 <onnjsfrlgyv6blttpmfn5yhbv5q7niteiwbhoze3qnz2zuwldc@seooqlssrpvx>
 <43e13556-18a4-4250-b4fe-7ab736ceba7d@redhat.com>
 <ggm2n6wqpx4pnlrkvgzxclm7o7luqmzlv4655yf2huqaxrebkl@2qycr6dhcpcd>
 <968d3543-d8ac-4b5a-af8e-e6921311d5cf@redhat.com>
 <ssc3bperkpjyqdrlmdbh2woxlghua2t44tg4cywj5pkwwdcpdo@2jpzqfy5zyzf>
 <7b6b8143-d7a4-439f-ae35-a91055f9d62a@redhat.com>
 <2e13a67a-0bad-4795-9ac8-ee800b704cb6@fastmail.fm>
 <ukkygby3u7hjhk3cgrxkvs6qtmlrigdwmqb5k22ru3qqn242au@s4itdbnkmvli>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <ukkygby3u7hjhk3cgrxkvs6qtmlrigdwmqb5k22ru3qqn242au@s4itdbnkmvli>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/19/24 18:37, Shakeel Butt wrote:
> On Thu, Dec 19, 2024 at 06:30:34PM +0100, Bernd Schubert wrote:
>>
>>
>> On 12/19/24 18:26, David Hildenbrand wrote:
>>> On 19.12.24 18:14, Shakeel Butt wrote:
>>>> On Thu, Dec 19, 2024 at 05:41:36PM +0100, David Hildenbrand wrote:
>>>>> On 19.12.24 17:40, Shakeel Butt wrote:
>>>>>> On Thu, Dec 19, 2024 at 05:29:08PM +0100, David Hildenbrand wrote:
>>>>>> [...]
>>>>>>>>
>>>>>>>> If you check the code just above this patch, this
>>>>>>>> mapping_writeback_indeterminate() check only happen for pages under
>>>>>>>> writeback which is a temp state. Anyways, fuse folios should not be
>>>>>>>> unmovable for their lifetime but only while under writeback which is
>>>>>>>> same for all fs.
>>>>>>>
>>>>>>> But there, writeback is expected to be a temporary thing, not
>>>>>>> possibly:
>>>>>>> "AS_WRITEBACK_INDETERMINATE", that is a BIG difference.
>>>>>>>
>>>>>>> I'll have to NACK anything that violates ZONE_MOVABLE / ALLOC_CMA
>>>>>>> guarantees, and unfortunately, it sounds like this is the case
>>>>>>> here, unless
>>>>>>> I am missing something important.
>>>>>>>
>>>>>>
>>>>>> It might just be the name "AS_WRITEBACK_INDETERMINATE" is causing
>>>>>> the confusion. The writeback state is not indefinite. A proper fuse fs,
>>>>>> like anyother fs, should handle writeback pages appropriately. These
>>>>>> additional checks and skips are for (I think) untrusted fuse servers.
>>>>>
>>>>> Can unprivileged user space provoke this case?
>>>>
>>>> Let's ask Joanne and other fuse folks about the above question.
>>>>
>>>> Let's say unprivileged user space can start a untrusted fuse server,
>>>> mount fuse, allocate and dirty a lot of fuse folios (within its dirty
>>>> and memcg limits) and trigger the writeback. To cause pain (through
>>>> fragmentation), it is not clearing the writeback state. Is this the
>>>> scenario you are envisioning?
>>>
>>> Yes, for example causing harm on a shared host (containers, ...).
>>>
>>> If it cannot happen, we should make it very clear in documentation and
>>> patch descriptions that it can only cause harm with privileged user
>>> space, and that this harm can make things like CMA allocations, memory
>>> onplug, ... fail, which is rather bad and against concepts like
>>> ZONE_MOVABLE/MIGRATE_CMA.
>>>
>>> Although I wonder what would happen if the privileged user space daemon
>>> crashes  (e.g., OOM killer?) and simply no longer replies to any messages.
>>>
>>
>> The request is canceled then - that should clear the page/folio state
>>
>>
>> I start to wonder if we should introduce really short fuse request
>> timeouts and just repeat requests when things have cleared up. At least
>> for write-back requests (in the sense that fuse-over-network might
>> be slow or interrupted for some time).
>>
>>
> 
> Thanks Bernd for the response. Can you tell a bit more about the request
> timeouts? Basically does it impact/clear the page/folio state as well?

That is just an idea, needs more discussion first. Just sent an off list
message. 



