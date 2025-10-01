Return-Path: <linux-fsdevel+bounces-63161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B909BB0064
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 12:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF0973C4F97
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 10:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEE22BEFE5;
	Wed,  1 Oct 2025 10:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="feeq6UlI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jcNScCXA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9488C29BDBF;
	Wed,  1 Oct 2025 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759314831; cv=none; b=Vk+mODBKuGHxeWrKjSGC+Jaq36cfNd19e7MFST9YZSGu8V8kAjpjU6VmDC3DY67P9fbPe0UJdVuQk+2E4Esv33vuBZRswFu5c/1nUovnjGXW9gNQrwPtLm9YdXBetU1ypf3UJ4QUWetIa2DleLCBWVe3OGYiYsM/Vnh9OSbXvmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759314831; c=relaxed/simple;
	bh=qdkXHIbNMbEMiYezbHUrizy/2CrJNGWYkQW0Pk6sQKk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GyF1C3LiQ6IlwQvhghUAQoDmC3uMxIu69jZrMFOUhL0ZNVj9lO96JBuBdtna4wMoysI8Ack4abCv06BS7NzcyjNAIABPRmzuj2ebrWBm2FmF5BrbBuWkCSc67rqDIQWm5efjrnb5Ym6vjd/8Jtbr4+T4MGC2C8rfiC15MjBKTSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=feeq6UlI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jcNScCXA; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A63BCEC0038;
	Wed,  1 Oct 2025 06:33:48 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 01 Oct 2025 06:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759314828;
	 x=1759401228; bh=agdHks9lyG6tctUiW+jhPBwjGNOe4D9oaDJAAzykNbo=; b=
	feeq6UlItMRLW37EYs0oqpVkS+mHpM5WRWuj5gmt3o02aWCprD2uqlJEQdJ93/Tu
	p0G3FEPnxSy6rLTKJIq8iNzFNIZS5KyC9GkpPef7K91LXf3EAJZuUzlfYXSS6KY4
	Eej9oRKCmjQXgJl9ciuuEll3CzStLE6uAc2URdx1rxdlQcJgGh+xsFU9onJyycqA
	D4o6Tck379swTGHapmd2lo02B87UXvpvwlpXxEJ2i+nn//r/fOAAyWOUEodBUjIC
	yp61DV4klkIO8TErCwG1f/pB4IOlyS4SS28roR1k3FjtDCo5/J7+f43wPTkOg4vK
	LzzFHUo+iltShiHLm9INyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759314828; x=
	1759401228; bh=agdHks9lyG6tctUiW+jhPBwjGNOe4D9oaDJAAzykNbo=; b=j
	cNScCXA55P3ijJujX5AC1s6FdnrzSaQ3cbH7ChbjzhGmpLorJjkfvuaJlg0DT9GW
	Jpbmy9Y6raS0d0RxzfASKcZ2lnA1RSpDOuhs2IQGrJOMNGWD+jnuSoezwL50jJ4a
	FjKwq39DwkxDS9Cr4A36iX1sfySK4mVeRKqJFlbUsqO6IflO7c/6QK0QXRE/Y940
	/f3oPzXLqLpAzNrrPoSMwekJVebHJ/Z8H2KxXCD/+FINkRLdiCNQdEpX0zd6IeWW
	AT5ljHjsYYOqK7rvvQZe6Lkll9Ac7ReZrnd6b6lFsmBffY7zgWnN3JZDCTFbEoss
	bvj0nFarxGP+Uwah+8zJA==
X-ME-Sender: <xms:iwPdaCvok4bwFWdJHIw0eGeeaJKu8TAEcYtPvuXaRMvf72LGvzcsVw>
    <xme:iwPdaCRQw1yErdihbn5_94TGmGjr06wemewf_0P7NAqGFTEgOAS5Sp6iPVJA2YAmV
    pf9tkLFAYyekxTFLmdnTJMQtsHq-8B9fJkpNucrrx3kakIBZkNb9_k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekvdeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedvhedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheprggthhhilhhlsegrtghhihhllhdrohhrghdprhgtphhtthhopehprg
    hvvghlseguvghngidruggvpdhrtghpthhtohepfhdrfhgrihhnvghllhhisehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepshhuughiphhmrdhmuhhkhhgvrhhjvggvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheprhifrghrshhofiesghhmgidruggvpdhrtghpthhtohepsghr
    ohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepphgrthgthhgvsheskhgvrhhnvghltghirdhorhhg
X-ME-Proxy: <xmx:iwPdaAGJg0r1tUvzifZedA6eI7BNl9Flp9oyz2bBWy6e87zZFDvjPg>
    <xmx:iwPdaJO65jKR24UetwgrvhOp_NDxxzsQcXcriVnQJBldKs4gjw_xdg>
    <xmx:iwPdaHeJOcjq3QFuAbbhVychvH-aNLrc3Ja6IwCRb_7D-sHJAoG1qg>
    <xmx:iwPdaOQoZcXxtZuFNx82TNW1vE61hkgn2XVyPQZLlgrPxgxFnHSvGg>
    <xmx:jAPdaBwIJjLJSXBM-6fIQBoA-5Xu-i0cqk1c3p5LjZscThAAzGjFd54Z>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0C01C700065; Wed,  1 Oct 2025 06:33:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AHv4v8KaD7D7
Date: Wed, 01 Oct 2025 12:33:26 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Guenter Roeck" <linux@roeck-us.net>, shuah <shuah@kernel.org>,
 patches@kernelci.org, lkft-triage@lists.linaro.org,
 "Pavel Machek" <pavel@denx.de>, "Jon Hunter" <jonathanh@nvidia.com>,
 "Florian Fainelli" <f.fainelli@gmail.com>,
 "Sudip Mukherjee" <sudipm.mukherjee@gmail.com>, rwarsow@gmx.de,
 "Conor Dooley" <conor@kernel.org>, hargar@microsoft.com,
 "Mark Brown" <broonie@kernel.org>, achill@achill.org,
 "Dan Carpenter" <dan.carpenter@linaro.org>, linux-fsdevel@vger.kernel.org,
 linux-block <linux-block@vger.kernel.org>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Benjamin Copeland" <benjamin.copeland@linaro.org>
Message-Id: <e18281db-8d13-4602-b009-97b8e43a07c0@app.fastmail.com>
In-Reply-To: 
 <CA+G9fYvhoeNWOsYMvWRh+BA5dKDkoSRRGBuw5aeFTRzR_ofCvg@mail.gmail.com>
References: <20250930143822.939301999@linuxfoundation.org>
 <CA+G9fYvhoeNWOsYMvWRh+BA5dKDkoSRRGBuw5aeFTRzR_ofCvg@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/122] 5.10.245-rc1 review
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 30, 2025, at 21:27, Naresh Kamboju wrote:
> We are investigating and running bisections.
>
> ### Test log
> tst_test.c:1888: TINFO: === Testing on vfat ===
> tst_test.c:1217: TINFO: Formatting /dev/loop0 with vfat opts='' extra 
> opts=''
> mkfs.vfat: Partitions or virtual mappings on device '/dev/loop0', not
> making filesystem (use -I to override)
> tst_test.c:1217: TBROK: mkfs.vfat failed with exit code 1

The error message indicates that the loop device contains
existing data and mkfs.vfat refuses to overwrite it, which
would be part of your test environment.

Can you try adding the suggested '-I' flag to the mkfs.vfat
invocation so it overrides the warning?

    Arnd

