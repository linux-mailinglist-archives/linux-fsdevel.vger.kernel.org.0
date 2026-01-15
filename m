Return-Path: <linux-fsdevel+bounces-73926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A301D24C7A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 14:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5993E30AE2C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 13:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F0D396D38;
	Thu, 15 Jan 2026 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="lTIM/CYT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FJ5Fgl9T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F621AA1D2;
	Thu, 15 Jan 2026 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768484515; cv=none; b=ble2GQEqoQUEZMIY9y+OUM3SoLON2zRd+hcOyME5ep/gnuZSNcMZG2CCJ1uaIgqgAOjFhp0a6ro48R4fTfnFHXs5ZmHk5U/A2a7IAKaQDYWqAVhC7cR77wtlIKW2GcVrBHcQJt7aplmlJJISId9UwIdmWQjfyquk+WuBl8jBmWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768484515; c=relaxed/simple;
	bh=fowyBBOjH1GMVYCNutUjzlOCLnL12K8y8y1c4xZdb5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=isUebiiiPjsj0ZhsBJHq1lTZkTT/PXZz55oK1ZP+9lRfDzS9o4BK+BoyQFWbFJFWuOplnZ8IJVaad6uJbetyL67UC9dRjOguEhK4XEDbblCaumTN4yM1EDXXIg4HbMVu06duj9K8EaWvL/mkTTnRbWX9mTY31heEaMLM+9bTpU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=lTIM/CYT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FJ5Fgl9T; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 831EAEC01A5;
	Thu, 15 Jan 2026 08:41:52 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 15 Jan 2026 08:41:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768484512;
	 x=1768570912; bh=69fHJUn5iBbbJJbNLa9nkXnLQq+ENxx3iVGR8U20y/E=; b=
	lTIM/CYT3KYnnz3ehZ95rOl07tIozf3mOE7X3T1ALRwlowfJHcrrrA7a8tPuCcYy
	4cYFRCO197FBr7NYMJDnDc9EcsLeZE5PmdBi8XS0c+1G16SF7pu5zHD3zvNGhQE3
	8V6kUKhfWxvvosqAGe0S4+el7AgUA15tjot1Sj4BgG6sL5L8vGYXsT7qTaMHs38u
	6V0qzbnjVZi9LfXr8U+3yne0EpEwA0+f1Z5ITEwkg6WIWtuIHZ0Fhzm5HCz/FD0o
	5FPoFhI3C4aRo/LWA8f7jFVnP4BROy1rdYGgfuRInYXDghtOBssQ7DHmtxNBRSKY
	GtYF/U0BNRT81VtxEwkpcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768484512; x=
	1768570912; bh=69fHJUn5iBbbJJbNLa9nkXnLQq+ENxx3iVGR8U20y/E=; b=F
	J5Fgl9TjujANQvn3hyFMKXywKnmQCi154VpbpxPjw2YNyUtgxRKGdFtHxrZTDUvK
	ft7cupxqK+bGbfC13PapEe4ye8ltDEyN4NWgpdyGq1Na7df9vP59NHn2W+P+xVWH
	04Hs76qOr4hxbXprAS7D39pcC2W3EUnMhK1oVyiuSx8/oSe2yjFOlIv5ONe7leX6
	ru59Xqt/HawBV6jNdXfI9lVaa4UuDcpbfL9kwogSoqzQawsfl5UbB1SfEnKE8F+q
	+RIcoQvy9WB6rPszsC9qmQRWdjv1pyz19RRYYRv2zsp1GruqaS+jsAJhI2nPmEUs
	aUq+FuH/RgXsPrX2Ia3yQ==
X-ME-Sender: <xms:oO5oaa0TZo3Uq2qRb43-YpREO1sxAt1tWnExGZ5zeR27rzfMVU3uRQ>
    <xme:oO5oaXHsiIg1J0UtTUXIySkg8aqkLkmfx-B4MG6cwLufwIupFoaLmnAqQDGtN05TF
    i0Z-OqHSwCSLNXbH9WM7s3O_0dfGrTHkbYMFP3XTN38N0NQAy1d>
