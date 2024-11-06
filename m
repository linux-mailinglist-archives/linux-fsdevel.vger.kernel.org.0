Return-Path: <linux-fsdevel+bounces-33804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B15219BF13E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 16:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58BF1C2217E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 15:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF695201256;
	Wed,  6 Nov 2024 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="j3dZnyhh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C9E1D6DB4;
	Wed,  6 Nov 2024 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905779; cv=none; b=c3RUGSMgTm6cujXnrQHC318B9t4hLH10fV56Ii94Tt9xOFKtr5X3jClMnGESgvHjSRA+H9iR/BT1BXbhweJ6Hzs9y7TOqF8i8gpiBg+0V4FVtgGwi8KG4T8AywqYU0drfL6+pVmzlAuMAkxipG7NeZ4PIZAYkrZ9+qWXtezyN4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905779; c=relaxed/simple;
	bh=jmCd2EppOkwcK2COEshSsILWGU3cpU05qf1ylf8y7Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRovmM8au43mHKSgAvoiU1vibNk4G4lAs5HoUepSsjV0COfQxwRkQs3592FtliFE3UO1YrA3DCNmKDOccuFh0n4YKjsx7h/75N7LM6DRfnerO3DHRjBobblUxAt1Lsn6O1hzbCCGd+wZWveV4tAvmS0UeCM/CGCDKaLWN0yMvrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=j3dZnyhh; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Xk7sS4P4hz9tYG;
	Wed,  6 Nov 2024 16:09:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1730905772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mAcG4C7h5Bdtkoxsrx4bNwyvDYHGRNmMLEV3kqpZcDw=;
	b=j3dZnyhhufySlNgZp5fK7M6CFPNVHCs3fcFpDgT1aaIPqB9lfoj+pYsPsyBKek031WbADr
	6ixPXj00HBO3FLJvBeZ5LARui2Qbn7ZhGiZ3gOjBxA6s3JatAlbWcUwQelLZkXEND4J0Nf
	dZXrp48bjYalv9DmXnyh7F5rNfiE3JUuV7CcW1MT9+EjP+kNFw1Zqfdf90MzQy64XffwbE
	MSY75BBOMxzunZF+EYzQW2HhkFFk0qt+JJP1lEpBl3iBb8V3bKznqceuucM1ODSb6ID8Jb
	kdROIjsX3mJeiEhKDmManhlLZwS5/0sMkZfbAlUcVoyf4pmaXz08fQaWAndISQ==
Date: Thu, 7 Nov 2024 02:09:19 +1100
From: Aleksa Sarai <cyphar@cyphar.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Karel Zak <kzak@redhat.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] overlayfs: port all superblock creation logging to
 fsopen logs
Message-ID: <20241106.141100-patchy.noises.kissable.cannons-37UAyhH88iH@cyphar.com>
References: <20241106-overlayfs-fsopen-log-v1-1-9d883be7e56e@cyphar.com>
 <20241106-mehrzahl-bezaubern-109237c971e3@brauner>
 <CAOQ4uxirsNEK24=u3K-X5A-EX80ofEx5ycjoqU4gocBoPVxbYw@mail.gmail.com>
 <CAOQ4uxj+gAtM6cY_aEmM7TAqLor7498f0FO3eTek_NpUXUKNaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nm6vlemi2lqhagjs"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj+gAtM6cY_aEmM7TAqLor7498f0FO3eTek_NpUXUKNaw@mail.gmail.com>


