Return-Path: <linux-fsdevel+bounces-55903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA196B0FBED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 23:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BADC0AA1BC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 21:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4712D20E31C;
	Wed, 23 Jul 2025 21:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="mbCGSZTn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7480D80C02
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 21:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753304517; cv=none; b=NENpxGCG9krYyZpnVWZsV1AOffrE56JotloJVXgMEyGD85LwAX75TRYgFCvn3qmvjpMqwxqUkieJP8/pD8zR4SAQEOV2vXmBjq1zBH9Gcmsfpb7zV5DZ/q0sYdvcUfqxPwo1JapbskYSVGQYNoUz0F9f25nPmxSjuknLDbo5B0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753304517; c=relaxed/simple;
	bh=n+0HSs87fesXbREkl+dtrCopS3LC+zQD7e1RCVVR3QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shRI/ldyQQcrh7NBO3II2XGTGReJrzUDLM3KLJ9SjU07tGAKe7mTba3Y4tENLSzjlSdqtxpAN/cDvUN2GLM1/zKuyjnkwB1jHNrTMg99Thnw0WEQOdZ3/Dk9XThVhMbBLSu4wFeMF7mSZPKdan5/FtWxeSFYExeXdEpYZfJQJFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=mbCGSZTn; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bnRQH5dB9zH39;
	Wed, 23 Jul 2025 23:01:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1753304503;
	bh=YMBV64h4usnoU4LNYkOsA6ceCQPl0nWBOgtg+p6IAS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mbCGSZTncRc+BI2sYHaiBkv/zmtwpKLe0TASKjh9X2cVkzjCG9OnOpu57igaudzzV
	 LJXSRzU14qLT8nI+4XxXybRv141mmV1jmMoxZkNq2POt+YDF5MKuIXsj3vKx4xBhFj
	 WGLL3L9FUcY/PcfGsHsfKSPrqePb7CTtxLPIWn4I=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4bnRQG5mwmz3hd;
	Wed, 23 Jul 2025 23:01:42 +0200 (CEST)
Date: Wed, 23 Jul 2025 23:01:42 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Jann Horn <jannh@google.com>, 
	John Johansen <john.johansen@canonical.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Ben Scarlato <akhna@google.com>, 
	Christian Brauner <brauner@kernel.org>, Daniel Burgener <dburgener@linux.microsoft.com>, 
	Jeff Xu <jeffxu@google.com>, NeilBrown <neil@brown.name>, Paul Moore <paul@paul-moore.com>, 
	Ryan Sullivan <rysulliv@redhat.com>, Song Liu <song@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/4] landlock: Fix handling of disconnected directories
Message-ID: <20250723.vouso1Kievao@digikod.net>
References: <20250719104204.545188-1-mic@digikod.net>
 <20250719104204.545188-3-mic@digikod.net>
 <18425339-1f4b-4d98-8400-1decef26eda7@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18425339-1f4b-4d98-8400-1decef26eda7@maowtm.org>
X-Infomaniak-Routing: alpha

