Return-Path: <linux-fsdevel+bounces-17032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D648A68FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 12:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75C21F21E78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 10:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2437128385;
	Tue, 16 Apr 2024 10:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnZLsGic"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592D4763F1;
	Tue, 16 Apr 2024 10:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264487; cv=none; b=Ai4D9UzEpxG66QUyPzvPzwjo0u6Wmhc472ZspUTNdIe956c3X2t8z1vCWqZ/K7NtJLsoPDrfUg+4zFM8gjomvMSMdkRCOtlCezND1rF96dD5as4Hidw3DAVB6ExAXuMQi6YFVq827jeO6uvt2ZDszI6aGHUmeQMf+ZQc7oKkK/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264487; c=relaxed/simple;
	bh=9KitHo46rzgloAkG8g9f8wQrd2pEve9HR9V9C+Fs41M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJ5zry8/BzOKOHxsZAfETaxUBgHncb/pWEfUbvFLNHHSqvSi7lURJbAAM/qyzP+pE+MWb47T7lZndcNHRufmhOjBG55KqgGq7VVZ9KbsGRaN9yE1uwa3apD0pDAt88z8gn1GIYpGwkC39VdOyUmhxLPZQr61WcYwMLA/5c/tLi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnZLsGic; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-69b730fc89bso4572126d6.1;
        Tue, 16 Apr 2024 03:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713264484; x=1713869284; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GtHrFqZ+ctDLTlIrzhNd273vIxcdhh97VrWsjHMZ3/I=;
        b=EnZLsGicrkGuDHCd/xen+aEKsK6PSGzVY2ASu0+H8SUhuAjuR8diZULD3Zx5X85MB1
         A5d0AjJUsaCdXiT30RqgBEfrFMmbAURyFB7PoERoB7svBfc1UWguZsg7u8eFB2fdQz0z
         WXE+QrTVf8FPMOx9J5OTtBuOanPQaL8p+zWZFt/o4HIhzQkDIsPUjlwuQQULfUqKD9Cq
         p9enPJE26hFnh7XOZhkw6g+dROlTr0ABIZ2Ew2q8FCpc4zPhr4/n6QifsVy7F4J9Qvfx
         BDLqPiPddVvlSRchiK74mO5n1ESD1bUOKziHJga1Rfnyq59bItB4BbmJyWGsnFnS0zpo
         auQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713264484; x=1713869284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GtHrFqZ+ctDLTlIrzhNd273vIxcdhh97VrWsjHMZ3/I=;
        b=tuS+7RWjV/kRt301pIY1fMZJv7rU+US0ro+rRt3TzXRxvI4EMN5cuV0kXuF1Tcvz9N
         jW/5igsItAx6bjcLDNNNXveGFmK11Y4MQJx5i9a2SaJZotMKZFlBQ1qqbGdourl5HwIb
         z8abf+IB9amonTrxBRtB1l60eYAGurQEkW/zakF4xMRltrbgsjMWcKFoP5vIGe9JTgAB
         siy71iYgnMdddQSRoIq4e/zaJA3dxX+9RyKAVB/E4fGiN6HT6Ah0xgJNUJ4QNXjRgTMi
         A+kFWLQRLrDOHqqMZkI8LTZbXGQ0PiQg4tTiSJFRLxkiq9EQAUqKokKDACfV1DaLzUEv
         +aYA==
X-Forwarded-Encrypted: i=1; AJvYcCU/1y2QyZCEWvqA3ox+Sf3TAkjDvNEFX6j7g2kxXmYCe7vOLEOqTpPV8MVvKOkc687H2UNsgAE9W0NAXSw31JdVEbMKikgsT5w0eNEj90P41sPKEnB5v/U8x/VIqtmvw937yYMaUIC7kvWahQ==
X-Gm-Message-State: AOJu0YyQJ9NoF8z/JHYieVWVR8ZAYcT6Pj+pG0JHMi8T8NsPIs1LnKHD
	g4N3Ne0ixozv1cS7BgsrMV29Iql5BHXc5czPq5tiE9Y8M0vrMiZyjI3PY1cnD1b8VbqZJrKn3Wy
	GmiREN6OY+DggU/980XzW1i+eT2A=
