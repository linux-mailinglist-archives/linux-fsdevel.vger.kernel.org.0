Return-Path: <linux-fsdevel+bounces-75443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGNfKGAfd2ntcQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 09:01:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE2885396
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 09:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDF7D3013004
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 08:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3B32F691A;
	Mon, 26 Jan 2026 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="i/qRwIZW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LrSBPgpH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D7B26E711;
	Mon, 26 Jan 2026 08:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769414459; cv=none; b=fB8RlaQn/Knl7X+Q0DWe61KKaPYIas8b5Xup8v5bi0fvdyjPqCKxPfcG8nR93a3+OWUrGpRSey1Yg2d2ksGrsJV4HsAHEzmIaNHxceWMkPuMcW0fnZhUCr5AbfQEIdoKnFqVzD6nIpXpYV8tKYN7OyBQhnjQOXDk3NlTZ4T5KEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769414459; c=relaxed/simple;
	bh=Jq2F+oCg5oDSvWCa10TFq1iUE4KbxQiTyPoLBVvSJjM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=k0ih/SSviI/Y9ZnfDReTQJVZSi9wM2mPrAwT5ABPe+A9wOTI8jxJJ3NYB5t/t1mqx/mA84xfOrHbBwupVwRUrPMokQ0JsZALI3AiTsicIVk8Tm3tJT7ATIckivhSOWHpWD9DOcDGqm37uCH5ZHIs7osDoezkoftXWmlijaSB1gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=i/qRwIZW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LrSBPgpH; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 674E91400059;
	Mon, 26 Jan 2026 03:00:57 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 26 Jan 2026 03:00:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769414457;
	 x=1769500857; bh=P8ncLr4g8+8XbCw2IM+F0C9C0EAgVMAauftZ2zcoeu8=; b=
	i/qRwIZWm1G8nLRfkb1Rc76Wazijd+Z/mwC3OyMOiAykxOdYor5eJzLaPMqX3Ksp
	xSvZV8QcyAu9pZrwal+CnDfVAt6Uot8cUs7PyR7rs1W3ZzguL/PF9K9Sr3PHrxaW
	SpZlQ+9VbSDeBqj71EVChoBtjTPrhG7vnS7K6g0CwZgSb+5h7mz0HLdhxXAq+WgW
	80lYjgRmAOy4mxaTIIHhQ/4u/1LVzFwbi3zIo+yj9FJC34tQ6Ay8QeSvNGf7rCXk
	6as6JL6amRw6a5de2S2WZeEUQqApyb4U7OeOvDhuvsLzIlLrlKLAFzlruu3saUf8
	n/ZS8ezoNEML9GpN7uPSrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769414457; x=
	1769500857; bh=P8ncLr4g8+8XbCw2IM+F0C9C0EAgVMAauftZ2zcoeu8=; b=L
	rSBPgpHkdl5X7xCzY2fvEIgpTFY+/r/7xI+LZVYvdyVQKV7j9jLjIRkOFTio7cLl
	giWjGRR2+8nbXe54FREQFceTpIDIRZ4tjUr232Gbc87Oli/XhNRDUy7QycxTurX0
	eGIl1FqaU94FuHiNMlyDiekDeK23/J1GnU5/uD1oA7wxktVd7W2JAFgQFvwalUAv
	fGfn2AAwIVSIug8abWSv8c9k2txOSmxPs5OBirIfw/q9zZ9ulvx1q+3htPG0CKpG
	8P9XWZgnFXtrR8QdMIFnz/8mF/jUFhv7Wx8Z+JcTZfGo1erBs5GMezGvByNU8TPa
	0xnJgIQmV0SL/VzEmfizw==
