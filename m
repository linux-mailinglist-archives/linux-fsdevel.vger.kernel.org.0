Return-Path: <linux-fsdevel+bounces-74314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3222DD39852
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 18:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 957BF300857D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 17:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB95E243951;
	Sun, 18 Jan 2026 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bz0S6Oh4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5EB21CC7B
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768756113; cv=none; b=RffDPxK4BjHjzOEqeGkW9Lu/lh6EPJcj2SVImkhaKHkPtgV8hTZBe14lkPojxYsTjmKg3cX7QTfgFYTKsOR7cP2mu3nKZc6aOQt7IsZxfnfP3mjSF9mJtbPCcxd1TVLboL53c5hB178i/rHVRezsudZU+5eTQ38j/syxi92aAHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768756113; c=relaxed/simple;
	bh=nzwfp/pGJDM2IWjAHAE5G8qThFPjQqLzGFFhb1vfVIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XO+pjYrQpXixomMw7GgojDKaZofKJaAmLrJzmNC13rt0e9X9A3I47od0w6wa82aAADI3+1JY7jqTCA5IUcudZXdaoHoIB199hr7rTXjzCI5vzToQJn+NgcUvLKtEyx2xVW8EdC9kTcQ9j+2VxaVqWApmzvv9lGNlL7P+gwK9v3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bz0S6Oh4; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64d1ef53cf3so4788342a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 09:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768756110; x=1769360910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2+WtaxwDDTKRHcByeepCidrxPKBTmm+F4zjz1XSsq4=;
        b=bz0S6Oh4Tyzzm4R0xt5nIGPD7KWHiy6wubhtWt33KVaFusl6XbByVL0IT6UXjD77U5
         bGeT2pjSNJy1CCejEt3FHv6sS8i2j1jwopFyiKLVp3ifz6m69MDgLbR3seKfPoUCiSZu
         a1R+AIURa+O+w7py5RtUET/iN0FfSpfVUbyvheGZ7Y19fns+GycOTvro3+zExl8pHew2
         /lztdhfuoKbJhh/Tbv9Hay6aZEITECRjwUqYMpj3FNW5UecfuM8gf+Sc/njElrXIgnAP
         m1MwwCyqNE69Jiq9Fqir+l544oHklFSVv2L8a7sWb7oDj/hNp1UoSb8zKEh0/E8oirQK
         BrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768756110; x=1769360910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m2+WtaxwDDTKRHcByeepCidrxPKBTmm+F4zjz1XSsq4=;
        b=mjknWC5MOmzCf7hYxhdR7IfGYWwuzGu41AQrukcCqiuKbceBpIZdT5C56ejF7g7itb
         zZXN/tcjUNUpSDc38UR1JwkpcNj56lXIhetv2kL6+Uq/13bOemtSXPzmt5caQLGygoFH
         B+TD5cCu0O7uMo6jh/Z4j50/l14nzgVSh7wVmDYmFcjS17cQ5lD4EFfG7yLLVAy5oGGg
         5TXKASXQYouR86sWGcLY/5vTXGZJzEKRWauT3wsQjVfQhu1/KYhj7zoT1wUPVruibxfB
         ALsRJt2/d2x3Pc/g3suWu2u/lCSLDBfSktewrvEq7ywsfwSUvh3pgUIRcK3HFOGG5Ro2
         IMUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB9Ic5w93ps0odDYaOdSizRDer8TiSC0EVvmvrdt33oPIXZYKFmxj0CXrAW4f0RV548HYqza5QdScfyoTw@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3JBLmH2/FV6p1CuiWhYnxk+k6RINRYlccT1wcHJYwi/LaF7yo
	Dc50oAd2nj1g2O6my9+awmI4JfvRMYrLCWhoCz6xnlfFVQQGF6zKqQ38/lxgTL4FyUJdRVyLW/j
	LEIZTngVO4XWfhRdoDZ4cuY4m9njjZ44=
X-Gm-Gg: AY/fxX6Z09+EbyqaufWj40+bXZ7Qq6hRI/9Zysg29LSCWUFucihex5cvhpnWULI+6HX
	g1qNLWOLHHFRItVWkp4b33qxjIucNTDf2aIfE4UEwazObeQ8zD22/1/lRV+Zyt2icLJfMmsmn76
	oWsufORvhuQnsrE8zxZtZGvYlXDhZi54/iNeggxaLoFxhtvnz0SoR6HP8vwEnZgIf1j4jW2SJ8x
	slMnHVvqjXlIkeWQhNuHkvsrV4BJPB7CvEnBGM+2Rj83qtaLF/pyjXsiIIVLrA2GcraquC/dRIx
	kvNWP49cE1C0DbNgEbWeDwpUKv9SZ94ZNY8zR4nT
