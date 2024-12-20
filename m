Return-Path: <linux-fsdevel+bounces-37944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA669F9564
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 16:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5722C161CAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A0C218AD2;
	Fri, 20 Dec 2024 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="r62Yhda4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YwM2mpPk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101E5215713
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734708376; cv=none; b=hoyiqZT0/ZLfe1cbGJAxhPIMrSO2ioBxZ6HP8VxofeUpCNQL2YC9ctkm1TmOgSl4PAnf9mSUSP4Fu608ot+HU8Ec1BjVEkz6H4ms9nhNt8UlZc8nQCtpTd8b/qKhKzQqfGYQGUCuWpgW10bxZJ7bq5ubdDOzdYPLs+N1KN6bW3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734708376; c=relaxed/simple;
	bh=jDjimHrwqQOr6NeFnD9MV8h9ov5QSwJRtva1Kqj+Ffs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kc7Ku96Tzp/yWdtxxFgNYZ/Aibk8tDDXc5cPvMZK05Uv8ElF484Hqp/GGiRvrOrESuSIRekqpd/gG20rhAnNfvQA0e31jbdER1tHXBBv53GuYm65nKWtvJJT+1gJqnNl4cbXpzm3Ulxsb+u3wNqbKajAYfES8Oe0zg0HJsQCq6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=r62Yhda4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YwM2mpPk; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id DCBE01140186;
	Fri, 20 Dec 2024 10:26:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 20 Dec 2024 10:26:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1734708372;
	 x=1734794772; bh=d/vcyTwwlUfNeJNyTKz54mWlFTaDgsMzYvfaGPggMx8=; b=
	r62Yhda4yKUK2U8Zfk1gX0QIWA2nO6eRfsIv42wyoDctmdoCv6AJ2bWb4oozDguk
	89izcpvUBkzb+0ieKXG1auiLQeVrteYLEzv04JZSSQu3PVaq++wjZdmZfzuP5iIF
	ZhBIsuVlh6bVduO9cXo7kuLVYW6eOqLsGXTkt+boGAt4jOJ5dFiLcy79kCmn7EHr
	eZAxXdJAJbVu4/TAuPeEiXmw3+6FKm/wwqQNAAmUPX/vYYvNVFzZzUPm8tz9YfE5
	p4XiLAv8eoDAPqcj1rF6evZXMbcG15WGKqo5dfT8gyQ5eaPw0TeqXvMAyVNAsjS5
	SWZcy3YKIndbIKLx3UjBHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734708372; x=
	1734794772; bh=d/vcyTwwlUfNeJNyTKz54mWlFTaDgsMzYvfaGPggMx8=; b=Y
	wM2mpPkXgjg4dTG4t2PKQi8aW4LL6ru9zsDMb7bXmXxll/ZJozWh3xMUmOmqVXor
	d+B46gJNrJLv+wApkx5LSp9GYOveDKYOtAbU7GAwAinTwICCsCcrIBHWMiFEgx02
	GHvojwyvqOJAHLWWRRyR6GoEB+yGzpn76wVUj5dAoSq1X0g5ieKgpcMF9Xcog0yN
	Cqkktm2+z6N3tNNe8F+ZNcT+8om7oADMWDeQUhWqdgcWICtWOPGhE5G9uGVfsDMv
	b8yuxzRs53jsBSBEAlc23k8MLyQhU3kBeK6OuM8xPAUFmlHivZeZcrgA8FpcAtkb
	r11dFiLuPlRDTkQxTua5Q==
X-ME-Sender: <xms:k4xlZ1EyONEglkv8l2q5q4MmoLra63dkIZ5Q4eiKrfnDMIg8GJkMrg>
    <xme:k4xlZ6VOxHpQvO2X-8CW6xycW_V2PocQ6BqzUa05MY0WnTgLUe7EU3PyFd4QnIe4P
    _cu_8m3yBwyY_Np>
