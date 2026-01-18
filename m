Return-Path: <linux-fsdevel+bounces-74313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A52D3984C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 18:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 893083008D5C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 17:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EAB23A58B;
	Sun, 18 Jan 2026 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAJxFQFe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8077260A
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768756051; cv=none; b=CAan3vCZ/5GQtsE5mbOlEMRYsznIbkioviwYZ5QyNfzeKgklyrPGn6pPQIqBZFxm49yBPQALvwNp8trMaUvOcJHE8Wr63krBOQ/SgtZBFxWpJQgD2rqbgjTwAzBiZSIoDeAG9wqyVIwVEaYzVuGUPjlEtMGebNyd14Ad50gne1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768756051; c=relaxed/simple;
	bh=47TmA8PROtBfylCfohOl428RWgpYVS3xl8hLnmRFGXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GeARjmALXtzxs3lHDzKtAtVc+yVGF1qaKGObF6lIefG7GdVlDvl0slV4F9vPTOXOLAeQADgRbJuo+7liZ6aRifLtvpWUkW+vCpm22yl/rt/30lNy6TCzeJ91tUNDagB1PfMCNsfR5ANOfn/CmNcQ81BUk6soJPQ9wXAVm/Hqm44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAJxFQFe; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64d1ef53cf3so4787677a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 09:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768756048; x=1769360848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abg4AmxGABlEjMiE+R4w4WcuaME2c8mboVc3g6mokBI=;
        b=PAJxFQFeuO6Jsqd8COqJZ49zgTGCIOxqteV/eDg2L/efAElaZkY6gls0eIRi6A/wMu
         oKqS7OMEiG9c9U3JcAO7Ru9RsNbP800DXD6UFeXZzlbQdPgwRjbDyBPJqyjSm+7U4L/2
         FhJJIm0BGE9En7joexeztrEr8qDiqCjtIk9LT3It3Hu8ufB9U68XX8mnAl9l9j+YqfEf
         UkxYdyk7CXtqvyG0eW7BYReLjH1+ohz3cyxNKnwFlwmFMUcYOKHrhTVWuaWQNtN2l2Sf
         mmX7l5fEDk0lsFLgvbX4W/vYg6YIxoj10Tf3tYwOs+YhKzLQ3rEdkRmNYB7EwSWeSPaH
         sJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768756048; x=1769360848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=abg4AmxGABlEjMiE+R4w4WcuaME2c8mboVc3g6mokBI=;
        b=xTdXWnO1SKl4oH7lmrL74WaiGfeVLcyk8YwOZJnmMh+n2qFuHdsccMjApnFBnvcN8K
         GmTiu25vKxSFyt3lx6eAvJ6sz4wjBRyM7yLZpZjpsGAxCGhMORcz5OPUdkrk1d/oR3S0
         C3Uv511RRYMqB08A6ypSVFHJ2Jug/22CFqE/8x9zYM8CQEMPDCeGWtcGG9ONZGlApAO3
         VFsvonaijABBA9hA21Hn4TY+dgfrhDqtcYJ1qm1eXC248Xs+MAESkaZa+dOAdkVUswdQ
         bwPbSDgOzoYuY2Xhguq0D2oga4ZGGDdpQODBI21Qu3O8pYTWqIGgGeokuHWNpXlSFz3v
         3Qdg==
X-Forwarded-Encrypted: i=1; AJvYcCX1P8LqoPnhLAtgE8bX87Tag2c91o54leLxOP5I1Ej1QONt9OdUNgpTzcO82adIsgz3ObAqv0gw60ryOKmO@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2janh5XxJHz/n09rdQcLUjokXBFjAPTvAhhhJDRpN2NQqYq6R
	duOKL9Dnq+a+cPReNGAyq5dpjFsLkb8H9+TNCEkcDA1rSa+ujHBHOm1oZ+auaaGXgscLdI/zpO5
	dTlFtPSVXPHBDv8K9FBfHtQ5tXtZMNmgHdbmPJtM=
X-Gm-Gg: AY/fxX5DuoZ+Jdh2+8KJihu67Efg8yXktJr2NK+49qNTlTFU0sxPJs/Wo+PILI8ctT9
	7zw+rW8Y/5IV7b03KABmucuy9qfXVHL6hSMz21KyvabqjGt2hRadVQtTgtkcMTXZV2264npt4E3
	eyCCf/FZYasAaLJAyq0DOhfx2ObgS8gL2t9/B+ZYQlB0DlNvGb2xh7NjIR5eX1Lq4CDMu4zH1Um
	4aDFx2rgj83XWLJAPqpZwuMwVxX8XE7JaQXu+65EQH3CiS2C+NrG2vffEU76S2tuo+0e4Ur+HYY
	zCxLlZPHLhQjkvctJhjj8g0xhsbyRg==
