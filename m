Return-Path: <linux-fsdevel+bounces-59449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA031B38F6C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 01:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84FFF366975
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 23:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89EB30FC01;
	Wed, 27 Aug 2025 23:58:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B670A7260A;
	Wed, 27 Aug 2025 23:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756339100; cv=none; b=NVf95q7SiPbpiiEtOSlciN1Mlr5/FTRmy+cxGI6LuFR/u6MoD3WaQ4xcnsl6XOl00Z/m5zc9VNCji8KLHMQTrU2XjRF0mukZ4/qD0nNE4ZBIfT39/VO8q5gUWLTz6CjA+rucvOvwq7un0hgcvVAUmvQoj+zhRNPlKduVcJkF2JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756339100; c=relaxed/simple;
	bh=icCSIWUerQO1Zodn51IfYGAubDfiSnEpwxONW6kQCPg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=HRcol4NYMjeli338DkPTMFiWBU4F2TcqMfEykSrQEBUuV6tR7RjU3t4gXimenl8wLC0Zg1u4aQgZP9DqwmQpBPtFW0EdL0VgD2rowFu0COURfdCSSawbr/l7cnnYvdt7ZW/z4ipykTSO+R5qsR9S3U+3DZ3Qg4twkP7jvVnxKF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1urQ1k-007QC6-7P;
	Wed, 27 Aug 2025 23:58:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: =?utf-8?q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Theodore Tso" <tytso@mit.edu>,
 "Gabriel Krisman Bertazi" <krisman@kernel.org>, linux-unionfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 kernel-dev@igalia.com
Subject:
 Re: [PATCH v6 9/9] ovl: Support mounting case-insensitive enabled layers
In-reply-to:
 <CAOQ4uxj551a7cvjpcYEyTLtsEXw9OxHtTc-VSm170J5pWtwoUQ@mail.gmail.com>
References:
 <>, <CAOQ4uxj551a7cvjpcYEyTLtsEXw9OxHtTc-VSm170J5pWtwoUQ@mail.gmail.com>
Date: Thu, 28 Aug 2025 09:58:05 +1000
Message-id: <175633908557.2234665.14959580663322237611@noble.neil.brown.name>

