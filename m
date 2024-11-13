Return-Path: <linux-fsdevel+bounces-34617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFD89C6C76
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 11:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F07D1F22F11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 10:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DE41FB89B;
	Wed, 13 Nov 2024 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b="qdOO4D4c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YomG/OEf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565951FB894;
	Wed, 13 Nov 2024 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492713; cv=none; b=Ab/7h9o/1keNBjpBxuFjUkUi/GCqCd5BMzuIGMqn4ccNS9z1nPWXDD/O3l9Shz55Ko7SuLadXfIminClJJQY80aKLd77WVu3PT+pBgUDYaXmI9vZ/87/pGk+Q84aNqnBv5Aw1esl+xB0SPrjdH/e5WkRAFNvSpSHQO5P8XbmD4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492713; c=relaxed/simple;
	bh=JREQOrJEy7b2WjqtlLkWenU3Sdrz5psDXOHswTCHJjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sATfvbOgaaPLgABQ6kn4phJC0BSJpeBXGK0Dw7gM664SzYr1k6j0WdQUutdVH4kl5Meg8cA6WBokZnIZQVbjyxTCzH+r5LwUqb6qYVU3knFok7kDXugUtqWdYcZKZFkSZNaHobf2ICvIR5GKM9UCSKKT3/xiFOqr+Jfw/3/Lp7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu; spf=pass smtp.mailfrom=e43.eu; dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b=qdOO4D4c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YomG/OEf; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e43.eu
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 6B11D114013A;
	Wed, 13 Nov 2024 05:11:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 13 Nov 2024 05:11:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=e43.eu; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731492710;
	 x=1731579110; bh=UydUylDYGNp4XMXqdQ1Jqh38XzDVngg2qZK4Az7KcHI=; b=
	qdOO4D4c/LBNjmceoNyxXsh47sTdOrmXVlGzHstYJKIO3SsFahfRyJccct3aoWnn
	lIw/kkmck0mypTWA7K9I6ho1Ojn+EnTBbHFd7pDI2hP/kXTLhX7/pGAYsv2zWMDf
	uPuip14eH5Ne+9KWzhPyUPqAfzveTLpm8KeT6bRFKHiCMUriY9kBLqnVbaAye2ym
	USNiQhQox+cLrIwXnQXjzWaTbeIlvUJtPnjj21Eq4vcHkQlcdRcSPCwaSMEDAk60
	uFxEgA9hwnf/RNiIurZU1eYZmribjd0/gqJsRZqWUt38ztjzP4NcDA61Wj/fCh6B
	yDULTA0PkGDh3Cf524D+XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731492710; x=
	1731579110; bh=UydUylDYGNp4XMXqdQ1Jqh38XzDVngg2qZK4Az7KcHI=; b=Y
	omG/OEfitVFLEP2RKHVtCqJ8/n22skxyUhj7LIR1dKNO6gjJos7vhRdcESLAfiV5
	lPd+KrTRjWRdma3qLHOF03Dfg7s3NLocu2d8r4cLSQsMuuHRAxocMYrFUsUEkMsl
	NFPON+smM58faoBM3xjvIxvjTuh+ej6Beswao7yjJF5/OWHfDGK9y9feO0DaD+mI
	UrcDNUt5JalfDt2z/gxU1kmzS846irxpKDAVEHjsQ6Vtri7TusE9LYamjzwhc8+y
	ioz1LyjOrVqk0FjVtMTceCCMHM5oxNls9KPi7JNTeqE+sub2foZX6N2HTGSHQqjd
	tz2quLEtzD7WEVRQOsrzw==
X-ME-Sender: <xms:Zns0ZyuD52dfZtSImMIRsNeo_Y7eAzD0k5oKcPf97751FXssaaop5Q>
    <xme:Zns0Z3eXBbuBH06LaeS8XNXsyLqxLMULngThouE5ePawSY6xk111Kbv8j1qUGNa3V
    ZSBJhp95bm9E4DppiY>
