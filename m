Return-Path: <linux-fsdevel+bounces-77031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LVDB/8HjmkT+wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 18:03:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2EB12FC75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 18:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E881930166C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 17:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BABD1DF25C;
	Thu, 12 Feb 2026 17:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4GA5fbJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EECE21C16A
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770915706; cv=none; b=NVAksrNbpOlGC3ByiZg0cdwq1Xvi3Qi/GqNWBFfjzViQxlb6ANbxx2bvCjlUXmLNy1p6rl0vmdctcUH2B+siTWyMbFSksvHT3D1R1nSffmruhSBRZ8xusngtWHX11Qjc5oBDA7B5S+WFv/qL8V4A5j+vGFw7PQebIsqxlYWFJy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770915706; c=relaxed/simple;
	bh=09hHYXjgVH/7n7RfDTt/rnUTv2jaNlZmYqsGHP9Cnxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrxSnHLSA6b7g5YQWF0JJ7EsWdxzW7PDCkDgWukWjjICDI63PUeZoiw+aXeNPLhpEDMhCLyQnPRWq7fnEq72sovl/UaTKn3s07J5bvDLXXaXIpTkHOE2RVQpEB4X8jWvJa8zDmQx0+VeQKjc++BxdFkzLMHFLiTZVkled5jlElw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4GA5fbJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C08C4CEF7;
	Thu, 12 Feb 2026 17:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770915706;
	bh=09hHYXjgVH/7n7RfDTt/rnUTv2jaNlZmYqsGHP9Cnxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O4GA5fbJvLXzUY+rKXVHHcNSol6B3RvKSQ15AjIiby1dtqoB2NxAajfvZribeWPQo
	 MhQsaNrnSQozLc3WBjNUMgv0475GGYIaVW7BcmEHRWmsMNlqh2lKOgA1HVkqOU4DCK
	 g6JF7ix2eypGKe/er0NuSnMouRkjf4Jqx94yypDcsY0JLy7HT4sGrnTCHSZbF9Udqp
	 1ljN+8aaNLxHQVbDRUodTeEAEvoDpRNZUZU0XC2tuuz2OpebDrpY5bN5+xnQBlns5h
	 S2t8XtSTNpQ6EwNPU4i3HImgv5Wq3GVkNrJkWHBqLtO7KLzHrsglCjU8CuoBBRCBoD
	 kbOKZio9fPj7w==
Date: Thu, 12 Feb 2026 17:01:42 +0000
From: Mark Brown <broonie@kernel.org>
To: luca.boccassi@gmail.com
Cc: linux-fsdevel@vger.kernel.org, christian@brauner.io
Subject: Re: [PATCH] pidfs: return -EREMOTE when PIDFD_GET_INFO is called on
 another ns
Message-ID: <86ac574b-550c-44cc-ab9f-8c69735497e3@sirena.org.uk>
References: <20260127225209.2293342-1-luca.boccassi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hnl4VMc3iuPWSomG"
Content-Disposition: inline
In-Reply-To: <20260127225209.2293342-1-luca.boccassi@gmail.com>
X-Cookie: Approved for veterans.
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77031-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sirena.org.uk:url,sirena.org.uk:mid]
X-Rspamd-Queue-Id: AF2EB12FC75
X-Rspamd-Action: no action


--hnl4VMc3iuPWSomG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 10:51:37PM +0000, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <luca.boccassi@gmail.com>
>=20
> Currently it is not possible to distinguish between the case where a
> process has already exited and the case where a process is in a
> different namespace, as both return -ESRCH.
> glibc's pidfd_getpid() procfs-based implementation returns -EREMOTE
> in the latter, so that distinguishing the two is possible, as the
> fdinfo in procfs will list '0' as the PID in that case:

This is in today's next and is triggering a failure in the LTP pidfd06
testcase:

  ioctl_pidfd06.c:44: TFAIL: ioctl(pidfd, PIDFD_GET_INFO, info) expected ES=
RCH: EREMOTE (66)

which is the change that the changelog says will be introduced however
the commit log for the LTP test says:

    Verify that ioctl() doesn't allow to obtain the exit status of an
    isolated process via PIDFD_INFO_EXIT in within an another isolated
    process, which doesn't have any parent connection.

which does sound like there might actually be a problem but I've made no
effort to investigate.

Full log:

  https://lava.sirena.org.uk/scheduler/job/2451827#L4882

bisect log:

# bad: [af98e93c5c39e6d0b87b42f0a32dd3066f795718] Add linux-next specific f=
iles for 20260212
# good: [710dadb69a145f40658bc82ec9552d835d680223] Merge branch 'for-linux-=
next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
# good: [40210c2b11a873ff64a812c2d2600f529f01a83e] rust: seq_file: replace =
`kernel::c_str!` with C-Strings
# good: [b3c78bc53630d14a5770451ede3a30e7052f3b8b] nfsd: do not allow expor=
ting of special kernel filesystems
# good: [a39162f77f49b618df5a721a1e48d8b903280fbd] exportfs: clarify the do=
cumentation of open()/permission() expotrfs ops
git bisect start 'af98e93c5c39e6d0b87b42f0a32dd3066f795718' '710dadb69a145f=
40658bc82ec9552d835d680223' '40210c2b11a873ff64a812c2d2600f529f01a83e' 'b3c=
78bc53630d14a5770451ede3a30e7052f3b8b' 'a39162f77f49b618df5a721a1e48d8b9032=
80fbd'
# test job: [40210c2b11a873ff64a812c2d2600f529f01a83e] https://lava.sirena.=
org.uk/scheduler/job/2450238
# test job: [b3c78bc53630d14a5770451ede3a30e7052f3b8b] https://lava.sirena.=
org.uk/scheduler/job/2450361
# test job: [a39162f77f49b618df5a721a1e48d8b903280fbd] https://lava.sirena.=
org.uk/scheduler/job/2450244
# test job: [af98e93c5c39e6d0b87b42f0a32dd3066f795718] https://lava.sirena.=
org.uk/scheduler/job/2451827
# bad: [af98e93c5c39e6d0b87b42f0a32dd3066f795718] Add linux-next specific f=
iles for 20260212
git bisect bad af98e93c5c39e6d0b87b42f0a32dd3066f795718
# test job: [0320ace7394a2fc7d1b81c25d1f1c7cf02ff3479] https://lava.sirena.=
org.uk/scheduler/job/2450155
# bad: [0320ace7394a2fc7d1b81c25d1f1c7cf02ff3479] Merge branch 'deferred.mi=
sc-7.0' into vfs.all
git bisect bad 0320ace7394a2fc7d1b81c25d1f1c7cf02ff3479
# test job: [ab89060fbc92edd6e852bf0f533f29140afabe0e] https://lava.sirena.=
org.uk/scheduler/job/2450267
# bad: [ab89060fbc92edd6e852bf0f533f29140afabe0e] pidfs: return -EREMOTE wh=
en PIDFD_GET_INFO is called on another ns
git bisect bad ab89060fbc92edd6e852bf0f533f29140afabe0e
# first bad commit: [ab89060fbc92edd6e852bf0f533f29140afabe0e] pidfs: retur=
n -EREMOTE when PIDFD_GET_INFO is called on another ns
# test job: [72c395024dac5e215136cbff793455f065603b06] https://lava.sirena.=
org.uk/scheduler/job/2444162
# good: [72c395024dac5e215136cbff793455f065603b06] Merge tag 'docs-7.0' of =
git://git.kernel.org/pub/scm/linux/kernel/git/docs/linux
git bisect good 72c395024dac5e215136cbff793455f065603b06
# first bad commit: [ab89060fbc92edd6e852bf0f533f29140afabe0e] pidfs: retur=
n -EREMOTE when PIDFD_GET_INFO is called on another ns

--hnl4VMc3iuPWSomG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmOB3UACgkQJNaLcl1U
h9AiWQf/afvt73Ib8Zuh4z8DOfUu4qiSzNEzHCbbe8qblLf1KfJ67guvOgGW6gRg
sNWLQ7LzCnJBng80Yss1n4BbE4ES/8/imRHIUrFDtqPyqAb+GHCEdocatPdib/2i
IylnEpNbJaI1O8mBwJlPVMQGnwo+JKI5ERQ0OL7GwNQBMrlI2rTUXeXtLs5zqk1t
ZemMxCB3jtC1WZpok9sfXma4o8H3A10OZTm2LU89NRYVkPL2+NAbVwNeRtgUhx9c
TfN/Bh63vw6cOBWU1cNMvaQZIWZCVeziWh3RxiFWtxysgAUy5xvJKqFH2zFqD5Um
K7j8gOW4qJsYiWJ++8ydy1Oumzi19Q==
=gjh6
-----END PGP SIGNATURE-----

--hnl4VMc3iuPWSomG--

