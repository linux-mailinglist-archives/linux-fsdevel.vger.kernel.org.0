Return-Path: <linux-fsdevel+bounces-12910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B4E8685AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 02:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17F171F21FD8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 01:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D674C6F;
	Tue, 27 Feb 2024 01:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="WgON1lms";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jZNk5Jes"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39A017F8
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 01:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708996902; cv=none; b=NHgG3S8HB3jjrrDbbyO658RIPTIImVRUzl9W7+1DswLZMgAIygzVsHdLIGdq7X+u+orymZLIae16878cQ7R20vZhqd3AXwlBK2U2aRV3fZQ/kX/0/mzhTQCU1wQx2cs7YSVcI8Yrvmk3m9qk1HOVtnm/LivStw70szD9V6x37UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708996902; c=relaxed/simple;
	bh=0GE3fEfCQs+Gp5PoQDuWaijVjBOwpKSibXahan7pZSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5Ol0jtHbsEnnpTyGTnMveBjYjG2lU8sCwh6b6SyIU2d//s0MBEmJ0fYsBq6Vz03EeUjCW8n1ADiQ6KAXFyfVF2g88maJhjF+qvmFyFzg5ezvLS3/eL04abVIJnXMmeiQcaZsu/9y28H9ok+s6a2Du6roXqIPs1QdJVrVa30A54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=none smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=WgON1lms; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jZNk5Jes; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=themaw.net
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id AEB045C006D;
	Mon, 26 Feb 2024 20:21:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 26 Feb 2024 20:21:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1708996899;
	 x=1709083299; bh=KkXTqFJPVV9tI+ZMuoftOVwNm9P3e2zoNkV2LI56qYY=; b=
	WgON1lms5Gvy6TENuaBZ3V7VFmdPDHxUwJgHn9o+FCEZGPSqLrJAZGQeDPlMP+ct
	BjtL4vLBcCt8QzO/sEE0A+wTbO2O/0vTTs4x2n2DpVSe2aVb5dJQJrvUFqUyRCd+
	2TwpQFCw/2dHt6zQ+BXzAGyqQtl/SRlhgKGTl6ZPruu+ME0yqZMF60foNJpovPtM
	c+DRwOIxhY7/gVuZqQ46tdAkU+HXzLWiUBO1inmfk9F9202UR1rL8zW+PPRmaThr
	BS6I5Zpc3qlfMaUPaNPiZPBNXwhNwh3HGI0Jr8lPYLKfMb9ibfYczEl5CTa0Ek5/
	QZrmGpbEzgPnoVAmNVN8DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708996899; x=
	1709083299; bh=KkXTqFJPVV9tI+ZMuoftOVwNm9P3e2zoNkV2LI56qYY=; b=j
	ZNk5JesbEUg8P182EKpFwAcJPc9MoPncnPkITp6ExsGZwlL0Z2aXpp+1V3bob2hm
	4qWpvnT18v8I67fyMhns+ZnJJ6vw3wxIyeTtotoC2gaepXOiDtyD/5yANlG8+//A
	3rB8RYSyEt6s2ZUqFUFkIQLouzO3LA873atZpNm4J8qRNRUAYjxxWTvnqbRKZcCW
	d/FzKgUzTouehDya2imn6Jwc0/f1K2WHkBP40moO4mEb4p+QRTh9lUBbECHoQJ9d
	OJZdcNIt1hi0k0NZ53OiHSysQmYFIFtwraccrKlaccttV4WwcJeF7F7kZUQOTx5p
	Rqgdd3Ujkqr2E78KWboqg==
X-ME-Sender: <xms:IzndZYUtGCgxx51KVVqVGS_PjdQ4xJL0KLotM-Tj1b7OuHs9Qk8KhQ>
    <xme:IzndZcn7wl84iNW7jKLWu0dl6JhXwqsgfvok8g-lCYLiCp2W7u1QcEyPyfIyL-KDq
    QLvgOAcERlo>
