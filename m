Return-Path: <linux-fsdevel+bounces-64143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AA3BDA966
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 18:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB598189308B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 16:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BE4302161;
	Tue, 14 Oct 2025 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="0rN2zvH4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rpNEprz2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55032FA0C6;
	Tue, 14 Oct 2025 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760458544; cv=none; b=Bw+pI6F06C790rI/B4bSCENyu/XNmlJSOz4LIucAeCW5WQQiF+OkJjUsejNDfV7JSocQ0N2PxRDpq9MvBKo1I872hQhCUf4ht11JwJhuAS5dxY5kzoAPiDK6geDtoBtbXjFjVWTgbGcyQ1opWqJpbQ5RFMWcBy4QBJ6iGjpABrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760458544; c=relaxed/simple;
	bh=Q6w1VqE53FfeBz4WyCau9FEGBSuaRabiVIaUWKK7iVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZJwIixz+Lw22+9jE8rFGSODM9buV6lDMyFP2lg5c3mXIoiwctqt6I80GSd+5XbSDb8bBCfNnqdBRwtW9Ke8Vg7sLkfZlpLLREqE0uzBc+JgX5U733n1nDij2uLT1fxk+IkDrd9xV3Ih4eW9bzqgfC7lgc4mdSYl19F1QCLLIqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=0rN2zvH4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rpNEprz2; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A4E15140019B;
	Tue, 14 Oct 2025 12:15:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 14 Oct 2025 12:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760458540;
	 x=1760544940; bh=FX0qldBxQ77xaR9LMotvxqCgckJFEK9oGv3cR/G8Hdw=; b=
	0rN2zvH4VOfjxTZJaIampjp7+aKRz8EtP0qFfSfOAZPbHT1OuTsi8qhCMXykKxT8
	fTTgZJYeapddatvbSxbx3mI790tZcPPVtb3k1VCUOcQRf4vfJTKjByWbJWLHyCiM
	FUpKCk4QF4Guq/7CJQeEVisgR1pZo7hGKWFiW48qG8f1TLKrjJEltbth2ObhOPdt
	PswVZ02OaBzU7HwDO/acX6ipF9ddbxC6tNIALG+LI7WWRtTBmipa8W24IHPhe03N
	BdVUtjWT5IiunhDqBGj/MjIAcFfpOrYE0eDjpadvBniFyXwcWy7V9EhPGrXashm/
	IWf3bImhpDSBV477QmvajQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760458540; x=
	1760544940; bh=FX0qldBxQ77xaR9LMotvxqCgckJFEK9oGv3cR/G8Hdw=; b=r
	pNEprz20m7CD+xQwZPJ7j30cM12nJ3XD6iFaRbafP5ps/r0O38vbMupDPxkNPZvF
	kvXhC6Q25I2sGuXypA4ezgbjov7gdgAd/7YlR1lmQCr2AOQwKgi9rRM0kPEQW5+a
	V6Cz3ymUDN8/icRjoKI9r5/MF4RnBVWluVpdygMJQwfcLf46EztSkOdJHoYFr3Hu
	XrNscHgKSEcOsjJ9baPh5eXe5+jXbFnfBJfymVX34vqecYf8aIdMpiGnFK2CGu7J
	QZTBF7GuU6ftdsoca7CYsDvOMPtAjvjiG7bgd67s06f/5QUBHr2J21vTRgLh4TxE
	I7zZvAQzKO2BrH8wK/Jxw==
X-ME-Sender: <xms:LHfuaCstO4nbEHBisQb9Go7YPAIu7Ac__31BdXtzFys1FXFW0yp8Ww>
    <xme:LHfuaAxNWGoNfBwcHh4sZUVZk72LHHumYnKI50Bg1BQm-dnqzNadurUL1rmV0cy66
    Q5wHGWBXmwrl0Z9-MGHEzAQLFO5tGz1c9wQTOcN_NOt7hipLw>
X-ME-Received: <xmr:LHfuaFBlV3IvfZwBDg7Ey9KpjxzuFdCR4iIKNLUOgeQKZtDynIbwTgRV2PltJKppLQ06PgBtMrQiEnEX5PPbvpkReUIx3TjhmDlMDTIgFwSTayDFjuxt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtg
    hpthhtohepsghfohhsthgvrhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepghhivhgv
    mhgvrdhguhhluhesghhmrghilhdrtghomhdprhgtphhtthhopehjohgrnhhnvghlkhhooh
    hnghesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LHfuaOchLIkaVBpRBcAPU42TobfJZLnqGJ0TPMfBuMy8gx2jmzxXXg>
    <xmx:LHfuaPlvPK9hOW8pCc_PvrK-4xW5Nwrx7AMEAsCjWS_IQ5in4AlnZw>
    <xmx:LHfuaFFnrw-vZVcsjE4dNji4jQuUk_CMlE1p7ZkQtlEL4WHrUgG3Pw>
    <xmx:LHfuaH6fcayc-8MJKjn8UAvlKhiNV4yNKxn_axFYYbd-C3FAvuDPjw>
    <xmx:LHfuaLHO1szm_81gM-x6rZEqzjBNUlgWD6focfw0-3qzvzOTSy_n2Drl>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 12:15:39 -0400 (EDT)
Message-ID: <3cfc568a-532f-44e0-a58e-6c3e042b173d@bsbernd.com>
Date: Tue, 14 Oct 2025 18:15:38 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: Miklos Szeredi <miklos@szeredi.hu>, Brian Foster <bfoster@redhat.com>
Cc: lu gu <giveme.gulu@gmail.com>, Joanne Koong <joannelkoong@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251009110623.3115511-1-giveme.gulu@gmail.com>
 <CAJnrk1aZ4==a3-uoRhH=qDKA36-FE6GoaKDZB7HX3o9pKdibYA@mail.gmail.com>
 <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
 <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
 <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com>
 <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com>
 <aO06hoYuvDGiCBc7@bfoster>
 <CAJfpegs0eeBNstSc-bj3HYjzvH6T-G+sVra7Ln+U1sXCGYC5-Q@mail.gmail.com>
 <aO1Klyk0OWx_UFpz@bfoster>
 <CAJfpeguoN5m4QVnwHPfyoq7=_BMRkWTBWZmY8iy7jMgF_h3uhA@mail.gmail.com>
 <aO5XvcuhEpw6BmiV@bfoster>
 <CAJfpegvkJQ2eW4dpkKApyGSwuXDw8s3+Z1iPH+uBO-AuGpfReQ@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegvkJQ2eW4dpkKApyGSwuXDw8s3+Z1iPH+uBO-AuGpfReQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/14/25 18:10, Miklos Szeredi wrote:
> On Tue, 14 Oct 2025 at 15:57, Brian Foster <bfoster@redhat.com> wrote:
> 
>> But TBH, if the writeback thing or something similarly simple works for
>> resolving the immediate bug, I wouldnt worry too much about it
>> until/unless there are userspace fs' explicitly looking for that sort of
>> behavior. Just my .02.
> 
> Agreed.
> 
> I just feel it unfortunate that this is default in libfuse and so many
> filesystems will have auto_inval_data enabled which don't even need
> it, and some mixed read-write workloads suffering badly as a
> consequence.

Maybe we should disable it in libfuse-3.18 and hope for reports, in case
there are regressions?


Thanks,
Bernd



