Return-Path: <linux-fsdevel+bounces-77489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOUDLXYrlWkwMgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 04:01:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 234B7152C5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 04:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3001303DD2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 03:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01772DE709;
	Wed, 18 Feb 2026 03:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="IbkSmj7W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052F119DF4F;
	Wed, 18 Feb 2026 03:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771383653; cv=none; b=AiHUdoRKgy56BUzOpLdr6PDYCuOW3kPFByO0Ms7MK0tdO9QhW1C/QWwyhqk/rN9TfZa5vcmFJN3mWkg0/fmtWpWvLai+c1IuNrQopAInl4cpW2T6T/mNeD7gF8B+r17ifMmNs6h4O5LlLzvk2ugfqrEQ3eGtQp5rVDTvqJxkh3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771383653; c=relaxed/simple;
	bh=RAAkTtc2W9BDVPW6YOz8VxRJYFKM7eMDfP9VRjrKpmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZvfHHw7w9SNTbZwnZcKtSk5rca8i1Cvax+PbWdSLLPU1F8mN9ARCzziScH3Gm94D/nvXxEygSADmtaZZFkaz9nZH0QBJ1hXvv8tDzRHgES2cQC6uTa/lr21PlmAq/RHZ7pSkoh0pGxS3peRwnotZVse6FtK2tc9mG3P0imBX4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=IbkSmj7W; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fG1V55NWLz9sGX;
	Wed, 18 Feb 2026 04:00:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1771383645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RAAkTtc2W9BDVPW6YOz8VxRJYFKM7eMDfP9VRjrKpmg=;
	b=IbkSmj7Wf13fCJ5Dk2vIP+xk/chtVjpODXk038uHEQN3+mZDJt99XDRcbXsKA8qaX1oFqX
	ZrGbIwM2zYJAIb4BZ8MnwYnstULz7GoCKpnuXhTLx3hQ2zoOFwFfNxyay3I8x3q/VzmQtz
	Sfx5sRiBOr8N+jdCMNBhD6NqcoyJCkr5Z69PcPNk9XiyZYnflfKLHWYXCpTJIh1I/W0tSv
	DzqpvjV3k+kUU50aAl9TssLP4QxaRTTaxO8vPaKxBj+rZYl2s/i6HXQmLzcwJbgghRfPH4
	LjdnQwC4FFcFmBN2q8e0T9oEMBvX5q/nFLpRqzypGE+8wpFfIRDBfTMliQz6iw==
Date: Wed, 18 Feb 2026 14:00:28 +1100
From: Aleksa Sarai <cyphar@cyphar.com>
To: Shyam Prasad N <nspmangalore@gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	CIFS <linux-cifs@vger.kernel.org>, linux-nfs@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [LSF/MM/BPF TOPIC] Support to split superblocks during remount
Message-ID: <2026-02-17-grimy-washed-domes-aluminum-0HKtw9@cyphar.com>
References: <CANT5p=orpQdzqxjNronnnKUo5HFGjuVwkwpjiGHQRmwh8es0Pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pqa547cvfgjehkdu"
Content-Disposition: inline
In-Reply-To: <CANT5p=orpQdzqxjNronnnKUo5HFGjuVwkwpjiGHQRmwh8es0Pw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cyphar.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cyphar.com:s=MBO0001];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77489-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cyphar@cyphar.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[cyphar.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cyphar.com:mid,cyphar.com:url,cyphar.com:dkim]
X-Rspamd-Queue-Id: 234B7152C5B
X-Rspamd-Action: no action


--pqa547cvfgjehkdu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [LSF/MM/BPF TOPIC] Support to split superblocks during remount
MIME-Version: 1.0

On 2026-02-17, Shyam Prasad N <nspmangalore@gmail.com> wrote:
> Filesystems today use sget/sget_fc at the time of mount to share
> superblocks when possible to reuse resources. Often the reuse of
> superblocks is a function of the mount options supplied. At the time
> of umount, VFS handles the cleaning up of the superblock and only
> notifies the filesystem when the last of those references is dropped.
>=20
> Some mount options could change during remount, and remount is
> associated with a mount point and not the superblock it uses. Ideally,
> during remount, the mount API needs to provide the filesystem an
> option to call sget to get a new superblock (that can also be shared)
> and do a put_super on the old superblock.
>=20
> I do realize that there are challenges here about how to transparently
> failover resources (files, inodes, dentries etc) to the new
> superblock. I would still like to understand if this is an idea worth
> pursuing?

I gave a talk at LPC 2025 about making the mount API more amenable to
reporting these kinds of confusing behaviours with regards to mount
options[1].

It seems to me that doing this kind of splitting is far less preferable
than providing a more robust mechanism to tell userspace about what
exact mount flags were ignored (or were already applied). This has some
other issues (as Christian explains during the discussion segment) but
it seems like a more workable solution to me and is closer to what
userspace would want.

[1]: https://www.youtube.com/watch?v=3DNX5IzF6JXp0

--=20
Aleksa Sarai
https://www.cyphar.com/

--pqa547cvfgjehkdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaZUrSBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG8f/QEA15/2cBMkygIGKx2Hjfyk
7m89DdDG2KyFmD6Eeut1ExMBANGkff6GqlCerOVrFrfPYtjptTxZFTGoGHYwlH/u
sEoE
=HK5O
-----END PGP SIGNATURE-----

--pqa547cvfgjehkdu--

