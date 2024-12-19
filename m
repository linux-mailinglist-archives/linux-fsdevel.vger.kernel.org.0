Return-Path: <linux-fsdevel+bounces-37839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D0A9F81DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF2747A227F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CB3194080;
	Thu, 19 Dec 2024 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="jJVAXStg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mp2Tzlxg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E5019DF6A
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734629442; cv=none; b=E8TUAn3tDcGil7OHe+/I1eAeOq+eWKwDNvxGECQ6brwOy7d7oJue0adHGEqzF9HRocKHMcyJYVmC6Vf9GP1HCJ02bpSu/lYj3xcNlPvDaE5CjDqlqml1WzXEjPrTYIkHt0rxsjT3YZAUPd+AaYcTVwVR/6UmjG9pK2ZokMfsCBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734629442; c=relaxed/simple;
	bh=POcjwhjz60XIRg/Oe0NTVEs+LLjPcyQ1lA9o8bPnbKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gzr5ZubhKuqmP1+GEVW3SqopV3S++6L5VHMcAf/bUFRj0OELO8rxzOCUNwR6MWaty6m79yVull5XoJUlqRIZ+1a4ADvUQEk4Oy44TGVLfuE6tpvZtADWBucUQHRfwWFDDo6v4Ul9VfB31WSz0+bCMTvIghkKGdQPWV4RAw3fTGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=jJVAXStg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mp2Tzlxg; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 58F281140174;
	Thu, 19 Dec 2024 12:30:39 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 19 Dec 2024 12:30:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1734629439;
	 x=1734715839; bh=IDuYtnssHU4nHmVzhDTI2qbL7scuU39ZTowlz3uiE2U=; b=
	jJVAXStgIaE/cowSCKqRN/uQtdwsD3U5KzfJS2CWbBZ6HPr6P78vOsIL0eV5Ufe1
	XMKGb2isjLBqALXY5cLCm4JvHWimsTVqS1jafK+atXlO1qZVwPEnv8dLTExKalBb
	4Ubx1DxX6xpgrTD/9D2jD0vXBfCAlitD8akVJ9ozgp6HkQ4Q8v8ZReIsY9hMKPQc
	M0NztlU8C2xxEscbvt2G0Ww6y6Ad4QvBL6v5YZ4TUorrq15OV9sKrGaJhoqH4Zqu
	mMdbDUAJ5F9RaLVkyaiu1kanPIDaZvX3fLHLF+sfUUGTmag29YimC7FmRh3u783y
	ikESqM55FtIUzTmVjmwpWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734629439; x=
	1734715839; bh=IDuYtnssHU4nHmVzhDTI2qbL7scuU39ZTowlz3uiE2U=; b=m
	p2TzlxgY6dAfW+mD3jflXT5lDSoUVSGBrxnk++wyKORrsOYgNnppJhxkEsIu0ZXU
	2SWyGljDK63xvxDwGuZRfqOAwQSmIBnwXhNOEt6hDC3aQF80CS5o+D/NCNyTRd/D
	G5nmUbocbZ0YvleSOt2xBU9yVne0oLQktfpPCu9AEtKTiKvKtr82pckGEsP5iApw
	mhV3v7FSDBHpqolyDZLv5bE8kNkrbG6aZ0My9zOv8Auos/MZLKq46HH9fXGnyHz1
	5C9A+3ukKV1hQZI5cRM5R3WJ+7iXIFrhpiePAR1GprYq3fFWvk1buXUjVElb3UO4
	+DA9Q/nULcZJ+6l6pVebg==
X-ME-Sender: <xms:PVhkZ6KkyA4iQkQCtQRGpTse5gfwbMDZ8MgPbu4tlW3Lcwi2EvWWzw>
    <xme:PVhkZyLBpRi2ZEeBSp0Nh7ho7HZbkiX4KUP04vj49tqPYJtVIzkrKlCqTDxxqFXBe
    24o6Db2fB_mmT5M>
X-ME-Received: <xmr:PVhkZ6sf0OgJIub9FhdhGOrzYW58_HLf6n1COsPn8MQ9dmYLjVORDAIrW0r6MKX4ExBOIsY8ETLRpiq0FhV1P6xtDTGYZXH4RKBwl92WES_lrfKMmtwc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddttddgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepudelfedvudevudev
    leegleffffekudekgeevlefgkeeluedvheekheehheekhfefnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhht
    sehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
    shhhrghkvggvlhdrsghuthhtsehlihhnuhigrdguvghvpdhrtghpthhtohepiihihiesnh
    hvihguihgrrdgtohhmpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtth
    hopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepjhgvfhhflhgvgihusehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpth
    htohepjhhoshgvfhesthhogihitghprghnuggrrdgtohhmpdhrtghpthhtoheplhhinhhu
    gidqmhhmsehkvhgrtghkrdhorhhg
