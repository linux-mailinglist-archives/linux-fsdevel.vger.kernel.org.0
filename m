Return-Path: <linux-fsdevel+bounces-59424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC20B38943
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 20:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B571BA3E34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 18:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E742C235E;
	Wed, 27 Aug 2025 18:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4cQTLfr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D32942AA5;
	Wed, 27 Aug 2025 18:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756318036; cv=none; b=Cf1gQJxJMpVHW4cZAuTnY0FViTvkV64M/2mH25rcuRe1mb3E7HNloaAlzR+wAfVq28JDv6QOPuq6nngqwWykviKykVuQkCSAWkGvyySc3KrF5I6rOuDyN4nbkI2VhGzZPeijNgH5ZRuYBG5O0niwZIHI70jhRsHp8eYN6E0r7Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756318036; c=relaxed/simple;
	bh=uqqlqciF8fhb3wrV1OXUajljBlp+Y6g2Nj22H/UwjwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKVs5BaTC6wjrrNXdsORrA2yab0h6txgY6/ZVULFB8AAzunwczEXp9Mg/ZIUvJ9F1VMdWygunUoYPTkA5c2BWsO7Pg5j9WgHXEJ0Cn1lfScTFJDV34D+3XOpv1nVVmS99uDovq1rFsAGPYU+jx7yynUAcg0S9dbopo7vJtqGoXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4cQTLfr; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afec56519c8so12787366b.2;
        Wed, 27 Aug 2025 11:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756318031; x=1756922831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgDrZW8t/x8j9pETLKxjpKUIpwNJcADZEWWQcjU06KE=;
        b=a4cQTLfrNU1itNUu7IvUFi/LkTnWUYX9HYLUqgUNkqbdY6TgzQCkQU+Dsbm83pT+2C
         Dqot/Srgh+yR+9Lxj+fayvLaCpTFU4p7TLz356ovh7IDQpEB++FYOQ118J+52oIrptk9
         cgIQDuJsWKPEtO380zh7GDLNyGFW3jpJliEfW4cAHilBsOwcRVmuWc0KtjM6SliUGju0
         1zark+kFC776H/jTSfObmlWRPEdPWcgYRtwCt/GluCe6kJt42brfxYICaoDSHS/VpZC5
         EN3DS5jFxgREfkwHcLK+UsAG4aC6aIMzYTNP5hGEASnc1aRlzERmj4EjrZMv6fl7I1b9
         G7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756318031; x=1756922831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgDrZW8t/x8j9pETLKxjpKUIpwNJcADZEWWQcjU06KE=;
        b=woHLK2Pm7q7kNt5xP8+soVHQjREVQwq3wB62Wj8hJyRaR6KPJJWBMSLs+6XDj1q6Ky
         ILK2x4UV7uiCgr8ixOMJj8MCH8TK6OcYQpJABjKDKUr5r9RkJRMSK/R12h9D25JIEqmB
         4TTq01KVGA2LzCYwjhm0zD7d4o5aXFFD5moKM1hhpTnc/+YC6KzK6ZX8X9BqZV1eyFGM
         H3sPND9GxjcpQJNbx6emo6Zn/1Npz+vSe6rHcig8LoCdeyhVyLtzf2Bz3WRTuQmbtvol
         rNFAgfJTOp6J8YnVqeBl1UAVz8PzFnE5DbtiFyyyY7N88QNtv01l4SmB1mVpzp3rJpdy
         nHpw==
X-Forwarded-Encrypted: i=1; AJvYcCUGgnT0i2aFYBcCBd49jBdRcj1gls4ln5q6TxnM+ZZpi3IkXglDFDPxDPdcNqeWFXuaAxUqlPcGkdnUNWvo@vger.kernel.org, AJvYcCUnpGWLfkjsnk0wrro8XUCilRw7sFuE4JcLoZbXSnYSHQ2F+mbWBS+apHNbOlLYGF73DpujY0rWveO9dvip@vger.kernel.org, AJvYcCVJnOVY2X6SP5rBPTr9SqfRUmkgaM7wJcCBcRH/DOyySWpEt8I0TRzWNmGGquU/l1Pv6z0umt9HR4rCtEbzow==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx8geSujeu6aU4MuiaHCOHoLjUNKmpazikR6QcBLgxdvxb0W3o
	wbIbVsawURmp6jEn6Z1OMgx4Ah6jK+v1iVoyK/06C3gxEad0gfUD/m+TyBOV44zZFqiIzMSBKzD
	VpPTbJI8EKS/1a1cWwnLGy+ydL8zQ3PU=
X-Gm-Gg: ASbGncs7m6hC6mfOMxvv+mfyZIdWpcPw+wUQgz1PVvuPjH0upldlPw9iQymJvcZ6TbT
	8j8edXxghuyAXmAy/B0S06J0GTMIkCbyPTGm1NeRdsFc9QYqinvcW/SNml+HDgDbGRQWF80EKYv
	XB2bKfu08mW/Xb5mawvnUxXkd/hly3d3xu9NBb1fikhtxadzbjHJIZ0zNx6IFWjoIqH0USGcBGZ
	34bEyo=