On Thu, 28 Aug 2025, Amir Goldstein wrote:
> On Tue, Aug 26, 2025 at 9:01=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
> >
> >
> >
> > Em 26/08/2025 04:31, Amir Goldstein escreveu:
> > > On Mon, Aug 25, 2025 at 3:31=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid=
@igalia.com> wrote:
> > >>
> > >> Hi Amir,
> > >>
> > >> Em 22/08/2025 16:17, Amir Goldstein escreveu:
> > >>
> > >> [...]
> > >>
> > >>     /*
> > >>>>>> -        * Allow filesystems that are case-folding capable but den=
y composing
> > >>>>>> -        * ovl stack from case-folded directories.
> > >>>>>> +        * Exceptionally for layers with casefold, we accept that =
they have
> > >>>>>> +        * their own hash and compare operations
> > >>>>>>             */
> > >>>>>> -       if (sb_has_encoding(dentry->d_sb))
> > >>>>>> -               return IS_CASEFOLDED(d_inode(dentry));
> > >>>>>> +       if (ofs->casefold)
> > >>>>>> +               return false;
> > >>>>>
> > >>>>> I think this is better as:
> > >>>>>            if (sb_has_encoding(dentry->d_sb))
> > >>>>>                    return false;
> > >>>>>
> > >>>
> > >>> And this still fails the test "Casefold enabled" for me.
> > >>>
> > >>> Maybe you are confused because this does not look like
> > >>> a test failure. It looks like this:
> > >>>
> > >>> generic/999 5s ...  [19:10:21][  150.667994] overlayfs: failed lookup
> > >>> in lower (ovl-lower/casefold, name=3D'subdir', err=3D-116): parent wr=
ong
> > >>> casefold
> > >>> [  150.669741] overlayfs: failed lookup in lower (ovl-lower/casefold,
> > >>> name=3D'subdir', err=3D-116): parent wrong casefold
> > >>> [  150.760644] overlayfs: failed lookup in lower (/ovl-lower,
> > >>> name=3D'casefold', err=3D-66): child wrong casefold
> > >>>    [19:10:24] [not run]
> > >>> generic/999 -- overlayfs does not support casefold enabled layers
> > >>> Ran: generic/999
> > >>> Not run: generic/999
> > >>> Passed all 1 tests
> > >>>
> > >>
> > >> This is how the test output looks before my changes[1] to the test:
> > >>
> > >> $ ./run.sh
> > >> FSTYP         -- ext4
> > >> PLATFORM      -- Linux/x86_64 archlinux 6.17.0-rc1+ #1174 SMP
> > >> PREEMPT_DYNAMIC Mon Aug 25 10:18:09 -03 2025
> > >> MKFS_OPTIONS  -- -F /dev/vdc
> > >> MOUNT_OPTIONS -- -o acl,user_xattr /dev/vdc /tmp/dir2
> > >>
> > >> generic/999 1s ... [not run] overlayfs does not support casefold enabl=
ed
> > >> layers
> > >> Ran: generic/999
> > >> Not run: generic/999
> > >> Passed all 1 tests
> > >>
> > >>
> > >> And this is how it looks after my changes[1] to the test:
> > >>
> > >> $ ./run.sh
> > >> FSTYP         -- ext4
> > >> PLATFORM      -- Linux/x86_64 archlinux 6.17.0-rc1+ #1174 SMP
> > >> PREEMPT_DYNAMIC Mon Aug 25 10:18:09 -03 2025
> > >> MKFS_OPTIONS  -- -F /dev/vdc
> > >> MOUNT_OPTIONS -- -o acl,user_xattr /dev/vdc /tmp/dir2
> > >>
> > >> generic/999        1s
> > >> Ran: generic/999
> > >> Passed all 1 tests
> > >>
> > >> So, as far as I can tell, the casefold enabled is not being skipped
> > >> after the fix to the test.
> > >
> > > Is this how it looks with your v6 or after fixing the bug:
> > > https://lore.kernel.org/linux-unionfs/68a8c4d7.050a0220.37038e.005c.GAE=
@google.com/
> > >
> > > Because for me this skipping started after fixing this bug
> > > Maybe we fixed the bug incorrectly, but I did not see what the problem
> > > was from a quick look.
> > >
> > > Can you test with my branch:
> > > https://github.com/amir73il/linux/commits/ovl_casefold/
> > >
> >
> > Right, our branches have a different base, mine is older and based on
> > the tag vfs/vfs-6.18.mount.
> >
> > I have now tested with your branch, and indeed the test fails with
> > "overlayfs does not support casefold enabled". I did some debugging and
> > the missing commit from my branch that is making this difference here is
> > e8bd877fb76bb9f3 ("ovl: fix possible double unlink"). After reverting it
> > on top of your branch, the test works. I'm not sure yet why this
> > prevents the mount, but this is the call trace when the error happens:
>=20
> Wow, that is an interesting development race...
>=20
> >
> > TID/PID 860/860 (mount/mount):
> >
> >                      entry_SYSCALL_64_after_hwframe+0x77
> >                      do_syscall_64+0xa2
> >                      x64_sys_call+0x1bc3
> >                      __x64_sys_fsconfig+0x46c
> >                      vfs_cmd_create+0x60
> >                      vfs_get_tree+0x2e
> >                      ovl_get_tree+0x19
> >                      get_tree_nodev+0x70
> >                      ovl_fill_super+0x53b
> > !    0us [-EINVAL]  ovl_parent_lock
> >
> > And for the ovl_parent_lock() arguments, *parent=3D"work", *child=3D"#7".=
 So
