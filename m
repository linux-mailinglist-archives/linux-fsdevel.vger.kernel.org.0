Return-Path: <linux-fsdevel+bounces-59513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22513B3A6BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 18:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4F5165380
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 16:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EEE32C30F;
	Thu, 28 Aug 2025 16:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Roozq7Pw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE261322DBF;
	Thu, 28 Aug 2025 16:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756399482; cv=none; b=TUMrfg6ffn8wU/pXbRtMTjctYchtQtprwPuMsNUPoDbxTZoNCU6PqecCaU2Zb4iiFuih0IvGE0iq2ebjeGpMhvRgRDdx/Ql9dB7fGaRfLAbroDw7Scb/mwI9I9AF9veIsb+iOs4E7KVPerGfOVLVuj88uxtbq2UWAb7d+7wi9mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756399482; c=relaxed/simple;
	bh=uwg8DhpbaIf+Lp47UGrGhwTWEmwgNOVbpLz4GvGtldI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmQHXlvAPn+8JsshfoRQ6FM5GnRw1BwIVqm0sBIHAJVg2avU8NBFTYQIsV/Axkl9KAgzXw3fml7Tn/lHPCd0KSHJH9LGs99YxfMNWiXTrRLqAgfrc7ECNTnryc1D6H5Pt+TEA71J08GUJIkAyZEi2f2qbumz7/wyWz5YLwjfRVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Roozq7Pw; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61c7942597fso4633654a12.0;
        Thu, 28 Aug 2025 09:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756399478; x=1757004278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1oYxNl79KV+WnUAs242vjco0TW5S8zrO3Yjw+fbe34=;
        b=Roozq7PwUvI5goNW/DuBrvh1rK+K4lbolJCgKBdnKYBI0u+EpbWyAAwBRuK0425gci
         pWLZrJGtT0vHP5hgQk1zPmSfonzbI3NZNOga2A7z2lw0zKP4H/O2yDQTqGVx1KNt5z4Z
         476V0KSzMnzYwdvSWmOIP/MZprdtDeFIDY5H7dQyt8XWMC45Np/6nsvnaESI+SHLhD7R
         gdTb+Wa0yScSfTLKI/afwvtJvHNIMv/iSoAanxnWIhqSx1cpCs5cg07aBu9OMAt6TkSO
         ePGMkhpaouZaImIxtpJ8fhQIUHBknRmTmL0WKlB8UmnYMWqTchuCsjeELgpObOw5pT6J
         auZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756399478; x=1757004278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1oYxNl79KV+WnUAs242vjco0TW5S8zrO3Yjw+fbe34=;
        b=h9eiKP6v75e9oMYKsB9fnrIvXHJCkfbORfD4S6NZ7BYfeNx+rFmT9VhhKM0ifP54Qi
         twh5eIpusYKvfP+hPhJ5H6ATqAOTzVKJ87aXG85oDwQow7043c+B8K2pIi4qNH3fJM7O
         Pat6G831RZKxLJ3qUYbTdnveyL1g/4B5I3bjCouz+cFM0SWJjrApwYkOOCiiQxyJinpO
         EM/vxGA5kR9ZL1291ql/Qill6FhDssZl/DJnouUcgufar5K68s0RL1Xtf0eSxVY5vWf8
         tysiRmtHpFK4fM+VLSc9AelOZd9seysbrYs3tstKusTlLYjGUOmv+YFVOOhTVzSr3gF0
         wlTA==
X-Forwarded-Encrypted: i=1; AJvYcCVh5Z2ocqwrI5vlLifk0nTl99dKD8+JqiUwTEeG0SjvsypIT5CI547YRBQYoLnMavyG9yYfW2cEFVkfy3buqA==@vger.kernel.org, AJvYcCX81pYdCM5csX5OYB8G3s/h/vB1rZddU9XbgniJRPTE+gkIMDz37WjFASjqBhGtBZruWoHgGMT3Yna13V5g@vger.kernel.org, AJvYcCXQr1YcRUk9MPha71vGnxD/yGRJi5fYtrYZCkBskbyVQr++t/24RzoZTQTUgZjUAFp3HuECuQ7D57/y6Et9@vger.kernel.org
X-Gm-Message-State: AOJu0YxvMZwZc7mvBIdj+aEP5H3e85R8xELdBr5ECR5TU41XJeoc0Bf0
	hPut6CZP6ZPgbg6JL+Ioha2PokoN4jyxowhfMSfbyGzfgcbuqYn45JoJKxhMK6UHsRPkrJtzNjt
	PRaUNqmytcLL/SGb8bZ7QsNXRcxoy3uU=
