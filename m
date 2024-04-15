Return-Path: <linux-fsdevel+bounces-16942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 245868A5584
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 16:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908141F22945
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 14:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0ED73163;
	Mon, 15 Apr 2024 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWlTAD6A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8F1433AD;
	Mon, 15 Apr 2024 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192481; cv=none; b=JJMKoflwG2TEjLWeEk7PJhAjeAE1tuM5JtzvoyedmpO8f2n91KCDc2YfW8yBLC9PtQMFgSaCLUdLo0ENFAgMkGciOAhbl3rrfxO75cIoffezRyQbONSwXfZLKrKGlfXPM8rSFeW+v3Z9f/b9twwKhMG/qsm3st5pQioQInKEqb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192481; c=relaxed/simple;
	bh=I13XM/oOMXTIWSLViq/vlsHE+oDy5NBL3yk6E0aLyX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=blYwTfSPGi/HFwBsdRlrwliQS2O2Ssq0kBQGRXXJowEwbKAMG6gnyo2pjD/y3l1xrnp3cQNvfCt+nXCT+uEFeq1dgp6/7/tIAIjKVhirMzqATSiMIlt45VKq/MmXfcEEG00F3ih48ZFQaqj9CgQ2hOw8Qia6WHiW1STiFkHS/Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWlTAD6A; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78ebcfcd3abso278468685a.1;
        Mon, 15 Apr 2024 07:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713192478; x=1713797278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdP5OuUUDcs87pXh/dw1Deyj8T0mk9wfjCCCqRUMku0=;
        b=PWlTAD6AgUdCqrd9mKWrym9nNSbxJSpwp2Wqx/s3cV5ae1576Tm5VKWUNvavciH8E3
         rN4qyXanjSLACPNo5GdcJfJ64qDhrQoeaRZ2pGQ8MWR8JdakdOj7eP9pQtJGf3KMh87U
         nWCqQ9vfgIduOksdulCSJbZUE3/0WBfOJJ4ql+tsBVpWw4ZELfKk1wYRs+NL6OP83c4g
         AwpvtysylL01kUPWKRPPuYP/esv6HYhA8i3l3edHrceqtLeVJIEsWRUx8DblsZuUI7iu
         YckREVVkJnsjapbmF1Aq205Z3O3PWE0wzXRhd+/yVDv+8qwanCoL/DIztUY/hgfBoLKc
         Og0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713192478; x=1713797278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdP5OuUUDcs87pXh/dw1Deyj8T0mk9wfjCCCqRUMku0=;
        b=WYoONwEDRYECvlGQFbQgJnEiaWS3939eWQjNjnnx0twg/lyJLUB/6tsBHItzPZo7lS
         YogsOZQbn0g28R1M6470XIRRgCm2SU5oFfuEChVxIgXw430x2ym3ulOXtR6yh28YL5RM
         u2QfKkPMx0VHoI3EDsylyOY4fbjHCs+8UHduVuIO1iyQglUC97r32B//WHIy4/np45tC
         8H157j/fRZJQcGBsbcu/dpCCv+VP5+vduPRUStkY078X0CH8TCoZKxp/L0q09o7+Fiv5
         +thAOj8sN5DNHbOEaWt3orfy+rZNGPmIEK2S72+Sf9oNu6qOYRN3EJZX0AKOimwzok4K
         kzog==
X-Forwarded-Encrypted: i=1; AJvYcCWBjyLrdcGW2wv+L7SKlJbsTXz88JDufd5T3bGg1srSJLS0xV9alOWP030iQR+xeBV2c9aFE+JrO4gGX0SmCDEukJi+POLVQQOKEsRMUi5WiOhPNDi9fjGPhLpM0C0nB+d90EDTWzhWZxt+PQ==
X-Gm-Message-State: AOJu0Ywl7ST/duNnetCWbI6/owvMS8USA6GLh9Co1aB9jBIRgejyYHpa
	TSTwve3Ir7hG4F1zzqKgtBR+A2nhAgDoLJly0DpVV+HLTKYW7NemzsZqIqSm0oRwVCEQcmQogd1
	2Zc5f3TXJCYvHf8wXuA+zXf5lsqk=
