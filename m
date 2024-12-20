Return-Path: <linux-fsdevel+bounces-37929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EE59F91FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 13:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F79188CBE3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 12:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE86E1C5CC1;
	Fri, 20 Dec 2024 12:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="Y59c+By/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QdeoGkyg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1652F1C549E
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734696948; cv=none; b=adBc473QkdbWm98YrnMrSvWjsNYG6poYIFrxMZS2sChAhTLp5DnVxrh137TX3RJuClIKjW3fTPzB+Nn+7md0oU0QJ2V9Tm0OM71Lae2QzZ6tMGzms6siTWOyDZSvrKmWAKm2CPPS9VBQ0fkCU+PFiyCkBj+pY3r8Uk1uCv/MR0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734696948; c=relaxed/simple;
	bh=kIiqKxX5ary8UkLEKVQhK+O4Q9YlzHk8WI1WJSsyJRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jCnIBkcHiztG0uNgHrFOT4oiKN1efKenB7AmUYhICp6BszeGrqucs0zQxV0wfFbR7ZlOa0teGSlJuTHwj+JE02lfKjRmitpZNyQW+QjXjG2ioUpl8L6v0N5rDxKvi1W91JD0pjZG4+tF2b+j1b7w75bLDZrtuYaqZK4Wc0pQIdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=Y59c+By/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QdeoGkyg; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D4E5F25401F2;
	Fri, 20 Dec 2024 07:15:44 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 20 Dec 2024 07:15:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1734696944;
	 x=1734783344; bh=+YGk28ztcSAWjy0uYggB9XXCE8N2gUhF1YO1R6mlzLg=; b=
	Y59c+By/BKXKhLTZGutksTiVzXmlh8WW2yZkyPbb/Uz3wQjTS1qw4ocjMOCf7tJs
	SpDvgLktO7JMK+jtiRDOy8aZ8sF5Gv3RgKAl1ETd0fSxzg+iorW9KNAHYrAgn48s
	HFtfAcAQfdrrSIXT2FvR2uCx0UEgKB9pXiYzb5Dqsi9aePwDTb4IIeXVk2Fuzs1M
	vwXbrtFiW7aZZX+oId96HZjkrez3y0CvPnw0ZVzFqg3ExPAwo1bdKYzegeRu5bcP
	j7hhhsexJkd7x9g1JC9o8NQ6mdw5xiuhLUY70fbTS1Ht39HGLvLekSFQZIEe1VZa
	szWpzgQ9RQi248/AOkp7/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734696944; x=
	1734783344; bh=+YGk28ztcSAWjy0uYggB9XXCE8N2gUhF1YO1R6mlzLg=; b=Q
	deoGkygSbRte96yoqCBzNFy/jkC1YAhRpFA+9so3li+2yVdYZhDuDZOIWeiash3p
	exSMADNg5wyy7VuNFHcVlIbPykWnO4a6SQICR47jejkfymaflxu3pOyYkRrjzSEG
	Ac7Qz2J03sErExfhlf+yjc/qYoI4qrq77vtNwViNZnh9GLwh30Be90WMsn6mW6Uy
	zoZz8FDAI1yNfZe2tVZ3p+ylv1+r76bujMEx+NIfa+snfK1gzAWkerGLtmPnee+M
	eEZWzdTQuDZpcCGcYw7zvstfqihDktc04RVHKznslbeSyHV0M3nTX07UpWJOf1V0
	SrZooqYfPnTvCKm8CoeSA==
X-ME-Sender: <xms:719lZ1h7P2a0hIeMcCUUpCIpCB8o4oIcq-EJ0nYuMYoB_YeLJCYIsA>
    <xme:719lZ6Cw7t5AxS0cDOvOg3uyZlCy1g5n8IVDZEfAYxbPafwyI8IBk4B-kDn5lpqXa
    jf3fMkbP2JDvqZJ>
X-ME-Received: <xmr:719lZ1FMMel9h4TVG7Z5wK2pvRQ22qz4clEwzkzgPgxrql0zPQXohQAUpZpNAP_I5B9dmqHM9iQLEri6dsKew-KINas6Wf0RQ0eY-YpCR2PbH591AhuS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefgueektdefuefg
    keeuieekieeljeehffejheeludeifeetueefhfetueehhfefnecuffhomhgrihhnpehkvg
    hrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmhdpnhgspg
    hrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgu
    sehrvgguhhgrthdrtghomhdprhgtphhtthhopehshhgrkhgvvghlrdgsuhhttheslhhinh
    hugidruggvvhdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtgho
    mhdprhgtphhtthhopeiiihihsehnvhhiughirgdrtghomhdprhgtphhtthhopehmihhklh
    hoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjvghffhhlvgiguheslhhinh
    hugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehjohhsvghfsehtohigihgtphgr
    nhgurgdrtghomhdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrgh
