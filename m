Return-Path: <linux-fsdevel+bounces-71367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2F3CBF6B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 19:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 990783036C8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 18:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FEA3254A9;
	Mon, 15 Dec 2025 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="k7mjH9eA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yArae+qL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA832BDC0B;
	Mon, 15 Dec 2025 18:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765822991; cv=none; b=fyJs3aOlWUwTdiHptrT87qIxelHaJK78jbmlYyQcQ/SANqbB5yHlDm6Gc85z0+TKyEuXt3vFKsc0Lk+Pji0lqmCRBKGZr+Zp39KXzrxB/gDU11I/75D3Lv7PCkCmbYvRxeNUrmbqeNb6YVNTQ3m95ymCHNKCeFzGGZvryDP+q/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765822991; c=relaxed/simple;
	bh=cBxSH3zyOGjlK881/zhZosiEl2TZEZ0LPtW6Mq5u/V0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mBRKcL0XGi9aRZCC18Ndc7LXkitxOmp/hvZ3vmTvYdgv2o0mysi3w/68XXBTTMvDp/Q6NQQWlC0U6AWf4VGQDkiR7Y06f9Brf4Vsamiz+gS2jW5RIxiY2en3cP3P5nEcZCgRyqp2aF1YwKFXEfsKdaTaX6BmK6fdi/D0+7pf94I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=k7mjH9eA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yArae+qL; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6BBEF7A0088;
	Mon, 15 Dec 2025 13:23:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 15 Dec 2025 13:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765822988;
	 x=1765909388; bh=jiHzKg5r95t/GyOYVdJM7oSr4TdCaGqDAfF2rW2qQZU=; b=
	k7mjH9eAGNzhfHE84lWdF372ZFJ25KLc8YYspFknKvJ306kSySVPACQZaaqtwvcy
	qaJO7cgNfFvYJi01E7coQlGOQyUNpeJ6F3hV25Ys8BOjGSprdrGavBhSbJl4GliN
	0eDrbaLKJAVyggusEgSpvIzc69vanuusjD7fS4Doh3FaY5vGsDOc2nlhxNefAR4C
	7GEd2hGV9BIhXqAl1D5Um6N3YnbyqaczbkVbImtQkzxDivKb4qSpKuGjxNohczpU
	Kzd+hhJX3ycuCHws2IlsCoSq342jotsnqcGtoLDUOBuouPtYs2ze891IaPEY1SrQ
	y9TbCjt8tr47PsnLAM2heg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765822988; x=
	1765909388; bh=jiHzKg5r95t/GyOYVdJM7oSr4TdCaGqDAfF2rW2qQZU=; b=y
	Arae+qLtnmZVnDsKT0/HD/kZxFVSCSfjWMfHvGF0YyqBls0GCqLbUDEMFGkclKZO
	3zL6UY/cG+2hRdo/rApDrSxxM+I0o//vhaPNQ4r+o3SdtnsZZdyE/N9zxaKZlBjy
	Vt4njwm4+1bVfBWjbqT1wC+qkXofBwv/7N9B8dH3Ktw/Z2Rvt1nJLo+QkgDOr44j
	gfBX2TFlRkIJL5gPhPPsmRVWwvNZXmKYu/svDmLqmAMU6J6jOaqKAZ1/urkuyZAa
	8G31UkeS4JoogH755iJmlfPo4U5FRDXrRS+C0HUhR7WFoztSJqspzD9e6lozKECu
	eWk81gKK4hjSiVmLJN6gQ==
X-ME-Sender: <xms:C1JAaelvma4yhPV9bVH-k5zkz4st0I5CqOgj0A4UhBxkJODre76GDw>
    <xme:C1JAaUGCJM3G5VyMlIyUcz5CfFG85fPy8c0fxJPys3GBwl33brtI_WQXweh8A9hB6
    cvTEE8Q-HsnqW7I1gQNETL7pr7wZBn0IwFgHbyWQmH14npAMlxP>
X-ME-Received: <xmr:C1JAaV8fzI7egxVsI7FEv7T902tkMrCgIVPqZkmqltWlIu7Uv9uCrKfX0wFigrGKIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefjeehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepfeeggeefffekudduleefheelleehgfffhedujedvgfetvedvtdefieehfeel
    gfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomhdprh
    gtphhtthhopegsshgthhhusggvrhhtseguughnrdgtohhmpdhrtghpthhtoheplhhuihhs
    sehighgrlhhirgdrtghomhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhh
    hupdhrtghpthhtohepughjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehk
    tghhvghnseguughnrdgtohhmpdhrtghpthhtohephhgsihhrthhhvghlmhgvrhesuggunh
    drtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:C1JAaVmIkXWl2n_mZ3S0FGwrBGap0YNcm-YBup9-Gwaw8SzqswN_eQ>
    <xmx:C1JAaQAfTn-JYZSZn_mPYPomkRx59sD3zXMD2zrGSZHqxBJjgX64Cg>
    <xmx:C1JAaeWdTrUZ-0WPDdtWKcdEa24myVwxkQzLcJwOyFxGBQscZJczAQ>
    <xmx:C1JAae8xwsGaf5iAPAEXOvPX3uzr0z_QapKhXV0l-e_Y9d7erzQCqw>
    <xmx:DFJAaXy8Gxv2jOPHxkQFEepZvyrMoR0tKjSBYSVqA0nUhuLawYUhLGKM>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Dec 2025 13:23:06 -0500 (EST)
