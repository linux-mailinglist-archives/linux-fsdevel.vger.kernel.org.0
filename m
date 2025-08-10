Return-Path: <linux-fsdevel+bounces-57243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE008B1FB80
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 19:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2FA21769CF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 17:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139082727F3;
	Sun, 10 Aug 2025 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bzzt.net header.i=@bzzt.net header.b="Qka6HBPB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ibFpBTjG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6DC1EA7E1;
	Sun, 10 Aug 2025 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754848642; cv=none; b=PhHQoowWHmSfSeFtsFrl1lgQf5kLbk+mLJSoRrLctfRqvexmCxJ1bVOcExzUI1JVCkJYo+lPWWEp01e87jq9sXMfescsQSNvUgBh8HpIRoeh2YEl4Y/kSS86ZDjlZS31Kvlgosl9djdGKz27HcXEvb11qsalH2ZUE4YTVDLmH2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754848642; c=relaxed/simple;
	bh=fSO2pKtQJLGHg+uw3sLgbIV1Rv915LeTxSDp+iPlEGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FG+LW5KlgqGnh6qQ2jBXmJW7l+7LoueFrIQzkD+5nY2Zr4UxP/eYMI0vQwsClrFo+a53sb2uJUNQuJfvDqlY+j4gKKTCfJ6Cy1WdGlxgJwaSUGWxsPDOsvVfR8HYA7dKr578IHwguCQ7bpk4nLfFAR1oUj6we3cbA7j1G2BYMHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bzzt.net; spf=pass smtp.mailfrom=bzzt.net; dkim=pass (2048-bit key) header.d=bzzt.net header.i=@bzzt.net header.b=Qka6HBPB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ibFpBTjG; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bzzt.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bzzt.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EC79F7A005D;
	Sun, 10 Aug 2025 13:57:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sun, 10 Aug 2025 13:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bzzt.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1754848638;
	 x=1754935038; bh=CKJHwhQNQy+ROAE4lhfUgG6FBAvwCYWmzuMLynqXNDE=; b=
	Qka6HBPBqe5fFkfsB1QsgZOj02B+CQ+76ZlodrPFL+Ch8r3VIJk5Snqf0cKnkhA1
	IZ3dLri3iITKx1o65wRVm6bwyEv1gnfpvsizzGHfJQrSNDTtgJxk8tmLcbajYzBA
	OJA1ASn2woSDuMTnZr4Ip/0AwaHMRNa98/nC6iWh1B5iENqmoouEGNm5WcpZQtAi
	3eluXgNwlrPBwTw9kDqn0ksDwa2GPbUxCZO+gWzQ886tKa+gz9FXgWJBSmW+dDEB
	wxY8aO4Pz2r3IrvHVOHlEK44BOh2Jp0DHEK/s82OTf3/++9Qa7jBG9mLDr3NYnoY
	7V5Jv8FAirX6vjKFezargA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754848638; x=
	1754935038; bh=CKJHwhQNQy+ROAE4lhfUgG6FBAvwCYWmzuMLynqXNDE=; b=i
	bFpBTjGb9fCWYdq3sYwnc0SHSZGr0WTjAbLnYO7IqS1tpAd7njgM7Xu0qFrtpP3m
	gFdnLnit6gx9yjF8AkfMVilRyZ1VEeSQEaVcTMol2DHkYYs6M4myxRUvV0l0UUE4
	0Yd46zL8595Ndxs7cyMZEsrAPz75trPsXwlTkt8C+1UyeOlpLnMmUUylTDh9ZCg3
	IDuKdeRW4lihW8dScWLFA+LVWbakEISc7Y/7z+0dhDL6lPF4ybEluUcOv1fo1Xr/
	pqrbaQaDx8aTZnBXTqKbWFMHmmflnsoFrHpLvg4uPqQ2suyvsYTyk4qAXVeMn2w3
	m5njHCjRRezeCmXN3lVhA==
X-ME-Sender: <xms:fd2YaGODLmsaYYqHgAYhzfD8D87YLk_dlT3sie7l16O5O1btDznLhA>
    <xme:fd2YaAIhHDYjSjkzmFk6sVZ7Vk20nHv22OSrP0A-ZI4a6rgL_TS84h99OUilz2wmY
    pFC546vITfipt39nL8>
