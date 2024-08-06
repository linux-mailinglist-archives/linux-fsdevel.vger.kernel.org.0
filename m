Return-Path: <linux-fsdevel+bounces-25136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD74C949566
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 18:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 923C428203E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 16:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1382D613;
	Tue,  6 Aug 2024 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARD8PGZl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5048518D635;
	Tue,  6 Aug 2024 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722961040; cv=none; b=Kis3C+vFR4S2KEWH9+nA7I2coZrwIPzyoM0MD9DCJMwmHiWYDIrL4Zn9X1WqR1H5ldp8SgI7fWPTy5ieC2/kuYbxlvKfKabhwaRbZw8+s7XK9AYATZ4njptmJ1d2nhFQ3VAoO0LHxV2GDmNpPnuTOo9I1TnDNEwW9oP46A6aRcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722961040; c=relaxed/simple;
	bh=P7qUrUlUJvLXkQ+a2mx7vAKlClxJBD7KrgVMUtkPSQ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kX6hC7FYytX0csk/il9uyJJ9tpJ2IDAAeemdfzwDoY6EQJt1TgC3Fxa1vNHTbOSgTf4kelHkUvIy/8rNo8QVKmEfIoBemJ+7GSl5J0ZvgbGNSSV79HPyW7ti6ykWJ8Pa2tcu2skAK/J1MD2y6VxjD2SvDa4rz5XVQ+8BoYsKjp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARD8PGZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B85C32786;
	Tue,  6 Aug 2024 16:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722961040;
	bh=P7qUrUlUJvLXkQ+a2mx7vAKlClxJBD7KrgVMUtkPSQ0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ARD8PGZlc8nX6j6s9dR3k9oJpZc8HXQPPKTXgwBu9FGau5VluADHNYbIwao+KUbDv
	 vTtiz2lNbODgRGDP9yMX3v3/sfxTUPA7Gy/Di+z8bNS+zjo78zf2Ygk4NcRkF8hWmb
	 4Tz4y+aLIpTE4Y+zwglfxAYjU2vbULI2logPltt8RoWlwbmGZv9XVqHlqJ9M/eC/64
	 9gNQ0xuIx3dC1c2XNxYlbxtyoCQDJXLdPm8QVoG+t/b8KcxgmBJJHukPmuzVUTf4t0
	 JpSmSw4NmYc12fYSw4TfGb15PXBAYlKZ5hE8qGw4qDqPXHEtmH/czhUhJdUqUQAMFM
	 +M7OMaU+8cnHg==
Message-ID: <915bca37dc73206b0a79f2fba4cac3255f8f6c0d.camel@kernel.org>
Subject: Re: [PATCH v2] fs: try an opportunistic lookup for O_CREAT opens too
From: Jeff Layton <jlayton@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrew Morton
	 <akpm@linux-foundation.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 06 Aug 2024 12:17:12 -0400
In-Reply-To: <CAGudoHF9nZMfk_XbRRap+0d=VNs_i8zqTkDXxogVt_M9YGbA8Q@mail.gmail.com>
References: <20240806-openfast-v2-1-42da45981811@kernel.org>
	 <CAGudoHF9nZMfk_XbRRap+0d=VNs_i8zqTkDXxogVt_M9YGbA8Q@mail.gmail.com>
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

