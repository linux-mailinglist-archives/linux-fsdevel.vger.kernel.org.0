Return-Path: <linux-fsdevel+bounces-8544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D90838FCA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 14:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6AC1F2AA44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 13:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6765FF1B;
	Tue, 23 Jan 2024 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbvZZiM4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BB75FF09;
	Tue, 23 Jan 2024 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015968; cv=none; b=YO8QComVVnvwAOcE5/8DHJ14Or9rdzSheF60OINZR1gp9N9bvFDlkskN1B5YVPmM6YIY9VdZiUETfIFUi9bRXqnD9ya9o+3hw/fshRYpLsb2oi0vm6yf7kC/1SMm9++oCog+Tj8LcpuecXwN2qBLsulXJVUlpzhilM7nynQSbl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015968; c=relaxed/simple;
	bh=Gq1+mEQ6ja2G8UP94ctjJ4FgOtBLuB/h5zt9GfFjNFw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GWc+bkFINzJ9x/9kVcldeV9r7uqJCcosnQQBUH/6TMRkOVlman7oPWf8eJ3RSzOrraaonBnVUEC2XfJ1XbMm5dbbetNf7ivJO9WZZ/sSYQTUqgYjIUBB9d8+7wfWAYkjWHdh68vN9LSkzrwlZskvoJuwhNjXNsOYFc6Fh/MBKTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbvZZiM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD9CC433B1;
	Tue, 23 Jan 2024 13:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706015967;
	bh=Gq1+mEQ6ja2G8UP94ctjJ4FgOtBLuB/h5zt9GfFjNFw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=DbvZZiM4AGbX7yMeU/S7ieI6TnYlGRWYnadhMDUfSqGZDkVkoK3IaR+6kAaQLE8vn
	 p/8x1//Z9jG5XUhj/JQPVAOkPHMeQrB4gekevEpY5ChnYBnYlh8P8ObIjDKfN5gMBp
	 xpBgSa6Jg9edoRIUm4kTV3zGIMIbsr1zp/FFG1xSCcChH8Ra4XtRbyJmJ/Wb9ggIfP
	 IBOz97R0V8ZUT6pRJiyUSwEczf4qRu891bGNzuTidbzLP9xDBaWHCTMOOq7vqdLfok
	 LTTaHBcYyMJrgtPyg5kzQZJlj/Rn2uofCuVVSm7+pbxuEHBYyLzhkUj30mWQryDy0Y
	 AC5m6OZ5MHJQA==
Message-ID: <7f615e3a3edabc706879e218f62dfe4425fbc236.camel@kernel.org>
Subject: Re: [REGRESSION] 6.6.10+ and 6.7+ kernels lock up early in init.
From: Jeff Layton <jlayton@kernel.org>
To: sedat.dilek@gmail.com
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, 
 stable@vger.kernel.org, Linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Paul Thompson
 <set48035@gmail.com>
Date: Tue, 23 Jan 2024 08:19:25 -0500
In-Reply-To: <CA+icZUXaxysi1Oq1wKeDZ5LZVp7i585vmPQi67hw1CdW7nGC6A@mail.gmail.com>
References: <Za9DUZoJbV0PYGN2@squish.home.loc>
	 <6939adb3-c270-481f-8547-e267d642beea@leemhuis.info>
	 <bbac350b-7a94-475e-88c9-35f6f8700af8@leemhuis.info>
	 <e2f791e51feb09e671d59afbbb233c4d6128a8d2.camel@kernel.org>
	 <CA+icZUXaxysi1Oq1wKeDZ5LZVp7i585vmPQi67hw1CdW7nGC6A@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-23 at 12:46 +0100, Sedat Dilek wrote:
> On Tue, Jan 23, 2024 at 12:16=E2=80=AFPM Jeff Layton <jlayton@kernel.org>=
 wrote:
