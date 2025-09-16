Return-Path: <linux-fsdevel+bounces-61752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600ABB598D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07E23ABEB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 14:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE1E315D3B;
	Tue, 16 Sep 2025 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="h9UZICVd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ex8jxbWG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D35228315A;
	Tue, 16 Sep 2025 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031307; cv=none; b=eDeVU2e7izWITcu53KaxHqgNGFklBH4h3VbRCgg+ZaEC8yC4r1E/JSBZZJ5j45PQB3Mr8+6qTEb5diBLh2koAsdC8teA4fuTw0mdYZAh+1fWa8EuGd0zTPztwpAiWt98fZZPelv6d083E+7sc6kuEzAzqHMbSwp5Jxjg5dAP/j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031307; c=relaxed/simple;
	bh=PI1MIx112AMKlNMjgAe/Z6fyJoAYHuhQPgHy2K0We8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BCFOvViJ6tu+E6FWD8fq58hCf4nyXoNn8wAr2JuXqTtJmV3UGhZbg/3PrCygignlLcbhF1wFzWo1bCcAWN9Pj2Fejqy+/h5cjF+O9RGu92MAruy3M/v1fZPTiWrMRB765NALCUvsLz2vcTeb5nx23x+2tZq131LlOilrFoyekL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=h9UZICVd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ex8jxbWG; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4C1847A026A;
	Tue, 16 Sep 2025 10:01:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 16 Sep 2025 10:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758031304;
	 x=1758117704; bh=dUGmtAZGjQCM3ouX0gm59Gepoq8iuPnrmyp5Xovbgdk=; b=
	h9UZICVd+cYisRdI2KY5Oj5PHdGrT9lN5EkaC7kwu/Ij/oXTlZk4vJ6pRX2yYQm5
	sVnqMBkn54RtGbCaWfoTHSE9rTf6XURIFQjC9EIXU28tu9x/P42Es4Lb1zRp8GIi
	AsmXHhKD8X5suGQLHR+opc4tNDx5XlKFb5x2v1Lb4Kww8t/ej0NcSd+x73soBr1C
	7baQI4k7lld8ztg7zD9Oe0Sr0TZhOsz2I7tsJatSUzUH/ffMPA1I4XpFVpF4pWwR
	5q9tWc6IFmGaiYk7icFeM+ogFV5y2oBvgbTAC7q7b+SxDvuNbvdjVPE2LJmxNwb8
	MP0M7kmYztNFaFKvJAh3qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758031304; x=
	1758117704; bh=dUGmtAZGjQCM3ouX0gm59Gepoq8iuPnrmyp5Xovbgdk=; b=E
	x8jxbWGEYY/ZWIcV10f4Fflz4CGM8f4RUeqVOdeFsJYrnU2iP1dekhCEH2wChobR
	Mkyaph8M5rzFcI3SYitoAb1CazKihfh3U7e1plxR58uD7FWbtu44Lz/foEgCSfNd
	lJW0B7Tzll2Spk4IGDLJjXkjL6ovN6yg/KhhHDIL8IKqz4w+0RrG2Gjd4bpTnAfF
	cCfKWkmEivxti/QFkWTTYlEmGTubf2k7Pl0+bPbbtwPEVQF8xaPBFhEUQMZ/pH+Z
	EIeR35iTmlRVF9HleLSEAx4SGz0SNKZd86nH5uaENNtFBPNRod81eAQMsFZdZl96
	K+k6avxVvWCzLuYJggR4A==
X-ME-Sender: <xms:x23JaNa3R8Zr8Tgg4B7zzJYD9Ti8VV60J_wFrzqtr9Rbji9ID70K1Q>
    <xme:x23JaAMqwpUEBaAGmVKAm2R5pETjlo8RJtArgI72mnHCYtML4w5Jk6jySAgYlXEtN
    XctlH2Ot_iiYRC1n-Y>
