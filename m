Return-Path: <linux-fsdevel+bounces-52918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA820AE871B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 16:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E0218929F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 14:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5299E209F38;
	Wed, 25 Jun 2025 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="FtLwaDpX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFB51D6193
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750863139; cv=none; b=Z5aaMeXJpwF61y44dYgRI5tpGBPbEzc/x6y7FJA3Yf0QVWA813zf9yYUNWJ2wTXvKHWxyOcwboJ0fhyfropb272BKtpPgboeC/MWcRhY210vsxzIvC/v9eZtxjRJW+MJ1feKm5ucPuQiLwpv1xwrVpj1M1MWkB2Ii5mxSMlWWvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750863139; c=relaxed/simple;
	bh=yjNan0dy3EQMe/4u3qOVb1/24GneEAGxaTkTZGJAb3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvgv5Q8iGBY5Dd+fql+bpj0k5OydjsH0dVlR992/j2Txd/6fhiK9iWgo55EDLqbPpAdJPyo+zuGF09M7qSq2JxbqpFfa5wV0XR+bZrqTf/n4TK7how4KfcoUShQqMKFTF7oDQmC6jdKGIrGEbOnM7rhP3i8Ai+ekXZthwsEVD1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=FtLwaDpX; arc=none smtp.client-ip=83.166.143.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bS4Xk5gXXzkl0;
	Wed, 25 Jun 2025 16:52:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1750863126;
	bh=qh5+3amT4dT5YgTv4rVxHX3iiB9H0OSzWb0SMX6Ee58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FtLwaDpXrRvQyn5du0h082afPul1oEjQOu6yRF1mjXRm9haj2PjXnX/aiLI5dW8jQ
	 NbauExTY/vXtrdjVkWGkUyWkQQWvjmK7DLKBFHJ4tr2/aqZRalZDSR4rQ+K3VvTyh2
	 X8xYfDGOTKWrRux9LnvGqkAjI+VyktdYi6DLzOdI=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bS4Xk1krczxZy;
	Wed, 25 Jun 2025 16:52:06 +0200 (CEST)
Date: Wed, 25 Jun 2025 16:52:05 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] selftests/landlock: Add tests for access through
 disconnected paths
Message-ID: <20250625.Eem6reiGhiek@digikod.net>
References: <09b24128f86973a6022e6aa8338945fcfb9a33e4.1749925391.git.m@maowtm.org>
 <20250619.yohT8thouf5J@digikod.net>
 <973a4725-4744-43ba-89aa-e9c39dce4d96@maowtm.org>
 <20250623.kaed2Ovei8ah@digikod.net>
 <351dd18f-5c17-4477-a9b9-23075e8722fa@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <351dd18f-5c17-4477-a9b9-23075e8722fa@maowtm.org>
X-Infomaniak-Routing: alpha

On Tue, Jun 24, 2025 at 12:16:55AM +0100, Tingmao Wang wrote:
> On 6/23/25 20:40, Mickaël Salaün wrote:
> > On Sun, Jun 22, 2025 at 04:42:49PM +0100, Tingmao Wang wrote:
> >> On 6/19/25 12:38, Mickaël Salaün wrote:
> >>> On Sat, Jun 14, 2025 at 07:25:02PM +0100, Tingmao Wang wrote:
> >>>> [...]
> >>>>
> >>>> This might need more thinking, but maybe if one of the operands is
> >>>> disconnected, we can just let it walk until IS_ROOT(dentry), and also
> >>>> collect access for the other path until IS_ROOT(dentry), then call
> >>>> is_access_to_paths_allowed() passing in the root dentry we walked to?  (In
> >>>> this case is_access_to_paths_allowed will not do any walking and just make
> >>>> an access decision.)
> >>>
> >>> If one side is in a disconnected directory and not the other side, the
> >>> rename would be denied by the VFS,
> >>
> >> Not always, right? For example in the path_disconnected_rename test we did:
> > 
> > Correct, only the mount point matter.
> > 
> >>
> >> 5051.  ASSERT_EQ(0, renameat(bind_s1d3_fd, file2_name, AT_FDCWD, file1_s2d2))
> >>                              ^^^^^^^^^^^^^^^^^^^^^^^^  ^^^^^^^^^^^^^^^^^^^^
> >>                              Disconnected              Connected
> >>
> >> (and it also has the other way)
> >>
> >> So looks like as long as they are still reached from two fds with two
> >> paths that have the same mnt, it will be allowed.  It's just that when we
> >> do parent walk we end up missing the mount.  This also means that for this
> >> refer check, if after doing the two separate walks (with the disconnected
> >> side walking all the way to IS_ROOT), we then walk from mnt again, we
> >> would allow the rename if there is a rule on mnt (or its parents) allowing
> >> file creation and refers, even if the disconnected side technically now
> >> lives outside the file hierarchy under mnt and does not have a parent with
> >> a rule allowing file creation.
> >>
> >> (I'm not saying this is necessary wrong or needs fixing, but I think it's
> >> an interesting consequence of the current implementation.)
> > 
> > Hmm, that's indeed a very subtle side effect.  One issue with the
> > current implementation is that if a directory between the mount
> > point and the source has REFER, and another directory not part of the
> > source hierarchy but part of the disconnected directory's hierarchy has
> > REFER and no other directory has REFER, and either the source or the
> > destination hierarchy is disconnected between the mount point and the
> > directory with the REFER, then Landlock will still deny such
> > rename/link.  A directory with REFER initially between the mount point
> > and the disconnected directory would also be ignored.  There is also the
> > case where both the source and the destination are disconnected.
> 
> Sorry, I'm having trouble following this.  Can you maybe give a more
> specific example, perhaps with commands?

