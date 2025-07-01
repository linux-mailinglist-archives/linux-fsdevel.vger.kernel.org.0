Return-Path: <linux-fsdevel+bounces-53583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0504DAF0439
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 21:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F564817A0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 19:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0267E284694;
	Tue,  1 Jul 2025 19:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="e03RjFXS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407AB15AF6
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751399953; cv=none; b=BLFeAW0wcAn5Y0f5Y6aSh5sTyVOpnS92AEA2yAPrwlgYR7REwM0/gUSSHLGCIiK7f4SU1qmic3yhEM9FXZDboHEnsOa4VHX3PlEaUDjk8BME/YXhmbOO/rDOQL0AENdv1+1/DogJe+3KXMoHQjUO2sUuEhmfw5FNNwKjENCQUCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751399953; c=relaxed/simple;
	bh=jixDHmDvR8U0dDT83hiZ8WniBwlKfoXeKBdMOX+1UdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agS1LbVTDmbsbYRKKQdU982EQ9UWR5J8pZtaclPDYlgj66y7Tfoy/2BagLyuy0JpW2kThQWwim6EKyoKuPxTyzLGCv/ARWrXKO6eOJiPtO6wOW2MrOMLHscpFaGCZO+ZEDONAP6pT01B1hHMHjwFeZXhOlUZlPaqD2xefdRfkqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=e03RjFXS; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bWv490Z8hzy2K;
	Tue,  1 Jul 2025 21:59:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1751399944;
	bh=bPeGEVrLy0aMuCa5BmrPge0uARt7r1vTwdNVrTjoZd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e03RjFXSweLX3mJqJHNHZ2CVeVLM0/Q4MrPJ5/K0RtPzO9YS5l0xkVcny7BtICPZy
	 5EGfKIqf6oEvzgvxPecyl0GAPvcNk1CO5el//3K4iz6dpPV6ANBJqZfp1bAm2+N6vo
	 ypS1+JVcuvtg7U2GZcFDLrrjgGihMenHTChSy1kU=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bWv483pv9zwt7;
	Tue,  1 Jul 2025 21:59:04 +0200 (CEST)
Date: Tue, 1 Jul 2025 21:59:01 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] selftests/landlock: Add tests for access through
 disconnected paths
Message-ID: <20250701.gieSee6cieZ5@digikod.net>
References: <09b24128f86973a6022e6aa8338945fcfb9a33e4.1749925391.git.m@maowtm.org>
 <20250619.yohT8thouf5J@digikod.net>
 <973a4725-4744-43ba-89aa-e9c39dce4d96@maowtm.org>
 <20250623.kaed2Ovei8ah@digikod.net>
 <351dd18f-5c17-4477-a9b9-23075e8722fa@maowtm.org>
 <20250625.Eem6reiGhiek@digikod.net>
 <f7e3d874-6088-4f70-8222-c4a8547d213e@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7e3d874-6088-4f70-8222-c4a8547d213e@maowtm.org>
X-Infomaniak-Routing: alpha

On Wed, Jun 25, 2025 at 09:46:08PM +0100, Tingmao Wang wrote:
> On 6/25/25 15:52, Mickaël Salaün wrote:
> > On Tue, Jun 24, 2025 at 12:16:55AM +0100, Tingmao Wang wrote:
> >> [..]
> > 
> > Let's say we initially have this hierarchy:
> > 
> > root
> > ├── s1d1
> > │   └── s1d2 [REFER]
> > │       └── s1d3
> > │           └── s1d4
> > │               └── f1
> > ├── s2d1 [bind mount of s1d1]
> > │   └── s1d2 [REFER]
> > │       └── s1d3
> > │           └── s1d4
> > │               └── f1
> > └── s3d1 [REFER]
> > 
> > s1d3 has s1d2 as parent with the REFER right.
> > 
> > We open [fd:s1d4].
> > 
> > Now, s1d1/s1d2/s1d3 is moved to s3d1/s1d3, which makes [fd:s1d4]/..
> > disconnected:
> > 
> > root
> > ├── s1d1
> > │   └── s1d2 [REFER]
> > ├── s2d1 [bind mount of s1d1]
> > │   └── s1d2 [REFER]
> > └── s3d1 [REFER]
> >     └── s1d3 [moved from s1d2]
> >         └── s1d4
> >             └── f1
> > 
> > Now, s1d3 has s3d1 as parent with the REFER right.
> > 
> > Moving [fd:s1d4]/f1 to s2d1/s1d2/f1 would be deny by Landlock
> 
> Maybe I'm misunderstanding your description, but this seems to work for
> me?

