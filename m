Return-Path: <linux-fsdevel+bounces-30189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BADE987791
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 18:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03BA41F215D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 16:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421B015B963;
	Thu, 26 Sep 2024 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="Zmm5Dmh3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JjVA+NHs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC4015667E;
	Thu, 26 Sep 2024 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727368202; cv=none; b=FrOwTArEnquY2vz6L8xCWYMJ61E+jhcoQV8/CqtTqqzJn27O904gE2ontf08MwqOqxU1HFNdvpJw5hB684IgAQgRnnFWHp76CBxNqz4G4DkjKAhXHdcn9nRjQCMbTVujE67U6acYu84U4pcAIrUO6C4w7EC6ur5iIQBgpCdw1Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727368202; c=relaxed/simple;
	bh=3Dvkb5szF3lpZGEDJN3/FA+b3iwYg4X+c90kPDoPmbc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NVMaRlYfs2Z3rLAY28ov/+D2iI0QYM31FVyrg32ZX0WgZPljPrSGfXJP5A94H4ZofsWKm4M3IvELyxIZNEN33dOiH/F37qjE07UTDe/RpvR12xh+wRX3wLuKjA7N6vsyFePobr9i0VpYKB5Uys4venSnS2dqlpxwh1vqgujMOQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=Zmm5Dmh3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JjVA+NHs; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id A455713805DA;
	Thu, 26 Sep 2024 12:29:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 26 Sep 2024 12:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727368199;
	 x=1727454599; bh=1fwaZ1hPf62zxuN2ZMSl392OZLsu53rvKQgTM/7if8Y=; b=
	Zmm5Dmh3x1mLgSc74NZBflacrcTOx0yPZO43a5iFEieui6OnFFeXhb+xapY9klVU
	yuqoq2Nb3H97qNgQUaJ7Iq98BC8VoZs3FS6zRW5ntSPYNFXBMCffW9lFjgpti+OW
	gYyG3o95SNU98svAMFo44FIX6yuxBZbfIdfqSGTeuygQSdQNqlemLFM+OlWNjd6d
	05EBTtvFGP33jvbILd9IXcpvqUWnoHzzgHZQU+UF8Apxtl6r4fJCe5LsucuJx4Rh
	lQ6HHdxBhwMxC4SDcCrdCHY8d6sNwsecz09hlTQNpwu/c967SAMLmgRmXy5x9p58
	VNIGwvNqIVzeuAs4ONfP6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727368199; x=
	1727454599; bh=1fwaZ1hPf62zxuN2ZMSl392OZLsu53rvKQgTM/7if8Y=; b=J
	jVA+NHsE5S1BBcTvfFA2OzlnzamUxpmSyFd7xkdoyTrqsPJcdrtnY82JSp02X9Tu
	8gr4wZnWPv+egOdK1L6wlmlfhdGibyHfM506zpcUVfPQMmvw1mvs8NmkkfzKL0LU
	nMKZebo/3rMSgczDdHbtkWxSIYKzgvfSeZmZfXKq1+k0VAdGl1qF20fFM7b2l8PT
	r+8nwc4x7/2ws+XWvwJIgtN9bJM1izrCCch9RH0Z3IJaqa2a6vheXSxK4ytOrtQo
	7L+h/tUvlm0dzetrhqpnCfbbfLywddCMQWPpMpUycfsxeWA7h5fIGbCM6y76sBJE
	yg5ybUyGRH/250EkW/CAA==
X-ME-Sender: <xms:Boz1ZhqjqCG3-UAYp4gOVToanJQuKs1shjy50VxpcwSEjYj3SPPfkA>
    <xme:Boz1ZjrqRAcTgXccHEGkbDeASALVKvXVTvQlkJjPOo8FQaWMEM2NgJcPnvwUH5nCs
    wv7HNCDtVBBARCwz8w>
X-ME-Received: <xmr:Boz1ZuMuoDP9WO5c_nO6PqlzYdyFIOJ6g4y95IJNljZeMSXqwnwnxsHwn9ISiTOcsPlp2Yi7GYeGOuegOQtnOYE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuhffvvehfjggtgfesthejredttddv
    jeenucfhrhhomhepgfhrihgtucfurghnuggvvghnuceoshgrnhguvggvnhesshgrnhguvg
    gvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepleevuefhueejheevhfffhfeigeeifefg
    ieejheekteetkeejteejtdehkedutdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshgrnhguvggvnhesshgrnhguvggvnhdrnhgvthdpnhgs
    pghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihgsrg
    hokhhunhdusehhuhgrfigvihdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgt
    iidprhgtphhtthhopegrlhgvkhhsrghnughrrdhmihhkhhgrlhhithhshihnsegtrghnoh
    hnihgtrghlrdgtohhmpdhrtghpthhtohepthihthhsohesmhhithdrvgguuhdprhgtphht
    thhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrug
    hilhhgvghrrdhkvghrnhgvlhesughilhhgvghrrdgtrgdprhgtphhtthhopehsthhgrhgr
    sggvrhesshhtghhrrggsvghrrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Boz1Zs5Uez0PeoqBJrzgIgAmZBSI4q4L8dYc1HIMsDMi1Hb30VuufQ>
    <xmx:Boz1Zg703wmR4OE3S78QoMgz1jVay8x86g_ccPq53qSYR9_jZ3j_aQ>
    <xmx:Boz1Zkgabgsbe169-Ro-3swhgewlI8xNhPuP9OHK_jbHiYczxy3t2w>
    <xmx:Boz1Zi5ye-Z0epOewj9X37bh3RswywBIWZJBUJrCVtVTj-4838O4PQ>
    <xmx:B4z1ZrKaPitTbu1i7it8qkr70C04tBkRufBVQjOFXIs9gOOU0UbuKa9d>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 12:29:57 -0400 (EDT)
Message-ID: <7521d6a5-eb58-4418-8c2a-a9950d8faf9c@sandeen.net>
Date: Thu, 26 Sep 2024 11:29:57 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ext4: fix crash on BUG_ON in ext4_alloc_group_tables
From: Eric Sandeen <sandeen@sandeen.net>
To: Baokun Li <libaokun1@huawei.com>, Jan Kara <jack@suse.cz>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: tytso@mit.edu, stable@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>,
 Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Wesley Hershberger <wesley.hershberger@canonical.com>,
 Yang Erkun <yangerkun@huawei.com>
References: <20240925143325.518508-1-aleksandr.mikhalitsyn@canonical.com>
 <20240925143325.518508-2-aleksandr.mikhalitsyn@canonical.com>
 <20240925155706.zad2euxxuq7h6uja@quack3>
 <142a28f9-5954-47f6-9c0c-26f7c142dbc1@huawei.com>
 <ac29f2ba-7f77-4413-82b9-45f377f6c971@sandeen.net>
Content-Language: en-US
In-Reply-To: <ac29f2ba-7f77-4413-82b9-45f377f6c971@sandeen.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/24 11:04 AM, Eric Sandeen wrote:

 
> Can you explain what the 2 cases under
> 
> /* Avoid allocating large 'groups' array if not needed */
> 
> are doing? I *think* the first 'if' is trying not to over-allocate for the last
> batch of block groups that get added during a resize. What is the "else if" case
> doing?

(or maybe I had that backwards)

Incidentally, the offending commit that this fixes (665d3e0af4d35ac) got turned
into CVE-2023-52622, so it's quite likely that distros have backported the broken
commit as part of the CVE game.

So the followup fix looks a bit urgent to me.

-Eric

