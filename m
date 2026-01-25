Return-Path: <linux-fsdevel+bounces-75385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKNLDtA4dmmTNgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 16:37:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD6481472
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 16:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE81F3005668
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 15:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8DC3254AA;
	Sun, 25 Jan 2026 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=owlfolio.org header.i=@owlfolio.org header.b="ZVnmxduM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FKKvHl7Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1532131AA95;
	Sun, 25 Jan 2026 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769355467; cv=none; b=b4OksyNRuetANozfqNeZnQbpRqoo508XxBkv2rx1DilVL7kIlqRWhsrf/XHfSUNB6LMdseRNjRIidWixDHFZwSA8XHlS826QirsknVPbx7vdcAvhYNoxSYKMhEf2/ka3kygrQUSwIs2AMJpCGwJRmrNUe1+xj55+Z6JdB+Equ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769355467; c=relaxed/simple;
	bh=VeVMljgEPJXTeUNiM8RemyXJYtjxqQXTnRz+WVh2cVw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KBGH++E2oAlPtbM0NSWBnTvyxpVQ0Z3hFM2HsScpVHMb3h0Pi8g+//VzUFlrWuMu8ozrf0XXaiOJt+SADP10g1rFi9s1w8lZUFrgV4YdSbm+twJCLhf6luYqkPYETMGVj7IAMqOF17Cexxx3pF8Wfl4eqg5LBAD/MvUNNbz9V5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=owlfolio.org; spf=pass smtp.mailfrom=owlfolio.org; dkim=pass (2048-bit key) header.d=owlfolio.org header.i=@owlfolio.org header.b=ZVnmxduM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FKKvHl7Z; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=owlfolio.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=owlfolio.org
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 15C2C7A0087;
	Sun, 25 Jan 2026 10:37:43 -0500 (EST)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-01.internal (MEProxy); Sun, 25 Jan 2026 10:37:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=owlfolio.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1769355462;
	 x=1769441862; bh=/7uSzfxfxt8SgLk6xFoqW1PmwJgy6RZJOPV1QIvRvUM=; b=
	ZVnmxduMR45r+WOaEKQyn76BEIgoYYDxUqCouvGJspW54P95eLCTpXubpnnIFAa/
	AujxHJEr44y04IOsOkxhOQ2gYD+88UqYCtQ0B/DPy/55LlyfZ4eTXvsJP7euRQDL
	kkBQUMcrgj+QfSg37oxEXSNbPt7sc3JeyIKG8+cgba8yYv0aLqu4SStiJhcuLP3z
	aalWhOVV63by8Bxa7fiuT2I0/hd/YXZ3h5EBf+melziaiUKUoMy1KgF0TW2OEiyj
	WSB3DCRUE8BaiAvvM4WKDZ5FsrSfmpyKhQ7dS4jYf865xr2vf9813vBYjYTZEir8
	ixhaOVWWLT9jPfmKMgpSLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769355462; x=
	1769441862; bh=/7uSzfxfxt8SgLk6xFoqW1PmwJgy6RZJOPV1QIvRvUM=; b=F
	KKvHl7Z9Cyq87xFMqD58/ciIfce17zRxf8E1wIEtA8mY7f13sfQLDahUzL7AlL24
	TVSV1oPC5QbMHg2WpWZX7i6lRX3aJc6Z06s0Q3VRQzX4m6EkTPB6ah1IXiEfaX3J
	8rSmzDg8tdThmt37mD2edoRU9k9eq2aa+0IBBPFBRPUbzjbVbvkK6RCbfCLueLp6
	mTTY5oprdC5y4g8I3nFipL4wBOFAtrzjLodmfnDgvQbb7tXnylD7UelEzQfmQkv9
	dbqD+ltsGMMRVWdu2xYD3r4yXQuR6Z/a4ZBntisZyobHsRAaAY+lrzS40gdUxOP5
	9gyBAgOcGadrENukvonjw==
