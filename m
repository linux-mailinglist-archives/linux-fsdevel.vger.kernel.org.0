Return-Path: <linux-fsdevel+bounces-16855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7568A3BF2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 11:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A774E1F21E97
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 09:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A94F335D3;
	Sat, 13 Apr 2024 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y34OVYHN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5115024A0E;
	Sat, 13 Apr 2024 09:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713000766; cv=none; b=D5/wnPgHRdz4MvsZuPhYRrxGj9nTFyotZ4Bl1kG0KqiOGPyW9qookg4ZJ7T+RrmxlitfgHmcO5R2Q5u9L8XqFUYTjWIrRZDLY9iavKWeU58FGRTZiGsSygieeVfsOMsCC+ghYqZMZRNp6JoLfxG5lIJFBUa0ce/WmrUw0EvyaGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713000766; c=relaxed/simple;
	bh=ddNnbgBOuapvOvgcOJYBd1o4NBMq0movs+vGmy0x0kE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/tC0jHp4snWndsyxQxroJh3uWvyt8cs2lqqv4hCszOWv17TieyDmmKc8z1/BXFOw8LOAhx5CwWPEiDkYmAOxs8xycoSUUNizkqELXmmx/ZVeHJXNr3m6VTRDeC4h1dz58MzIMDkf8u3+JynXyFXWWLonIlwIPG7tZR5VQtfVWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y34OVYHN; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-69b628c4893so5027026d6.0;
        Sat, 13 Apr 2024 02:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713000764; x=1713605564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8KkEs4o5JCi1eGvVZIKnGaQy4oo0ec50YtQ/IXylC4=;
        b=Y34OVYHNtqqkfHBBIM7iAjDlBIKXXIA3DENlRzy4X6BUhyqfFYBHJMSxF0XJYHD+xK
         pzP/TM4U7bfIY4h3p8nOzK6CKM1kP0hQrJ/8QNg7MPwksG6x+H7BFFvfQ2rOa71KdonX
         oNPGXf4Hc8cPj7JIB72CNcpZU/GxSarkFC8iU8mEYI4rgvWk9wYvI9qXtI5iulUlK+7u
         QtRJEkeHWdoXMP5Xx9M2xKv8YT+hTb6kwL+tjFYRqcobchX3QS460hSMkI76VuNDdVWP
         iwCVC1Wup5351Fz/G5FTuAr2pc9TTeCniwKSydEKGOMT+7W3+y288wSWRmbegXGK6ACs
         1hBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713000764; x=1713605564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8KkEs4o5JCi1eGvVZIKnGaQy4oo0ec50YtQ/IXylC4=;
        b=BPcIOVhXqISHOlkRjmlbNo+2tXUyu0+2OR71CUuCtvXF8wgxDMqFVYajugL1+lPSL2
         8RtZJKISsbn9p+LuLC+qRfkaH2iq6KIcRVqDzc/9FV8uPRDcTCbpZboTFKIgmLtlS+ja
         oHJcpOe7ux/HdmTzmVuQeJ6tilwhGzCEORdVcSI5u58S844XM9armnOEWwV0NTgIYnzI
         7+CsNkyUkZHTIeuOff0X4eZBN9iK1o7+jqEq/T/O//1sgidKbO0vLyPz3svKNUG1bjUy
         w8fXEyHLmCMvrmKuPy2z3DI7DrNlTziYcii5Taeu/tYrNgU8G/zB5BRXDNkKeFZHUocS
         BZ/w==
X-Forwarded-Encrypted: i=1; AJvYcCWnshEihTuQfFFM0vxkcackIE91qR4nid1WyO240lQwZM52p2scWwbtojrJTtjKqSpUUYDDCFkd83jaDfEtvPwP3iCItIe2zBmNo9xHA/IpfER1BgmSmVk+GZE0SCFV8EfQwIc6Nm3SoKQGmw==
X-Gm-Message-State: AOJu0YyuH6FDOwSDwYEkmcoV9BKXI/lFVDOQp+/Q8cUs0pm4WuGU2Bt8
	eNmpTofcJxf93lEwLz1xcZtL0lIr7gzMxZsAdFbRmLf4pXhiDS/+fAD1Cz90fYFCiW04Z5pXSfL
	o5xuddpzvTKxBHwWpJ5W49jQQvwk=
X-Google-Smtp-Source: AGHT+IF0fOtuQFUJte8RIpaMSP+5E/TTaMvh6g5DfaAIXPtgMPYzUQk0jmeWi7D3FX3Ee8WAlcP+IKUq780ipVbO4go=
X-Received: by 2002:ad4:5519:0:b0:69b:6b28:f941 with SMTP id
 pz25-20020ad45519000000b0069b6b28f941mr452187qvb.20.1713000764088; Sat, 13
 Apr 2024 02:32:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000095bb400615f4b0ed@google.com> <20240413084519.1774-1-hdanton@sina.com>
