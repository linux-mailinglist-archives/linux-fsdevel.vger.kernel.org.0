Return-Path: <linux-fsdevel+bounces-36657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B09A9E7641
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 17:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33FC928890E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 16:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7236D206284;
	Fri,  6 Dec 2024 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="hG3rXntJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f7lF8o7Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C561206270;
	Fri,  6 Dec 2024 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733503096; cv=none; b=ktJJuk8h0CTdlxGIL4PDQGLJNzKeV5q9tOFuXWqC6Zd6obYmUkM8F1lvkz8ByZA8dR1XkMI1mYR0O2Ts+bLcBTDjLX9zjY10QZO9FxIjNRQm92WLt1BtON0f6HwulwzhNx+yauNMRZtZAGYo5T4xN6zphH4qgHzGLWDGbrt35B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733503096; c=relaxed/simple;
	bh=FGnfniOj0Y6FgSXqJOpFrfLoZU988Gf5jVo3rNrTFME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gLRGHDRTU9FN2t+Mtqg1bgM/FFwIQLTWDLL7T4EOqRwhDuFkStE2xVptJcMSdS4F0ndjU7lY8xhThV+gTszegAZ7iAw5Ugm9T590bN1ANy+rSvajiyafugzk8UsMNGpFwJktmp/7KdNIhsc6FNyp6M1QRSI3TaneyYEOw0tVi2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=hG3rXntJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f7lF8o7Y; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 8BA241140170;
	Fri,  6 Dec 2024 11:38:13 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 06 Dec 2024 11:38:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733503093;
	 x=1733589493; bh=L8wQMVN3CA3vlvWokkwFyOCJdtQgbTsN9Yv6oOD1qYM=; b=
	hG3rXntJBtqBKgg4TozOVwX4UpjLKyB0Ca8AouOX4bt92JGdtvT3YzIy3IBMBF1n
	2g81pdUWxTiISDTD5K7Lw+Xh/THRvv7SHJ5mZMAOHJq5iyF+sYt1O9ctITYYCgnL
	5idi9GscfbI9TUUL7fdXL9EDgpgzRZcZmWqFiiwiarP4w63wTzhR1yCtkME5ie/Y
	jwlX+9bakoqW6G6bTatiegNJcD6jTjkeGUjWsTdV5ZhfDaTpNvC6VLE5TDfG2jxK
	gp9ovGtAHuJDsOxKBVRY7Z5VgCiqA86B7L3eblIlBGv1mLaawV5lf2EbjPpQGYQF
	1zx+ikK7RHvsaAeTUJ1F6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733503093; x=
	1733589493; bh=L8wQMVN3CA3vlvWokkwFyOCJdtQgbTsN9Yv6oOD1qYM=; b=f
	7lF8o7YgyRYwTz0ik1pkkH1xZ3kNQBw2Jhi3HuZE6OUj5/mj1YCpjUh+PyUU5b22
	RPZr4gxVx3dqTGgvGBIzn0zJ/WZyrUvRuzOZzLfpb15wxEYObRAh7FBwtWEeJASA
	Cpfzg5J9dmZuJcXdVVIy4i8EiyFsKS6jGHSziKVcKbnqGOKtfhU/sKPlxP9SkNkZ
	FJy/SMCMf1vNlnR7ffsbSNXKmXHEOpQClggA7BAAlB91xqFPz+EQ2siSs4X64qHD
	2Znx/asFSbiX2yyDNZeyvyLNRZ2GFgVsT074azxoI+vjZfYqQGbJR7qZCF3zxGhu
	9zMXXbDmQqFaREKmqtpXg==
X-ME-Sender: <xms:dChTZxkHZ4ihIXc5SH4x4Y8hErc8McgY9o5QMWEEaNFg_xBkoqn7bQ>
    <xme:dChTZ82XQCUveY0CoFsgHNeGEuZhGUKfq6GKGjPzPWZsU9b9AhJNQ4P2VRim21K1v
    XnO_5PrIsxkKKf708A>
