Return-Path: <linux-fsdevel+bounces-15088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47570886ECC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 15:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EECB7286253
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 14:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1989047F6F;
	Fri, 22 Mar 2024 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z54Ah0dj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B545447F5D
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711118401; cv=none; b=j7QV3JAdEdwaswI28qOs9Q6NAQQp77GskHCtB+sJmUmzBLmWtEkrB3ItgOO7WY3yo7XuS8u8Xrz9Co3QsXeJO5w63qU/nYiPNGBm0zoAJSUMx2rt9pjk0q4vm/z0WZFHm3ZU2iOMYx0JriuuEDp7bwHkZwuHC8Ny9k7eMii/kg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711118401; c=relaxed/simple;
	bh=M7m9yV9q8q1viUtrYDpgP7bD9ijmQCcD6ZY4tFU6kqs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ni6ht8mVc+OQMVQqs0pBnppKzPBeBRtpwmHIGBY1ki79cWritiOup/q2xomdZS+LTxyMgVZNQzjLU8M1CMjwWrKSKpLuneEKfBc64hlZsVZKPa65OGtSnKEB4U9uDbsvJCJXDOiYhKuP8KdDu2H6HtEnWvcCIzCAehUTVphDqk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z54Ah0dj; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a4455ae71fcso107870766b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 07:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711118398; x=1711723198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/VtsW+/qJuiMTAVZL+Cnz9ytEzKEgAcOHZ3oa+QL2U=;
        b=z54Ah0dj4cu0+PcuKgUInytYtmwSvQRQ4F8ibGoF3t93BqjAv4RAxV11SYGkxRg1cd
         +/U2mVqv1sYk2whiZM7KVxTl8ccJkaACmam4AqTnGIrsPeM5XO/pS1h9Uq8jXdORJMfL
         obGTc5KvjQzOYauIbz81nfYngnzqK45hMoTs4WAKb1VnD7fYtehIyrSSV2/X/V3lOCZ+
         tfKsXUubXyjYvbsAtU21TyLRLYGs5tqZLGopUUGOP9XEd/GtVbwrhzrUqtlcadNPETLB
         u0y+O8J0+VvyQDep7EwMcR2vQ/xlIkd363m4S+sPbrHgnCy0WLcH8byVnNBb4qNxllwy
         3pSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711118398; x=1711723198;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r/VtsW+/qJuiMTAVZL+Cnz9ytEzKEgAcOHZ3oa+QL2U=;
        b=eFpCE3RMsKnvrzcYkGjRYBkCvzbeLb1soOzc5erHJ0g0FSMDmR1tiHKk7vFfY0552c
         a5l817gofeGutCyNzYmrbOQjHi1prBhgjBNGL/YUJvRehzNRBhhlojuYykRjxqFft2ol
         Bz7XIGYulsLusPQQVf0kA2Q9Zriwi6LBdDA11BJsBHIBUWHBYdOaZL9Swwo6thT1yXzD
         JycgjcfDdoigQ+YazWEu54ZCw3sSiIAmw82zfhhj7V4TuzjWf9z0RKMK907sEYArtHXW
         eD72C+19xWFE5SAsAZnNhs5SyT8S6ET8gWOH5WQs4L1OLwmBX4iXXkqF4b/m/gnHPrcV
         9Cdw==
X-Forwarded-Encrypted: i=1; AJvYcCV/VT9xJvenmWBnI8mKxNPjgTZ70LFNadDAPmzQafTwBefOsl2FexU7AUY8knHfo9ktSo+8hoVMAAAd2EYkrzNRx4zLxxz4Ecii8LGL1w==
X-Gm-Message-State: AOJu0YzrWHZGfCPM86lMjd3Y7suQWRLHdI8uBrgJEc6of1hHqcs8j5QS
	KwKl5untPTddcpBH7vkoKywzB8RgkQWqoKLr5nVTI0Su3BqLL1XYrMxZOuuDwWS+3Z9f5tYSSdH
	O8A==
X-Google-Smtp-Source: AGHT+IFeINQB2Sle2Lc5d7rpFvqJ16OAKnqUTHVNUPaYB9k0cSsB18JUjEFjHs1bMxWTLSjcIFGX8Cbe+TA=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:906:f191:b0:a45:2ebe:2636 with SMTP id
 gs17-20020a170906f19100b00a452ebe2636mr9264ejb.9.1711118397698; Fri, 22 Mar
 2024 07:39:57 -0700 (PDT)
Date: Fri, 22 Mar 2024 15:39:55 +0100
In-Reply-To: <20240322.axashie2ooJ1@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309075320.160128-1-gnoack@google.com> <20240309075320.160128-7-gnoack@google.com>
 <20240322.axashie2ooJ1@digikod.net>
