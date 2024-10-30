Return-Path: <linux-fsdevel+bounces-33307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DE59B6FCB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 23:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B06B284B96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 22:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB871C3F06;
	Wed, 30 Oct 2024 22:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="tMlpxp0y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HkpgAaJG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4395A21765B
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 22:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730326665; cv=none; b=G2XxSJVv81fEybBOFbZRT0C5orAWDZ8bibS28qe1YX3k89mMoq4ZWZUpP6Qj7qL6nJbe4VdbcqkMGuF2550+42UwQ+nQCQxPLs3H4wgNQhjBM57BvB2v1QyGY9lbJz0FIEpOBKPJ+zTlm66py1FQQoH57Hvfnkoa1hvndMKomZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730326665; c=relaxed/simple;
	bh=ayxDNTgxmoDKWQg0/YQ+Fz8efYHxeHFZOeplpSao7cY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LTyxqPnb2qD6/zSebpLi116CD/oqqCOAY2AFHfGHoAZi2HyBGBam/CHGSIM1XcMQUs6gmhc/d7SDWlTyq7Duu+ltJ0E3epID11o1828m/qaZbapjt0588Yfe8UB5GQSS4iPoN0sfOiGJOVeBYs4aW6c9UCjlPq/++pyGapq8C2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=tMlpxp0y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HkpgAaJG; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 2AF34114018D;
	Wed, 30 Oct 2024 18:17:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 30 Oct 2024 18:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730326661;
	 x=1730413061; bh=f2eeGGIhfQ+o3+Vs5R+YZ3pcGBYA0Jz/O5mq++nI8uY=; b=
	tMlpxp0yw0rFA8YwKsWbtd3T3yNnxh8oKrdzj6aPP3FccZMfEGTOVVXchvzRBT7h
	pGnEIRwEwANQkiZnwecHmSSDpgEflvYk1anoZRzpeOO4x88zUuHua2qFf3CDayFw
	6yPFOY5xkit0AkYf2JEeLkZ2vlskgUvq6CAPOiKtpPCvoHGGp+udlQzrL3xIIKxV
	LgIGO+XyLN6ZTVMh1ZE8vTPPpzblrNkzP5Z1lpT+CrOV65Pht0gv4PYnoPYfkP9g
	XbQdX+1ACvkgMKvstOfvzYqFxIa7+QkTorkJYhO1OrIiyNZgmPgyohvqfqjhKR6i
	GbQ46ktw+iTAaWMTmJ6BgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730326661; x=
	1730413061; bh=f2eeGGIhfQ+o3+Vs5R+YZ3pcGBYA0Jz/O5mq++nI8uY=; b=H
	kpgAaJGdGfbnDN0mItiSQOjvgwyohp7TQvuxsxvsMKBSv+XFzu9WWuK+PzYV96e5
	W8reEBvmnQP54iLWJcshiJKnwZQ65PQCRGgX9JpWxLqiWyCWCcH7m0QW3DH/SZ7e
	egVPzxlK3neW/qICIUjxxXem9vTTCYhwbscTQjuVLLWlatlI2+Zw/Cq4BLM1TSNM
	KRwQ0ZyjQvU/2iHChAgylfOcddxmmzQ2dIOrfu3OeZpOxL6od+CXO5M37ijP6zpn
	ZWRuycrxJ5Qg8h8tjpIGwwTHlWrc7FlNyhSDUEGExHGQFLxbu4DzEX/ScQrZ30MJ
	EkhYAUFrBc55fIc/U453g==
X-ME-Sender: <xms:g7AiZw9jvJ_eOx3nMdsYaP7UeytVscflSRmxlANxecEhY9e-tKvzxg>
    <xme:g7AiZ4vD_9_3M5385hfltBpxzoAXAYes-5tQ6LqvGt-MBJe9V33fXf5a-TzjM1npj
    1zppgyeUYKb_2OT>
X-ME-Received: <xmr:g7AiZ2B8Ge_igI3hT2TbC-G1QapwJWvnuiZcPOBAkky6Yvu7FkMMbI3X6i8w9eD03T4aFezlrzxvB60zmtxe6RTeGVQmB88XrSoYL6wHbo_mfkBYOQd8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekfedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeduleefvdduvedu
    veelgeelffffkedukeegveelgfekleeuvdehkeehheehkefhfeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepshhhrghkvggvlhdrsghuthhtsehlihhnuhigrdguvghvpdhr
    tghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epjhgvfhhflhgvgihusehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtohep
    mhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuhigqdhfshguvg
    hvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhoshgvfhesthho
    gihitghprghnuggrrdgtohhmpdhrtghpthhtohephhgrnhhnvghssegtmhhpgigthhhgrd
    horhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthht
    ohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtohhm
