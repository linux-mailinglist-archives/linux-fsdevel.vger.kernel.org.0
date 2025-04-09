Return-Path: <linux-fsdevel+bounces-46052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A583A8201F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 10:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F731BA0F5A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 08:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F336725D20D;
	Wed,  9 Apr 2025 08:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="gL6oXoGf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cpj7yjcI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A017A25D1ED;
	Wed,  9 Apr 2025 08:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744187513; cv=none; b=lkOD+PqtOggTWL9pWaDADquFV4UGN5vppGh0XDQ9694pfYer6yXsFEB9U5zMKynW8Zp130t7L8DhLGRqlNeD+/jclDrE03lDkrQxWoSPSpMyy1sPObyCwq7PrNNJ7rpgHoa9fQb0wJAOMew58dHIeXaqAm09dvWw4hs85v22EYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744187513; c=relaxed/simple;
	bh=PCpZpdhmfkrQTn04uXQxa/ZIWBVgIJf/v0Z5cgyr0h4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=piAVuDp15CMpzMk96vRcqIndKUSae1BF7604VWmIl2SZ6fxOOn0rAuXiJK+Ak1PczCvtDTKopSDwnFFRanDDuq4yB7hatiwAikkJcdaVtgWTGfH+tDboC9SNcxFqetSt+5sm84TinanCgclNCtETdd7iTd90TDDlXANNHBasbwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=gL6oXoGf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cpj7yjcI; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id AAC6C1380140;
	Wed,  9 Apr 2025 04:31:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 09 Apr 2025 04:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744187509;
	 x=1744273909; bh=t6lmhI9lGDXs0/ghIIQ/kwihxBN774g27lMjQXgy508=; b=
	gL6oXoGf8RA2NAuc6yg4i0HZCWKp+C7wmCvwdmuAjKrWYqZt7OCbpj1E3onC5vrI
	/BUIcoHoABC1zTD4VBhrUeo5WzI/kFk1b8H+4kjSSTlH2k8tBoTij8WN/DbHbsqO
	I71yaMiSWBAk7VAufXboL1AVG7DSNVMNzE9obm7PnYm4Zq2QimAm7lFp4SCcHbnn
	y6tXwXmuzXQX3YvSHgn+UFJ8hqUehs1o9jEyD3OJtCj74PC7dPjMlKJPxs2Hv+kh
	ZDbqJPQ24/n3/oxtod52a9Ah1KOHGJG724n6pCPT8L3B17aZd6oj5Osk7apEuIwd
	OTQwruEQ21cjoAUtz+irPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744187509; x=
	1744273909; bh=t6lmhI9lGDXs0/ghIIQ/kwihxBN774g27lMjQXgy508=; b=C
	pj7yjcIBC8YIAc6moPAM1lFW36hWc4haPuYtauOO5XShSMc/RAp1oyM+C+ztD8he
	2SH/15Rz4tcdLPTDAV4EMQKZqj0FUFbIQ9or3iziqjDBTe8SONL5cO2zaSlgBKUG
	cmzQ8J7MaaBbfn38KQZ3Mrpa+cxiHV80qg+UDx1PcHdzcf/fqpXUAcPs+/c80RX1
	PcoeA/6wF/4eOJaQzkcNsINJsQ7rvS+tUFsIMOGKnFpMnERh15POMLJKnrah2Ck3
	HENppBffRdHrvS5sP1swa39/pJJtJ/lEJTyiZiHRDovAg4JHb20H/nWNgRGiwUoT
	Q5OF50louOGwDSus+lImw==
X-ME-Sender: <xms:dDD2Z0bAUbbjrewj5RTiNixKojhJaH2uFdZCOh7IBeyBA5LDpIx94w>
    <xme:dDD2Z_bdC1DJFbe8JSQNRVQ1jw_G0EWKAHYxgZjB72XovapxEWZEMkcxCeiOPwwap
    yGOiivw9pRbTdmf>
X-ME-Received: <xmr:dDD2Z-_doKjDgXPcwkbEbtNas1LKD5p9miK3-6MqEOjhKS5zQXacpw360zYrgwIwT5UfWAykZ9Uo58Kh5qYXfeUkFHzZ-fHgI00khCq508Pk2_IqyDC2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdehhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuh
    gsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnheptddugefgjeef
    kedtgefhheegvddtfeejheehueeufffhfeelfeeuheetfedutdeinecuffhomhgrihhnpe
    hgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmhdpnh
    gspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrtgho
    sehulhhsrdgtohdriigrpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuh
    dprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheptghhrhhishhtohhphhgvrdhjrghilhhlvghtseifrghnrggu
    ohhordhfrhdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomh
    dprhgtphhtthhopehrughunhhlrghpsehinhhfrhgruggvrggurdhorhhgpdhrtghpthht
    ohepthhrrghpvgigihhtsehsphgrfihnrdhlihhnkhdprhgtphhtthhopegurghvihgurd
    hlrghighhhthdrlhhinhhugiesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:dDD2Z-qkGnN7oduFT9PCvNZ28g_dmqU3jWLFWdQCxIthLPEcP4FKaQ>
    <xmx:dDD2Z_o3fiL9VPyUfvw55J1bHiIWQlxB8Uxp4uQgT0Ed_BbFUDrpWQ>
    <xmx:dDD2Z8QNZ_06GZK-7QVi22GEHQEToWI3Du_vgxz7Ty8gS7vjAOAZzQ>
    <xmx:dDD2Z_qFjJaETK89aVToW6M8JuZQIeFAnQwcMjA3DTF4-fCtTfJIlQ>
    <xmx:dTD2Z8RJG-6HmAEoUiTqIvWTdEju_svnxnZ_HH-fYCp9xdtE3dy1UFKL>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Apr 2025 04:31:47 -0400 (EDT)
Message-ID: <e8659104-54de-4155-bac1-f45df440e468@fastmail.fm>
Date: Wed, 9 Apr 2025 10:31:46 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fuse: Adjust readdir() buffer to requesting buffer
 size.
To: Jaco Kroon <jaco@uls.co.za>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 christophe.jaillet@wanadoo.fr, joannelkoong@gmail.com,
 rdunlap@infradead.org, trapexit@spawn.link, david.laight.linux@gmail.com
References: <20250314221701.12509-1-jaco@uls.co.za>
 <20250401142831.25699-1-jaco@uls.co.za>
 <20250401142831.25699-3-jaco@uls.co.za>
 <CAJfpegtOGWz_r=7dbQiCh2wqjKh59BqzqJ0ruhtYtsYBB+GG2Q@mail.gmail.com>
 <19df312f-06a2-4e71-960a-32bc952b0ed2@uls.co.za>
 <CAJfpegseKMRLpu3-yS6PeU2aTmh_qKyAvJUWud_SLz1aCHY_tw@mail.gmail.com>
 <d42dec00-513c-49d4-b4f3-d7a6ae387a6b@fastmail.fm>
 <b812fec3-8736-4005-918e-318e955c1902@uls.co.za>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <b812fec3-8736-4005-918e-318e955c1902@uls.co.za>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jaco,

On 4/9/25 09:12, Jaco Kroon wrote:
> Hi Bernd,
> 
> You sure you're looking at the newest version?
> 
> Or where does the below need to get applied?
> 
> I'm not seeing that in the patch to which you replied.


I just applied Miklos' patch that uses vmalloc. It applies
to the repo without your patch

I also
pushed to a branch

https://github.com/bsbernd/linux/commit/2b5ca68656a4a47e35b8cf1dfcf39c4335066497

In this branch: https://github.com/bsbernd/linux/tree/fuse-large-readdir


Cheers,
Bernd

