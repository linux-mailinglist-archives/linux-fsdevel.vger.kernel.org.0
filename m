Return-Path: <linux-fsdevel+bounces-57511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EE5B22AD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 16:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556343BF580
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 14:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22D42EBBA8;
	Tue, 12 Aug 2025 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="tAlp9wc+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3831C861D;
	Tue, 12 Aug 2025 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009429; cv=none; b=NP3Xtdoi6wadK1kpmOfWQ5XCQnUFugsVmC5f+/uBKeEsPXLQVBuMjf13SpvcM3CPEKteWp4F6qUnupXz/lraWagkUh9LLu/3BCqBFSXUOJkk8OjaFI87XInx82vcCp2c3NbW4nY98AmoJq0rSUbTyHmhiQeyDh+zTKKSUZWR87k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009429; c=relaxed/simple;
	bh=TVkjW699CHZWgxRNPot9inBJGX3alnLe8d6qC+rLCWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vm8w6750FE5C+hgmEAyiL5yj2Wk513Si3xnZgdpaICanTbPC4STKaSPvXrYfhyZpXIrSKMClJnYI7RLQhN55bm9F1pxr45HF0w8V5bZBLtzAi1jCuwxJY3mvtWHDZJ2xwSdZ+A6QC/CNbTewPClzoGhF0jHpGGh5hpUVtFxXDRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=tAlp9wc+; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4c1YxC4CCGz9v0C;
	Tue, 12 Aug 2025 16:37:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1755009423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TVkjW699CHZWgxRNPot9inBJGX3alnLe8d6qC+rLCWk=;
	b=tAlp9wc+C9dE6hf/4ILGAxbE2sP0x0VA5GCrFgrNA/dd/Td+3CvDv2odkMJS1ueO0qZ2vw
	0YXKuaHuvQh4+7p+yzo45xHfyRFUsYfbdx4TGV0L+EXCtozOBIE+BrYX99G4wzQGFAqP6+
	3ogZQQ9fuI8HRvtBXLc8W3wkntIg49YFcr6wObxdM0sKQw/hTWLALn5g1YtMTg3X2c3m1a
	25UazPIMnha9f6Udh4p9gmD7IG1KKVSSOz0sF9Qyebe8pOdytSDrt8FgcV7PZ1Bh9pWN30
	U3DRTOmK8dE/XLMeec601qZnTzCrPQObhhS7fa8n2Fot6U8utw9Y6qIAazCLQg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Wed, 13 Aug 2025 00:36:53 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Alejandro Colomar <alx@kernel.org>, 
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
	linux-man <linux-man@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3 08/12] man/man2/move_mount.2: document "new" mount API
Message-ID: <2025-08-12.1755009210-quick-best-oranges-coats-BNJpCV@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
 <20250809-new-mount-api-v3-8-f61405c80f34@cyphar.com>
 <1989db97e30.b71849c573511.8013418925525314426@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kaz3kqcj5ydq3bak"
Content-Disposition: inline
In-Reply-To: <1989db97e30.b71849c573511.8013418925525314426@zohomail.com>
X-Rspamd-Queue-Id: 4c1YxC4CCGz9v0C


--kaz3kqcj5ydq3bak
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 08/12] man/man2/move_mount.2: document "new" mount API
MIME-Version: 1.0

On 2025-08-12, Askar Safin <safinaskar@zohomail.com> wrote:
> move_mount for v2 contained this:
> > Mounts cannot be moved beneath the rootfs
>=20
> In v3 you changed this to this:
> > Mount objects cannot be attached beneath the filesystem root
>=20
> You made this phrase worse.
>=20
> "Filesystem root" can be understood as "root of superblock".
> So, please, change this to "root directory" or something.

Maybe I should borrow the "root mount" terminology from pivot_root(2)?
(Though they use "root mount in the mount namespace of the calling
process", which is a little wordy.) I didn't like using "rootfs" as
shorthand in a man-page.

> > This would create a new bind-mount of /home/cyphar as attached mount ob=
ject, and then attach
> You meant "as detached mount object"

Thanks, I have already fixed this in my branch (and the two other
misuses of "attach" in fsopen(2)). FWIW, open_tree(2) was the first
man-page in this series that I wrote, so I hadn't settled on the wording
the first draft.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--kaz3kqcj5ydq3bak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaJtRhRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG8g8gEAtNCs9V+TudnOJxLO88wp
xHxmYljMCq1nezCIuWn4s0EBAIXtGQxv9lKRFLj/dEZXk0Y0gQ6Ecu867n5EzFvA
xhIK
=ifx0
-----END PGP SIGNATURE-----

--kaz3kqcj5ydq3bak--