X-Gm-Gg: ASbGncvrxvhrRWUrWRhUzndflI3jpwMWqdISJhIbbFBi3AGfJyFJNmT5AfvqTCL3ob1
	OXJiKKggHLPRvUBbwv8T8HkQeQAXrZbhKm5dqPxih8yzsWZ5tqPR4ISvu/HwBRnJ8OWXI7LzcOv
	uHIHCbtEMJMZL3v7aNEyfqiBalnYOYvc/tuaADEtRpoQkEP1c83HPyO2VOba6SL4/GnYrIvjRsA
	372p5AvQqlvQ8hY3A==
X-Google-Smtp-Source: AGHT+IHk97TQgUdvqCtvxly5QSHhyONPa1bTKiIm75KZov2ZedDBpgSVOi1MZ8E0y3turH98Xt+jB35mx0hlb+5vnDc=
X-Received: by 2002:aa7:c892:0:b0:61c:5100:3063 with SMTP id
 4fb4d7f45d1cf-61c983b959emr6749938a12.7.1756399477823; Thu, 28 Aug 2025
 09:44:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxj551a7cvjpcYEyTLtsEXw9OxHtTc-VSm170J5pWtwoUQ@mail.gmail.com>
 <175633908557.2234665.14959580663322237611@noble.neil.brown.name>
 <87ldn416il.fsf@mailhost.krisman.be> <CAOQ4uxhJfFgpUKHy0c23i0dsvxZoRuGxMVXbasEn3zf3s0ORYg@mail.gmail.com>
In-Reply-To: <CAOQ4uxhJfFgpUKHy0c23i0dsvxZoRuGxMVXbasEn3zf3s0ORYg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 28 Aug 2025 18:44:26 +0200
X-Gm-Features: Ac12FXxmYGHjZX0AXTrhwV22C74ZW8Lbzo1cU21TSkKinMkK3uq1KUywKsTB4Gw
Message-ID: <CAOQ4uxhGmTbCJMz8C2gKzU5hjBBzKqR2eOtRJz4J83AxSD5djg@mail.gmail.com>
Subject: Re: [PATCH v6 9/9] ovl: Support mounting case-insensitive enabled layers
To: NeilBrown <neil@brown.name>
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com, Gabriel Krisman Bertazi <gabriel@krisman.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 9:25=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Thu, Aug 28, 2025 at 5:15=E2=80=AFAM Gabriel Krisman Bertazi
> <gabriel@krisman.be> wrote:
> >
> > "NeilBrown" <neil@brown.name> writes:
> >
> > > On Thu, 28 Aug 2025, Amir Goldstein wrote:
> > >> On Tue, Aug 26, 2025 at 9:01=E2=80=AFPM Andr=C3=A9 Almeida <andrealm=
eid@igalia.com> wrote:
> > >> >
> > >> >
> > >> >
> > >> > Em 26/08/2025 04:31, Amir Goldstein escreveu:
> > >> > > On Mon, Aug 25, 2025 at 3:31=E2=80=AFPM Andr=C3=A9 Almeida <andr=
ealmeid@igalia.com> wrote:
> > >> > >>
> > >> > >> Hi Amir,
> > >> > >>
> > >> > >> Em 22/08/2025 16:17, Amir Goldstein escreveu:
> > >> > >>
> > >> > >> [...]
> > >> > >>
> > >> > >>     /*
> > >> > >>>>>> -        * Allow filesystems that are case-folding capable =
but deny composing
> > >> > >>>>>> -        * ovl stack from case-folded directories.
> > >> > >>>>>> +        * Exceptionally for layers with casefold, we accep=
t that they have
> > >> > >>>>>> +        * their own hash and compare operations
> > >> > >>>>>>             */
> > >> > >>>>>> -       if (sb_has_encoding(dentry->d_sb))
> > >> > >>>>>> -               return IS_CASEFOLDED(d_inode(dentry));
> > >> > >>>>>> +       if (ofs->casefold)
> > >> > >>>>>> +               return false;
> > >> > >>>>>
> > >> > >>>>> I think this is better as:
> > >> > >>>>>            if (sb_has_encoding(dentry->d_sb))
> > >> > >>>>>                    return false;
> > >> > >>>>>
> > >> > >>>
> > >> > >>> And this still fails the test "Casefold enabled" for me.
> > >> > >>>
> > >> > >>> Maybe you are confused because this does not look like
> > >> > >>> a test failure. It looks like this:
> > >> > >>>
> > >> > >>> generic/999 5s ...  [19:10:21][  150.667994] overlayfs: failed=
 lookup
