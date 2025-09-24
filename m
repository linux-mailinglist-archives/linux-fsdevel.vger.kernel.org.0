Return-Path: <linux-fsdevel+bounces-62671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC79B9C3D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 23:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6C7326C4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 21:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981202848BE;
	Wed, 24 Sep 2025 21:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="cJv7J9s9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="avkTrV0y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C445153BED
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 21:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758748165; cv=none; b=Th18/0PeR0cOWbr0UbKuSy1JdY/xnjgdD+iITJaKYqETk4rAYtA7GriLYt8EjUMPTvmHNttC1fPXGr1xF78LHrqwdw2nKKqsZvCkdnOAhe2XfomAhmXsBfgFso6YSMGJiYWSEIRmQN+4D5sXbvb7ud06+gtMmZYxsZMV0l3qopk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758748165; c=relaxed/simple;
	bh=E7KppVK9/PQfWEoQ7zrc2rC1chtqVLh8qqO2fRkQjKM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JG0Ek4i6RBnpvbWLW/wioRql5UHSGHO+lO00V7ThrYKrMpoK/dat3xuVIHVRFRFoCRqGHfk6GSMIrH6jOr7u1VZAOwfWBkMDq4roPgNubk9p+WiC3iOsHxO/nmVnf7UQYKNxC1BmlrgRtuabai9vq+Tg2GJe9JQMvKq6KnXbnOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=cJv7J9s9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=avkTrV0y; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 40AD17A0187;
	Wed, 24 Sep 2025 17:09:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 24 Sep 2025 17:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758748162;
	 x=1758834562; bh=Qtmf+uXuVNLvFuim22IQZnCZCaCfp3Om0prwH1n81WY=; b=
	cJv7J9s9687sXoIrfEUSyNMoOMAIQPEh7rlCWs2eRKdAPoKeJpg5o6JQEF6Dg5my
	o6SDKQ6JTzdFZDu3CC55d65NzpiAXmqzsASJS1rvw+tXuqUwAZRIU4oROLFD7Ya9
	FZshQmHzyz4iDaVZNYYITFRX+dLxQ2m+6ER/EB1e/6ZBK0clvZvpHq2FOzT2CXyK
	4pbfU/yQbZxZJtuSmr4J/oxB1Y3ISOe3WGg9tTdPQpeWTG/H8cvhMWL4py6kZmW+
	bHf+rgGz/36O2Xa10lmMM2CkRatbADBaWFqiqu/V0/re11+ko085UuN2grVLSfy/
	F5JYznx7uPSbv5u1m7KO+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758748162; x=
	1758834562; bh=Qtmf+uXuVNLvFuim22IQZnCZCaCfp3Om0prwH1n81WY=; b=a
	vkTrV0yV5er0CNW6b0199D9DiDTakz3VaPYHM6upcqeX8BEoQGlEvC3Q58CX63CV
	OThYlmM+MunWo2xKCIfpcAOQg2lvW1XyQzwopA89n8kS9rqTyczdqOQC9x0V3ZK8
	NSRX/7ehvb3tjRrXEhn7wj8HJnAXi/fX563XNi2TOc8ngKRqUiGm3YQXZJkAbXGg
	/SNFMb+wlrSX8g5A+PU/djTsXrCBW3eswBK3xXF7uy2+81mcmcwQ0n4/x2dh7MQz
	vxw9F6LqzGq07Isc6vlF/8i1lGDvRD6p07/bdbr1YnPlT4Msk/cYicXglxxShSjW
	WNTID0fYSn3XLrQYSSgdg==
X-ME-Sender: <xms:AV7UaOxYArM0h0WaXTvgiKcNEg2-aR7ru6PJbAmRjckeWriBGUmGbg>
    <xme:AV7UaASEB87-po0ptA0MVhUlX7CzqXjxB5Ro6BxVzeyQ0KfSCuCH8qHlxohQJrEPn
    ahyScETEIjgd9SmNGeMJtRdP5LlZ8DQgakgGs95yNqjxAD_ehBgvw>
