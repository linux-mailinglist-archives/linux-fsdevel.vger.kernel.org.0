Return-Path: <linux-fsdevel+bounces-59467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD44B39519
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 09:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5768B189E6BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 07:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540282D6E68;
	Thu, 28 Aug 2025 07:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRsJ0VG9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B962D0274;
	Thu, 28 Aug 2025 07:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756365926; cv=none; b=LZOxtfL0bA46oAzSrVEI9VkNp6Qjpe+OV9CKeeOdy/5XtIEeUJsi/atmaU5vJCC7CdZihhnCE10mnhXcrmjmFhermhy1o12CBKNEXDbRQS0bnKJox/LD3/ADsezOVav0ep2vyQ+s+AXgZsys6eCBmppEYQX4dC6i8RAIgV8+yp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756365926; c=relaxed/simple;
	bh=E6hJ7d0BBx/C6PP6yRRZKrLaMDN55y8ro2gcimm4r/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MjCZr7q191xjb9ryNdw5NfSMHuOiJ3uRJyGGTxfX4Q4mRHHJD9cral/6kUPNyI09zXgGK5fNQ0rCSYK5JVCJ8SUwDBgkWBkJGtWuhxoy27yGvwO0IXCaTDELJYOrHEXP09LrJqVHy9x3DImuT2Pqk3OzzwTdIJcb1hWTg+Un3/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRsJ0VG9; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61cb9e039d9so1200993a12.1;
        Thu, 28 Aug 2025 00:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756365919; x=1756970719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrF8339N14j0AqIqMbzGbNGOg2JSxLKavWKQA1/3tD8=;
        b=dRsJ0VG9ZN9QMhlCkjstAWdqovRyIdcIuhoCtd3iF1MuwN/5M1Lcbz+ByfVL/jopj7
         G2AhnGIiNtuso33kXZm0brr0Kj2vsNK4L3n/2xm6dBfU8XYs7H9v0KLrou0gACbu6C4d
         S1G9waFza1/NwbWAaxrxIW2VvR/JRcmQalf0YcVaW0x+bG+w8PDLT3hGVFivtVupRtyb
         rzX/xoQswRBeAT0YsXlHJ1ivAsi831Sc0L+eo65CEw3VgEIBnCBAIPgMzoaXPZyuCu6t
         JA7XTRKcdcleJPnCKLzzcv9/IDzrY05qd6CsrTnYB7MrHsZJNNmGqz3u0CLMbRx7jwWV
         0AXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756365919; x=1756970719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrF8339N14j0AqIqMbzGbNGOg2JSxLKavWKQA1/3tD8=;
        b=v5+Nlqz4ETjPTRrnyoJBX5aeyfm+4luwcvcsS6FzgIasJFe/XsCWJWrlbsnC0QCd8P
         9ayMHxlM4+g/6hbrvQ2VmLJ5EOm4TQbTX12+096L8jHqhyi+QEw26RwlTu4ijUzboAPw
         BoWy2LxlEF/CEQbhAjroW++RnmB6EnBAfa+VSMKMEFKwKR03YO+uESml59yKtY8w29pX
         YDvs6m2VjwD6TfOyKFtxffYt0E2Zijx346dPiwcpP1lGdDG4HvSEiDFRtYe11jEBqcSJ
         NlbbhHjG1TIQaDnpuk8om+VFyAriw7cGo4YIvU85g1M3anYZ1bstNljtrzXHssdzv0yw
         WIww==
X-Forwarded-Encrypted: i=1; AJvYcCVU71s8vqr2fVoIvjUunKO+LSiCrVTPwvkDVzFvJcYiC+VDHl0kEX9iF2JaUboMpFwBgmOLDhq4d+dUvrui@vger.kernel.org, AJvYcCW3aV1Ghb2Rq8/7x7q4A7f+Y34DmcFVt95Bfr3+L/S3tMfTx1QgsrAM/7jCCHD43VObv0BQGPghV+XT1JXR@vger.kernel.org, AJvYcCX+PcUnQLIDwFYW3wjXysuR69jSp6d37ETeLTB7aQyUV4Faa/MHjybXUM3asWRlVD0f13j7mikdhsvL/mD23A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwv+3NfdFsbHhtP0J7S+sQzsuCkVtrSwg56WSxlCw2+c2+HFhz
	00cr4rCvO+opeOA14EB3p6+Ic9/0nE729P7rScfO8WcUcXQYfl9RhcAL5GGkkray0ktuGInNpa0
	nq2IR/WqjKGub1hu+8OliD1bfSBEuGe0=