X-ME-Proxy: <xmx:g7AiZweh--BEpjMnVBpHeqMDqY7pQDe2sTCktv8_iKzHDbKw112HdA>
    <xmx:g7AiZ1Oeh54kSEZnX59afh0pHwKLcSBPkeSQIdPRgqYk6_JGfol_BA>
    <xmx:g7AiZ6mXZ8diII9ijFF0LzUBu81bqlGXMMTDC1isH1Op19T02fhMrA>
    <xmx:g7AiZ3v6xslCmGew8iLWP4VxPhTjmTfz3gzpGgMf5-VnW3l39OzkGA>
    <xmx:hbAiZ4oRZ8s9lWcZzMY7aaQaRnf8nJTo3vN8ii0JOku09MKy7nYGRVjF>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Oct 2024 18:17:37 -0400 (EDT)
Message-ID: <ba12ca3b-7d98-489d-b5b9-d8c5c4504987@fastmail.fm>
Date: Wed, 30 Oct 2024 23:17:36 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Joanne Koong <joannelkoong@gmail.com>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, Miklos Szeredi
 <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
 hannes@cmpxchg.org, linux-mm@kvack.org, kernel-team@meta.com
References: <3e4ff496-f2ed-42ef-9f1a-405f32aa1c8c@linux.alibaba.com>
 <CAJnrk1aDRQPZCWaR9C1-aMg=2b3uHk-Nv6kVqXx6__dp5Kqxxw@mail.gmail.com>
 <CAJnrk1ZNqLXAM=QZO+rCqarY1ZP=9_naU7WNyrmPAY=Q2Htu_Q@mail.gmail.com>
 <CAJnrk1bzuJjsfevYasbpHZXvpS=62Ofo21aQSg8wWFns82H-UA@mail.gmail.com>
 <0c3e6a4c-b04e-4af7-ae85-a69180d25744@fastmail.fm>
 <CAJnrk1b=ntstDcnjgLsmX+wTyHaiC9SZ7cdSRF2Zbb+0SAG1Zw@mail.gmail.com>
 <023c4bab-0eb6-45c5-9a42-d8fda0abec02@fastmail.fm>
 <CAJnrk1aqMY0j179JwRMZ3ZWL0Hr6Lrjn3oNHgQEiyUwRjLdVRw@mail.gmail.com>
 <c1cac2b5-e89f-452a-ba4f-95ed8d1ab16f@fastmail.fm>
 <CAJnrk1ZLEUZ9V48UfmXyF_=cFY38VdN=VO9LgBkXQSeR-2fMHw@mail.gmail.com>
 <rdqst2o734ch5ttfjwm6d6albtoly5wgvmdyyqepieyjo3qq7n@vraptoacoa3r>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <rdqst2o734ch5ttfjwm6d6albtoly5wgvmdyyqepieyjo3qq7n@vraptoacoa3r>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/30/24 22:56, Shakeel Butt wrote:
> On Wed, Oct 30, 2024 at 10:35:47AM GMT, Joanne Koong wrote:
>> On Wed, Oct 30, 2024 at 10:27 AM Bernd Schubert
>> <bernd.schubert@fastmail.fm> wrote:
>>>
>>>
>>> Hmm, if tmp pages can be compacted, isn't that a problem for splice?
>>> I.e. I don't understand what the difference between tmp page and
>>> write-back page for migration.
>>>
>>
>> That's a great question! I have no idea how compaction works for pages
>> being used in splice. Shakeel, do you know the answer to this?
>>
> 
> Sorry for the late response. I still have to go through other unanswered
> questions but let me answer this one quickly. From the way the tmp pages
> are allocated, it does not seem like they are movable and thus are not
> target for migration/compaction.
> 
> The page with the writeback bit set is actually just a user memory page
> cache which is moveable but due to, at the moment, under writeback it
> temporarily becomes unmovable to not cause corruption.

Thanks a lot for your quick reply Shakeel! (Actually very fast!).

With that, it confirms what I wrote earlier - removing tmp and ignoring
fuse writeback pages in migration should not make any difference 
regarding overall system performance. Unless I miss something,
more on the contrary as additional memory pressure expensive page
copying is being removed.


Thanks,
Bernd

