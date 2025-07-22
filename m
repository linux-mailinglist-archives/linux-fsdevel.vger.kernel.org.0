Return-Path: <linux-fsdevel+bounces-55714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8309B0E336
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 20:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A90B1886BF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 18:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7416328000A;
	Tue, 22 Jul 2025 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="RmaqNLPm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eFI5pVpx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333221DF270;
	Tue, 22 Jul 2025 18:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753207449; cv=none; b=tbQmksa+CM/hYBbfgkj1GHmAKHobIsWSB7NTDEgE09CL+Tn6/IqEk/G6GAbNeARnd8aFBS25U+m4LZNjRARTELgr07WdGfl6gHbdxJN5PXA9nxEThBAp5vYXdZFnTa6OER+mYq26qCpjGdgybGnEp3PcdltDz7jY71l5lH5Miz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753207449; c=relaxed/simple;
	bh=O4W9ok36sOMhqnk/GG/Fs1eqq/lA4zTF19ANoOfjY6A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=u5lF2DV+kogEtaMyIcNJBZNk+/J42yxAhPccQvGz/cz6+GMoM6iyxY+Y8EB5NaypV9g1vtTZVHsrSjeyE1goyXI8zJdpdg2EoIefO1ltGHUrbf9Lqcq5NA3DOotr4fzKuPbinGudoelsGhHYoaTqRIIxW2A4ICxPwW4d42kwWZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=RmaqNLPm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eFI5pVpx; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3F6A21400504;
	Tue, 22 Jul 2025 14:04:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 22 Jul 2025 14:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753207446;
	 x=1753293846; bh=+hXXyBYk+ld9rL0qPwJPscTr5LI2GnAdvZDaR8aPFTI=; b=
	RmaqNLPml8Vf4V9JGAnIohmfh4VDCSbqwcAnl7gCqaFnjheBOWVhGIvHb99M97tI
	7/NTZC0IgyJkzD0tWrNwMUOUtA3XwolLmKCJKjJOaoDffett+4w36e3oiHv213kb
	LLL3OQ+qIQuEL+W427hLmMpLwMiqDhY66LlUBKietJtE2Z8dunMds7FRpJw0vpsE
	iu9Fl93+mpCcCuj63MdkEGeTIjkPubY69RKUmk5vrvY/DjKF2bCcF8zjkIqHDWsr
	KtQQw4JMif2/XDN/i2cGzRVd+P6EPsfs9Kq9zz9qRNea4471ZbbjYriTmTBT76Io
	eXSxQSwTDWMxgyQjhDVKYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753207446; x=
	1753293846; bh=+hXXyBYk+ld9rL0qPwJPscTr5LI2GnAdvZDaR8aPFTI=; b=e
	FI5pVpxk+a4d+Jaye4xw/MRUYUC8g/yXdgnuipxwE3fE1j7BHFVSVQJuhoguh3SB
	0w3CBI0wjSmmThfEtdY9Tzv3W6GGqDCPitZjBdQ/BvlCNC0UCvk8QlSUMtKNNt4c
	H7Ya9zvWiHrS+07uD8HQOBHoLB747amlggR9EZHHqSRZNw9phGeiFT637Tt5W2EP
	dvck/wIizPYsI1K+mO2/ibaSXH3db+6mzZDYKvXPFK7dbGA8hku++Tr+iiLZMGo9
	w6jvXnBnwk10KSRBlPQ+UzkQkTVIbQ6APIqWdr+Ep9mFAQ+/7gDkWGRL6DsQdZ78
	uBa6s2TClsNCAHEWoQrqw==
X-ME-Sender: <xms:lNJ_aKlibJG951BX2A7AdY27GFYNZfNDEnHQttr1n7IQbczugJ1maQ>
    <xme:lNJ_aNp3XHovF_Rj3Vit46qRobmxCEDzKkr_2_mchuNVHkbXvKde9zEhp-XeawTaM
    GRYb5Hq_YB9NyPp7dw>
X-ME-Received: <xmr:lNJ_aPEHbNEtra261RmSUj96fBergAQKSLIcvtyqKVQMgg-XRPLRl2kehcV0g2TwJiA1c2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejheehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfhuffvvehfjggtgfesthekredttddvjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpedvge
    duuefgudejgfdtteffudejjeelleeiudekueejudehtefghfegvdetveffueenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghksehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhr
    ghdruhhkpdhrtghpthhtoheprghkhhhnrgesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggsuhhrghgvnhgv
    rheslhhinhhugidrmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopehjrghnnhhhse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehjvghffhiguhesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepnhgvihhlsegsrhhofihnrdhnrghmvg
