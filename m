Return-Path: <linux-fsdevel+bounces-39493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A64A15249
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 15:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 770BA7A262A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 14:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A762918734F;
	Fri, 17 Jan 2025 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="WJoODkPo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kh9AVZEg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C5214B06C
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737125921; cv=none; b=TotCmbr0zNI1iPaofN5LrfXqf4K4mm/22YORmJJxX2fMTC4yBWYiUAyUd6nj7Z8ZIEmLPbawsoGozT2JfN0ysRGNB7GROmNWoBDnTtMyora1MIS7AL+5yVJZZZjOY9XsWT2vTsFHmPPlCoxkLqYN4q6lVKYoQoEEKT3tT7Yr5kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737125921; c=relaxed/simple;
	bh=zVCP80E59upSzTM7Vo1WIU08zWhpqqaTCDU36Cp08ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQELJ+4EX7fHMqsL+ZOF2+GGO1j8bedeUpm+6ElPwAHbkAOlSTABxzEqhltlL/a0GJtwR0z+H1448qziJh7f2Y2455CSPl03KojzxfDexLGkRfVuOyLQW83X+LG5O6q12x0mIOYyMwkyvrzNXhAD88xhs+E1SOdRNHwl86UK4do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=WJoODkPo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kh9AVZEg; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5409425401E2;
	Fri, 17 Jan 2025 09:58:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 17 Jan 2025 09:58:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737125918;
	 x=1737212318; bh=Dc+eWR6RlYjJjwkVLtTs6WjxOn2g/r3Eydc/5aPMqWw=; b=
	WJoODkPobw4b9v//6KQL73LlZeAIF1DUJe1QA8ado2DpEKUjyuuzthkBuHt0YG+V
	ugVwNPoFnu+FryXV8i7Xo5xHfh35U9KqL6CiABREAUNa/mr2Usr5FC9c0hQz/EKJ
	ynjY7YCkTuPfPqWtIF1WIjZBPLPuvFdc768OqB+rzdC3l/dFhzBo9z1K2iGChWno
	fMw6Ji6zP98yn8VIeqr9UFc0feP9IR5ZTYhorvdG0JKxZxVveDQ8wquRVa/3BofE
	ZP0VR9KMW4qYnNPXS+oQygk+zM4N1YmOvIL06dk60PQQffvCi+KDNC8c95Na1HBw
	JKlDmx2fsGtxygZyXnWZzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737125918; x=
	1737212318; bh=Dc+eWR6RlYjJjwkVLtTs6WjxOn2g/r3Eydc/5aPMqWw=; b=K
	h9AVZEgq7giz1UwLqTRj749O7j8d3uz6Ddi1lInRNrsIchq3+RRfrL6hwH+2pdTZ
	qNmiV/5/VQOkofVrVBS0jCZ0AqbNB8KDWgY4lSUuFQ8HLFrOAwwcm+1lHhfaXzBA
	xboxchroQYgBSJ5ZDC84mJkucc0JwivjiL7T2FYnzTjyldwOXpOXu1EqGC31bG9Y
	HKr3fmR3YSoaH01CN+IhbtfYqBX73ScFgOq8d2MwQxBQBO58WZzL+LoLaok6P4Po
	g8RXxP9gZc+Fjh9Ro6j75Ks5TFAweGYgL0R4rR7Bwk48p0lkguB8vs82tA71PlW3
	9jo+Dj9/qngNb9G/3KVeA==
X-ME-Sender: <xms:HXCKZ8kiUCObIgWDz0sfE0vVYfHT8Gvn7uG70hOZUlUnyLUujXVc5w>
    <xme:HXCKZ72Boa_TnTHpKj4SeG8r4Sgalv3QJpuTdwNqTa1woES-55k_o0miAh5cL4Q2U
    zjnNErL2BdfWtxYxZc>
