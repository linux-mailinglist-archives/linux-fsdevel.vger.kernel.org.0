Return-Path: <linux-fsdevel+bounces-36736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5B49E8D09
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 09:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343911881777
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 08:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FD5215075;
	Mon,  9 Dec 2024 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="gO+gGVAN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MMvzIvd3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D82C189B85
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 08:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733731611; cv=none; b=B+yOKLXcTq/dK/rMRhoiTdxNHojlkyU2eev4rPwh1mKrC4T904EtfdJWHaoUc/URwC7++X7wt5C16uS9NZKjxckx0QYjZivGO3qvCtd640LK/pXqXYwXLzHHn+yL/4thgoEN+bafZhLgjr/OdOiGFLHJ/9RT5QtaB1C+qPLLk+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733731611; c=relaxed/simple;
	bh=brlwBf89Z4BwzynDzicXQhcKnmNktGILS9164g5okzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=le0qRXdeXS+q8hcXVElqifWIJasrgbBBW7uQewuqs9d4hsNcF7rHrMmy7Oe+kVrhB/7Y5pHot1y9Hp+kQKM4SMhdQ9AP9s1P/cliGFz929K7/mwFZ4O6XbwdLT/ERaREg5qkbjE1qNbaq/1tT9hi8iTTXTX9oPhO2KcpWq9MGzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=gO+gGVAN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MMvzIvd3; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 157F7114012A;
	Mon,  9 Dec 2024 03:06:48 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 09 Dec 2024 03:06:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1733731607;
	 x=1733818007; bh=nJ2TfVg6myUkiNygNGPlyFOd8lthy9lDT4fL1AZENhQ=; b=
	gO+gGVANO+99z8SIX34XkdpmsPw2bmm1T7+QbPpKFSpEWWDERGgDY0N5/hRH1x1x
	inEl+jg22XV35UFNUXs72UfI/XHorl5zXy9MFJimazjRdmYutX8YwbVlJiWpDWO2
	ZsI2JlSVuhRq/3RWiyyQ1PZy9OsT9uAftWFIgu5dTdFpEvihLgHhc/UL3c86e0B5
	MuSNjhiVgNh9fzDCfKiYW9rDfBVcGVI6frKjGId22x7QIJB9wU1CVucnCynDeVYV
	dnDFatVUjkg+KvPG9rJJo/M5vHciaywKJ9eCtENK7QYskuAoj7Q8f/omgJrPG8m5
	p3y+U6WQLD4VHe9eb4FxvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733731607; x=
	1733818007; bh=nJ2TfVg6myUkiNygNGPlyFOd8lthy9lDT4fL1AZENhQ=; b=M
	MvzIvd36Fgg4mLRPQeaI0XlW6iVBZLAWZ/4y2uO3aZwoBEODeTNCqHHvh3IIA6TB
	fI9xlJ4yN748AK1QjRuNoB98EsaOTWsQd9ruoz2gVtncGAuto8ojYGGpcn9Yf5Xz
	sKIitZXYliDmrQcRgZgDbwnQ4AE8LMVGzhS9I5tqcyNxp73qPi7w20o/6KAdYHad
	JwL6inn2Q1nU5uEuwJ7MP6ERIsBJkSFQWHR6D4+sP599BtLWMfAZzzzCBuYBGGF/
	jWskFhcc9C39cCOQPNOkPSXC82tMxIfiOYaWVtiDnhKnGu9kqu/yZP9jAp9mUNMP
	a9l5bEbK+i/iY7em35w9g==
X-ME-Sender: <xms:FqVWZ3hnN7wEaMwyek7ZX_6_8P_kaQytZpjF7Q8nb9JCNKbtES-o3A>
    <xme:FqVWZ0D6IqWUwlYWruYv4Tfy_AZWQvWoej7XKurIwW5YakMnfMrpAeMIlrAQdmBTl
    xiU8XGH6FZYbNqZ>
X-ME-Received: <xmr:FqVWZ3FlGueUxsX25QuBbOX_7MOjVLmuMhR-v71BgZ_vtgUyanZPhTceNA1pLbKFs0BkyHR52dz9HZELC8i_NL-nLBN3x7aTSlPaiUziNRgZ_sZ1b4op>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeeggdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnh
    gurdgtohhmqeenucggtffrrghtthgvrhhnpedtuedvueduledtudekhfeuleduudeijedv
    veevveetuddvfeeuvdekffejleeuueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhn
    ugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepmhgrlhhtvgdrshgthhhrohgvuggvrhesthhngihiphdruggv
    pdhrtghpthhtohepjhgvfhhflhgvgihusehlihhnuhigrdgrlhhisggrsggrrdgtohhmpd
    hrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehk
    vghnthdrohhvvghrshhtrhgvvghtsehlihhnuhigrdguvghvpdhrtghpthhtohepmhhsii
    gvrhgvughisehrvgguhhgrthdrtghomhdprhgtphhtthhopehjohhsvghfsehtohigihgt
    phgrnhgurgdrtghomhdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilh
    drtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepsghstghhuhgsvghrthesuggunhdrtghomh
