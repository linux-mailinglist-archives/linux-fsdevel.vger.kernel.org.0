Return-Path: <linux-fsdevel+bounces-29196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFB4976FC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 19:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908191C23E64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 17:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CE11BE25C;
	Thu, 12 Sep 2024 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="bN2UIqIh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vy8MxjSQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74DA149C50
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726163289; cv=none; b=NNI1TNmEYBrjzVBiRdGpAlG3VrN+8iuBHq47EdP/mmXxF5Odu2bAT5uUxMgPulgOR5dO13f2dJwWynKQ+005Xzof/ep3aD1cJAidRxp/c0fgJmZnzRnrJJNkvESlI5mhK5nxqVSvjGPYOIiPrH/twemiPyYBf2HkCwT8aHGC1bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726163289; c=relaxed/simple;
	bh=bTsddMKqW7QLri/twCTzHOX1T1ZXWMvinPgrmy31nZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubWPVkJHP42O+LJTPlm2taWktDVPiTPa8eYw5YQSUD8RAZ/bldnqboE5zmIW6/FYbhpCnIDOMFEvZrx+zfFpPDa+TLPBR3DXu2L7oxqhJMN+BglKWsZetXPAss7YGqNuZOGY4BeLXyDYMzxibnix6JeVhYPLVjP9br2v/KL9FAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=bN2UIqIh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vy8MxjSQ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id DAE3813800E3;
	Thu, 12 Sep 2024 13:48:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 12 Sep 2024 13:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1726163286;
	 x=1726249686; bh=WapS79isIRfe9UIdo1SIp8bjO6Vvx91dNU7fPSXtw/4=; b=
	bN2UIqIhetqvJpgLZm1nV4BaYoxURoKgz3FRc9DVX9ulADdDIHpk3VnsNgBPNxrg
	nfL+Ew/ZHD5JOtbj7y9alzg4G/tN8q0P6rGJtuepVhpbtQ46SQhDZ8Xrr6jzOT5W
	yd/Cqyq26yCHbRC7+hLnXTc+L1lykWr0lO1GheHonIZ9OeeJuaagsKbC8NyG7Sjn
	QE0fOnJ2a0vgbTTSn1a4ASVOhNWt5+nNyRIPGdH4Kvn+3lxVO0Km44dPqbBC6K+s
	aBLqZshDoVtYXWo1Y/SbMIiGpPVOHvNViM+9Q1ne5FFesKyCH433hNBMxbb4mQKB
	vYSc0jsGR1iktp/RHCWtTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726163286; x=
	1726249686; bh=WapS79isIRfe9UIdo1SIp8bjO6Vvx91dNU7fPSXtw/4=; b=V
	y8MxjSQTLgQKCNTM81wXxGq04bVadOxdoaB0910/6E0RlF3kipLCxHiBCX/GEVxl
	CLjLaZZyRDNz10MkXukYgG0rw1Ydw0xin8oChwLPIS+o0q/hlkP4IDaw/ZWwbWCf
	ketu/ZItUDnfZhtG+0O89zUBD0LkabSeVZIEe5br3SCh97SebGsLqU4Ub+xxmn9C
	1I/JH54xkD59jyx2euWGOCNZTfchQlB/rfWoqZBU6izwfCd8tegiP/BtU41e847p
	QAPeoZuY9Ow6SGnGujIZXdxclgmChQn2xx1AHiZ4LScbtnLSUIpEOMkQuJ0xEN4w
	MXNGy2N6MjaY6eu7iXNAw==
X-ME-Sender: <xms:VinjZsFS4CEXkdYm7CwL_z0QsyX2RZrZWXzovFtvNuTCXPCYwPjm5Q>
    <xme:VinjZlW-vuZ-BhpMSMDZl13C8EA29ecUjs1fBBCflh-He11d517ArmPbRUhymeygZ
    tdTiawzUcjD4aN0>
X-ME-Received: <xmr:VinjZmLA88F368R7wyem8NHM_abP5m3MXDv2ZyusxCk2p2dwQYzA2T9n0KqMsoTTdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedguddulecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:VinjZuFh3C5EVMwcw1ElL4CAalMaptJW8x-KHhNdJuAjcU4HwDJ7KQ>
    <xmx:VinjZiWXdYkfNoLRN7MYQ6qaKpegeAJCcdAs2sWK5qbDzf3hGv4wNQ>
    <xmx:VinjZhM13xnM6UxO7dKPhPM8LSdb5oA7FY9SduGl6_CFJPblFezBMA>
    <xmx:VinjZp082mcqodt-uNe--SfvZJEmR_nKPUF1cTJIiJ3QWmMZk-ohlQ>
    <xmx:VinjZgziaYlpQrk0_d8L89_2tSpurVs4MgHcfiIxE7R7ghdSU3UlvghD>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 13:48:05 -0400 (EDT)
Message-ID: <517adc6f-5d21-450a-9080-08a1fad4a1c8@fastmail.fm>
Date: Thu, 12 Sep 2024 19:48:04 +0200
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
 <CAOw_e7bR8xHbCrcv4x9P=XbE4nXcjiCkpiuxV4waS-i7QK=82A@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US
In-Reply-To: <CAOw_e7bR8xHbCrcv4x9P=XbE4nXcjiCkpiuxV4waS-i7QK=82A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/12/24 19:26, Han-Wen Nienhuys wrote:
> On Wed, Sep 11, 2024 at 3:06 PM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>> Do you know how old this behavior is? It would be great to not have to
>>> write the kludge on my side, but if it has been out there for a long
>>> time, I can't pretend the problem doesn't exist once it is fixed, as
>>> it will still crop up if folks run things on older kernels. The
>>> runtime for Go has been issuing SIGURG for preempted goroutines since
>>> ~2020.
>>
>> Following git history, I think introduced here
>>
>> commit 1f60fbe7274918adb8db2f616e321890730ab7e3
>> Author: Theodore Ts'o <tytso@mit.edu>
>> Date:   Sat Apr 23 22:50:07 2016 -0400
>>
>>      ext4: allow readdir()'s of large empty directories to be interrupted
> 
> Could the same behavior happen for readdir, or is only readdirplus affected?
> 

Should be the same, it calls fuse_emit(), which calls into the filldir 
functions in fs/readdir.c.

A way out might be a cached readdir (FOPEN_CACHE_DIR) as the entries do 
not get lost.


Bernd