X-ME-Proxy: <xmx:ldJ_aLTseB4UIztJ9I1yziF27EoVWXw9LFo3P8fhbnYq4wG1Kgp8Cg>
    <xmx:ldJ_aNPzwB8Hbaupf1njJVWkNh8IcrGAX3T3yt0zJ7v_jAEpt5k_6A>
    <xmx:ldJ_aAnTngFa2Ph0jLFFY8f87Dey-qy474tXHEvoptfr4yINZCXV8Q>
    <xmx:ldJ_aHbAFxP9dOAQeNNjo4vlqN19WDS9mla37Toq2Vu_o5NVOlAoXQ>
    <xmx:ltJ_aH6Z2xPnsre9T-XEKmul9BeFA3gLo8zQ2xQ4QpNW1KAhkaAUQEbU>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 14:04:03 -0400 (EDT)
Message-ID: <18425339-1f4b-4d98-8400-1decef26eda7@maowtm.org>
Date: Tue, 22 Jul 2025 19:04:02 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH v3 2/4] landlock: Fix handling of disconnected directories
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Ben Scarlato <akhna@google.com>,
 Christian Brauner <brauner@kernel.org>,
 Daniel Burgener <dburgener@linux.microsoft.com>, Jann Horn
 <jannh@google.com>, Jeff Xu <jeffxu@google.com>, NeilBrown
 <neil@brown.name>, Paul Moore <paul@paul-moore.com>,
 Ryan Sullivan <rysulliv@redhat.com>, Song Liu <song@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20250719104204.545188-1-mic@digikod.net>
 <20250719104204.545188-3-mic@digikod.net>
