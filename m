Return-Path: <linux-fsdevel+bounces-24198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A0A93B21F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 15:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57DE1F247AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 13:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3340F158DA7;
	Wed, 24 Jul 2024 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2bRVF4+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963C1158A27
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jul 2024 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721829371; cv=none; b=aQounVbJbki76WlCLBp7yvnCyxqUqqIz1X6133QlXqJtyWAIadoueY+IiRmko++8o9SugqXb/016YA3h8RLKPnPiYJUAzfKIH5CvlOi5WTrfR7Yl35riLh5EZztQBpkD9T+9mgn5zRS6g3yIL0SXiqInOR4oZFGNCav0nN1u+XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721829371; c=relaxed/simple;
	bh=q3hJswAZRohpmOpgDP7SseIaA/ZEn9K9EwtyJogvCCM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ln0ZjnprozGMhnbtDDQSazK43K8euWk7jyKUrJ0ISy+XojZVewCM7Vhy272YX4MR4WIECWPjCSxsXk5Gu+nY8bkAk2SMz97fytV7JzuRZY4qf/TR8S/D0YzLEtk+mtowmva0fRuMIeRQIKVdziE8QKdE5figDMTzLxTWUqq0Cx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2bRVF4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DD6C32781;
	Wed, 24 Jul 2024 13:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721829371;
	bh=q3hJswAZRohpmOpgDP7SseIaA/ZEn9K9EwtyJogvCCM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=X2bRVF4+Dit9sc41FhoTLIuBx/l+SUmwTnSBAuTH4CZamesa2S4VASL68p/DbbOT8
	 TWH9ylAPF7wscPDPiptRzdE8oIyHicg84wr6j2pZTxO7nRxgmTHs7+/CmfVhMPRD98
	 oBWG5XUk94GsowL5Vy2xMF5/hyCtJaWBCMm6F9gHMx/5cVeFpF1eC9NdpSXiYhiC2/
	 6zDv+ogX5F/EBoo8aACBy/8Yo8Bzkel8aYEaWGCbokrAZHEWbvXRAd+bwMpJwymKpd
	 CUwVBktmwGSLuYHaIBXbEDs/CxY3z80qklcKEdOvxeUuSJoEcEkD9BkBvwNOF6EWv8
	 X1pgSkHn7C42w==
Message-ID: <41f1e62a9b54b79688d15e66499eef02075aeb2e.camel@kernel.org>
Subject: Re: [PATCH RFC 1/2] fcntl: add F_CREATED
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, Jann
 Horn <jannh@google.com>, Jan Kara <jack@suse.com>, Daan De Meyer
 <daan.j.demeyer@gmail.com>
Date: Wed, 24 Jul 2024 09:56:09 -0400
In-Reply-To: <20240724-work-fcntl-v1-1-e8153a2f1991@kernel.org>
References: <20240724-work-fcntl-v1-0-e8153a2f1991@kernel.org>
	 <20240724-work-fcntl-v1-1-e8153a2f1991@kernel.org>
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

On Wed, 2024-07-24 at 15:15 +0200, Christian Brauner wrote:
> Systemd has a helper called openat_report_new() that returns whether a
> file was created anew or it already existed before for cases where
> O_CREAT has to be used without O_EXCL (cf. [1]). That apparently isn't
> something that's specific to systemd but it's where I noticed it.
>=20
> The current logic is that it first attempts to open the file without
> O_CREAT | O_EXCL and if it gets ENOENT the helper tries again with both
> flags. If that succeeds all is well. If it now reports EEXIST it
> retries.
>=20
> That works fairly well but some corner cases make this more involved. If
> this operates on a dangling symlink the first openat() without O_CREAT |
> O_EXCL will return ENOENT but the second openat() with O_CREAT | O_EXCL
> will fail with EEXIST. The reason is that openat() without O_CREAT |
> O_EXCL follows the symlink while O_CREAT | O_EXCL doesn't for security
> reasons. So it's not something we can really change unless we add an
> explicit opt-in via O_FOLLOW which seems really ugly.
>=20
> The caller could try and use fanotify() to register to listen for
> creation events in the directory before calling openat(). The caller
> could then compare the returned tid to its own tid to ensure that even
> in threaded environments it actually created the file. That might work
> but is a lot of work for something that should be fairly simple and I'm
> uncertain about it's reliability.
>=20
> The caller could use a bpf lsm hook to hook into security_file_open() to
> figure out whether they created the file. That also seems a bit wild.
>=20
> So let's add F_CREATED which allows the caller to check whether they
> actually did create the file. That has caveats of course but I don't
> think they are problematic:
>=20
> * In multi-threaded environments a thread can only be sure that it did
> =C2=A0 create the file if it calls openat() with O_CREAT. In other words,
> =C2=A0 it's obviously not enough to just go through it's fdtable and chec=
k
> =C2=A0 these fds because another thread could've created the file.
>=20

