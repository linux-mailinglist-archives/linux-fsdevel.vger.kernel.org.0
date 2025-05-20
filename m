Return-Path: <linux-fsdevel+bounces-49537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E43ABE1B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 19:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 596FA4C189D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 17:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9250C27FB04;
	Tue, 20 May 2025 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ipDHD+9o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3B5263F44
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747761456; cv=none; b=dbIkyk1lKK0ydVDEpzDlgl4zlvZ+HGNk+ciwyKcNYTHAQpWnbVpQVKUY0hr4lJ2IvpnFsOqiuCcGgbmCEv5UAHHqLpYo5y8qFuwNCBKT97WHypS9g4KOTVaQtapD/g/KvHIfn6g9gBmFwUmJB8dyqqremRH8rp0zt6QCeMUyJMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747761456; c=relaxed/simple;
	bh=sbBPrcKlpzkqf+EvXrK5q9JFazNaHCusAXL+IFPG8/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uGL3IxKV5DeFfNZN3jEnESjKSbChc0u9YZv9pPPfzQurNg1HH1GrrhgScmDtT/3dV4iuy8s1MB2Bj5on15gxWqZ71j5xHgErehBsI/nuilqDd7K13y84dx70a5S0nNbUvhBYCHGoLiSiYiB9UN/Fwnp1+riXATezTMY8lgJ6FEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ipDHD+9o; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b1a1930a922so4118093a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 10:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747761450; x=1748366250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5sVT6y4YSnGlKGqP6gXqGwI3RzkKYcVE2Jf3DOuL9k=;
        b=ipDHD+9oZkAe/fs9yTZcjn7prXbkHXQRwtRuf1WgXh9r7lBsfCXkNx29YEN3N5ImE+
         X47n4qyXxBqBoxtJFW3bnB6GjQ6MTOxiV1MjXPSOYejDdSRMClIT2u+fTQtQ7tMfUJLD
         Fp5TpXvrfLp7zrfkzggWkqYzEf61X2n/QPPVl9RD3bfQVCirb2CoUVlrKb5S4gKiRN96
         7SPskvnvK2Z6lSGabrj+5pdrR7kpAdvgU/Y0hV3gQKEar8HFcSNEPQVXGyARIreZdMU6
         xQPfa4AMGXYy5c7p9yhu1DFI4N/Rlp8tsZYt/GtfmvRodgSDi+2/woA0DQF0Kh8O/5ao
         nBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747761450; x=1748366250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5sVT6y4YSnGlKGqP6gXqGwI3RzkKYcVE2Jf3DOuL9k=;
        b=sUL3OQBvtYWXLOYMs2UBAxUAr/VzrTkp7LzpOrmBcff43oWLdQSueZiesZigten5jN
         4jw1AHe0xmUoI1c+X/ODjwktGObLY8F3Nnx9xxZA7hfPiB52Bmp6HrjMZ08nUkuSOe2D
         LuKnmt2Ry70nCxefgk+jLHyI7X1jQ9MwsuLn90zAePx28GH8tRivQkgn8iFTovc5Mc/B
         knNQmIzik3IRiong9+MzaSvM/FyyCVM7+H0tIfhsD2sjSUaHnmzdz3tSUMdOjQ3jWily
         a/fD1sD+VKOnhPBZ+r28RL1BC+Jj4I6cYbBwrunBNERy41uTDNmev0Tq/1AjHZX68vLJ
         czIA==
X-Forwarded-Encrypted: i=1; AJvYcCVii6dHKjn6PbsqCUTs8116OU7ozYv2SUqdKR+bAQfVSQcQrXHF0DiB2ckFkMeRotXyOmiajlcGrTDYEUj/@vger.kernel.org
X-Gm-Message-State: AOJu0YzOZDTKm9+alx0SMP8DFsesqMB0GEW2x5g1RWOqPuANltGG70Rf
	wWpbemMpZx0ZRuyRwi2JnBWrPSWIe9gE85zz7nF76edw4KlK3TGq25F+oFnJ5kqKqfGjRIV8FnA
	4A5wnu7Dz8A3BJ8CEvsSpHSQmJcyl8Y6MdiZ1CuAf
X-Gm-Gg: ASbGncsRfx1uIYX0OOt3VCNS7iM4ZNsokkW4GfJTpEuZzPorS1qKedjMxGRGkb26NMl
	kNkSQxQF3zNc+PdJ0FidKqnfLWES5DR8RCVk8im0LPS8Y6G03lep/JTz6mShxzlpX2Cfp+rsOQJ
	0CYTYRLJdDAtzPJqK8TfXWn67gbbkWCC1TGqXT4IP8TdxxNBMZry7L4YMShp4NuS9EMkZffWM0z
	urpVF3a3mlFC70=
X-Google-Smtp-Source: AGHT+IHsHx+xZBgbaLrxW+q7w4hfzF7ci4/OH6M0XOp3DOGWGM+CCsEa6HV3QBQDepNNYYuHQ+OUh/rEI7VYOmFwA/E=
X-Received: by 2002:a17:902:e885:b0:22e:421b:49b1 with SMTP id
 d9443c01a7336-231d45bfc34mr279967565ad.48.1747761450362; Tue, 20 May 2025
 10:17:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <680809f3.050a0220.36a438.0003.GAE@google.com> <tencent_55ACA45C1762977206C3B376C36BA96B8305@qq.com>
 <20250516193122.GS2023217@ZenIV> <20250516232046.GT2023217@ZenIV>
