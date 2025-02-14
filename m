Return-Path: <linux-fsdevel+bounces-41739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC99A363BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 17:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11FC1704C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 16:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617C0267AEA;
	Fri, 14 Feb 2025 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="eVJFrAhC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rJStk9Ar"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAFF262816
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739552329; cv=none; b=Gm6NnyAktSJvYeMP6K0y+zZHq3aKYqNYa0eOvyeHCINIfKYMrpp48JPVysp9MTQ4UqJifjA/u6kyL3SoG2qJr3fAHrJ2nKb+KWqmCwfKDPxdzgyiwNchBeBcyOu/vBFciP0UibYmDrz2sY9SpjGJUJQqBl3hq3DB+5+Y8DvWIl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739552329; c=relaxed/simple;
	bh=c9iYgnTRGe8TsMtAR+o7KLJ5sm6uGOW5KwQDPti28Kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XX8fgHv4lkbLBS/1NS0xP2T9h1bDvCqHcEzDMtbpqORepo/52xO36CO4MLVPhpcGOyRTDorSeLXfpEHZx3xj3ZCLBz/PxlvShmSHKEvP5pv13lGEJffghrHQwwhwVAnP7QYjhdRqvU8LYfSdodeiAaC7oJ0lk61n+cqrrHKppN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=eVJFrAhC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rJStk9Ar; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 8758C1380167;
	Fri, 14 Feb 2025 11:58:45 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 14 Feb 2025 11:58:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739552325;
	 x=1739638725; bh=W49os1SN4YhxHnRCHL0p1oWRzCpSwmJqxsb9XXuhQ+c=; b=
	eVJFrAhC8pn/0Yy766RB4qYoJU0YGKEKJYlopMHi0w8JbG0ymuIxUbaD8IIzdDM7
	Zbbe4JH9acJe9xVmMVmf9ZfRR5ESfaIh8l9jpTuaX+eoL1PLElukdtuAD0AuARI7
	TRVkzLhFPZ8WUFTD9num/L66GK7e8BNHdshQoGvDmxUI5cGfDEh+vzILTCqkJOrf
	3PLOuxrtJU7uNPbbUpacW8LPVj+ZbCqBqn09wMs1DKw1lfl9kjdVmLXdaRtfh0AA
	GmFSQ0wjZERgBAkbTyXUG2zTOnXht+rOfI2aXcSelBtsqaCdzuP2BFU0zrI1i6R4
	7wownVC+msEjKieLc8dJmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739552325; x=
	1739638725; bh=W49os1SN4YhxHnRCHL0p1oWRzCpSwmJqxsb9XXuhQ+c=; b=r
	JStk9ArGEC1X6HNIZSquLqeRQVgYHasahXk8qcKb7opsYc5ZsWUvE7iDPpQyeRxR
	Yx5Uy71D4g1luZrn5Eba1C+w6ZPRxHTJ0ZpVPKwpJ+uCF96GjzunN0bhDI8tp19/
	SXlXyi2se5X5oHgk+1N2E37NQIXRkF3qBpd3vKR+I/H6nbkSu1bu97efmZ5Rr0mH
	nIERwMLdMILjGZ1MfbbRKxE8ObNQY42P+wt81cS6Z0YMj8M95niXzyiPSVesZxyh
	w2+2uFyGQkLteNUoV1/Nife4axcbhry0RoZCTzpzO34BlzlCcqtouIfNm8PmCTUE
	76Bb3gfTieXYIn+K+AcWQ==
X-ME-Sender: <xms:RXavZ-fSKapPJ6GlF6_8kQmny17Dpvq3KU0HyzxJhzykqqqdRMUXSQ>
    <xme:RXavZ4NyNA7IfyoGRqHn2pkxNa_l3DOtfNKe8lAXnxX_uv4NRaHtjUNUzqZEbZquf
    dAQdUiKYrh12H9XCAI>
X-ME-Received: <xmr:RXavZ_jLWk2qWnw5yUMmtVs0rx8I2DiRnD6waLf4wjuuutP8bQIEsH0uKQFsQHdeabQWaqFrbicrHQRIen4SFF6lkevn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepgfhrihgtucfurghnuggvvghnuceoshgrnhguvggvnhesshgrnhguvg
    gvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepveeikeeuteefueejtdehfeefvdegffei
    vdejjeelfffhgeegjeeutdejueelhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshgrnhguvggvnhesshgrnhguvggvnhdrnhgvthdpnhgs
    pghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughhohifvg
    hllhhssehrvgguhhgrthdrtghomhdprhgtphhtthhopehsrghnuggvvghnsehrvgguhhgr
    thdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshesshgthhgruhgvrhdruggvvh
X-ME-Proxy: <xmx:RXavZ78UbeBQMbS6lmBhCvwF6ebMBpNIG1C7Z6iBXPOnAJ6HtbHUpQ>
    <xmx:RXavZ6szbY0u2Fg9rWwAVhAlopGMdxGxtoh1ri6dzV4jR5NWgRFPxg>
    <xmx:RXavZyE-dcC905swYz2JsLEYn5yXCUXhHt4mxEGJDG32CZtNtptBlA>
    <xmx:RXavZ5Orxp7DW6beTgulCe10xacMt16p3TVWntKZoALdqWi2-naziw>
    <xmx:RXavZ8L5XErP32BMK3ws_tdu_vi2eSd3puDsD5zyKKwbQHp_bHS9YqIW>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Feb 2025 11:58:44 -0500 (EST)
Message-ID: <0a3f44cb-46f1-4ffe-ba8e-ce7f0cee1bc1@sandeen.net>
Date: Fri, 14 Feb 2025 10:58:44 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] watch_queue: Fix pipe accounting
To: David Howells <dhowells@redhat.com>, Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Lukas Schauer <lukas@schauer.dev>
References: <a8d8f11a-0fea-4b74-893b-905d6ef841e6@redhat.com>
 <b34d5d5f-f936-4781-82d3-6a69fdec9b61@redhat.com>
 <4145092.1739551762@warthog.procyon.org.uk>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <4145092.1739551762@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/14/25 10:49 AM, David Howells wrote:
> Eric Sandeen <sandeen@redhat.com> wrote:
> 
>> -	if (!pipe_has_watch_queue(pipe)) {
>> -		pipe->max_usage = nr_slots;
>> -		pipe->nr_accounted = nr_slots;
>> -	}
>> +	pipe->max_usage = nr_slots;
>> +	pipe->nr_accounted = nr_slots;
> 
> Hmmm...   The pipe ring is supposed to have some spare capacity when used as a
> watch queue so that you can bung at least a few messages into it.

If the pipe has an original number of buffers on it, and
then watch_queue_set_size adjusts that number - where does
the spare capacity come from? Who adds it / where?

Thanks,
-Eric

> David
> 
> 


