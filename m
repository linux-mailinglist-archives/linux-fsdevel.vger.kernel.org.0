Return-Path: <linux-fsdevel+bounces-70635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E38CA2ED4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 10:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6CC530A8B22
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 09:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D3E33469A;
	Thu,  4 Dec 2025 09:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="lMWkYbkQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T0bYVEPJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0202F7AD4;
	Thu,  4 Dec 2025 09:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764839376; cv=none; b=t2T3eMm/U9buhT74tawLqCwWtW9jz+uwpug26I/bpWov8zk1jroKNLztLPryAUkcwcDOGrSXb4uv/xlrATJhZrNVmdtJLWAyGifutGSHsr8yp4QVmq1+xxYkX1pxpjgHKmGIML9mmulOErAefz6h99zBwQGv1e1dY0OSaC6f2nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764839376; c=relaxed/simple;
	bh=WkoKtlmdpwYo75LaXVuNNodQLvjx2w5vFrAp579r9Qw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=by/lKQr2qcQXjXGClW+qgbmyBg+Cztxv0UeTc1HOlsjB93zSEgN1uVrJuHYlP7amfKHssZeinAeR3Jw41mOcVHlro0SogAaT1FBN8mLRqXEP/WsdXoob3h9gNew61OvK+wg/jKDrEG8+/TJz5iAZUwmefb6ML2byCoYmYF93kNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=lMWkYbkQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T0bYVEPJ; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 9BBA51D000E0;
	Thu,  4 Dec 2025 04:09:32 -0500 (EST)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-04.internal (MEProxy); Thu, 04 Dec 2025 04:09:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1764839372;
	 x=1764925772; bh=/ztwZ2LCncPz/9Lf6JmOR9KE45SbTlD4TEBMpqz4fag=; b=
	lMWkYbkQ1hkjsenpt08bCj78PNszMlhR1V0AsfBF3LikUk4LJT3QlP/OrXHjKOIU
	pCpyhm4YFQ6qCqie16CECI7ZBZYO3Y/lk9UnOrH5ogzjvaUSDHUrEmRLeHICHfgX
	XTESKCWSLsFMk7ERLXD3TSWJP0VNT0LOcTzqm/YEO2ssQ7SoM4k4GViWDahwC60g
	5vwuylCzc+1Hut2p4ogMrTj2+W/rF6VPxAZnqtDE3lCcWJMcZ3aTC1RoMfMZkPsv
	5fP8Xi/FxvoYgP9P+3W9zh6//GDnELwkZa8pT0ve+vOJkItFjiT+eoajcST0bK9q
	yC0RSu0k6CyWoPDQUq8RIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764839372; x=
	1764925772; bh=/ztwZ2LCncPz/9Lf6JmOR9KE45SbTlD4TEBMpqz4fag=; b=T
	0bYVEPJnmrL4y0a6BOCZl7iPYe96cOQSld2QVp7obaxK3crJojmr2+jO9mZ/rDdQ
	iVbpoSWyfbw1rubvwcvPx95/e5ktlfTKNzj1+cgOECPpcxOC3B/04g78T0Nd9aKQ
	RM1yhj5/c6u+ml+8BsB1TsIY0Pyy7lKD4ogFrGZbMVclUdv7tSu7A7gd0QCA6tXv
	Byp5HM+3SEjxcxr720lQB3K9MZ9IK4wFcJyAOL3y05QA44AMmG6vvyJJ7X30xNcU
	Es7/YdeUYGYLWWsK+l1Hgk1679Ktoxp17Bw/BexUnEoPK7momNt9CzKwNIruiwfH
	SaVbddHKN8ntZjcAHH60g==
