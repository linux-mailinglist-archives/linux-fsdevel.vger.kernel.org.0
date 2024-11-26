Return-Path: <linux-fsdevel+bounces-35871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9989D9265
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 08:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 185B6B21D4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 07:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D6B192D8C;
	Tue, 26 Nov 2024 07:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="r31ufQsH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5A2539A;
	Tue, 26 Nov 2024 07:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732605927; cv=none; b=gCDqUw1OFXewVizPKvDoxnkKjZo0jizBhDBbnumW3NKNtiZLudjQTetb0wW++EdyP8QsM+jzGKz5yEiiEqfUp5jbxlLAEeASVJDNaO3iekOqA0VpMelB6MsfioxdnezgQc8/HO8Dc/QComCX+mm5cXT3dcJ6OifEyp7dqkuYDwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732605927; c=relaxed/simple;
	bh=d4GA/dn8SMUGDdwMhv6nUgYcRT0jASDcyaaObPZaUhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4v/rxEyWKT5izRLNxLzX/f1tR3SnudFJLa0JkFH5pyJjR0hWnTFmt+3W2i4XB+XrEt4/rmiksby8uLBcID3kL5nXRjVO0hrgFjgctDqf76pWrjDfvruIcQJBRdJtB4I2SkeinFWNgWDHZ14fENs90gTcQMak/5Jh4wa84y8iJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=r31ufQsH; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4XyDcc2LZcz9ssS;
	Tue, 26 Nov 2024 08:25:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1732605920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lbb6JtFJJT5mAePS1XFAEjrGigc5bpItypg24K1zApg=;
	b=r31ufQsHIjS7O28NDv28gmCeCzcqw+slG/hVLsFjijYXAHzlXRHNzh7CmKIfmDPKIj5reO
	Ku/7SPO0xbOAwJoM3RHYrcHxxtRjBD7Yssj9ykB5cHHPQ78f8QzQRJ/FxCQLFAME+acG3y
	I9PpCUEhsKG0iSF8+Yfn3o/rWDZvmxlcRxgH433AKJ6WJ6zWBwEqAVeZObAf/tKjiPwgpK
	Ufv2Wn/DAdTRWEaKzPxS+cHoNnYgAiyInskGLNZJg+GZRtJvZi2Q5QW3hFCKUKeU7y5PdQ
	dCF9FPuBhTKQOky+CJy0ACQOMZ23uX2A+vy7eM3b2xH1TUDWuVyGgLY7KDQn+A==
Date: Tue, 26 Nov 2024 18:25:08 +1100
From: Aleksa Sarai <cyphar@cyphar.com>
To: Karel Zak <kzak@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] overlayfs: port all superblock creation logging to
 fsopen logs
Message-ID: <20241126.065751-glad.dagger.vile.lyrics-RJ5aGOKAtri@cyphar.com>
References: <20241106-overlayfs-fsopen-log-v1-1-9d883be7e56e@cyphar.com>
 <20241106-mehrzahl-bezaubern-109237c971e3@brauner>
 <CAOQ4uxirsNEK24=u3K-X5A-EX80ofEx5ycjoqU4gocBoPVxbYw@mail.gmail.com>
 <CAOQ4uxj+gAtM6cY_aEmM7TAqLor7498f0FO3eTek_NpUXUKNaw@mail.gmail.com>
 <20241106.141100-patchy.noises.kissable.cannons-37UAyhH88iH@cyphar.com>
 <j7ngxuxqdwrq5o6zi2hmt3zfmh6s5mzrlvwjw6snqbv5oc5ggo@nqpr6wjec7go>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2mndsyxsr4emsewc"
Content-Disposition: inline
In-Reply-To: <j7ngxuxqdwrq5o6zi2hmt3zfmh6s5mzrlvwjw6snqbv5oc5ggo@nqpr6wjec7go>


