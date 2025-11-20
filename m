Return-Path: <linux-fsdevel+bounces-69215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 273D2C731DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 10:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 775284E872C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 09:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1E231281D;
	Thu, 20 Nov 2025 09:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="rz9KaaXB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84702116E0;
	Thu, 20 Nov 2025 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763630726; cv=none; b=Z6TgNPNzoGrrLlBiTGy/gKi5HkFyYhDksRTmUPlwx/yO/SC12cDsBl1bOkaVEGkabRXtaAjenwnYRq9MFOTclhNck4Cw/rlM8ldE6gtjMMq/7laybgaU1PqyaEW/prymVX3GWTdJSjILdiHb5mHoWCuRVGRWG4QtUpOxZLEcdkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763630726; c=relaxed/simple;
	bh=RF0ot3oTUmVd+UfiWoVlZXD8HvDSIqhD1CGs/i1fFLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcdAsiCQpHEXwJqT6Vwr4PuuhObl7SxRE/B0+vVenoEVRP0ujddJSpg3vA1dTX0edpgknOl3Rtv/saj8EB3xGdoWgfk/H2YbxagW+VeVhaTfd18Qshp5qny/v5eHp/O4OsCEXoY0BbRQEuToAixvjVT66QHnn6sfvEdU3NshiZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=rz9KaaXB; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dBtHF06Sqz9vCS;
	Thu, 20 Nov 2025 10:25:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1763630713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u8phQttnuU1JatsQgZAAR3JN6cR7M9BIHnUMPn6PNDc=;
	b=rz9KaaXBSr2KSOJKpJtb7nSdKSvo7mu+FrDeX+N8X59dGmrfdA8ieB9B+3qSauvAnRoGtv
	cfJYQ/y7Cs86N7VVsJHdynUqW7O/JZP7l16yjRTvMpq6eXUPekoJlP8je1edqUGCEZ37mT
	bdOAjXtFxWOtPqdalHXHmYEPR8m0HNKKAs01cph5c39kfE8xWXY8s4XFelQj2ekhZJCPMe
	3qMOkokRcRQHEu5V0tE5DgfhnjHtJwVZd5nqhWtD011IEUh8xn/vIsAgvFMnmuFnK7voM+
	ZSQTLSOneRGiSB8+/LzEpPbv0cIR6hNcaVvjQo2sWxWOAcX4UHP4BkUlxgFKpw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Thu, 20 Nov 2025 20:24:55 +1100
From: Aleksa Sarai <cyphar@cyphar.com>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Alyssa Ross <hi@alyssa.is>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, "Eric W. Biederman" <ebiederm@xmission.com>, jlayton@kernel.org, 
	Bruce Fields <bfields@fieldses.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
	shuah@kernel.org, David Howells <dhowells@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: Safety of resolving untrusted paths with detached mount dirfd
Message-ID: <2025-11-20-nifty-tied-sables-casualty-AgEHtJ@cyphar.com>
References: <87cy5eqgn8.fsf@alyssa.is>
 <2025-11-20-limber-salted-luncheon-scads-7AT044@cyphar.com>
 <cdf9deb2-7a09-48c5-97e2-2ea6d5901882@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="34v6rjgqhaf7iabt"
Content-Disposition: inline
In-Reply-To: <cdf9deb2-7a09-48c5-97e2-2ea6d5901882@gmail.com>
X-Rspamd-Queue-Id: 4dBtHF06Sqz9vCS


--34v6rjgqhaf7iabt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Safety of resolving untrusted paths with detached mount dirfd
MIME-Version: 1.0

On 2025-11-19, Demi Marie Obenour <demiobenour@gmail.com> wrote:
> On 11/19/25 21:18, Aleksa Sarai wrote:
> > On 2025-11-19, Alyssa Ross <hi@alyssa.is> wrote:
> >> Hello,
> >>
> >> As we know, it's not safe to use chroot() for resolving untrusted paths
> >> within some root, as a subdirectory could be moved outside of the
> >> process root while walking the path[1].  On the other hand,
> >> LOOKUP_BENEATH is supposed to be robust against this, and going by [2],
> >> it sounds like resolving with the mount namespace root as dirfd should
> >> also be.
> >>
> >> My question is: would resolving an untrusted path against a detached
> >> mount root dirfd opened with OPEN_TREE_CLONE (not necessarily a
> >> filesystem root) also be expected to be robust against traversal issue=
s?
> >> i.e. can I rely on an untrusted path never resolving to a path that
> >> isn't under the mount root?
> >=20
> > No, if you hit an absolute symlink or use an absolute path it will
> > resolve to your current->fs->root (mount namespace root or chroot).
> > However, OPEN_TREE_CLONE will stop ".." from naively stepping out of the
> > detached bind-mount. If you are dealing with procfs then magic-links can
> > also jump out.
>=20
> Is using open_tree_attr() with MOUNT_ATTR_NOSYMFOLLOW enough to prevent
> these?  Will it still provide protection even if someone concurrently
> renames one of the files out from under the root?  I know that can
> escape a chroot, but I wonder if this provides more guarantees.

That will block symlinks (in a similar manner to RESOLVE_NO_SYMLINKS),
so those particular problems would not be an issue. Of course, a lot of
symlink usages are valid and so this will block those as well (back when
I wrote openat2 I did a cursory scan and something like 15% of system
paths contained symlinks on my system).

I think that ".." will not be a problem even with renames because the
detached mount is associated with the directory (just like how moving a
bind-mount source doesn't suddenly expose more information).

It also goes without saying that you need to make sure an absolute path
*never* gets passed to any of the helper functions you write to do this
-- in my view this is usually going to be quite a fragile setup. Who is
providing the paths to your program?

> https://github.com/QubesOS/qubes-secpack/blob/main/QSBs/qsb-014-2015.txt
> was the chroot breakout.
>=20
> > You can always use RESOLVE_BENEATH or RESOLVE_IN_ROOT in combination
> > with OPEN_TREE_CLONE.
>
> Unfortunately not everything supports that.  For instance, mkdirat()
> doesn't.

You can openat2(RESOLVE_BENEATH) the parent directory and then mkdirat()
the final component (because mkdirat does not follow trailing symlinks).
This is what libpathrs[1] does, and it works for most *at() syscalls
(those that support AT_EMPTY_PATH are even easier).

[1]: https://github.com/cyphar/libpathrs

--=20
Aleksa Sarai
https://www.cyphar.com/

--34v6rjgqhaf7iabt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaR7eZxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG8YFAEA2tlI8su/QsFbnk3a10ug
+QV7M5ppRYppVgPBvTzYB10BAPeWS7V+wwoUO5gi/e1GNqMzsmkOtOyeoQOELTfr
lVIH
=EPTQ
-----END PGP SIGNATURE-----

--34v6rjgqhaf7iabt--