X-ME-Received: <xmr:Zns0Z9y_inKSQbFe_q7yoK1QFhm_jn8PG5iZF2UFq9RrFSiJMEO1wybfSL4SWwzdKMO0OAsMOdjLRNsw01u20jKDgNb5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddtgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeen
    ucfhrhhomhepgfhrihhnucfuhhgvphhhvghrugcuoegvrhhinhdrshhhvghphhgvrhguse
    gvgeefrdgvuheqnecuggftrfgrthhtvghrnhepjeeftdelheduueetjeehvdefhfefvddv
    ieekleejfeevffdtheduheejledvfedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepvghrihhnrdhshhgvphhhvghrugesvgegfedrvghupdhn
    sggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrmhhirh
    ejfehilhesghhmrghilhdrtghomhdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhessghrrghunhgvrhdrih
    hopdhrtghpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphhtthho
    pegslhhutggrseguvggsihgrnhdrohhrgh
X-ME-Proxy: <xmx:Zns0Z9PEJlni2gwWahpwUok4temgE5N3tmSo4ze4F2f7hYOz1iwhSw>
    <xmx:Zns0Zy8kH3NYLlAyvxSNRUDK2RTrB-y7zY8ZQlotPD-6bMrsWOOBtQ>
    <xmx:Zns0Z1U-_5zmlJxzj3_7RWIsrcOqZ-Qw2Vhfbv-bkgBR4MrDD74ilg>
    <xmx:Zns0Z7d5p8m2AxE9pbB97GeR7kfdQI-Vw0TXH2yRfVlOkk03ff3GIg>
    <xmx:Zns0Z3Pt77uJF9LhZe_D5z0zM0QLzvSC4jL2uC4PhMoXWFB-jvX7Zo8W>
Feedback-ID: i313944f9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 05:11:48 -0500 (EST)
Message-ID: <ed210bc9-f257-4cbd-afba-b4019baaf71f@e43.eu>
Date: Wed, 13 Nov 2024 11:11:47 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] pidfs: implement fh_to_dentry
Content-Language: en-GB
To: Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 christian@brauner.io, paul@paul-moore.com, bluca@debian.org
References: <20241101135452.19359-1-erin.shepherd@e43.eu>
 <20241101135452.19359-5-erin.shepherd@e43.eu>
 <08d15335925b4fa70467546dd7c08c4e23918220.camel@kernel.org>
 <CAOQ4uxg96V3FBpnn0JvPFvqjK8_R=4gHbJjTPVTxDPzyns52hw@mail.gmail.com>
From: Erin Shepherd <erin.shepherd@e43.eu>
In-Reply-To: <CAOQ4uxg96V3FBpnn0JvPFvqjK8_R=4gHbJjTPVTxDPzyns52hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/11/2024 09:01, Amir Goldstein wrote:

> I don't like playing pseudo cryptographic games, we are not
> crypto experts so we are bound to lose in this game.

I agree. It would be one thing to obfusficate things in order to prevent
userspace from relying upon something that's not ABI; it would be another
to do so with the intent of hiding data. If we wanted to do that, we'd
need to actually encrypt the PID (with e.g. AES-CTR(key, iv=inode_nr))

> My thinking is the other way around -
> - encode FILEID_INO32_GEN with pid_nr + i_generation
> - pid_nr is obviously not unique across pidns and reusable
>   but that makes it just like i_ino across filesystems
> - the resulting file handle is thus usable only in the pidns where
>   it was encoded - is that a bad thing?
>
> Erin,
>
> You write that "To ensure file handles are invariant and can move
> between pid namespaces, we stash a pid from the initial namespace
> inside the file handle."
>
> Why is it a requirement for userspace that pidfs file handles are
> invariant to pidns?

I don't think it's a requirement, but I do think its useful - it is nice if
a service inside a pidns can pass you a file handle and you can restore it and
things are fine (consider also handles stored on the filesystem, as a better
analog for PID files)

But I too was uncertain about exposing root namespace PIDs to containers. I
have no objections to limiting restore of file handles to the same pid ns -
though I think we should defnitely document that such a limitation may be
lifted in the future.

- Erin