X-ME-Received: <xmr:HXCKZ6pj8FkHtwGc2949eb16O5L6jDMWaH5gz-Gi9MaDHB065RZeMGaADvX2EDQmINq8NfUW2BZbD1yvOjs0qRXfbDUc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpefgrhhitgcuufgrnhguvggvnhcuoehsrghnuggvvghnsehsrghnuggvvg
    hnrdhnvghtqeenucggtffrrghtthgvrhhnpeevieekueetfeeujedtheeffedvgeffiedv
    jeejleffhfeggeejuedtjeeulefhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtpdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehvihhrohesii
    gvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepshgrnhguvggvnhesrhgv
    ughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:HXCKZ4mXgNYAWHDuWpgBjP89_S8aSqjJ6_xJb5hppZe6R8tq-sbHUQ>
    <xmx:HXCKZ61fdZkx4NDRWbwKhKO2xq6XIOiwJhzgKDIwj4n8OmJ-09wa3w>
    <xmx:HXCKZ_vGUYXh3fMYBlAOJ0kOtxREr5pi7yiAb_iqWv_YbVwreLj8YQ>
    <xmx:HXCKZ2XMmMh7drEmhFuPkitrlx7WT32SUZ9b70Dvc34OUV4pJVo30A>
    <xmx:HnCKZ9SiL11YBM7UPllwMO_rJiNjLRyZJLiuUPeE7BGSxohB6_eMbZSg>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 09:58:37 -0500 (EST)
Message-ID: <c624f5f2-33bf-42da-9aaa-ef1a346fb9ea@sandeen.net>
Date: Fri, 17 Jan 2025 08:58:36 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ufs: convert ufs to the new mount API
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org,
 brauner@kernel.org
References: <20250116184932.1084286-1-sandeen@redhat.com>
 <20250116190844.GM1977892@ZenIV>
 <9f1435d3-5a40-405e-8e14-8cbdb49294f5@sandeen.net>
 <20250117081136.GP1977892@ZenIV>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20250117081136.GP1977892@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/17/25 2:11 AM, Al Viro wrote:
> On Thu, Jan 16, 2025 at 04:07:44PM -0600, Eric Sandeen wrote:
>> On 1/16/25 1:08 PM, Al Viro wrote:
>>> On Thu, Jan 16, 2025 at 12:49:32PM -0600, Eric Sandeen wrote:
>>>
>>>> +	switch (opt) {
>>>> +	case Opt_type:
>>>> +		if (reconfigure &&
>>>> +		    (ctx->mount_options & UFS_MOUNT_UFSTYPE) != result.uint_32) {
>>>> +			pr_err("ufstype can't be changed during remount\n");
>>>> +			return -EINVAL;
>>>>  		}
>>>> +		ufs_clear_opt(ctx->mount_options, UFS_MOUNT_UFSTYPE);
>>>> +		ufs_set_opt(ctx->mount_options, result.uint_32);
>>>> +		break;
>>>
>>> Do we really want to support ufstype=foo,ufstype=bar?
>>
>> well, we already do that today. Old code was:
>>
>>                 switch (token) {
>>                 case Opt_type_old:
>>                         ufs_clear_opt (*mount_options, UFSTYPE);
>>                         ufs_set_opt (*mount_options, UFSTYPE_OLD);
>>                         break; 
>>                 case Opt_type_sunx86:
>>                         ufs_clear_opt (*mount_options, UFSTYPE);
>>                         ufs_set_opt (*mount_options, UFSTYPE_SUNx86);
>>                         break;
>> ...
>>
>> so I was going for a straight conversion for now so that the behavior
>> was exactly the same (i.e. keep the last-specified type. I know, it's
>> weird, who would do that? Still. Don't break userspace? And we've been
>> burned before.)
> 
> FWIW, see viro/vfs.git #work.ufs - separating ufs flavour and on-error
> flags, dealing with -o ufstype conflicts, then your patch ported on
> top of that.


LGTM; you may want to edit my commit log, because this:

"ufs_set/clear/test_opt macros are changed to take the full option,
to facilitate setting in parse_param.

ufstype option changes during remount are rejected during parsing,
rather than after the fact as they were before."

no longer makes any sense; you did that already in your new patches
so these changes no longer exist in my patch.

Acked-by: Eric Sandeen <sandeen@redhat.com>

Thanks,
-Eric