X-ME-Received: <xmr:oO5oaZjAJEXoLsBZPOMQLuU4X1tymUfjFvpPtzQQz0TAqvf-sTHhuFNUOaf9LfVgath0D2qTDm0YUKndhwJow_0xu9rezCQ_8QCxM-fMdnO2uqYB4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeivddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeefgeegfeffkeduudelfeehleelhefgffehudejvdfgteevvddtfeeiheef
    lefgvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehhohhrshhtsegsihhrthhhvghlmhgvrhdruggvpd
    hrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohephhhorhhsthessghirhhthhgvlhhmvghrrdgtohhmpdhrtghpthhtohepmhhikhhloh
    hssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgsihhrthhhvghlmhgvrhes
    uggunhdrtghomhdprhgtphhtthhopehluhhishesihhgrghlihgrrdgtohhm
X-ME-Proxy: <xmx:oO5oaaCOhrKQQQGZXQ6bxC_Up07sxBjNKGWvfPGvKIZyO7oQ9-LEJQ>
    <xmx:oO5oabTKsaXIOMxHOwAViA7J_MQIwQpja48ZET8epMgXKAlJobPrkA>
    <xmx:oO5oafXmdHEQYPFBfmgRApWXAaGe_9i7aVF7D6nX-nKsq1c8HdW2Ig>
    <xmx:oO5oaUdJQD0SIAX7bJclvWgRUJiMvzLRyr4sE-Thd1xeCqbD-u_Q1Q>
    <xmx:oO5oaaNsSEZA5V9OjGjsl8Vo-ttJLoVcR86TBqnuUDS-jJYclOO-2GtC>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 08:41:50 -0500 (EST)
Message-ID: <3223f464-9f76-4c37-b62b-f61f6b1fc1f6@bsbernd.com>
Date: Thu, 15 Jan 2026 14:41:49 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] fuse: add an implementation of open+getattr
To: Horst Birthelmer <horst@birthelmer.de>,
 Joanne Koong <joannelkoong@gmail.com>
Cc: Horst Birthelmer <horst@birthelmer.com>,
 Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>,
 Luis Henriques <luis@igalia.com>
References: <20260109-fuse-compounds-upstream-v4-0-0d3b82a4666f@ddn.com>
 <20260109-fuse-compounds-upstream-v4-3-0d3b82a4666f@ddn.com>
 <CAJnrk1ZtS4VfYo03UFO_khcaA6ugHiwtWQqaObB5P_ozFtsCHA@mail.gmail.com>
 <aWjteRMwc_KIN4pt@fedora.fritz.box>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <aWjteRMwc_KIN4pt@fedora.fritz.box>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/15/26 14:38, Horst Birthelmer wrote:
> On Wed, Jan 14, 2026 at 06:29:26PM -0800, Joanne Koong wrote:
>> On Fri, Jan 9, 2026 at 10:27 AM Horst Birthelmer <horst@birthelmer.com> wrote:
>>>
>>> +
>>> +       err = fuse_compound_send(compound);
>>> +       if (err)
>>> +               goto out;
>>> +
>>> +       err = fuse_compound_get_error(compound, 0);
>>> +       if (err)
>>> +               goto out;
>>> +
>>> +       err = fuse_compound_get_error(compound, 1);
>>> +       if (err)
>>> +               goto out;
>>
>> Hmm, if the open succeeds but the getattr fails, why not process it
>> kernel-side as a success for the open? Especially since on the server
>> side, libfuse will disassemble the compound request into separate
>> ones, so the server has no idea the open is even part of a compound.
>>
>> I haven't looked at the rest of the patch yet but this caught my
>> attention when i was looking at how fuse_compound_get_error() gets
>> used.
>>
> After looking at this again ...
> Do you think it would make sense to add an example of lookup+create, or would that just convolute things?


I think that will be needed with the LOOKUP_HANDLE from Luis, if we go
the way Miklos proposes. To keep things simple, maybe not right now?


Thanks,
Bernd