On Tue, 2024-08-06 at 17:25 +0200, Mateusz Guzik wrote:
> On Tue, Aug 6, 2024 at 4:32=E2=80=AFPM Jeff Layton <jlayton@kernel.org>
> wrote:
> >=20
> > Today, when opening a file we'll typically do a fast lookup, but if
> > O_CREAT is set, the kernel always takes the exclusive inode lock. I
> > assume this was done with the expectation that O_CREAT means that
> > we
> > always expect to do the create, but that's often not the case. Many
> > programs set O_CREAT even in scenarios where the file already
> > exists.
> >=20
> > This patch rearranges the pathwalk-for-open code to also attempt a
> > fast_lookup in certain O_CREAT cases. If a positive dentry is
> > found, the
> > inode_lock can be avoided altogether, and if auditing isn't
> > enabled, it
> > can stay in rcuwalk mode for the last step_into.
> >=20
> > One notable exception that is hopefully temporary: if we're doing
> > an
> > rcuwalk and auditing is enabled, skip the lookup_fast. Legitimizing
> > the
> > dentry in that case is more expensive than taking the i_rwsem for
> > now.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > Here's a revised patch that does a fast_lookup in the O_CREAT
> > codepath
> > too. The main difference here is that if a positive dentry is found
> > and
> > audit_dummy_context is true, then we keep the walk lazy for the
> > last
> > component, which avoids having to take any locks on the parent
> > (just
> > like with non-O_CREAT opens).
> >=20
> > The testcase below runs in about 18s on v6.10 (on an 80 CPU
> > machine).
> > With this patch, it runs in about 1s:
> >=20
>=20
> I don't have an opinion on the patch.
>=20
> If your kernel does not use apparmor and the patch manages to dodge
> refing the parent, then indeed this should be fully deserialized just
> like non-creat opens.
>=20

Yep. Pity that auditing will slow things down, but them's the breaks...

> Instead of the hand-rolled benchmark may I interest you in using
> will-it-scale instead? Notably it reports the achieved rate once per
> second, so you can check if there is funky business going on between
> reruns, gives the cpu the time to kick off turbo boost if applicable
> etc.
>=20
> I would bench with that myself, but I temporarily don't have handy
> access to bigger hw. Even so, the below is completely optional and
> perhaps more of a suggestion for the future :)
>=20
> I hacked up the test case based on tests/open1.c.
>=20
> git clone https://github.com/antonblanchard/will-it-scale.git
>=20
> For example plop into tests/opencreate1.c && gmake &&
> ./opencreate1_processes -t 70:
>=20
> #include <stdlib.h>
> #include <unistd.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <assert.h>
> #include <string.h>
>=20
> char *testcase_description =3D "Separate file open/close + O_CREAT";
>=20
> #define template=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "/tmp/willitsc=
ale.XXXXXX"
> static char (*tmpfiles)[sizeof(template)];
> static unsigned long local_nr_tasks;
>=20
> void testcase_prepare(unsigned long nr_tasks)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmpfiles =3D (char(*)[sizeof(t=
emplate)])malloc(sizeof(template)
> * nr_tasks);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(tmpfiles);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < nr_tasks; i+=
+) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 strcpy(tmpfiles[i], template);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 char *tmpfile =3D tmpfiles[i];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 int fd =3D mkstemp(tmpfile);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 assert(fd >=3D 0);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 close(fd);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 local_nr_tasks =3D nr_tasks;
> }
>=20
> void testcase(unsigned long long *iterations, unsigned long nr)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *tmpfile =3D tmpfiles[nr]=
;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (1) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 int fd =3D open(tmpfile, O_RDWR | O_CREAT, 0600);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 assert(fd >=3D 0);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 close(fd);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (*iterations)++;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> }
>=20
> void testcase_cleanup(void)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < local_nr_tas=
ks; i++) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 unlink(tmpfiles[i]);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(tmpfiles);
> }
>=20
>=20

Good suggestion and thanks for the testcase. With v6.10 kernel, I'm
seeing numbers like this at -t 70:

min:4873 max:11510 total:418915
min:4884 max:10598 total:408848
min:3704 max:12371 total:467658
min:2842 max:11792 total:418239
min:2966 max:11511 total:414144
min:4756 max:11381 total:413137
min:4557 max:10789 total:404628
min:4780 max:11125 total:413349
min:4757 max:11156 total:405963

...with the patched kernel, things are significantly faster:

min:265865 max:508909 total:21464553                                 =20
min:263252 max:500084 total:21242190                                 =20
min:263989 max:504929 total:21396968                                 =20
min:263343 max:505852 total:21346829                                 =20
min:263023 max:507303 total:21410217                                 =20
min:263420 max:506593 total:21426307                                 =20
min:259556 max:494529 total:20927169                                 =20
min:264451 max:508967 total:21433676                                 =20
min:263486 max:509460 total:21399874                                 =20
min:263906 max:507400 total:21393015                                 =20

I can get some fancier plots if anyone is interested, but the benefit
of this patch seems pretty clear.
--=20
Jeff Layton <jlayton@kernel.org>

