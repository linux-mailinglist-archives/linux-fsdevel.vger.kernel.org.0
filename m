Return-Path: <linux-fsdevel+bounces-52973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971FCAE8FA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 22:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C5E3A05AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 20:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCC31F9A89;
	Wed, 25 Jun 2025 20:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="h8KwLdr+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JMJDxPEW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972CD3074AD;
	Wed, 25 Jun 2025 20:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750884374; cv=none; b=utYGWdKRcUQrOLk6Nw2MXOjsRqV/xN4reClrT8aPJibMrMyA2UR1FoTr/kJpKQYdU/HzsAd9hPWSDuaOHwW9+1DDomqbl9dGxsrtA8B+Hp2yCzDfGhg3DxEajHDmTaylw7nwfSe5WB7K1Enucc1IFdir7rUiIb/PSXt1Rx81gs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750884374; c=relaxed/simple;
	bh=X3G8TIBuvD+MPpUacMStN/hat902oPYw8jSbLP174qM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QsBg9HqxhHD+4CQRYzl1I86h0jxy/dJZsZKNOiLx+ELeyrr5csn0MGw4a7fYgXwOjBPu5oIwMun/V9OOXLK4BgxMetzxPy4srU33b7CJvUgfrHsawAXc3OelXQm5DpWG1HxQ61AzX/XQhODp7Rj4aJYo7z88b+MvQEkLt+I54pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=h8KwLdr+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JMJDxPEW; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A2AF514000FC;
	Wed, 25 Jun 2025 16:46:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 25 Jun 2025 16:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750884370;
	 x=1750970770; bh=smnrFKiUQf0vR+IQX4MMZ/DMtVkDodX+DHYGu1XEt80=; b=
	h8KwLdr++Ti2OvbNCACZ3mBMltl9xxNZ3FbAjwJzc3cbIvbvnaHJkb8WHiDHJqvM
	JtwRYM8p580NSo84y8hAAhD/FT5KpWVet7phpxeRPxww9pu6X3jcif05Mnz67Rjo
	lJTcNA/frDc/KvUVI1RvXfYezxSJgdcuD+/1yvF6gNVXfdoPqAMOykSrcvwHm4KB
	7bOpCmMsPsL+ZUVYfghVBG3bPN2DNxph/ztgIlWrFBGsIwxG9B46YR8FpllQBLB5
	SItUgaNSZxWyJaRNA2aZNV1YjtCiyR0AptYSDVJxtDq/mF6eWjMHnfGnpH1zy0QI
	HapBmgGKZJnALuaBeabdkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750884370; x=
	1750970770; bh=smnrFKiUQf0vR+IQX4MMZ/DMtVkDodX+DHYGu1XEt80=; b=J
	MJDxPEWDEiNxgT1I8rStlLQkpT9O4qFGUip/HYuq+Yd4sBKX6tKlVmbcWLMplYbx
	/nUW++q6rsGVP0uZDJp8z14XURXJC7nyWE8+xuFa5N0/fHnEWnExPN3uzk22KP6t
	4HFupA5Hsr0eSP7bDkhmwbz1bnLS99uC5fyudBJj5v322HkDtzgXiz2KQFHzIlA6
	hfKayKW1VWQh/arEooCrtgKo68sKez0KLrBW/maEf8rBYV+V/KFwaJz71kcBLhTt
	WwWCwqJiG2v1OpBfUJjRQHtMsUoid1LXDFUHbD7QuKYZkwCBM0RBKNJOouBME2Zn
	0dQNM5WjWYdzEs82v9w4Q==
X-ME-Sender: <xms:EmBcaJaouHZNRsh8bG_PaqjPAQGqKBQf2fdxGydCHHYo6RIVdrPyig>
    <xme:EmBcaAaoVDov5LI5yhViMJgzd0XkvaDUt2YIzm-petFR2tGvRg_2cDgpK2LID2bv1
    BUGHl3-V8BZ6RvfVDc>
