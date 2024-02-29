Return-Path: <linux-fsdevel+bounces-13225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F0286D6F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 23:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20FB2B22DD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 22:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE23381DE;
	Thu, 29 Feb 2024 22:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b="i3J82juf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="azm3luIO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C5722318;
	Thu, 29 Feb 2024 22:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709246626; cv=none; b=HAHxQy6Vaye1FbdspLtLPpWGWREKXxr2fAHpQcSQZGUPIU+n2EzsY+Ps6oIZ3Bz1Z0kFbR8b5Ta9YmaofsPEaNrEMJ5/wYUVZgok8GoNMaWpZGKbeDZodpuE51atOwJAUfVPvB5wsF6zXsDb9csuLxehYJZv140XkBYI9QZwDgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709246626; c=relaxed/simple;
	bh=9XSGUMRxz0sE0T4ckvyeXP3yYfhB9m1rrvjoyxGiCbk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ti5uBlO0htImlOsQRF5BtYjwEMJsdrtztIBrE6QO3RbwY1hGzTRsziGrYJm5Q2uL9pVFbPdLBTzO/jcXcKaVt76ps/cQxmXCU6h/rd6vFq4zwSyTxXggLIseauwe1rcGmzUrpmWFNQUx+S6BO6UKumO/qIKQRZ9U/c6l28CgTos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org; spf=pass smtp.mailfrom=verbum.org; dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b=i3J82juf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=azm3luIO; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verbum.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 318A35C0049;
	Thu, 29 Feb 2024 17:43:42 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute2.internal (MEProxy); Thu, 29 Feb 2024 17:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709246622; x=1709333022; bh=NKAcUD0tyU
	b9nMY+LNYg26qTHsO4yEgMmPCWFlV5e0o=; b=i3J82juftyqETEw0mTaAIZKnT2
	N7htheRuh6rPvQ3bh7EOFMvMTUpmAA9YGHF5Q/khBKcvWUDSgWnj0e3fY7oHpQHo
	hVMNAQKW5MM2XNeXSnnq97w9f7rEGzetwuTEA5BSXPnieyLQYkmD06ge2G99uG8x
	mhsXaoZYvwiL/AbU3IJSCrmCSCtE+N6YmfHceovZSTKu7lpRXikolddM5NeivJdr
	slfM5WwTcuHemxxZzyIevtMXtS+2OtEHXtT/DE0gtmTyPVqXIfoA5We+MjyUXW64
	O62IEXZ6azUl94pYh/ZsjFCdRGHPm3xPdFlacF2a8McURTKKiKfgy2KTpPvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709246622; x=1709333022; bh=NKAcUD0tyUb9nMY+LNYg26qTHsO4
	yEgMmPCWFlV5e0o=; b=azm3luIOFXl4nKMajVF9d4wmSaTUQ/W+yiWPEv9AI4sw
	RKozh6NI/NUasPiZdVOPnAbEkn1wq5QiPs5xNloCwB3xZ1R3sXs8vdlN0LzW6GS6
	XFglX69kD7sm27hHSJgZEbhODGWQs2et/GzLvb8bqxUPHlK93UhvNhH609lpXrT7
	46M0GeqF4up6tEyA5zIsVELeaqFfNoDNzLsGmKaYBEzmmfkeMx8lJZIpQyUf9jA8
	YYmpGl0ZblpE40VlU17PJ42Jd0xE/lN631avP/dh6sa/xk/QzPLjxtPJLcvCq1Ou
	nWMFYfuR7173I2493RYYNVIDYch8WRovAnwOGYabpA==
X-ME-Sender: <xms:nQjhZQBiKnAIt0MbZv0S305drlEwifto-czuL-_zlIDlSYEZL8T2bg>
    <xme:nQjhZSjWDXZZcdO5qWswJZTLoQUjKbFqLzyO-PB9OyBWqZa71BWP38eA7Ce6a6YLz
    cteNp5x1j-zKc5Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeelgdduiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfveho
    lhhinhcuhggrlhhtvghrshdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvtdfhffdufeffueejgeevkeeggedtudekteetlefgteeujeeg
    ffelgffhueegveenucffohhmrghinhepthhoohdrhhhofienucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifrghlthgvrhhssehvvghrsghumhdr
    ohhrgh
