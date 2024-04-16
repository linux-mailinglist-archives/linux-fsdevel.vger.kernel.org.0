Return-Path: <linux-fsdevel+bounces-17053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4918A7154
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 18:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444771F22096
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 16:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159CC133283;
	Tue, 16 Apr 2024 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJkQ+LRR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B333B1327F8;
	Tue, 16 Apr 2024 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284840; cv=none; b=VuaqZKqXz37Ba9F42d85kCX1XfsRlB2MfFzY4AV3q0mhe5UMewOzlGKqqG+vBJ1IMR73IVNsQlQwhSpatDpquZ8EHkleIJc+JzRTD+7U1aiW958zDXXW4GxK+Y55OYBi3vDr0n2zKSgoB2X2oK0ObPkCCeSmC26U18IzK33ciJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284840; c=relaxed/simple;
	bh=lrd3VvHkNlO2uIbQ+bSrXQpiygq+TDjfC9et7gc9kzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1D2vtOuHujRQX6NwtFj5IBZHE5n8VhrxZ5c28xC+RyUVZ976I+od24wGFulGPupgyn3XIH/3vbAmxK9cL7ggl21ZuNAMhMliCcIttfvaOxBwK0erE/6ziGKgLZxhNLrre9+EK3u2A35ak4XB+O5c+1Xj0sL4S32oM8nVCHYuTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJkQ+LRR; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5aa1b7a37b3so2771652eaf.0;
        Tue, 16 Apr 2024 09:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713284837; x=1713889637; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qb4PseByLCf0GEw8SDaozxk0Rdf60ydaj4DEGNJgoP8=;
        b=lJkQ+LRRBCkrZm+NmyC8HiIQpUKdfU1Gh4ItCue7lq0lFe5YwGZEApP83uXQVGGNeG
         WFAVrD2T8MVE8adOGKI4hctNXvQKNKIKZyjlIHkEpvIkgW9Eouo50YxfyC6khmx2qZaR
         yk1kL6GAn78PFV2+XdrpicPnI3f3J2FvMevLY/4O1/M0ZD8afhG/uWQkUn4u6EuZUi9Z
         mz6VRbRnIoFXqg4S7ROtJKZrPKQ1CKBaN8Op+8i8sB8ggvN/1so3h5EoPkpYusmXKL6s
         0D/Ftr3XlvQEOw0fwRFjbQk1R18umrtLpBb79FO8MIMPnNlTjvsR82uhFp0k+jB3IFip
         i6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713284837; x=1713889637;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qb4PseByLCf0GEw8SDaozxk0Rdf60ydaj4DEGNJgoP8=;
        b=uMaBGj/HdybiJkA2RfT0bzT4DXUlf+yV18h0NF3KmbvXpj2LgrpDCkJ73GbpOPrpiO
         KXw0/hNjuO8vfk/G28VxAUsCPI89GzKjZC1/XZd3AAuBOdH119htY5gzUIQm8+6vxqRS
         flPcfuEfjIKEmNrkvY8CdqP6VbkOox5Ny3rdUVBrbdN+YqjN7oGcZm+QnYN65xxhpEDJ
         NmRpjXVfPmrVhLeV4ZT6MyiLMXFYrCnR9yoQyaUo8k5jR43FQ3YOZtrTsSu3w0qS0EF5
         R8xJr0YmHMFr+5Ok4S1NH0fnKLYwYY/f0MGuqaGZUgygjr3HCkEScLNTgYlxN4B4sj9s
         tdFA==
X-Forwarded-Encrypted: i=1; AJvYcCUxj+sLF4v/2qn7bVglPSC2uzVpVBNG3UBQSAyrJjgmjyP2tmTAs1h8yh2Bqw+SO0+ys98d+I42uwaVdwJT6NLBorsxmc/pIG4ClzyViDXEhSiCHmOVIVmA8JCNZ3Ep9ELvhU2PBVFWbovHnw==
X-Gm-Message-State: AOJu0Yy2Us6olfFCA2iizCN6XCLfxBy1UxQlaH/qpm1kTHPZDPZ9ixCv
	Qa++e6Mzs3M4ZRpkpKyw0emO+u0FdVAoWR7Hfiwgljaeav0lze95BoKGrKCadll6PvBF/9xha2N
	d7ieKIIa7dZr8wjzV03RPOdyUaTU=