X-Google-Smtp-Source: AGHT+IEUaaYdLLV/b6uuF320rv2A2sxcDoueTQbvOnkmcbozLRyCmk86GS8q34k3wH5ysHrVHsyZf7gy7F8PeetZz5o=
X-Received: by 2002:ad4:57ae:0:b0:699:4b0b:4228 with SMTP id
 g14-20020ad457ae000000b006994b0b4228mr11935844qvx.62.1713264484226; Tue, 16
 Apr 2024 03:48:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000095bb400615f4b0ed@google.com> <20240413084519.1774-1-hdanton@sina.com>
 <CAOQ4uxhh4Tm6j+Hh+F2aQFuHfpCh_kJ10FYTfXo+AxoP4m01ag@mail.gmail.com>
 <20240415140333.y44rk5ggbadv4oej@quack3> <CAOQ4uxiG_7HGESMNkrJ7QmsXbgOneUGpMjx8vob87kntwTzUTQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxiG_7HGESMNkrJ7QmsXbgOneUGpMjx8vob87kntwTzUTQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 16 Apr 2024 13:47:53 +0300
Message-ID: <CAOQ4uxg_qkqos7pXaTRAL++wYfuWZCWVcn64XK2g=GKR3zpOzQ@mail.gmail.com>
Subject: Re: [syzbot] Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in fsnotify
To: Jan Kara <jack@suse.cz>
Cc: Hillf Danton <hdanton@sina.com>, 
	syzbot <syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com>, 
	linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000fd4afa0616347898"

