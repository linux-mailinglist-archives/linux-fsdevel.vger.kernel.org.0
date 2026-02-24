Return-Path: <linux-fsdevel+bounces-78270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECqEHqi0nWnURAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 15:24:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4DF18853F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 15:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56D583101E36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 14:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89103A0B20;
	Tue, 24 Feb 2026 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Dw6i0uu/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D4HqaUh8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E4D3806A5;
	Tue, 24 Feb 2026 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771942912; cv=none; b=oLV2f2sT4Jn+k9BKsHGR9BG4U+ziJL/P0GwuRO65DKRk02v3srud6Lyx4FVj9pMdQwTCBxf6B7PpPbCEbTS0hQjdh4/rWMkD96MIzxABsls2mlwXOKvAD6HeJg90Cic/GKwRZfUZMZtfDbOt/bK12wI0aSLsLUS6UUaQcp/p+h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771942912; c=relaxed/simple;
	bh=ZY+nfMr6N8IaewZoqjPoliXxqmewibNuEHGDuir7EuE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JMDrUxqbjctkEvVeQLnNWbe0CHEFAB1KSt50yTBffxANcUBPUXvNSOW9zV+gCrqP/C5PFm/vb6ZX9oYnNfNJ9k/RxevPDMDcR6de2uxZsid9iHcy9oWYq3F9MCJzDl2gJoBbYU7Gx1eRy3wE0pBqFwzUupahPiaFaCQhtIkpr84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Dw6i0uu/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D4HqaUh8; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 25C857A0226;
	Tue, 24 Feb 2026 09:21:49 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 24 Feb 2026 09:21:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771942908;
	 x=1772029308; bh=e7mI4HpymDX2XCi9sMPC+TZYyqhUHKoWZGamGdWnans=; b=
	Dw6i0uu/cjeEym7qYZbcV8bbha2FtlwyYgq98MmQZqr9KnjS7uBJ4hF+w6kyjMN+
	bIN0I3pvhaTGXGpghd+AU6p1IzWQmMUNvi8eO+KMu0/fKJNMsxegOGEJCQ6JKneu
	qe3bcHcIv7bKTWquIdIRbkdwoR+yTBzVW1EAPemTTlsZUZp3+w3Ano3SvDT01HwP
	V2dHh8ZJfhfdjqS6vORYmFDEj8laqorkj3VTnI80bAOBnAOpG9TRNLKtvvfU5xGR
	GzIGCzPzCn0bTWbqKTWoR8sGZUkYXgR6TPLK1Gjbf0DnJS4Fk+oqbUMo7LqzGMSO
	Ih26J+iGO+eOzBON2feLDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771942908; x=
	1772029308; bh=e7mI4HpymDX2XCi9sMPC+TZYyqhUHKoWZGamGdWnans=; b=D
	4HqaUh8ITDXZbf8GK/kuAZjp9g2RXYdcMFppjI76TauqgBYNL3QajIOvip1Ta2T4
	BUK1vx3YdzsOYxTzlvB+vJlwOTx3QiIhTLaB6TRaGQHZ7OisD/d8cOgy+d12mdNz
	8b3xly9bkniq4Wm8un21kIRQw7y79aXUJKjkStnvFxTrfZsHRvzEzCJY4dyULPgS
	r6Xn3Yn2TWglH8F7zZmfjdnEW8l2o5vcnIbzSfWyrIixTOrk7pNw+YHzLBkSetVs
	es8nkshXWMIpsNJsH/dbRFovvp4lwVIAbWCkr0YNU7QWiMsNI2ZMl+Oq7S//hPga
	xzw6B12IRUF89fO5d0h/g==