Let's say we initially have this hierarchy:

root
├── s1d1
│   └── s1d2 [REFER]
│       └── s1d3
│           └── s1d4
│               └── f1
├── s2d1 [bind mount of s1d1]
│   └── s1d2 [REFER]
│       └── s1d3
│           └── s1d4
│               └── f1
└── s3d1 [REFER]

s1d3 has s1d2 as parent with the REFER right.

We open [fd:s1d4].

Now, s1d1/s1d2/s1d3 is moved to s3d1/s1d3, which makes [fd:s1d4]/..
disconnected:

root
├── s1d1
│   └── s1d2 [REFER]
├── s2d1 [bind mount of s1d1]
│   └── s1d2 [REFER]
└── s3d1 [REFER]
    └── s1d3 [moved from s1d2]
        └── s1d4
            └── f1

Now, s1d3 has s3d1 as parent with the REFER right.

Moving [fd:s1d4]/f1 to s2d1/s1d2/f1 would be deny by Landlock whereas
the source and destination had and still have REFER in their
hierarchies.  This is because s3d1 and s1d2 are evaluated for
[fd:s1d4]/f1.  We could have a similar scenario for the destination and
for both.


> 
> By "mount point" do you mean the bind mount? If a path has became
> disconnected because the directory moved away from under the mountpoint,
> and is therefore not covered by any REFER (you said "either the source or
> the destination hierarchy is disconnected between the mount point and the
> directory with the REFER") wouldn't it make sense for the rename to be
> denied?

Yes if the new hierarchy (e.g. s3d1 in my example) doesn't have REFER.

> 
> > 
> > I didn't consider such cases with collect_domain_accesses().  I'm
> > wondering if this path walk gap should be fixed (instead of applying
> > https://lore.kernel.org/all/20250618134734.1673254-1-mic@digikod.net/ )
> > or not.  We should not rely on optimization side effects, but I'm not
> > sure which behavior would make more sense...  Any though?
> 
> I didn't quite understand your example above and how is it possible for us
> to end up denying something that should be allowed.  My understanding of
> the current implementation is, when either operands are disconnected, it
> will walk all the way to the current filesystem's root and stop there.
> However, it will then still do the walk from the original bind mount up to
> the real root (/), and if there is any REFER rules on that path, we will
> still allow the rename.  This means that if the rename still ends up being
> denied, then it wouldn't have been allowed in the first place, even if the
> path has not become disconnected.
> 
> An interesting concrete example I came up with:
> 
> /# uname -a
> Linux 5610c72ba8a0 6.16.0-rc2-dev #43 SMP ...
> /# mkdir /a /b
> /# mkdir /a/a1 /b/b1
> /# mount -t tmpfs none /a/a1
> /# mkdir /a/a1/a11
> /# mount --bind /a/a1/a11 /b/b1
> /# mkdir /a/a1/a11/a111
> /# tree /a /b
> /a
> `-- a1
>     `-- a11
>         `-- a111
> /b
> `-- b1
>     `-- a111
> 
> 7 directories, 0 files
> /# cd /b/b1/a111/
> /b/b1/a111# mv /a/a1/a11/a111 /a/a1/a12
> /b/b1/a111# ls ..  # we're disconnected now
> ls: cannot access '..': No such file or directory
> /b/b1/a111 [2]# touch /a/a1/a12/file
> 
> /b/b1/a111# LL_FS_RO=/:/a/a1 LL_FS_RW=/:/b/b1  /sandboxer ls
> Executing the sandboxed command...
> file
> 
> /b/b1/a111# LL_FS_RO=/:/a/a1 LL_FS_RW=/:/b/b1  /sandboxer mv -v file file2
> Executing the sandboxed command...
> mv: cannot move 'file' to 'file2': Permission denied
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> # This fails because for same dir rename we just use is_access_to_path_allowed,
> # which will stop at /a/a1 (and thus never reach either /b/b1 or /).

Good example, and this rename should probably be allowed because the
root directory allows REFER.

> 
> /b/b1/a111 [1]# mkdir subdir
> /b/b1/a111# LL_FS_RO=/:/a/a1 LL_FS_RW=/b/b1  /sandboxer mv -v file subdir/file2
> Executing the sandboxed command...
> [..] WARNING: CPU: 1 PID: 656 at security/landlock/fs.c:1065 ...
> renamed 'file' -> 'subdir/file2'
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> # This works because now we restart walk from /b/b1 (the bind mnt)
> 
> /b/b1/a111# mv subdir/file2 file
> /b/b1/a111# LL_FS_RO=/:/a/a1 LL_FS_RW=/a  /sandboxer mv -v file subdir/file2
> Executing the sandboxed command...
> mv: cannot move 'file' to 'subdir/file2': Permission denied
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> # This is also not allowed, but that's OK since even though technically we're
> # actually moving /a/a1/a12/file to /a/a1/a12/subdir/file2, we're not doing it
> # through /a (we're walking into a12 via /b/b1, so rules on /a shouldn't
> # apply anyway)

Yes

> 
> /b/b1/a111 [1]# LL_FS_RO=/:/a/a1 LL_FS_RW=/b  /sandboxer mv -v file subdir/file2
> Executing the sandboxed command...
> renamed 'file' -> 'subdir/file2'
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> # And this works because we walk from /b/b1 after doing collect_domain_accesses
> 
> I think overall this is just a very strange edge case and people should
> not rely on the exact behavior whether it's intentional or optimization
> side-effect (as long as it deny access / renames when there is no rules at
> any of the reasonable upper directories).  Also, since as far as I can
> tell this "optimization" only accidentally allows more access (i.e.  rules
> anywhere between the bind mountpoint to real root would apply, even if
> technically the now disconnected directory belongs outside of the
> mountpoint), I think it might be fine to leave it as-is, rather than
> potentially complicating this code to deal with this quite unusual edge
> case?  (I mean, it's not exactly obvious to me whether it is more correct
> to respect rules placed between the original bind mountpoint and root, or
> more correct to ignore these rules (i.e. the behaviour of non-refer access
> checks))

I kind of agree, overall it's not really a security issue (if we
consider the origin of files), but it may still be inconsistent for
users in rare cases.  Anyway, even if we don't want it, users could rely
on this edge case (cf. Hyrum's law).

> 
> It is a bit weird that `mv -v file file2` and `mv -v file subdir/file2`
> behaves differently tho.

Yes, `mv file file2` doesn't depends on REFER because it cannot impact a
Landlock security policy.  This behavior is a bit weird without kernel
and Landlock knowledge though.

> 
> If you would like to fix it, what do you think about my initial idea?:
> > This might need more thinking, but maybe if one of the operands is
> > disconnected, we can just let it walk until IS_ROOT(dentry), and also
> > collect access for the other path until IS_ROOT(dentry), then call

Until then, it would be unchanged, right?

> > is_access_to_paths_allowed() passing in the root dentry we walked to?  (In
> > this case is_access_to_paths_allowed will not do any walking and just make
> > an access decision.)

Are you suggesting to not evaluate mnt_dir for disconnected paths?  What
about the case where both the source and the destination are
disconnected?

> 
> This will basically make the refer checks behave the same as non-refer
> checks on disconnected paths - walk until IS_ROOT, and stop there.

I think it would make more sense indeed.