X-ME-Received: <xmr:dChTZ3ooP5ONhbl1-CPrfXjvUriKmo7IrccQ_sgwV0i4R_kkjp9vACq5jF_QUHTux_zWl3yIb-HZACo8zR1E00ZW5fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepkfffgggfuf
    fvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefgrhhitgcuufgrnhguvggvnhcu
    oehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtqeenucggtffrrghtthgvrhhnpeevie
    ekueetfeeujedtheeffedvgeffiedvjeejleffhfeggeejuedtjeeulefhvdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghnuggvvghnse
    hsrghnuggvvghnrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehmtghgrhhofheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsh
    grnhguvggvnhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepphgrthgthhgvsheslhhi
    shhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehfshhtvghsthhssehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgohhsthdruggvvhesshgrmhhsuhhngh
    drtghomh
X-ME-Proxy: <xmx:dChTZxlEndGndargkCiuTg7DTO6T2C4ZytgVwKwetfW_v8Utjo6b-A>
    <xmx:dChTZ_04dDziGaCloDBl_23OqyAfGsRfDdKW4gZhirHScTx7iKfRig>
    <xmx:dChTZwsu0pjhKauVJvOu84_UOHOF5ulPvQH6rix0kYr0ZwW9WGL7xw>
    <xmx:dChTZzUOnVXmI5-VwaBlYdj5I584KmICgIrA5nCMioktssP_BJi5QA>
    <xmx:dShTZ5pk-LLEhfDHvA65njFCtlSyAbOsE2_Q8bzYI5BrFtEHo-aSSHi8>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 11:38:12 -0500 (EST)
Message-ID: <14e3c1fd-4c16-4676-8f66-81558febc4dd@sandeen.net>
Date: Fri, 6 Dec 2024 10:38:11 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common/config: use modprobe -w when supported
To: Luis Chamberlain <mcgrof@kernel.org>, Eric Sandeen <sandeen@redhat.com>
Cc: patches@lists.linux.dev, fstests@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, gost.dev@samsung.com
References: <20241205002624.3420504-1-mcgrof@kernel.org>
 <0272e083-8915-407a-9d7f-0c1a253c32d7@redhat.com>
 <Z1IuphUjdnnRUWCg@bombadil.infradead.org>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <Z1IuphUjdnnRUWCg@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/24 4:52 PM, Luis Chamberlain wrote:
> On Wed, Dec 04, 2024 at 10:35:45PM -0600, Eric Sandeen wrote:
>> but that probably has more to do with the test not realizing
>> /before it starts/ that the module cannot be removed and it
>> should not even try.
> 
> Right.
> 
>> Darrick fixed that with:
>>
>> [PATCH 2/2] xfs/43[4-6]: implement impatient module reloading
> 
> Looks good to me.
> 
>> but it's starting to feel like a bit of a complex house of cards
>> by now. We might need a more robust framework for determining whether
>> a module is removable /at all/ before we decide to wait patiently
>> for a thing that cannot ever happen?
> 
> I think the above is a good example of knowing userspace and knowing
> that userspace may be doing something else and we're ok to fail.
> Essentially, module removal is non-deterministic due to how finicky
> and easy it is to bump the refcnt for arbitrary reasons which are
> subsystem specific. The URLs in the commit log I added provide good
> examples of this. It is up to each subsystem to ensure a proper
> quiesce makes sense to ensure userspace won't do something stupid
> later.
> 
> If one can control the test environment to quiesce first, then it
> makes sense to patiently remove the module. Otherwise the optional
> impatient removal makes sense.

Not to belabor the point too much, but my gut feeling is there are
cases where "quiescing" is not the issue at all - if the module is
in use on the system somewhere outside of xfstests, no amount of
quiescing or waiting will make it removable. Essentially, xfstests
needs to figure out if it is the sole owner/user of a module before
it tries to do any sort of waiting for removal, IMHO.

I haven't had the time to think through it much, just my spidey-
sense tingling when looking at the xfs/43[4-6] problem and feeling
like there's probably a better/cleaner/more explicit solution for
some of this.

Thanks,
-Eric

>   Luis
> 