X-ME-Proxy: <xmx:PVhkZ_aJmN1llx0z6ZEeNm_BWemBStHNNWqmpb7px15M2OdmJ9ZNmw>
    <xmx:PVhkZxaG8SQuBgmoR1j3QLqmVVedQ9k7HtiNhIx18cASWTZ6KllxAw>
    <xmx:PVhkZ7B3fOobFHA8x5viTZuu2tI6z6g2GFeWfMo6cMZ2oMBI5LwhRw>
    <xmx:PVhkZ3anZBPeCKJ2JhsTyOCOtqMCq7KNApBlYgVf_a7dIUmkZcYiSw>
    <xmx:P1hkZ1o0QK7MZSy0CyBkDBdlD8n-KXme2pkJbaFB2G5XnojRsDshB9l1>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Dec 2024 12:30:36 -0500 (EST)
Message-ID: <2e13a67a-0bad-4795-9ac8-ee800b704cb6@fastmail.fm>
Date: Thu, 19 Dec 2024 18:30:34 +0100
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
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: Zi Yan <ziy@nvidia.com>, Joanne Koong <joannelkoong@gmail.com>,
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
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <7b6b8143-d7a4-439f-ae35-a91055f9d62a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/19/24 18:26, David Hildenbrand wrote:
> On 19.12.24 18:14, Shakeel Butt wrote:
>> On Thu, Dec 19, 2024 at 05:41:36PM +0100, David Hildenbrand wrote:
>>> On 19.12.24 17:40, Shakeel Butt wrote:
>>>> On Thu, Dec 19, 2024 at 05:29:08PM +0100, David Hildenbrand wrote:
>>>> [...]
>>>>>>
>>>>>> If you check the code just above this patch, this
>>>>>> mapping_writeback_indeterminate() check only happen for pages under
>>>>>> writeback which is a temp state. Anyways, fuse folios should not be
>>>>>> unmovable for their lifetime but only while under writeback which is
>>>>>> same for all fs.
>>>>>
>>>>> But there, writeback is expected to be a temporary thing, not
>>>>> possibly:
>>>>> "AS_WRITEBACK_INDETERMINATE", that is a BIG difference.
>>>>>
>>>>> I'll have to NACK anything that violates ZONE_MOVABLE / ALLOC_CMA
>>>>> guarantees, and unfortunately, it sounds like this is the case
>>>>> here, unless
>>>>> I am missing something important.
>>>>>
>>>>
>>>> It might just be the name "AS_WRITEBACK_INDETERMINATE" is causing
>>>> the confusion. The writeback state is not indefinite. A proper fuse fs,
>>>> like anyother fs, should handle writeback pages appropriately. These
>>>> additional checks and skips are for (I think) untrusted fuse servers.
>>>
>>> Can unprivileged user space provoke this case?
>>
>> Let's ask Joanne and other fuse folks about the above question.
>>
>> Let's say unprivileged user space can start a untrusted fuse server,
>> mount fuse, allocate and dirty a lot of fuse folios (within its dirty
>> and memcg limits) and trigger the writeback. To cause pain (through
>> fragmentation), it is not clearing the writeback state. Is this the
>> scenario you are envisioning?
> 
> Yes, for example causing harm on a shared host (containers, ...).
> 
> If it cannot happen, we should make it very clear in documentation and
> patch descriptions that it can only cause harm with privileged user
> space, and that this harm can make things like CMA allocations, memory
> onplug, ... fail, which is rather bad and against concepts like
> ZONE_MOVABLE/MIGRATE_CMA.
> 
> Although I wonder what would happen if the privileged user space daemon
> crashes  (e.g., OOM killer?) and simply no longer replies to any messages.
> 

The request is canceled then - that should clear the page/folio state


I start to wonder if we should introduce really short fuse request
timeouts and just repeat requests when things have cleared up. At least
for write-back requests (in the sense that fuse-over-network might
be slow or interrupted for some time).


Thanks,
Bernd