You're right, this is a wrong example.

> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index d8f9259fffe4..5e550e6da49c 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -5201,6 +5201,72 @@ TEST_F_FORK(layout1_bind, path_disconnected_link)
>  	}
>  }
>  
> +FIXTURE(layout_disconnected_special){};
> +FIXTURE_SETUP(layout_disconnected_special)
> +{
> +	prepare_layout(_metadata);
> +
> +	create_file(_metadata, TMP_DIR "/s1d1/s1d2/s1d3/s1d4/f1");
> +	create_directory(_metadata, TMP_DIR "/s2d1");
> +	create_directory(_metadata, TMP_DIR "/s3d1");
> +
> +	set_cap(_metadata, CAP_SYS_ADMIN);
> +	ASSERT_EQ(0,
> +		  mount(TMP_DIR "/s1d1", TMP_DIR "/s2d1", NULL, MS_BIND, NULL));
> +	clear_cap(_metadata, CAP_SYS_ADMIN);
> +}
> +
> +FIXTURE_TEARDOWN_PARENT(layout_disconnected_special)
> +{
> +	/* umount(TMP_DIR "/s2d1") is handled by namespace lifetime. */
> +
> +	remove_path(TMP_DIR "/s1d1/s1d2/s1d3/s1d4/f1");
> +
> +	cleanup_layout(_metadata);
> +}
> +
> +TEST_F_FORK(layout_disconnected_special, disconnected_special)
> +{
> +	const __u64 access =
> +		LANDLOCK_ACCESS_FS_REFER | LANDLOCK_ACCESS_FS_MAKE_REG |
> +		LANDLOCK_ACCESS_FS_REMOVE_FILE | LANDLOCK_ACCESS_FS_READ_FILE;
> +	const struct rule rules[] = {
> +		{
> +			.path = TMP_DIR "/s1d1/s1d2",
> +			.access = access,
> +		},
> +		{
> +			.path = TMP_DIR "/s3d1",
> +			.access = access,
> +		},
> +		{},
> +	};
> +	int s1d4_bind_fd, ruleset_fd;
> +
> +	s1d4_bind_fd = open(TMP_DIR "/s2d1/s1d2/s1d3/s1d4", O_PATH | O_CLOEXEC);
> +	EXPECT_LE(0, s1d4_bind_fd);
> +
> +	ruleset_fd = create_ruleset(_metadata, access, rules);
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	/* Make it disconnected. */
> +	EXPECT_EQ(0, renameat(AT_FDCWD, TMP_DIR "/s1d1/s1d2/s1d3", AT_FDCWD,
> +			      TMP_DIR "/s3d1/s1d3"));
> +
> +	/* Check it's disconnected. */
> +	ASSERT_EQ(ENOENT, test_open_rel(s1d4_bind_fd, "..", O_DIRECTORY));
> +
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	EXPECT_EQ(0, close(ruleset_fd));
> +
> +	EXPECT_EQ(0, renameat(s1d4_bind_fd, "f1", AT_FDCWD,
> +			      TMP_DIR "/s2d1/s1d2/f1"));
> +	EXPECT_EQ(0, test_open(TMP_DIR "/s2d1/s1d2/f1", O_RDONLY));
> +	EXPECT_EQ(0, renameat(AT_FDCWD, TMP_DIR "/s2d1/s1d2/f1", s1d4_bind_fd,
> +			      "f1"));
> +	EXPECT_EQ(0, test_open(TMP_DIR "/s3d1/s1d3/s1d4/f1", O_RDONLY));
> +}
> +
>  #define LOWER_BASE TMP_DIR "/lower"
>  #define LOWER_DATA LOWER_BASE "/data"
>  static const char lower_fl1[] = LOWER_DATA "/fl1";
> 
> Output:
> 
> 	root@5610c72ba8a0 /t/landlock# cp /linux/tools/testing/selftests/landlock/ /tmp -r
> 	root@5610c72ba8a0 /t/landlock# ./fs_test -t disconnected_special
> 	TAP version 13
> 	1..1
> 	# Starting 1 tests from 1 test cases.
> 	#  RUN           layout_disconnected_special.disconnected_special ...
> 	#            OK  layout_disconnected_special.disconnected_special
> 	ok 1 layout_disconnected_special.disconnected_special
> 	# PASSED: 1 / 1 tests passed.
> 	# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> (I think this is similar to an existing test case, but if you think it's
> worth having, feel free to add it to the commit (maybe it needs a better
> name than disconnected_special))
> 
> I tested this manually initially which would have been on virtiofs instead
> of tmpfs, and the behaviour is the same - rename was allowed.
> 
> > whereas
> > the source and destination had and still have REFER in their
> > hierarchies.  This is because s3d1 and s1d2 are evaluated for
> > [fd:s1d4]/f1.  We could have a similar scenario for the destination and
> > for both.
> > 
> > [...]
> >> An interesting concrete example I came up with:
> >>
> >> /# uname -a
> >> Linux 5610c72ba8a0 6.16.0-rc2-dev #43 SMP ...
> >> /# mkdir /a /b
> >> /# mkdir /a/a1 /b/b1
> >> /# mount -t tmpfs none /a/a1
> >> /# mkdir /a/a1/a11
> >> /# mount --bind /a/a1/a11 /b/b1
> >> /# mkdir /a/a1/a11/a111
> >> /# tree /a /b
> >> /a
> >> `-- a1
> >>     `-- a11
> >>         `-- a111
> >> /b
> >> `-- b1
> >>     `-- a111
> >>
> >> 7 directories, 0 files
> >> /# cd /b/b1/a111/
> >> /b/b1/a111# mv /a/a1/a11/a111 /a/a1/a12
> >> /b/b1/a111# ls ..  # we're disconnected now
> >> ls: cannot access '..': No such file or directory
> >> /b/b1/a111 [2]# touch /a/a1/a12/file
> >>
> >> /b/b1/a111# LL_FS_RO=/:/a/a1 LL_FS_RW=/:/b/b1  /sandboxer ls
> >> Executing the sandboxed command...
> >> file
> >>
> >> /b/b1/a111# LL_FS_RO=/:/a/a1 LL_FS_RW=/:/b/b1  /sandboxer mv -v file file2
> >> Executing the sandboxed command...
> >> mv: cannot move 'file' to 'file2': Permission denied
> >> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >> # This fails because for same dir rename we just use is_access_to_path_allowed,
> >> # which will stop at /a/a1 (and thus never reach either /b/b1 or /).
> > 
> > Good example, and this rename should probably be allowed because the
> > root directory allows REFER.
> 
> Well, it is disallowed for the same reason why a read to [disconnected
> cwd]/file would be disallowed, even if root has an allow everything rule -
> landlock never gets to the root because this is on a separate filesystem,
> and so if the path is disconnected it can't get out of it.
> 
> > 
> >>
> >> /b/b1/a111 [1]# mkdir subdir
> >> /b/b1/a111# LL_FS_RO=/:/a/a1 LL_FS_RW=/b/b1  /sandboxer mv -v file subdir/file2
> >> Executing the sandboxed command...
> >> [..] WARNING: CPU: 1 PID: 656 at security/landlock/fs.c:1065 ...
> >> renamed 'file' -> 'subdir/file2'
> >> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >> # This works because now we restart walk from /b/b1 (the bind mnt)
> >>
> >> /b/b1/a111# mv subdir/file2 file
> >> /b/b1/a111# LL_FS_RO=/:/a/a1 LL_FS_RW=/a  /sandboxer mv -v file subdir/file2
> >> Executing the sandboxed command...
> >> mv: cannot move 'file' to 'subdir/file2': Permission denied
> >> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >> # This is also not allowed, but that's OK since even though technically we're
> >> # actually moving /a/a1/a12/file to /a/a1/a12/subdir/file2, we're not doing it
> >> # through /a (we're walking into a12 via /b/b1, so rules on /a shouldn't
> >> # apply anyway)
> > 
> > Yes
> > 
> >>
> >> /b/b1/a111 [1]# LL_FS_RO=/:/a/a1 LL_FS_RW=/b  /sandboxer mv -v file subdir/file2
> >> Executing the sandboxed command...
> >> renamed 'file' -> 'subdir/file2'
> >> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >> # And this works because we walk from /b/b1 after doing collect_domain_accesses
> >>
> >> I think overall this is just a very strange edge case and people should
> >> not rely on the exact behavior whether it's intentional or optimization
> >> side-effect (as long as it deny access / renames when there is no rules at
> >> any of the reasonable upper directories).  Also, since as far as I can
> >> tell this "optimization" only accidentally allows more access (i.e.  rules
> >> anywhere between the bind mountpoint to real root would apply, even if
> >> technically the now disconnected directory belongs outside of the
> >> mountpoint), I think it might be fine to leave it as-is, rather than
> >> potentially complicating this code to deal with this quite unusual edge
> >> case?  (I mean, it's not exactly obvious to me whether it is more correct
> >> to respect rules placed between the original bind mountpoint and root, or
> >> more correct to ignore these rules (i.e. the behaviour of non-refer access
> >> checks))
> > 
> > I kind of agree, overall it's not really a security issue (if we
> > consider the origin of files), but it may still be inconsistent for
> > users in rare cases.  Anyway, even if we don't want it, users could rely
> > on this edge case (cf. Hyrum's law).
> > 
> >>
> >> It is a bit weird that `mv -v file file2` and `mv -v file subdir/file2`
> >> behaves differently tho.
> > 
> > Yes, `mv file file2` doesn't depends on REFER because it cannot impact a
> > Landlock security policy.  This behavior is a bit weird without kernel
> > and Landlock knowledge though.
> > 
> >>
> >> If you would like to fix it, what do you think about my initial idea?:
> >>> This might need more thinking, but maybe if one of the operands is
> >>> disconnected, we can just let it walk until IS_ROOT(dentry), and also
> >>> collect access for the other path until IS_ROOT(dentry), then call
> > 
> > Until then, it would be unchanged, right?
> 
> Sorry, I'm not fully clear on what you meant by "until then", and what
> would be unchanged, but on second thought I think this proposal is
> problematic as it would mean that we won't follow_up on mountpoints even
> for the other connected path (as collect_domain_accesses does not do
> that).
> 
> > 
> >>> is_access_to_paths_allowed() passing in the root dentry we walked to?  (In
> >>> this case is_access_to_paths_allowed will not do any walking and just make
> >>> an access decision.)
> > 
> > Are you suggesting to not evaluate mnt_dir for disconnected paths?  What
> > about the case where both the source and the destination are
> > disconnected?
> 
> Yes basically, but I think my proposal was problematic.
> 
> > 
> >>
> >> This will basically make the refer checks behave the same as non-refer
> >> checks on disconnected paths - walk until IS_ROOT, and stop there.
> > 
> > I think it would make more sense indeed.
> 
> It would make sense if both sides are disconnected, but not if just one
> side is.  In that case we still want to walk the other connected path
> normally.

This discussion made me think about different edge cases and I sent a
proposal for a fix with tests that should cover all the cases we talked
about here:
https://lore.kernel.org/all/20250701183812.3201231-1-mic@digikod.net/