X-Received: by 2002:a05:6402:518e:b0:649:9f05:68ce with SMTP id
 4fb4d7f45d1cf-654526d5ef4mr6513257a12.14.1768756109662; Sun, 18 Jan 2026
 09:08:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116142845.422-1-luochunsheng@ustc.edu> <20260116142845.422-2-luochunsheng@ustc.edu>
 <CAOQ4uxg13jAJyG8b3CpjKE8FXn3ce=yUCzw+Qc=k29si=FtXaQ@mail.gmail.com>
 <428db714-5ec8-4259-b808-b8784153d4f2@ustc.edu> <CAOQ4uxhgOk2Ati81vqEkgWFODkW_gkB7Z7wj0x1A8RX38wLSRA@mail.gmail.com>
 <2264748f-58f7-490e-be0b-257db08a761d@ustc.edu> <CAOQ4uxhbo8vkuNZmhpyOUnttakNmyqCdmiyQyLJakPmsReu3mg@mail.gmail.com>
In-Reply-To: <CAOQ4uxhbo8vkuNZmhpyOUnttakNmyqCdmiyQyLJakPmsReu3mg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 18 Jan 2026 18:08:18 +0100
X-Gm-Features: AZwV_Qhao9iGC8xbIaB14wPv6-kd8kaLMaSb1-mizmg9sV3JKS0SJhdNjiG_Hbc
Message-ID: <CAOQ4uxhcj0Bu0WjkeHoi6Y3CL=gBKJRcsbSEb7DrteAfiZbBnw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: add ioctl to cleanup all backing files
To: Chunsheng Luo <luochunsheng@ustc.edu>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2026 at 6:07=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Sun, Jan 18, 2026 at 12:47=E2=80=AFPM Chunsheng Luo <luochunsheng@ustc=
.edu> wrote:
> >
> >
> >
> > On 1/18/26 1:00 AM, Amir Goldstein wrote:
> > > On Sat, Jan 17, 2026 at 5:14=E2=80=AFPM Chunsheng Luo <luochunsheng@u=
stc.edu> wrote:
> > >>
> > >>
> > >>
> > >> On 1/16/26 11:39 PM, Amir Goldstein wrote:
> > >>> On Fri, Jan 16, 2026 at 3:28=E2=80=AFPM Chunsheng Luo <luochunsheng=
@ustc.edu> wrote:
> > >>>>
> > >>>> To simplify crash recovery and reduce performance impact, backing_=
ids
> > >>>> are not persisted across daemon restarts. After crash recovery, th=
is
> > >>>> may lead to resource leaks if backing file resources are not prope=
rly
> > >>>> cleaned up.
> > >>>>
> > >>>> Add FUSE_DEV_IOC_BACKING_CLOSE_ALL ioctl to release all backing_id=
s
> > >>>> and put backing files. When the FUSE daemon restarts, it can use t=
his
> > >>>> ioctl to cleanup all backing file resources.
> > >>>>
> > >>>> Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
> > >>>> ---
> > >>>>    fs/fuse/backing.c         | 19 +++++++++++++++++++
> > >>>>    fs/fuse/dev.c             | 16 ++++++++++++++++
> > >>>>    fs/fuse/fuse_i.h          |  1 +
> > >>>>    include/uapi/linux/fuse.h |  1 +
> > >>>>    4 files changed, 37 insertions(+)
> > >>>>
> > >>>> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> > >>>> index 4afda419dd14..e93d797a2cde 100644
> > >>>> --- a/fs/fuse/backing.c
> > >>>> +++ b/fs/fuse/backing.c
> > >>>> @@ -166,6 +166,25 @@ int fuse_backing_close(struct fuse_conn *fc, =
int backing_id)
> > >>>>           return err;
> > >>>>    }
> > >>>>
> > >>>> +static int fuse_backing_close_one(int id, void *p, void *data)
> > >>>> +{
> > >>>> +       struct fuse_conn *fc =3D data;
> > >>>> +
> > >>>> +       fuse_backing_close(fc, id);
> > >>>> +
> > >>>> +       return 0;
> > >>>> +}
> > >>>> +
> > >>>> +int fuse_backing_close_all(struct fuse_conn *fc)
> > >>>> +{
> > >>>> +       if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> > >>>> +               return -EPERM;
> > >>>> +
> > >>>> +       idr_for_each(&fc->backing_files_map, fuse_backing_close_on=
e, fc);
> > >>>> +
> > >>>> +       return 0;
> > >>>> +}
> > >>>> +
> > >>>
> > >>> This is not safe and not efficient.
> > >>> For safety from racing with _open/_close, iteration needs at least
> > >>> rcu_read_lock(),
> > >>
> > >> Yes, you're absolutely right. Additionally, calling idr_remove withi=
n
> > >> idr_for_each maybe presents safety risks.
> > >>
> > >>> but I think it will be much more efficient to zap the entire map wi=
th
> > >>> fuse_backing_files_free()/fuse_backing_files_init().
> > >>>
> > >>> This of course needs to be synchronized with concurrent _open/_clos=
e/_lookup.
> > >>> This could be done by making c->backing_files_map a struct idr __rc=
u *
> > >>> and replace the old and new backing_files_map under spin_lock(&fc->=
lock);
> > >>>
> > >>> Then you can call fuse_backing_files_free() on the old backing_file=
s_map
> > >>> without a lock.
> > >>>
> > >>> As a side note, fuse_backing_files_free() iteration looks like it m=
ay need
> > >>> cond_resched() if there are a LOT of backing ids, but I am not sure=
 and
