Return-Path: <linux-fsdevel+bounces-37818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2724C9F7EF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16B8716C276
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 16:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49483226887;
	Thu, 19 Dec 2024 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="yGaY/irh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QhXiwXe+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4D6226529
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734624550; cv=none; b=qReH3lu2CMRAMUCm4J0kkEZuCdziaBjAq0JrSzw5pzetOVWtCF5E8niyUYcRUVvVzzOutoE8dtoYOBX+Gb9LLMmWLqjEL1JZ0KhxsP/OS/+TNmapnZnOiHuCTSaK/dwNP8GVj4+B2zNxHo6uWbjCrvTMAnoF5sAe187TlGdKAVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734624550; c=relaxed/simple;
	bh=ARl14DuEFHJGAO7R/evMREEwI9lLvM1yQGSS/fBbbuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ViN5x0RenM1cFAD0WZZGdnpJdbTOu446+zKuCdTgPYy3ELffC5198WhsCTjj1MwP3mh4+N1YHKrtx46KeJkBgQ3Uglvl6lxgNzBPshsCBqy7VHbx1LS01oFgp1QCHOvKCSSyjOt7KcqQnjWQBKQymyvyFqsZvmkDR0am51U4lYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=yGaY/irh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QhXiwXe+; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 2E991114013F;
	Thu, 19 Dec 2024 11:09:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 19 Dec 2024 11:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1734624547;
	 x=1734710947; bh=mek9gh2qCnrmwkTbLZwTrAHm/dw3ZHqNhHYFkkmDqS8=; b=
	yGaY/irhR2I2mVPcVI4vmxEz7Jp/9ytly7MsNm6WtZFkMn2QbAoCDXeokSdCdM74
	Yso+KyfleYbojnFwsljhUv68m6KO1DcC7ecsIn0vdWUnNwhDrHn74KY7RF9hvNNf
	HD/W81dH5Ff7fyrjEUN6XubTwEWkdIemtQMbo9zMBrXKXFfYAoBhFe37u60F6UZL
	jLV3LHZnMJDWd+cXrA0kUEEu2P7rt685llNya1pnc3NZ5Mc1KOtWxfFOMypjhCBo
	1LPHZcG2R+nIboi87ZLqLUMNnVF4Sn1aZDa4oPrr8NWxntPjj8Vr6lhwzq//OA4c
	ij5aJ+Wbk6U/WTVtnphsaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734624547; x=
	1734710947; bh=mek9gh2qCnrmwkTbLZwTrAHm/dw3ZHqNhHYFkkmDqS8=; b=Q
	hXiwXe+GEby1kpRmgcBaZTbCyPDNetoGLaC8OGQeG7Nl8if3kYxURw+9OoexlvwV
	2VNoQHv2+UldafDQyX4U6oJ2Nhezag/HhQMo+lQIV9T7Zzhh/s1zEV0MIPtGEqCS
	fje+78Hl6Ge91izsjAbJsZ9vfg2bWCN4cKEUol37Nro2rWPgxrzK+HX9N8ORvA8o
	Z4UAxRrC0TRTCp+s00+qNjVBihvMt6DCS+x7bZZ7xXJWBGJp5oSzWDPuFILXhCTZ
	6rHP++nBtcZVUKC+Qw/K+TacoeQCiAsB7VdM/P/SaNULPdkrvpvKH+ZD6293gCNE
	aRjS6ji74pJ6Fsm1/HXEQ==
X-ME-Sender: <xms:IUVkZ7O5OB9UkRajQYy_QUjFhOEKTFmun9zCWh3x_yTHZtVXwdFXGA>
    <xme:IUVkZ1__9_TTe4TOBW9Lkqr9YUKchwQ0lenyO3Ja6uoaEP7oahUPhxEw2TFG_NIkk
    IMoiTy3Uyb8JvSS>
X-ME-Received: <xmr:IUVkZ6Rt--FHFdZW86f_7B7qPQ6y-sgHYDyoaUJE2c_7iRe_YpV8bUFtg4AnV56EpmCRufq__OgFcIjkGcZEFWIaQrQeKyOwJY40TAYruE9IJEfFqfaN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddttddgkeefucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:IUVkZ_tyoqwGu8ODZJajOEe5Yt56TWU29WxqKQeKv7zMCjbZ-RK_tQ>
    <xmx:IUVkZzc7IFrFdWgWT-3IYs9dRMvjNgmf6r-GC8RzcsLBVAZaKBNdvQ>
    <xmx:IUVkZ708hx5C1uw7caiTgj3-clbPw_fp1uiRHdqrGynvS-2J-nZvCw>
    <xmx:IUVkZ_87ANcxWWb_dlT_jtfKI-RKvn8H8pRfh61afLpYjcdKyytRNA>
    <xmx:I0VkZ-9Hv8szlGb2F-YPQ3hoJoQEklSZQy6NE-yjzHr7RuqypdjnBG05>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Dec 2024 11:09:03 -0500 (EST)
Message-ID: <ec2e747d-ea84-4487-9c9f-af3db8a3355f@fastmail.fm>
Date: Thu, 19 Dec 2024 17:09:02 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Zi Yan <ziy@nvidia.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
 David Hildenbrand <david@redhat.com>, Joanne Koong <joannelkoong@gmail.com>,
 miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org,
 kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>,
 Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