> > >> > >>> in lower (ovl-lower/casefold, name=3D'subdir', err=3D-116): pa=
rent wrong
> > >> > >>> casefold
> > >> > >>> [  150.669741] overlayfs: failed lookup in lower (ovl-lower/ca=
sefold,
> > >> > >>> name=3D'subdir', err=3D-116): parent wrong casefold
> > >> > >>> [  150.760644] overlayfs: failed lookup in lower (/ovl-lower,
> > >> > >>> name=3D'casefold', err=3D-66): child wrong casefold
> > >> > >>>    [19:10:24] [not run]
> > >> > >>> generic/999 -- overlayfs does not support casefold enabled lay=
ers
> > >> > >>> Ran: generic/999
> > >> > >>> Not run: generic/999
> > >> > >>> Passed all 1 tests
> > >> > >>>
> > >> > >>
> > >> > >> This is how the test output looks before my changes[1] to the t=
est:
> > >> > >>
> > >> > >> $ ./run.sh
> > >> > >> FSTYP         -- ext4
> > >> > >> PLATFORM      -- Linux/x86_64 archlinux 6.17.0-rc1+ #1174 SMP
> > >> > >> PREEMPT_DYNAMIC Mon Aug 25 10:18:09 -03 2025
> > >> > >> MKFS_OPTIONS  -- -F /dev/vdc
> > >> > >> MOUNT_OPTIONS -- -o acl,user_xattr /dev/vdc /tmp/dir2
> > >> > >>
> > >> > >> generic/999 1s ... [not run] overlayfs does not support casefol=
d enabled
> > >> > >> layers
> > >> > >> Ran: generic/999
> > >> > >> Not run: generic/999
> > >> > >> Passed all 1 tests
> > >> > >>
> > >> > >>
> > >> > >> And this is how it looks after my changes[1] to the test:
> > >> > >>
> > >> > >> $ ./run.sh
> > >> > >> FSTYP         -- ext4
> > >> > >> PLATFORM      -- Linux/x86_64 archlinux 6.17.0-rc1+ #1174 SMP
> > >> > >> PREEMPT_DYNAMIC Mon Aug 25 10:18:09 -03 2025
> > >> > >> MKFS_OPTIONS  -- -F /dev/vdc
> > >> > >> MOUNT_OPTIONS -- -o acl,user_xattr /dev/vdc /tmp/dir2
> > >> > >>
> > >> > >> generic/999        1s
> > >> > >> Ran: generic/999
> > >> > >> Passed all 1 tests
> > >> > >>
> > >> > >> So, as far as I can tell, the casefold enabled is not being ski=
pped
> > >> > >> after the fix to the test.
> > >> > >
> > >> > > Is this how it looks with your v6 or after fixing the bug:
> > >> > > https://lore.kernel.org/linux-unionfs/68a8c4d7.050a0220.37038e.0=
05c.GAE@google.com/
> > >> > >
> > >> > > Because for me this skipping started after fixing this bug
> > >> > > Maybe we fixed the bug incorrectly, but I did not see what the p=
roblem
> > >> > > was from a quick look.
> > >> > >
> > >> > > Can you test with my branch:
> > >> > > https://github.com/amir73il/linux/commits/ovl_casefold/
> > >> > >
> > >> >
> > >> > Right, our branches have a different base, mine is older and based=
 on
