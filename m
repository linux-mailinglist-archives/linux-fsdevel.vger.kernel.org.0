Return-Path: <linux-fsdevel+bounces-13742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C141873577
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 12:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D8D284881
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 11:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CC7768FB;
	Wed,  6 Mar 2024 11:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="vOcqFhqR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cvPGn+Yb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980AA2907;
	Wed,  6 Mar 2024 11:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709723768; cv=none; b=jjNiJ1vVPIMBqB6w2J8Glp1B+M/IMmDDgUTdSCNIWRWa7F2evPjq07cOSqsYFnt6WoLmVHMrjfAer4ambqRoNH+V4piumR83RwZi2u8nI9XJT/yA4QQ5boM15lpZyeu9pWxVwS5Y+ylLKrNdUEsOUcTg92c6wuwlDUn2+HpGyJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709723768; c=relaxed/simple;
	bh=Lz0bsq08ymHzHXiwDFFXePeWEE/vJs9dusHDjJSFuew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cmdA+IzGdQF4koBZt2LQXPWdtWFRJYPHRdoTjLs/vbFBevQCDP0Nn9cNN+TFybA56foeFSCERPua3RBVkw4jq9W7yHgzhJhAKksknFqE5895V1H39K+09ZWwuQy3iIs6Dhx9QRhJT959efjRCnlICi0uksFiQmYeOGTbuFNWp7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=vOcqFhqR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cvPGn+Yb; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 57B6B320010B;
	Wed,  6 Mar 2024 06:16:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 06 Mar 2024 06:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1709723763;
	 x=1709810163; bh=euRAQTDYQadFcgoxjxByg2C0UZ4sLTe5P2pud1Ie/DY=; b=
	vOcqFhqRoZi6VCBg71kCWd5yXw49z77iXT4BD8RidA4Fy99KfFapYS9kwXH2aWIs
	i1TlQymqnHcBe+qYSOHtR9fxkRLCqjgJbRnByev/ptB2Hb9tS69I8onIoRRE5eOL
	R8T+MVH5I4RebPvP5uxVk/NTakk0ClRfQg6DfKxce9w1JuFm67VVV6mbx70NFpSl
	HAJrnsYEyBQYT3/NB0uHkT0SUO2lfUm/vLhwqjV5gP27VXNN5V/vN/yi0/uDHLvu
	Unue6QZCyi6bjAbW/gRh8iQRpsd0E61ZTSATSJfiIYQNW20o9njTfKBfUr4N/BOE
	jY6xTVxatUu3Jc5ur0GoxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709723763; x=
	1709810163; bh=euRAQTDYQadFcgoxjxByg2C0UZ4sLTe5P2pud1Ie/DY=; b=c
	vPGn+Yb9/85TeZ1uskigiMUgXxGHTygcN2p0b0pHIPdXvwkATbdQjyvRyFcibRyp
	wlM6sY1krTlA5Px6kS8MrPy7VavYr/nJG04Z5EbDhjI3Onjjt6ssYd2nPbgFkj66
	IoMlgKpTtySS8T+EeICVktwk5eVam49pnG9mIyU9nYe3VuiYCSy2RqPCJNRkkY5X
	Kh8aLMpnlUWLslW9xKcGVbhJCVYsOmSJghV2jXXWJtvD2tpyAuyI0h2FWsGHbSnZ
	25hatWDp+ABgyg1D5UWRKPd0M2Rp6WyxouJ1LSqz8SZESDATLQoR5xrjPcTJQTsd
	AcM+GOdk6hrdYNUnp9ydw==
X-ME-Sender: <xms:c1DoZZM_5zIWN_smJQWJnoNsnhb1vh6OY-BlmDu5Cikzxmu2icNPZA>
    <xme:c1DoZb8_Ds11WMtZQXpqML8f_xBGfTU6QdzXpfq_K214vz4bWRnRbFmKoq_3Lg0Uk
    LPNKg9OCZlOn6JH>
X-ME-Received: <xmr:c1DoZYQWy3lWujEcFjKq-XcYyyi-RssklwkivN0EVELmHjpRr_gSV67R0XCD5znDZQkxUfdtdFV2vjx-i1uWEYxwb1Bpdp4-fjnAGBDVtmp2Pg2ugxql>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpedtudeggfejfeektdeghfehgedvtdefjeehheeu
    ueffhfefleefueehteefuddtieenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdr
    shgthhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:c1DoZVuaRtCrAO0YU9nEyt4A5R9BQ_ZKV16nStpxDC_TMG6dnBcX7w>
    <xmx:c1DoZRc_5Y5IYXzJzFiOCPd6R4SNnNMVCssWjDNpuXbsISVg8QiCOw>
    <xmx:c1DoZR0jZWpm2NXXlhVIqAU80IugBHBqdK4mHR41iRPh6k6aagkBOg>
    <xmx:c1DoZV7vsYNq8rvkRk6jv9HOPon_gpqQoG_5if7ly6sEHHRnZBPJ6w>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Mar 2024 06:16:03 -0500 (EST)
Message-ID: <a77853da-31e3-4a7c-9e1c-580a8136c3bf@fastmail.fm>
Date: Wed, 6 Mar 2024 12:16:00 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fs/fuse: Fix missing FOLL_PIN for direct-io
To: Miklos Szeredi <miklos@szeredi.hu>, Lei Huang <lei.huang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <1693334193-7733-1-git-send-email-lei.huang@linux.intel.com>
 <CAJfpegtX_XAHhHS4XN1-=cOHy0ZUSxuA_OQO5tdujLVJdE1EdQ@mail.gmail.com>
Content-Language: en-US, de-DE, fr
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpegtX_XAHhHS4XN1-=cOHy0ZUSxuA_OQO5tdujLVJdE1EdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/6/24 11:01, Miklos Szeredi wrote:
> On Tue, 29 Aug 2023 at 20:37, Lei Huang <lei.huang@linux.intel.com> wrote:
>>
>> Our user space filesystem relies on fuse to provide POSIX interface.
>> In our test, a known string is written into a file and the content
>> is read back later to verify correct data returned. We observed wrong
>> data returned in read buffer in rare cases although correct data are
>> stored in our filesystem.
>>
>> Fuse kernel module calls iov_iter_get_pages2() to get the physical
>> pages of the user-space read buffer passed in read(). The pages are
>> not pinned to avoid page migration. When page migration occurs, the
>> consequence are two-folds.
>>
>> 1) Applications do not receive correct data in read buffer.
>> 2) fuse kernel writes data into a wrong place.
>>
>> Using iov_iter_extract_pages() to pin pages fixes the issue in our
>> test.
>>
>> An auxiliary variable "struct page **pt_pages" is used in the patch
>> to prepare the 2nd parameter for iov_iter_extract_pages() since
>> iov_iter_get_pages2() uses a different type for the 2nd parameter.
>>
>> Signed-off-by: Lei Huang <lei.huang@linux.intel.com>
> 
> Applied, with a modification to only unpin if
> iov_iter_extract_will_pin() returns true.

Hi Miklos,

do you have an idea if this needs to be back ported and to which kernel
version?
I had tried to reproduce data corruption with 4.18 - Lei wrote that he
could see issues with older kernels as well, but I never managed to
trigger anything on 4.18-RHEL. Typically I use ql-fstest
(https://github.com/bsbernd/ql-fstest) and even added random DIO as an
option - nothing report with weeks of run time. I could try again with
more recent kernels that have folios.

Thanks,
Bernd

