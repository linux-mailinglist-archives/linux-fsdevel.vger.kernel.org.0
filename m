Return-Path: <linux-fsdevel+bounces-63389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BD2BB7DF3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 20:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513A43AE1E5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 18:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF78F2DCC1C;
	Fri,  3 Oct 2025 18:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mazzo.li header.i=@mazzo.li header.b="u/lzdkL7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x47M0Pwt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1D8285CBB
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 18:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759515524; cv=none; b=LgJKhvzVDfVVNPV4Zaked+3U+k58hvik+ADK5008zRcoW0z0vHORRwbxlbf7IdMLJ40nfn/C5p0F600ShhJHgUO5E3hpqyTaCg4sh52FxUYw95J/ljMn8IdbJqhiJGQz5GScCkLF7QY+gJaVxpVHKySvUEtU/0hqS64qwyLcFvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759515524; c=relaxed/simple;
	bh=S2QZNe4UMBLwe80jRNhaQ6gqyoRgX6npn6LxzgWf8hw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Iae6vqSy8t1SHDk7jtay1HvZZ7sIwkF208RmwXwkZbhKdV7Kwrk7QPTX6Nb4xeccYiMJB0LveDIikH0KDRNp6HX0ZARHoIkOLFy4wIliv4ABZVg6o4ztAXAAurzzdpqqykdx7koTpQjGw3Yg37Ev9BXK7dfhTZL+249eecVU2nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mazzo.li; spf=pass smtp.mailfrom=mazzo.li; dkim=pass (2048-bit key) header.d=mazzo.li header.i=@mazzo.li header.b=u/lzdkL7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x47M0Pwt; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mazzo.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mazzo.li
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5FA4E7A00CC;
	Fri,  3 Oct 2025 14:18:39 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-05.internal (MEProxy); Fri, 03 Oct 2025 14:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mazzo.li; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759515519;
	 x=1759601919; bh=S2QZNe4UMBLwe80jRNhaQ6gqyoRgX6npn6LxzgWf8hw=; b=
	u/lzdkL7iSu6bPgJji3PSF9DRHYH2+tsIzVNd01zj1Yghb+xt7CJXulGjTUwCGHw
	EOsKzh/FfNpfGpH9yiKwq0VobwBXlexEnOGWLiDcFWKVUgYHnMGwNkaaGWBPWqpE
	AfxTqpou03vZcezFwtje2m3Cy6TJGn88eY6BnI1WFsaG3uT6Vny0cICOcxTAWqMU
	gijOr4zMh4p/2lf+vMjx/cpFZsMr2kx0D/CH0u9FmcSLg1QDr8QBYgTAjwZUCiOI
	G0y5VsTnEfGN16VKAq9cNuq7p62/f4CdMuX7LG0kd3Cecg2ctfXntDNZ6jatlSw/
	CemyCOp4BGARHs4aVAsgSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759515519; x=
	1759601919; bh=S2QZNe4UMBLwe80jRNhaQ6gqyoRgX6npn6LxzgWf8hw=; b=x
	47M0PwtvX5QX65J9H3AhNHRQ6s43q42TYRlR3pdZBpsWeOZw8r2UHE07JKG+9s8V
	6dJ2/yIfaxeETezZvp30H4Zmh8rDOT7Ca+FY3NeE6lLcE4+NMrT+8iqi7w4fSkEg
	bYvfm7hDsjDxuYPyfR1zz6cYsX2KAJQamxEnI28TnciW4NKP7FGJgHf0I4N2Xov/
	QTAYT8oPDegNgLuZhsbKwkEg+ysLVDLNrTR5FWJnLy4pbtnOhkRnop1I4lo0+XIL
	cGp3aflNkV7apeUazpKabN3WOtwM970TmK23iGXHfzXgJby+mexl07doQ/znFuRL
	ybooYWpe93B/vR3viQuJg==
