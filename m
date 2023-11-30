Return-Path: <linux-fsdevel+bounces-4347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B3D7FED00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 11:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31BC1C2030B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 10:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110FE3C061
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="EtxLv10c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA99BD
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 01:28:13 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SgrTQ2nngzMqFVV;
	Thu, 30 Nov 2023 09:28:10 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SgrTP4DFfzMppBR;
	Thu, 30 Nov 2023 10:28:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1701336490;
	bh=p5GkyzCCG+8SDkrIxBXGWp91SA70cAopkuZGmxeIp9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EtxLv10cCcG/gboZmYr2+T3YssOwQDhL3HDvzzji73VmWMHckAm2fNKO9idFL6/rT
	 k0kFBKsPHC/HHq7i5KTuYNrKgDhcpTO9KdaFqI3NYmSvax6RaVkh7jXiHd+NRZT3m2
	 TMDIBDOl7OfclavP72ivYp+wxNUPesoNYHj7JkKQ=
Date: Thu, 30 Nov 2023 10:28:08 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 3/7] selftests/landlock: Test IOCTL support
Message-ID: <20231130.iaghae9Puogh@digikod.net>
References: <20231117154920.1706371-1-gnoack@google.com>
 <20231117154920.1706371-4-gnoack@google.com>
 <20231120.AejoJ2ooja0i@digikod.net>
 <ZWDV-45LBwKvvgx1@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWDV-45LBwKvvgx1@google.com>
X-Infomaniak-Routing: alpha