On Tue, Jul 22, 2025 at 07:04:02PM +0100, Tingmao Wang wrote:
> On 7/19/25 11:42, Mickaël Salaün wrote:
> > [...]
> > @@ -784,12 +787,18 @@ static bool is_access_to_paths_allowed(
> >  	if (WARN_ON_ONCE(!layer_masks_parent1))
> >  		return false;
> >  
> > -	allowed_parent1 = is_layer_masks_allowed(layer_masks_parent1);
> > -
> >  	if (unlikely(layer_masks_parent2)) {
> >  		if (WARN_ON_ONCE(!dentry_child1))
> >  			return false;
> >  
> > +		/*
> > +		 * Creates a backup of the initial layer masks to be able to restore
> > +		 * them if we find out that we were walking a disconnected directory,
> > +		 * which would make the collected access rights inconsistent (cf.
> > +		 * reset_to_mount_root).
> > +		 */
> 
> This comment is duplicate with the one below, is this intentional?
> 
> > [...]
> 
> On the other hand, I'm still a bit uncertain about the domain check
> semantics.  While it would not cause a rename to be allowed if it is
> otherwise not allowed by any rules on or above the mountpoint, this gets a
> bit weird if we have a situation where renames are allowed on the
> mountpoint or everywhere, but not read/writes, however read/writes are
> allowed directly on a file, but the dir containing that file gets
> disconnected so the sandboxed application can't read or write to it.
> (Maybe someone would set up such a policy where renames are allowed,
> expecting Landlock to always prevent renames where additional permissions
> would be exposed?)
> 
> In the above situation, if the file is then moved to a connected
> directory, it will become readable/writable again.

We can generalize this issue to not only the end file but any component
of the path: disconnected directories.  In fact, the main issue is the
potential inconsistency of access checks over time (e.g. between two
renames).  This could be exploited to bypass the security checks done
for FS_REFER.

I see two solutions:

1. *Always* walk down to the IS_ROOT directory, and then jump to the
   mount point.  This makes it possible to have consistent access checks
   for renames and open/use.  The first downside is that that would
   change the current behavior for bind mounts that could get more
   access rights (if the policy explicitly sets rights for the hidden
   directories).  The second downside is that we'll do more walk.

2. Return -EACCES (or -ENOENT) for actions involving disconnected
   directories, or renames of disconnected opened files.  This second
   solution is simpler and safer but completely disables the use of
   disconnected directories and the rename of disconnected files for
   sandboxed processes.

It would be much better to be able to handle opened directories as
(object) capabilities, but that is not currently possible because of the
way paths are handled by the VFS and LSM hooks.

Tingmao, Günther, Jann, what do you think?

It looks like AppArmor also denies access to disconnected path in some
cases, but it tries to reconstruct the path for known internal
filesystems, and it seems to specifically handle the case of chroot.  I
don't know when PATH_CONNECT_PATH is set though.

John, could you please clarify how disconnected directories and files
are handled by AppArmor?

> 
> Here is an example test, using the layout1_bind fixture for flexibility
> for now (and also because I needed to just go to bed yesterday lol) (but
> this would probably be better written as an additional
> layout5_disconnected_branch variant).
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 21dd95aaf5e4..2274f165d933 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -5100,6 +5100,118 @@ TEST_F_FORK(layout1_bind, path_disconnected_rename)
>  	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
>  }
>  
> +static void
> +path_disconnected_gain_back_rights_via_rename(struct __test_metadata *_metadata,
> +					      bool has_read_rule_on_other_d)
> +{
> +	/*
> +	 * This is a ruleset where rename/create/delete rights are allowed
> +	 * anywhere under the mount, and so still applies after path gets
> +	 * disconnected.  However the only read right is given to the file
> +	 * directly, and therefore the file is no longer readable after the
> +	 * path to it being disconnected.
> +	 */
> +	// clang-format off
> +	struct rule layer1[] = {
> +		{
> +			.path = dir_s2d2,
> +			.access = LANDLOCK_ACCESS_FS_REFER |
> +					LANDLOCK_ACCESS_FS_MAKE_DIR |
> +					LANDLOCK_ACCESS_FS_REMOVE_DIR |
> +					LANDLOCK_ACCESS_FS_MAKE_REG |
> +					LANDLOCK_ACCESS_FS_REMOVE_FILE
> +		},
> +		{
> +			.path = file1_s1d3,
> +			.access = LANDLOCK_ACCESS_FS_READ_FILE,
> +		},
> +		{
> +			.path = TMP_DIR "/s1d1/s1d2/s1d3_2",
> +			.access = LANDLOCK_ACCESS_FS_READ_FILE,
> +		},
> +		{}
> +	};
> +	// clang-format on
> +
> +	int ruleset_fd, bind_s1d3_fd, res;
> +
> +	if (!has_read_rule_on_other_d) {
> +		layer1[2].path = NULL;
> +		layer1[2].access = 0;
> +	}
> +
> +	ASSERT_EQ(0, mkdir(dir_s4d1, 0755))
> +	{
> +		TH_LOG("Failed to create %s: %s", dir_s4d1, strerror(errno));
> +	}
> +
> +	/* Directory used to move the file into, in order to try to regain read */
> +	ASSERT_EQ(0, mkdir(TMP_DIR "/s1d1/s1d2/s1d3_2", 0755))
> +	{
> +		TH_LOG("Failed to create %s: %s", TMP_DIR "/s1d1/s1d2/s1d3_2",
> +		       strerror(errno));
> +	}
> +
> +	ruleset_fd = create_ruleset(_metadata, ACCESS_ALL, layer1);
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	bind_s1d3_fd = open(bind_dir_s1d3, O_PATH | O_CLOEXEC);
> +	ASSERT_LE(0, bind_s1d3_fd);
> +	EXPECT_EQ(0, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
> +
> +	/* Make disconnected */
> +	ASSERT_EQ(0, rename(dir_s1d3, dir_s4d2))
> +	{
> +		TH_LOG("Failed to rename %s to %s: %s", dir_s1d3, dir_s4d2,
> +		       strerror(errno));
> +	}
> +
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	EXPECT_EQ(0, close(ruleset_fd));
> +
> +	/* We shouldn't be able to read file1 under disconnected path now */
> +	EXPECT_EQ(EACCES, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
> +
> +	/*
> +	 * But can we circumvent it by moving file1 to a connected path when
> +	 * either we're allowed to read that move destination, or if we have
> +	 * allow rules on the original file, then the move target doesn't even
> +	 * need read rules on itself.
> +	 *
> +	 * This is possible even though the domain check should semantically
> +	 * ensure that any path (?) we can't read can't become readable
> +	 * (through that path) again by a rename?
> +	 */
> +	res = renameat(bind_s1d3_fd, file1_name, AT_FDCWD,
> +		       TMP_DIR "/s2d1/s2d2/s1d3_2/f1");
> +	if (res == 0) {
> +		TH_LOG("Renamed file1 to %s, which should not have been allowed.",
> +		       TMP_DIR "/s2d1/s2d2/s1d3_2/f1");
> +		/* At this point the test has failed, but let's try reading it */
> +		res = test_open(TMP_DIR "/s2d1/s2d2/s1d3_2/f1", O_RDONLY);
> +		if (res != 0) {
> +			TH_LOG("Failed to read file1 after rename: %s",
> +			       strerror(res));
> +		} else {
> +			TH_LOG("file1 is readable after rename!");
> +			ASSERT_TRUE(false);
> +		}
> +		ASSERT_TRUE(false);
> +	}
> +	ASSERT_EQ(-1, res);
> +	EXPECT_EQ(EXDEV, errno);
> +}
> +
> +TEST_F_FORK(layout1_bind, path_disconnected_gain_back_rights_1)
> +{
> +	path_disconnected_gain_back_rights_via_rename(_metadata, false);
> +}
> +
> +TEST_F_FORK(layout1_bind, path_disconnected_gain_back_rights_2)
> +{
> +	path_disconnected_gain_back_rights_via_rename(_metadata, true);
> +}
> +
>  /*
>   * Test that linkat(2) with disconnected paths works under Landlock. This
>   * test moves s1d3 to s4d1.
> 
> The behavior is as hypothesized above:
> 
> 	root@b8f2ef644787 /t/landlock# ./fs_test -t path_disconnected_gain_back_rights_1 -t path_disconnected_gain_back_rights_2
> 	TAP version 13
> 	1..2
> 	# Starting 2 tests from 1 test cases.
> 	#  RUN           layout1_bind.path_disconnected_gain_back_rights_1 ...
> 	# fs_test.c:5188:path_disconnected_gain_back_rights_1:Renamed file1 to tmp/s2d1/s2d2/s1d3_2/f1, which should not have been allowed.
> 	# fs_test.c:5196:path_disconnected_gain_back_rights_1:file1 is readable after rename!
> 	# fs_test.c:5197:path_disconnected_gain_back_rights_1:Expected 0 (0) != false (0)
> 	# path_disconnected_gain_back_rights_1: Test terminated by assertion
> 	#          FAIL  layout1_bind.path_disconnected_gain_back_rights_1
> 	not ok 1 layout1_bind.path_disconnected_gain_back_rights_1
> 	#  RUN           layout1_bind.path_disconnected_gain_back_rights_2 ...
> 	# fs_test.c:5188:path_disconnected_gain_back_rights_2:Renamed file1 to tmp/s2d1/s2d2/s1d3_2/f1, which should not have been allowed.
> 	# fs_test.c:5196:path_disconnected_gain_back_rights_2:file1 is readable after rename!
> 	# fs_test.c:5197:path_disconnected_gain_back_rights_2:Expected 0 (0) != false (0)
> 	# path_disconnected_gain_back_rights_2: Test terminated by assertion
> 	#          FAIL  layout1_bind.path_disconnected_gain_back_rights_2
> 	not ok 2 layout1_bind.path_disconnected_gain_back_rights_2
> 	# FAILED: 0 / 2 tests passed.
> 	# Totals: pass:0 fail:2 xfail:0 xpass:0 skip:0 error:0
> 
> Would it be worth it to have the domain check take into account this edge
> case?  (But on the other hand, one could argue that if rights are granted
> directly to a file, then the policy author intended for access to be
> allowed, but in which case shouldn't access, even if through disconnected
> path, be allowed?)
> 
> Best,
> Tingmao
> 

