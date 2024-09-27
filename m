Return-Path: <linux-fsdevel+bounces-30213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B6E987D1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 04:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E886B1F243F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 02:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0155316E86F;
	Fri, 27 Sep 2024 02:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="RwZBZcml";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H2yxUoxE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A448158203;
	Fri, 27 Sep 2024 02:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727404772; cv=none; b=GmQx+2V6L7jgtwcGXnO0srTd1XbU9Qt7TQh8qom5lqXTjJf6+5cWQmTDWlbz7eZFNXCYniBOHg7Jiir/xkpfeUoGjVSxzERWfTfO2chSWU1tAkhaMhTKucswEA8sZQ+zsuX0znLAU4BNaV6Mb5tw8mpJsLYrc8DVo8+j8vNn1yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727404772; c=relaxed/simple;
	bh=6IiA3CI+ncRhB4nevilH3Amfa8WE2li/aCE3SCActVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c9st+SGAyzqJNIalCfdtdTt19pvsM2VpsT4Ri6f0WWyThqXcJXCp0K66ZBqk/oheWT77ijcVz2tGvTLSzQCzXhHlRo5+ToA0OPz+yRxRSj3cE9CkSO4sTp0RpyfyeeoLvAk95BF8S+09+kq+PMiSEREk/7dc4ey2TNyET6sFfc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=RwZBZcml; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H2yxUoxE; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 25CC0138026A;
	Thu, 26 Sep 2024 22:39:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 26 Sep 2024 22:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727404769;
	 x=1727491169; bh=ooAna1dt8fOcrt2wq9Upl/xQhMR9tlHFSBv1SmAVsp0=; b=
	RwZBZcmlvKG2MryC9GEGC24TRvHgA5Z2YuEM3a2V0ezLlKJBeOP4Dffi2388Q/vR
	b9jJbXTBreXuSTpnxSWcLbJCPegH4WYBIEaAb4QSUH3OvYqZf6iR0XgwkfAyiMa5
	rcwDu94taPzlQVL5zl3yqx5ML7emD+S9paSn8TQtKRf+tp10Jv8hDDM/LXLw8HGV
	WJE4DQo51HNtPRfc1/5Cwk8qWQTGC2TfYmnY5mKXpwib+86uMx5IKn+WhTqAzj9e
	tJVn0kHZsaOndjID8Yd6eseqTHzmsToP4pmhdRuLLsVUj6GhmTlk1u3+pySqTerW
	8JMe63YSy2HoQkLeZiNhig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727404769; x=
	1727491169; bh=ooAna1dt8fOcrt2wq9Upl/xQhMR9tlHFSBv1SmAVsp0=; b=H
	2yxUoxEF9B9TWaPFvVJrhN9gB4fxuSVcA5MrqXWAtOaxHGwVh9ywvrQOtB5vvPJL
	xke9Cw4MASweIs36Tb9K0P8cEa85Xo2u4P9dG+aM47V21x5La4IdOEBDc9rDEwO4
	cAWsHanjWxdwZp9RtRb6t4CqniQMHx/YOMgpjMidGa3GEnJ3NWYdXOOel8ykWhhp
	Z/WcX4YEdtU5NpKAtbUtC/1DByRClPRpDJrHRkqRuqkIiDA+m2z+NVx9Gk1adXmD
	A87b4ckFr4CscG+Wp4beahDQsqPN6aVzmmbz2nPsjMgoQKZDbUY8Z/TMa6IDcm6p
	lsxWUSBb/50wCHA5G3rEA==
X-ME-Sender: <xms:4Br2Zgi8kzSxrRb_h6jQC5uvl9qHZ7Aba2nONSxkl1pCmOZSAldqEQ>
    <xme:4Br2ZpBbLK06YREupX3ODwlsCim2oJ41eqXiCKfFGanJXeliXIqqt_oVD5TPEhTFA
    1uwrSHgL_h5P4NFhpc>