X-Google-Smtp-Source: AGHT+IHAIRLKTiXAZvH0nB6ogSI0cYhPE4DqOPuTffoZvWLJU1ZgGg+u/BnPeAns45mAtRDN5YaayHO6PxJekChv56s=
X-Received: by 2002:a05:6359:4dc2:b0:186:4ada:4256 with SMTP id
 pj2-20020a0563594dc200b001864ada4256mr14348657rwb.22.1713284837454; Tue, 16
 Apr 2024 09:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000095bb400615f4b0ed@google.com> <20240413084519.1774-1-hdanton@sina.com>
 <CAOQ4uxhh4Tm6j+Hh+F2aQFuHfpCh_kJ10FYTfXo+AxoP4m01ag@mail.gmail.com>
 <20240415140333.y44rk5ggbadv4oej@quack3> <CAOQ4uxiG_7HGESMNkrJ7QmsXbgOneUGpMjx8vob87kntwTzUTQ@mail.gmail.com>
 <20240416132207.idn7rjzq4d4rayaz@quack3>
In-Reply-To: <20240416132207.idn7rjzq4d4rayaz@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 16 Apr 2024 19:27:05 +0300
Message-ID: <CAOQ4uxjJK3YT1+s_OwtM+=p_C8RCvXaAm6v5V+atyqvRKuKp+g@mail.gmail.com>
Subject: Re: [syzbot] Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in fsnotify
To: Jan Kara <jack@suse.cz>
Cc: Hillf Danton <hdanton@sina.com>, 
	syzbot <syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com>, 
	linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000235907061639362b"