On Fri, Nov 24, 2023 at 05:57:31PM +0100, Günther Noack wrote:
> Hi!
> 
> On Mon, Nov 20, 2023 at 09:41:20PM +0100, Mickaël Salaün wrote:
> > On Fri, Nov 17, 2023 at 04:49:16PM +0100, Günther Noack wrote:
> > > +FIXTURE_VARIANT(ioctl)
> > > +{
> > > +	const __u64 handled;
> > > +	const __u64 permitted;
> > 
> > Why not "allowed" like the rule's field? Same for the variant names.
> 
> Just for consistency with the ftruncate tests which also named it like that... %-)
> 
> Sounds good though, I'll just rename it in both places.
> 
> 
> > > +	const mode_t open_mode;
> > > +	/*
> > > +	 * These are the expected IOCTL results for a representative IOCTL from
> > > +	 * each of the IOCTL groups.  We only distinguish the 0 and EACCES
> > > +	 * results here, and treat other errors as 0.
> > 
> > In this case, why not use a boolean instead of a semi-correct error
> > code?
> 
> I found it slightly less convoluted.  When we use booleans here, we need to map
> between error codes and booleans at a different layer.  At the same time, we
> already have various test_foo_ioctl() and test_foo() functions, and they are
> sometimes also used in other contexts like test_fs_ioc_getflags_ioctl().  These
> test_foo() helpers generally return error codes so far, and it felt more
> important to stay consistent with that.  If we want to keep that both, the only
> other place to map between booleans and error codes would be with ternary
> operators or such in the EXPECT_EQ clauses, but that also felt like it would
> turn unreadable... %-)

Sounds good.

> 
> I can change it if you feel strongly about it though. Let me know.
> 
> > > +	 */
> > > +	const int expected_fioqsize_result; /* G1 */
> > > +	const int expected_fibmap_result; /* G2 */
> > > +	const int expected_fionread_result; /* G3 */
> > > +	const int expected_fs_ioc_zero_range_result; /* G4 */
> > > +	const int expected_fs_ioc_getflags_result; /* other */
> > > +};
> > > +
> > > +/* clang-format off */
> > > +FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_i_permitted_none) {
> > 
> > You can remove all the variant's "ioctl_" prefixes.
> 
> Done.
> 
> 
> > > +	/* clang-format on */
> > > +	.handled = LANDLOCK_ACCESS_FS_EXECUTE | LANDLOCK_ACCESS_FS_IOCTL,
> > > +	.permitted = LANDLOCK_ACCESS_FS_EXECUTE,
> > 
> > You could use 0 instead and don't add the related rule in this case.
> 
> Done.
> 
> 
> > Great tests!
> 
> Thanks :)
> 
> 
> > > +static int test_fioqsize_ioctl(int fd)
> > > +{
> > > +	size_t sz;
> > > +
> > > +	if (ioctl(fd, FIOQSIZE, &sz) < 0)
> > > +		return errno;
> > > +	return 0;
> > > +}
> > > +
> > > +static int test_fibmap_ioctl(int fd)
> > > +{
> > > +	int blk = 0;
> > > +
> > > +	/*
> > > +	 * We only want to distinguish here whether Landlock already caught it,
> > > +	 * so we treat anything but EACCESS as success.  (It commonly returns
> > > +	 * EPERM when missing CAP_SYS_RAWIO.)
> > > +	 */
> > > +	if (ioctl(fd, FIBMAP, &blk) < 0 && errno == EACCES)
> > > +		return errno;
> > > +	return 0;
> > > +}
> > > +
> > > +static int test_fionread_ioctl(int fd)
> > > +{
> > > +	size_t sz = 0;
> > > +
> > > +	if (ioctl(fd, FIONREAD, &sz) < 0 && errno == EACCES)
> > > +		return errno;
> > > +	return 0;
> > > +}
> > > +
> > > +#define FS_IOC_ZERO_RANGE _IOW('X', 57, struct space_resv)
> > > +
> > > +static int test_fs_ioc_zero_range_ioctl(int fd)
> > > +{
> > > +	struct space_resv {
> > > +		__s16 l_type;
> > > +		__s16 l_whence;
> > > +		__s64 l_start;
> > > +		__s64 l_len; /* len == 0 means until end of file */
> > > +		__s32 l_sysid;
> > > +		__u32 l_pid;
> > > +		__s32 l_pad[4]; /* reserved area */
> > > +	} reservation = {};
> > > +	/*
> > > +	 * This can fail for various reasons, but we only want to distinguish
> > > +	 * here whether Landlock already caught it, so we treat anything but
> > > +	 * EACCES as success.
> > > +	 */
> > > +	if (ioctl(fd, FS_IOC_ZERO_RANGE, &reservation) < 0 && errno == EACCES)
> > 
> > What are the guarantees that an error different than EACCES would not
> > mask EACCES and then make tests pass whereas they should not?
> 
> It is indeed possible that one of these ioctls legitimately returns EACCES after
> Landlock was letting that ioctl through, and then we could not tell apart
> whether Landlock blocked it or whether the underlying IOCTL command returned
> that.  I double checked that this is not the case for these specific
> invocations.  But with some other IOCTL commands in these groups, I believe I
> was getting EACCES sometimes from the IOCTL.  So we only use one representative
> IOCTL from each IOCTL group, for which it happened to work.
> 
> To convince yourself, you can see in the tests that we have both "success" and
> "blocked" examples in the tests for each of these IOCTL commands, and the
> Landlock rules are the only difference between these examples. Therefore, we
> know that it is actually Landlock returning the EACCES and not the underlying
> IOCTL.

This is correct, at least for now. Let's stick to that.

> 
> > > +		return errno;
> > > +	return 0;
> > > +}
> > > +
> > > +TEST_F_FORK(ioctl, handle_dir_access_file)
> > > +{
> > > +	const int flag = 0;
> > > +	const struct rule rules[] = {
> > > +		{
> > > +			.path = dir_s1d1,
> > > +			.access = variant->permitted,
> > > +		},
> > > +		{},
> > > +	};
> > > +	int fd, ruleset_fd;
> > 
> > Please rename fd into something like file_fd.
> 
> Done.
> 
> 
> > > +TEST_F_FORK(ioctl, handle_file_access_file)
> > > +{
> > > +	const char *const path = file1_s1d1;
> > > +	const int flag = 0;
> > > +	const struct rule rules[] = {
> > > +		{
> > > +			.path = path,
> > > +			.access = variant->permitted,
> > > +		},
> > > +		{},
> > > +	};
> > > +	int fd, ruleset_fd;
> > > +
> > > +	if (variant->permitted & LANDLOCK_ACCESS_FS_READ_DIR) {
> > > +		/* This access right can not be granted on files. */
> > > +		return;
> > > +	}
> > 
> > You should use SKIP().
> 
> Done.
> 
> 
> > > +	/* Enables Landlock. */
> > > +	ruleset_fd = create_ruleset(_metadata, variant->handled, rules);
> > > +	ASSERT_LE(0, ruleset_fd);
> > > +	enforce_ruleset(_metadata, ruleset_fd);
> > > +	ASSERT_EQ(0, close(ruleset_fd));
> > > +
> > > +	fd = open(path, variant->open_mode);
> > > +	ASSERT_LE(0, fd);
> > > +
> > > +	/*
> > > +	 * Checks that IOCTL commands in each IOCTL group return the expected
> > > +	 * errors.
> > > +	 */
> > > +	EXPECT_EQ(variant->expected_fioqsize_result, test_fioqsize_ioctl(fd));
> > > +	EXPECT_EQ(variant->expected_fibmap_result, test_fibmap_ioctl(fd));
> > > +	EXPECT_EQ(variant->expected_fionread_result, test_fionread_ioctl(fd));
> > > +	EXPECT_EQ(variant->expected_fs_ioc_zero_range_result,
> > > +		  test_fs_ioc_zero_range_ioctl(fd));
> > > +	EXPECT_EQ(variant->expected_fs_ioc_getflags_result,
> > > +		  test_fs_ioc_getflags_ioctl(fd));
> > > +
> > > +	/* Checks that unrestrictable commands are unrestricted. */
> > > +	EXPECT_EQ(0, ioctl(fd, FIOCLEX));
> > > +	EXPECT_EQ(0, ioctl(fd, FIONCLEX));
> > > +	EXPECT_EQ(0, ioctl(fd, FIONBIO, &flag));
> > > +	EXPECT_EQ(0, ioctl(fd, FIOASYNC, &flag));
> > > +
> > > +	ASSERT_EQ(0, close(fd));
> > > +}
> > 
> > Don't you want to create and use a common helper with most of these
> > TEST_F_FORK blocks? It would highlight what is the same or different,
> > and it would also enables to extend the coverage to other file types
> > (e.g. character device).
> 
> I did not find a good way to factor this out, to be honest, and so preferred to
> keep it unrolled.
> 
> I try to follow the rule of not putting too many "if" conditions and logic into
> my tests (it helps to keep the tests straightforward and understandable), and I
> find it more straightforward to spell out these few EXPECT_EQs three times than
> introducing a "test_all_ioctl_expectations()" helper function :)

I understand, but I'm not sure there would be so much "if" that it would
be difficult to understand. Did you try to factor it out with the
_metadata argument?

> 
> —Günther
> 