X-ME-Received: <xmr:AV7UaN_Dx9n-ZyQq_kCaysODHQFQRtO-29kvLjYCTRcMSModSum8U7KqCgHHwLakRatDGumwTVWsimxAbLr4tssPaMNLVCaZ-iGZ-xNNbBQXZpRKXS7c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigeeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepkfffgggfuffhvfevfhgjtgfgsehtjeertd
    dtvdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgusegsshgs
    vghrnhgurdgtohhmqeenucggtffrrghtthgvrhhnpedvgeekvdelvdelfeelheeiveetue
    dvveefgedtleeggeffuedugfelieekvdehheenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepuggthhhgvddttddtsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:AV7UaPoId0_RSQwkygwxT5jmq_HcLY34SVAe6Sc0gGOavw_Rkx4RMQ>
    <xmx:AV7UaCns_cNxIrM9yQFLEak5IaVRJmgYpnGEPcNhtLR4-wcEwBye_A>
    <xmx:AV7UaOJOrna7oHgnmkD327x1LEcv1IwixZq6P7GTkiTYa2oQ3W0N2g>
    <xmx:AV7UaPxUA7NiUO0b3zQNxFM2Eh2prz9ZeKdsQ-nlobLiLk6E7MMmHA>
    <xmx:Al7UaKgCMPqfPn7-RheL86aYnFp-ChChj16sTOtWyHqNoss0GIKheRpr>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 17:09:21 -0400 (EDT)
Message-ID: <fb7bc595-bbc6-42b0-a16c-acc79f59cbee@bsbernd.com>
Date: Wed, 24 Sep 2025 23:09:20 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fuse over io_uring mode cannot handle iodepth > 1 case properly
 like the default mode
From: Bernd Schubert <bernd@bsbernd.com>
To: Gang He <dchg2000@gmail.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <CAGmFzScM+UFXCuw5F3B3rZ8iFFyZxwSwBHJD6XwPnHVtqr5JMg@mail.gmail.com>
 <E1CDDCDF-0461-4522-985E-07EF212FE927@bsbernd.com>
 <CAGmFzSe+Qcpmtrav_LUxJtehwXQ3K=5Srd1Y2mvs4Y-k7m05zQ@mail.gmail.com>
 <5f63c8e3-c246-442a-a3a6-d455c0ee9302@bsbernd.com>
 <CAGmFzSe66awps9Tbnzex3J8Tn18Q6aEVF3uJnwJfVAsn36_yrg@mail.gmail.com>
 <CAGmFzSdD71SxAxCJp5BbJZ7-JVARtoDPPScGvxhTF=+HQ+D6jw@mail.gmail.com>
 <dbb91af0-ef9d-4a17-852e-ffaa1c759661@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <dbb91af0-ef9d-4a17-852e-ffaa1c759661@bsbernd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/25 10:38, Bernd Schubert wrote:
> [Added back fsdevel into CC]
> 

I'm getting there, upcoming patch as part of the queue reduction series:

fuse: {io-uring} Queue background requests on a different core

Running background IO on a different core makes quite a difference.

fio --directory=/tmp/dest --name=iops.\$jobnum --rw=randread \
--bs=4k --size=1G --numjobs=1 --iodepth=4 --time_based\
--runtime=30s --group_reporting --ioengine=io_uring\
 --direct=1

unpatched
   READ: bw=272MiB/s (285MB/s), 272MiB/s-272MiB/s (285MB/s-285MB/s) ...

patched
Run status group 0 (all jobs):
   READ: bw=674MiB/s (707MB/s), 674MiB/s-674MiB/s (707MB/s-707MB/s) ...


fuse-over-io-uring RFC v1 and v2 versions had

https://lore.kernel.org/all/20240529-fuse-uring-for-6-9-rfc2-out-v1-17-d149476b1d65@ddn.com/

I dropped it on request as was an optimization hack. I had
planned to add it back earlier, but was totally occupied
from January to beginning of September...



Thanks,
Bernd