In-Reply-To: <20240413084519.1774-1-hdanton@sina.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 13 Apr 2024 12:32:32 +0300
Message-ID: <CAOQ4uxhh4Tm6j+Hh+F2aQFuHfpCh_kJ10FYTfXo+AxoP4m01ag@mail.gmail.com>
Subject: Re: [syzbot] Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in fsnotify
To: Hillf Danton <hdanton@sina.com>, Jan Kara <jack@suse.cz>
Cc: syzbot <syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com>, 
	linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 11:45=E2=80=AFAM Hillf Danton <hdanton@sina.com> wr=
ote:
>
> On Fri, 12 Apr 2024 23:42:19 -0700 Amir Goldstein
> > On Sat, Apr 13, 2024 at 4:41=3DE2=3D80=3DAFAM Hillf Danton <hdanton@sin=
a.com> wrote:
> > >
> > > On Thu, 11 Apr 2024 01:11:20 -0700
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    6ebf211bb11d Add linux-next specific files for 2024=
0410
> > > > git tree:       linux-next
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D3D1621a=
f9d180000
> > >
> > > #syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-=
next.git  6ebf211bb11d
> > >
> > > --- x/fs/notify/fsnotify.c
> > > +++ y/fs/notify/fsnotify.c
> > > @@ -101,8 +101,8 @@ void fsnotify_sb_delete(struct super_blo
> > >         wait_var_event(fsnotify_sb_watched_objects(sb),
> > >                        !atomic_long_read(fsnotify_sb_watched_objects(=
sb)));
> > >         WARN_ON(fsnotify_sb_has_priority_watchers(sb, FSNOTIFY_PRIO_C=
ONTENT));
> > > -       WARN_ON(fsnotify_sb_has_priority_watchers(sb,
> > > -                                                 FSNOTIFY_PRIO_PRE_C=
ONTENT));
> > > +       WARN_ON(fsnotify_sb_has_priority_watchers(sb, FSNOTIFY_PRIO_P=
RE_CONTENT));
> > > +       synchronize_srcu(&fsnotify_mark_srcu);
> > >         kfree(sbinfo);
> > >  }
> > >
> > > @@ -499,7 +499,7 @@ int fsnotify(__u32 mask, const void *dat
> > >  {
> > >         const struct path *path =3D3D fsnotify_data_path(data, data_t=
ype);
> > >         struct super_block *sb =3D3D fsnotify_data_sb(data, data_type=
);
> > > -       struct fsnotify_sb_info *sbinfo =3D3D fsnotify_sb_info(sb);
> > > +       struct fsnotify_sb_info *sbinfo;
> > >         struct fsnotify_iter_info iter_info =3D {};
> > >         struct mount *mnt =3D3D NULL;
> > >         struct inode *inode2 =3D3D NULL;
> > > @@ -529,6 +529,8 @@ int fsnotify(__u32 mask, const void *dat
> > >                 inode2_type =3D3D FSNOTIFY_ITER_TYPE_PARENT;
> > >         }
> > >
> > > +       iter_info.srcu_idx =3D3D srcu_read_lock(&fsnotify_mark_srcu);
> > > +       sbinfo =3D3D fsnotify_sb_info(sb);
> > >         /*
> > >          * Optimization: srcu_read_lock() has a memory barrier which =
can
> > >          * be expensive.  It protects walking the *_fsnotify_marks li=
sts.
> >
> >
> > See comment above. This kills the optimization.
> > It is not worth letting all the fsnotify hooks suffer the consequence
> > for the edge case of calling fsnotify hook during fs shutdown.
>
> Say nothing before reading your fix.
> >
> > Also, fsnotify_sb_info(sb) in fsnotify_sb_has_priority_watchers()
> > is also not protected and using srcu_read_lock() there completely
> > nullifies the purpose of fsnotify_sb_info.
> >
> > Here is a simplified fix for fsnotify_sb_error() rebased on the
> > pending mm fixes for this syzbot boot failure:
> >
> > #syz test: https://github.com/amir73il/linux fsnotify-fixes
>
> Feel free to post your patch at lore because not everyone has
> access to sites like github.
> >
> > Jan,
> >
> > I think that all the functions called from fs shutdown context
> > should observe that SB_ACTIVE is cleared but wasn't sure?
>
> If you composed fix based on SB_ACTIVE that is cleared in
> generic_shutdown_super() with &sb->s_umount held for write,
> I wonder what simpler serialization than srcu you could
> find/create in fsnotify.

As far as I can tell there is no need for serialisation.

The problem is that fsnotify_sb_error() can be called from the
context of ->put_super() call from generic_shutdown_super().

It's true that in the repro the thread calling fsnotify_sb_error()
in the worker thread running quota deferred work from put_super()
but I think there are sufficient barriers for this worker thread to
observer the cleared SB_ACTIVE flag.

Anyway, according to syzbot, repro does not trigger the UAF
with my last fix.

To be clear, any fsnotify_sb_error() that is a result of a user operation
would be holding an active reference to sb so cannot race with
fsnotify_sb_delete(), but I am not sure that same is true for ext4
worker threads.

Jan,

You wrote that "In theory these two calls can even run in parallel
and fsnotify() can be holding fsnotify_sb_info pointer while
fsnotify_sb_delete() is freeing".

Can you give an example of this case?

Thanks,
Amir.

