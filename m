Return-Path: <linux-fsdevel+bounces-70579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F31C9FE85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 17:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B48983002699
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 16:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296EE35BDC4;
	Wed,  3 Dec 2025 16:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="aHcDVid9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KLfJDOBp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685C135BDB9;
	Wed,  3 Dec 2025 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764778991; cv=none; b=nDD1VO59L49R0s4bca/mNSPstzYL30BupdBvycglBZm9rZX0J/eMa5jeegyBt+1AQ9Y7TjwIkeAfMZ8VY22diRdU4ul+7ZV+xLKbY97UQzZxxSj2/E3jTdn0HhSuGcHwo/DHNsEQqiR4paK6Yesvyu0B1Z4IYlIDT/XTcvGplz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764778991; c=relaxed/simple;
	bh=bx937mEcj8vEK6tgEte3icTEq3dIugv3PYquKmorkHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IU5Jsa2XJT3WeFZhWDmYZqzWSxMrxdfii9nMsUAL/2up8K/Z0PcSadlcV4VujjzEg8g0fuMNr/SNDuDTVynEfhsGA93XfRUyWQOLxRyUREC+kW4FVfQARLXURA4cQL9i4z0b8+eO/B8nfwV5trjNkF4+HlmedI+Kqdbf2pdeRq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=aHcDVid9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KLfJDOBp; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 881C1EC0541;
	Wed,  3 Dec 2025 11:23:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 03 Dec 2025 11:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764778988;
	 x=1764865388; bh=VQ/KPY2nDrJs35yoFE20KGE0zYNXnzk6GT4UM+TVCc0=; b=
	aHcDVid92/5L5FFIAYdIr1bRtonG7s8TbvPykkKSPEHfjseHeA7HQmzliHPetkmG
	Mb4nS5oDESl/lASUy+iIlKjOafpIfg9rGCFy3OZ9BTWg1pimnFAooSBPAJXJDbir
	IcSHiUc97vn5NLv4BOy1Y3XkiSCgqeQTMZ6bGUA657uwIQVArFsl6T8YM8fQXcb0
	ijeDZqR3tcInx6P9COkzrXdNS79BoKagdCNbVCjoTdksLAbu6yM10+uPDuPI3qvl
	nXMJlxBrIw3Z3F7Hxa74WXf67Mj8sREWYdxMKeb0XCbwdISQt0bCJB1RidUl783Q
	FvDx9fWCXfbC1uuy3Z/wjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764778988; x=
	1764865388; bh=VQ/KPY2nDrJs35yoFE20KGE0zYNXnzk6GT4UM+TVCc0=; b=K
	LfJDOBp57l/lYsvtSCbgMRGtumpG74hVdMSgylT+LMf04MwY7Oz16JKa+rntx0hZ
	oGx0jhHhOqvSsNWznltPwGgrsGdVEdP4uBpHuks+BKKtk8qtKcoUSTbNzbE1qnbr
	Teh2xrQWpqQz5crvVyRTACzx0/KRRKJvHgayRT9D7dE7pIUpJe3DOUTMqLYjFI1p
	hFoH3zB4h5gpRt0Ro9+KsGYP1aRqWlrFhZ9bA8AXOh1nK2bD7ApqfcI5Qs2jvqlN
	+p+8AeosL9gbMAentsrTd1/XdetWne1yoJ5zqW9IzW9UXt6Adg9hvGhE+Tg1ZpM7
	Qr1qcDx1/1affS1ezlp/A==
X-ME-Sender: <xms:62MwadYpzPsImovkpqYOd1a5cPLHLn48zenyhSaTsM8HaMZHPm_RWw>
    <xme:62MwaaaLzqEFscS3Xgu6v3GHtYT1GAi-WKw875tUL7cenf28nv82Ka1KmLHLOGOkg
    cc3RlAepar1ZlRAs9vqOC10BcZhYAEn9j6eM3LSyRpHKjZlusfE5Fo>