--000000000000fd4afa0616347898
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 5:47=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Mon, Apr 15, 2024 at 5:03=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >
> > On Sat 13-04-24 12:32:32, Amir Goldstein wrote:
> > > On Sat, Apr 13, 2024 at 11:45=E2=80=AFAM Hillf Danton <hdanton@sina.c=
om> wrote:
> > > > On Fri, 12 Apr 2024 23:42:19 -0700 Amir Goldstein
> > > > > On Sat, Apr 13, 2024 at 4:41=3DE2=3D80=3DAFAM Hillf Danton <hdant=
on@sina.com> wrote:
> > > > > > On Thu, 11 Apr 2024 01:11:20 -0700
> > > > > > > syzbot found the following issue on:
> > > > > > >
> > > > > > > HEAD commit:    6ebf211bb11d Add linux-next specific files fo=
r 20240410
> > > > > > > git tree:       linux-next
> > > > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D3=
D1621af9d180000
> > > > > >
> > > > > > #syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/=
linux-next.git  6ebf211bb11d
> > > > > >
> > > > > > --- x/fs/notify/fsnotify.c
> > > > > > +++ y/fs/notify/fsnotify.c
> > > > > > @@ -101,8 +101,8 @@ void fsnotify_sb_delete(struct super_blo
> > > > > >         wait_var_event(fsnotify_sb_watched_objects(sb),
> > > > > >                        !atomic_long_read(fsnotify_sb_watched_ob=
jects(sb)));
> > > > > >         WARN_ON(fsnotify_sb_has_priority_watchers(sb, FSNOTIFY_=
PRIO_CONTENT));
> > > > > > -       WARN_ON(fsnotify_sb_has_priority_watchers(sb,
> > > > > > -                                                 FSNOTIFY_PRIO=
_PRE_CONTENT));
> > > > > > +       WARN_ON(fsnotify_sb_has_priority_watchers(sb, FSNOTIFY_=
PRIO_PRE_CONTENT));
> > > > > > +       synchronize_srcu(&fsnotify_mark_srcu);
> > > > > >         kfree(sbinfo);
> > > > > >  }
> > > > > >
> > > > > > @@ -499,7 +499,7 @@ int fsnotify(__u32 mask, const void *dat
> > > > > >  {
> > > > > >         const struct path *path =3D3D fsnotify_data_path(data, =
data_type);
> > > > > >         struct super_block *sb =3D3D fsnotify_data_sb(data, dat=
a_type);
> > > > > > -       struct fsnotify_sb_info *sbinfo =3D3D fsnotify_sb_info(=
sb);
> > > > > > +       struct fsnotify_sb_info *sbinfo;
> > > > > >         struct fsnotify_iter_info iter_info =3D {};
> > > > > >         struct mount *mnt =3D3D NULL;
> > > > > >         struct inode *inode2 =3D3D NULL;
> > > > > > @@ -529,6 +529,8 @@ int fsnotify(__u32 mask, const void *dat
> > > > > >                 inode2_type =3D3D FSNOTIFY_ITER_TYPE_PARENT;
> > > > > >         }
> > > > > >
> > > > > > +       iter_info.srcu_idx =3D3D srcu_read_lock(&fsnotify_mark_=
srcu);
> > > > > > +       sbinfo =3D3D fsnotify_sb_info(sb);
> > > > > >         /*
> > > > > >          * Optimization: srcu_read_lock() has a memory barrier =
which can
> > > > > >          * be expensive.  It protects walking the *_fsnotify_ma=
rks lists.
> > > > >
> > > > >
> > > > > See comment above. This kills the optimization.
> > > > > It is not worth letting all the fsnotify hooks suffer the consequ=
ence
> > > > > for the edge case of calling fsnotify hook during fs shutdown.
> > > >
> > > > Say nothing before reading your fix.
> > > > >
> > > > > Also, fsnotify_sb_info(sb) in fsnotify_sb_has_priority_watchers()
> > > > > is also not protected and using srcu_read_lock() there completely
> > > > > nullifies the purpose of fsnotify_sb_info.
> > > > >
> > > > > Here is a simplified fix for fsnotify_sb_error() rebased on the
> > > > > pending mm fixes for this syzbot boot failure:
> > > > >
> > > > > #syz test: https://github.com/amir73il/linux fsnotify-fixes
> > > >
> > > > Feel free to post your patch at lore because not everyone has
> > > > access to sites like github.
> > > > >
> > > > > Jan,
> > > > >
> > > > > I think that all the functions called from fs shutdown context
> > > > > should observe that SB_ACTIVE is cleared but wasn't sure?
> > > >
> > > > If you composed fix based on SB_ACTIVE that is cleared in
> > > > generic_shutdown_super() with &sb->s_umount held for write,
> > > > I wonder what simpler serialization than srcu you could
> > > > find/create in fsnotify.
> > >
> > > As far as I can tell there is no need for serialisation.
> > >
> > > The problem is that fsnotify_sb_error() can be called from the
> > > context of ->put_super() call from generic_shutdown_super().
> > >
> > > It's true that in the repro the thread calling fsnotify_sb_error()
> > > in the worker thread running quota deferred work from put_super()
> > > but I think there are sufficient barriers for this worker thread to
> > > observer the cleared SB_ACTIVE flag.
> > >
> > > Anyway, according to syzbot, repro does not trigger the UAF
> > > with my last fix.
> > >
> > > To be clear, any fsnotify_sb_error() that is a result of a user opera=
tion
> > > would be holding an active reference to sb so cannot race with
> > > fsnotify_sb_delete(), but I am not sure that same is true for ext4
> > > worker threads.
> > >
> > > Jan,
> > >
> > > You wrote that "In theory these two calls can even run in parallel
> > > and fsnotify() can be holding fsnotify_sb_info pointer while
> > > fsnotify_sb_delete() is freeing".
> > >
> > > Can you give an example of this case?
> >
> > Yeah, basically what Hilf writes:
> >
> > Task 1                                  Task 2
> >   umount()                              some delayed work, transaction
> >                                           commit, whatever is still run=
ning
> >                                           before ext4_put_super() compl=
etes
> >     ...                                     ext4_error()
> >                                               fsnotify_sb_error()
> >                                                 fsnotify()
> >                                                   fetches fsnotify_sb_i=
nfo
> >     generic_shutdown_super()
> >       fsnotify_sb_delete()
> >         frees fsnotify_sb_info
>
> OK, so what do you say about Hillf's fix patch?
>
> Maybe it is ok to let go of the optimization in fsnotify(), considering
> that we now have stronger optimizations in the inline hooks and
> in __fsnotify_parent()?
>
> I think that Hillf's patch is missing setting s_fsnotify_info to NULL?
>
>  @@ -101,8 +101,8 @@ void fsnotify_sb_delete(struct super_blo
>          wait_var_event(fsnotify_sb_watched_objects(sb),
>                         !atomic_long_read(fsnotify_sb_watched_objects(sb)=
));
>          WARN_ON(fsnotify_sb_has_priority_watchers(sb, FSNOTIFY_PRIO_CONT=
ENT));
> +       WRITE_ONCE(sb->s_fsnotify_info, NULL);
> +       synchronize_srcu(&fsnotify_mark_srcu);
>          kfree(sbinfo);
>  }
>

I reworked Hillf's patch so it won't break the optimizations for
the common case and added setting s_fsnotify_info to NULL (attached).

Let's see what syzbot has to say:

#syz test: https://github.com/amir73il/linux fsnotify-fixes

Thanks,
Amir.

--000000000000fd4afa0616347898
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-fsnotify-fix-UAF-from-FS_ERROR-event-on-a-shutting-d.patch"
Content-Disposition: attachment; 
	filename="0001-fsnotify-fix-UAF-from-FS_ERROR-event-on-a-shutting-d.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lv29dqjx0>
X-Attachment-Id: f_lv29dqjx0

RnJvbSA0ZTQyZTZiNjZjMjRlNDJiNDA4OWIxMjEyZjBlY2NiMDFiN2I3ZWRhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBUaHUsIDExIEFwciAyMDI0IDE4OjU5OjA4ICswMzAwClN1YmplY3Q6IFtQQVRDSF0gZnNu
b3RpZnk6IGZpeCBVQUYgZnJvbSBGU19FUlJPUiBldmVudCBvbiBhIHNodXR0aW5nIGRvd24KIGZp
bGVzeXN0ZW0KClByb3RlY3QgYWdhaW5zdCB1c2UgYWZ0ZXIgZnJlZSB3aGVuIGZpbGVzeXN0ZW0g
Y2FsbHMgZnNub3RpZnlfc2JfZXJyb3IoKQpkdXJpbmcgZnMgc2h1dGRvd24uCgpmc25vdGlmeV9z
Yl9lcnJvcigpIG1heSBiZSBjYWxsZWQgd2l0aG91dCBhbiBzX2FjdGl2ZSByZWZlcmVuY2UsIHNv
IHVzZQpTUkNVIHRvIHN5bmNocm9uaXplIGFjY2VzcyB0byBmc25vdGlmeV9zYl9pbmZvKCkgaW4g
dGhpcyBjYXNlLgoKUmVwb3J0ZWQtYnk6IHN5emJvdCs1ZTNmOWIyYTY3YjQ1ZjE2ZDRlNkBzeXpr
YWxsZXIuYXBwc3BvdG1haWwuY29tClN1Z2dlc3RlZC1ieTogSGlsbGYgRGFudG9uIDxoZGFudG9u
QHNpbmEuY29tPgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1mc2RldmVsLzIw
MjQwNDEzMDE0MDMzLjE3MjItMS1oZGFudG9uQHNpbmEuY29tLwpGaXhlczogMDdhM2I4ZDBiZjcy
ICgiZnNub3RpZnk6IGxhenkgYXR0YWNoIGZzbm90aWZ5X3NiX2luZm8gc3RhdGUgdG8gc2IiKQpT
aWduZWQtb2ZmLWJ5OiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgotLS0KIGZz
L25vdGlmeS9mc25vdGlmeS5jICAgICAgICAgICAgIHwgMTQgKysrKysrKysrKysrLS0KIGluY2x1
ZGUvbGludXgvZnNub3RpZnlfYmFja2VuZC5oIHwgIDMgKysrCiAyIGZpbGVzIGNoYW5nZWQsIDE1
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvbm90aWZ5L2Zz
bm90aWZ5LmMgYi9mcy9ub3RpZnkvZnNub3RpZnkuYwppbmRleCAyYWU5NjVlZjM3ZTguLmVjOWI1
MzVkMzMzYSAxMDA2NDQKLS0tIGEvZnMvbm90aWZ5L2Zzbm90aWZ5LmMKKysrIGIvZnMvbm90aWZ5
L2Zzbm90aWZ5LmMKQEAgLTEwMyw2ICsxMDMsOCBAQCB2b2lkIGZzbm90aWZ5X3NiX2RlbGV0ZShz
dHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiKQogCVdBUk5fT04oZnNub3RpZnlfc2JfaGFzX3ByaW9yaXR5
X3dhdGNoZXJzKHNiLCBGU05PVElGWV9QUklPX0NPTlRFTlQpKTsKIAlXQVJOX09OKGZzbm90aWZ5
X3NiX2hhc19wcmlvcml0eV93YXRjaGVycyhzYiwKIAkJCQkJCSAgRlNOT1RJRllfUFJJT19QUkVf
Q09OVEVOVCkpOworCVdSSVRFX09OQ0Uoc2ItPnNfZnNub3RpZnlfaW5mbywgTlVMTCk7CisJc3lu
Y2hyb25pemVfc3JjdSgmZnNub3RpZnlfbWFya19zcmN1KTsKIAlrZnJlZShzYmluZm8pOwogfQog
CkBAIC01MDYsNiArNTA4LDcgQEAgaW50IGZzbm90aWZ5KF9fdTMyIG1hc2ssIGNvbnN0IHZvaWQg
KmRhdGEsIGludCBkYXRhX3R5cGUsIHN0cnVjdCBpbm9kZSAqZGlyLAogCXN0cnVjdCBkZW50cnkg
Km1vdmVkOwogCWludCBpbm9kZTJfdHlwZTsKIAlpbnQgcmV0ID0gMDsKKwlib29sIHNiX2FjdGl2
ZV9yZWYgPSAhKG1hc2sgJiBGU19FVkVOVFNfUE9TU19PTl9TSFVURE9XTik7CiAJX191MzIgdGVz
dF9tYXNrLCBtYXJrc19tYXNrOwogCiAJaWYgKHBhdGgpCkBAIC01MzUsOCArNTM4LDEwIEBAIGlu
dCBmc25vdGlmeShfX3UzMiBtYXNrLCBjb25zdCB2b2lkICpkYXRhLCBpbnQgZGF0YV90eXBlLCBz
dHJ1Y3QgaW5vZGUgKmRpciwKIAkgKiBIb3dldmVyLCBpZiB3ZSBkbyBub3Qgd2FsayB0aGUgbGlz
dHMsIHdlIGRvIG5vdCBoYXZlIHRvIGRvCiAJICogU1JDVSBiZWNhdXNlIHdlIGhhdmUgbm8gcmVm
ZXJlbmNlcyB0byBhbnkgb2JqZWN0cyBhbmQgZG8gbm90CiAJICogbmVlZCBTUkNVIHRvIGtlZXAg
dGhlbSAiYWxpdmUiLgorCSAqIFdlIG9ubHkgbmVlZCBTUkNVIHRvIGtlZXAgc2JpbmZvICJhbGl2
ZSIgZm9yIGV2ZW50cyBwb3NzaWJsZQorCSAqIGR1cmluZyBzaHV0ZG93biAoZS5nLiBGU19FUlJP
UikuCiAJICovCi0JaWYgKCghc2JpbmZvIHx8ICFzYmluZm8tPnNiX21hcmtzKSAmJgorCWlmICgo
IXNiaW5mbyB8fCAoc2JfYWN0aXZlX3JlZiAmJiAhc2JpbmZvLT5zYl9tYXJrcykpICYmCiAJICAg
ICghbW50IHx8ICFtbnQtPm1udF9mc25vdGlmeV9tYXJrcykgJiYKIAkgICAgKCFpbm9kZSB8fCAh
aW5vZGUtPmlfZnNub3RpZnlfbWFya3MpICYmCiAJICAgICghaW5vZGUyIHx8ICFpbm9kZTItPmlf
ZnNub3RpZnlfbWFya3MpKQpAQCAtNTYyLDcgKzU2NywxMiBAQCBpbnQgZnNub3RpZnkoX191MzIg
bWFzaywgY29uc3Qgdm9pZCAqZGF0YSwgaW50IGRhdGFfdHlwZSwgc3RydWN0IGlub2RlICpkaXIs
CiAJCXJldHVybiAwOwogCiAJaXRlcl9pbmZvLnNyY3VfaWR4ID0gc3JjdV9yZWFkX2xvY2soJmZz
bm90aWZ5X21hcmtfc3JjdSk7Ci0KKwkvKgorCSAqIEZvciBldmVudHMgcG9zc2libGUgZHVyaW5n
IHNodXRkb3duIChlLmcuIEZTX0VSUk9SKSB3ZSBtYXkgbm90IGhvbGQKKwkgKiBhbiBzX2FjdGl2
ZSByZWZlcmVuY2Ugb24gc2IsIHNvIHdlIG5lZWQgdG8gcmUtZmV0Y2ggc2JpbmZvIHdpdGgKKwkg
KiBzcmN1X3JlYWRfbG9jaygpIGhlbGQuCisJICovCisJc2JpbmZvID0gZnNub3RpZnlfc2JfaW5m
byhzYik7CiAJaWYgKHNiaW5mbykgewogCQlpdGVyX2luZm8ubWFya3NbRlNOT1RJRllfSVRFUl9U
WVBFX1NCXSA9CiAJCQlmc25vdGlmeV9maXJzdF9tYXJrKCZzYmluZm8tPnNiX21hcmtzKTsKZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZnNub3RpZnlfYmFja2VuZC5oIGIvaW5jbHVkZS9saW51
eC9mc25vdGlmeV9iYWNrZW5kLmgKaW5kZXggN2YxYWI4MjY0ZTQxLi5mMTA5ODc2NjJkMWYgMTAw
NjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvZnNub3RpZnlfYmFja2VuZC5oCisrKyBiL2luY2x1ZGUv
bGludXgvZnNub3RpZnlfYmFja2VuZC5oCkBAIC05Nyw2ICs5Nyw5IEBACiAgKi8KICNkZWZpbmUg
RlNfRVZFTlRTX1BPU1NfVE9fUEFSRU5UIChGU19FVkVOVFNfUE9TU19PTl9DSElMRCkKIAorLyog
RXZlbnRzIHRoYXQgY291bGQgYmUgZ2VuZXJhdGVkIHdoaWxlIGZzIGlzIHNodXR0aW5nIGRvd24g
Ki8KKyNkZWZpbmUgRlNfRVZFTlRTX1BPU1NfT05fU0hVVERPV04gKEZTX0VSUk9SKQorCiAvKiBF
dmVudHMgdGhhdCBjYW4gYmUgcmVwb3J0ZWQgdG8gYmFja2VuZHMgKi8KICNkZWZpbmUgQUxMX0ZT
Tk9USUZZX0VWRU5UUyAoQUxMX0ZTTk9USUZZX0RJUkVOVF9FVkVOVFMgfCBcCiAJCQkgICAgIEZT
X0VWRU5UU19QT1NTX09OX0NISUxEIHwgXAotLSAKMi4zNC4xCgo=
--000000000000fd4afa0616347898--