X-ME-Received: <xmr:k4xlZ3ISujGV9hF5y_KdoAG-sBUYxJOz4yyb5BNLqU-k_MTKw6heSZAUeks_5Wy7Z7CqlA8xsKhJ-MZUF23Lko2qCwUS0iwSPjv-g9BJmxipLGMoomd1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfg
    tdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhht
    sehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
    shhhrghkvggvlhdrsghuthhtsehlihhnuhigrdguvghvpdhrtghpthhtohepjhhorghnnh
    gvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepiihihiesnhhvihguihgr
    rdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtth
    hopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepjhgvfhhflhgvgihusehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpth
    htohepjhhoshgvfhesthhogihitghprghnuggrrdgtohhmpdhrtghpthhtoheplhhinhhu
    gidqmhhmsehkvhgrtghkrdhorhhg
X-ME-Proxy: <xmx:k4xlZ7Gyx3oK5gKAHDOjr__yrj0eNJw96K7jMdMqIXCGchiAJ_w8gA>
    <xmx:k4xlZ7XfASfjI7HMuIeq8SUC1qwYpKsL1wuQ9rYX6HA3PJdvHD6hrg>
    <xmx:k4xlZ2N6i_zFzgK8-0IaZGQPRx1UPdXgsd_dOdfY4KsLscZKKlytWQ>
    <xmx:k4xlZ62fOfewR20oqGAICZfL5yFSapK8COpfRPvNy1t09gS3gJOHlg>
    <xmx:lIxlZ4V-GE8RWQsSnbuBc36V_HGpYcSpvofnmSV7cJxx-aViAN9_btTp>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 10:26:09 -0500 (EST)
Message-ID: <128e28fd-4b08-4c6a-802d-f3a080f21452@fastmail.fm>
Date: Fri, 20 Dec 2024 16:26:08 +0100
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
 <b16bff80-758c-451b-a96c-b047f446f992@fastmail.fm>
 <9404aaa2-4fc2-4b8b-8f95-5604c54c162a@redhat.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <9404aaa2-4fc2-4b8b-8f95-5604c54c162a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/20/24 15:49, David Hildenbrand wrote:
>>> I'm wondering if there would be a way to just "cancel" the writeback and
>>> mark the folio dirty again. That way it could be migrated, but not
>>> reclaimed. At least we could avoid the whole AS_WRITEBACK_INDETERMINATE
>>> thing.
>>>
>>
>> That is what I basically meant with short timeouts. Obviously it is not
>> that simple to cancel the request and to retry - it would add in quite
>> some complexity, if all the issues that arise can be solved at all.
> 
> At least it would keep that out of core-mm.
> 
> AS_WRITEBACK_INDETERMINATE really has weird smell to it ... we should
> try to improve such scenarios, not acknowledge and integrate them, then
> work around using timeouts that must be manually configured, and ca
> likely no be default enabled because it could hurt reasonable use cases :(
> 
> Right now we clear the writeback flag immediately, indicating that data
> was written back, when in fact it was not written back at all. I suspect
> fsync() currently handles that manually already, to wait for any of the
> allocated pages to actually get written back by user space, so we have
> control over when something was *actually* written back.

Yeah, fuse_writepage_end() decreases fi->writectr, which gets checked
by fsync.

Knowing when somethings has been written back is not the issue, but
keeping order, handling splice, possible double write to the same range
(it should be mostly idempotent, but is that guaranteed by all servers),
etc.


> 
> 
> Similar to your proposal, I wonder if there could be a way to request
> fuse to "abort" a writeback request (instead of using fixed timeouts per
> request). Meaning, when we stumble over a folio that is under writeback
> on some paths, we would tell fuse to "end writeback now", or "end
> writeback now if it takes longer than X". Essentially hidden inside
> folio_wait_writeback().

Yeah, that would be a minor improvement to the overall issue ;) Re-queue
issue.

> 
> When aborting a request, as I said, we would essentially "end writeback"
> and mark the folio as dirty again. The interesting thing is likely how
> to handle user space that wants to process this request right now (stuck
> in fuse_send_writepage() I assume?), correct?

That sends background requests - does not get stuck. Completion happens
in fuse_writepage_end(), when the request reply is received.



Thanks,
Bernd

