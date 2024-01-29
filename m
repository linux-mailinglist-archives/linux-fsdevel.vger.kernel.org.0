Return-Path: <linux-fsdevel+bounces-9373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B8C840592
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 13:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E604D1C22DA5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 12:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF6B679F1;
	Mon, 29 Jan 2024 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="i+4rKc5m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QzaDbg79"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3744D64CD8
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 12:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532474; cv=none; b=FfHM0IfKwJL8VNkL1ucA6VQOueEUMiTHN/rT1jzbX1gczYtzUmmVFX16maYOuBPyOR9VaKMx3w96tQeQSJaOL8Vr7+ul2WbGOjq3Unxyvk2gTRN2/GR/Z7ld0p7Ry5BeLj291g6ZMSNTsxhjOyS859xRD80esTkcWask+Halobw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532474; c=relaxed/simple;
	bh=bqPWOW1sl4x5kal9AJdl/6q6txmwLHCMV0JacX8Av1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwjLqtkbWVfp3H3J9K2sZK0ZJF7pWVeSrYGkpNhuwNxVIDjybHaz5g55d70oCXBkdoJ7vBallrtG0rfknNe+0Wmgq908AOEIL2i+/wXyICxtzrgcio0JCslji0f+o9HPvhfiwOpqGDeYz8t3C52UkuwRR8zPGPgXW0/mz9jRnWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=i+4rKc5m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QzaDbg79; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 4AC705C00D0;
	Mon, 29 Jan 2024 07:47:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 29 Jan 2024 07:47:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1706532470;
	 x=1706618870; bh=E1Jk9+bgomTvcgIQGAbxepx4JGM/edZEgl8Hk8qvKiw=; b=
	i+4rKc5m2GLOrecVJesCBf8CtiY5Am9xFyVMlCZwEsgrpvZDRLH6gZJQF1I7+z4G
	5fVsdKJ7cYOVNFVVL4GrEIxfHDr47/76mXpHY0HLjLUcLQbIC18he1mLEvy0P4y6
	edvI+NDWw3xXFIzCTmNPWLj05foebyWj74mX3fM3Lscfufh875GyJL1etfHFDSwe
	r0j1p1FKVt2+aRtArG1X1+sNpvzOii6pv42t8Smb2qMIh9zGfHutvRWxlTFEH+ct
	jTVUrrJsiwEd2kFBx3pg970IxWR/A46CVQ8RDzZAraf0J74jCJADdGvSZSBnr3fn
	vgH249tg8QGgKNyAiIyqwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706532470; x=
	1706618870; bh=E1Jk9+bgomTvcgIQGAbxepx4JGM/edZEgl8Hk8qvKiw=; b=Q
	zaDbg79HORlez1PulalkfONn9e3iofWe8/djRho+NpIr7gqbnnFixB2n1SmMv3YD
	JrZwlneyCyOI2vJOAtgytD7JzetHFSIHTbPcW+H3hZyZ8JjPuOizGLTJhJDFMCNU
	p9rqdjnv+KwCW6witaJNM/4hX3CxOsVM+sYbSJJ/WWwJlRbHxWIylWerjYGBSxFi
	lY0FYaw6gIrR1lK9ZqnEvw+JVFLAH8HLjGheh6uETFGbF9Olabws3setnBEbTg9t
	KPFLYHeVv9vhW7/EydIaaz4/Ft2bBw+0yif6s53S/UbdG3qz9hEMgn6yG7HpEx0Q
	9xE7a7OkVl5zsSzUBTS+Q==
X-ME-Sender: <xms:dZ63ZT62R-XmvdTj6ZWckr5Inw5mQgYygzdCTb1uvKNvi3lo0iOoIw>
    <xme:dZ63ZY5oYhonwSLHW3KKQXBYjKJbhrAAoFl0GR2XvUos7fLQHTizliG7a7ATLxNPX
    x8_7TK_1V-gkAF_>