X-ME-Received: <xmr:IzndZcYi6Fblnc4ol80Dhc2dpkx0aIVyafoyhbeEpwDq6woO5-qVeJP4opw_E0QMVlCvvGn8eU_gg-KOCSp4PYJ3sN6rWWk71qhuf-TPskNTfleFel5XnQ1N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeefgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    dvueetuefhjedtueethfehlefgleduveduhedvgeeigeelffefveejgeegveeiueenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:IzndZXUegJd1CY25wa7wz9JRijlD7olF-nR9GRaCWr4NlrwNaOGUtw>
    <xmx:IzndZSnaCWNa1v6s2JEVQLif26M1h1C5B3MumtEA2gcbrIaTFozN2w>
    <xmx:IzndZcdV5TFMEfAE4wIg-GATM_jFr4wJMtI-f9rqlemW7aYAnsIe5A>
    <xmx:IzndZTD3AQI7WkB3y5bVbWvOuWciimpABwgnGZ4BmvsFEFLCxOyBXg>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Feb 2024 20:21:36 -0500 (EST)
Message-ID: <4a0e7bf3-a559-42c9-9c50-acb83d3a430b@themaw.net>
Date: Tue, 27 Feb 2024 09:21:32 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] vfs: always log mount API fs context messages to
 dmesg
To: Eric Sandeen <sandeen@redhat.com>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Alexander Viro <aviro@redhat.com>, Bill O'Donnell <billodo@redhat.com>,
 Karel Zak <kzak@redhat.com>
References: <9934ed50-5760-4326-a921-cee0239355b0@redhat.com>
 <20240226-geboxt-absitzen-57467986b708@brauner>
 <4d5f6969-8abc-443a-a395-d511b4baa99e@redhat.com>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <4d5f6969-8abc-443a-a395-d511b4baa99e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/2/24 23:23, Eric Sandeen wrote:
> On 2/26/24 5:27 AM, Christian Brauner wrote:
>>> * systemd is currently probing with a dummy mount option which will
>>>    generate noise, see
>>>    https://github.com/systemd/systemd/blob/main/src/basic/mountpoint-util.c#L759
>>>    i.e. -
>>>    [   10.689256] proc: Unknown parameter 'adefinitelynotexistingmountoption'
>>>    [   10.801045] tmpfs: Unknown parameter 'adefinitelynotexistingmountoption'
>>>    [   11.119431] proc: Unknown parameter 'adefinitelynotexistingmountoption'
>>>    [   11.692032] proc: Unknown parameter 'adefinitelynotexistingmountoption'
>> Yeah, I remember that they want to know whether a given mount option is
>> supported or not. That would potentially cause some people to pipe up
>> complaining about dmesg getting spammed with this if we enable it.
>>
>> Ok, so right now invalfc() is logged in the fs_context but it isn't
>> logged in dmesg, right? Would it make sense to massage invalfc() so that
>> it logs with error into the fs_context but with info into dmesg? This
>> would avoid spamming dmesg and then we could risk turning this on to see
>> whether this causes complaints.
> Hm, yeah that would make sense I think - less consequential messages go only
> to the fc, higher priority messages go to both fc and dmesg. (userspace
> could still filter on severity for messages in the fc as desired.)
>
> The interfaces are already a little unclear, ("what is warnf vs. warnfc?")
> without reading the code, and this'd be another slightly unexpected wrinkle,
> but functionally it makes sense to me. I wonder if a sysctl to set a
> severity threshold for dmesg would make any sense, or if that'd be overkill.

A case that I encountered quite a while ago was where (IIRC) a kernel NFS

bug was logged because of the appearance of a new message in the kernel log.


I investigated and explained that what the message said had already been

happening but was not previously logged and the reason the message was now

appearing was due to code changes (the mount api).


At this point it becomes annoying, when the user isn't happy with the

explanation and doesn't quite say so but continues to complain. Admittedly

I didn't say I wasn't going to change it but then I didn't implement the

change and I'm not an NFS maintainer so maybe I should have ignored the

bug ...


It was then I thought the mount api logging needed so more thought and

here we are.


Perhaps, if we had some way to change the log level of messages via

configuration, sysfs perhaps, so that what gets logged to the kernel

log can be better controlled. An additional (or perhaps different scale)

log level that can allow finer grained control of what gets logged might

be sufficient.


TBH I'm not really sure the best way to improve the situation, all I know

is we do need continue to log messages to the kernel log, where appropriate

and we do need a way to ensure all messages are available in the context.


Ian

>> You know you could probably test your patch with xfstests to see if this
>> causes any new test failures because dmesg contains new output. This
>> doesn't disqualify the patch ofc it might just useful to get an idea how
>> much noiser we are by doing this.
> Good point. Ok, it sounds like there's some movement towards agreement that
> at least some messages should go to dmesg. I'll dig a little deeper and come
> up with a more solid & tested proposal.
>
> Thanks,
> -Eric
>
>