X-Gm-Gg: ASbGncuHzu4CTfXY80kEIwXbt69d0heEAETJtI81jtbJ0KOdFVs3gQZBp2wX/X4d0Tk
	WR1RKb20t1pyNFF6Lp0Ltp2GW3utS5emc8Qp38uT2fOcVpk4ppBnVjenFO2Pxyy5wOCwwH2PbJ7
	fvVLBkcPN5kAVehDK0EXyvpNEn8kY0/Ws74yCPlXwo11bi0haiMFwAgbhe5ZMN22i8UyW3qfMTZ
	MtsUxM=
X-Google-Smtp-Source: AGHT+IEeFQofFZwVrQoNG5BYQqQsmbTCCuUJzGeDjcG3gve3112+dz4r8P074W/7dEa3MSlB8Vqzx6PU+XtSK+iq/7k=
X-Received: by 2002:a05:6402:51d1:b0:61c:e1d6:6bf6 with SMTP id
 4fb4d7f45d1cf-61ce1d672b2mr857482a12.7.1756365918958; Thu, 28 Aug 2025
 00:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxj551a7cvjpcYEyTLtsEXw9OxHtTc-VSm170J5pWtwoUQ@mail.gmail.com>
 <175633908557.2234665.14959580663322237611@noble.neil.brown.name> <87ldn416il.fsf@mailhost.krisman.be>