Message-ID: <4ca7053e-68fc-483b-a967-092cd845e9d2@bsbernd.com>
Date: Mon, 15 Dec 2025 19:23:05 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/6] fuse: initial infrastructure for
 FUSE_LOOKUP_HANDLE support
To: Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bschubert@ddn.com>
Cc: Luis Henriques <luis@igalia.com>, Miklos Szeredi <miklos@szeredi.hu>,
 "Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>,
 Horst Birthelmer <hbirthelmer@ddn.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Matt Harvey <mharvey@jumptrading.com>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>
References: <20251212181254.59365-1-luis@igalia.com>
 <20251212181254.59365-4-luis@igalia.com>
 <87f48f32-ddc4-4c57-98c1-75bc5e684390@ddn.com>
 <CAOQ4uxj_-_zbuCLdWuHQj4fx2sBOn04+-6F2WiC9SRdmcacsDA@mail.gmail.com>
 <8bae31f2-37fc-4a87-98c8-4aa966c812af@ddn.com>
 <CAOQ4uxh-+S_KMSjH6CYRGa--aLfQOeqCTt=22DGSRQUJTJ2bPw@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US
In-Reply-To: <CAOQ4uxh-+S_KMSjH6CYRGa--aLfQOeqCTt=22DGSRQUJTJ2bPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/15/25 19:09, Amir Goldstein wrote:
> On Mon, Dec 15, 2025 at 6:11 PM Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> On 12/15/25 18:06, Amir Goldstein wrote:
>>> On Mon, Dec 15, 2025 at 2:36 PM Bernd Schubert <bschubert@ddn.com> wrote:
>>>>
>>>> Hi Luis,
>>>>
>>>> I'm really sorry for late review.
>>>>
>>>> On 12/12/25 19:12, Luis Henriques wrote:
>>>>> This patch adds the initial infrastructure to implement the LOOKUP_HANDLE
>>>>> operation.  It simply defines the new operation and the extra fuse_init_out
>>>>> field to set the maximum handle size.
>>>>>
>>>>> Signed-off-by: Luis Henriques <luis@igalia.com>
>>>>> ---
>>>>>    fs/fuse/fuse_i.h          | 4 ++++
>>>>>    fs/fuse/inode.c           | 9 ++++++++-
>>>>>    include/uapi/linux/fuse.h | 8 +++++++-
>>>>>    3 files changed, 19 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>>>>> index 1792ee6f5da6..fad05fae7e54 100644
>>>>> --- a/fs/fuse/fuse_i.h
>>>>> +++ b/fs/fuse/fuse_i.h
>>>>> @@ -909,6 +909,10 @@ struct fuse_conn {
>>>>>        /* Is synchronous FUSE_INIT allowed? */
>>>>>        unsigned int sync_init:1;
>>>>>
>>>>> +     /** Is LOOKUP_HANDLE implemented by fs? */
>>>>> +     unsigned int lookup_handle:1;
>>>>> +     unsigned int max_handle_sz;
>>>>> +
> 
> The bitwise section better be clearly separated from the non bitwise section,
> but as I wrote, the bitwise one is not needed anyway.
> 
>>>>>        /* Use io_uring for communication */
>>>>>        unsigned int io_uring;
>>>>>
>>>>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>>>>> index ef63300c634f..bc84e7ed1e3d 100644
>>>>> --- a/fs/fuse/inode.c
>>>>> +++ b/fs/fuse/inode.c
>>>>> @@ -1465,6 +1465,13 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>>>>>
>>>>>                        if (flags & FUSE_REQUEST_TIMEOUT)
>>>>>                                timeout = arg->request_timeout;
>>>>> +
>>>>> +                     if ((flags & FUSE_HAS_LOOKUP_HANDLE) &&
>>>>> +                         (arg->max_handle_sz > 0) &&
>>>>> +                         (arg->max_handle_sz <= FUSE_MAX_HANDLE_SZ)) {
>>>>> +                             fc->lookup_handle = 1;
>>>>> +                             fc->max_handle_sz = arg->max_handle_sz;
>>>>
>>>> I don't have a strong opinion on it, maybe
>>>>
>>>> if (flags & FUSE_HAS_LOOKUP_HANDLE) {
>>>>          if (!arg->max_handle_sz || arg->max_handle_sz > FUSE_MAX_HANDLE_SZ) {
>>>>                  pr_info_ratelimited("Invalid fuse handle size %d\n, arg->max_handle_sz)
>>>>          } else {
>>>>                  fc->lookup_handle = 1;
>>>>                  fc->max_handle_sz = arg->max_handle_sz;
>>>
>>> Why do we need both?
>>> This seems redundant.
>>> fc->max_handle_sz != 0 is equivalent to fc->lookup_handle
>>> isnt it?
>>
>> I'm personally always worried that some fuse server implementations just
>> don't zero the entire buffer. I.e. areas they don't know about.
>> If all servers are guaranteed to do that the flag would not be needed.
>>
> 
> I did not mean that we should not use the flag FUSE_HAS_LOOKUP_HANDLE
> we should definitely use it, but why do we need both
> bool fc->lookup_handle and unsigned fc->max_handle_sz in fuse_conn?
> The first one seems redundant.

Ah sorry, you are absolutely right.