X-Google-Smtp-Source: AGHT+IFXBXviIp8bhU13C8T8lSfHKPASLhMZCZr5YCmvZvKkE8Sp56JW7pcBIf1nVRHkDz/Van/bYQPDwNtNoDtbkzo=
X-Received: by 2002:a0c:fc06:0:b0:69b:2897:4fc4 with SMTP id
 z6-20020a0cfc06000000b0069b28974fc4mr8856089qvo.58.1713192478430; Mon, 15 Apr
 2024 07:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000095bb400615f4b0ed@google.com> <20240413084519.1774-1-hdanton@sina.com>
 <CAOQ4uxhh4Tm6j+Hh+F2aQFuHfpCh_kJ10FYTfXo+AxoP4m01ag@mail.gmail.com> <20240415140333.y44rk5ggbadv4oej@quack3>
In-Reply-To: <20240415140333.y44rk5ggbadv4oej@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 15 Apr 2024 17:47:45 +0300
Message-ID: <CAOQ4uxiG_7HGESMNkrJ7QmsXbgOneUGpMjx8vob87kntwTzUTQ@mail.gmail.com>
Subject: Re: [syzbot] Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in fsnotify
To: Jan Kara <jack@suse.cz>
Cc: Hillf Danton <hdanton@sina.com>, 
	syzbot <syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com>, 
	linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 5:03=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 13-04-24 12:32:32, Amir Goldstein wrote:
> > On Sat, Apr 13, 2024 at 11:45=E2=80=AFAM Hillf Danton <hdanton@sina.com=
> wrote:
> > > On Fri, 12 Apr 2024 23:42:19 -0700 Amir Goldstein
> > > > On Sat, Apr 13, 2024 at 4:41=3DE2=3D80=3DAFAM Hillf Danton <hdanton=
@sina.com> wrote:
> > > > > On Thu, 11 Apr 2024 01:11:20 -0700
> > > > > > syzbot found the following issue on:
> > > > > >
> > > > > > HEAD commit:    6ebf211bb11d Add linux-next specific files for =
20240410
> > > > > > git tree:       linux-next
> > > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D3D1=
621af9d180000
> > > > >
> > > > > #syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/li=
nux-next.git  6ebf211bb11d
> > > > >
> > > > > --- x/fs/notify/fsnotify.c
> > > > > +++ y/fs/notify/fsnotify.c
> > > > > @@ -101,8 +101,8 @@ void fsnotify_sb_delete(struct super_blo
> > > > >         wait_var_event(fsnotify_sb_watched_objects(sb),
> > > > >                        !atomic_long_read(fsnotify_sb_watched_obje=
cts(sb)));
> > > > >         WARN_ON(fsnotify_sb_has_priority_watchers(sb, FSNOTIFY_PR=
IO_CONTENT));
> > > > > -       WARN_ON(fsnotify_sb_has_priority_watchers(sb,
> > > > > -                                                 FSNOTIFY_PRIO_P=
RE_CONTENT));
> > > > > +       WARN_ON(fsnotify_sb_has_priority_watchers(sb, FSNOTIFY_PR=
IO_PRE_CONTENT));
> > > > > +       synchronize_srcu(&fsnotify_mark_srcu);
> > > > >         kfree(sbinfo);
> > > > >  }
> > > > >
> > > > > @@ -499,7 +499,7 @@ int fsnotify(__u32 mask, const void *dat
> > > > >  {
> > > > >         const struct path *path =3D3D fsnotify_data_path(data, da=
ta_type);
> > > > >         struct super_block *sb =3D3D fsnotify_data_sb(data, data_=
type);
> > > > > -       struct fsnotify_sb_info *sbinfo =3D3D fsnotify_sb_info(sb=
);
> > > > > +       struct fsnotify_sb_info *sbinfo;
> > > > >         struct fsnotify_iter_info iter_info =3D {};
> > > > >         struct mount *mnt =3D3D NULL;
> > > > >         struct inode *inode2 =3D3D NULL;
> > > > > @@ -529,6 +529,8 @@ int fsnotify(__u32 mask, const void *dat
> > > > >                 inode2_type =3D3D FSNOTIFY_ITER_TYPE_PARENT;
> > > > >         }
> > > > >
> > > > > +       iter_info.srcu_idx =3D3D srcu_read_lock(&fsnotify_mark_sr=
cu);
> > > > > +       sbinfo =3D3D fsnotify_sb_info(sb);
> > > > >         /*
> > > > >          * Optimization: srcu_read_lock() has a memory barrier wh=
ich can
> > > > >          * be expensive.  It protects walking the *_fsnotify_mark=
s lists.
> > > >
> > > >
> > > > See comment above. This kills the optimization.
> > > > It is not worth letting all the fsnotify hooks suffer the consequen=
ce
> > > > for the edge case of calling fsnotify hook during fs shutdown.
> > >
> > > Say nothing before reading your fix.
> > > >
> > > > Also, fsnotify_sb_info(sb) in fsnotify_sb_has_priority_watchers()
> > > > is also not protected and using srcu_read_lock() there completely
> > > > nullifies the purpose of fsnotify_sb_info.
> > > >
> > > > Here is a simplified fix for fsnotify_sb_error() rebased on the
> > > > pending mm fixes for this syzbot boot failure:
> > > >
> > > > #syz test: https://github.com/amir73il/linux fsnotify-fixes
> > >
> > > Feel free to post your patch at lore because not everyone has
> > > access to sites like github.
> > > >
> > > > Jan,
> > > >
> > > > I think that all the functions called from fs shutdown context
> > > > should observe that SB_ACTIVE is cleared but wasn't sure?
> > >
> > > If you composed fix based on SB_ACTIVE that is cleared in
> > > generic_shutdown_super() with &sb->s_umount held for write,
> > > I wonder what simpler serialization than srcu you could
> > > find/create in fsnotify.
> >
> > As far as I can tell there is no need for serialisation.
> >
> > The problem is that fsnotify_sb_error() can be called from the
> > context of ->put_super() call from generic_shutdown_super().
> >
> > It's true that in the repro the thread calling fsnotify_sb_error()
> > in the worker thread running quota deferred work from put_super()
> > but I think there are sufficient barriers for this worker thread to
> > observer the cleared SB_ACTIVE flag.
> >
> > Anyway, according to syzbot, repro does not trigger the UAF
> > with my last fix.
> >
> > To be clear, any fsnotify_sb_error() that is a result of a user operati=
on
> > would be holding an active reference to sb so cannot race with
> > fsnotify_sb_delete(), but I am not sure that same is true for ext4
> > worker threads.
> >
> > Jan,
> >
> > You wrote that "In theory these two calls can even run in parallel
> > and fsnotify() can be holding fsnotify_sb_info pointer while
> > fsnotify_sb_delete() is freeing".
> >
> > Can you give an example of this case?
>
> Yeah, basically what Hilf writes:
>
> Task 1                                  Task 2
>   umount()                              some delayed work, transaction
>                                           commit, whatever is still runni=
ng
>                                           before ext4_put_super() complet=
es
>     ...                                     ext4_error()
>                                               fsnotify_sb_error()
>                                                 fsnotify()
>                                                   fetches fsnotify_sb_inf=
o
>     generic_shutdown_super()
>       fsnotify_sb_delete()
>         frees fsnotify_sb_info

OK, so what do you say about Hillf's fix patch?

Maybe it is ok to let go of the optimization in fsnotify(), considering
that we now have stronger optimizations in the inline hooks and
in __fsnotify_parent()?

I think that Hillf's patch is missing setting s_fsnotify_info to NULL?

 @@ -101,8 +101,8 @@ void fsnotify_sb_delete(struct super_blo
         wait_var_event(fsnotify_sb_watched_objects(sb),
                        !atomic_long_read(fsnotify_sb_watched_objects(sb)))=
;
         WARN_ON(fsnotify_sb_has_priority_watchers(sb, FSNOTIFY_PRIO_CONTEN=
T));
+       WRITE_ONCE(sb->s_fsnotify_info, NULL);
+       synchronize_srcu(&fsnotify_mark_srcu);
         kfree(sbinfo);
 }

Thanks,
Amir.

