Return-Path: <linux-fsdevel+bounces-29115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 994949758A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 18:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2FC281542
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 16:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE981AED31;
	Wed, 11 Sep 2024 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="CJrBAbOB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nEgNn/xb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BA8383B1
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726072960; cv=none; b=fsxaT0FmW2Nu2A5gLKoXVp8kcdcizt9AUX9m5Zda/HVMNe18Q/NMicyR5+h4VBoyeNwX2jJlhrBFyZe0epgdHY3fEqhbkUX61X3LJhJQypOStvTj/mjKIZyNGeoO9zUio2GB6aY81dZPaBqVKAe2t8E/pWqrFSReWfi1lAzJ8H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726072960; c=relaxed/simple;
	bh=S5x+5aVmOVZTl587zs+H/39pNbz/LVf3sB8si+ea29A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FbC+5aSdXeRjihsVSXCbmjElXN3N2jdgXQx0k3nbn/6pxbQnhIrsmuPVlvASY6oIeAT9NBPXkyoSZmC1Wy5e2Lo4b24PcBacX89DNj+uvAj1iOZa5rustBUXtx/Aw4T1d5h5Jd5parmvUc79bXg7D4tVJEOkmgrhi2UJqWZzEXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=CJrBAbOB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nEgNn/xb; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8883511401BC;
	Wed, 11 Sep 2024 12:42:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 11 Sep 2024 12:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1726072957;
	 x=1726159357; bh=XYZewyJ6x6fjTdjPMSh/aVe6lB4WxE4dnWzUv1YdnvQ=; b=
	CJrBAbOBQLXzB09ZyzPNr40mhtuJuy1BSb0aywblCiWEepH0YTB02haOLa7dG6P+
	0++nZD0RIXshT1MpFkpQDT0DoePrsO6xuzCc8SDggnnbiLHolL8ID6R+Yd8XxgJc
	tLvNpToiNsaW/tD9EDPm2EF1hh6n5ecJPiq/c6TElo9X6Y9q+MwHx8ZLHyczA9s5
	bp+ndJkr61GJjf1tiBUseHHlW6SWQ3+MTMZcL1u7yyLae3JtvG8SXhRi/STyk5k+
	FHJJr6JOmGbpOqIx0fLX9Zuh2zmTGcl6HL5jYTRQAEA5hklTcTn9Zm34NM2jS0GS
	7Eklyldvvl0XRA9Sz60f6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726072957; x=
	1726159357; bh=XYZewyJ6x6fjTdjPMSh/aVe6lB4WxE4dnWzUv1YdnvQ=; b=n
	EgNn/xbpSTbJjk8n1fWvx9nW5sbZ+Xw6oCQN874kWpENnENaR3urdOCnJA5MbT6W
	TWsmSXCryDMH0EK7NpFlQWpuJApXBkm6rusCvF5zQIwCQgWO1kQtxc6H+rXwjQGN
	mrQYEB5gRsPUWrcIqVyh0lKACu2XK0ARtvlnV2qS+N63SMhCqUL/WqpigcL1PTiS
	DzYE8UBco/QqChEobZWBXywj2Di55VDmF5O3diFCXSEjUSCN8Mo2gUTb3wTrsrQX
	HYY5KyM0OUhSeV7dSuecz5QyRTJzCh+MBtd7WR1hsO4fq+NTieS1f+N9qf/EDywr
	8NWoeAC2+5TJKUGMH6TDg==
X-ME-Sender: <xms:fcjhZr0_nFyF73ltbcYa4-8VwLqJCrs3GMM0YdXNYDE5_fDg7a1rPA>
    <xme:fcjhZqEN_b8KAWbGJhkrcivHxBkodnmHE82Dr3poS7RdI862F9U_CQT_N9H5LYQLh
    zSJg3tAUt-Dbg0P>
