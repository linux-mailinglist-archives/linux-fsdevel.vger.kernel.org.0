Return-Path: <linux-fsdevel+bounces-3730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 129A37F79BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 17:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E156B21191
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 16:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D002AF00;
	Fri, 24 Nov 2023 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c8bpFJF/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EDE173D
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 08:57:43 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9cb79eb417so2023011276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 08:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700845062; x=1701449862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYTsHHxJlfG14dn+7UEWrCdCwra+hwU+w+BoD3ZTwsk=;
        b=c8bpFJF/+836jE7LohXY1eFXWDiB21DZWZeK9Di2Q4zCGIMzXlQrErhcGHZc9uaqFt
         MmqrPqGxuybO9rxse32Wo7AxpPndaWO47DE+oWsH4wdzkrd4iCCYPWXDxSMI8rPap9b8
         /+Z2ZaItr2LVUDebELgVpV9dS1Yf8vM0hTgr6ZDaYzQgcRejwJhNJRsZ+0EJg7wCVpgu
         Jr/M5PXYPoMZoa5IvMfMMOkQItSSTuu48LurlgzKZgYIuKVmyny3VvSks3hC5DW+amtg
         z9kdiFli+6luUir9EYgvAV0BLJQ+xPHvtbzFX5o19n9a78TbwQq5mb8Pek2CqMGCiPj/
         vzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700845062; x=1701449862;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TYTsHHxJlfG14dn+7UEWrCdCwra+hwU+w+BoD3ZTwsk=;
        b=PdQHoVszJjXr/gZoPFTDS5cxLykb3g0yUM3HKWcTQi0yop44vVd1uvKi9tzgnnYzU2
         OODFw1Wt53RKQqRIDzzLHLxQN3s0p1dj3SQ75CdK8AdHkBE3rrGCIUgM1mWbCNi7BhPs
         u26VGxvOBd0JL6XvsgnQ6vqZ1qWhemdLsnvT1+QlLDvOT0W86Kss90tzeMM+wE/q9TR6
         qGLSXWOUPY13T5ZoAYTrU8fuALBV5zXM2JaS2aJtIE53BXRSJu919DGxeEZD9u1MrZMm
         kAaCeTkZ4sr9SysU8UuVz4CL2ie25rlwV21dihQbTcBovRWjLH5w20AxHNq2SnQ01DAF
         OmCQ==
X-Gm-Message-State: AOJu0YydgP243zKTtA/bBAI8MWRfbGPHk/EOKVTDNOMZQQZOLT0BscVr
	jHKw/TveCg/BPXvXXZ2j0X5B242ckSA=
X-Google-Smtp-Source: AGHT+IGFAJ4m7iIGrj1H30McVPi7RXdRkuKrD0XqfpaoK4iYzPfQs8iy6yRVVhFO4Ahngifkhppf1AwMqwU=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:9429:6eed:3418:ad8a])
 (user=gnoack job=sendgmr) by 2002:a25:6f8b:0:b0:db4:4df:8c0d with SMTP id
 k133-20020a256f8b000000b00db404df8c0dmr105078ybc.11.1700845062654; Fri, 24
 Nov 2023 08:57:42 -0800 (PST)
Date: Fri, 24 Nov 2023 17:57:31 +0100
In-Reply-To: <20231120.AejoJ2ooja0i@digikod.net>
Message-Id: <ZWDV-45LBwKvvgx1@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231117154920.1706371-1-gnoack@google.com> <20231117154920.1706371-4-gnoack@google.com>
 <20231120.AejoJ2ooja0i@digikod.net>
Subject: Re: [PATCH v5 3/7] selftests/landlock: Test IOCTL support
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi!

On Mon, Nov 20, 2023 at 09:41:20PM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, Nov 17, 2023 at 04:49:16PM +0100, G=C3=BCnther Noack wrote:
> > +FIXTURE_VARIANT(ioctl)
> > +{
> > +	const __u64 handled;
> > +	const __u64 permitted;
>=20
> Why not "allowed" like the rule's field? Same for the variant names.

Just for consistency with the ftruncate tests which also named it like that=
... %-)