X-Google-Smtp-Source: AGHT+IEiU9jMXzGGgFJSuk7KNGOFP2ffEMSNk8Gj84FdDOTFO9E44PibzEQ7rxDE7D23TYumoCv8/5FT9kiY7RaP0Bo=
X-Received: by 2002:a17:907:e98a:b0:afd:d62d:980e with SMTP id
 a640c23a62f3a-afe29446dcbmr1941842766b.28.1756318031136; Wed, 27 Aug 2025
 11:07:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
 <20250822-tonyk-overlayfs-v6-9-8b6e9e604fa2@igalia.com> <CAOQ4uxhWE=5_+DBx7OJ94NVCZXztxf1d4sxyMuakDGKUmbNyTg@mail.gmail.com>
 <62e60933-1c43-40c2-a166-91dd27b0e581@igalia.com> <CAOQ4uxjgp20vQuMO4GoMxva_8yR+kcW3EJxDuB=T-8KtvDr4kg@mail.gmail.com>
 <6235a4c0-2b28-4dd6-8f18-4c1f98015de6@igalia.com> <CAOQ4uxgMdeiPt1v4s07fZkGbs5+3sJw5VgcFu33_zH1dZtrSsg@mail.gmail.com>
 <18704e8c-c734-43f3-bc7c-b8be345e1bf5@igalia.com>
In-Reply-To: <18704e8c-c734-43f3-bc7c-b8be345e1bf5@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 27 Aug 2025 20:06:59 +0200
X-Gm-Features: Ac12FXxywCaSCY4VfYKO2y_tDwZpUvz7yGPCbsac4bdb1Xx0nMWNnDKNdOKTrV4
Message-ID: <CAOQ4uxj551a7cvjpcYEyTLtsEXw9OxHtTc-VSm170J5pWtwoUQ@mail.gmail.com>
Subject: Re: [PATCH v6 9/9] ovl: Support mounting case-insensitive enabled layers
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 9:01=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
>
>
> Em 26/08/2025 04:31, Amir Goldstein escreveu:
> > On Mon, Aug 25, 2025 at 3:31=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid=
@igalia.com> wrote:
> >>
> >> Hi Amir,
> >>
> >> Em 22/08/2025 16:17, Amir Goldstein escreveu:
> >>
> >> [...]
> >>
> >>     /*
> >>>>>> -        * Allow filesystems that are case-folding capable but den=
y composing
> >>>>>> -        * ovl stack from case-folded directories.
> >>>>>> +        * Exceptionally for layers with casefold, we accept that =
they have
> >>>>>> +        * their own hash and compare operations
> >>>>>>             */
> >>>>>> -       if (sb_has_encoding(dentry->d_sb))
> >>>>>> -               return IS_CASEFOLDED(d_inode(dentry));
> >>>>>> +       if (ofs->casefold)
> >>>>>> +               return false;
> >>>>>
> >>>>> I think this is better as:
> >>>>>            if (sb_has_encoding(dentry->d_sb))
> >>>>>                    return false;
> >>>>>
> >>>
> >>> And this still fails the test "Casefold enabled" for me.
> >>>
> >>> Maybe you are confused because this does not look like
> >>> a test failure. It looks like this:
> >>>
> >>> generic/999 5s ...  [19:10:21][  150.667994] overlayfs: failed lookup
> >>> in lower (ovl-lower/casefold, name=3D'subdir', err=3D-116): parent wr=
ong
> >>> casefold
> >>> [  150.669741] overlayfs: failed lookup in lower (ovl-lower/casefold,
> >>> name=3D'subdir', err=3D-116): parent wrong casefold
> >>> [  150.760644] overlayfs: failed lookup in lower (/ovl-lower,
> >>> name=3D'casefold', err=3D-66): child wrong casefold
> >>>    [19:10:24] [not run]
> >>> generic/999 -- overlayfs does not support casefold enabled layers
> >>> Ran: generic/999
> >>> Not run: generic/999
> >>> Passed all 1 tests
> >>>
> >>
> >> This is how the test output looks before my changes[1] to the test:
> >>
> >> $ ./run.sh
> >> FSTYP         -- ext4
> >> PLATFORM      -- Linux/x86_64 archlinux 6.17.0-rc1+ #1174 SMP
> >> PREEMPT_DYNAMIC Mon Aug 25 10:18:09 -03 2025
> >> MKFS_OPTIONS  -- -F /dev/vdc
> >> MOUNT_OPTIONS -- -o acl,user_xattr /dev/vdc /tmp/dir2
> >>
> >> generic/999 1s ... [not run] overlayfs does not support casefold enabl=
ed
> >> layers
> >> Ran: generic/999
> >> Not run: generic/999
> >> Passed all 1 tests
> >>
> >>
> >> And this is how it looks after my changes[1] to the test:
> >>
> >> $ ./run.sh
> >> FSTYP         -- ext4
> >> PLATFORM      -- Linux/x86_64 archlinux 6.17.0-rc1+ #1174 SMP
> >> PREEMPT_DYNAMIC Mon Aug 25 10:18:09 -03 2025
> >> MKFS_OPTIONS  -- -F /dev/vdc
> >> MOUNT_OPTIONS -- -o acl,user_xattr /dev/vdc /tmp/dir2
> >>
> >> generic/999        1s
> >> Ran: generic/999
> >> Passed all 1 tests
> >>
> >> So, as far as I can tell, the casefold enabled is not being skipped
> >> after the fix to the test.
> >
> > Is this how it looks with your v6 or after fixing the bug:
> > https://lore.kernel.org/linux-unionfs/68a8c4d7.050a0220.37038e.005c.GAE=
@google.com/
> >
> > Because for me this skipping started after fixing this bug
> > Maybe we fixed the bug incorrectly, but I did not see what the problem
> > was from a quick look.
> >
> > Can you test with my branch:
> > https://github.com/amir73il/linux/commits/ovl_casefold/
> >
>
> Right, our branches have a different base, mine is older and based on
> the tag vfs/vfs-6.18.mount.
>
> I have now tested with your branch, and indeed the test fails with
> "overlayfs does not support casefold enabled". I did some debugging and
> the missing commit from my branch that is making this difference here is
> e8bd877fb76bb9f3 ("ovl: fix possible double unlink"). After reverting it
> on top of your branch, the test works. I'm not sure yet why this
> prevents the mount, but this is the call trace when the error happens:

Wow, that is an interesting development race...

>
> TID/PID 860/860 (mount/mount):
>
>                      entry_SYSCALL_64_after_hwframe+0x77
>                      do_syscall_64+0xa2
>                      x64_sys_call+0x1bc3
>                      __x64_sys_fsconfig+0x46c
>                      vfs_cmd_create+0x60
>                      vfs_get_tree+0x2e
>                      ovl_get_tree+0x19
>                      get_tree_nodev+0x70
>                      ovl_fill_super+0x53b
> !    0us [-EINVAL]  ovl_parent_lock
>
> And for the ovl_parent_lock() arguments, *parent=3D"work", *child=3D"#7".=
 So
> right now I'm trying to figure out why the dentry for #7 is not hashed.
>

The reason is this:

static struct dentry *ext4_lookup(...
{
...
        if (IS_ENABLED(CONFIG_UNICODE) && !inode && IS_CASEFOLDED(dir)) {
                /* Eventually we want to call d_add_ci(dentry, NULL)
                 * for negative dentries in the encoding case as
                 * well.  For now, prevent the negative dentry
                 * from being cached.
                 */
                return NULL;
        }

        return d_splice_alias(inode, dentry);
}

Neil,

Apparently, the assumption that
ovl_lookup_temp() =3D> ovl_lookup_upper() =3D> lookup_one()
returns a hashed dentry is not always true.

It may be always true for all the filesystems that are currently
supported as an overlayfs
upper layer fs (?), but it does not look like you can count on this
for the wider vfs effort
and we should try to come up with a solution for ovl_parent_lock()
that will allow enabling
casefolding on overlayfs layers.

This patch seems to work. WDYT?

Thanks,
Amir.

commit 5dfcd10378038637648f3f422e3d5097eb6faa5f
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Wed Aug 27 19:55:26 2025 +0200

    ovl: adapt ovl_parent_lock() to casefolded directories

    e8bd877fb76bb9f3 ("ovl: fix possible double unlink") added a sanity
    check of !d_unhashed(child) to try to verify that child dentry was not
    unlinked while parent dir was unlocked.

    This "was not unlink" check has a false positive result in the case of
    casefolded parent dir, because in that case, ovl_create_temp() returns
    an unhashed dentry.

    Change the "was not unlinked" check to use cant_mount(child).
    cant_mount(child) means that child was unlinked while we have been
    holding a reference to child, so it could not have become negative.

    This fixes the error in ovl_parent_lock() in ovl_check_rename_whiteout(=
)
    after ovl_create_temp() and allows mount of overlayfs with casefolding
    enabled layers.

    Reported-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
    Link: https://lore.kernel.org/r/18704e8c-c734-43f3-bc7c-b8be345e1bf5@ig=
alia.com/
    Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index bec4a39d1b97c..bffbb59776720 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1551,9 +1551,23 @@ void ovl_copyattr(struct inode *inode)

 int ovl_parent_lock(struct dentry *parent, struct dentry *child)
 {
+       bool is_unlinked;
+
        inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
-       if (!child ||
-           (!d_unhashed(child) && child->d_parent =3D=3D parent))
+       if (!child)
+               return 0;
+
+       /*
+        * After re-acquiring parent dir lock, verify that child was not mo=
ved
+        * to another parent and that it was not unlinked. cant_mount() mea=
ns
+        * that child was unlinked while parent was unlocked. Since we are
+        * holding a reference to child, it could not have become negative.
+        * d_unhashed(child) is not a strong enough indication for unlinked=
,
+        * because with casefolded parent dir, ovl_create_temp() returns an
+        * unhashed dentry.
+        */
+       is_unlinked =3D cant_mount(child) || WARN_ON_ONCE(d_is_negative(chi=
ld));
+       if (!is_unlinked && child->d_parent =3D=3D parent)
                return 0;

        inode_unlock(parent->d_inode);