X-ME-Received: <xmr:4Br2ZoG0RtYXRkbu7cUBa9lNcQDiwmofrl8bQFdPixlbvXPMtaNtSq5WrkAt1uqaPjKaaCplC-41meDv7_PAogQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtkedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpefgrhhitgcuufgrnhguvggvnhcuoehsrghnuggvvghnsehsrghnuggvvg
    hnrdhnvghtqeenucggtffrrghtthgvrhhnpefgueevteekledtfeegleehudetleettdev
    heduheeifeeuvdekveduudejudetgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtpdhnsggp
    rhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhisggroh
    hkuhhnudeshhhurgifvghirdgtohhmpdhrtghpthhtoheprghlvghkshgrnhgurhdrmhhi
    khhhrghlihhtshihnhestggrnhhonhhitggrlhdrtghomhdprhgtphhtthhopehthihtsh
    hosehmihhtrdgvughupdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprgguihhlghgvrhdrkhgvrhhnvghlseguihhlghgvrhdrtg
    grpdhrtghpthhtohepshhtghhrrggsvghrsehsthhgrhgrsggvrhdrohhrghdprhgtphht
    thhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4Br2ZhQtFkxJDhG9Hrv5SIF0nmOv0Nwf97ng5uK6CiGU8CxnT9zx2A>
    <xmx:4Br2ZtztpHSbOHBXok6oW3FQRVwCyfKIadK3H--R5UjXMXanR14fSQ>
    <xmx:4Br2Zv6Ko2ecOZI-ZbL5n7lQFylI8TE0_rfgzhGodmZsYZqnVPUTNQ>
    <xmx:4Br2ZqzzR-h7U7MoXXD5BqgX38HhGMUU1HTXI-LKbXfof3_PQzkF-w>
    <xmx:4Rr2ZtjmSxyVGRDCJaMv2rIF_WFKw7AiDyZmXULJpKpzk7NP2eRaeXkW>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 22:39:27 -0400 (EDT)
Message-ID: <0596a1ae-f47c-4b6f-8849-73e7cfe7ff39@sandeen.net>
Date: Thu, 26 Sep 2024 21:39:26 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ext4: fix crash on BUG_ON in ext4_alloc_group_tables
To: Baokun Li <libaokun1@huawei.com>
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
 tytso@mit.edu, stable@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>,
 Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Wesley Hershberger <wesley.hershberger@canonical.com>,
 Yang Erkun <yangerkun@huawei.com>, Jan Kara <jack@suse.cz>
References: <20240925143325.518508-1-aleksandr.mikhalitsyn@canonical.com>
 <20240925143325.518508-2-aleksandr.mikhalitsyn@canonical.com>
 <20240925155706.zad2euxxuq7h6uja@quack3>
 <142a28f9-5954-47f6-9c0c-26f7c142dbc1@huawei.com>
 <ac29f2ba-7f77-4413-82b9-45f377f6c971@sandeen.net>
 <7521d6a5-eb58-4418-8c2a-a9950d8faf9c@sandeen.net>
 <11e3133e-6069-477f-9c4a-3698bd6a18ec@huawei.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <11e3133e-6069-477f-9c4a-3698bd6a18ec@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/26/24 8:51 PM, Baokun Li wrote:
> On 2024/9/27 0:29, Eric Sandeen wrote:
>> On 9/26/24 11:04 AM, Eric Sandeen wrote:
>>
>>  
>>> Can you explain what the 2 cases under
>>>
>>> /* Avoid allocating large 'groups' array if not needed */
>>>
>>> are doing? I *think* the first 'if' is trying not to over-allocate for the last
>>> batch of block groups that get added during a resize. What is the "else if" case
>>> doing?
>> (or maybe I had that backwards)
>>
>> Incidentally, the offending commit that this fixes (665d3e0af4d35ac) got turned
>> into CVE-2023-52622, so it's quite likely that distros have backported the broken
>> commit as part of the CVE game.
> The commit to fix CVE-2023-52622 is commit 5d1935ac02ca5a
> ("ext4: avoid online resizing failures due to oversized flex bg").

I'm sorry - you're right. 665d3e0af4d35ac was part of the original
series that included 5d1935ac02ca5a, but it was not the fix.

> This commit does not address the off by one issue above.

Agreed.

>>
>> So the followup fix looks a bit urgent to me.
>>
>> -Eric
> Okay, I'll send out the fix patch today.

thanks :)

-Eric

> 
> Regards,
> Baokun
> .
> 