X-Received: by 2002:a05:6402:278d:b0:64d:c54a:334e with SMTP id
 4fb4d7f45d1cf-65452ccace0mr6413405a12.29.1768756047754; Sun, 18 Jan 2026
 09:07:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116142845.422-1-luochunsheng@ustc.edu> <20260116142845.422-2-luochunsheng@ustc.edu>
 <CAOQ4uxg13jAJyG8b3CpjKE8FXn3ce=yUCzw+Qc=k29si=FtXaQ@mail.gmail.com>
 <428db714-5ec8-4259-b808-b8784153d4f2@ustc.edu> <CAOQ4uxhgOk2Ati81vqEkgWFODkW_gkB7Z7wj0x1A8RX38wLSRA@mail.gmail.com>
 <2264748f-58f7-490e-be0b-257db08a761d@ustc.edu>
In-Reply-To: <2264748f-58f7-490e-be0b-257db08a761d@ustc.edu>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 18 Jan 2026 18:07:16 +0100
X-Gm-Features: AZwV_QjGeJ4WJpfuCdKXOGZLFXw0TPHGadgSw7l8nzDoOdBRf4bMt5m5cv08GH4
Message-ID: <CAOQ4uxhbo8vkuNZmhpyOUnttakNmyqCdmiyQyLJakPmsReu3mg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: add ioctl to cleanup all backing files
To: Chunsheng Luo <luochunsheng@ustc.edu>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2026 at 12:47=E2=80=AFPM Chunsheng Luo <luochunsheng@ustc.e=
du> wrote:
>
>
>
> On 1/18/26 1:00 AM, Amir Goldstein wrote:
> > On Sat, Jan 17, 2026 at 5:14=E2=80=AFPM Chunsheng Luo <luochunsheng@ust=
c.edu> wrote:
> >>
> >>
> >>
> >> On 1/16/26 11:39 PM, Amir Goldstein wrote:
> >>> On Fri, Jan 16, 2026 at 3:28=E2=80=AFPM Chunsheng Luo <luochunsheng@u=
stc.edu> wrote:
> >>>>
> >>>> To simplify crash recovery and reduce performance impact, backing_id=
s
> >>>> are not persisted across daemon restarts. After crash recovery, this
> >>>> may lead to resource leaks if backing file resources are not properl=
y
> >>>> cleaned up.
> >>>>
> >>>> Add FUSE_DEV_IOC_BACKING_CLOSE_ALL ioctl to release all backing_ids
> >>>> and put backing files. When the FUSE daemon restarts, it can use thi=
s
> >>>> ioctl to cleanup all backing file resources.
> >>>>
> >>>> Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
> >>>> ---
> >>>>    fs/fuse/backing.c         | 19 +++++++++++++++++++
> >>>>    fs/fuse/dev.c             | 16 ++++++++++++++++
> >>>>    fs/fuse/fuse_i.h          |  1 +
> >>>>    include/uapi/linux/fuse.h |  1 +
> >>>>    4 files changed, 37 insertions(+)
> >>>>
> >>>> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> >>>> index 4afda419dd14..e93d797a2cde 100644
> >>>> --- a/fs/fuse/backing.c
> >>>> +++ b/fs/fuse/backing.c
> >>>> @@ -166,6 +166,25 @@ int fuse_backing_close(struct fuse_conn *fc, in=
t backing_id)
> >>>>           return err;
> >>>>    }
> >>>>
> >>>> +static int fuse_backing_close_one(int id, void *p, void *data)
> >>>> +{
> >>>> +       struct fuse_conn *fc =3D data;
> >>>> +
> >>>> +       fuse_backing_close(fc, id);
> >>>> +
> >>>> +       return 0;
> >>>> +}
> >>>> +
> >>>> +int fuse_backing_close_all(struct fuse_conn *fc)
> >>>> +{
> >>>> +       if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> >>>> +               return -EPERM;
> >>>> +
> >>>> +       idr_for_each(&fc->backing_files_map, fuse_backing_close_one,=
 fc);
> >>>> +
> >>>> +       return 0;
> >>>> +}
> >>>> +
> >>>
> >>> This is not safe and not efficient.
> >>> For safety from racing with _open/_close, iteration needs at least
> >>> rcu_read_lock(),
> >>
> >> Yes, you're absolutely right. Additionally, calling idr_remove within
> >> idr_for_each maybe presents safety risks.
> >>
> >>> but I think it will be much more efficient to zap the entire map with
> >>> fuse_backing_files_free()/fuse_backing_files_init().
> >>>
> >>> This of course needs to be synchronized with concurrent _open/_close/=
_lookup.
> >>> This could be done by making c->backing_files_map a struct idr __rcu =
*
> >>> and replace the old and new backing_files_map under spin_lock(&fc->lo=
ck);
> >>>
> >>> Then you can call fuse_backing_files_free() on the old backing_files_=
map
> >>> without a lock.
> >>>
> >>> As a side note, fuse_backing_files_free() iteration looks like it may=
 need