Message-ID: <Zf2YO8LHm3Wi4aNu@google.com>
Subject: Re: [PATCH v10 6/9] selftests/landlock: Test IOCTLs on named pipes
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 08:48:29AM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> It might be interesting to create a layout with one file of each type
> and use that for the IOCTL tests.

We have already written these tests and we can keep them, but I think that =
we
only gain little additional confidence from testing non-device files.  The
implementation is saying pretty directly that IOCTLs are permitted if the f=
ile
is not a character or block device, at the top of the file_ioctl hook.  I d=
on't
see much value in testing this even more exhaustively and would like to kee=
p it
as it is for now.


> On Sat, Mar 09, 2024 at 07:53:17AM +0000, G=C3=BCnther Noack wrote:
> > Named pipes should behave like pipes created with pipe(2),
> > so we don't want to restrict IOCTLs on them.
> >=20
> > Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
> > ---
> >  tools/testing/selftests/landlock/fs_test.c | 61 ++++++++++++++++++----
> >  1 file changed, 52 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing=
/selftests/landlock/fs_test.c
> > index 5c47231a722e..d991f44875bc 100644
> > --- a/tools/testing/selftests/landlock/fs_test.c
> > +++ b/tools/testing/selftests/landlock/fs_test.c
> > @@ -3924,6 +3924,58 @@ TEST_F_FORK(layout1, o_path_ftruncate_and_ioctl)
> >  	ASSERT_EQ(0, close(fd));
> >  }
> > =20
> > +static int test_fionread_ioctl(int fd)
> > +{
> > +	size_t sz =3D 0;
> > +
> > +	if (ioctl(fd, FIONREAD, &sz) < 0 && errno =3D=3D EACCES)
> > +		return errno;
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Named pipes are not governed by the LANDLOCK_ACCESS_FS_IOCTL_DEV ri=
ght,
> > + * because they are not character or block devices.
> > + */
> > +TEST_F_FORK(layout1, named_pipe_ioctl)
> > +{
> > +	pid_t child_pid;
> > +	int fd, ruleset_fd;
> > +	const char *const path =3D file1_s1d1;
> > +	const struct landlock_ruleset_attr attr =3D {
> > +		.handled_access_fs =3D LANDLOCK_ACCESS_FS_IOCTL_DEV,
> > +	};
> > +
> > +	ASSERT_EQ(0, unlink(path));
> > +	ASSERT_EQ(0, mkfifo(path, 0600));
> > +
> > +	/* Enables Landlock. */
> > +	ruleset_fd =3D landlock_create_ruleset(&attr, sizeof(attr), 0);
> > +	ASSERT_LE(0, ruleset_fd);
> > +	enforce_ruleset(_metadata, ruleset_fd);
> > +	ASSERT_EQ(0, close(ruleset_fd));
> > +
> > +	/* The child process opens the pipe for writing. */
> > +	child_pid =3D fork();
> > +	ASSERT_NE(-1, child_pid);
> > +	if (child_pid =3D=3D 0) {
>=20
> What is the purpose of this child's code?

From fifo(7):

  Opening the FIFO blocks until the other end is opened also.

So the child and parent process both wait for the other open to happen.

I suspect I could technically also use O_RDWR here, but that is undefined
behaviour in POSIX and less conventional code.  (This is described further =
down,
also in fifo(7).)

>=20
> > +		fd =3D open(path, O_WRONLY);
> > +		close(fd);
> > +		exit(0);
> > +	}
> > +
> > +	fd =3D open(path, O_RDONLY);
> > +	ASSERT_LE(0, fd);
> > +
> > +	/* FIONREAD is implemented by pipefifo_fops. */
> > +	EXPECT_EQ(0, test_fionread_ioctl(fd));
> > +
> > +	ASSERT_EQ(0, close(fd));
> > +	ASSERT_EQ(0, unlink(path));
> > +
> > +	ASSERT_EQ(child_pid, waitpid(child_pid, NULL, 0));
> > +}
> > +
> >  /* clang-format off */
> >  FIXTURE(ioctl) {};
> > =20
> > @@ -3997,15 +4049,6 @@ static int test_tcgets_ioctl(int fd)
> >  	return 0;
> >  }
> > =20
> > -static int test_fionread_ioctl(int fd)
> > -{
> > -	size_t sz =3D 0;
> > -
> > -	if (ioctl(fd, FIONREAD, &sz) < 0 && errno =3D=3D EACCES)
> > -		return errno;
> > -	return 0;
> > -}
> > -
>=20
> You should add test_fionread_ioctl() at the right place from the start.

Fair enough, done.

> >  TEST_F_FORK(ioctl, handle_dir_access_file)
> >  {
> >  	const int flag =3D 0;
> > --=20
> > 2.44.0.278.ge034bb2e1d-goog
> >=20
> >=20

=E2=80=94G=C3=BCnther