X-ME-Proxy: <xmx:FqVWZ0QjcOQucFc5orcnzLPyoarq_iBttW73j29uHhdP_Mt1QT9uhg>
    <xmx:FqVWZ0zgYbpoIlSebD-NWZ8ImhLPlwy3DPSqOAuaU7XAcHghF6Jg2w>
    <xmx:FqVWZ65kJ3qqYEwL7jARYu5caHqKF9wuGljaks_OFYWGNS3-4pMl1w>
    <xmx:FqVWZ5zDP47M1UhlKoWq3qPE341ZrnZ0UkmnrPvY6StcuroRY3kcig>
    <xmx:F6VWZwedpHiRv5HK2OzXYTUyhUFp3zOuJWbo9VKUsWChhODLjkXqiw-1>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Dec 2024 03:06:45 -0500 (EST)
Message-ID: <0c7205c3-f2f2-4400-8b1c-3adda48fdeab@bsbernd.com>
Date: Mon, 9 Dec 2024 09:06:44 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: silent data corruption in fuse in rc1
To: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>,
 Jingbo Xu <jefflexu@linux.alibaba.com>, Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Miklos Szeredi <mszeredi@redhat.com>, Josef Bacik <josef@toxicpanda.com>,
 Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org,
 Bernd Schubert <bschubert@ddn.com>
References: <p3iss6hssbvtdutnwmuddvdadubrhfkdoosgmbewvo674f7f3y@cwnwffjqltzw>
 <cb2ceebc-529e-4ed1-89fa-208c263f24fd@tnxip.de>
 <Z1T09X8l3H5Wnxbv@casper.infradead.org>
 <68a165ea-e58a-40ef-923b-43dfd85ccd68@tnxip.de>
 <2143b747-f4af-4f61-9c3e-a950ab9020cf@tnxip.de>
 <0d5ac910-97c1-44a8-aee7-56500a710b9e@linux.alibaba.com>
 <804c06e3-4318-4b78-b108-12e0843c2855@tnxip.de>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <804c06e3-4318-4b78-b108-12e0843c2855@tnxip.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Malte,

On 12/9/24 07:42, Malte Schröder wrote:
> On 09/12/2024 02:57, Jingbo Xu wrote:
>> Hi, Malte
>>
>> On 12/9/24 6:32 AM, Malte Schröder wrote:
>>> On 08/12/2024 21:02, Malte Schröder wrote:
>>>> On 08/12/2024 02:23, Matthew Wilcox wrote:
>>>>> On Sun, Dec 08, 2024 at 12:01:11AM +0100, Malte Schröder wrote:
>>>>>> Reverting fb527fc1f36e252cd1f62a26be4906949e7708ff fixes the issue for
>>>>>> me.     
>>>>> That's a merge commit ... does the problem reproduce if you run
>>>>> d1dfb5f52ffc?  And if it does, can you bisect the problem any further
>>>>> back?  I'd recommend also testing v6.12-rc1; if that's good, bisect
>>>>> between those two.
>>>>>
>>>>> If the problem doesn't show up with d1dfb5f52ffc? then we have a dilly
>>>>> of an interaction to debug ;-(
>>>> I spent half a day compiling kernels, but bisect was non-conclusive.
>>>> There are some steps where the failure mode changes slightly, so this is
>>>> hard. It ended up at 445d9f05fa149556422f7fdd52dacf487cc8e7be which is
>>>> the nfsd-6.13 merge ...
>>>>
>>>> d1dfb5f52ffc also shows the issue. I will try to narrow down from there.
>>>>
>>>> /Malte
>>>>
>>> Ha! This time I bisected from f03b296e8b51 to d1dfb5f52ffc. I ended up
>>> with 3b97c3652d91 as the culprit.
>> Would you mind checking if [1] fixes the issue?  It is a fix for
>> 3b97c3652d91, though the initial report shows 3b97c3652d91 will cause
>> null-ptr-deref.
>>
>>
>> [1]
>> https://lore.kernel.org/all/20241203-fix-fuse_get_user_pages-v2-1-acce8a29d06b@ddn.com/
> It does not fix the issue, still behaves the same.
> 

could you give instructions how to get the issue? Maybe we can script it and I let 
it run in a loop on one my systems?


Thanks,
Bernd