X-ME-Sender: <xms:OR93aXpy7AxORIU8ALV6SVfu2GZ2tBNdzlmDswt34Lb4YZm9Cneepw>
    <xme:OR93acctjR84XwxNcMmXRPCfvXJHKuwNNt2ndhhKMa674tgNLKZiDEM9Zza2Ar7Bn
    KioTE1PB5frHOtFMlBldkzdQ-YB-kU87Skom0WUXlX_Lv-8dfeLivI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheejudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheprghlvgigrdgrrhhinhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epughorhhjohihtghhhiduuddusehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghrrghu
    nhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtoheplhhinhhugidqfh
    hsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhroh
    esiigvnhhivhdrlhhinhhugidrohhrghdruhhk
X-ME-Proxy: <xmx:OR93aTKgUj39tnP09CSXHNMGJ2heUbjZRPV5NDvoKsA-kGAlSlr_RA>
    <xmx:OR93aaMiqJLtkyYsO5eTvi0GVgGBlKuB9gIOBLkDOqu5cO8cV17COg>
    <xmx:OR93aWUJFyUbVv-ozIaodOhfUJpGlFy3D3S1KJULKXPezIDVyVM-0w>
    <xmx:OR93aYk1XpUrB2OWDgaxXZNLYxWE0aelmaXVe0HZjm705XklnqENKg>
    <xmx:OR93abVzKXbrDGDOgh7usBGEtBAjxFn0fSkzr1byWiOuIuB4-a266cOu>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F206D700069; Mon, 26 Jan 2026 03:00:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: As39fFuPNmh7
Date: Mon, 26 Jan 2026 09:00:35 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dorjoy Chowdhury" <dorjoychy111@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Jeff Layton" <jlayton@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Alexander Aring" <alex.aring@gmail.com>
Message-Id: <a3a9ea10-ae0f-4258-9950-89c2bdfa05b1@app.fastmail.com>
In-Reply-To: 
 <CAFfO_h7ttQPVCR-yQ_=h4BLoHYW3QZOWQ+oSNSFvY-7NOxxeHw@mail.gmail.com>
References: <20260125141518.59493-1-dorjoychy111@gmail.com>
 <20260125141518.59493-2-dorjoychy111@gmail.com>
 <57fe666f-f451-462f-8f16-8c0ba83f1eac@app.fastmail.com>
 <CAFfO_h7ttQPVCR-yQ_=h4BLoHYW3QZOWQ+oSNSFvY-7NOxxeHw@mail.gmail.com>
Subject: Re: [PATCH 1/2] open: new O_REGULAR flag support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-75443-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:dkim,app.fastmail.com:mid,messagingengine.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1BE2885396
X-Rspamd-Action: no action

On Sun, Jan 25, 2026, at 16:41, Dorjoy Chowdhury wrote:
>
> Thanks for pointing this out. I will fix up in v2 along with other
> comments (if any). I looked at the existing error codes in
> uapi/asm-generic/errno.h and didn't notice anything that I could
> reuse. So if I understand correctly, I will need this new error code
> in both uapi/asm-generic/errno.h (not in errno-base.h) and in
> arch/*/include/uapi/asm/errno.h (I see some parallel
> tools/arch/*/include/uapi/asm/errno.h files too) just after EHWPOISON,
> right?

Yes, sounds good to me.

>> > diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
>> > index 613475285643..11e5eadab868 100644
>> > --- a/include/uapi/asm-generic/fcntl.h
>> > +++ b/include/uapi/asm-generic/fcntl.h
>> > @@ -88,6 +88,10 @@
>> >  #define __O_TMPFILE  020000000
>> >  #endif
>> >
>> > +#ifndef O_REGULAR
>> > +#define O_REGULAR       040000000
>> > +#endif
>>
>> This in turn clashes with O_PATH on alpha, __O_TMPFILE on
>> parisc, and __O_SYNC on sparc. We can probably fill the holes
>> in asm/fcntl.h to define this.
>>
>
> And for this, I will need to just define O_REGULAR in alpha, parisc
> and sparc too, right?

Yes, the only question is whether to use the first available
bit, or the one after the previously last one.

> Good catch on the sparc file, some are octal, some are hexadecimal,
> easy to miss. Thanks!

Right, I wonder if there are any downsides to redefining them
all the same way.

    Arnd

