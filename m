Return-Path: <linux-fsdevel+bounces-69109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0E8C6F623
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 15:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B81244FD1F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 14:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A475936C0CD;
	Wed, 19 Nov 2025 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="Msp/8Ugq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OXw9+CMn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C979A2E7165;
	Wed, 19 Nov 2025 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562320; cv=none; b=el+Zxp+6cFP3z5I9fUwSeg23DB5Ozw4pBAWwa9ERaNDWl6gQqlwed6y3RDQcP2ueiDCt5YzSdebNGNmAvOj7kBpymlaP3CNdNyyK7jRKiu7DG8B/nP5YnPhhkEuHmQPSIx89fBIakJ1EoChtIRXKUhUlyCuBwMOHdglRcXth8/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562320; c=relaxed/simple;
	bh=9SkXPt2mWvs5IIt4XRK/mbXVzF3jutwQkYzM57Xh1a8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hlR523Vl2HsvPLCZGykA4RHoR7N7GsztruZ3rzeFW+uSUgfwapSLSULNwKiESAxaSRbiQllMGQLyQDGOLT3MymbqwbgRJb7zZ9jHBaijgaEGQE7FPcNohivXHuDVYi6fHpZiFSPP5yrn3oUEPkQBQ0YkBn5HrT0nWXw+Q5hL8sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=Msp/8Ugq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OXw9+CMn; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 656701400076;
	Wed, 19 Nov 2025 09:25:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 19 Nov 2025 09:25:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1763562315; x=1763648715; bh=uSLyGu3lXBDz6tpjXdnJ72JFOQcMhNbl
	D6TTCrVdXuE=; b=Msp/8UgqaOnRUDuOe0373Q/9yP49p8WR4cUbZI78nXF8HcR6
	0eiTHDvtSsZd2CX1J6kD3BuJe88BS7VRNU2WN1sXYXxnAA+wS/GA0R0Fc71q/xG6
	bFVVmGGdWxlCoMP8kyxe5vkwIXsUl5BTbsNtG5INnPqgobN/Ctp7z8yl3/hgCRUs
	zVdy03AxBa41JNA8Xb2HhSrAllACb+ONbAgdC6cHkW6PQT2FcvhZ6wgOgPOho1pz
	jj2SD6v3yO3rK35qKAv+wH+dgmgofnTRuskytfG/Q1/mjIycJEgyYnVzviPwJkxU
	LLGrSdgNAmliJN51ZYBe44tnzqtEjSRyTM+Gyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763562315; x=
	1763648715; bh=uSLyGu3lXBDz6tpjXdnJ72JFOQcMhNblD6TTCrVdXuE=; b=O
	Xw9+CMn+lJ0H/1etQPGXj2wbErAwthvuBv/3FDaJKYXWAHGpG0CigTZO4QKVAOMD
	Bv76Wd6o/E88t4Vvga6XwC9MG+IxaDPRA3S/L4w77/J0eMO3aZ6MlBXBMa/rwjY1
	0fWTvy7Uf9A48h+EUu95jazAJyRhRRbejKAYzXEv5jACPuM4YmQtBzdUGx5siW65
	p1X5XW2SAZkC8AxfmqFJa63fYvoC4n6PT2BcyDf2f5jSGviZE3aDUpg7qsx4BDA2
	/3mY5RmZpIsOueusg548P+CNtevLc4gndxkrw//jaNZY+Rt6TRTO/Nt8w4KT1b1J
	YPzRANi97EDckp/zUSSkA==
X-ME-Sender: <xms:StMdacsOUp53RTmf_pMuxo8HYTuZvvrkO_TUTsLgHorNjLhMb8Nmuw>
    <xme:StMdaS36xKDpnR4dE0Dg9xq_SU1BBpbjb-TlcWdru7qz0SkOqCzHqiP8A1EuphRc7
    Wdt6rx99K3kszc0mvq6EBUyOX23md_1E6QeVmLt_2mjv2lVQRCxhT4>
