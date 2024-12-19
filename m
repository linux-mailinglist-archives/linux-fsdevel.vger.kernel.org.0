Return-Path: <linux-fsdevel+bounces-37813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44579F7EA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 16:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E47E168318
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 15:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63138227566;
	Thu, 19 Dec 2024 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="H2L69tPu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="luavtjKa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB4013790B
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623822; cv=none; b=WPFfqG/SXUVGpSQMnZETiH/qx5bnONbODDnUdbeN3vv0Hx91T8sAl0H9rhI/6bVeY1GQUmLL1yODLN0YIfx3PE95d5xtMgTMQDOupcal183KBx8C7Y3Qtc1AEW3FscU0yY7ErFkI0fj6UJCfO/EdA/5KC2qIxrWZdoB1oO3Ukvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623822; c=relaxed/simple;
	bh=Yiioeo46zVZn58BFRWmLpjlnoZj5qlNpPGz1PxUzfA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sd7fIqWEDE3SAWbZ3LP5jA06uZiX8GC8JlQA8CbicSkUWZx5mdZOd2F3Xehf49EqJq34ow1nFUVIwD9UqpDgO23vDi2nusPgqJo8aa5XK4urDx3Henpa94ntf5dXNMiLgeLPctVNyNfxMplwlAhAwOSgbxMngRXMgee32dqb+LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=H2L69tPu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=luavtjKa; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9250025401A9;
	Thu, 19 Dec 2024 10:56:58 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 19 Dec 2024 10:56:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1734623818;
	 x=1734710218; bh=gc5vkcYiT+hiUXtKigBqPhX1kK7DHuuPpXaxTMlQJMo=; b=
	H2L69tPubHKtm17n31PcNMoRe3bySPokbKS9N8j2QwXOzk0WWgwy0L19XlYhoj9+
	kKe/oRw1uL18hWaMRNjFq9nmW4bXdflRNb6xhiY2fRc7iwjCiX9d2JYNcC3R6Llp
	VbtaoTGBW6b0X5VA3IrogbGGPU20yoOk+LWmhBb1RDSLV2ztW6s27fbRd1Rfe8By
	8VJO+5UIYg2y2M4P5Q8EIyzA1k/9rq+HfElYH85Q+g3ZM/evgPkLsNhQsAm5zjvu
	btFD5iXdvU41hk39cZyp22X2kG6ABrGwbbPW42MX2BIyBL0obgSwi3IoO5lq1O0C
	GG5XCLJIqjsee/x8skxjYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734623818; x=
	1734710218; bh=gc5vkcYiT+hiUXtKigBqPhX1kK7DHuuPpXaxTMlQJMo=; b=l
	uavtjKao08408yQ5sIIG5bWX2yY6F3FBMqPPx3VKnjxw6SSdUqBR3FaTbXgLrMMd
	g4ZEfpN3Sy/9Xn1/hPahuUTqNKclRXUAUJPzw/Fh7S9pj2+v63aQyd1IbySWGFjY
	MwR4LaW4FxXI2UoRQkel1O1IqFpI1Iiws6glvlcwkTR+wQms8JjqptNnqz0qqlVO
	cyb8Eb5KROGrBJnXWo1XoSdFsH0FftXOmtnTdLExUO8ngfY7NAR2bMbW722FhGFY
	nFEvRExn0eg3zpoc518LYLxt75z48BNIvHSqlNe7aAW45NM152KMOSA4AjGu8IlG
	TJOpcav2ubQJc2Vyhe+tw==
X-ME-Sender: <xms:SEJkZ78AJb5eAfde_UQ5X05lihavq0J8JYVnZPVnurvuFVIU8NIXsQ>
    <xme:SEJkZ3sHd86zrI--xMakeoraFoIIunSbUZXquO0yBaaTcOnYzzo_4hyHgXIEe2CNe
    bBbPuBNvxhdJlHd>
X-ME-Received: <xmr:SEJkZ5AJK2DPuB6vv0xvgWpR98k0LnuswltiSF38u4yvPuLuJt4-RyuHe9JcqmkTD0Uy9NMIOkObHernGbEJWG54qXjwkMwSKwi5qvxE0tbHYITL-yLM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddttddgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfg
    tdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhht
    sehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepiihihiesnhhvihguihgrrdgtohhmpdhrtghpthhtohepshhh
    rghkvggvlhdrsghuthhtsehlihhnuhigrdguvghvpdhrtghpthhtohepuggrvhhiugesrh
    gvughhrghtrdgtohhmpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtth
    hopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepjhgvfhhflhgvgihusehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpth
    htohepjhhoshgvfhesthhogihitghprghnuggrrdgtohhmpdhrtghpthhtoheplhhinhhu
    gidqmhhmsehkvhgrtghkrdhorhhg
