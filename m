Return-Path: <linux-fsdevel+bounces-78284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGBPF1HVnWk0SQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 17:44:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C177F189F56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 17:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB4623051847
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 16:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EBA3A63EB;
	Tue, 24 Feb 2026 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuSb3AGt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD483A9616
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771951031; cv=none; b=cg5Ro6P1ozpfTEwV/Xs2e5xxYXBv0EjS2kqRB1/IgBp+BMmG+fC/RPMB6A3eK+TcsjgWx+dg9XAnZORUhWKeNNeiZUok0jDF/mVs1YBAfYjf/7pz9sf6TTF+UWuew+zvIwT42jZ2RQEiYJ6dGm0dQSXiKKhQ6qcvEr971JHKn24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771951031; c=relaxed/simple;
	bh=p/9SdvBSogz8pVh5FXvynPjBzAfPBEKuHPbg+eeIrK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckEzB8Qb8lUigGNEADMAKzRXO/ziFqWjxRfdbX5HVcotvVlmrhogq3QzUhz8Gsj1GBAk4UpMoOjCT11dM/j2OVxqUtkg0Fd+hEw0ZolsawMMjfMSSPIwskOGUR/ACpRw2C4MxForHQmjmtAfGY9IgIIfQeCGCBO9/uCiTR85PWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuSb3AGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01330C19425;
	Tue, 24 Feb 2026 16:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771951031;
	bh=p/9SdvBSogz8pVh5FXvynPjBzAfPBEKuHPbg+eeIrK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LuSb3AGt4iG0vU6TWGNuVTm6HCDCs04OHP1s3q1TfPp2SmNTJdokKVBxKWT8jjsF+
	 0EBHCz2r56H8AJAbxjpiXxvVzkqCKFTm/B7EExsG3Gv2j1Q2uIjY0MKDsIMY7VeeDd
	 vo7Zk2Id8kRXRfTDI7yw3EkWT7wP5vKV7S2sQVsF28xV/46922RSDR9AP3oSxIqZN/
	 33Sm0VlfZSy7370UY1T2KBJweQ8ZZwr32IngQXclk1wklkk/fs8qciA7WmPJKP1MBP
	 jRuHIDRv1G2bP8sMpzSLwTMV6Zzrasi5S9A2LLOl4UTs5Ls75HkA4gQ6jhnPfpdHeb
	 cNAmyZMePdFWQ==
Date: Tue, 24 Feb 2026 16:37:02 +0000
From: Mark Brown <broonie@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Guillaume Tucker <gtucker@gtucker.io>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, kunit-dev@googlegroups.com,
	David Gow <davidgow@google.com>
Subject: Re: [PATCH RFC v2] pidfs: convert rb-tree to rhashtable
Message-ID: <c4a6ffe9-f625-4c0a-83f4-a2ea5451f914@sirena.org.uk>
References: <20260120-work-pidfs-rhashtable-v2-1-d593c4d0f576@kernel.org>
 <0150e237-41d2-40ae-a857-4f97ca664468@gtucker.io>
 <20260224-kurzgeschichten-urteil-976e57a38c5c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1kvh4KE5BqJ6Lwrs"
Content-Disposition: inline
In-Reply-To: <20260224-kurzgeschichten-urteil-976e57a38c5c@brauner>
X-Cookie: An apple a day makes 365 apples a year.
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78284-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gtucker.io,gmail.com,zeniv.linux.org.uk,suse.cz,vger.kernel.org,googlegroups.com,google.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C177F189F56
X-Rspamd-Action: no action


--1kvh4KE5BqJ6Lwrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 24, 2026 at 02:22:31PM +0100, Christian Brauner wrote:
> On Fri, Feb 20, 2026 at 04:11:43PM +0100, Guillaume Tucker wrote:

> > we can see that the last pointer ffffffff99026d40 was never enqueued,
> > and the one from free_pid() ffffffff988adaf0 was never dequeued.
> > This is where I stopped investigating as it looked legit and someone
> > else might have more clues as to what's going on here.  I've only
> > seen the problem with this callback but again, KUnit is a very narrow
> > kind of workload so the root cause may well be lying elsewhere.

> > Please let me know if you need any more debugging details or if I can
> > help test a fix.  Hope this helps!

> Thanks for the report. I have so far no idea how that can happen:

> * Is this reproducible with multiple compilers?

FWIW I've been seeing RCU stalls and crashes in KUnit while building
-next which I believe are the same as Guillaume is reporting, these have
reproduced with multiple arches using the Debian GCC 14 and with LLVM
for me.  Example of my command line:

   ./tools/testing/kunit/kunit.py run --arch arm64 --cross_compile=aarch64-linux-gnu-

> * Is this reproducible on v7.0-rc1?

The issues I'm seeing certainly are.  I just tried testing on this
specific commit (802182490445f6bcf5de0e0518fb967c2afb6da1) and managed
to have KUnit complete though...

> Fwiw, we're missing one check currently:

...

> But it seems unlikely that pidfs_add_pid() fails here.

That doesn't seem to have any impact for me.  I suspect that there may
be multiple interacting changes triggering the issue (or making it more
likely to occur) which isn't helping anything :/  See also:

   https://lore.kernel.org/r/59e8c352-7bc8-4358-af74-fee8c29280ba@davidgow.net

--1kvh4KE5BqJ6Lwrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmd060ACgkQJNaLcl1U
h9Bawgf7Byz6T02MG5YslfytZUJofCIUAFR4lrIs2kl6znYF0p9FwaJ00oMsRyu0
HweVZgFLwSpSFBYXqt7q5zrAtbrilUHt4ZP7d1CGgirm610rzptxY7TYSLwJb57I
CmWl0VPYmgPHcvvWqk9sffgfR7ANGHoq+ca+B44zCv/kE0uPUX+0rN36tVZifClY
IaaNyf2eEYRWs0zlxEhUvhw2ETd7ClW4zDst7+sdZqgnk2Yv8UtgOK7s1H/AYrMI
mMBFBLSK2EAVAziMhYoViVfxGJ6zvWbR7o/ZuhGU+2ZExrxhrYIngim5DcQWx2pv
q1d3UkvD/WyFo8CP70t+vd85EdOC6A==
=Q2Kb
-----END PGP SIGNATURE-----

--1kvh4KE5BqJ6Lwrs--