X-ME-Received: <xmr:dZ63ZadwHiSLM6-ioT7q_Su9DN6tarMveZ-CMYqLtaSnKurGyZ6cY1FoYeklDyxlegrhRA9mTGGMawBt3R8fpv8M2yAUao9kO_SUFUH8dqpDJwB62l0v>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfgtdfggeelfedvheefieev
    jeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:dZ63ZUJtA6un-uRT6hshv4Ju_SBOUa9bSqjD49j3oA_Wm-hSekScVQ>
    <xmx:dZ63ZXKVuhWSOv7VrixJMG8Km1n-BW3IG036rpRJWnUruheZAA23bg>
    <xmx:dZ63ZdyptATv9Sku63MzMkaYs_yXJwliqPpFHlcZrWES4RQU3WlLfg>
    <xmx:dp63ZUGv5al-kAMsqxJU4NZbc4crN-nVI_pk47YHCDH7Z_oj-8qUqA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 07:47:48 -0500 (EST)
Message-ID: <3435db6c-d073-4e60-adfd-53b2e0797b3c@fastmail.fm>
Date: Mon, 29 Jan 2024 13:47:47 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Future of libfuse maintenance
Content-Language: en-US, de-DE, fr
To: Antonio SJ Musumeci <trapexit@spawn.link>,
 Nikolaus Rath <nikolaus@rath.org>,
 Martin Kaspar via fuse-devel <fuse-devel@lists.sourceforge.net>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
References: <b1603752-5f5b-458f-a77b-2cc678c75dfb@app.fastmail.com>
 <9ed27532-41fd-4818-8420-7b7118ce5c62@fastmail.fm>
 <92efd760-a08c-4cb1-90ab-d1d5ddb42807@spawn.link>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <92efd760-a08c-4cb1-90ab-d1d5ddb42807@spawn.link>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/29/24 13:46, Antonio SJ Musumeci wrote:
> On 1/29/24 03:22, Bernd Schubert wrote:
>> Hi Nikolaus,
>>
>> On 1/29/24 09:56, Nikolaus Rath wrote:
>>> [Resend as text/plain so it doesn't bounce from linux-fsdevel@]
>>>
>>> Hello everyone,
>>>
>>> The time that I have availability for libfuse maintenance is a lot less today than it was a few years ago, and I don't expect that to change.
>>
>> firstly. thanks a lot for your great work over the last years!
>>
>>>
>>> For a while, it has worked reasonably well for other people to submit pull requests that I can review and merge, and for me to make regular releases based on that.
>>>
>>> Recently, I've become increasingly uncomfortable with this. My familiarity with the code and context is getting smaller and smaller, so it takes me more and more time to review pull requests and the quality of my reviews and understanding is decreasing.
>>>
>>> Therefore, I don't think this trajectory is sustainable. It takes too much of my time while adding too little value, and also gives the misleading impression of the state of affairs.
>>>
>>> If anyone has ideas for how libfuse could be maintained, please let me know.
>>>
>>> Currently I see these options:
>>>
>>> 1. Fully automate merge requests and releases, i.e. merge anything that passes unit tests and release every x months (or, more likely, just ask people to download current Git head).
>>
>> Please not, that is quite dangerous. I don't think the tests are
>> perfect, especially with compatibility tests are missing. In principle
>> we would need to get github to run tests on different kernel versions -
>> no idea how to do that.
>>
>>
>>>
>>> 2. Declare it as unmaintained and archive the Github project
>>>
>>> 3. Someone else takes over my role. I'd like this to be someone with a history of contributions though, because libfuse is a perfect target for supply chain attacks and I don't want to make this too easy.
>>
>> I'm maintaining our DDN internal version anyway - I think I can help to
>> maintain libfuse / take it over.
>>
>> Btw, I also think that kernel fuse needs a maintenance team - I think
>> currently patches are getting forgotten about - I'm planning to set up
>> my own fuse-bernd-next branch with patches, which I think should be
>> considered - I just didn't get to that yet.
>>
>>
>> Thanks,
>> Bernd
> 
> +1 for Bernd's maintenance *team* idea. But perhaps extended to libfuse
> as well? There are a number of us who are familiar with the code and at
> least semi-active in the space. Help spread the load.
> 
> I could help out at least on the libfuse side.

You are absolutely right, a team is always better.