X-ME-Received: <xmr:fcjhZr7LyT4rFaYAOJ2KT5pEOGaT0H_-8irzsQaogTMWroFrWuotQLR682GrbmzK6WJqvH4P-FRonrRybS0mxjlQrpYDy83_7Hyd8IR_5SllV1MKO8Lb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejuddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeduleefvdduvedu
    veelgeelffffkedukeegveelgfekleeuvdehkeehheehkefhfeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohephhgrnhifvghnnhesghhmrghilhdrtghomhdprhgtphhtthho
    pehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuh
    igqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhi
    khhlohhssehsiigvrhgvughirdhhuh
X-ME-Proxy: <xmx:fcjhZg3gA-V_8VWuQsrePA8ixRObOYC5m1gboIDx2jPIQVEGj0YdNw>
    <xmx:fcjhZuHXMQyhf_oUg9LuD6HtRisqGz1Ath71wz1clLxGggRh2CYeCQ>
    <xmx:fcjhZh-tf5tSYLE_RNxrDnjhAuL7YjyX_2KYtYECMVnPc1DhhLmq6w>
    <xmx:fcjhZrkhGNjApFEqpGR1ZGdnnKpHHu7xoY03Omie_hkZ4auez3FFwQ>
    <xmx:fcjhZqjOvPNqKzn8WkHel-Yr4l17FiXZB1FyHbiBZdKTn8qiPxQ9Xf4o>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Sep 2024 12:42:36 -0400 (EDT)
Message-ID: <e5eb669c-d465-495e-b27e-a712553db121@fastmail.fm>
Date: Wed, 11 Sep 2024 18:42:35 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Interrupt on readdirplus?
To: Han-Wen Nienhuys <hanwenn@gmail.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org,
 Miklos Szeredi <miklos@szeredi.hu>
References: <CAOw_e7bqrAkZtUcY=Q6ZSeh_bKo+jyQ=oNfuzKCJpRT=5s-Yqg@mail.gmail.com>
 <5012b62c-79f3-4ec4-af19-ace3f9b340e7@fastmail.fm>
 <CAOw_e7Yd7shq3oup-s3PVVQMyHE7rqFF8JNftnCU5Fyp8S5pYQ@mail.gmail.com>
 <CAJnrk1YxUqmV4uMJbokrsOajhtwuuXHRpB1T9r4DY-zoU7JZmQ@mail.gmail.com>
 <CAOw_e7YSyq8C+_Qu_dkxS2k4qEECcySGdmAtqPcyTXBtaeiQ7w@mail.gmail.com>
 <0a122714-8835-4658-b364-10f4709456e7@fastmail.fm>
 <CAOw_e7YvF5GVhR1Ozkw18w+kbe6s+Wf8EVCocEbVNh03b23THg@mail.gmail.com>
 <be572f0c-e992-4f3f-8da0-03e0e2fa3b1e@fastmail.fm>
 <CAOw_e7aDMOF7orJ5eaPzNyOH8EmzJCB42GojfZmcSnhg_z2sng@mail.gmail.com>
 <4f41ae59-cd54-44b4-a201-30aa898ee7f7@fastmail.fm>
 <CAOw_e7Y49DRmVxEOPcAubtdzXzu6J-Z2wdkumxDs7OMHLRipbw@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAOw_e7Y49DRmVxEOPcAubtdzXzu6J-Z2wdkumxDs7OMHLRipbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/11/24 17:59, Han-Wen Nienhuys wrote:
> On Wed, Sep 11, 2024 at 3:06 PM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>> I mean SIG_IGN, either at fuse server startup or at set in opendir and
>> unset in closedir, the latter is rather ugly for multi threaded fuse server.
> 
> This would work for my tests, where the FUSE server is the same
> process as the one opening the directory, but if that is not the case,
> the SIG_IGN would have to be set not on the server, but on the process
> accessing the filesystem, right?
> 

Oh right, won't help to do it in fuse server.