X-ME-Received: <xmr:EmBcaL9G6fU6MZr_sGWxzL0lHfzMPRrO0ieEoHc_ZmKDmYZUtTtf5bveSBlaaVmX9uSEcyE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvfeejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeduke
    evhfegvedvveeihedvvdeghfeglefgudegfeetvdekiefgledtheeggefhgfenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehgnhhorggtkhesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:EmBcaHol2mgS7HjCEULP5EDN393VE88ZI-IFV-vGic_42CH08OiVrQ>
    <xmx:EmBcaEpVSTdRCnmkA_jrmbm165Jm5fzbVYbMcHzvyY7TuWINpoTAJw>
    <xmx:EmBcaNRo-LlyWFV9ZuO_IkMWH7rZwlUr0ICbJ1MTWExVVXPAjDuxMg>
    <xmx:EmBcaMqrAEs1YtZ4GIdytDKZGvZcMK4qnZdded_8Fo4yHRt4y0BWMA>
    <xmx:EmBcaI39isPuOJAxazQbHN9x3C1X7OSLs8Vh_kmDEwUuWgbyrm3rtfnz>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 16:46:09 -0400 (EDT)
Message-ID: <f7e3d874-6088-4f70-8222-c4a8547d213e@maowtm.org>
Date: Wed, 25 Jun 2025 21:46:08 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/landlock: Add tests for access through
 disconnected paths
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <09b24128f86973a6022e6aa8338945fcfb9a33e4.1749925391.git.m@maowtm.org>
 <20250619.yohT8thouf5J@digikod.net>
 <973a4725-4744-43ba-89aa-e9c39dce4d96@maowtm.org>
 <20250623.kaed2Ovei8ah@digikod.net>
 <351dd18f-5c17-4477-a9b9-23075e8722fa@maowtm.org>
 <20250625.Eem6reiGhiek@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20250625.Eem6reiGhiek@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/25/25 15:52, Mickaël Salaün wrote:
> On Tue, Jun 24, 2025 at 12:16:55AM +0100, Tingmao Wang wrote:
>> [..]
> 
> Let's say we initially have this hierarchy:
> 
> root
> ├── s1d1
> │   └── s1d2 [REFER]
> │       └── s1d3
> │           └── s1d4
> │               └── f1
> ├── s2d1 [bind mount of s1d1]
> │   └── s1d2 [REFER]
> │       └── s1d3
> │           └── s1d4
> │               └── f1
> └── s3d1 [REFER]
> 
> s1d3 has s1d2 as parent with the REFER right.
> 
> We open [fd:s1d4].
> 
> Now, s1d1/s1d2/s1d3 is moved to s3d1/s1d3, which makes [fd:s1d4]/..
> disconnected:
> 
> root
> ├── s1d1
> │   └── s1d2 [REFER]
> ├── s2d1 [bind mount of s1d1]
> │   └── s1d2 [REFER]
> └── s3d1 [REFER]
>     └── s1d3 [moved from s1d2]
>         └── s1d4
>             └── f1
> 
> Now, s1d3 has s3d1 as parent with the REFER right.
> 
> Moving [fd:s1d4]/f1 to s2d1/s1d2/f1 would be deny by Landlock

Maybe I'm misunderstanding your description, but this seems to work for
me?

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index d8f9259fffe4..5e550e6da49c 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -5201,6 +5201,72 @@ TEST_F_FORK(layout1_bind, path_disconnected_link)
 	}
 }
 