Not exactly. FMODE_CREATED is set in the file description. In principle
a userland program should know which thread actually did the the open()
that results in each fd. This new interface tells us which fd's open
actually resulted in the file being created (which is good).

In any case, I don't see this as a problem. The interface does what it
says on the tin.

> * If there's any codepaths where an openat() with O_CREAT would yield
> =C2=A0 the same struct file as that of another thread it would obviously
> =C2=A0 cause wrong results. I'm not aware of any such codepaths from open=
at()
> =C2=A0 itself. Imho, that would be a bug.
>=20

Definitely a bug. That said, this will have interesting interactions
with dup that may need to be documented. IOW, if you dup a file with
FMODE_CREATED, then the new fd will also report that F_CREATED is true.

> * Related to the previous point, calling the new fcntl() on files created
> =C2=A0 and opened via special-purpose system calls or ioctl()s would caus=
e
> =C2=A0 wrong results only if the affected subsystem a) raises FMODE_CREAT=
ED
> =C2=A0 and b) may return the same struct file for two different calls. I'=
m
> =C2=A0 not seeing anything outside of regular VFS code that raises
> =C2=A0 FMODE_CREATED.
>=20

Me neither. This interface is really about "traditional" filesystems.
If you're dealing with some pseudo-fs (proc, sys, debugfs, etc.), I
don't think you can expect to get sane results from this.

> =C2=A0 There is code for b) in e.g., the drm layer where the same struct =
file
> =C2=A0 is resurfaced but again FMODE_CREATED isn't used and it would be v=
ery
> =C2=A0 misleading if it did.
>=20
> Link: https://github.com/systemd/systemd/blob/11d5e2b5fbf9f6bfa5763fd45b5=
6829ad4f0777f/src/basic/fs-util.c#L1078=C2=A0[1]
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> =C2=A0fs/fcntl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 ++++++++++
> =C2=A0include/uapi/linux/fcntl.h |=C2=A0 3 +++
> =C2=A02 files changed, 13 insertions(+)
>=20
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 300e5d9ad913..55a66ad9b432 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -343,6 +343,12 @@ static long f_dupfd_query(int fd, struct file *filp)
> =C2=A0	return f.file =3D=3D filp;
> =C2=A0}
> =C2=A0
> +/* Let the caller figure out whether a given file was just created. */
> +static long f_created(const struct file *filp)
> +{
> +	return !!(filp->f_mode & FMODE_CREATED);
> +}
> +
> =C2=A0static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
> =C2=A0		struct file *filp)
> =C2=A0{
> @@ -352,6 +358,9 @@ static long do_fcntl(int fd, unsigned int cmd, unsign=
ed long arg,
> =C2=A0	long err =3D -EINVAL;
> =C2=A0
> =C2=A0	switch (cmd) {
> +	case F_CREATED:
> +		err =3D f_created(filp);
> +		break;
> =C2=A0	case F_DUPFD:
> =C2=A0		err =3D f_dupfd(argi, filp, 0);
> =C2=A0		break;
> @@ -463,6 +472,7 @@ static long do_fcntl(int fd, unsigned int cmd, unsign=
ed long arg,
> =C2=A0static int check_fcntl_cmd(unsigned cmd)
> =C2=A0{
> =C2=A0	switch (cmd) {
> +	case F_CREATED:
> =C2=A0	case F_DUPFD:
> =C2=A0	case F_DUPFD_CLOEXEC:
> =C2=A0	case F_DUPFD_QUERY:
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index c0bcc185fa48..d78a6c237688 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -16,6 +16,9 @@
> =C2=A0
> =C2=A0#define F_DUPFD_QUERY	(F_LINUX_SPECIFIC_BASE + 3)
> =C2=A0
> +/* Was the file just created? */
> +#define F_CREATED	(F_LINUX_SPECIFIC_BASE + 4)
> +
> =C2=A0/*
> =C2=A0 * Cancel a blocking posix lock; internal use only until we expose =
an
> =C2=A0 * asynchronous lock api to userspace:
>=20

This looks sane to me.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

