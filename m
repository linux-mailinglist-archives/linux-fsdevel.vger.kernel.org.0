Return-Path: <linux-fsdevel+bounces-49963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C79AC6513
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 11:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F1E51BA65FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 09:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CEB2749CB;
	Wed, 28 May 2025 09:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kode54.net header.i=@kode54.net header.b="J+P6ryq+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eIbJAUhi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC481274646;
	Wed, 28 May 2025 09:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748422835; cv=none; b=RVfASOL+y0lipf8rVGreFey0cTFqHHWkHyCP1i1BWoxoHT7Cs/5N7RZeFj9kzNoaRPlGDw/b8WPHTOYyKr9AkpfANkiLGMGZuIxCt67hHl/B0gdPUWucpulKqJlJSVbbJPMxllVr0is3dtdpJlUWGHEJG9hO5Ei2sXlco89rs1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748422835; c=relaxed/simple;
	bh=z6W/IJ2e+qbl9PkcC1h6jlkIMPh1FARrtaYFaS3okqs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UzZbtUk5rZ06ZFY35ADBUZuQb3p0+LnRXNmQbaDN2JG/BCkJlXD+OuSTxvPZawB7Gs59n947hkzdaKEM7Ft/i7L2hOd+xdfGx0B4LnbdYKpSqqq/jc1psDuGv/B+kVHMM0EM1Zltno1M90BVfzOf+C2528FYeMqD+RZuF+KenB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kode54.net; spf=pass smtp.mailfrom=kode54.net; dkim=pass (2048-bit key) header.d=kode54.net header.i=@kode54.net header.b=J+P6ryq+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eIbJAUhi; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kode54.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kode54.net
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id C6B9E1380B08;
	Wed, 28 May 2025 05:00:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 28 May 2025 05:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748422831;
	 x=1748509231; bh=Z1yOxaM2wfMvKI2kVWfHUYbkiPZ7bTZx5z+jZhW1zmw=; b=
	J+P6ryq+XgBkSGADS8inZDprJWswloO7nEtlMXpix6eT51jG9p4g3FINCn02sUe9
	MvD6gyJLHYSdmgCr0ZZPWVG2fvBjmTa4nJeDxzlCzqWwA741z3ob8CsvViLOu7t7
	5dZIMF9z32YbFRBBqH6CsurGRPT10fVhn6LMSNWK4q2cXmkTEgqlweeOBEbNtciP
	ZLpqZpSZ3IGMWMYHTqBS36fGXtLTNcotjI0y1fsrD2ZlRczbQPFOI7kKTFiL2Wwn
	qdUOOPZkWlrIbZ2N5KDuVpCw7lj7Eh9eVKffZNRkidk2FrRDqG8CfBub0PV7Emxm
	cs2/gaIsIKRwwwTyGaS6gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748422831; x=
	1748509231; bh=Z1yOxaM2wfMvKI2kVWfHUYbkiPZ7bTZx5z+jZhW1zmw=; b=e
	IbJAUhiQseVLDs7B308JF56W6tTO8SrEK/DjkDGeSwkBxseO+2Er3VLGXb0SkfIU
	W4S8w8aREdTTANutogr6zBDDjIUjW2TPx3Db1m4es4MGTytDxKuW5E3kkJ7Hywia
	wem/KRZVl9cehB6qVYfeq+T1kblQAytdfQ3EnXj2WOnSjay9FdoEvd3lnZQ+6Vcv
	+ElI1jVYJej7KMOcAGrP6Jf6rXf+d7OIY3b0YncE/bGIjst7GVgr2Yk19GZXF788
	dy+nuwLgi00mkcSUL7HqPUsJRJquzP/er8O7Z6Nms3gY6PAAe289+P18G1BMj5n3
	qCUxE7qOEhDmIwZ0sPzjg==
X-ME-Sender: <xms:rtA2aMDBQJ2j1EwDRAI8TbKCwfvqNydHRzNRuziiVT8JGhNxJgzQ6g>
    <xme:rtA2aOgam4fH8dKn-4x1N4RLiJZwKV3qMX9buenG0HkgJCkdYSlYif_AMQgihUf3t
    8Ger203jxuF-YdtkVA>
X-ME-Received: <xmr:rtA2aPk8dwxb6YufPQzz6hmv21ELdBJj1BxB950mh2pax08B1fc-OpzlsGEXNkQoDn4sbJHnAEMlHEKNXlYmuBgDJoQXexu3qg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvvdekgeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvefu
    hffvofhfjgesthhqredtredtjeenucfhrhhomhepfdevhhhrihhsthhophhhvghrucfunh
    hofihhihhllhdfuceotghhrhhisheskhhouggvheegrdhnvghtqeenucggtffrrghtthgv
    rhhnpeeileetudejffegjeegfffhhffhkeefjefgtddujeehheevleevjeejffekieekve
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhr
    ihhssehkohguvgehgedrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepjhhohhhnsehsthhofhhfvghlrdhorhhgpdhrtghpthhtohep
    khgvnhhtrdhovhgvrhhsthhrvggvtheslhhinhhugidruggvvhdprhgtphhtthhopehtoh
    hrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqsggtrggthhgvfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rtA2aCwY_NeT4DE9OTqJY8rptC2V451djeBMBxTfOLF0AdLUeCQSCA>
    <xmx:rtA2aBSX4SBlWIP-AFjclFMOKYMB4l7Ei2aGeMSezdFGZqErXMYI4A>
    <xmx:rtA2aNbnH82s9MX5q6K4yRAKZ-bOrTocfVBC-1n1g4iMvQQMNm6d2w>
    <xmx:rtA2aKSLxcAXVOZuMjIDQchC1NjET6839D0xgon-LtyzqWnV8twelw>
    <xmx:r9A2aCvP1EHZIVkzUmeUR479AiDabuMllQHbU9Q0Xlc_fwh58kI6eK-e>
Feedback-ID: i9ec6488d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 May 2025 05:00:29 -0400 (EDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 May 2025 02:00:29 -0700
Message-Id: <DA7O5Z6M9D5H.2OX4U4K5YQ7C9@kode54.net>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 <linux-bcachefs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] bcachefs changes for 6.16
From: "Christopher Snowhill" <chris@kode54.net>
To: "John Stoffel" <john@stoffel.org>, "Kent Overstreet"
 <kent.overstreet@linux.dev>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <oxkibsokaa3jw2flrbbzb5brx5ere724f3b2nyr2t5nsqfjw4u@23q3ardus43h> <dmfrgqor3rfvjfmx7bp4m7h7wis4dt5m3kc2d3ilgkg4fb4vem@wytvcdifbcav> <26678.2527.611113.400746@quad.stoffel.home>
In-Reply-To: <26678.2527.611113.400746@quad.stoffel.home>

On Tue May 27, 2025 at 11:52 AM PDT, John Stoffel wrote:
>>>>>> "Kent" =3D=3D Kent Overstreet <kent.overstreet@linux.dev> writes:
>
>> There was a feature request I forgot to mention - New option,
>> 'rebalance_on_ac_only'. Does exactly what the name suggests, quite
>> handy with background compression.
>
> LOL, only if you know what the _ac_ part stands for.  :-)

Would you have suggested perhaps _mains_ ? That may have rang better
with some folks. I suppose, at least.