Content-Language: en-US
In-Reply-To: <20250719104204.545188-3-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/19/25 11:42, Mickaël Salaün wrote:
> [...]
> @@ -784,12 +787,18 @@ static bool is_access_to_paths_allowed(
>  	if (WARN_ON_ONCE(!layer_masks_parent1))
>  		return false;
>  
> -	allowed_parent1 = is_layer_masks_allowed(layer_masks_parent1);
> -
>  	if (unlikely(layer_masks_parent2)) {
>  		if (WARN_ON_ONCE(!dentry_child1))
>  			return false;
>  
> +		/*
> +		 * Creates a backup of the initial layer masks to be able to restore
> +		 * them if we find out that we were walking a disconnected directory,
> +		 * which would make the collected access rights inconsistent (cf.
> +		 * reset_to_mount_root).
> +		 */

This comment is duplicate with the one below, is this intentional?

> [...]

On the other hand, I'm still a bit uncertain about the domain check
semantics.  While it would not cause a rename to be allowed if it is
otherwise not allowed by any rules on or above the mountpoint, this gets a
bit weird if we have a situation where renames are allowed on the
mountpoint or everywhere, but not read/writes, however read/writes are
allowed directly on a file, but the dir containing that file gets
disconnected so the sandboxed application can't read or write to it.
(Maybe someone would set up such a policy where renames are allowed,
expecting Landlock to always prevent renames where additional permissions
would be exposed?)

In the above situation, if the file is then moved to a connected
directory, it will become readable/writable again.

Here is an example test, using the layout1_bind fixture for flexibility
for now (and also because I needed to just go to bed yesterday lol) (but
this would probably be better written as an additional
layout5_disconnected_branch variant).

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 21dd95aaf5e4..2274f165d933 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -5100,6 +5100,118 @@ TEST_F_FORK(layout1_bind, path_disconnected_rename)
 	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
 }
 
+static void
+path_disconnected_gain_back_rights_via_rename(struct __test_metadata *_metadata,
+					      bool has_read_rule_on_other_d)
+{
+	/*
+	 * This is a ruleset where rename/create/delete rights are allowed
+	 * anywhere under the mount, and so still applies after path gets
+	 * disconnected.  However the only read right is given to the file
+	 * directly, and therefore the file is no longer readable after the
+	 * path to it being disconnected.
+	 */
+	// clang-format off
+	struct rule layer1[] = {
+		{
+			.path = dir_s2d2,
+			.access = LANDLOCK_ACCESS_FS_REFER |
+					LANDLOCK_ACCESS_FS_MAKE_DIR |
+					LANDLOCK_ACCESS_FS_REMOVE_DIR |
+					LANDLOCK_ACCESS_FS_MAKE_REG |
+					LANDLOCK_ACCESS_FS_REMOVE_FILE
+		},
+		{
+			.path = file1_s1d3,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{
+			.path = TMP_DIR "/s1d1/s1d2/s1d3_2",
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{}
+	};
+	// clang-format on
+
+	int ruleset_fd, bind_s1d3_fd, res;
+
+	if (!has_read_rule_on_other_d) {
+		layer1[2].path = NULL;
+		layer1[2].access = 0;
+	}
+
+	ASSERT_EQ(0, mkdir(dir_s4d1, 0755))
+	{
+		TH_LOG("Failed to create %s: %s", dir_s4d1, strerror(errno));
+	}
+
+	/* Directory used to move the file into, in order to try to regain read */
+	ASSERT_EQ(0, mkdir(TMP_DIR "/s1d1/s1d2/s1d3_2", 0755))
+	{
+		TH_LOG("Failed to create %s: %s", TMP_DIR "/s1d1/s1d2/s1d3_2",
+		       strerror(errno));
+	}
+
+	ruleset_fd = create_ruleset(_metadata, ACCESS_ALL, layer1);
+	ASSERT_LE(0, ruleset_fd);
+
+	bind_s1d3_fd = open(bind_dir_s1d3, O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, bind_s1d3_fd);
+	EXPECT_EQ(0, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
+
+	/* Make disconnected */
+	ASSERT_EQ(0, rename(dir_s1d3, dir_s4d2))
+	{
+		TH_LOG("Failed to rename %s to %s: %s", dir_s1d3, dir_s4d2,
+		       strerror(errno));
+	}
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/* We shouldn't be able to read file1 under disconnected path now */
+	EXPECT_EQ(EACCES, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
+
+	/*
+	 * But can we circumvent it by moving file1 to a connected path when
+	 * either we're allowed to read that move destination, or if we have
+	 * allow rules on the original file, then the move target doesn't even
+	 * need read rules on itself.
+	 *
+	 * This is possible even though the domain check should semantically
+	 * ensure that any path (?) we can't read can't become readable
+	 * (through that path) again by a rename?
+	 */
+	res = renameat(bind_s1d3_fd, file1_name, AT_FDCWD,
+		       TMP_DIR "/s2d1/s2d2/s1d3_2/f1");
+	if (res == 0) {
+		TH_LOG("Renamed file1 to %s, which should not have been allowed.",
+		       TMP_DIR "/s2d1/s2d2/s1d3_2/f1");
+		/* At this point the test has failed, but let's try reading it */
+		res = test_open(TMP_DIR "/s2d1/s2d2/s1d3_2/f1", O_RDONLY);
+		if (res != 0) {
+			TH_LOG("Failed to read file1 after rename: %s",
+			       strerror(res));
+		} else {
+			TH_LOG("file1 is readable after rename!");
+			ASSERT_TRUE(false);
+		}
+		ASSERT_TRUE(false);
+	}
+	ASSERT_EQ(-1, res);
+	EXPECT_EQ(EXDEV, errno);
+}
+
+TEST_F_FORK(layout1_bind, path_disconnected_gain_back_rights_1)
+{
+	path_disconnected_gain_back_rights_via_rename(_metadata, false);
+}
+
+TEST_F_FORK(layout1_bind, path_disconnected_gain_back_rights_2)
+{
+	path_disconnected_gain_back_rights_via_rename(_metadata, true);
+}
+
 /*
  * Test that linkat(2) with disconnected paths works under Landlock. This
  * test moves s1d3 to s4d1.

The behavior is as hypothesized above:

	root@b8f2ef644787 /t/landlock# ./fs_test -t path_disconnected_gain_back_rights_1 -t path_disconnected_gain_back_rights_2
	TAP version 13
	1..2
	# Starting 2 tests from 1 test cases.
	#  RUN           layout1_bind.path_disconnected_gain_back_rights_1 ...
	# fs_test.c:5188:path_disconnected_gain_back_rights_1:Renamed file1 to tmp/s2d1/s2d2/s1d3_2/f1, which should not have been allowed.
	# fs_test.c:5196:path_disconnected_gain_back_rights_1:file1 is readable after rename!
	# fs_test.c:5197:path_disconnected_gain_back_rights_1:Expected 0 (0) != false (0)
	# path_disconnected_gain_back_rights_1: Test terminated by assertion
	#          FAIL  layout1_bind.path_disconnected_gain_back_rights_1
	not ok 1 layout1_bind.path_disconnected_gain_back_rights_1
	#  RUN           layout1_bind.path_disconnected_gain_back_rights_2 ...
	# fs_test.c:5188:path_disconnected_gain_back_rights_2:Renamed file1 to tmp/s2d1/s2d2/s1d3_2/f1, which should not have been allowed.
	# fs_test.c:5196:path_disconnected_gain_back_rights_2:file1 is readable after rename!
	# fs_test.c:5197:path_disconnected_gain_back_rights_2:Expected 0 (0) != false (0)
	# path_disconnected_gain_back_rights_2: Test terminated by assertion
	#          FAIL  layout1_bind.path_disconnected_gain_back_rights_2
	not ok 2 layout1_bind.path_disconnected_gain_back_rights_2
	# FAILED: 0 / 2 tests passed.
	# Totals: pass:0 fail:2 xfail:0 xpass:0 skip:0 error:0

Would it be worth it to have the domain check take into account this edge
case?  (But on the other hand, one could argue that if rights are granted
directly to a file, then the policy author intended for access to be
allowed, but in which case shouldn't access, even if through disconnected
path, be allowed?)

Best,
Tingmao