References: <20241122232359.429647-1-joannelkoong@gmail.com>
 <20241122232359.429647-5-joannelkoong@gmail.com>
 <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
 <hltxbiupl245ea7b4rzpcyz3d62mzs6igcx42g7zsksanbxqb3@sho3dzzht3rx>
 <f30fba5f-b2ca-4351-8c8f-3ac120b2d227@redhat.com>
 <gdu7kmz4nbnjqenj5vea4rjwj7v67kjw6ggoyq7ok4la2uosqa@i5gxpmoopuii>
 <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
 <ec27cb90-326a-40b8-98ac-c9d5f1661809@fastmail.fm>
 <0CF889CE-09ED-4398-88AC-920118D837A1@nvidia.com>
 <722A63E5-776E-4353-B3EE-DE202E4A4309@nvidia.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <722A63E5-776E-4353-B3EE-DE202E4A4309@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/19/24 17:02, Zi Yan wrote:
> On 19 Dec 2024, at 11:00, Zi Yan wrote:
>> On 19 Dec 2024, at 10:56, Bernd Schubert wrote:
>>
>>> On 12/19/24 16:55, Zi Yan wrote:
>>>> On 19 Dec 2024, at 10:53, Shakeel Butt wrote:
>>>>
>>>>> On Thu, Dec 19, 2024 at 04:47:18PM +0100, David Hildenbrand wrote:
>>>>>> On 19.12.24 16:43, Shakeel Butt wrote:
>>>>>>> On Thu, Dec 19, 2024 at 02:05:04PM +0100, David Hildenbrand wrote:
>>>>>>>> On 23.11.24 00:23, Joanne Koong wrote:
>>>>>>>>> For migrations called in MIGRATE_SYNC mode, skip migrating the folio if
>>>>>>>>> it is under writeback and has the AS_WRITEBACK_INDETERMINATE flag set on its
>>>>>>>>> mapping. If the AS_WRITEBACK_INDETERMINATE flag is set on the mapping, the
>>>>>>>>> writeback may take an indeterminate amount of time to complete, and
>>>>>>>>> waits may get stuck.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>>>>>>>> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
>>>>>>>>> ---
>>>>>>>>>    mm/migrate.c | 5 ++++-
>>>>>>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>>>>>>> index df91248755e4..fe73284e5246 100644
>>>>>>>>> --- a/mm/migrate.c
>>>>>>>>> +++ b/mm/migrate.c
>>>>>>>>> @@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>>>>>>>>    		 */
>>>>>>>>>    		switch (mode) {
>>>>>>>>>    		case MIGRATE_SYNC:
>>>>>>>>> -			break;
>>>>>>>>> +			if (!src->mapping ||
>>>>>>>>> +			    !mapping_writeback_indeterminate(src->mapping))
>>>>>>>>> +				break;
>>>>>>>>> +			fallthrough;
>>>>>>>>>    		default:
>>>>>>>>>    			rc = -EBUSY;
>>>>>>>>>    			goto out;
>>>>>>>>
>>>>>>>> Ehm, doesn't this mean that any fuse user can essentially completely block
>>>>>>>> CMA allocations, memory compaction, memory hotunplug, memory poisoning... ?!
>>>>>>>>
>>>>>>>> That sounds very bad.
>>>>>>>
>>>>>>> The page under writeback are already unmovable while they are under
>>>>>>> writeback. This patch is only making potentially unrelated tasks to
>>>>>>> synchronously wait on writeback completion for such pages which in worst
>>>>>>> case can be indefinite. This actually is solving an isolation issue on a
>>>>>>> multi-tenant machine.
>>>>>>>
>>>>>> Are you sure, because I read in the cover letter:
>>>>>>
>>>>>> "In the current FUSE writeback design (see commit 3be5a52b30aa ("fuse:
>>>>>> support writable mmap"))), a temp page is allocated for every dirty
>>>>>> page to be written back, the contents of the dirty page are copied over to
>>>>>> the temp page, and the temp page gets handed to the server to write back.
>>>>>> This is done so that writeback may be immediately cleared on the dirty
>>>>>> page,"
>>>>>>
>>>>>> Which to me means that they are immediately movable again?
>>>>>
>>>>> Oh sorry, my mistake, yes this will become an isolation issue with the
>>>>> removal of the temp page in-between which this series is doing. I think
>>>>> the tradeoff is between extra memory plus slow write performance versus
>>>>> temporary unmovable memory.
>>>>
>>>> No, the tradeoff is slow FUSE performance vs whole system slowdown due to
>>>> memory fragmentation. AS_WRITEBACK_INDETERMINATE indicates it is not
>>>> temporary.
>>>
>>> Is there is a difference between FUSE TMP page being unmovable and
>>> AS_WRITEBACK_INDETERMINATE folios/pages being unmovable?
> 
> (Fix my response location)
> 
> Both are unmovable, but you can control where FUSE TMP page
> can come from to avoid spread across the entire memory space. For example,
> allocate a contiguous region as a TMP page pool.

Wouldn't it make sense to have that for fuse writeback pages as well?
Fuse tries to limit dirty pages anyway.


Thanks,
Bernd