X-ME-Received: <xmr:62MwaawCMbtMzyGraIY9s_2hdZHn1Nz4N5R1vCmS3rIBomy8o6id672GJcnh7SM8p5O6gPsMMp7e_E8DasSnse88jw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttd
    dvjeenucfhrhhomhepgfhrihgtucfurghnuggvvghnuceoshgrnhguvggvnhesshgrnhgu
    vggvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepveeikeeuteefueejtdehfeefvdegff
    eivdejjeelfffhgeegjeeutdejueelhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepshgrnhguvggvnhesshgrnhguvggvnhdrnhgvthdpnh
    gspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrshhm
    rgguvghushestghouggvfihrvggtkhdrohhrghdprhgtphhtthhopehsrghnuggvvghnse
    hrvgguhhgrthdrtghomhdprhgtphhtthhopehrvghpkhesthhrihhplhgvfhgruhdrlhht
    pdhrtghpthhtohepvhelfhhssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoh
    eplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopegvrhhitghvhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhutghhohes
    ihhonhhkohhvrdhnvghtpdhrtghpthhtoheplhhinhhugigpohhsshestghruhguvggshi
    htvgdrtghomh
X-ME-Proxy: <xmx:62Mwaee7Rh3b4WodIKywTGZl2k0e35htAZ7HBjreCLvW0wTx3EDsqg>
    <xmx:62MwaX5NXhgNov7wjEiBiXiCtfjPpN_UXSw7JvryjqE3683Hia0BhQ>
    <xmx:62MwabK4ZjDrenv7-NY_Ui6vH1CUfqPiglSpyMmPjf6Q75VBxLgUmw>
    <xmx:62MwaXzTEn0KD1NTFpBBsAnRYz9kaQvIEtMnfG3aA2dpOJSSs322mg>
    <xmx:7GMwaZOhnMw8aS-hmOBkz6hqwkNKhvNOKXyFw77Jk0aeKisBHiq7z41U>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 11:23:07 -0500 (EST)
Message-ID: <35a48945-a163-4325-9e08-8f1604c698bc@sandeen.net>
Date: Wed, 3 Dec 2025 10:23:06 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 4/4] 9p: convert to the new mount API
To: Dominique Martinet <asmadeus@codewreck.org>,
 Eric Sandeen <sandeen@redhat.com>
Cc: Remi Pommarel <repk@triplefau.lt>, v9fs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com, eadavis@qq.com
References: <20251010214222.1347785-1-sandeen@redhat.com>
 <20251010214222.1347785-5-sandeen@redhat.com>
 <aOzT2-e8_p92WfP-@codewreck.org> <aSdgDkbVe5xAT291@pilgrim>
 <aSeCdir21ZkvXJxr@codewreck.org>
 <b7b203c4-6e4b-4eeb-a23e-e6314342f288@redhat.com>
 <aS47OBYiF1PBeVSv@codewreck.org>
 <13d4a021-908e-4dff-874d-d4cbdcdd71d4@redhat.com>
 <aTBTndsQaLAv0sHP@codewreck.org>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <aTBTndsQaLAv0sHP@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/25 9:13 AM, Dominique Martinet wrote:
> Eric Sandeen wrote on Tue, Dec 02, 2025 at 04:12:36PM -0600:

...

> I also agree the other show_options look safe enough as they either
> print a string or int. . . .
> Ah, actually I spotted another one:
>         if (v9ses->debug)
>                 seq_printf(m, ",debug=%x", v9ses->debug);
> This needs to be prefixed by 0x as well -- Eric, do you mind if I amend
> your patch 5 with that as well?

Doh ... sure, please go ahead and fix it however you'd like.

-Eric

> 
> Remi - I did check rootfstype=9p as well and all seems fine but I'd
> appreciate if you could test as well
> 
> 
> Thanks!


