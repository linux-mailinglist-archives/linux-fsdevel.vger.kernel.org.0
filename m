Return-Path: <linux-fsdevel+bounces-38151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAC89FCED9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 23:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163FD3A0338
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 22:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18FF1B87D9;
	Thu, 26 Dec 2024 22:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="HujmXv+G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZMvntYwt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A355F1A238A
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2024 22:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735253084; cv=none; b=CG71ALsWxk78INct8VWz4XRC0cCBmnnawLPXNHtFQ1Vj6d8gCwJ34vqMOO4JLA1Bz3CRr+fv11D3ZHuY7/q/HoJZvwwLb97OVL0JRK/0uGCizNdpFCStxchUQgqXaWbexkWn4110mj2Gkz4O1wTwSTl1/5TzDexQ3dCto+kSEfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735253084; c=relaxed/simple;
	bh=kYyBbSnFrVbk5JrapuSoKBCK2xx26UHvk9QV7qD8/xU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R0o63q5n/PbuTNxwD9KxZE4+4pZ73hgnsS+fd9uqeGU5UfuowwSt2ibSOrDAdPhrYH/UTyMEpEUyR0jf1Gd7HEasAwbdHbmn4aUXkhdQ48Nf/eW/lxkR7z1WfS7/wkQDd29VGkEzMe5CMY8Mu5CoDmlc6GA+6TTxCLNbLf5f1gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=HujmXv+G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZMvntYwt; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 90393138012C;
	Thu, 26 Dec 2024 17:44:41 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 26 Dec 2024 17:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735253081;
	 x=1735339481; bh=iHVQm7mLnu5hDjafzYNY1v9wHWbw0TuXuoeVqRtAxss=; b=
	HujmXv+GC+y+G3pNOJAEe8uugZ5cCKBhMkaZQKyoBjQNTfKRSGKVeiIsaovUncss
	qeslyj3w7M080MIGRlr8r7n84Cs5mh5KPkF0I5UHOOWV+rL26x1uEFucd06XYEYS
	yQ6YnoAPco+x0pjcTRB2H8Oq2d3xBiFp70RrXNRWc8uGf41odqgQQwgHubkP5ABp
	6Pi27Gd73yC8fvUXqj2LRvTW5QNqp7b0Ukx9NGm38kDRPiSORouMnS7Pr/sEuu2E
	45U195ik3TcuGA2UBpiRJZCkUV3Otwv0beam27Pe5gDjHffT7JXkTXRUQJitP/LV
	uUEWwQMUfPCN28yGmfcxUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735253081; x=
	1735339481; bh=iHVQm7mLnu5hDjafzYNY1v9wHWbw0TuXuoeVqRtAxss=; b=Z
	MvntYwtG4Ick8EIBUERZioyNz2yjI5jehpAGkSrbl4Qzk5t7cYhznaxpGPc86m/8
	ahaKS8tgrQtPErpmO/HtoXQ/igyAtms8DXnaimU4EpKi79WfOOgiP9y2XvvVv4xa
	I376rkivgyXvC89/2GgTZZZJIcLrehRIXASAWbWAkkEifGwhFgczampziasFmB0v
	ZN258hrqxffEB9dflgqCckYxE8IzTYve3BbtGRBjT5AQxk+007QboFCl1OgcUNvw
	HY8cPTGR2Nkm0xTA2bwVFkhq60JcOSDb1GCVw6Qn/8AaqkGEDK7H6tipU1NmEKLF
	pIUPOEobSiai9BhKwMFeA==
X-ME-Sender: <xms:WNxtZ-my0OumxMkUAEh4krd8Px4Nw6RFMx27jM9bL3yeNHUe5w-HZQ>
    <xme:WNxtZ12fWy2U7351R3rJ-NjO6ABjqoyvrd8B_Gkb4cEn2Ki7cQynQ50sOuxxPK_MX
    UGGLAWqm5xAqn2W>
X-ME-Received: <xmr:WNxtZ8rATChVoxS5a0ryXAgVSN7qkVM08aspNNZzpWfX-vsM8oZqHG0XlwSs83Cf-ZhAn6JwJvB0-qQ27q3z9VVc-jPiN_qKnFktwcKhtWEwYzieFhEz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudduledgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepudelfedvudevudev
    leegleffffekudekgeevlefgkeeluedvheekheehheekhfefnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhht
    sehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepshhhrghkvg
    gvlhdrsghuthhtsehlihhnuhigrdguvghvpdhrtghpthhtohepiihihiesnhhvihguihgr
    rdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtth
    hopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepjhgvfhhflhgvgihusehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpth
    htohepjhhoshgvfhesthhogihitghprghnuggrrdgtohhmpdhrtghpthhtoheplhhinhhu
    gidqmhhmsehkvhgrtghkrdhorhhg
X-ME-Proxy: <xmx:WNxtZyn-_kicmbIjUEJbg6-NaDizQIZbPNdjfwgdRaEu590gt7g0Kw>
    <xmx:WNxtZ83R-kQZFjaOBj3D7S4_I8HecQWLMlbG-zGDuurdOk_heJZB_w>
    <xmx:WNxtZ5seLGctdYnQoODHNzUZSmSJFzJH_Y-mn82fDY1Qqn6L9dBK5w>
    <xmx:WNxtZ4XbyaSdsCrjz0CrUBwPP3L_ydOg2d9RHRCiMJ9E4FeOrDAs2Q>
    <xmx:WdxtZ323Pq0fZNMzlAxiKr-7pIY3hmrXq9Vb8CrMOqwB3ILBrnV1BoFe>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 17:44:38 -0500 (EST)
