Return-Path: <linux-fsdevel+bounces-26511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3EA95A402
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 19:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CED61F25B8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 17:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9881B2ED9;
	Wed, 21 Aug 2024 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="n8lCaxEh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eYsRP3qr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C50514E2CB;
	Wed, 21 Aug 2024 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724261909; cv=none; b=ltlUAvzCeVD9ndWyVM0gp+MPwlIBYYN4TciPTG2J+dMQj/B2+IeEMal6mOZqmD4Lbp6L3q5Ki+uYqiGwdY4BDrLEm9ilKEcuJAt/lDy5pgz4D2Tu6+6coK72KGehhKum0drcV1mOeAPdes/Xfx/XPICEvIFCyYy2rR1lM5M350g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724261909; c=relaxed/simple;
	bh=5IOi8iEyNGDv+oLdp1Oiux9zoLB00zn866uexTdEvv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GBHhhd7nTqaQaHMv28lA+TEc+29VsGr77ICIgJ0Eg8z+E+l+kyd2EKZ+CKYaTnbXkOg3GEQSY6qNjsftF1BMB1O/yzS4/FhjyVndAweGJtlEhPwvtS7YSvYHPEl9nLc5QM+YN0vF9X6nW9VPbHy+3B721zUFz+lnx1n4GnrTycQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=n8lCaxEh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eYsRP3qr; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6EFD0138FF6F;
	Wed, 21 Aug 2024 13:38:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 21 Aug 2024 13:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1724261906;
	 x=1724348306; bh=zgzTzsiJWv8g320HvGuSnIto4KTkXMdjjhfH6NawjJk=; b=
	n8lCaxEh8Qyq7/K9q0bdMfPwripzUHAQ+ryVuMjXDSPaW8cJWH3zNSoqrhmsIyz/
	asqSMH6rx6BXuPEiKQQ+UAyMvLcEgqkZfRk8LkZ/gqms+lLn5NLuBKZimARdber1
	sgveNMRlIYGfWa5MsIQ+dPn0BMBhzJEUujz2Qu4MuTQHHAhKo+zGG8fDpRa2PPvK
	t31T+9JNp9MIro4GNdZoHalf6XJ4w8c9yL/mAK5SBPHJpJf6sTHFfMjnUub3BPBh
	/T+qSTFAlo9yTdcr9c8qAw1YvgiXOY6z6BWeHkDMJgpe18zAGPwuybv1cTVIwPxR
	hH9L7r4umQjHDdTjf1BlhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724261906; x=
	1724348306; bh=zgzTzsiJWv8g320HvGuSnIto4KTkXMdjjhfH6NawjJk=; b=e
	YsRP3qrm8YB1F6uGDKVJYJzMXuWv/nBtUaebUDjKYV7bct5tp7BaSovTLd9YZrHy
	6ffUn77+uqC3uxTORdFh4+teV6LIpY+JQWJzUF3XXFMZWVmg8vdynqxCbgJVxLeI
	iFI1NyVSQKf4l+QGLwxB9yFZChF7dzFh+CPkdxmQDyteB1uUz7043C2U1wkD6CJN
	5QYm8zw1oU/YNLbhrUAc1V9rg15ZNgos3ZLoUmv8jPkiJEdU7eKT++hlgDwSCJ1q
	tNZY5UytrJeOra3n3+tezP0bVBALnwvq0JNofqf3vy5pZ5j/ft1OMZUObKA5Zth6
	JNuB+RMRVtClGndw1/1FA==
X-ME-Sender: <xms:EibGZmeFR3G5jvZMy1ZqTPnvRkXSn7mqt4Pbx0_sG9JGZ1suqRCuTA>
    <xme:EibGZgNzOBKlpv8XsFHuef-lv814-c_Lh8872bKf3NcU9v63S12kQufli5hEwVp8e
    g_2bYaOCtvIIkpo>
X-ME-Received: <xmr:EibGZngCghHA_ofn8QeC-oyOfnW5SAmnR8GdSmPpGWWnVVfxhNDZKpeH87wTQKztKZpaxuEAfq-dwPo0I76gWdbaYknFqR3bHHGUeONO8tHwghx-a7nhrjnM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddukedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeffjeevfeefjefg
    hfefhfeiueffffetledtgffhhfdttdefueevledvleetfeevtdenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhrghifhgv
    nhhgrdiguhesshhhohhpvggvrdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsiigvrh
    gvughirdhhuhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:EibGZj9JFt6A6qeEHQAmv-8tZjNr-guwm-7Fsd_XcCTBAsxh90ivJQ>
    <xmx:EibGZiuOo_l_aaLRENwQxAFt-xrGLB77iAlq-Ilh3Opgv7yEMXDYNw>
    <xmx:EibGZqHG6BazPwawcGenVyB_s9ew15g4bNMxq9XuzbPQQqfN2gr1QQ>
    <xmx:EibGZhPKmhBiwk-toX5B0YYGwJzTKnfHfuTQn92c01Hsyl-Z47rAUg>
    <xmx:EibGZkJoJp7e8aFDHLyrWehJT20s8YCg2H-4c8GseC2MVviLrYD4UqAd>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Aug 2024 13:38:25 -0400 (EDT)
Message-ID: <92427273-edeb-42b2-8f3c-5256d5a4b056@fastmail.fm>
Date: Wed, 21 Aug 2024 19:38:23 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] fuse: do not generate interrupt requests for fatal signals
To: Haifeng Xu <haifeng.xu@shopee.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240613040147.329220-1-haifeng.xu@shopee.com>
 <CAJfpegsGOsnqmKT=6_UN=GYPNpVBU2kOjQraTcmD8h4wDr91Ew@mail.gmail.com>
 <a8d0c5da-6935-4d28-9380-68b84b8e6e72@shopee.com>
 <CAJfpegsvzDg6fUy9HGUaR=7x=LdzOet4fowPvcbuOnhj71todg@mail.gmail.com>
 <39f3f4ae-4875-4cd5-ac2e-9a704750eff6@shopee.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <39f3f4ae-4875-4cd5-ac2e-9a704750eff6@shopee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/15/24 14:19, Haifeng Xu wrote:
> 
> 
> On 2024/6/14 18:01, Miklos Szeredi wrote:
>> On Thu, 13 Jun 2024 at 12:44, Haifeng Xu <haifeng.xu@shopee.com> wrote:
>>
>>> So why the client doesn't get woken up?
>>
>> Need to find out what the server (lxcfs) is doing.  Can you do a
>> strace of lxcfs to see the communication on the fuse device?
> 
> ok, I use strace to track one of the server threads. The output
> can be seen in attachment. 
> 
> FD: 6 DIR  /run/lxcfs/controllers/sys/fs/cgroup/
> FD: 7 CHR  /dev/fuse

I had missed that there is an strace output. 
Would it be possible that you describe your issue with all 
details you have? There is a timeout patch now and it would probably solve your issue

https://lore.kernel.org/all/20240813232241.2369855-1-joannelkoong@gmail.com/T/


but Miklos is asking for a motivation. From point of view that fuse server could 
abort requests itself Miklos is absolutely right (the product I'm actually working
on has that...). And one could even add a timeout mechanism to libfuse.
But question to understand your main issue and if there would be a request 
timeout needed.

In general, it would be helpful if you could provide everything you know, already
with the initial patch.
Later on you posted that you use LXCFS, but personally I don't know anything about
it. So it would be good to describe where that actually runs and what you do to trigger
the issue, etc. Details...

Thanks,
Bernd