X-ME-Sender: <xms:fhPgaECrAwnymhqJersJPyTdoZ8PPjKzt92S9BoetHccTaEvuZ8WuQ>
    <xme:fhPgaBU--lw-nWKDAXP5hncTlERuCOCQIdf4p2WkNsGvcaxxts2E9Gf3dHyenXcmE
    oOBs7SbXv0LSRpvrAPM8xDJD79dcOwihdVWplpn7AEz_tzXUugWdac>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekleeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfhrhgrnhgt
    vghstghoucforgiiiiholhhifdcuoehfsehmrgiiiihordhliheqnecuggftrfgrthhtvg
    hrnhepffejgfevkefhiedtgfehudfgueeiuefgveehgfevffejveetfefgfffgiefgfffh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhesmh
    griiiiohdrlhhipdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmhdprhgtph
    htthhopegrmhhirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhopegsrhgruhhn
    vghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthho
    pehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fhPgaPsX3HKPZlDMabjbkQEfcDT5UbtEd1P7oUDadCsH9a_VuEOXoA>
    <xmx:fhPgaJwnk07cjSazfhcIGzIQkqLQ7Qbpp27-nr2Tiu6K0p26I-zgRA>
    <xmx:fhPgaKDUg9w5fDYmQAExYj10f9aiZ5mpzEOgElEmDBiWhzv0WN9HYQ>
    <xmx:fhPgaPdm2afLHZc3a0GYwax40pgvO-ys9pefd6p5-gFPBLj5yZlhZA>
    <xmx:fxPgaMblXrcP4oNIrzctuXfnBNu-0dPt5Vik3NOU9zbRmKuRmn1FnfnS>
Feedback-ID: i78a648d4:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7CE85216005F; Fri,  3 Oct 2025 14:18:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AKLrIgF2TFVc
Date: Fri, 03 Oct 2025 19:18:18 +0100
From: "Francesco Mazzoli" <f@mazzo.li>
To: "Bernd Schubert" <bernd.schubert@fastmail.fm>,
 "Amir Goldstein" <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, "Christian Brauner" <brauner@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>, "Miklos Szeredi" <miklos@szeredi.hu>
Message-Id: <8e7a527f-2536-45d2-891a-3e203a5011ab@app.fastmail.com>
In-Reply-To: <7747f95d-b766-4528-91c5-87666624289e@fastmail.fm>
References: <bc883a36-e690-4384-b45f-6faf501524f0@app.fastmail.com>
 <CAOQ4uxi_Pas-kd+WUG0NFtFZHkvJn=vgp4TCr0bptCaFpCzDyw@mail.gmail.com>
 <34918add-4215-4bd3-b51f-9e47157501a3@app.fastmail.com>
 <7747f95d-b766-4528-91c5-87666624289e@fastmail.fm>
Subject: Re: Mainlining the kernel module for TernFS, a distributed filesystem
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 3, 2025, at 18:35, Bernd Schubert wrote:
> Btw, I had see your design a week or two ago when posted on phoronix and
> looks like you need to know in FUSE_RELEASE if application crashed. I think
> that is trivial and we at DDN might also use for the posix/S3 interface,
> patch follows - no need for extra steps with BPF).

It's a bit more complicated than that, sadly. I'd imagine that FUSE_RELEASE
will be called when the file refcount drops to zero but this might very well be
after we actually intended to link the file. Consider the case when a process
forks, the children inherits the file descriptors (including open TernFS
files), and then the parent close()s the file, intending to link it. You won't
get FUSE_RELEASE because of the reference in the child, and the file won't be
linked as a consequence.

However you can't link the file too eagerly either for the reverse reason. What
you need is to track "intentional" closes, and you're going to end up relying
on some heuristic, unless you use something like O_TMPFILE + linkat.

In the kernel module we do that by tracking where the close came from and if
the close is being performed as part of the process winding down. We only link
the file if the close is coming from the process that created the file and not
as part of process winddown. This particular heuristic that has worked well for
us, and empirically it has been quite user friendly.

In FUSE with BPF we do something arguably more principled: we mark a file as
"explicitly closed" if it was closed through close(), and only link it after an
explicit close has been recorded.

> Fuse sends LOOKUP in fuse_dentry_revalidate()? I.e. that is just a userspace
> counter then if a dentry was already looked up? For the upcoming
> FUSE_LOOKUP_HANDLE we can also make sure it takes an additional flag argument.

Oh, I had not realized that FUSE will return valid if the lookup is stable,
thank you. You'll still pay the price of roundtripping through userspace
though, and given how common lookups are, I'd imagine tons of spurious lookups
into the FUSE server would still be unpleasant.

> I agree on copying, but with io-uring I'm not sure about a request queue issue.
> At best missing is a dynamic size of ring entries, which would reduce memory
> usage. And yeah, zero-copy would help as well, but we at DDN buffer access
> with erase coding, compression, etc - maybe possible at some with bpf, but right
> now too hard.

I'll have to take a look at FUSE + io_uring, won't comment on that until I'm
familiar with it :).

Francesco