Message-ID: <b3466cec-7689-485a-8ffb-206c9b50ccc2@fastmail.fm>
Date: Thu, 26 Dec 2024 23:44:37 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Joanne Koong <joannelkoong@gmail.com>
Cc: David Hildenbrand <david@redhat.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Zi Yan <ziy@nvidia.com>,
 miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org,
 kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>,
 Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
References: <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
 <43e13556-18a4-4250-b4fe-7ab736ceba7d@redhat.com>
 <ggm2n6wqpx4pnlrkvgzxclm7o7luqmzlv4655yf2huqaxrebkl@2qycr6dhcpcd>
 <968d3543-d8ac-4b5a-af8e-e6921311d5cf@redhat.com>
 <ssc3bperkpjyqdrlmdbh2woxlghua2t44tg4cywj5pkwwdcpdo@2jpzqfy5zyzf>
 <7b6b8143-d7a4-439f-ae35-a91055f9d62a@redhat.com>
 <2e13a67a-0bad-4795-9ac8-ee800b704cb6@fastmail.fm>
 <ukkygby3u7hjhk3cgrxkvs6qtmlrigdwmqb5k22ru3qqn242au@s4itdbnkmvli>
 <CAJnrk1bRk9xkVkMg8twaNi-gWBRps7A6HubMivKBHQiHzf+T8w@mail.gmail.com>
 <2bph7jx4hvhxpgp77shq2j7mo4xssobhqndw5v7hdvbn43jo2w@scqly5zby7bm>
 <71d7ac34-a5e5-4e59-802b-33d8a4256040@redhat.com>
 <b16bff80-758c-451b-a96c-b047f446f992@fastmail.fm>
 <9404aaa2-4fc2-4b8b-8f95-5604c54c162a@redhat.com>
 <CAJnrk1YWJKcMT41Boa_NcMEgx1rd5YN-Qau3VV6v3uiFcZoGgQ@mail.gmail.com>
 <61a4bcb1-8043-42b1-bf68-1792ee854f33@redhat.com>
 <166a147e-fdd7-4ea6-b545-dd8fb7ef7c2f@fastmail.fm>
 <CAJnrk1ZzOnBwj8HoABWuUZvigMzFaha+YeC117DR1aDJDuOQRg@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1ZzOnBwj8HoABWuUZvigMzFaha+YeC117DR1aDJDuOQRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/23/24 20:00, Joanne Koong wrote:
> On Sat, Dec 21, 2024 at 1:59 PM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>>
>>
>> On 12/21/24 17:25, David Hildenbrand wrote:
>>> On 20.12.24 22:01, Joanne Koong wrote:
>>>> On Fri, Dec 20, 2024 at 6:49 AM David Hildenbrand <david@redhat.com>
>>>> wrote:
>>>>>
>>>>>>> I'm wondering if there would be a way to just "cancel" the
>>>>>>> writeback and
>>>>>>> mark the folio dirty again. That way it could be migrated, but not
>>>>>>> reclaimed. At least we could avoid the whole
>>>>>>> AS_WRITEBACK_INDETERMINATE
>>>>>>> thing.
>>>>>>>
>>>>>>
>>>>>> That is what I basically meant with short timeouts. Obviously it is not
>>>>>> that simple to cancel the request and to retry - it would add in quite
>>>>>> some complexity, if all the issues that arise can be solved at all.
>>>>>
>>>>> At least it would keep that out of core-mm.
>>>>>
>>>>> AS_WRITEBACK_INDETERMINATE really has weird smell to it ... we should
>>>>> try to improve such scenarios, not acknowledge and integrate them, then
>>>>> work around using timeouts that must be manually configured, and ca
>>>>> likely no be default enabled because it could hurt reasonable use
>>>>> cases :(
>>>>>
>>>>> Right now we clear the writeback flag immediately, indicating that data
>>>>> was written back, when in fact it was not written back at all. I suspect
>>>>> fsync() currently handles that manually already, to wait for any of the
>>>>> allocated pages to actually get written back by user space, so we have
>>>>> control over when something was *actually* written back.
>>>>>
>>>>>
>>>>> Similar to your proposal, I wonder if there could be a way to request
>>>>> fuse to "abort" a writeback request (instead of using fixed timeouts per
>>>>> request). Meaning, when we stumble over a folio that is under writeback
>>>>> on some paths, we would tell fuse to "end writeback now", or "end
>>>>> writeback now if it takes longer than X". Essentially hidden inside
>>>>> folio_wait_writeback().
>>>>>
>>>>> When aborting a request, as I said, we would essentially "end writeback"
>>>>> and mark the folio as dirty again. The interesting thing is likely how
>>>>> to handle user space that wants to process this request right now (stuck
>>>>> in fuse_send_writepage() I assume?), correct?
>>>>
>>>> This would be fine if the writeback request hasn't been sent yet to
>>>> userspace but if it has and the pages are spliced
>>>
>>> Can you point me at the code where that splicing happens?
>>
>> fuse_dev_splice_read()
>>   fuse_dev_do_read()
>>     fuse_copy_args()
>>       fuse_copy_page
>>
>>
>> Btw, for the non splice case, disabling migration should be
>> only needed while it is copying to the userspace buffer?
> 
> I don't think so. We don't currently disable migration when copying
> to/from the userspace buffer for reads.


Sorry for my late reply. I'm confused about "reads". This discussions
is about writeback?
Without your patches we have tmp-pages - migration disabled on these. 
With your patches we have AS_WRITEBACK_INDETERMINATE - migration
also disabled?

I think we have two code paths

a) fuse_dev_read - does a full buffer copy. Why do we need tmp-pages
for these at all? The only time migration must not run on these pages
while it is copying to the userspace buffer?

b) fuse_dev_splice_read - isn't this our real problem, as we don't
know when pages in the pipe are getting consumed?


Thanks,
Bernd


