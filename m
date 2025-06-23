Return-Path: <linux-fsdevel+bounces-52642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9AFAE4DB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 21:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35395178EDB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 19:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17322D4B53;
	Mon, 23 Jun 2025 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="PORuIXcj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E607819C554
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 19:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750707669; cv=none; b=PeNJhTrbENCXOJTDdsYgn8i9y6nugC2pzy75qJUcZxCylukS26Vf6fXZFjNcZl7pMOKvYwyHH/lWdYK3E3vmlqOa+cBRiRAB9ScvLFk+q355z1nIj5G3H7S0Jv5sdFiiLhESF2LEuzl3sOMBxtjuZ5y5xk5xuzOaouvHtd0BNjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750707669; c=relaxed/simple;
	bh=5NESCJ2C0k3c/bq33kaycObKMRXxkSk7OfchAPWb61A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxBLe6FY0Ikd7ZYO8pwmacm3hKwLxq4eo8sJW1e6vQlDeWfRpM8cEExSgjjH3PgL9we+9zVrR7UMeR9X3d4+/TJJYfTzNW3DiOFUYvFcpjwv9BZbxePZS4FTi2WkWFgkXjPnHfuZJLWIups3R2YabR+dfpoPfYArVtgGjJh7alY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=PORuIXcj; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bQz2v0xGhzXhX;
	Mon, 23 Jun 2025 21:40:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1750707655;
	bh=+PdntTwQutG2Ke93Rwxbf5el2guoygdYyJGMg5CRmPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PORuIXcj93tCuZWrSKna4Izi+Vp7SeJhJ0u6GjyPU20sD/+tVdOE2VbRQdriEWXkQ
	 /lA/oVMXn9blC/+uvXgZ39xJf4GwjxPfxArulpzK54SkuWUK/tY2iDN5wKnznCsyHW
	 lvZ5zHpDJp6Im27KI33e0japWfzhUH6u1e7V4vUM=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4bQz2t46DczLW;
	Mon, 23 Jun 2025 21:40:54 +0200 (CEST)
Date: Mon, 23 Jun 2025 21:40:53 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] selftests/landlock: Add tests for access through
 disconnected paths
Message-ID: <20250623.kaed2Ovei8ah@digikod.net>
References: <09b24128f86973a6022e6aa8338945fcfb9a33e4.1749925391.git.m@maowtm.org>
 <20250619.yohT8thouf5J@digikod.net>
 <973a4725-4744-43ba-89aa-e9c39dce4d96@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <973a4725-4744-43ba-89aa-e9c39dce4d96@maowtm.org>
X-Infomaniak-Routing: alpha

On Sun, Jun 22, 2025 at 04:42:49PM +0100, Tingmao Wang wrote:
> On 6/19/25 12:38, Mickaël Salaün wrote:
> > On Sat, Jun 14, 2025 at 07:25:02PM +0100, Tingmao Wang wrote:
> >> This adds a test for the edge case discussed in [1], and in addition also
> >> test rename operations when the operands are through disconnected paths,
> >> as that go through a separate code path in Landlock.
> >>
> >> [1]: https://lore.kernel.org/linux-security-module/027d5190-b37a-40a8-84e9-4ccbc352bcdf@maowtm.org/
> >>
> >> This has resulted in a WARNING, due to collect_domain_accesses() not
> >> expecting to reach a different root from path->mnt:
> >>
> >> 	#  RUN           layout1_bind.path_disconnected ...
> >> 	#            OK  layout1_bind.path_disconnected
> >> 	ok 96 layout1_bind.path_disconnected
> >> 	#  RUN           layout1_bind.path_disconnected_rename ...
> >> 	[..] ------------[ cut here ]------------
> >> 	[..] WARNING: CPU: 3 PID: 385 at security/landlock/fs.c:1065 collect_domain_accesses
> >> 	[..] ...
> >> 	[..] RIP: 0010:collect_domain_accesses (security/landlock/fs.c:1065 (discriminator 2) security/landlock/fs.c:1031 (discriminator 2))
> >> 	[..] current_check_refer_path (security/landlock/fs.c:1205)
> >> 	[..] ...
> >> 	[..] hook_path_rename (security/landlock/fs.c:1526)
> >> 	[..] security_path_rename (security/security.c:2026 (discriminator 1))
> >> 	[..] do_renameat2 (fs/namei.c:5264)
> >> 	#            OK  layout1_bind.path_disconnected_rename
> >> 	ok 97 layout1_bind.path_disconnected_rename
> > 
> > Good catch and thanks for the tests!  I sent a fix:
> > https://lore.kernel.org/all/20250618134734.1673254-1-mic@digikod.net/
> > 
> >>
> >> My understanding is that terminating at the mountpoint is basically an
> >> optimization, so that for rename operations we only walks the path from
> >> the mountpoint to the real root once.  We probably want to keep this
> >> optimization, as disconnected paths are probably a very rare edge case.
> > 
> > Rename operations can only happen within the same mount point, otherwise
> > the kernel returns -EXDEV.  The collect_domain_accesses() is called for
> > the source and the destination of a rename to walk to their common mount
> > point, if any.  We could maybe improve this walk by doing them at the
> > same time but because we don't know the depth of each path, I'm not sure
> > the required extra complexity would be worth it.  The current approach
> > is simple and opportunistically limits the walks.
> > 
> >>
> >> This might need more thinking, but maybe if one of the operands is
> >> disconnected, we can just let it walk until IS_ROOT(dentry), and also
> >> collect access for the other path until IS_ROOT(dentry), then call
> >> is_access_to_paths_allowed() passing in the root dentry we walked to?  (In
> >> this case is_access_to_paths_allowed will not do any walking and just make
> >> an access decision.)
> > 
> > If one side is in a disconnected directory and not the other side, the
> > rename would be denied by the VFS,
> 
> Not always, right? For example in the path_disconnected_rename test we did:

Correct, only the mount point matter.

> 
> 5051.  ASSERT_EQ(0, renameat(bind_s1d3_fd, file2_name, AT_FDCWD, file1_s2d2))
>                              ^^^^^^^^^^^^^^^^^^^^^^^^  ^^^^^^^^^^^^^^^^^^^^
>                              Disconnected              Connected
> 
> (and it also has the other way)
> 
> So looks like as long as they are still reached from two fds with two
> paths that have the same mnt, it will be allowed.  It's just that when we
> do parent walk we end up missing the mount.  This also means that for this
> refer check, if after doing the two separate walks (with the disconnected
> side walking all the way to IS_ROOT), we then walk from mnt again, we
> would allow the rename if there is a rule on mnt (or its parents) allowing
> file creation and refers, even if the disconnected side technically now
> lives outside the file hierarchy under mnt and does not have a parent with
> a rule allowing file creation.
> 
> (I'm not saying this is necessary wrong or needs fixing, but I think it's
> an interesting consequence of the current implementation.)

Hmm, that's indeed a very subtle side effect.  One issue with the
current implementation is that if a directory between the mount
point and the source has REFER, and another directory not part of the
source hierarchy but part of the disconnected directory's hierarchy has
REFER and no other directory has REFER, and either the source or the
destination hierarchy is disconnected between the mount point and the
directory with the REFER, then Landlock will still deny such
rename/link.  A directory with REFER initially between the mount point
and the disconnected directory would also be ignored.  There is also the
case where both the source and the destination are disconnected.

I didn't consider such cases with collect_domain_accesses().  I'm
wondering if this path walk gap should be fixed (instead of applying
https://lore.kernel.org/all/20250618134734.1673254-1-mic@digikod.net/ )
or not.  We should not rely on optimization side effects, but I'm not
sure which behavior would make more sense...  Any though?

> 
> > but Landlock should still log (and then deny) the side that would be
> > denied anyway.
> > 
> >>
> >> Letting the walk continue until IS_ROOT(dentry) is what
> >> is_access_to_paths_allowed() effectively does for non-renames.
> >>
A> >> (Also note: moving the const char definitions a bit above so that we can
> >> use the path for s4d1 in cleanup code.)
> >>
> >> Signed-off-by: Tingmao Wang <m@maowtm.org>
> > 
> > I squashed your patches and push them to my next branch with some minor
> > changes.  Please let me know if there is something wrong.
> 
> Thanks for the edits!  I did notice two things:
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index fa0f18ec62c4..c0a54dde7225 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -4561,6 +4561,17 @@ TEST_F_FORK(ioctl, handle_file_access_file)
>  FIXTURE(layout1_bind) {};
>  /* clang-format on */
>  
> +static const char bind_dir_s1d3[] = TMP_DIR "/s2d1/s2d2/s1d3";
> +static const char bind_file1_s1d3[] = TMP_DIR "/s2d1/s2d2/s1d3/f1";
> +/* Moved targets for disconnected path tests. */
>     ^^^^^^^^^^^^^
>     I had "Move targets" here as a noun (i.e. the target/destinations of
>     the renames)

Makes sense now :)

> 
> +static const char dir_s4d1[] = TMP_DIR "/s4d1";
> +static const char file1_s4d1[] = TMP_DIR "/s4d1/f1";
> ...
> 
> Also, I was just re-reading path_disconnected_rename and I managed to get
> confused (i.e. "how is the rename in the forked child allowed at all (i.e.
> how did we get EXDEV instead of EACCES) after applying layer 2?").  If you
> end up amending that commit, can you add this short note:
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index c0a54dde7225..84615c4bb7c0 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -4936,6 +4936,8 @@ TEST_F_FORK(layout1_bind, path_disconnected_rename)
>  		},
>  		{}
>  	};
> +
> +	/* This layer only handles LANDLOCK_ACCESS_FS_READ_FILE only. */

That can be useful.

>  	const struct rule layer2_only_s1d2[] = {
>  		{
>  			.path = dir_s1d2,
> 
> Wish I had caught this earlier.  I mean neither of the two things are
> hugely important, but I assume until you actually send the merge request
> you can amend stuff relatively easily?  If not then it's also alright :)

I apply your changes.  Commits should usually wait at least a week in
linux-next.

> 
> >
> > [...]
> 
> Ack to all suggestions, thanks!
> 
> Best,
> Tingmao
> 

