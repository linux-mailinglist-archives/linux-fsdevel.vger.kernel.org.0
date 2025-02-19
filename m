Return-Path: <linux-fsdevel+bounces-42120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434C0A3C990
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 21:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F400916EE71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 20:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CA522E015;
	Wed, 19 Feb 2025 20:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="XMo8GcQp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GjUm8TgK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9891BE251
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 20:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996545; cv=none; b=qrXLggB43O77x+nodW6+c34z3haTOK/+NT0dDeWLgcGSobOoUsmPnPWD0WCISUCLjhwlSKci4DaZ8XhxiXc2cHTIQYoeFrPdC2Grtw1Qym2mQ6Dem1PLjHiNsv1RJOVlaVgKwqbCZsr7ZnMpXRNcIUIFZNa35SMoEgZwexGWSWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996545; c=relaxed/simple;
	bh=XlhlOn4++ghzCENHnkD2+xphWGtySOB2YHR3aJBRKBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sIclHHhmLJwqSwY2txHZO2NjsKElyqAWBhYuBO8P7oM3+xf9TAL6ivX5UHkvZREJt5Vc3gUlSrceaQpm4zRO7GJ5HXxUVLPY0S1Jp+zHuIFV2tf6QCN5C+B/5f0BC3xjuHfv87NAvh85tkhV6qhQQNRoYECYp4BtmdOclWlzmPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=XMo8GcQp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GjUm8TgK; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CDAB425401E9;
	Wed, 19 Feb 2025 15:22:21 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 19 Feb 2025 15:22:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1739996541;
	 x=1740082941; bh=QbH4FKHLm+zvxOAh9YtPTLNSBGRbYMUiXMmKvQxzii8=; b=
	XMo8GcQp8xGuGThCVI7GoB52GB6oqqwFTTOTqhSWrKnQWJXbsviG8qbjkejsisjY
	n6AiSqrTEEeuhYDx2d2XwM7w0F0pDac+KYdhYP31ocbS/r6omEksVW3Ri4Korkjq
	0zi/Tl1JD9bet9CcjLxfF0OBim7Y+pSE7zXWZ+uh3aOgjCplF4DUzxVMUe9s8dpT
	kDKE0ZgswIjDKmWqowmsEIIbob4GM15TFqGgvtXBiLnSE0x0H7dJSSJYqRU6RBHS
	WRuSMZy87VINA9VZ3z5vLvIM76tE2e5Q4cb7pnZ6RgjTGgr0NE+gwJzgGi6MnuhB
	voqMtTAxGDz29HIiwqxRKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739996541; x=
	1740082941; bh=QbH4FKHLm+zvxOAh9YtPTLNSBGRbYMUiXMmKvQxzii8=; b=G
	jUm8TgKmDhcP2ntJGm78SnDcIPCVNsC7JFy4wZWlCS41azPjMGTqtQgQynZ8md3P
	fNZg4MgokaUXWw5Tv7DggvnOb2hthrTdXB31RYaQnHo7Cp6lGbbrmChh5UJvb/FY
	Ygpa3cZYo36qr9U92g4yJcSIzCyuHhKcV77XZqZZXFCC9kN1e2kUxl8yPQtd8ufR
	REX1mbFVlucoveLHPL3KMcYZrsoWd9dIH0JYnFamFryTjVlZ2F+E5kFaN7K5qIg+
	LI2LiG3R9MF2KYIesRHQiQlFG1Qiybt+fjDA46FYO/HxS4Z58rnu9NOjBZoK1FGN
	BHI0NG7BNhxP2xmvA8SIw==
X-ME-Sender: <xms:fD22ZyaAFBNPnB8oMkv4XrgvdbwLu4cti8wQziiSIvI0TD_iJNTyaw>
    <xme:fD22Z1bQ2ukpfKFTk__CcpxABHckcqcUvpwFplyVPBdob7OftynhJq3IysPbbKjDn
    auBMA5-yK2XjIkP>
X-ME-Received: <xmr:fD22Z89QAMRF0aPet70qEXvDwBZPwNgBWwLuVlnT9X-HfNGm3v8OtrwNs5KlKXKyF2zMRxDEtW4lIUmQRq3EVt7e7kbU1haK5NymuJ1LQRRO88ZaR_mP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeihedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddu
    gfdtgfegleefvdehfeeiveejieefveeiteeggffggfeulefgjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepshgrmhgtlhgvfihishesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehfuhhsvgdqug
    gvvhgvlheslhhishhtshdrshhouhhrtggvfhhorhhgvgdrnhgvthdprhgtphhtthhopehl
    rghurhgrrdhprhhomhgsvghrghgvrhestggvrhhnrdgthhdprhgtphhtthhopehlihhnuh
    igqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fD22Z0rOcwKJne5C3ia1fjRuigVP50DoXZAe2GSO1ky9cWeK6KH7Eg>
    <xmx:fD22Z9oVIavy7ap4WqE3K03NoIs-CPgeeUIjya-TSa3Dk9q5ttChDQ>
    <xmx:fD22ZyTGlkhXQ0kJJB7oFE-1Ho-YZGb7v6WzmzDGMJ494dWvrHM43g>
    <xmx:fD22Z9pGBLKmqG5L-fFIvubVpQP96hVF6PmvJc7nGsrL9HxSS-n2QQ>
    <xmx:fT22Z2ANjtnxhd7LQJcIgGSim77nibSrQSpvmH6iES3jH2J5kZyZKMF9>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 15:22:20 -0500 (EST)
Message-ID: <568e942f-7ef9-4a00-a94f-441f156471b1@fastmail.fm>
Date: Wed, 19 Feb 2025 21:22:18 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [fuse-devel] Symlink caching: Updating the target can result in
 corrupted symlinks - kernel issue?
To: Sam Lewis <samclewis@google.com>, miklos@szeredi.hu
Cc: fuse-devel@lists.sourceforge.net, laura.promberger@cern.ch,
 linux-fsdevel@vger.kernel.org
References: <CAJfpegvVtao9OotO3sZopxxkSTkRV-cizpE1r2VtG7xZExZFOQ@mail.gmail.com>
 <20250219195400.1700787-1-samclewis@google.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250219195400.1700787-1-samclewis@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sam,

On 2/19/25 20:54, Sam Lewis wrote:
> Hi Miklos.
> 
> I work at Google on the Android team, and we have a build system that would benefit greatly from the kernel symlink cache. In my testing, I can easily reproduce the truncation using the steps outlined by Laura. I tested your patch and have confirmed it fixes the bug.
> 
> What steps need to be taken to merge your fix? Can I help in any way?

I think we should write tests for all of these fuse specific operations,
ideally probably as part of xfstests.


Thanks,
Bernd