--2mndsyxsr4emsewc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-11-13, Karel Zak <kzak@redhat.com> wrote:
> On Thu, Nov 07, 2024 at 02:09:19AM GMT, Aleksa Sarai wrote:
> > On 2024-11-06, Amir Goldstein <amir73il@gmail.com> wrote:
> > > On Wed, Nov 6, 2024 at 12:00=E2=80=AFPM Amir Goldstein <amir73il@gmai=
l.com> wrote:
> > > >
> > > > On Wed, Nov 6, 2024 at 10:59=E2=80=AFAM Christian Brauner <brauner@=
kernel.org> wrote:
> > > > >
> > > > > On Wed, Nov 06, 2024 at 02:09:58PM +1100, Aleksa Sarai wrote:
> > > > > > overlayfs helpfully provides a lot of of information when setti=
ng up a
> > > > > > mount, but unfortunately when using the fsopen(2) API, a lot of=
 this
> > > > > > information is mixed in with the general kernel log.
> > > > > >
> > > > > > In addition, some of the logs can become a source of spam if pr=
ograms
> > > > > > are creating many internal overlayfs mounts (in runc we use an =
internal
> > > > > > overlayfs mount to protect the runc binary against container br=
eakout
> > > > > > attacks like CVE-2019-5736, and xino_auto=3Don caused a lot of =
spam in
> > > > > > dmesg because we didn't explicitly disable xino[1]).
> > > > > >
> > > > > > By logging to the fs_context, userspace can get more accurate
> > > > > > information when using fsopen(2) and there is less dmesg spam f=
or
> > > > > > systems where a lot of programs are using fsopen("overlay"). Le=
gacy
> > > > > > mount(2) users will still see the same errors in dmesg as they =
did
> > > > > > before (though the prefix of the log messages will now be "over=
lay"
> > > > > > rather than "overlayfs").
> > > >
> > > > I am not sure about the level of risk in this format change.
> > > > Miklos, WDYT?
> > > >
> > > > > >
> > > > > > [1]: https://bbs.archlinux.org/viewtopic.php?pid=3D2206551
> > > > > >
> > > > > > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > > > > > ---
> > > > >
> > > > > To me this sounds inherently useful! So I'm all for it.
> > > > >
> > > >
> > > > [CC: Karel]
> > > >
> > > > I am quite concerned about this.
> > > > I have a memory that Christian suggested to make this change back in
> > > > the original conversion to new mount API, but back then mount tool
> > > > did not print out the errors to users properly and even if it does
> > > > print out errors, some script could very well be ignoring them.
> >=20
> > I think Christian mentioned this at LSF/MM (or maybe LPC), but it seems
> > that util-linux does provide the log information now in the case of
> > fsconfig(2) errors:
> >=20
> > 	% strace -e fsopen,fsconfig mount -t overlay -o userxattr=3Dstr x /tmp=
/a
> > 	fsopen("overlay", FSOPEN_CLOEXEC)       =3D 3
> > 	fsconfig(3, FSCONFIG_SET_STRING, "source", "foo", 0) =3D 0
> > 	fsconfig(3, FSCONFIG_SET_STRING, "userxattr", "str", 0) =3D -1 EINVAL =
(Invalid argument)
> > 	mount: /tmp/a: fsconfig system call failed: overlay: Unexpected value =
for 'userxattr'.
> > 		   dmesg(1) may have more information after failed mount system call.
> >=20
> > (Using the current HEAD of util-linux -- openSUSE's util-linux isn't
> > compiled with support for fsopen apparently.)
>=20
> After failed mount-related syscalls, libmount reads messages prefixed
> with "e " from the file descriptor created by fdopen(). These messages
> are later printed by mount(8).
>=20
> mount(8) or libmount does not read anything from kmesg.
>=20
> > However, it doesn't output any of the info-level ancillary
> > information if there were no errors.
>=20
> This is the expected default behavior. mount(8) does not print any
> additional information.
>=20
> We can enhance libmount to read and print other messages on stdout if
> requested by the user. For example, the mount(8) command has a
> --verbose option that is currently only used by some /sbin/mount.<type>
> helpers, but not by mount(8) itself. We can improve this and use it in
> libmount to read and print info-level messages.
>=20
> I can prepare a libmount/mount(8) patch for this.

This sounds like a good idea to me.

> > So there will definitely be some loss of
> > information for pr_* logs that don't cause an actual error (which is a
> > little unfortunate, since that is the exact dmesg spam that caused me to
> > write this patch).
> >=20
> > I could take a look at sending a patch to get libmount to output that
> > information, but that won't help with the immediate issue, and this
> > doesn't help with the possible concern with some script that scrapes
> > dmesg. (Though I think it goes without saying that such scripts are kind
> > of broken by design -- since unprivileged users can create overlayfs
> > mounts and thus spam the kernel log with any message, there is no
> > practical way for a script to correctly get the right log information
> > without using the new mount API's logging facilities.)
>=20
> > I can adjust this patch to only include the log+return-an-error cases,
> > but that doesn't really address your primary concern, I guess.
> >=20
> > > > My strong feeling is that suppressing legacy errors to kmsg should =
be opt-in
> > > > via the new mount API and that it should not be the default for lib=
mount.
> > > > IMO, it is certainly NOT enough that new mount API is used by users=
pace
> > > > as an indication for the kernel to suppress errors to kmsg.
> =20
> For me, it seems like we are mixing two things together.
>=20
> kmesg is a *log*, and tools like systemd read and save it. It is used
> for later issue debugging or by log analyzers. This means that all
> relevant information should be included.
>=20
> The stderr/stdout output from tools such as mount(8) is simply
> feedback for users or scripts, and informational messages are just
> hints. They should not be considered a replacement for system logging
> facilities. The same applies to messages read from the new mount API;
> they should not be a replacement for system logs.
>=20
> In my opinion, it is acceptable to suppress optional and unimportant
> messages and not save them into kmesg. However, all other relevant
> messages should be included regardless of the tool or API being used.

For warning or error messages, this makes sense -- though I think the
"least spammy" option would be that the logs are output to kmesg if
userspace closes the fscontext fd without reading the logs. That should
catch programs that miss log information, without affecting programs
that do read the logs (and do whatever they feel is appropriate with
them). That would be some reasonable default behaviour, and users could
explicitly opt into a verbose mode.

For informational or debug messages, I feel that the default should be
that we want to avoid outputting to kmesg when using the new mount API
since the information is non-critical and the only way of associating
the information is using the fscontext log. But if we had this "only log
on close if not read" behaviour, I think having the same behaviour for
all log messages would still work and would be more consistent.

> Additionally, it should be noted that mount(8)/libmount is only a
> userspace tool and is not necessary for mounting filesystems. The
> kernel should not rely on libmount behavior; there are other tools
> available such as busybox.

Sure, but by switching to the new mount API you are buying into
different behaviour for error logs (if only for the generic VFS ones),
regardless of what kind of program you are.

> > I can see an argument for some kind of MS_SILENT analogue for
> > fsconfig(), though it will make the spam problem worse until programs
> > migrate to setting this new flag.
> =20
> Yes, the ideal solution would be to have mount options that can
> control this behavior. This would allow users to have control over it
> and save their settings to fstab, as well as keep it specific to the
> mount node.
>=20
> > Also, as this is already an issue ever since libmount added support for
> > the new API (so since 2.39 I believe?), I think it would make just as
> > much sense for this flag to be opt-in -- so libmount could set the
> > "verbose" or "kmsglog" flag by default but most normal programs would
> > not get the spammy behaviour by default.
>=20
> I prefer if the default behavior is defined by the kernel, rather than
> by userspace tools like libmount. If we were to automatically add any
> mount options through libmount, it would make it difficult to coexist
> with settings in fstab, etc. It's always better to have transparency
> and avoid any hidden factors in the process.

Right, my suggestion was that verbose should be opt-in precisely because
wanting to output to kmesg when using the new mount API is something
that only really makes sense for libmount and similar tools and so
should be opt-in rather than opt-out.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--2mndsyxsr4emsewc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZ0V31AAKCRAol/rSt+lE
b3KLAPwPMUIRLGuX9UJKWWy9VUCSa1AfH6Sedviog/Shlm3xfQEA/KmOaFdpKbxm
Coaaa8BhwFWw1lgRgdwDvYMCUdKV+AU=
=AmBD
-----END PGP SIGNATURE-----

--2mndsyxsr4emsewc--