In-Reply-To: <87ldn416il.fsf@mailhost.krisman.be>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 28 Aug 2025 09:25:07 +0200
X-Gm-Features: Ac12FXywcZ1Qgo7VpU_2XkfsXJKC__bgn-foKxqM0W81pE1gr3L-wf1SD3IuRsQ
Message-ID: <CAOQ4uxhJfFgpUKHy0c23i0dsvxZoRuGxMVXbasEn3zf3s0ORYg@mail.gmail.com>
Subject: Re: [PATCH v6 9/9] ovl: Support mounting case-insensitive enabled layers
To: Gabriel Krisman Bertazi <gabriel@krisman.be>, NeilBrown <neil@brown.name>
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 5:15=E2=80=AFAM Gabriel Krisman Bertazi
<gabriel@krisman.be> wrote:
>
> "NeilBrown" <neil@brown.name> writes:
>
> > On Thu, 28 Aug 2025, Amir Goldstein wrote:
> >> On Tue, Aug 26, 2025 at 9:01=E2=80=AFPM Andr=C3=A9 Almeida <andrealmei=
d@igalia.com> wrote:
> >> >
> >> >
> >> >
> >> > Em 26/08/2025 04:31, Amir Goldstein escreveu:
> >> > > On Mon, Aug 25, 2025 at 3:31=E2=80=AFPM Andr=C3=A9 Almeida <andrea=
lmeid@igalia.com> wrote:
> >> > >>
> >> > >> Hi Amir,
> >> > >>
> >> > >> Em 22/08/2025 16:17, Amir Goldstein escreveu:
> >> > >>
> >> > >> [...]
> >> > >>
> >> > >>     /*
> >> > >>>>>> -        * Allow filesystems that are case-folding capable bu=
t deny composing
> >> > >>>>>> -        * ovl stack from case-folded directories.
> >> > >>>>>> +        * Exceptionally for layers with casefold, we accept =
that they have
> >> > >>>>>> +        * their own hash and compare operations
> >> > >>>>>>             */
> >> > >>>>>> -       if (sb_has_encoding(dentry->d_sb))
> >> > >>>>>> -               return IS_CASEFOLDED(d_inode(dentry));
> >> > >>>>>> +       if (ofs->casefold)
> >> > >>>>>> +               return false;
> >> > >>>>>
> >> > >>>>> I think this is better as:
> >> > >>>>>            if (sb_has_encoding(dentry->d_sb))
> >> > >>>>>                    return false;
> >> > >>>>>
> >> > >>>
> >> > >>> And this still fails the test "Casefold enabled" for me.
> >> > >>>
> >> > >>> Maybe you are confused because this does not look like
> >> > >>> a test failure. It looks like this:
> >> > >>>
> >> > >>> generic/999 5s ...  [19:10:21][  150.667994] overlayfs: failed l=
ookup
> >> > >>> in lower (ovl-lower/casefold, name=3D'subdir', err=3D-116): pare=
nt wrong
> >> > >>> casefold
> >> > >>> [  150.669741] overlayfs: failed lookup in lower (ovl-lower/case=
fold,
> >> > >>> name=3D'subdir', err=3D-116): parent wrong casefold
> >> > >>> [  150.760644] overlayfs: failed lookup in lower (/ovl-lower,
> >> > >>> name=3D'casefold', err=3D-66): child wrong casefold
> >> > >>>    [19:10:24] [not run]
> >> > >>> generic/999 -- overlayfs does not support casefold enabled layer=
s
> >> > >>> Ran: generic/999
> >> > >>> Not run: generic/999
> >> > >>> Passed all 1 tests
> >> > >>>
> >> > >>
> >> > >> This is how the test output looks before my changes[1] to the tes=
t:
> >> > >>
> >> > >> $ ./run.sh
> >> > >> FSTYP         -- ext4
> >> > >> PLATFORM      -- Linux/x86_64 archlinux 6.17.0-rc1+ #1174 SMP
> >> > >> PREEMPT_DYNAMIC Mon Aug 25 10:18:09 -03 2025
> >> > >> MKFS_OPTIONS  -- -F /dev/vdc
> >> > >> MOUNT_OPTIONS -- -o acl,user_xattr /dev/vdc /tmp/dir2
> >> > >>
> >> > >> generic/999 1s ... [not run] overlayfs does not support casefold =
enabled
> >> > >> layers
> >> > >> Ran: generic/999
> >> > >> Not run: generic/999
> >> > >> Passed all 1 tests
> >> > >>
> >> > >>
> >> > >> And this is how it looks after my changes[1] to the test:
> >> > >>
> >> > >> $ ./run.sh
> >> > >> FSTYP         -- ext4
> >> > >> PLATFORM      -- Linux/x86_64 archlinux 6.17.0-rc1+ #1174 SMP
> >> > >> PREEMPT_DYNAMIC Mon Aug 25 10:18:09 -03 2025
> >> > >> MKFS_OPTIONS  -- -F /dev/vdc
> >> > >> MOUNT_OPTIONS -- -o acl,user_xattr /dev/vdc /tmp/dir2
> >> > >>
> >> > >> generic/999        1s
> >> > >> Ran: generic/999
> >> > >> Passed all 1 tests
> >> > >>
> >> > >> So, as far as I can tell, the casefold enabled is not being skipp=
ed
> >> > >> after the fix to the test.
> >> > >
> >> > > Is this how it looks with your v6 or after fixing the bug:
> >> > > https://lore.kernel.org/linux-unionfs/68a8c4d7.050a0220.37038e.005=
c.GAE@google.com/
> >> > >
> >> > > Because for me this skipping started after fixing this bug
> >> > > Maybe we fixed the bug incorrectly, but I did not see what the pro=
blem
> >> > > was from a quick look.
> >> > >
> >> > > Can you test with my branch:
> >> > > https://github.com/amir73il/linux/commits/ovl_casefold/
> >> > >
> >> >
> >> > Right, our branches have a different base, mine is older and based o=
n
> >> > the tag vfs/vfs-6.18.mount.
> >> >
> >> > I have now tested with your branch, and indeed the test fails with
> >> > "overlayfs does not support casefold enabled". I did some debugging =
and
> >> > the missing commit from my branch that is making this difference her=
e is
> >> > e8bd877fb76bb9f3 ("ovl: fix possible double unlink"). After revertin=
g it
> >> > on top of your branch, the test works. I'm not sure yet why this
> >> > prevents the mount, but this is the call trace when the error happen=
s:
> >>
> >> Wow, that is an interesting development race...
> >>
> >> >
> >> > TID/PID 860/860 (mount/mount):
> >> >
> >> >                      entry_SYSCALL_64_after_hwframe+0x77
> >> >                      do_syscall_64+0xa2
> >> >                      x64_sys_call+0x1bc3
> >> >                      __x64_sys_fsconfig+0x46c
> >> >                      vfs_cmd_create+0x60
> >> >                      vfs_get_tree+0x2e
> >> >                      ovl_get_tree+0x19
> >> >                      get_tree_nodev+0x70
> >> >                      ovl_fill_super+0x53b
> >> > !    0us [-EINVAL]  ovl_parent_lock
> >> >
> >> > And for the ovl_parent_lock() arguments, *parent=3D"work", *child=3D=
"#7". So
> >> > right now I'm trying to figure out why the dentry for #7 is not hash=
ed.
> >> >
> >>
> >> The reason is this:
> >>
> >> static struct dentry *ext4_lookup(...
> >> {
> >> ...
> >>         if (IS_ENABLED(CONFIG_UNICODE) && !inode && IS_CASEFOLDED(dir)=
) {
> >>                 /* Eventually we want to call d_add_ci(dentry, NULL)
> >>                  * for negative dentries in the encoding case as
> >>                  * well.  For now, prevent the negative dentry
> >>                  * from being cached.
> >>                  */
> >>                 return NULL;
> >>         }
> >>
> >>         return d_splice_alias(inode, dentry);
> >> }
> >>
> >> Neil,
> >>
> >> Apparently, the assumption that
> >> ovl_lookup_temp() =3D> ovl_lookup_upper() =3D> lookup_one()
> >> returns a hashed dentry is not always true.
> >>
> >> It may be always true for all the filesystems that are currently
> >> supported as an overlayfs
> >> upper layer fs (?), but it does not look like you can count on this
> >> for the wider vfs effort
> >> and we should try to come up with a solution for ovl_parent_lock()
> >> that will allow enabling
> >> casefolding on overlayfs layers.
> >>
> >> This patch seems to work. WDYT?
> >>
> >> Thanks,
> >> Amir.
> >>
> >> commit 5dfcd10378038637648f3f422e3d5097eb6faa5f
> >> Author: Amir Goldstein <amir73il@gmail.com>
> >> Date:   Wed Aug 27 19:55:26 2025 +0200
> >>
> >>     ovl: adapt ovl_parent_lock() to casefolded directories
> >>
> >>     e8bd877fb76bb9f3 ("ovl: fix possible double unlink") added a sanit=
y
> >>     check of !d_unhashed(child) to try to verify that child dentry was=
 not
> >>     unlinked while parent dir was unlocked.
> >>
> >>     This "was not unlink" check has a false positive result in the cas=
e of
> >>     casefolded parent dir, because in that case, ovl_create_temp() ret=
urns
> >>     an unhashed dentry.
> >>
> >>     Change the "was not unlinked" check to use cant_mount(child).
> >>     cant_mount(child) means that child was unlinked while we have been
> >>     holding a reference to child, so it could not have become negative=
.
> >>
> >>     This fixes the error in ovl_parent_lock() in ovl_check_rename_whit=
eout()
> >>     after ovl_create_temp() and allows mount of overlayfs with casefol=
ding
> >>     enabled layers.
> >>
> >>     Reported-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> >>     Link: https://lore.kernel.org/r/18704e8c-c734-43f3-bc7c-b8be345e1b=
f5@igalia.com/
> >>     Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >>
> >> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> >> index bec4a39d1b97c..bffbb59776720 100644
> >> --- a/fs/overlayfs/util.c
> >> +++ b/fs/overlayfs/util.c
> >> @@ -1551,9 +1551,23 @@ void ovl_copyattr(struct inode *inode)
> >>
> >>  int ovl_parent_lock(struct dentry *parent, struct dentry *child)
> >>  {
> >> +       bool is_unlinked;
> >> +
> >>         inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
> >> -       if (!child ||
> >> -           (!d_unhashed(child) && child->d_parent =3D=3D parent))
> >> +       if (!child)
> >> +               return 0;
> >> +
> >> +       /*
> >> +        * After re-acquiring parent dir lock, verify that child was n=
ot moved
> >> +        * to another parent and that it was not unlinked. cant_mount(=
) means
> >> +        * that child was unlinked while parent was unlocked. Since we=
 are
> >> +        * holding a reference to child, it could not have become nega=
tive.
> >> +        * d_unhashed(child) is not a strong enough indication for unl=
inked,
> >> +        * because with casefolded parent dir, ovl_create_temp() retur=
ns an
> >> +        * unhashed dentry.
> >> +        */
> >> +       is_unlinked =3D cant_mount(child) || WARN_ON_ONCE(d_is_negativ=
e(child));
> >> +       if (!is_unlinked && child->d_parent =3D=3D parent)
> >>                 return 0;
> >>
> >>         inode_unlock(parent->d_inode);
> >>
> >
> > I don't feel comfortable with that.  Letting ovl_parent_lock() succeed
> > on an unhashed dentry doesn't work for my longer term plans for locking=
.
> > I would really rather we got that dentry hashed.
> >
> > What is happening is :
> >   - lookup on non-existent name -> unhashed dentry
> >   - vfs_create on that dentry - still unhashed
> >   - rename of that unhashed dentry -> confusion in ovl_parent_lock()
> >
> > If this were being done from user-space there would be another lookup
> > after the create and before the rename, and that would result in a
> > hashed dentry.
> >
> > Could ovl_create_real() do a lookup for the name if the dentry isn't
> > hashed?  That should result in a dentry that can safely be passed to
> > ovl_parent_lock().
>
> Might be a good time to mention I have a branch enabling negative
> dentries in casefolded directories.  It didn't have any major issues last
> time I posted, but it didn't get much interest.  It should be enough to
> resolve the unhashed dentries after a lookup due to casefolding.
>
> I'd need to revisit and retest, but it is a way out of it.
>

That's definitely a way out, but I don't know if it's needed to unblock the
ovl_casefold work.

I will try Neil's suggestion because it makes sense.

Neil,

FYI, if your future work for vfs assumes that fs will alway have the
dentry hashed after create, you may want to look at:

static int ovl_instantiate(struct dentry *dentry, struct inode *inode,
...
        /* Force lookup of new upper hardlink to find its lower */
        if (hardlink)
                d_drop(dentry);

        return 0;
}

If your assumption is not true for overlayfs, it may not be true for other =
fs
as well. How could you verify that it is correct?

I really hope that you have some opt-in strategy in mind, so those new
dirops assumptions would not have to include all possible filesystems.

Thanks,
Amir.