Sounds good though, I'll just rename it in both places.


> > +	const mode_t open_mode;
> > +	/*
> > +	 * These are the expected IOCTL results for a representative IOCTL fr=
om
> > +	 * each of the IOCTL groups.  We only distinguish the 0 and EACCES
> > +	 * results here, and treat other errors as 0.
>=20
> In this case, why not use a boolean instead of a semi-correct error
> code?

I found it slightly less convoluted.  When we use booleans here, we need to=
 map
between error codes and booleans at a different layer.  At the same time, w=
e
already have various test_foo_ioctl() and test_foo() functions, and they ar=
e
sometimes also used in other contexts like test_fs_ioc_getflags_ioctl().  T=
hese
test_foo() helpers generally return error codes so far, and it felt more
important to stay consistent with that.  If we want to keep that both, the =
only
other place to map between booleans and error codes would be with ternary
operators or such in the EXPECT_EQ clauses, but that also felt like it woul=
d
turn unreadable... %-)

I can change it if you feel strongly about it though. Let me know.

> > +	 */
> > +	const int expected_fioqsize_result; /* G1 */
> > +	const int expected_fibmap_result; /* G2 */
> > +	const int expected_fionread_result; /* G3 */
> > +	const int expected_fs_ioc_zero_range_result; /* G4 */
> > +	const int expected_fs_ioc_getflags_result; /* other */
> > +};
> > +
> > +/* clang-format off */
> > +FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_i_permitted_none) {
>=20
> You can remove all the variant's "ioctl_" prefixes.

Done.


> > +	/* clang-format on */
> > +	.handled =3D LANDLOCK_ACCESS_FS_EXECUTE | LANDLOCK_ACCESS_FS_IOCTL,
> > +	.permitted =3D LANDLOCK_ACCESS_FS_EXECUTE,
>=20
> You could use 0 instead and don't add the related rule in this case.

Done.


> Great tests!

Thanks :)