> > >>> this is orthogonal to your change.
> > >>>
> > >>> Thanks,
> > >>> Amir.
> > >>>
> > >>>
> > >>
> > >> Thank you for your helpful suggestions. However, it cannot use
> > >> fuse_backing_files_free() in the close_all implementation because it
> > >> directly frees backing files without respecting reference counts. Th=
is
> > >> function requires that no one is actively using the backing file (it
> > >> even has WARN_ON_ONCE(refcount_read(&fb->count) !=3D 1)), which cann=
ot be
> > >> guaranteed after a crash recovery scenario where backing files may s=
till
> > >> be in use.
> > >
> > > Right.
> > >
> > >>
> > >> Instead, the implementation uses fuse_backing_put() to safely decrem=
ent
> > >> the reference count and allow the backing file to be freed when no
> > >> longer in use.
> > >
> > > OK.
> > >
> > >>
> > >> Additionally, the implementation addresses two race conditions:
> > >>
> > >> - Race between idr_for_each and lookup: Uses synchronize_rcu() to en=
sure
> > >> all concurrent RCU readers (i.e., in-flight fuse_backing_lookup() ca=
lls)
> > >> complete before releasing backing files, preventing use-after-free i=
ssues.
> > >
> > > Almost. See below.
> > >
> > >>
> > >> - Race with open/close operations: Uses fc->lock to atomically swap =
the
> > >> old and new IDR maps, ensuring consistency with concurrent
> > >> fuse_backing_open() and fuse_backing_close() operations.
> > >>
> > >> This approach provides the same as the RCU pointer suggestion, but w=
ith
> > >> less code and no changes to the struct fuse_conn data structures.
> > >>
> > >> I've updated it and verified the implementation. Could you please re=
view it?
> > >>
> > >>
> > >> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> > >> index 4afda419dd14..047d373684f9 100644
> > >> --- a/fs/fuse/backing.c
> > >> +++ b/fs/fuse/backing.c
> > >> @@ -166,6 +166,45 @@ int fuse_backing_close(struct fuse_conn *fc, in=
t
> > >> backing_id)
> > >>           return err;
> > >>    }
> > >>
> > >> +static int fuse_backing_release_one(int id, void *p, void *data)
> > >> +{
> > >> +       struct fuse_backing *fb =3D p;
> > >> +
> > >> +       fuse_backing_put(fb);
> > >> +
> > >> +       return 0;
> > >> +}
> > >> +
> > >> +int fuse_backing_close_all(struct fuse_conn *fc)
> > >> +{
> > >> +       struct idr old_map;
> > >> +
> > >> +       if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> > >> +               return -EPERM;
> > >> +
> > >> +       /*
> > >> +        * Swap out the old backing_files_map with a new empty one u=
nder
> > >> lock,
> > >> +        * then release all backing files outside the lock. This avo=
ids long
> > >> +        * lock hold times and potential races with concurrent open/=
close
> > >> +        * operations.
> > >> +        */
> > >> +       idr_init(&old_map);
> > >> +       spin_lock(&fc->lock);
> > >> +       swap(fc->backing_files_map, old_map);
> > >> +       spin_unlock(&fc->lock);
> > >> +
> > >> +       /*
> > >> +        * Ensure all concurrent RCU readers complete before releasi=
ng
> > >> backing
> > >> +        * files, so any in-flight lookups can safely take reference=
s.
> > >> +        */
> > >> +       synchronize_rcu();
> > >> +
> > >> +       idr_for_each(&old_map, fuse_backing_release_one, NULL);
> > >> +       idr_destroy(&old_map);
> > >> +
> > >> +       return 0;
> > >> +}
> > >> +
> > >
> > > That's almost safe but not enough.
> > > This lookup code is not safe against the swap():
> > >
> > >    rcu_read_lock();
> > >    fb =3D idr_find(&fc->backing_files_map, backing_id);
> > >
> > > That is the reason you need to make fc->backing_files_map
> > > an rcu referenced ptr.
> > >
> > > Instead of swap() you use xchg() to atomically exchange the
> > > old and new struct idr pointers and for lookup:
> > >
> > >    rcu_read_lock();
> > >    fb =3D idr_find(rcu_dereference(fc->backing_files_map), backing_id=
);
> > >
> > > Thanks,
> > > Amir.
> > >
> > >
> >
> > Yes, swap() isn't atomic, it's just copying structs, so it's not safe
> > when racing with lookup.
> >
> > I've updated the version to make fc->backing_files_map an rcu reference=
d
> > ptr. Please review the attached patch.
>
> You can also use rcu_replace_pointer() to swap old_idr <-> new_idr,
> but otherwise the patch looks fine to me.
>

Feel free to add
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