+FIXTURE(layout_disconnected_special){};
+FIXTURE_SETUP(layout_disconnected_special)
+{
+	prepare_layout(_metadata);
+
+	create_file(_metadata, TMP_DIR "/s1d1/s1d2/s1d3/s1d4/f1");
+	create_directory(_metadata, TMP_DIR "/s2d1");
+	create_directory(_metadata, TMP_DIR "/s3d1");
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0,
+		  mount(TMP_DIR "/s1d1", TMP_DIR "/s2d1", NULL, MS_BIND, NULL));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+FIXTURE_TEARDOWN_PARENT(layout_disconnected_special)
+{
+	/* umount(TMP_DIR "/s2d1") is handled by namespace lifetime. */
+
+	remove_path(TMP_DIR "/s1d1/s1d2/s1d3/s1d4/f1");
+
+	cleanup_layout(_metadata);
+}
+
+TEST_F_FORK(layout_disconnected_special, disconnected_special)
+{
+	const __u64 access =
+		LANDLOCK_ACCESS_FS_REFER | LANDLOCK_ACCESS_FS_MAKE_REG |
+		LANDLOCK_ACCESS_FS_REMOVE_FILE | LANDLOCK_ACCESS_FS_READ_FILE;
+	const struct rule rules[] = {
+		{
+			.path = TMP_DIR "/s1d1/s1d2",
+			.access = access,
+		},
+		{
+			.path = TMP_DIR "/s3d1",
+			.access = access,
+		},
+		{},
+	};
+	int s1d4_bind_fd, ruleset_fd;
+
+	s1d4_bind_fd = open(TMP_DIR "/s2d1/s1d2/s1d3/s1d4", O_PATH | O_CLOEXEC);
+	EXPECT_LE(0, s1d4_bind_fd);
+
+	ruleset_fd = create_ruleset(_metadata, access, rules);
+	ASSERT_LE(0, ruleset_fd);
+
+	/* Make it disconnected. */
+	EXPECT_EQ(0, renameat(AT_FDCWD, TMP_DIR "/s1d1/s1d2/s1d3", AT_FDCWD,
+			      TMP_DIR "/s3d1/s1d3"));
+
+	/* Check it's disconnected. */
+	ASSERT_EQ(ENOENT, test_open_rel(s1d4_bind_fd, "..", O_DIRECTORY));
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	EXPECT_EQ(0, renameat(s1d4_bind_fd, "f1", AT_FDCWD,
+			      TMP_DIR "/s2d1/s1d2/f1"));
+	EXPECT_EQ(0, test_open(TMP_DIR "/s2d1/s1d2/f1", O_RDONLY));
+	EXPECT_EQ(0, renameat(AT_FDCWD, TMP_DIR "/s2d1/s1d2/f1", s1d4_bind_fd,
+			      "f1"));
+	EXPECT_EQ(0, test_open(TMP_DIR "/s3d1/s1d3/s1d4/f1", O_RDONLY));
+}
+
 #define LOWER_BASE TMP_DIR "/lower"
 #define LOWER_DATA LOWER_BASE "/data"
 static const char lower_fl1[] = LOWER_DATA "/fl1";

Output:

	root@5610c72ba8a0 /t/landlock# cp /linux/tools/testing/selftests/landlock/ /tmp -r
	root@5610c72ba8a0 /t/landlock# ./fs_test -t disconnected_special
	TAP version 13
	1..1
	# Starting 1 tests from 1 test cases.
	#  RUN           layout_disconnected_special.disconnected_special ...
	#            OK  layout_disconnected_special.disconnected_special
	ok 1 layout_disconnected_special.disconnected_special
	# PASSED: 1 / 1 tests passed.
	# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

(I think this is similar to an existing test case, but if you think it's
worth having, feel free to add it to the commit (maybe it needs a better
name than disconnected_special))

I tested this manually initially which would have been on virtiofs instead
of tmpfs, and the behaviour is the same - rename was allowed.