> > +static int test_fioqsize_ioctl(int fd)
> > +{
> > +	size_t sz;
> > +
> > +	if (ioctl(fd, FIOQSIZE, &sz) < 0)
> > +		return errno;
> > +	return 0;
> > +}
> > +
> > +static int test_fibmap_ioctl(int fd)
> > +{
> > +	int blk =3D 0;
> > +
> > +	/*
> > +	 * We only want to distinguish here whether Landlock already caught i=
t,
> > +	 * so we treat anything but EACCESS as success.  (It commonly returns
> > +	 * EPERM when missing CAP_SYS_RAWIO.)
> > +	 */
> > +	if (ioctl(fd, FIBMAP, &blk) < 0 && errno =3D=3D EACCES)
> > +		return errno;
> > +	return 0;
> > +}
> > +
> > +static int test_fionread_ioctl(int fd)
> > +{
> > +	size_t sz =3D 0;
> > +
> > +	if (ioctl(fd, FIONREAD, &sz) < 0 && errno =3D=3D EACCES)
> > +		return errno;
> > +	return 0;
> > +}
> > +
> > +#define FS_IOC_ZERO_RANGE _IOW('X', 57, struct space_resv)
> > +
> > +static int test_fs_ioc_zero_range_ioctl(int fd)
> > +{
> > +	struct space_resv {
> > +		__s16 l_type;
> > +		__s16 l_whence;
> > +		__s64 l_start;
> > +		__s64 l_len; /* len =3D=3D 0 means until end of file */
> > +		__s32 l_sysid;
> > +		__u32 l_pid;
> > +		__s32 l_pad[4]; /* reserved area */
> > +	} reservation =3D {};
> > +	/*
> > +	 * This can fail for various reasons, but we only want to distinguish
> > +	 * here whether Landlock already caught it, so we treat anything but
> > +	 * EACCES as success.
> > +	 */
> > +	if (ioctl(fd, FS_IOC_ZERO_RANGE, &reservation) < 0 && errno =3D=3D EA=
CCES)
>=20
> What are the guarantees that an error different than EACCES would not
> mask EACCES and then make tests pass whereas they should not?

It is indeed possible that one of these ioctls legitimately returns EACCES =
after
Landlock was letting that ioctl through, and then we could not tell apart
whether Landlock blocked it or whether the underlying IOCTL command returne=
d
that.  I double checked that this is not the case for these specific
invocations.  But with some other IOCTL commands in these groups, I believe=
 I
was getting EACCES sometimes from the IOCTL.  So we only use one representa=
tive
IOCTL from each IOCTL group, for which it happened to work.

To convince yourself, you can see in the tests that we have both "success" =
and
"blocked" examples in the tests for each of these IOCTL commands, and the
Landlock rules are the only difference between these examples. Therefore, w=
e
know that it is actually Landlock returning the EACCES and not the underlyi=
ng
IOCTL.

> > +		return errno;
> > +	return 0;
> > +}
> > +
> > +TEST_F_FORK(ioctl, handle_dir_access_file)
> > +{
> > +	const int flag =3D 0;
> > +	const struct rule rules[] =3D {
> > +		{
> > +			.path =3D dir_s1d1,
> > +			.access =3D variant->permitted,
> > +		},
> > +		{},
> > +	};
> > +	int fd, ruleset_fd;
>=20
> Please rename fd into something like file_fd.

Done.


> > +TEST_F_FORK(ioctl, handle_file_access_file)
> > +{
> > +	const char *const path =3D file1_s1d1;
> > +	const int flag =3D 0;
> > +	const struct rule rules[] =3D {
> > +		{
> > +			.path =3D path,
> > +			.access =3D variant->permitted,
> > +		},
> > +		{},
> > +	};
> > +	int fd, ruleset_fd;
> > +
> > +	if (variant->permitted & LANDLOCK_ACCESS_FS_READ_DIR) {
> > +		/* This access right can not be granted on files. */
> > +		return;
> > +	}
>=20
> You should use SKIP().

Done.


> > +	/* Enables Landlock. */
> > +	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
> > +	ASSERT_LE(0, ruleset_fd);
> > +	enforce_ruleset(_metadata, ruleset_fd);
> > +	ASSERT_EQ(0, close(ruleset_fd));
> > +
> > +	fd =3D open(path, variant->open_mode);
> > +	ASSERT_LE(0, fd);
> > +
> > +	/*
> > +	 * Checks that IOCTL commands in each IOCTL group return the expected
> > +	 * errors.
> > +	 */
> > +	EXPECT_EQ(variant->expected_fioqsize_result, test_fioqsize_ioctl(fd))=
;
> > +	EXPECT_EQ(variant->expected_fibmap_result, test_fibmap_ioctl(fd));
> > +	EXPECT_EQ(variant->expected_fionread_result, test_fionread_ioctl(fd))=
;
> > +	EXPECT_EQ(variant->expected_fs_ioc_zero_range_result,
> > +		  test_fs_ioc_zero_range_ioctl(fd));
> > +	EXPECT_EQ(variant->expected_fs_ioc_getflags_result,
> > +		  test_fs_ioc_getflags_ioctl(fd));
> > +
> > +	/* Checks that unrestrictable commands are unrestricted. */
> > +	EXPECT_EQ(0, ioctl(fd, FIOCLEX));
> > +	EXPECT_EQ(0, ioctl(fd, FIONCLEX));
> > +	EXPECT_EQ(0, ioctl(fd, FIONBIO, &flag));
> > +	EXPECT_EQ(0, ioctl(fd, FIOASYNC, &flag));
> > +
> > +	ASSERT_EQ(0, close(fd));
> > +}
>=20
> Don't you want to create and use a common helper with most of these
> TEST_F_FORK blocks? It would highlight what is the same or different,
> and it would also enables to extend the coverage to other file types
> (e.g. character device).

I did not find a good way to factor this out, to be honest, and so preferre=
d to
keep it unrolled.

I try to follow the rule of not putting too many "if" conditions and logic =
into
my tests (it helps to keep the tests straightforward and understandable), a=
nd I
find it more straightforward to spell out these few EXPECT_EQs three times =
than
introducing a "test_all_ioctl_expectations()" helper function :)

=E2=80=94G=C3=BCnther