X-ME-Sender: <xms:_LOdaSWdBJ6d23xA0gDoZ7AJ1ksEorJId6drmWVQ-JIWEnnJFb_a8w>
    <xme:_LOdaZb60DzGpTE1wrdOAJ5HezkD5jJEgEqKl1_TSU_SCzvq8gFJLLzw1PkAwoams
    dfd83hhAI8pGRUoeMlePlJOd6zYlddVMP68cy-JHA-X9sCWC88xwXc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedtfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfefhheetffduvdfgieeghfejtedvkeetkeejfeekkeelffejteevvdeghffhiefh
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvsghighhgvghrsh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhsvhgvrhhithihsehlihhsthhsrdhl
    ihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqfhdvfhhsqdguvghvvghlsehlih
    hsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtohephhgthheslhhsthdr
    uggvpdhrtghpthhtohepughsthgvrhgsrgesshhushgvrdgtiidprhgtphhtthhopehlih
    hnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhi
    nhhugidqvgigthegsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdigfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_LOdaa7nX9WLv9NNYiBHorlVQMKcXox6-7zviO9ey-NUi0MDxSOmgg>
    <xmx:_LOdacEJ1j4w7csTmSvFz7YWPT_a5R9BfV4xOvGcjR8A5jm0YCOCdQ>
    <xmx:_LOdaVBPTPMXIHVJD2d5a-PEzLE7qts4oy3tQduIfiShOP8Wjo_0mw>
    <xmx:_LOdaRwr-AYw4bHcPBNKh-ClEujeHtarlQpPAgkzGWJ24ya_brYw0g>
    <xmx:_LOdaZG7S_rCFNDrmhQ92Qg41ztV-CaW2xJNisZLfsqAmdktFGh1mpsF>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 180EC70006A; Tue, 24 Feb 2026 09:21:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AcHQldxZr-js
Date: Tue, 24 Feb 2026 15:19:35 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "David Sterba" <dsterba@suse.cz>, "Eric Biggers" <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 "Christoph Hellwig" <hch@lst.de>, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-btrfs@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-Id: <d02f6b7c-76d5-4239-8a32-8163797a81b0@app.fastmail.com>
In-Reply-To: <20260224135507.GT26902@twin.jikos.cz>
References: <20260221204525.30426-1-ebiggers@kernel.org>
 <20260224135507.GT26902@twin.jikos.cz>
Subject: Re: [PATCH] fsverity: add dependency on 64K or smaller pages
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78270-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:email,arndb.de:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 1A4DF18853F
X-Rspamd-Action: no action

On Tue, Feb 24, 2026, at 14:55, David Sterba wrote:
> On Sat, Feb 21, 2026 at 12:45:25PM -0800, Eric Biggers wrote:
>> Currently, all filesystems that support fsverity (ext4, f2fs, and btrfs)
>> cache the Merkle tree in the pagecache at a 64K aligned offset after the
>> end of the file data.  This offset needs to be a multiple of the page
>> size, which is guaranteed only when the page size is 64K or smaller.
>> 
>> 64K was chosen to be the "largest reasonable page size".  But it isn't
>> the largest *possible* page size: the hexagon and powerpc ports of Linux
>> support 256K pages, though that configuration is rarely used.
>> 
>> For now, just disable support for FS_VERITY in these odd configurations
>> to ensure it isn't used in cases where it would have incorrect behavior.
>> 
>> Fixes: 671e67b47e9f ("fs-verity: add Kconfig and the helper functions for hashing")
>> Reported-by: Christoph Hellwig <hch@lst.de>
>> Closes: https://lore.kernel.org/r/20260119063349.GA643@lst.de
>> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
>
> Makes sense to me, we have "depends on PAGE_SIZE_LESS_THAN_256KB" since
> somebody tried to use btrfs on the 256K system.

I wonder if we should just drop the configuration entirely. There
are very few users on either PowerPC44x (officially orphaned, but
I know users) and Hexagon (officially supported, but no hardware
available outside of Qualcomm). My impression is that this was
implemented purely because the hardware can do it, not because
anyone actually wants to use 256K pages.

I see that commit "e12401222f74 powerpc/44x: Support for 256KB
PAGE_SIZE" mentions how one has to patch the linker to support
larger than 64K pages, and I see that both powerpc and hexagon
linkers still hardcode the section alignment to 64K pages, for
obvious reasons.

      Arnd