In-Reply-To: <20250516232046.GT2023217@ZenIV>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 20 May 2025 19:17:17 +0200
X-Gm-Features: AX0GCFt0jmQ7RJlWUHtJOlQZuoQ26GKGxmJ1lhYT3ZEgehcfVvrGpSVJNfVcSOQ
Message-ID: <CANp29Y55bJ_3qg+y4jgwuUu7nwvtrfhFEvStzFuoWzS=Xm=3uw@mail.gmail.com>
Subject: Re: [pox on syzbot - again][exfat] exfat_mkdir() breakage on
 corrupted image
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Edward Adam Davis <eadavis@qq.com>, syzbot+321477fad98ea6dd35b7@syzkaller.appspotmail.com, 
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Al,

I've only just seen this email as it landed in my Spam folder for some reas=
on.

On Sat, May 17, 2025 at 1:20=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Fri, May 16, 2025 at 08:31:22PM +0100, Al Viro wrote:
> > On Wed, May 14, 2025 at 06:39:40AM +0800, Edward Adam Davis wrote:
> > > In the reproducer, when calling renameat2(), olddirfd and newdirfd pa=
ssed
> > > are the same value r0, see [1]. This situation should be avoided.
> > >
> > > [1]
> > > renameat2(r0, &(0x7f0000000240)=3D'./bus/file0\x00', r0, &(0x7f000000=
01c0)=3D'./file0\x00', 0x0)
> > >
> > > Reported-by: syzbot+321477fad98ea6dd35b7@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3D321477fad98ea6dd35b=
7
> > > Tested-by: syzbot+321477fad98ea6dd35b7@syzkaller.appspotmail.com
> > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > ---
> > >  fs/namei.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/fs/namei.c b/fs/namei.c
> > > index 84a0e0b0111c..ff843007ca94 100644
> > > --- a/fs/namei.c
> > > +++ b/fs/namei.c
> > > @@ -5013,7 +5013,7 @@ int vfs_rename(struct renamedata *rd)
> > >     struct name_snapshot old_name;
> > >     bool lock_old_subdir, lock_new_subdir;
> > >
> > > -   if (source =3D=3D target)
> > > +   if (source =3D=3D target || old_dir =3D=3D target)
> > >             return 0;
> >
> > What the hell?
> >
> > 1) olddirfd and newdirfd have nothing to do with vfs_rename() - they ar=
e
> > bloody well gone by the time we get there.
> >
> > 2) there's nothing wrong with having the same value passed in both -
> > and it's certainly not a "quietly do nothing".
> >
> > 3) the check added in this patch is... odd.  You are checking essentica=
lly
> > for rename("foo/bar", "foo").  It should fail (-ENOTEMPTY or -EINVAL, d=
epending
> > upon RENAME_EXCHANGE in flags) without having reached vfs_rename().
>
> 4) it's definitely an exfat bug, since we are getting
>         old_dentry->d_parent !=3D target
>         old_dentry->d_parent->d_inode =3D=3D target->d_inode
>         S_ISDIR(target->d_inode->i_mode)
> All objects involved are on the same super_block, which has "exfat" for
> ->s_type->name, so it's exfat ending up with multiple dentries for
> the same directory inode, and once that kind of thing has happened,
> the system is FUBAR.
>
> As for the root cause, almost certainly their ->mkdir() is deciding
> that it has just created a new inode - and ending up with existing one,
> already in icache and already with a dentry attached to it.
>
> <adds BUG_ON(!hlist_empty(&inode->i_dentry)) into exfat_mkdir()>
>
>    [   84.780875] exFAT-fs (loop0): Volume was not properly unmounted. So=
me data may be corrupt. Please run fsck.
>    [   84.781411] exFAT-fs (loop0): Medium has reported failures. Some da=
ta may be lost.
>    [   84.782209] exFAT-fs (loop0): failed to load upcase table (idx : 0x=
00010000, chksum : 0xe62de5da, utbl_chksum : 0xe619d30d)
>    [   84.783272] ------------[ cut here ]------------
>    [   84.783546] kernel BUG at fs/exfat/namei.c:881!
>
> ... and there we go.  exfat_mkdir() getting an existing in-core inode
> and attaching an alias to it, with expected fun results.
>
> For crying out loud, how many times do syzbot folks need to be told that
> getting report to attention of relevant filesystem folks is important?
>
> Subject: [syzbot] [fs?] INFO: task hung in vfs_rename (2)
>
> mentionings of anything exfat-related: 0.
>
> Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
>          linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
>                  viro@zeniv.linux.org.uk
>
> mentionings of anything exfat-related: 0.
>
> In message body:
>   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=3D=
12655204580000)
>
> Why, that does sound like some filesystem bug might be involved
> and presumably the damn thing knows which type had it been.
> <start browser, cut'n'paste the sodding link>
> ... and the very first line is
> fsck.exfat -n exited with status code 4
>
> Result: 3 weeks later it *STILL* hasn't reached the relevant fs
> maintainers.  Could that be a sufficient evidence to convince the
> fine fellows working on syzbot that "you just need to click a few
> links" DOES NOT WORK?
>
> We'd been there several times already.  For relatively polite example,
> see https://lore.kernel.org/all/Y5ZDjuSNuSLJd8Mn@ZenIV/ - I can't be arse=
d
> to explain that again and again, and you don't seem to mind following
> links in email, so...
>

I've checked the code, and there was indeed a bug in our
classification rules, specifically concerning the recognition of the
`syz_mount_image$exfat` call as an indicator for the "exfat"
subsystem. The fix will reach syzbot soon.

Sorry for the inconvenience it has caused.

--=20
Aleksandr