X-ME-Sender: <xms:y08xad0E0P7XZ3LLIRWXsGnFeuOPy51Rx0KiQ6WXE9OuSAulAiimmg>
    <xme:y08xae5zO2ABy5jAcIkXtJWEITZFqHAsIyHr6rKFj0IrT_IJG-Gbdt3FvW9eOgyy4
    V_pti8bZ4GbABl3eUD9z8NCt8JiYuxorQbeyGwH41_WL8yQg8HS-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    epvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguse
    grrhhnuggsrdguvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheprghlvgigrdgrrhhinhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsg
    hrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdifvghishhsshgthhhuhheslh
    hinhhuthhrohhnihigrdguvgdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgr
    tghlvgdrtghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhope
    hlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:y08xaYW7JMKrmf7fzz_JD-mBoOZHzxLAb0eA2of3gKoqL_r2ll9qOg>
    <xmx:y08xaYlTcb_M88NQvkSc_IR7AWQuNah2rvJjniS6MrZPV0I2xIF1-Q>
    <xmx:y08xaen3XKd5t_BSGYR0Q6juEKyYoQcwk5gJXTYVEOzo7-Myipw5tA>
    <xmx:y08xaYbE0JS3PWlbdlIRLkerzR0_feq52yvfYVV8lC1l7aUjy21EeA>
    <xmx:zE8xadprFUgKdQSdNU8x8XwasNK18z8ar7i2OdPEZmwpnags6oB0nLTK>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CB74AC40054; Thu,  4 Dec 2025 04:09:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdXoxbahDSgB
Date: Thu, 04 Dec 2025 10:09:01 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Alexander Aring" <alex.aring@gmail.com>, "Jan Kara" <jack@suse.cz>,
 "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <f6ad9bf5-6010-4974-8b37-eedd3bcc4b66@app.fastmail.com>
In-Reply-To: 
 <20251204075422-78bae8db-0be5-4053-b0b9-33fc4c7125ae@linutronix.de>
References: <20251203-uapi-fcntl-v1-1-490c67bf3425@linutronix.de>
 <75186ab2-8fc8-4ac1-aebe-a616ba75388e@app.fastmail.com>
 <20251204075422-78bae8db-0be5-4053-b0b9-33fc4c7125ae@linutronix.de>
Subject: Re: [PATCH] vfs: use UAPI types for new struct delegation definition
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025, at 07:58, Thomas Wei=C3=9Fschuh wrote:
> On Wed, Dec 03, 2025 at 03:14:31PM +0100, Arnd Bergmann wrote:
>> > --- a/include/uapi/linux/fcntl.h
>> > +++ b/include/uapi/linux/fcntl.h
>> > @@ -4,11 +4,7 @@
>> >=20
>> >  #include <asm/fcntl.h>
>> >  #include <linux/openat2.h>
>> > -#ifdef __KERNEL__
>> >  #include <linux/types.h>
>> > -#else
>> > -#include <stdint.h>
>> > -#endif
>>=20
>> I think we have a couple more files that could use similar changes,
>> but they tend to be at a larger scale:
>
> To start, let's extend the UAPI header tests to detect such dependenci=
es [0].
> Then we can clean them up without new ones popping up.

Sounds good to me. This also caused some problems when I did some
validation to find implicit padding in uapi data structures (using -Wpad=
ded).
I eventually figured out how to build all uapi headers against nolibc
on all architectures with my cross-compilers and clang.

Specifically, I needed some macro definitions for architecture specific
padding in linux/types.h.

I'll have to rebase my patches after -rc1, and we can see if it's
worth upstreaming, either the bits improve the test coverage or
the actual padding annotations I added.

>> include/uapi/xen/privcmd.h
>
> I have no idea how that header is supposed to work at all, as it depen=
ds on
> non-UAPI headers. It is also ignored in the UAPI header tests.

This is the hack I'm using to test-build the header, but I don't
think that is what we want upstream:

--- a/include/uapi/xen/privcmd.h
+++ b/include/uapi/xen/privcmd.h
@@ -36,7 +36,12 @@
=20
 #include <linux/types.h>
 #include <linux/compiler.h>
+#ifdef __KERNEL__
 #include <xen/interface/xen.h>
+#else
+typedef __u16 domid_t;
+typedef __u64 xen_pfn_t;
+#endif
=20
 struct privcmd_hypercall {
        __u64 op;

     Arnd