X-ME-Received: <xmr:StMdaQQxHuTIiniNpoQSWmXFzffVI0DBa8k86gbMG7MLj_z_U7ryADSCqOWTDvZTX7CAaBhYD8GamaJaSvo2_ySaNuOTkpfI_0YRrYfh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdeggeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkgggtsehgtderredttddtnecuhfhrohhmpeetlhihshhsrgcutfho
    shhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeekjeevuefgue
    ekheejvddvjeeulefgtedtledtjeefheehtdduvdegtedtleelleenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhephhhisegrlhihshhsrgdrihhspdhnsggprhgtphhtthhopeduiedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprhgtph
    htthhopegthihphhgrrhestgihphhhrghrrdgtohhmpdhrtghpthhtohepsghfihgvlhgu
    shesfhhivghlughsvghsrdhorhhgpdhrtghpthhtohepuggvmhhiohgsvghnohhurhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhi
    htohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhtoheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:StMdaev0zCR3HVwOji2NighyzGEXgQ4XlWAe_9sQN3qcUgbjGuhQPw>
    <xmx:StMdaeJvoEDTbvtczkGll2QoFVE-blA0Eoiqm6l_dB9QqyPW6uWJUA>
    <xmx:StMdaSd5rnbF7n7y6DrA6RQgexvH5iXkiqdddbTxaniPAg0h9oBE0Q>
    <xmx:StMdaQVCDIVVYeKQoMRRNtmkdtN66zxTaTnwuDFSHrvWd7K65gVsYg>
    <xmx:S9MdaUg_Q-6U049TOA6ao_zzE74uxVh9f3NschoiGEGf6JRTntFE3HBi>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 09:25:13 -0500 (EST)
Received: by fw12.qyliss.net (Postfix, from userid 1000)
	id D0CC22287CB7; Wed, 19 Nov 2025 14:46:37 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: linux-fsdevel@vger.kernel.org
Cc: Demi Marie Obenour <demiobenour@gmail.com>, Aleksa Sarai
 <cyphar@cyphar.com>, Jann Horn <jannh@google.com>, "Eric W. Biederman"
 <ebiederm@xmission.com>, jlayton@kernel.org, Bruce Fields
 <bfields@fieldses.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann
 <arnd@arndb.de>, shuah@kernel.org, David Howells <dhowells@redhat.com>,
 Andy Lutomirski <luto@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org
Subject: Safety of resolving untrusted paths with detached mount dirfd
Date: Wed, 19 Nov 2025 14:46:35 +0100
Message-ID: <87cy5eqgn8.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Hello,

As we know, it's not safe to use chroot() for resolving untrusted paths
within some root, as a subdirectory could be moved outside of the
process root while walking the path[1].  On the other hand,
LOOKUP_BENEATH is supposed to be robust against this, and going by [2],
it sounds like resolving with the mount namespace root as dirfd should
also be.

My question is: would resolving an untrusted path against a detached
mount root dirfd opened with OPEN_TREE_CLONE (not necessarily a
filesystem root) also be expected to be robust against traversal issues?
i.e. can I rely on an untrusted path never resolving to a path that
isn't under the mount root?

[1]: https://lore.kernel.org/lkml/CAG48ez30WJhbsro2HOc_DR7V91M+hNFzBP5ogRMZaxbAORvqzg@mail.gmail.com/
[2]: https://lore.kernel.org/lkml/C89D720F-3CC4-4FA9-9CBB-E41A67360A6B@amacapital.net/

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQGoGac7QfI+H5ZtFCZddwkt31pFQUCaR3KOwAKCRCZddwkt31p
Fdj3AP0SAsCZF1PqR/445B52H+Yf19RvjVlHJh0I/X3OdGW/kAEA3flerEzGP+Fw
5F0hSZBlcJJwaEN7yFPo51mFvvMT1wA=
=74+2
-----END PGP SIGNATURE-----
--=-=-=--