X-ME-Received: <xmr:x23JaGa5laVJ89-BHAn5ZHonQeOkW9laaUo71btf6I1iuqOy9aNyjmUmtI2ahoZuv2Yaaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegtdejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeduke
    evhfegvedvveeihedvvdeghfeglefgudegfeetvdekiefgledtheeggefhgfenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrshhmrgguvghushestghouggvfihrvggtkhdrohhrghdprhgtphhtthhopehlih
    hnuhigpghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhrtghpthhtohepmhhitgesughi
    ghhikhhougdrnhgvthdprhgtphhtthhopegvrhhitghvhheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhutghhohesihhonhhkohhvrdhnvghtpdhrtghpthhtohepvhelfhhs
    sehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepghhnohgrtghksehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgv
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtg
    ii
X-ME-Proxy: <xmx:x23JaIWZhPdklPBCYuGeYT-hAZ18TeVqb6Dt3k08Mf-c7z3LO3ZxEg>
    <xmx:x23JaNBOqZUv26gUpxA5gv6gYOJpT0AbYY4SOaqzElzm6DNNjy47Ug>
    <xmx:x23JaMLeiD4TkaYgkvKM6La-BH9D1qz53DWidsqvs2CyyXf7eHwF_A>
    <xmx:x23JaDv00oVs2gNCOIHrxAJZprZp8_PDQ6_4nmv40ExZbmD05DpTaw>
    <xmx:yG3JaKwML17l4D9Vrk4fZwLr0H7fJKihD9fhtMbGj-j55Fyhcf74N9ku>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 10:01:41 -0400 (EDT)
Message-ID: <a98c14f5-4b28-4f7b-86a2-94e3d66bbf26@maowtm.org>
Date: Tue, 16 Sep 2025 15:01:40 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] fs/9p: Reuse inode based on path (in addition to
 qid)
To: Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, v9fs@lists.linux.dev, =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack@google.com>, linux-security-module@vger.kernel.org,
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
 Matthew Bobrowski <repnop@google.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
References: <aMih5XYYrpP559de@codewreck.org>
 <6502db0c-17ed-4644-a744-bb0553174541@maowtm.org>
 <aMlnpz7TrbXuL0mc@codewreck.org>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <aMlnpz7TrbXuL0mc@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/16/25 14:35, Dominique Martinet wrote:
> Tingmao Wang wrote on Tue, Sep 16, 2025 at 01:44:27PM +0100:
>> [...]
>>
>> Note that in discussion with Mickaël (maintainer of Landlock) he indicated
>> that he would be comfortable for Landlock to track a qid, instead of
>> holding a inode, specifically for 9pfs.
> 
> Yes, I saw that, but what you pointed out about qid reuse make me
> somewhat uncomfortable with that direction -- you could allow a
> directory, delete it, create a new one somewhere else and if the
> underlying fs reuse the same inode number the rule would allow an
> intended directory instead so I'd rather not rely on qid for this
> either.
> But if you think that's not a problem in practice (because e.g. landlock
> would somehow detect the dir got deleted or another good reason it's not
> a problem) then I agree it's probably the simplest way forward
> implementation-wise.
> 

Sorry, I forgot to add that this idea would also involve Landlock holding
a reference to the fid (or dentry, but that's problematic due to breaking
unmount unless we can have a new hook) to keep the file open on the host
side so that the qid won't be reused (ignoring collisions caused by
different filesystems mounted under one 9pfs export when multidev mapping
is not enabled)

(There's the separate issue of QEMU not seemingly keeping a directory open
on the host when the guest has a fid to it tho.  I checked that if the dir
is renamed on the host side, any process in the guest that has a fd to it
(checked via cd in a shell) will not be able to use that fd to read it
anymore.  This also means that another directory might be created with the
same qid.path)

(I've not looked at the code yet but Christian, feel free to point out if
I missed anything or if you disagree :) didn't realize earlier you're also
the recent author of the 9pfs server in QEMU)