X-ME-Received: <xmr:fd2YaBFYsrXgcgPT6m4SvNx4z8pIzvPRMxWG3mU1b_S4PmJD2dQi87L16oZ9gYjtET2T2uHTdnhE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedtvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesthekre
    dtredtjeenucfhrhhomheptehrnhhouhhtucfgnhhgvghlvghnuceorghrnhhouhhtsegs
    iiiithdrnhgvtheqnecuggftrfgrthhtvghrnheptefhueeugeduueffudfgveeuveetje
    ehgeetvdevjefghfeltdethfeugeegvedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhr
    ghdptghouggvsggvrhhgrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhhouhhtsegsiiiithdrnhgvthdpnhgspghrtghpthht
    ohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrhigrnheslhgrhhhfrg
    drgiihiidprhgtphhtthhopegrnhhtohhnhidrrghnthhonhihsehsvggtuhhnvghtrdgt
    ohhmpdhrtghpthhtoheprghnthhonhihsehphhgvnhhomhgvrdhorhhgpdhrtghpthhtoh
    eprghsmhgruggvuhhssegtohguvgifrhgvtghkrdhorhhgpdhrtghpthhtohepsghrrghu
    nhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughhohifvghllhhssehrvgguhh
    grthdrtghomhdprhgtphhtthhopegvrhhitghvhheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fd2YaBDLZ2R5Ln6k6Z1XOkXZIwdLI8Dme8LY1SElmURnfN5lISEafQ>
    <xmx:fd2YaL2f48BRL_vkrRKQx4L17yDv_SdYFwZYMSr7yM46T9u56chk6w>
    <xmx:fd2YaONzoIRKTHhOqJEQbN7sZHuf_qqizhRCoUY8kQIr2KL5U5Jd7A>
    <xmx:fd2YaI4I-JiomzH8_jKrJt8RHA-cepX4Twx3FtxE2KZwlgxVVC2aRQ>
    <xmx:ft2YaFb6tPdtSsGjfunltI3H_MMOjEBfiMTpr3yLLBS_syheoxzx2VRh>
Feedback-ID: i8a1146c4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Aug 2025 13:57:13 -0400 (EDT)
From: Arnout Engelen <arnout@bzzt.net>
To: ryan@lahfa.xyz
Cc: antony.antony@secunet.com,
	antony@phenome.org,
	asmadeus@codewreck.org,
	brauner@kernel.org,
	dhowells@redhat.com,
	ericvh@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com,
	lucho@ionkov.net,
	maximilian@mbosch.me,
	netfs@lists.linux.dev,
	regressions@lists.linux.dev,
	sedat.dilek@gmail.com,
	v9fs@lists.linux.dev
Subject: Re: [REGRESSION] 9pfs issues on 6.12-rc1
Date: Sun, 10 Aug 2025 19:57:11 +0200
Message-ID: <20250810175712.3588005-1-arnout@bzzt.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <w5ap2zcsatkx4dmakrkjmaexwh3mnmgc5vhavb2miaj6grrzat@7kzr5vlsrmh5>
References: <w5ap2zcsatkx4dmakrkjmaexwh3mnmgc5vhavb2miaj6grrzat@7kzr5vlsrmh5>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 13 Jun 2025 00:24:13 +0200, Ryan Lahfa wrote:
> Le Wed, Oct 23, 2024 at 09:38:39PM +0200, Antony Antony a écrit :
> > On Wed, Oct 23, 2024 at 11:07:05 +0100, David Howells wrote:
> > > Hi Antony,
> > > 
> > > I think the attached should fix it properly rather than working around it as
> > > the previous patch did.  If you could give it a whirl?
> > 
> > Yes this also fix the crash.
> > 
> > Tested-by: Antony Antony <antony.antony@secunet.com>
> 
> I cannot confirm this fixes the crash for me. My reproducer is slightly
> more complicated than Max's original one, albeit, still on NixOS and
> probably uses 9p more intensively than the automated NixOS testings
> workload.

I'm seeing a problem in the same area - the symptom is slightly different,
but the location seems very similar. I'm also running a NixOS image.
Mounting a 9p filesystem in qemu with `cache=readahead`, reading a
12943-byte file, in the guest I do see a 12943-byte file, but only
the first 12288 bytes are populated: the rest are zero. This also
reproduces (most but not all of the time) on 6.16-rc7, but not on all host
machines I've tried.

After applying a simplified version of [1] (i.e. [2]), the problem does not
reproduce anymore. It seems something in `p9_client_read_once` somehow
leaves the iov_iter in an unhealthy state. It would be good to understand
exactly what, but I haven't been able to figure that out yet.

I have a smallish nix-based reproducer at [3], and a more involved setup
with a lot of logging enabled and a convenient way to attach gdb at [4].
You start the VM and then 'cat /repro/default.json' manually, and see if
it looks 'truncated'.

Interestingly, the file is read in two p9 read calls: one of 12288 bytes and
one of 655 bytes. The first read is a zero-copy one, the second is not
zero-copy (because it is smaller than 1024). I've also tried with a slightly
larger version of the file, that is read as 2 zero-copy reads, and I have not
been able to reproduce the problem with that. From my (admittedly limited)
understanding the non-zerocopy code path looks fine, though.

I hope this is helpful - I'd be happy to keep looking into this further,
but any help pointing me in the right direction would be much appreciated :)


Kind regards,

Arnout

[1] https://lore.kernel.org/all/3327438.1729678025@warthog.procyon.org.uk/T/#mc97a248b0f673dff6dc8613b508ca4fd45c4fefe
[2] https://codeberg.org/raboof/nextcloud-onlyoffice-test-vm/src/branch/reproducer-with-debugging/kernel-use-copied-iov_iter.patch
[3] https://codeberg.org/raboof/nextcloud-onlyoffice-test-vm/src/branch/small-reproducer
[4] https://codeberg.org/raboof/nextcloud-onlyoffice-test-vm/src/branch/reproducer-with-debugging

