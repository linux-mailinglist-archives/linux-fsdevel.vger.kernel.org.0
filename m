Return-Path: <linux-fsdevel+bounces-75476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8An+OZ6Od2m9hgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 16:56:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BB58A5F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 16:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CBC8301ECFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 15:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78347341057;
	Mon, 26 Jan 2026 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="GgFGGIz5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xIj7htBj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F6033F368;
	Mon, 26 Jan 2026 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769442948; cv=none; b=TuVrYioBxN4ZE0m2PdTYtpKjX2JtyQ83E6RNeRVHEdesVFnd88yZ9UziUOwmU1x4OXrB+nB7ce9wAtiUEa6hD5Q1cJfjqWd2T2j+pGTkEYpyOknKxeo3h9jftqC9kllDCpNzU3B1LJjh9T4CPo4C4WhHEe2NBjJGDFLwhp83i74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769442948; c=relaxed/simple;
	bh=rb5R7JXNwig6A8hF/CHe/VvCS1Cr8hFL1HjQlCZ6u08=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rKEbA97fwXvwzFctPLieYEEf1jYYpTJENG8HxR5kgsjEO3pf/0ipIz5ofKpdbDESbyalNsLBRSQ3ahQQnhMoD4l0P3g6HtOYpYOgALtqqW3LMi4kGyYSKgfWO+82AqSFq0+Rt4nR984fCAgc+dZDd6FR9T0ibE33vPDFWVuFPdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=GgFGGIz5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xIj7htBj; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 90BF1EC021F;
	Mon, 26 Jan 2026 10:55:45 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 26 Jan 2026 10:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769442945;
	 x=1769529345; bh=Dxv3fy7a9waPSHSm5jZkF31RjhZVUqYCjtFysImUS8s=; b=
	GgFGGIz5oR/FhffMa/1xQvNOLNNkl7+tLcBz4dZucD/xKxg+IVwC8bOG+HJU5I+K
	KUVDRNOwNLU3cwuWlmuqj557dL0+hjG8OC1w6qjM/aeNRuRXhyPu4G2YgWFhP7R8
	A2F5uoNV6NO6tIY0kf2REuYuTm6k4+ucp+B3mnkohoRorDnWVzNbOijbLdWukpm1
	UkdrCsjrfL6m1foLzxFArPNqHASG7hOuWrECR0Lz/WEioIlO4GSziCBgnufftDAw
	gf2RW9BHlv7gD+ZF4tPx7xwqRkpFhIqZy9TVq0RlBufl1sSc3CsQ39vXKYFpU4T1
	rpFSL0oe5uKhSkOQNadr3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769442945; x=
	1769529345; bh=Dxv3fy7a9waPSHSm5jZkF31RjhZVUqYCjtFysImUS8s=; b=x
	Ij7htBjqjpljyMl8RLPt9FM4UfHNER4KkFjR9JIz7Gqik1UNE8CGRMteBCj2WQfF
	3hAyq4Gmmpiul5NEtQFxAkpRmzBi5qMfXu460MoVFTtsgkv34VwblUfK4tcNokAs
	D/Nqrqy+aNjPRK4qYje8JF09Ea18gHP41zBy3aQ7jJC4TIIo3+gO1VE4bDQdVPMC
	78OMxLpYRamWihVlu18S0cthOtph7Zit8ed8fDSwFWo3Gy1tM3P5KYjRD8SsX03p
	ZsLJ09UJQ/ixoQEIORRsoIL+MIseWSkvNWN4WDpGO2TiSMyEv5QQaaroV8es5Th3
	KBYOxsd1iZRWmj6gNav4A==
X-ME-Sender: <xms:gY53aQedRzG9jRHwoP8nn_EZve83j8oZ21GFH8UutyhfUNgfDmYEdg>
    <xme:gY53adD5lAIFiiVjlS3FfQ2ActTi5j1uU7JCyD2glJZ3JfnX2VNUkYxxV1BJTX9z7
    yhqA-R5KWMAB2VXPgIv-vfs8SRq7aBkJ6u6z_A7nl1Su1wtm0lJCS8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheektdekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:gY53ab-fh9Maxq-PqAHXYkkOQyL_teXc2QTMHaPeB87GwUKU7n6LYA>
    <xmx:gY53aayfzQBKgbFOit1wPZUSqX1Gc5sZdMcCla-0iqnA0ancNDvWkA>
    <xmx:gY53aTpcr8tF-X5Pn-BNaUzprpHR1cbn7eEDQfYwrQgUoHF8ZYlNKA>
    <xmx:gY53aTrYAHFQVf8Mu5DoPGz5FmnWwo_nLFbrzlmn92-pCGuBl1HVFg>
    <xmx:gY53aTqNz9EJZod1XAJQrKkQKmwRqbB8L6dEQ6qSnlyU6EXtbsjdT_oL>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 07812700069; Mon, 26 Jan 2026 10:55:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AuviwbZQ_R9V
Date: Mon, 26 Jan 2026 16:55:24 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dorjoy Chowdhury" <dorjoychy111@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Jeff Layton" <jlayton@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Alexander Aring" <alex.aring@gmail.com>
Message-Id: <6c9d7f9b-36ea-4222-8c10-843f726b6e62@app.fastmail.com>
In-Reply-To: <20260126154156.55723-2-dorjoychy111@gmail.com>
References: <20260126154156.55723-1-dorjoychy111@gmail.com>
 <20260126154156.55723-2-dorjoychy111@gmail.com>
Subject: Re: [PATCH v2 1/2] open: new O_REGULAR flag support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-75476-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 68BB58A5F3
X-Rspamd-Action: no action

On Mon, Jan 26, 2026, at 16:39, Dorjoy Chowdhury wrote:

> diff --git a/arch/parisc/include/uapi/asm/fcntl.h 
> b/arch/parisc/include/uapi/asm/fcntl.h
> index 03dee816cb13..efd763335ff7 100644
> --- a/arch/parisc/include/uapi/asm/fcntl.h
> +++ b/arch/parisc/include/uapi/asm/fcntl.h
> @@ -19,6 +19,7 @@
> 
>  #define O_PATH		020000000
>  #define __O_TMPFILE	040000000
> +#define O_REGULAR	060000000

This is two bits, not one, and it overlaps with O_PATH|__O_TMPFILE.

The other ones look like they are fine in this regard, but I'm
still unsure if we should be using the next available bit, or
reusing an unused lower bit, e.g. these bits removed in commit
41f5a81c07cd ("parisc: Drop HP-UX specific fcntl and signal flags"):

-#define O_BLKSEEK      000000100 /* HPUX only */
-#define O_RSYNC                002000000 /* HPUX only */
-#define O_INVISIBLE    004000000 /* invisible I/O, for DMAPI/XDSM */

     Arnd