> whereas
> the source and destination had and still have REFER in their
> hierarchies.  This is because s3d1 and s1d2 are evaluated for
> [fd:s1d4]/f1.  We could have a similar scenario for the destination and
> for both.
> 
> [...]
>> An interesting concrete example I came up with:
>>
>> /# uname -a
>> Linux 5610c72ba8a0 6.16.0-rc2-dev #43 SMP ...
>> /# mkdir /a /b
>> /# mkdir /a/a1 /b/b1
>> /# mount -t tmpfs none /a/a1
>> /# mkdir /a/a1/a11
>> /# mount --bind /a/a1/a11 /b/b1
>> /# mkdir /a/a1/a11/a111
>> /# tree /a /b
>> /a
>> `-- a1
>>     `-- a11
>>         `-- a111
>> /b
>> `-- b1
>>     `-- a111
>>
>> 7 directories, 0 files
>> /# cd /b/b1/a111/
>> /b/b1/a111# mv /a/a1/a11/a111 /a/a1/a12
>> /b/b1/a111# ls ..  # we're disconnected now
>> ls: cannot access '..': No such file or directory
>> /b/b1/a111 [2]# touch /a/a1/a12/file
>>
>> /b/b1/a111# LL_FS_RO=/:/a/a1 LL_FS_RW=/:/b/b1  /sandboxer ls
>> Executing the sandboxed command...
>> file
>>
>> /b/b1/a111# LL_FS_RO=/:/a/a1 LL_FS_RW=/:/b/b1  /sandboxer mv -v file file2
>> Executing the sandboxed command...
>> mv: cannot move 'file' to 'file2': Permission denied
>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> # This fails because for same dir rename we just use is_access_to_path_allowed,
>> # which will stop at /a/a1 (and thus never reach either /b/b1 or /).
> 
> Good example, and this rename should probably be allowed because the
> root directory allows REFER.

Well, it is disallowed for the same reason why a read to [disconnected
cwd]/file would be disallowed, even if root has an allow everything rule -
landlock never gets to the root because this is on a separate filesystem,
and so if the path is disconnected it can't get out of it.

> 
>>
>> /b/b1/a111 [1]# mkdir subdir
>> /b/b1/a111# LL_FS_RO=/:/a/a1 LL_FS_RW=/b/b1  /sandboxer mv -v file subdir/file2
>> Executing the sandboxed command...
>> [..] WARNING: CPU: 1 PID: 656 at security/landlock/fs.c:1065 ...
>> renamed 'file' -> 'subdir/file2'
>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> # This works because now we restart walk from /b/b1 (the bind mnt)
>>
>> /b/b1/a111# mv subdir/file2 file
>> /b/b1/a111# LL_FS_RO=/:/a/a1 LL_FS_RW=/a  /sandboxer mv -v file subdir/file2
>> Executing the sandboxed command...
>> mv: cannot move 'file' to 'subdir/file2': Permission denied
>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> # This is also not allowed, but that's OK since even though technically we're
>> # actually moving /a/a1/a12/file to /a/a1/a12/subdir/file2, we're not doing it
>> # through /a (we're walking into a12 via /b/b1, so rules on /a shouldn't
>> # apply anyway)
> 
> Yes
> 
>>
>> /b/b1/a111 [1]# LL_FS_RO=/:/a/a1 LL_FS_RW=/b  /sandboxer mv -v file subdir/file2
>> Executing the sandboxed command...
>> renamed 'file' -> 'subdir/file2'
>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> # And this works because we walk from /b/b1 after doing collect_domain_accesses
>>
>> I think overall this is just a very strange edge case and people should
>> not rely on the exact behavior whether it's intentional or optimization
>> side-effect (as long as it deny access / renames when there is no rules at
>> any of the reasonable upper directories).  Also, since as far as I can
>> tell this "optimization" only accidentally allows more access (i.e.  rules
>> anywhere between the bind mountpoint to real root would apply, even if
>> technically the now disconnected directory belongs outside of the
>> mountpoint), I think it might be fine to leave it as-is, rather than
>> potentially complicating this code to deal with this quite unusual edge
>> case?  (I mean, it's not exactly obvious to me whether it is more correct
>> to respect rules placed between the original bind mountpoint and root, or
>> more correct to ignore these rules (i.e. the behaviour of non-refer access
>> checks))
> 
> I kind of agree, overall it's not really a security issue (if we
> consider the origin of files), but it may still be inconsistent for
> users in rare cases.  Anyway, even if we don't want it, users could rely
> on this edge case (cf. Hyrum's law).
> 
>>
>> It is a bit weird that `mv -v file file2` and `mv -v file subdir/file2`
>> behaves differently tho.
> 
> Yes, `mv file file2` doesn't depends on REFER because it cannot impact a
> Landlock security policy.  This behavior is a bit weird without kernel
> and Landlock knowledge though.
> 
>>
>> If you would like to fix it, what do you think about my initial idea?:
>>> This might need more thinking, but maybe if one of the operands is
>>> disconnected, we can just let it walk until IS_ROOT(dentry), and also
>>> collect access for the other path until IS_ROOT(dentry), then call
> 
> Until then, it would be unchanged, right?

Sorry, I'm not fully clear on what you meant by "until then", and what
would be unchanged, but on second thought I think this proposal is
problematic as it would mean that we won't follow_up on mountpoints even
for the other connected path (as collect_domain_accesses does not do
that).

> 
>>> is_access_to_paths_allowed() passing in the root dentry we walked to?  (In
>>> this case is_access_to_paths_allowed will not do any walking and just make
>>> an access decision.)
> 
> Are you suggesting to not evaluate mnt_dir for disconnected paths?  What
> about the case where both the source and the destination are
> disconnected?

Yes basically, but I think my proposal was problematic.

> 
>>
>> This will basically make the refer checks behave the same as non-refer
>> checks on disconnected paths - walk until IS_ROOT, and stop there.
> 
> I think it would make more sense indeed.

It would make sense if both sides are disconnected, but not if just one
side is.  In that case we still want to walk the other connected path
normally.