> >>> cond_resched() if there are a LOT of backing ids, but I am not sure a=
nd
> >>> this is orthogonal to your change.
> >>>
> >>> Thanks,
> >>> Amir.
> >>>
> >>>
> >>
> >> Thank you for your helpful suggestions. However, it cannot use
> >> fuse_backing_files_free() in the close_all implementation because it
> >> directly frees backing files without respecting reference counts. This
> >> function requires that no one is actively using the backing file (it
> >> even has WARN_ON_ONCE(refcount_read(&fb->count) !=3D 1)), which cannot=
 be
> >> guaranteed after a crash recovery scenario where backing files may sti=
ll
> >> be in use.
> >
> > Right.
> >
> >>
> >> Instead, the implementation uses fuse_backing_put() to safely decremen=
t
> >> the reference count and allow the backing file to be freed when no
> >> longer in use.
> >
> > OK.
> >
> >>
> >> Additionally, the implementation addresses two race conditions:
> >>
> >> - Race between idr_for_each and lookup: Uses synchronize_rcu() to ensu=
re
> >> all concurrent RCU readers (i.e., in-flight fuse_backing_lookup() call=
s)
> >> complete before releasing backing files, preventing use-after-free iss=
ues.
> >
> > Almost. See below.
> >
> >>
> >> - Race with open/close operations: Uses fc->lock to atomically swap th=
e
> >> old and new IDR maps, ensuring consistency with concurrent
> >> fuse_backing_open() and fuse_backing_close() operations.
> >>
> >> This approach provides the same as the RCU pointer suggestion, but wit=
h
> >> less code and no changes to the struct fuse_conn data structures.
> >>
> >> I've updated it and verified the implementation. Could you please revi=
ew it?
> >>
> >>
> >> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> >> index 4afda419dd14..047d373684f9 100644
> >> --- a/fs/fuse/backing.c
> >> +++ b/fs/fuse/backing.c
> >> @@ -166,6 +166,45 @@ int fuse_backing_close(struct fuse_conn *fc, int
> >> backing_id)
> >>           return err;
> >>    }
> >>
> >> +static int fuse_backing_release_one(int id, void *p, void *data)
> >> +{
> >> +       struct fuse_backing *fb =3D p;
> >> +
> >> +       fuse_backing_put(fb);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +int fuse_backing_close_all(struct fuse_conn *fc)
> >> +{
> >> +       struct idr old_map;
> >> +
> >> +       if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> >> +               return -EPERM;
> >> +
> >> +       /*
> >> +        * Swap out the old backing_files_map with a new empty one und=
er
> >> lock,
> >> +        * then release all backing files outside the lock. This avoid=
s long
> >> +        * lock hold times and potential races with concurrent open/cl=
ose
> >> +        * operations.
> >> +        */
> >> +       idr_init(&old_map);
> >> +       spin_lock(&fc->lock);
> >> +       swap(fc->backing_files_map, old_map);
> >> +       spin_unlock(&fc->lock);
> >> +
> >> +       /*
> >> +        * Ensure all concurrent RCU readers complete before releasing
> >> backing
> >> +        * files, so any in-flight lookups can safely take references.
> >> +        */
> >> +       synchronize_rcu();
> >> +
> >> +       idr_for_each(&old_map, fuse_backing_release_one, NULL);
> >> +       idr_destroy(&old_map);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >
> > That's almost safe but not enough.
> > This lookup code is not safe against the swap():
> >
> >    rcu_read_lock();
> >    fb =3D idr_find(&fc->backing_files_map, backing_id);
> >
> > That is the reason you need to make fc->backing_files_map
> > an rcu referenced ptr.
> >
> > Instead of swap() you use xchg() to atomically exchange the
> > old and new struct idr pointers and for lookup:
> >
> >    rcu_read_lock();
> >    fb =3D idr_find(rcu_dereference(fc->backing_files_map), backing_id);
> >
> > Thanks,
> > Amir.
> >
> >
>
> Yes, swap() isn't atomic, it's just copying structs, so it's not safe
> when racing with lookup.
>
> I've updated the version to make fc->backing_files_map an rcu referenced
> ptr. Please review the attached patch.

You can also use rcu_replace_pointer() to swap old_idr <-> new_idr,
but otherwise the patch looks fine to me.

Thanks,
Amir.