--000000000000235907061639362b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 4:22=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 15-04-24 17:47:45, Amir Goldstein wrote:
> > On Mon, Apr 15, 2024 at 5:03=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Sat 13-04-24 12:32:32, Amir Goldstein wrote:
> > > > On Sat, Apr 13, 2024 at 11:45=E2=80=AFAM Hillf Danton <hdanton@sina=
.com> wrote:
> > > > > On Fri, 12 Apr 2024 23:42:19 -0700 Amir Goldstein
> > > > > > On Sat, Apr 13, 2024 at 4:41=3DE2=3D80=3DAFAM Hillf Danton <hda=
nton@sina.com> wrote:
> > > > > > > On Thu, 11 Apr 2024 01:11:20 -0700
> > > > > > > > syzbot found the following issue on:
> > > > > > > >
> > > > > > > > HEAD commit:    6ebf211bb11d Add linux-next specific files =
for 20240410
> > > > > > > > git tree:       linux-next
> > > > > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=
=3D3D1621af9d180000
> > > > > > >
> > > > > > > #syz test https://git.kernel.org/pub/scm/linux/kernel/git/nex=
t/linux-next.git  6ebf211bb11d
> > > > > > >
> > > > > > > --- x/fs/notify/fsnotify.c
> > > > > > > +++ y/fs/notify/fsnotify.c
> > > > > > > @@ -101,8 +101,8 @@ void fsnotify_sb_delete(struct super_blo
> > > > > > >         wait_var_event(fsnotify_sb_watched_objects(sb),
> > > > > > >                        !atomic_long_read(fsnotify_sb_watched_=
objects(sb)));
> > > > > > >         WARN_ON(fsnotify_sb_has_priority_watchers(sb, FSNOTIF=
Y_PRIO_CONTENT));
> > > > > > > -       WARN_ON(fsnotify_sb_has_priority_watchers(sb,
> > > > > > > -                                                 FSNOTIFY_PR=
IO_PRE_CONTENT));
> > > > > > > +       WARN_ON(fsnotify_sb_has_priority_watchers(sb, FSNOTIF=
Y_PRIO_PRE_CONTENT));
> > > > > > > +       synchronize_srcu(&fsnotify_mark_srcu);
> > > > > > >         kfree(sbinfo);
> > > > > > >  }
> > > > > > >
> > > > > > > @@ -499,7 +499,7 @@ int fsnotify(__u32 mask, const void *dat
> > > > > > >  {
> > > > > > >         const struct path *path =3D3D fsnotify_data_path(data=
, data_type);
> > > > > > >         struct super_block *sb =3D3D fsnotify_data_sb(data, d=
ata_type);
> > > > > > > -       struct fsnotify_sb_info *sbinfo =3D3D fsnotify_sb_inf=
o(sb);
> > > > > > > +       struct fsnotify_sb_info *sbinfo;
> > > > > > >         struct fsnotify_iter_info iter_info =3D {};
> > > > > > >         struct mount *mnt =3D3D NULL;
> > > > > > >         struct inode *inode2 =3D3D NULL;
> > > > > > > @@ -529,6 +529,8 @@ int fsnotify(__u32 mask, const void *dat
> > > > > > >                 inode2_type =3D3D FSNOTIFY_ITER_TYPE_PARENT;
> > > > > > >         }
> > > > > > >
> > > > > > > +       iter_info.srcu_idx =3D3D srcu_read_lock(&fsnotify_mar=
k_srcu);
> > > > > > > +       sbinfo =3D3D fsnotify_sb_info(sb);
> > > > > > >         /*
> > > > > > >          * Optimization: srcu_read_lock() has a memory barrie=
r which can
> > > > > > >          * be expensive.  It protects walking the *_fsnotify_=
marks lists.
> > > > > >
> > > > > >
> > > > > > See comment above. This kills the optimization.
> > > > > > It is not worth letting all the fsnotify hooks suffer the conse=
quence
> > > > > > for the edge case of calling fsnotify hook during fs shutdown.
> > > > >
> > > > > Say nothing before reading your fix.
> > > > > >
> > > > > > Also, fsnotify_sb_info(sb) in fsnotify_sb_has_priority_watchers=
()
> > > > > > is also not protected and using srcu_read_lock() there complete=
ly
> > > > > > nullifies the purpose of fsnotify_sb_info.
> > > > > >
> > > > > > Here is a simplified fix for fsnotify_sb_error() rebased on the
> > > > > > pending mm fixes for this syzbot boot failure:
> > > > > >
> > > > > > #syz test: https://github.com/amir73il/linux fsnotify-fixes
> > > > >
> > > > > Feel free to post your patch at lore because not everyone has
> > > > > access to sites like github.
> > > > > >
> > > > > > Jan,
> > > > > >
> > > > > > I think that all the functions called from fs shutdown context
> > > > > > should observe that SB_ACTIVE is cleared but wasn't sure?
> > > > >
> > > > > If you composed fix based on SB_ACTIVE that is cleared in
> > > > > generic_shutdown_super() with &sb->s_umount held for write,
> > > > > I wonder what simpler serialization than srcu you could
> > > > > find/create in fsnotify.
> > > >
> > > > As far as I can tell there is no need for serialisation.
> > > >
> > > > The problem is that fsnotify_sb_error() can be called from the
> > > > context of ->put_super() call from generic_shutdown_super().
> > > >
> > > > It's true that in the repro the thread calling fsnotify_sb_error()
> > > > in the worker thread running quota deferred work from put_super()
> > > > but I think there are sufficient barriers for this worker thread to
> > > > observer the cleared SB_ACTIVE flag.
> > > >
> > > > Anyway, according to syzbot, repro does not trigger the UAF
> > > > with my last fix.
> > > >
> > > > To be clear, any fsnotify_sb_error() that is a result of a user ope=
ration
> > > > would be holding an active reference to sb so cannot race with
> > > > fsnotify_sb_delete(), but I am not sure that same is true for ext4
> > > > worker threads.
> > > >
> > > > Jan,
> > > >
> > > > You wrote that "In theory these two calls can even run in parallel
> > > > and fsnotify() can be holding fsnotify_sb_info pointer while
> > > > fsnotify_sb_delete() is freeing".
> > > >
> > > > Can you give an example of this case?
> > >
> > > Yeah, basically what Hilf writes:
> > >
> > > Task 1                                  Task 2
> > >   umount()                              some delayed work, transactio=
n
> > >                                           commit, whatever is still r=
unning
> > >                                           before ext4_put_super() com=
pletes
> > >     ...                                     ext4_error()
> > >                                               fsnotify_sb_error()
> > >                                                 fsnotify()
> > >                                                   fetches fsnotify_sb=
_info
> > >     generic_shutdown_super()
> > >       fsnotify_sb_delete()
> > >         frees fsnotify_sb_info
> >
> > OK, so what do you say about Hillf's fix patch?
> >
> > Maybe it is ok to let go of the optimization in fsnotify(), considering
> > that we now have stronger optimizations in the inline hooks and
> > in __fsnotify_parent()?
> >
> > I think that Hillf's patch is missing setting s_fsnotify_info to NULL?
> >
> >  @@ -101,8 +101,8 @@ void fsnotify_sb_delete(struct super_blo
> >          wait_var_event(fsnotify_sb_watched_objects(sb),
> >                         !atomic_long_read(fsnotify_sb_watched_objects(s=
b)));
> >          WARN_ON(fsnotify_sb_has_priority_watchers(sb, FSNOTIFY_PRIO_CO=
NTENT));
> > +       WRITE_ONCE(sb->s_fsnotify_info, NULL);
> > +       synchronize_srcu(&fsnotify_mark_srcu);
> >          kfree(sbinfo);
> >  }
>
> So I had a look into this. Yes, something like this should work. We'll se=
e
> whether synchronize_srcu() won't slow down umount too much. If someone wi=
ll
> complain, we'll have to find a better solution.
>

Actually, kfree_rcu(sbinfo) may be enough.
We do not actually access sbinfo during mark iteration and
event handling, we only access it to get to the sb connector.

Something like the attached patch?

Thanks,
Amir.

--000000000000235907061639362b
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v2-0001-fsnotify-fix-UAF-from-FS_ERROR-event-on-a-shuttin.patch"
Content-Disposition: attachment; 
	filename="v2-0001-fsnotify-fix-UAF-from-FS_ERROR-event-on-a-shuttin.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lv2lj4kh0>
X-Attachment-Id: f_lv2lj4kh0

RnJvbSA4OTA3YjBlOTZhMWQ3ZDNiMDkwOTgyYWJjNmQ5ZWIzOTZlYjQ2N2YwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBUaHUsIDExIEFwciAyMDI0IDE4OjU5OjA4ICswMzAwClN1YmplY3Q6IFtQQVRDSCB2Ml0g
ZnNub3RpZnk6IGZpeCBVQUYgZnJvbSBGU19FUlJPUiBldmVudCBvbiBhIHNodXR0aW5nIGRvd24K
IGZpbGVzeXN0ZW0KClByb3RlY3QgYWdhaW5zdCB1c2UgYWZ0ZXIgZnJlZSB3aGVuIGZpbGVzeXN0
ZW0gY2FsbHMgZnNub3RpZnlfc2JfZXJyb3IoKQpkdXJpbmcgZnMgc2h1dGRvd24uCgpmc25vdGlm
eV9zYl9lcnJvcigpIG1heSBiZSBjYWxsZWQgd2l0aG91dCBhbiBzX2FjdGl2ZSByZWZlcmVuY2Us
IHNvIHVzZQpSQ1UgdG8gc3luY2hyb25pemUgYWNjZXNzIHRvIGZzbm90aWZ5X3NiX2luZm8oKSBp
biB0aGlzIGNhc2UuCgpSZXBvcnRlZC1ieTogc3l6Ym90KzVlM2Y5YjJhNjdiNDVmMTZkNGU2QHN5
emthbGxlci5hcHBzcG90bWFpbC5jb20KU3VnZ2VzdGVkLWJ5OiBIaWxsZiBEYW50b24gPGhkYW50
b25Ac2luYS5jb20+Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWZzZGV2ZWwv
MjAyNDA0MTMwMTQwMzMuMTcyMi0xLWhkYW50b25Ac2luYS5jb20vCkZpeGVzOiAwN2EzYjhkMGJm
NzIgKCJmc25vdGlmeTogbGF6eSBhdHRhY2ggZnNub3RpZnlfc2JfaW5mbyBzdGF0ZSB0byBzYiIp
ClNpZ25lZC1vZmYtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+Ci0tLQog
ZnMvbm90aWZ5L2Zzbm90aWZ5LmMgICAgICAgICAgICAgfCAxNyArKysrKysrKysrKysrKy0tLQog
aW5jbHVkZS9saW51eC9mc25vdGlmeV9iYWNrZW5kLmggfCAgNCArKysrCiAyIGZpbGVzIGNoYW5n
ZWQsIDE4IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvbm90
aWZ5L2Zzbm90aWZ5LmMgYi9mcy9ub3RpZnkvZnNub3RpZnkuYwppbmRleCAyYWU5NjVlZjM3ZTgu
LjMxMGM4ZTg0NTQ4MiAxMDA2NDQKLS0tIGEvZnMvbm90aWZ5L2Zzbm90aWZ5LmMKKysrIGIvZnMv
bm90aWZ5L2Zzbm90aWZ5LmMKQEAgLTEwMyw3ICsxMDMsOCBAQCB2b2lkIGZzbm90aWZ5X3NiX2Rl
bGV0ZShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiKQogCVdBUk5fT04oZnNub3RpZnlfc2JfaGFzX3By
aW9yaXR5X3dhdGNoZXJzKHNiLCBGU05PVElGWV9QUklPX0NPTlRFTlQpKTsKIAlXQVJOX09OKGZz
bm90aWZ5X3NiX2hhc19wcmlvcml0eV93YXRjaGVycyhzYiwKIAkJCQkJCSAgRlNOT1RJRllfUFJJ
T19QUkVfQ09OVEVOVCkpOwotCWtmcmVlKHNiaW5mbyk7CisJV1JJVEVfT05DRShzYi0+c19mc25v
dGlmeV9pbmZvLCBOVUxMKTsKKwlrZnJlZV9yY3Uoc2JpbmZvLCByY3UpOwogfQogCiAvKgpAQCAt
NTA2LDYgKzUwNyw3IEBAIGludCBmc25vdGlmeShfX3UzMiBtYXNrLCBjb25zdCB2b2lkICpkYXRh
LCBpbnQgZGF0YV90eXBlLCBzdHJ1Y3QgaW5vZGUgKmRpciwKIAlzdHJ1Y3QgZGVudHJ5ICptb3Zl
ZDsKIAlpbnQgaW5vZGUyX3R5cGU7CiAJaW50IHJldCA9IDA7CisJYm9vbCBzYl9hY3RpdmVfcmVm
ID0gIShtYXNrICYgRlNfRVZFTlRTX1BPU1NfT05fU0hVVERPV04pOwogCV9fdTMyIHRlc3RfbWFz
aywgbWFya3NfbWFzazsKIAogCWlmIChwYXRoKQpAQCAtNTM1LDggKzUzNywxMCBAQCBpbnQgZnNu
b3RpZnkoX191MzIgbWFzaywgY29uc3Qgdm9pZCAqZGF0YSwgaW50IGRhdGFfdHlwZSwgc3RydWN0
IGlub2RlICpkaXIsCiAJICogSG93ZXZlciwgaWYgd2UgZG8gbm90IHdhbGsgdGhlIGxpc3RzLCB3
ZSBkbyBub3QgaGF2ZSB0byBkbwogCSAqIFNSQ1UgYmVjYXVzZSB3ZSBoYXZlIG5vIHJlZmVyZW5j
ZXMgdG8gYW55IG9iamVjdHMgYW5kIGRvIG5vdAogCSAqIG5lZWQgU1JDVSB0byBrZWVwIHRoZW0g
ImFsaXZlIi4KKwkgKiBXZSBuZWVkIFJDVSByZWFkIHNpZGUgdG8ga2VlcCBzYmluZm8gImFsaXZl
IiBmb3IgZXZlbnRzIHBvc3NpYmxlCisJICogZHVyaW5nIHNodXRkb3duIChlLmcuIEZTX0VSUk9S
KS4KIAkgKi8KLQlpZiAoKCFzYmluZm8gfHwgIXNiaW5mby0+c2JfbWFya3MpICYmCisJaWYgKCgh
c2JpbmZvIHx8IChzYl9hY3RpdmVfcmVmICYmICFzYmluZm8tPnNiX21hcmtzKSkgJiYKIAkgICAg
KCFtbnQgfHwgIW1udC0+bW50X2Zzbm90aWZ5X21hcmtzKSAmJgogCSAgICAoIWlub2RlIHx8ICFp
bm9kZS0+aV9mc25vdGlmeV9tYXJrcykgJiYKIAkgICAgKCFpbm9kZTIgfHwgIWlub2RlMi0+aV9m
c25vdGlmeV9tYXJrcykpCkBAIC01NjIsMTEgKzU2NiwxOCBAQCBpbnQgZnNub3RpZnkoX191MzIg
bWFzaywgY29uc3Qgdm9pZCAqZGF0YSwgaW50IGRhdGFfdHlwZSwgc3RydWN0IGlub2RlICpkaXIs
CiAJCXJldHVybiAwOwogCiAJaXRlcl9pbmZvLnNyY3VfaWR4ID0gc3JjdV9yZWFkX2xvY2soJmZz
bm90aWZ5X21hcmtfc3JjdSk7Ci0KKwkvKgorCSAqIEZvciBldmVudHMgcG9zc2libGUgZHVyaW5n
IHNodXRkb3duIChlLmcuIEZTX0VSUk9SKSB3ZSBtYXkgbm90IGhvbGQKKwkgKiBhbiBzX2FjdGl2
ZSByZWZlcmVuY2Ugb24gc2IsIHNvIHdlIG5lZWQgdG8gZGVyZWZlcmVuY2Ugc2JpbmZvIHdpdGgK
KwkgKiByY3VfcmVhZF9sb2NrKCkgaGVsZC4KKwkgKi8KKwlyY3VfcmVhZF9sb2NrKCk7CisJc2Jp
bmZvID0gZnNub3RpZnlfc2JfaW5mbyhzYik7CiAJaWYgKHNiaW5mbykgewogCQlpdGVyX2luZm8u
bWFya3NbRlNOT1RJRllfSVRFUl9UWVBFX1NCXSA9CiAJCQlmc25vdGlmeV9maXJzdF9tYXJrKCZz
YmluZm8tPnNiX21hcmtzKTsKIAl9CisJcmN1X3JlYWRfdW5sb2NrKCk7CiAJaWYgKG1udCkgewog
CQlpdGVyX2luZm8ubWFya3NbRlNOT1RJRllfSVRFUl9UWVBFX1ZGU01PVU5UXSA9CiAJCQlmc25v
dGlmeV9maXJzdF9tYXJrKCZtbnQtPm1udF9mc25vdGlmeV9tYXJrcyk7CmRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L2Zzbm90aWZ5X2JhY2tlbmQuaCBiL2luY2x1ZGUvbGludXgvZnNub3RpZnlf
YmFja2VuZC5oCmluZGV4IDdmMWFiODI2NGU0MS4uZjExMDQ3MTI1NTIyIDEwMDY0NAotLS0gYS9p
bmNsdWRlL2xpbnV4L2Zzbm90aWZ5X2JhY2tlbmQuaAorKysgYi9pbmNsdWRlL2xpbnV4L2Zzbm90
aWZ5X2JhY2tlbmQuaApAQCAtOTcsNiArOTcsOSBAQAogICovCiAjZGVmaW5lIEZTX0VWRU5UU19Q
T1NTX1RPX1BBUkVOVCAoRlNfRVZFTlRTX1BPU1NfT05fQ0hJTEQpCiAKKy8qIEV2ZW50cyB0aGF0
IGNvdWxkIGJlIGdlbmVyYXRlZCB3aGlsZSBmcyBpcyBzaHV0dGluZyBkb3duICovCisjZGVmaW5l
IEZTX0VWRU5UU19QT1NTX09OX1NIVVRET1dOIChGU19FUlJPUikKKwogLyogRXZlbnRzIHRoYXQg
Y2FuIGJlIHJlcG9ydGVkIHRvIGJhY2tlbmRzICovCiAjZGVmaW5lIEFMTF9GU05PVElGWV9FVkVO
VFMgKEFMTF9GU05PVElGWV9ESVJFTlRfRVZFTlRTIHwgXAogCQkJICAgICBGU19FVkVOVFNfUE9T
U19PTl9DSElMRCB8IFwKQEAgLTQ4OCw2ICs0OTEsNyBAQCBzdHJ1Y3QgZnNub3RpZnlfbWFya19j
b25uZWN0b3IgewogICovCiBzdHJ1Y3QgZnNub3RpZnlfc2JfaW5mbyB7CiAJc3RydWN0IGZzbm90
aWZ5X21hcmtfY29ubmVjdG9yIF9fcmN1ICpzYl9tYXJrczsKKwlzdHJ1Y3QgcmN1X2hlYWQgcmN1
OwogCS8qCiAJICogTnVtYmVyIG9mIGlub2RlL21vdW50L3NiIG9iamVjdHMgdGhhdCBhcmUgYmVp
bmcgd2F0Y2hlZCBpbiB0aGlzIHNiLgogCSAqIE5vdGUgdGhhdCBpbm9kZXMgb2JqZWN0cyBhcmUg
Y3VycmVudGx5IGRvdWJsZS1hY2NvdW50ZWQuCi0tIAoyLjM0LjEKCg==
--000000000000235907061639362b--