X-ME-Proxy: <xmx:719lZ6SwHXIrc6MHm8aR9m3C_8mf-9YcZBFbHngmMGRc3DrcaFcVJA>
    <xmx:719lZyxSy47vV-k_jhsAsoLSutwLa7ONw4G6I2iWTZy4_NxeSrU84w>
    <xmx:719lZw4h3OGHTMTLEeg_cKrLqVoN_ml2Odr67kDPm5n2_PPH1ZZGKQ>
    <xmx:719lZ3w48v-X1ma22UlB0CswYX0oAXxebH3PnMwKIYPd1-vFRQMv-Q>
    <xmx:8F9lZ2hXgpNKEkJu8hW1gTUbBDmrgHWyu5yolkuE54rlUYGvnZ-6S2IL>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 07:15:41 -0500 (EST)
Message-ID: <b16bff80-758c-451b-a96c-b047f446f992@fastmail.fm>
Date: Fri, 20 Dec 2024 13:15:40 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: David Hildenbrand <david@redhat.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Joanne Koong <joannelkoong@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com,
 josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>
References: <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
 <onnjsfrlgyv6blttpmfn5yhbv5q7niteiwbhoze3qnz2zuwldc@seooqlssrpvx>
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
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <71d7ac34-a5e5-4e59-802b-33d8a4256040@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/20/24 12:44, David Hildenbrand wrote:
> On 19.12.24 18:54, Shakeel Butt wrote:
>> On Thu, Dec 19, 2024 at 09:44:42AM -0800, Joanne Koong wrote:
>>> On Thu, Dec 19, 2024 at 9:37 AM Shakeel Butt <shakeel.butt@linux.dev>
>>> wrote:
>> [...]
>>>>>
>>>>> The request is canceled then - that should clear the page/folio state
>>>>>
>>>>>
>>>>> I start to wonder if we should introduce really short fuse request
>>>>> timeouts and just repeat requests when things have cleared up. At
>>>>> least
>>>>> for write-back requests (in the sense that fuse-over-network might
>>>>> be slow or interrupted for some time).
>>>>>
>>>>>
>>>>
>>>> Thanks Bernd for the response. Can you tell a bit more about the
>>>> request
>>>> timeouts? Basically does it impact/clear the page/folio state as well?
>>>
>>> Request timeouts can be set by admins system-wide to protect against
>>> malicious/buggy fuse servers that do not reply to requests by a
>>> certain amount of time. If the request times out, then the whole
>>> connection will be aborted, and pages/folios will be cleaned up
>>> accordingly. The corresponding patchset is here [1]. This helps
>>> mitigate the possibility of unprivileged buggy servers tieing up
>>> writeback state by not replying.
>>>
>>
>> Thanks a lot Joanne and Bernd.
>>
>> David, does these timeouts resolve your concerns?
> 
> Thanks for that information. Yes and no. :)
> 
> Bernd wrote: "I start to wonder if we should introduce really short fuse
> request timeouts and just repeat requests when things have cleared up.
> At least for write-back requests (in the sense that fuse-over-network
> might be slow or interrupted for some time).
> 
> Indicating to me that while timeouts might be supported soon (will there
> be a sane default?) even trusted implementations can run into this
> (network example above) where timeouts might actually be harmful I suppose?

Yeah and that makes it hard to provide a default. In Joannes timeout patches
the admin can set a system default.

https://lore.kernel.org/all/20241218222630.99920-3-joannelkoong@gmail.com/

> 
> I'm wondering if there would be a way to just "cancel" the writeback and
> mark the folio dirty again. That way it could be migrated, but not
> reclaimed. At least we could avoid the whole AS_WRITEBACK_INDETERMINATE
> thing.
> 

That is what I basically meant with short timeouts. Obviously it is not
that simple to cancel the request and to retry - it would add in quite
some complexity, if all the issues that arise can be solved at all.


Thanks,
Bernd