X-ME-Sender: <xms:xjh2ab74hpnSJkQT1uOoELPUe-Gp8ghxXhzSHFipid2Ao1iwEUtHKA>
    <xme:xjh2abtwqZDZEPZ3hx9qkpwKoVNT8AO_3RN4besvLHQk9N3K6GzRfYnpO-Ci0_U-Z
    NLZJ86vbvg54JWX--HvjNjNqsc5Pkaa7638nXwKBBb1mjrnxrgA_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheehudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfkggrtghk
    ucghvghinhgsvghrghdfuceoiigrtghksehofihlfhholhhiohdrohhrgheqnecuggftrf
    grthhtvghrnhepjefghfdthfetleejgefgjeefiedvtdeufeetgfehueevieelveetkedu
    udegfefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmpd
    hsthgrtghkohhvvghrfhhlohifrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepiigrtghksehofihlfhholhhiohdrohhrghdpnhgspg
    hrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkvghrnhgv
    lhesihhnfhhinhhithgvqdhsohhurhgtvgdruggvpdhrtghpthhtoheprghlgieskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepuggrlhhirghssehlihgstgdrohhrghdprhgtphhtthhopehlihgstgdqrg
    hlphhhrgesshhouhhrtggvfigrrhgvrdhorhhgpdhrtghpthhtohepjhgrtghksehsuhhs
    vgdrtgiipdhrtghpthhtoheplhhinhhugidqrghpihesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepvhhinhgtvghnthesvhhinhgtudejrdhnvght
X-ME-Proxy: <xmx:xjh2aSHvAu6Mq2tc8I0wHaQMrR20B3hx6dGHr8VUiQQX5d3eQc3yfQ>
    <xmx:xjh2aRn9-2zlnAcs--Gu_3wKTqh0UAZdY-gPXxtfLMpcwpNx3TZInQ>
    <xmx:xjh2aVd9CcWKHGQPR2uaANXcsGW1nulb8TrtM9jk6BX4fyHbOzG0Uw>
    <xmx:xjh2afFav2Ao5UemgRY8gU4uqf0zpF7zWDq3Hf9ocO8nSOFbM4dNDA>
    <xmx:xjh2aTA431scxgOxT0kYN4ESvdVFNEInmav8FU58KizapyvAeULbZITZ>
Feedback-ID: i876146a2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E4350C4006E; Sun, 25 Jan 2026 10:37:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ANFeMez8yEXZ
Date: Sun, 25 Jan 2026 10:37:01 -0500
From: "Zack Weinberg" <zack@owlfolio.org>
To: "The 8472" <kernel@infinite-source.de>, "Rich Felker" <dalias@libc.org>
Cc: "Alejandro Colomar" <alx@kernel.org>,
 "Vincent Lefevre" <vincent@vinc17.net>, "Jan Kara" <jack@suse.cz>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, "GNU libc development" <libc-alpha@sourceware.org>