X-ME-Proxy: <xmx:nQjhZTl3jMbMdVXLx7BZQG3cY-HoqcRuQKxQkhiPZ6Z2mBrwL8QQiA>
    <xmx:nQjhZWxlW1hqy64mApb442ELYYV33w3JxcQH6rT9YSnCcR9t8Z4TTQ>
    <xmx:nQjhZVT73B8of-OJg_pHrvQnC8Mh2xrr9qCDOl-9iPgYWNPBGjyzcQ>
    <xmx:ngjhZQefhJfaAw95CwfPcl7zwBy0MAlgwajgKdIs9wh1DXbpgk3kew>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C5F822A2008B; Thu, 29 Feb 2024 17:43:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-204-gba07d63ee1-fm-20240229.003-gba07d63e
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7282e2c3-f44a-4425-b0f7-24d1182e5499@app.fastmail.com>
In-Reply-To: <20240229201840.GC1927156@frogsfrogsfrogs>
References: <170900011604.938268.9876750689883987904.stgit@frogsfrogsfrogs>
 <87961163-a4b9-4032-aa06-f5126c9c8ca2@app.fastmail.com>
 <20240229201840.GC1927156@frogsfrogsfrogs>
Date: Thu, 29 Feb 2024 17:43:21 -0500
From: "Colin Walters" <walters@verbum.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>,
 "Christoph Hellwig" <hch@lst.de>
Subject: Re: [PATCHSET v29.4 03/13] xfs: atomic file content exchanges
Content-Type: text/plain



On Thu, Feb 29, 2024, at 3:18 PM, Darrick J. Wong wrote:
>
> Correct, there's no built-in dedupe.  For small files you'll probably
> end up with a single allocation anyway, which is ideal in terms of
> ondisk metadata overhead.

Makes sense.

> though I would bet that extending linkat (or rename, or
> whatever) is going to be the only workable solution for old / simple
> filesystems (e.g. fat32).

Ah, right; that too.

> How /does/ dconf handle those changes?  Does it rename the file and
> signal all the other dconf threads to reopen the file?  And then those
> threads get the new file contents?

I briefly skimmed the code and couldn't find it, but yes I believe it's basically that clients have an inotify watch that gets handled from the mainloop and clients close and reopen and re-mmap - it's probably nonexistent to have non-mainloop threads reading things from the mmap, so there's no races with any other threads.

>
> Huurrrh hurrrh.  That's right, I don't see how exchange can mesh well
> with mmap without actual flock()ing. :(
>
> fsnotify will send a message out to userspace after the exchange
> finishes, which means that userspace could watch for the notifications
> via fanotify.  However, that's still a bit racy... :/

Right.  However...it's not just about mmap.  Sorry this is a minor rant but...near my top ten list of changes to make with a time machine for Unix would be the concept of a contents-immutable file, like all the seals that work on memfd with F_ADD_SEALS (and outside of fsverity, which is good but can be a bit of a heavier hammer).

A few times I've been working on shell script in my editor on my desktop, and these shell scripts are tests because shell script is so tempting.  I'm sure this familiar, given (x)fstests.

And if you just run the tests (directly from source in git), and then notice a bug, and start typing in your editor, save the changes, and then and your editor happens to do a generic "open(O_TRUNC), save" instead of an atomic rename.  This happens to be what `nano` and VSCode do, although at least the `vi` I have here does an atomic rename.  (One could say all editors that don't are broken...but...)

And now because the way bash works (and I assume other historical Unix shells) is that they interpret the file *as they're reading it* in this scenario you can get completely undefined behavior.  It could do *anything*.

At least one of those times, I got an error from an `rm -rf` invocation that happened to live in one of those test scripts...that could have in theory just gone off and removed anything.

Basically the contents-immutable is really what you *always* want for executables and really anything that can be parsed without locking (like, almost all config files in /etc too).  With ELF files there's EXTBUSY if it *happens* to be in use, but that's just a hack.  Also in that other thread about racing writes to suid executables...well, there'd be no possibility for races if we just denied writing because again - it makes no sense to just make random writes in-place to an executable.  (OK I did see the zig folks are trying an incremental linker, but still I would just assume reflinks are available for that)

Now this is relevant here because, I don't think anything like dpkg/rpm and all those things could ever use this ioctl for this reason.

So, it seems to me like it should really be more explicitly targeted at
- Things that are using open()+write() today and it's safe for that use case
- The database cases

And not talk about replacing the general open(O_TMPFILE) + rename() path.