> > >> > the tag vfs/vfs-6.18.mount.
> > >> >
> > >> > I have now tested with your branch, and indeed the test fails with
> > >> > "overlayfs does not support casefold enabled". I did some debuggin=
g and
> > >> > the missing commit from my branch that is making this difference h=
ere is
> > >> > e8bd877fb76bb9f3 ("ovl: fix possible double unlink"). After revert=
ing it
> > >> > on top of your branch, the test works. I'm not sure yet why this
> > >> > prevents the mount, but this is the call trace when the error happ=
ens:
> > >>
> > >> Wow, that is an interesting development race...
> > >>
> > >> >
> > >> > TID/PID 860/860 (mount/mount):
> > >> >
> > >> >                      entry_SYSCALL_64_after_hwframe+0x77
> > >> >                      do_syscall_64+0xa2
> > >> >                      x64_sys_call+0x1bc3
> > >> >                      __x64_sys_fsconfig+0x46c
> > >> >                      vfs_cmd_create+0x60
> > >> >                      vfs_get_tree+0x2e
> > >> >                      ovl_get_tree+0x19
> > >> >                      get_tree_nodev+0x70
> > >> >                      ovl_fill_super+0x53b
> > >> > !    0us [-EINVAL]  ovl_parent_lock
> > >> >
> > >> > And for the ovl_parent_lock() arguments, *parent=3D"work", *child=
=3D"#7". So
> > >> > right now I'm trying to figure out why the dentry for #7 is not ha=
shed.
> > >> >
> > >>
> > >> The reason is this:
> > >>
> > >> static struct dentry *ext4_lookup(...
> > >> {
> > >> ...
> > >>         if (IS_ENABLED(CONFIG_UNICODE) && !inode && IS_CASEFOLDED(di=
r)) {
> > >>                 /* Eventually we want to call d_add_ci(dentry, NULL)
> > >>                  * for negative dentries in the encoding case as
> > >>                  * well.  For now, prevent the negative dentry
> > >>                  * from being cached.
> > >>                  */
> > >>                 return NULL;
> > >>         }
> > >>
> > >>         return d_splice_alias(inode, dentry);
> > >> }
> > >>
> > >> Neil,
> > >>
> > >> Apparently, the assumption that
> > >> ovl_lookup_temp() =3D> ovl_lookup_upper() =3D> lookup_one()
> > >> returns a hashed dentry is not always true.
> > >>
> > >> It may be always true for all the filesystems that are currently
> > >> supported as an overlayfs
> > >> upper layer fs (?), but it does not look like you can count on this
> > >> for the wider vfs effort
> > >> and we should try to come up with a solution for ovl_parent_lock()
> > >> that will allow enabling
> > >> casefolding on overlayfs layers.
> > >>
> > >> This patch seems to work. WDYT?
> > >>
> > >> Thanks,
> > >> Amir.
> > >>
> > >> commit 5dfcd10378038637648f3f422e3d5097eb6faa5f
> > >> Author: Amir Goldstein <amir73il@gmail.com>
> > >> Date:   Wed Aug 27 19:55:26 2025 +0200
> > >>
> > >>     ovl: adapt ovl_parent_lock() to casefolded directories
> > >>
> > >>     e8bd877fb76bb9f3 ("ovl: fix possible double unlink") added a san=
ity
> > >>     check of !d_unhashed(child) to try to verify that child dentry w=
as not
> > >>     unlinked while parent dir was unlocked.
> > >>
> > >>     This "was not unlink" check has a false positive result in the c=
ase of
> > >>     casefolded parent dir, because in that case, ovl_create_temp() r=
eturns
> > >>     an unhashed dentry.
> > >>
> > >>     Change the "was not unlinked" check to use cant_mount(child).
> > >>     cant_mount(child) means that child was unlinked while we have be=
en
> > >>     holding a reference to child, so it could not have become negati=
ve.
> > >>
> > >>     This fixes the error in ovl_parent_lock() in ovl_check_rename_wh=
iteout()
> > >>     after ovl_create_temp() and allows mount of overlayfs with casef=
olding
> > >>     enabled layers.
> > >>
> > >>     Reported-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> > >>     Link: https://lore.kernel.org/r/18704e8c-c734-43f3-bc7c-b8be345e=
1bf5@igalia.com/
> > >>     Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > >>
> > >> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> > >> index bec4a39d1b97c..bffbb59776720 100644
> > >> --- a/fs/overlayfs/util.c
> > >> +++ b/fs/overlayfs/util.c
> > >> @@ -1551,9 +1551,23 @@ void ovl_copyattr(struct inode *inode)
> > >>
> > >>  int ovl_parent_lock(struct dentry *parent, struct dentry *child)
> > >>  {
> > >> +       bool is_unlinked;
> > >> +
> > >>         inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
> > >> -       if (!child ||
> > >> -           (!d_unhashed(child) && child->d_parent =3D=3D parent))
> > >> +       if (!child)
> > >> +               return 0;
> > >> +
> > >> +       /*
> > >> +        * After re-acquiring parent dir lock, verify that child was=
 not moved
> > >> +        * to another parent and that it was not unlinked. cant_moun=
t() means
> > >> +        * that child was unlinked while parent was unlocked. Since =
we are
> > >> +        * holding a reference to child, it could not have become ne=
gative.
> > >> +        * d_unhashed(child) is not a strong enough indication for u=
nlinked,
> > >> +        * because with casefolded parent dir, ovl_create_temp() ret=
urns an
> > >> +        * unhashed dentry.
> > >> +        */
> > >> +       is_unlinked =3D cant_mount(child) || WARN_ON_ONCE(d_is_negat=
ive(child));
> > >> +       if (!is_unlinked && child->d_parent =3D=3D parent)
> > >>                 return 0;
> > >>
> > >>         inode_unlock(parent->d_inode);
> > >>
> > >
> > > I don't feel comfortable with that.  Letting ovl_parent_lock() succee=
d
> > > on an unhashed dentry doesn't work for my longer term plans for locki=
ng.
> > > I would really rather we got that dentry hashed.
> > >
> > > What is happening is :
> > >   - lookup on non-existent name -> unhashed dentry
> > >   - vfs_create on that dentry - still unhashed
> > >   - rename of that unhashed dentry -> confusion in ovl_parent_lock()
> > >
> > > If this were being done from user-space there would be another lookup
> > > after the create and before the rename, and that would result in a
> > > hashed dentry.
> > >
> > > Could ovl_create_real() do a lookup for the name if the dentry isn't
> > > hashed?  That should result in a dentry that can safely be passed to
> > > ovl_parent_lock().
> >

See patch below.
Seems to get the job done.

Thanks,
Amir.

>
> FYI, if your future work for vfs assumes that fs will alway have the
> dentry hashed after create, you may want to look at:
>
> static int ovl_instantiate(struct dentry *dentry, struct inode *inode,
> ...
>         /* Force lookup of new upper hardlink to find its lower */
>         if (hardlink)
>                 d_drop(dentry);
>
>         return 0;
> }
>
> If your assumption is not true for overlayfs, it may not be true for othe=
r fs
> as well. How could you verify that it is correct?
>
> I really hope that you have some opt-in strategy in mind, so those new
> dirops assumptions would not have to include all possible filesystems.
>


commit 32786370148617766043f6d054ff40758ce79f21 (HEAD -> ovl_casefold)
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Wed Aug 27 19:55:26 2025 +0200

    ovl: make sure that ovl_create_real() returns a hashed dentry

    e8bd877fb76bb9f3 ("ovl: fix possible double unlink") added a sanity
    check of !d_unhashed(child) to try to verify that child dentry was not
    unlinked while parent dir was unlocked.

    This "was not unlink" check has a false positive result in the case of
    casefolded parent dir, because in that case, ovl_create_temp() returns
    an unhashed dentry after ovl_create_real() gets an unhashed dentry from
    ovl_lookup_upper() and makes it positive.

    To avoid returning unhashed dentry from ovl_create_temp(), let
    ovl_create_real() lookup again after making the newdentry positive,
    so it always returns a hashed positive dentry (or an error).

    This fixes the error in ovl_parent_lock() in ovl_check_rename_whiteout(=
)
    after ovl_create_temp() and allows mount of overlayfs with casefolding
    enabled layers.

    Reported-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
    Closes: https://lore.kernel.org/r/18704e8c-c734-43f3-bc7c-b8be345e1bf5@=
igalia.com/
    Suggested-by: Neil Brown <neil@brown.name>
    Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 538a1b2dbb387..a5e9ddf3023b3 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -212,12 +212,32 @@ struct dentry *ovl_create_real(struct ovl_fs
*ofs, struct dentry *parent,
                        err =3D -EPERM;
                }
        }
-       if (!err && WARN_ON(!newdentry->d_inode)) {
+       if (err)
+               goto out;
+
+       if (WARN_ON(!newdentry->d_inode)) {
                /*
                 * Not quite sure if non-instantiated dentry is legal or no=
t.
                 * VFS doesn't seem to care so check and warn here.
                 */
                err =3D -EIO;
+       } else if (d_unhashed(newdentry)) {
+               struct dentry *d;
+               /*
+                * Some filesystems (i.e. casefolded) may return an unhashe=
d
+                * negative dentry from the ovl_lookup_upper() call before
+                * ovl_create_real().
+                * In that case, lookup again after making the newdentry
+                * positive, so ovl_create_upper() always returns a hashed
+                * positive dentry.
+                */
+               d =3D ovl_lookup_upper(ofs, newdentry->d_name.name, parent,
+                                    newdentry->d_name.len);
+               dput(newdentry);
+               if (IS_ERR_OR_NULL(d))
+                       err =3D d ? PTR_ERR(d) : -ENOENT;
+               else
+                       return d;
        }
 out:
        if (err) {

