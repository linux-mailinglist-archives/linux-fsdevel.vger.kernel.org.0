Return-Path: <linux-fsdevel+bounces-24239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF4593C09E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 13:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8ABF1C2040B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 11:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BEF1990D6;
	Thu, 25 Jul 2024 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lG9L+e0s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7929E176224
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721906203; cv=none; b=KYvmLNZ8wv3LPjfuU1aF1mOLK4NwS9fmpI1GWUQPSNZvVZU5F59y8rZYiqtnOzZff776U8RjswxOM0RSVVftwumGimaWsYD5UcyqVqzzD8iqPgmZBi5jp47NUaxLMpcBG9UmjuqNkA+QsJM+AjNCWn9kBAENFynMJM2F8GOSyco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721906203; c=relaxed/simple;
	bh=O5PumLAYobTmoJ7TWng3oT+OUk7rue8hcvkQ7MweOjk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bHBTN+p1zcNJ6b5srtpSPe8gZwr2+2lFjrHTJlhAeLolNySVhepidBiAf/FZjVMsw2AnUb+ERawgBORFTEYb+m9uhj2qXx5xlCRjwmKdazVYxCwRmPQxK12MfR62Kz9z0jh3SpATL1p6HTYRJda5VYM2X4hCK9HNOJ+ShOnNZhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lG9L+e0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B56C116B1;
	Thu, 25 Jul 2024 11:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721906203;
	bh=O5PumLAYobTmoJ7TWng3oT+OUk7rue8hcvkQ7MweOjk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=lG9L+e0stFm9WkhpqNtNEnt2YbDeLDiQ88HvcqVCjOkHywfpejPKf8hIaOewiM1K6
	 JnVh0jmWaRAo6f5ZRL7fxPZ37qC8x+/l9vKRnjjcHrYbGlvLh/XVW1JCfEBmOpUBP/
	 s4Yht/TTFPJAIgdvPDWkTlyITkZiu8YTJOE38zcOEdj5i53N6zV69coFLp2UStYtBj
	 NDkbEoL6qU8GlEp2SeEVDtpaNSRrMx/53Fr4TpKEy5nLtIuSgqzzroB9cNVwcS6Ear
	 6pDrbleRqHZEBY9PFjfgmyrLm4D9Lesz6VJ6YDqXFk9/uZy8WnZQAAUHi3d3P3vPXN
	 EHVZbbtBQJNdQ==
Message-ID: <afa789e106531ebf6f41a8b8b223ef5f6df36cf0.camel@kernel.org>
Subject: Re: [PATCH RFC 1/2] fcntl: add F_CREATED
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, Jann
 Horn <jannh@google.com>, Jan Kara <jack@suse.com>, Daan De Meyer
 <daan.j.demeyer@gmail.com>
Date: Thu, 25 Jul 2024 07:16:41 -0400
In-Reply-To: <20240725-mimik-herrichten-c51d721324bc@brauner>
References: <20240724-work-fcntl-v1-0-e8153a2f1991@kernel.org>
	 <20240724-work-fcntl-v1-1-e8153a2f1991@kernel.org>
	 <41f1e62a9b54b79688d15e66499eef02075aeb2e.camel@kernel.org>
	 <20240725-mimik-herrichten-c51d721324bc@brauner>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-07-25 at 10:38 +0200, Christian Brauner wrote:
> On Wed, Jul 24, 2024 at 09:56:09AM GMT, Jeff Layton wrote:
> > On Wed, 2024-07-24 at 15:15 +0200, Christian Brauner wrote:
> > > Systemd has a helper called openat_report_new() that returns whether =
a
> > > file was created anew or it already existed before for cases where
> > > O_CREAT has to be used without O_EXCL (cf. [1]). That apparently isn'=
t
> > > something that's specific to systemd but it's where I noticed it.
> > >=20
> > > The current logic is that it first attempts to open the file without
> > > O_CREAT | O_EXCL and if it gets ENOENT the helper tries again with bo=
th
> > > flags. If that succeeds all is well. If it now reports EEXIST it
> > > retries.
> > >=20
> > > That works fairly well but some corner cases make this more involved.=
 If
> > > this operates on a dangling symlink the first openat() without O_CREA=
T |
> > > O_EXCL will return ENOENT but the second openat() with O_CREAT | O_EX=
CL
> > > will fail with EEXIST. The reason is that openat() without O_CREAT |
> > > O_EXCL follows the symlink while O_CREAT | O_EXCL doesn't for securit=
y
> > > reasons. So it's not something we can really change unless we add an
> > > explicit opt-in via O_FOLLOW which seems really ugly.
> > >=20
> > > The caller could try and use fanotify() to register to listen for
> > > creation events in the directory before calling openat(). The caller
> > > could then compare the returned tid to its own tid to ensure that eve=
n
> > > in threaded environments it actually created the file. That might wor=
k
> > > but is a lot of work for something that should be fairly simple and I=
'm
> > > uncertain about it's reliability.
> > >=20
> > > The caller could use a bpf lsm hook to hook into security_file_open()=
 to
> > > figure out whether they created the file. That also seems a bit wild.
> > >=20
> > > So let's add F_CREATED which allows the caller to check whether they
> > > actually did create the file. That has caveats of course but I don't
> > > think they are problematic:
> > >=20
> > > * In multi-threaded environments a thread can only be sure that it di=
d
> > > =C2=A0 create the file if it calls openat() with O_CREAT. In other wo=
rds,
> > > =C2=A0 it's obviously not enough to just go through it's fdtable and =
check
> > > =C2=A0 these fds because another thread could've created the file.
> > >=20
> >=20
> > Not exactly. FMODE_CREATED is set in the file description. In principle
> > a userland program should know which thread actually did the the open()
> > that results in each fd. This new interface tells us which fd's open
> > actually resulted in the file being created (which is good).
> >=20
> > In any case, I don't see this as a problem. The interface does what it
> > says on the tin.
> >=20
> > > * If there's any codepaths where an openat() with O_CREAT would yield
> > > =C2=A0 the same struct file as that of another thread it would obviou=
sly
> > > =C2=A0 cause wrong results. I'm not aware of any such codepaths from =
openat()
> > > =C2=A0 itself. Imho, that would be a bug.
> > >=20
> >=20
> > Definitely a bug. That said, this will have interesting interactions
> > with dup that may need to be documented. IOW, if you dup a file with
> > FMODE_CREATED, then the new fd will also report that F_CREATED is true.
>=20
> Yes, but it's the behavior one expects. Dup'ing an fd implies fd1->file
> =3D=3D fd2->file and so it's correct behavior. IOW, someone must confuse
> open() with dup() to be surprised by this.

It's the behavior _we_ generally expect, but a lot of people don't
understand the subtleties of file descriptions vs. file descriptors.
Spelling out this behavior explicitly would probably prevent a few
headaches.

--=20
Jeff Layton <jlayton@kernel.org>