Message-Id: <de07d292-99d8-44e8-b7d6-c491ac5fe5be@app.fastmail.com>
In-Reply-To: <7654b75b-6697-4aad-93fc-29fa9b734bdb@infinite-source.de>
References: <20250517133251.GY1509@brightrain.aerifal.cx>
 <5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
 <8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>
 <20250524022416.GB6263@brightrain.aerifal.cx>
 <1571b14d-1077-4e81-ab97-36e39099761e@app.fastmail.com>
 <20260120174659.GE6263@brightrain.aerifal.cx> <aW_jz7nucPBjhu0C@devuan>
 <aW_olRn5s1lbbjdH@devuan>
 <1ec25e49-841e-4b04-911d-66e3b9ff4471@app.fastmail.com>
 <0f60995f-370f-4c2d-aaa6-731716657f9d@infinite-source.de>
 <20260124213934.GI6263@brightrain.aerifal.cx>
 <7654b75b-6697-4aad-93fc-29fa9b734bdb@infinite-source.de>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from POSIX.1-2024
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[owlfolio.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[owlfolio.org:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75385-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[owlfolio.org:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zack@owlfolio.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim,owlfolio.org:dkim]
X-Rspamd-Queue-Id: 0BD6481472
X-Rspamd-Action: no action

On Sat, Jan 24, 2026, at 4:57 PM, The 8472 wrote:
> On 24/01/2026 22:39, Rich Felker wrote:
>> On Sat, Jan 24, 2026 at 08:34:01PM +0100, The 8472 wrote:
>>> On 23/01/2026 01:33, Zack Weinberg wrote:
>>>
>>> [...]
>>>
>>>> ERRORS
>>>>          EBADF  The fd argument was not a valid, open file descript=
or.
>>>
>>> Unfortunately EBADF from FUSE is passed through unfiltered by the ke=
rnel
>>> on close[0], that makes it more difficult to reliably detect bugs re=
lating
>>> to double-closes of file descriptors.
>>
>> Wow, that's a nasty bug. Are the kernel folks not amenable to fixing
>> it?
>
> Not when I brought it up last time, no[0]
>
> [0] https://lore.kernel.org/linux-fsdevel/1b946a20-5e8a-497e-96ef-f7b1=
e037edcb@infinite-source.de/

It seems to me that Antonio Muscemi=E2=80=99s point is valid for *most* =
errno
codes.  Like, a whole lot of them exist just to give more information
*to a human user* about the cause of an unrecoverable error.  Take
the list of =E2=80=9Cerror codes that indicate a delayed error from a pr=
evious
write(2) operation,=E2=80=9D from a little later in the draft, for insta=
nce:
there=E2=80=99s no plausible way for a *program* to react differently to
EFBIG, EDQUOT, and ENOSPC, but we expect that the *user* will want
to react differently, so we want different error messages for each,
so they=E2=80=99re different error codes.  It=E2=80=99s not a problem if=
 the kernel
produces an error code of this type that wasn=E2=80=99t in the official
documented list, because the program doesn=E2=80=99t need to treat it sp=
ecially.

But EBADF is different; it has the very specific meaning =E2=80=9Cuser s=
pace
passed an invalid file descriptor to a system call,=E2=80=9D which almost
always indicates a *bug in the program*, and allowing that meaning to
be diluted is not OK.  It=E2=80=99s getting off topic for this conversat=
ion,
but there=E2=80=99s a short list of other errno codes that indicate a sp=
ecific
situation that the *program* should respond to in a specific way
(EAGAIN, EINTR, EINPROGRESS, EFAULT, and EPIPE are the only ones
I can think of) and maybe it would spark a more constructive
conversation on the kernel side if we presented a *comprehensive*
list of errno codes that FUSE servers shouldn=E2=80=99t be allowed to pr=
oduce
with a specific rationale for each.

>>     Delayed errors reported by close()
>>
>>         In a variety of situations, most notably when writing to a fi=
le
>>         that is hosted on a network file server, write(2) operations =
may
>>         =E2=80=9Coptimistically=E2=80=9D return successfully as soon =
as the write has
>>         been queued for processing.
>>
>>         close(2) waits for confirmation that *most* of the processing
>>         for previous writes to a file has been completed, and reports
>>         any errors that the earlier write() calls *would have* report=
ed,
>>         if they hadn=E2=80=99t returned optimistically.  Especially, =
close()
>>         will report =E2=80=9Cdisk full=E2=80=9D (ENOSPC) and =E2=80=9C=
disk quota exceeded=E2=80=9D
>>         (EDQUOT) errors that write() didn=E2=80=99t wait for.
>
> The Rust standard library team is also interested in this topic, there
> is lively discussion[1] whether it makes sense to surface errors from
> close at all. Our current default is to ignore them.
> It is my understanding that errors may not have happened yet at
> the time of close due to delayed writeback or additional descriptors
> pointing to the description, e.g. in a forked child, and thus
> close() is not a reliable mechanism for error detection and
> fsync() is the only available option.
>
> [1] https://github.com/rust-lang/libs-team/issues/705

This is something I care about a lot as well, but I currently don=E2=80=99t
have an *opinion*.  To form an informed opinion, I need the answers
to these questions:

>>      [QUERY: Do delayed errors ever happen in any of these situations?
>>
>>         - The fd is not the last reference to the open file descripti=
on
>>
>>         - The OFD was opened with O_RDONLY
>>
>>         - The OFD was opened with O_RDWR but has never actually
>>           been written to
>>
>>         - No data has been written to the OFD since the last call to
>>           fsync() for that OFD
>>
>>         - No data has been written to the OFD since the last call to
>>           fdatasync() for that OFD
>>
>>         If we can give some guidance about when people don=E2=80=99t =
need to
>>         worry about delayed errors, it would be helpful.]

In particular, I really hope delayed errors *aren=E2=80=99t* ever report=
ed
when you close a file descriptor that *isn=E2=80=99t* the last reference
to its open file description, because the thread-safe way to close
stdout without losing write errors[2] depends on that not happening.

And whether the Rust stdlib can legitimately say =E2=80=9Cleaving aside =
the
additional cost of calling fsync(), you do not *need* the error return
from close() because you can call fsync() first,=E2=80=9D depends on whe=
ther
it=E2=80=99s actually true that you *won=E2=80=99t* ever get a delayed e=
rror from
close() if you called fsync() first and didn=E2=80=99t do any more outpu=
t in
between (assume the fd has no duplicates here).  I would not be
surprised at all if those FUSE guys insisted on their right to make

    char msg[] =3D "soon I will be invincible\n";
    int fd =3D open("/test-fuse-fs/test.txt", O_WRONLY, 0666);
    write(fd, msg, sizeof(msg) - 1);
    fsync(fd);
    close(fd);

return an error *only* from the close, not the write or the fsync.
And I also wouldn=E2=80=99t be surprised at all to find production NFS or
SMB servers that did that.

[2] https://stackoverflow.com/a/50865617 (third code block)

zw