X-ME-Proxy: <xmx:SUJkZ3fejZJGxUUPmgn8dK1Pe9XNk4OR8LuDS5dkgAbfkRRWfZhWSQ>
    <xmx:SUJkZwNnPmDHirV7lcbAaPJtUi-4U9QIXHsE0q7oLljfL6SwC3iHjg>
    <xmx:SUJkZ5kqyRwXMsZWcG0ndh_xxtCZzMj4m0EBXDwHa4iQwxlGGpfLQw>
    <xmx:SUJkZ6sqlmOR-0nhB4vOFHWgCOAZ01k-Es5FVlSa-fJ7iw0379fIrA>
    <xmx:SkJkZyu2XDGan-EZEswTrYUkKn_X0KsQ6wv7WnHPkJTRlpL00t_7ZcX1>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Dec 2024 10:56:55 -0500 (EST)
Message-ID: <ec27cb90-326a-40b8-98ac-c9d5f1661809@fastmail.fm>
Date: Thu, 19 Dec 2024 16:56:54 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: David Hildenbrand <david@redhat.com>,
 Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com,
 josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>
References: <20241122232359.429647-1-joannelkoong@gmail.com>
 <20241122232359.429647-5-joannelkoong@gmail.com>
 <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
 <hltxbiupl245ea7b4rzpcyz3d62mzs6igcx42g7zsksanbxqb3@sho3dzzht3rx>
 <f30fba5f-b2ca-4351-8c8f-3ac120b2d227@redhat.com>
 <gdu7kmz4nbnjqenj5vea4rjwj7v67kjw6ggoyq7ok4la2uosqa@i5gxpmoopuii>
 <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/19/24 16:55, Zi Yan wrote:
> On 19 Dec 2024, at 10:53, Shakeel Butt wrote:
> 
>> On Thu, Dec 19, 2024 at 04:47:18PM +0100, David Hildenbrand wrote:
>>> On 19.12.24 16:43, Shakeel Butt wrote:
>>>> On Thu, Dec 19, 2024 at 02:05:04PM +0100, David Hildenbrand wrote:
>>>>> On 23.11.24 00:23, Joanne Koong wrote:
>>>>>> For migrations called in MIGRATE_SYNC mode, skip migrating the folio if
>>>>>> it is under writeback and has the AS_WRITEBACK_INDETERMINATE flag set on its
>>>>>> mapping. If the AS_WRITEBACK_INDETERMINATE flag is set on the mapping, the
>>>>>> writeback may take an indeterminate amount of time to complete, and
>>>>>> waits may get stuck.
>>>>>>
>>>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>>>>> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
>>>>>> ---
>>>>>>    mm/migrate.c | 5 ++++-
>>>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>>>> index df91248755e4..fe73284e5246 100644
>>>>>> --- a/mm/migrate.c
>>>>>> +++ b/mm/migrate.c
>>>>>> @@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>>>>>    		 */
>>>>>>    		switch (mode) {
>>>>>>    		case MIGRATE_SYNC:
>>>>>> -			break;
>>>>>> +			if (!src->mapping ||
>>>>>> +			    !mapping_writeback_indeterminate(src->mapping))
>>>>>> +				break;
>>>>>> +			fallthrough;
>>>>>>    		default:
>>>>>>    			rc = -EBUSY;
>>>>>>    			goto out;
>>>>>
>>>>> Ehm, doesn't this mean that any fuse user can essentially completely block
>>>>> CMA allocations, memory compaction, memory hotunplug, memory poisoning... ?!
>>>>>
>>>>> That sounds very bad.
>>>>
>>>> The page under writeback are already unmovable while they are under
>>>> writeback. This patch is only making potentially unrelated tasks to
>>>> synchronously wait on writeback completion for such pages which in worst
>>>> case can be indefinite. This actually is solving an isolation issue on a
>>>> multi-tenant machine.
>>>>
>>> Are you sure, because I read in the cover letter:
>>>
>>> "In the current FUSE writeback design (see commit 3be5a52b30aa ("fuse:
>>> support writable mmap"))), a temp page is allocated for every dirty
>>> page to be written back, the contents of the dirty page are copied over to
>>> the temp page, and the temp page gets handed to the server to write back.
>>> This is done so that writeback may be immediately cleared on the dirty
>>> page,"
>>>
>>> Which to me means that they are immediately movable again?
>>
>> Oh sorry, my mistake, yes this will become an isolation issue with the
>> removal of the temp page in-between which this series is doing. I think
>> the tradeoff is between extra memory plus slow write performance versus
>> temporary unmovable memory.
> 
> No, the tradeoff is slow FUSE performance vs whole system slowdown due to
> memory fragmentation. AS_WRITEBACK_INDETERMINATE indicates it is not
> temporary.

Is there is a difference between FUSE TMP page being unmovable and
AS_WRITEBACK_INDETERMINATE folios/pages being unmovable?


Thanks,
Bernd
AS_WRITEBACK_INDETERMINATE

