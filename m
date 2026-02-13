Return-Path: <linux-fsdevel+bounces-77116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JdoCyr0jmnDGAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 10:51:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9FD134B0B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 10:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 989EA3014079
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 09:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050F234F469;
	Fri, 13 Feb 2026 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="NbLwgaIO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE7F2DF146
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 09:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770976289; cv=none; b=MW69YD0dhcPAISLsz/fOsP/5gYbnppNqOqkdDg+bu4y3DscTGs+EHlR572FswiUYecKu8+nSCR5xQkEvYQN1k8CvQQP4MCgqwHYOAhKFOyfkkBVXQPfGvz7hMTtcBO208dt19YQxXj0ZQdj7iGoJeLgfgy9kp3+iayZKl0iX5vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770976289; c=relaxed/simple;
	bh=1CyGSMyvWqDImBSIjoU/O05J+ttS6fr+dJAdzNpNxmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnTD2wp1eur+RpSqhs4gwXzdcBIhpHVFyv+c5Ckt5B5Q9RiJR3KcEbhgroYWZPmCiZ3rST0bBgfIwR2x0fHciQRuFKAuhhIgmHYClRxRGc9cRLpfxoMR7hpWLMGCRDVpcSdwiqBpGJrzlNaSZs5WMiRWls9KRQOd2Pdqp/NYoYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=NbLwgaIO; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fC6r43smQz9srB;
	Fri, 13 Feb 2026 10:51:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1770976276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0XJeAuMRxEOi8SYgKVEsfc7ExRb8YS8n3qZ/MeJidqE=;
	b=NbLwgaIOTpgFp+YPcqGtgtlt6Zwg/7Txw7tCONkx/QnO0gX1zE5xYzd34WCpiA6pmm9Bag
	ilvSk7pDH//aFV0t+h0iW4M1edqS6lfMrYoQ31xmAnKstVtTufoA66eHOc35tloN1bB172
	FIGza77jb0wickU3XhKB60eV1SAzzSBStDCj7pzGxRccQVEu1XseMrmI6bfgs/nFMWIKVi
	veaDjDXHaD/A96qxi+BtM7ktCzpXh8jRyqHfOR50BAF5iAgTQVL7NdOc24IWTazficBuGB
	6QOWVwB1jz8trajipe1M3Nd6oUnG+2KkPe2K/hGu2Fs4nh0i19U09MKyWgHNlg==
Date: Fri, 13 Feb 2026 20:51:07 +1100
From: Aleksa Sarai <cyphar@cyphar.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Askar Safin <safinaskar@gmail.com>, christian@brauner.io, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, werner@almesberger.net
Subject: Re: [RFC] pivot_root(2) races
Message-ID: <2026-02-13-crispy-unlucky-servers-sequels-4N1yCT@cyphar.com>
References: <CAHk-=wikNJ82dh097VZbqNf_jAiwwZ_opzfvMr-8Ub3_1cx3jQ@mail.gmail.com>
 <20260212171717.2927887-1-safinaskar@gmail.com>
 <CAHk-=wgS5T7sCbjweEKTqbT94XxmcPzppz6Mi6b8nKve-TFarg@mail.gmail.com>
 <1FC2FB1F-BDA5-472D-A7DB-D146F6F75B16@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qye2mpmasnupusmr"
Content-Disposition: inline
In-Reply-To: <1FC2FB1F-BDA5-472D-A7DB-D146F6F75B16@zytor.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cyphar.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[cyphar.com:s=MBO0001];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,brauner.io,suse.cz,vger.kernel.org,zeniv.linux.org.uk,almesberger.net];
	TAGGED_FROM(0.00)[bounces-77116-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cyphar.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cyphar@cyphar.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4D9FD134B0B
X-Rspamd-Action: no action


--qye2mpmasnupusmr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC] pivot_root(2) races
MIME-Version: 1.0

On 2026-02-12, H. Peter Anvin <hpa@zytor.com> wrote:
> On February 12, 2026 11:11:55 AM PST, Linus Torvalds <torvalds@linux-foun=
dation.org> wrote:
> >On Thu, 12 Feb 2026 at 09:17, Askar Safin <safinaskar@gmail.com> wrote:
> >>
> >> In my opinion this is a bug. We should make pivot_root change cwd and =
root
> >> for processes in the same mount and user namespace only, not all proce=
sses
> >> on the system. (And possibly also require "can ptrace" etc.)
> >
> >Yeah, I think adding a few more tests to that
> >
> >                fs =3D p->fs;
> >                if (fs) {
> >
> >check in chroot_fs_refs() is called for.
> >
> >Maybe just make it a helper function that returns 'struct fs_struct'
> >if replacing things is appropriate.  But yes, I think "can ptrace" is
> >the thing to check.
> >
> >Of course, somebody who actually sets up containers and knows how
> >those things use pivot_root() today should check the rules.
> >
> >               Linus
>=20
> It would be interesting to see how much would break if pivot_root()
> was restricted (with kernel threads parked in nullfs safely out of the
> way.)
>=20
> I have gotten a feeling that pivot_root() is used today mostly due to
> convenience rather than need.

Speaking as probably the heaviest user of pivot_root(2) on modern
systems (container runtimes), we still need to use it today to configure
mount namespaces for containers in a sane way.

But (as Christian mentioned elsewhere), the new OPEN_TREE_NAMESPACE
stuff opens the door to eliminating this requirement for container
runtimes by sidestepping the whole "clone a mntns and its mounts that
you need to blow away later" dance that we currently do with
unshare(CLONE_NEWNS) + pivot_root().

--=20
Aleksa Sarai
https://www.cyphar.com/

--qye2mpmasnupusmr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaY70CxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG/eDgEA7h5vqvpdc3Rm6ZnT4rTq
97J/gqlQrK9Eg5tRKvG+q/wBAJAkC7WD1GW3wNVm2J6Mzx5wtEZU4wRrWVT8INBv
5aUC
=1FUS
-----END PGP SIGNATURE-----

--qye2mpmasnupusmr--