> > right now I'm trying to figure out why the dentry for #7 is not hashed.
> >
>=20
> The reason is this:
>=20
> static struct dentry *ext4_lookup(...
> {
> ...
>         if (IS_ENABLED(CONFIG_UNICODE) && !inode && IS_CASEFOLDED(dir)) {
>                 /* Eventually we want to call d_add_ci(dentry, NULL)
>                  * for negative dentries in the encoding case as
>                  * well.  For now, prevent the negative dentry
>                  * from being cached.
>                  */
>                 return NULL;
>         }
>=20
>         return d_splice_alias(inode, dentry);
> }
>=20
> Neil,
>=20
> Apparently, the assumption that
> ovl_lookup_temp() =3D> ovl_lookup_upper() =3D> lookup_one()
> returns a hashed dentry is not always true.
>=20
> It may be always true for all the filesystems that are currently
> supported as an overlayfs
> upper layer fs (?), but it does not look like you can count on this
> for the wider vfs effort
> and we should try to come up with a solution for ovl_parent_lock()
> that will allow enabling
> casefolding on overlayfs layers.
>=20
> This patch seems to work. WDYT?
>=20
> Thanks,
> Amir.
>=20
> commit 5dfcd10378038637648f3f422e3d5097eb6faa5f
> Author: Amir Goldstein <amir73il@gmail.com>
> Date:   Wed Aug 27 19:55:26 2025 +0200
>=20
>     ovl: adapt ovl_parent_lock() to casefolded directories
>=20
>     e8bd877fb76bb9f3 ("ovl: fix possible double unlink") added a sanity
>     check of !d_unhashed(child) to try to verify that child dentry was not
>     unlinked while parent dir was unlocked.
>=20
>     This "was not unlink" check has a false positive result in the case of
>     casefolded parent dir, because in that case, ovl_create_temp() returns
>     an unhashed dentry.
>=20
>     Change the "was not unlinked" check to use cant_mount(child).
>     cant_mount(child) means that child was unlinked while we have been
>     holding a reference to child, so it could not have become negative.
>=20
>     This fixes the error in ovl_parent_lock() in ovl_check_rename_whiteout()
>     after ovl_create_temp() and allows mount of overlayfs with casefolding
>     enabled layers.
>=20
>     Reported-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
>     Link: https://lore.kernel.org/r/18704e8c-c734-43f3-bc7c-b8be345e1bf5@ig=
alia.com/
>     Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>=20
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index bec4a39d1b97c..bffbb59776720 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -1551,9 +1551,23 @@ void ovl_copyattr(struct inode *inode)
>=20
>  int ovl_parent_lock(struct dentry *parent, struct dentry *child)
>  {
> +       bool is_unlinked;
> +
>         inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
> -       if (!child ||
> -           (!d_unhashed(child) && child->d_parent =3D=3D parent))
> +       if (!child)
> +               return 0;
> +
> +       /*
> +        * After re-acquiring parent dir lock, verify that child was not mo=
ved
> +        * to another parent and that it was not unlinked. cant_mount() mea=
ns
> +        * that child was unlinked while parent was unlocked. Since we are
> +        * holding a reference to child, it could not have become negative.
> +        * d_unhashed(child) is not a strong enough indication for unlinked,
> +        * because with casefolded parent dir, ovl_create_temp() returns an
> +        * unhashed dentry.
> +        */
> +       is_unlinked =3D cant_mount(child) || WARN_ON_ONCE(d_is_negative(chi=
ld));
> +       if (!is_unlinked && child->d_parent =3D=3D parent)
>                 return 0;
>=20
>         inode_unlock(parent->d_inode);
>=20

I don't feel comfortable with that.  Letting ovl_parent_lock() succeed
on an unhashed dentry doesn't work for my longer term plans for locking.
I would really rather we got that dentry hashed.

What is happening is :
  - lookup on non-existent name -> unhashed dentry
  - vfs_create on that dentry - still unhashed
  - rename of that unhashed dentry -> confusion in ovl_parent_lock()

If this were being done from user-space there would be another lookup
after the create and before the rename, and that would result in a
hashed dentry.

Could ovl_create_real() do a lookup for the name if the dentry isn't
hashed?  That should result in a dentry that can safely be passed to
ovl_parent_lock().

NeilBrown