> >=20
> > On Tue, 2024-01-23 at 07:39 +0100, Linux regression tracking (Thorsten
> > Leemhuis) wrote:
> > > [a quick follow up with an important correction from the reporter for
> > > those I added to the list of recipients]
> > >=20
> > > On 23.01.24 06:37, Linux regression tracking (Thorsten Leemhuis) wrot=
e:
> > > > On 23.01.24 05:40, Paul Thompson wrote:
> > > > >=20
> > > > >   With my longstanding configuration, kernels upto 6.6.9 work fin=
e.
> > > > > Kernels 6.6.1[0123] and 6.7.[01] all lock up in early (open-rc) i=
nit,
> > > > > before even the virtual filesystems are mounted.
> > > > >=20
> > > > >   The last thing visible on the console is the nfsclient service
> > > > > being started and:
> > > > >=20
> > > > > Call to flock failed: Funtion not implemented. (twice)
> > > > >=20
> > > > >   Then the machine is unresponsive, numlock doesnt toggle the key=
board led,
> > > > > and the alt-sysrq chords appear to do nothing.
> > > > >=20
> > > > >   The problem is solved by changing my 6.6.9 config option:
> > > > >=20
> > > > > # CONFIG_FILE_LOCKING is not set
> > > > > to
> > > > > CONFIG_FILE_LOCKING=3Dy
> > > > >=20
> > > > > (This option is under File Systems > Enable POSIX file locking AP=
I)
> > >=20
> > > The reporter replied out-of-thread:
> > > https://lore.kernel.org/all/Za9TRtSjubbX0bVu@squish.home.loc/
> > >=20
> > > """
> > >       Now I feel stupid or like Im losing it, but I went back and gre=
pped for
> > > the CONFIG_FILE_LOCKING in my old Configs, and it was turned on in al=
l
> > > but 6.6.9. So, somehow I turned that off *after I built 6.6.9? Argh. =
I
> > > just built 6.6.4 with it unset and that locked up too.
> > >       Sorry if this is just noise, though one would have hoped the fa=
ilure
> > > was less severe...
> > > """
> > >=20
> >=20
> > Ok, so not necessarily a regression? It might be helpful to know the
> > earliest kernel you can boot with CONFIG_FILE_LOCKING turned off.
> >=20
> > > >=20
> > I'll give a try reproducing this later though.
>=20
> Quote from Paul:
> "
> Now I feel stupid or like Im losing it, but I went back and grepped
> for the CONFIG_FILE_LOCKING in my old Configs, and it was turned on in al=
l
> but 6.6.9. So, somehow I turned that off *after I built 6.6.9? Argh. I ju=
st
> built 6.6.4 with it unset and that locked up too.
> Sorry if this is just noise, though one would have hoped the failure
> was less severe...
> "
>=20
> -Sedat-
>=20
> https://lore.kernel.org/all/Za9TRtSjubbX0bVu@squish.home.loc/#t
>=20
>=20

Ok, I can reproduce this in KVM, which should make this a bit simpler:

I tried turning off CONFIG_FILE_LOCKING on mainline kernels and it also
hung for me at boot here (I think it was trying to enable the nvme disks
attached to this host):

[  OK  ] Reached target sysinit.target - System Initialization.
[  OK  ] Finished dracut-pre-mount.service - dracut pre-mount hook.
[  OK  ] Started plymouth-start.service - Show Plymouth Boot Screen.
[  OK  ] Started systemd-ask-password-plymo=E2=80=A6quests to Plymouth Dire=
ctory Watch.
[  OK  ] Reached target paths.target - Path Units.
[  OK  ] Reached target basic.target - Basic System.
[    4.647183] cryptd: max_cpu_qlen set to 1000
[    4.650280] AVX2 version of gcm_enc/dec engaged.
[    4.651252] AES CTR mode by8 optimization enabled
         Starting systemd-vconsole-setup.service - Virtual Console Setup...
[FAILED] Failed to start systemd-vconsole-s=E2=80=A6up.service - Virtual Co=
nsole Setup.
See 'systemctl status systemd-vconsole-setup.service' for details.
[    5.777176] virtio_blk virtio3: 8/0/0 default/read/poll queues
[    5.784633] virtio_blk virtio3: [vda] 41943040 512-byte logical blocks (=
21.5 GB/20.0 GiB)
[    5.791351]  vda: vda1 vda2 vda3
[    5.792672] virtio_blk virtio6: 8/0/0 default/read/poll queues
[    5.801796] virtio_blk virtio6: [vdb] 209715200 512-byte logical blocks =
(107 GB/100 GiB)
[    5.807839] virtio_blk virtio7: 8/0/0 default/read/poll queues
[    5.813098] virtio_blk virtio7: [vdc] 209715200 512-byte logical blocks =
(107 GB/100 GiB)
[    5.818500] virtio_blk virtio8: 8/0/0 default/read/poll queues
[    5.823969] virtio_blk virtio8: [vdd] 209715200 512-byte logical blocks =
(107 GB/100 GiB)
[    5.829217] virtio_blk virtio9: 8/0/0 default/read/poll queues
[    5.834636] virtio_blk virtio9: [vde] 209715200 512-byte logical blocks =
(107 GB/100 GiB)
[    **] Job dev-disk-by\x2duuid-5a8a135f\x2=E2=80=A6art running (13min 46s=
 / no limit)


The last part will just keep spinning forever.

I've gone back as far as v6.0, and I see the same behavior. I then tried
changing the disks in the VM to be attached by virtio instead of NVMe,
and that also didn't help.

That said, I'm using a fedora 39 cloud image here. I'm not sure it's
reasonable to expect that to boot properly with file locking disabled.
=20
Paul, what distro are you running? When you say that it's hung, are you
seeing similar behavior?
--=20
Jeff Layton <jlayton@kernel.org>

