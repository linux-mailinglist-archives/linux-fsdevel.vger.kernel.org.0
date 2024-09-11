Return-Path: <linux-fsdevel+bounces-29094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCF1975336
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 15:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 702331C20A77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 13:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F03189F2D;
	Wed, 11 Sep 2024 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="ztAadXUG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NuNkBj4I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3CE187353
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060011; cv=none; b=gcP8SuE7x7grSTxeMBKgF2ZuCrlo3qB5ydRbjOoddYOJdDC14hd4O/cQSBviP6/akqV5FA+H2Uc2KtvWxsEVX48ID8ap8EYRbNdeAkndWjX/j1lGPf0MVvv3HJkQkhFbh5QGsWGVXiFhOjhBBm0oroD/1Wuy5wASmCZJ1nxQwB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060011; c=relaxed/simple;
	bh=nbHSUgw2CFl3g7HmWcANJqDtOhWqYbJkfIKg4pvfHns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WdTOGxCjGwFjkybtsphcKebR5MqvRN2fhzMsu3qnQ6w3hKP5gNDxAwx1fqCqcDizFDgET3vf+p6B07FdeAp17TjWY20fHP1RfMQmrWL+c5gznMUUsKh90B6L1xGpZ2Zhf4mEcTF+npRqIKoVKYD4YDVsMEWLL9ZYApx8aipegrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=ztAadXUG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NuNkBj4I; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 98D1D1380249;
	Wed, 11 Sep 2024 09:06:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 11 Sep 2024 09:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1726060008;
	 x=1726146408; bh=x9wo0z4vFocR7hBvNpt3zt0GEZ7Spka5pEJ4+drPgvw=; b=
	ztAadXUGF3pJ//2psOYPeSJgEqXOUCGmk4Lo9CyF0QldTU4zSfKusvgWJxpOwFNZ
	eEdFSODbt12aBJ0UG7c2UYTN04bsCuLz08xsMsiiilGnXGejHJGePZJ1Kq86UzPN
	T/Ml4szcIafy6/TTzuLGaPdqURP0Uy0jRQ5Io+tXQK/Bzw8I5Eaa6Ba9ii/Zjrli
	ffcy8aBynxI1M2JdwI57Z0f+WxfdmTqKzEFbzAmO9mmeQQpiYEYDodlHs4ww2kjw
	Yzd33t3CrQqRwQ67VFsvQct0h3bDkQpCcFnEwGGhNxP7bSo/eiRYhAGtCuKBOv8d
	7gLs+0VXRPZNrIBEXy3V3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726060008; x=
	1726146408; bh=x9wo0z4vFocR7hBvNpt3zt0GEZ7Spka5pEJ4+drPgvw=; b=N
	uNkBj4I6tlMawDomkatH7ftl5ksRyzvp/5frUdWvtbo3gABLaRBSqkAnLy0b4F8K
	e6QK8H2owUo69l885CNVKdy5zbkPmCJjShNq1pVMSbqfTytcn4qYICXIf/BatURI
	NyfUE49l+xwqKqCKuMYVCkNCPb00Et32XAreQYKVfsjHulVYzGQYnFax+mxXFAGF
	tbecK9FKe5w14vvaJ4gEbkc5wedOqL/mWw3j017rGB5m9FVju1pMIP76YMogvKRR
	uS4VwLJbTswTiCnTG+6Dv7qHUWjmr7geUrZ7TKEV61vH6mE/qWjP6qgBC9JwMjWA
	y1WRmrfuB3XfMn+ttNdfg==
X-ME-Sender: <xms:6JXhZhqphIWctr_8oVex_KtD7o0QPYkvtsUya2SNSf5BwhhGJhD4Rg>
    <xme:6JXhZjp4V8F2CLxzLjLf6ui8jaVogyxbdQljS2jj3F7PTL7P7UAS4ulKaHcOR1Bh5
    Jc5nanhiT_mm4x7>
X-ME-Received: <xmr:6JXhZuOkGgFVZIMtcubauOtOSkzdWGpqPDcHDSN74bFHwKaKy_XPDaqGSQyPEiIVKkSD_aZ5f8ynaGgEXfi9hBngM7o9xUkql2k3rXJ9b7D8YfkJ6lo2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejuddgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepleeffeeljeeijeef
    udehleeltdfgleehueetieetheffjeefvdfghfejfeeiieevnecuffhomhgrihhnpegsoh
    hothhlihhnrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhrghnfigv
    nhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmh
    grihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhu
X-ME-Proxy: <xmx:6JXhZs6So4jHDJeZHLlfFS-IdPVCSVtjRVwNOOgLeGAYwGPrc1-mXw>
    <xmx:6JXhZg5atlki53N3ZLM_3iW_B7KfP6xtSaL9oKUCM94PZFh_uEYLsQ>
    <xmx:6JXhZkiIW7HafVGH8EYViCKq7ynr6HTgC2PFk9DvVZgFz8m9fESq2Q>
    <xmx:6JXhZi5IZ0WrrYXaQXb7qYQh8nptmc7x_qEsETULr3g7p99VOSkQCg>
    <xmx:6JXhZr1uvG3XpaxHe7yD2Ik4xGWxdl72Y20D1uZ0UOzXO3JqAIiklGui>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Sep 2024 09:06:47 -0400 (EDT)
Message-ID: <4f41ae59-cd54-44b4-a201-30aa898ee7f7@fastmail.fm>
Date: Wed, 11 Sep 2024 15:06:46 +0200
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
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAOw_e7aDMOF7orJ5eaPzNyOH8EmzJCB42GojfZmcSnhg_z2sng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/11/24 14:08, Han-Wen Nienhuys wrote:
> On Wed, Sep 11, 2024 at 12:31 PM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>> Ok, it was a bit hard to extract that information. Basically kernel
>> behavior doesn't match your expectations and causes overhead. As I wrote
>> in the evening, I think the behavior comes from static bool filldir64()
>> (or other filldir functions) in fs.readdir.c. Oh, I just notice I had
>> posted the wrong line, correct one should be here
>>
>> https://elixir.bootlin.com/linux/v6.10.9/source/fs/readdir.c#L350
> 
> Ah, I was already wondering, as I couldn't understand why your
> previous code link was relevant.
> 
>> As you can see, that is fs/readdir.c - not fuse alone. And I guess it is
>> right to stop on a pending signal. For me a but surprising that the
>> first entry is still accepted and only then the signal is checked.
> 
> Do you know how old this behavior is? It would be great to not have to
> write the kludge on my side, but if it has been out there for a long
> time, I can't pretend the problem doesn't exist once it is fixed, as
> it will still crop up if folks run things on older kernels. The
> runtime for Go has been issuing SIGURG for preempted goroutines since
> ~2020.

Following git history, I think introduced here

commit 1f60fbe7274918adb8db2f616e321890730ab7e3
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Sat Apr 23 22:50:07 2016 -0400

    ext4: allow readdir()'s of large empty directories to be interrupted


> 
>> One option would be to ignore that signal in userspace before readdir
>> and to reset after that?
> 
> I am not sure what change you are suggesting here. Can you clarify?
> 

I mean SIG_IGN, either at fuse server startup or at set in opendir and
unset in closedir, the latter is rather ugly for multi threaded fuse server.


Bernd