--nm6vlemi2lqhagjs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-11-06, Amir Goldstein <amir73il@gmail.com> wrote:
> On Wed, Nov 6, 2024 at 12:00=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Wed, Nov 6, 2024 at 10:59=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > On Wed, Nov 06, 2024 at 02:09:58PM +1100, Aleksa Sarai wrote:
> > > > overlayfs helpfully provides a lot of of information when setting u=
p a
> > > > mount, but unfortunately when using the fsopen(2) API, a lot of this
> > > > information is mixed in with the general kernel log.
> > > >
> > > > In addition, some of the logs can become a source of spam if progra=
ms
> > > > are creating many internal overlayfs mounts (in runc we use an inte=
rnal
> > > > overlayfs mount to protect the runc binary against container breako=
ut
> > > > attacks like CVE-2019-5736, and xino_auto=3Don caused a lot of spam=
 in
> > > > dmesg because we didn't explicitly disable xino[1]).
> > > >
> > > > By logging to the fs_context, userspace can get more accurate
> > > > information when using fsopen(2) and there is less dmesg spam for
> > > > systems where a lot of programs are using fsopen("overlay"). Legacy
> > > > mount(2) users will still see the same errors in dmesg as they did
> > > > before (though the prefix of the log messages will now be "overlay"
> > > > rather than "overlayfs").
> >
> > I am not sure about the level of risk in this format change.
> > Miklos, WDYT?
> >
> > > >
> > > > [1]: https://bbs.archlinux.org/viewtopic.php?pid=3D2206551
> > > >
> > > > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > > > ---
> > >
> > > To me this sounds inherently useful! So I'm all for it.
> > >
> >
> > [CC: Karel]
> >
> > I am quite concerned about this.
> > I have a memory that Christian suggested to make this change back in
> > the original conversion to new mount API, but back then mount tool
> > did not print out the errors to users properly and even if it does
> > print out errors, some script could very well be ignoring them.

I think Christian mentioned this at LSF/MM (or maybe LPC), but it seems
that util-linux does provide the log information now in the case of
fsconfig(2) errors:

	% strace -e fsopen,fsconfig mount -t overlay -o userxattr=3Dstr x /tmp/a
	fsopen("overlay", FSOPEN_CLOEXEC)       =3D 3
	fsconfig(3, FSCONFIG_SET_STRING, "source", "foo", 0) =3D 0
	fsconfig(3, FSCONFIG_SET_STRING, "userxattr", "str", 0) =3D -1 EINVAL (Inv=
alid argument)
	mount: /tmp/a: fsconfig system call failed: overlay: Unexpected value for =
'userxattr'.
		   dmesg(1) may have more information after failed mount system call.

(Using the current HEAD of util-linux -- openSUSE's util-linux isn't
compiled with support for fsopen apparently.)

However, it doesn't output any of the info-level ancillary information
if there were no errors. So there will definitely be some loss of
information for pr_* logs that don't cause an actual error (which is a
little unfortunate, since that is the exact dmesg spam that caused me to
write this patch).

I could take a look at sending a patch to get libmount to output that
information, but that won't help with the immediate issue, and this
doesn't help with the possible concern with some script that scrapes
dmesg. (Though I think it goes without saying that such scripts are kind
of broken by design -- since unprivileged users can create overlayfs
mounts and thus spam the kernel log with any message, there is no
practical way for a script to correctly get the right log information
without using the new mount API's logging facilities.)

I can adjust this patch to only include the log+return-an-error cases,
but that doesn't really address your primary concern, I guess.

> > My strong feeling is that suppressing legacy errors to kmsg should be o=
pt-in
> > via the new mount API and that it should not be the default for libmoun=
t.
> > IMO, it is certainly NOT enough that new mount API is used by userspace
> > as an indication for the kernel to suppress errors to kmsg.

I can see an argument for some kind of MS_SILENT analogue for
fsconfig(), though it will make the spam problem worse until programs
migrate to setting this new flag.

Also, as this is already an issue ever since libmount added support for
the new API (so since 2.39 I believe?), I think it would make just as
much sense for this flag to be opt-in -- so libmount could set the
"verbose" or "kmsglog" flag by default but most normal programs would
not get the spammy behaviour by default. If you're writing a custom
program using the new mount API, you almost certainly *don't* want dmesg
to get a bunch of messages that you would have no plan to ever parse.

> > I have no problem with reporting errors to both userspace and kmsg
> > without opt-in from usersapce.
> >
> > Furthermore, looking at the existing invalfc() calls in overlayfs, I se=
e that
> > a few legacy pr_err() were converted to invalfc() with this commit
> > (signed off by myself):
> > 819829f0319a ovl: refactor layer parsing helpers
> >
> > I am not really sure if the discussion about suppressing the kmsg error=
s was
> > resolved or dismissed or maybe it only happened in my head??
> >
> > Thanks,
> > Amir.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--nm6vlemi2lqhagjs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZyuGnwAKCRAol/rSt+lE
b1jQAQDCWNN50tS1k5tjB7ne9t4zcS67AYiOfFOJyhwRd6UKVwEAngvgn3Y2y8gt
r/Mc7k7tYJ+qX60wf3te8JudAGJOhQw=
=03yX
-----END PGP SIGNATURE-----

--nm6vlemi2lqhagjs--

