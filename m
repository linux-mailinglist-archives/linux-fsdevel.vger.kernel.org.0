Return-Path: <linux-fsdevel+bounces-34711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB7F9C7F6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 01:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D627B22CDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 00:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4266C2E0;
	Thu, 14 Nov 2024 00:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue+2OEIU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25A0A95C
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 00:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731544763; cv=none; b=h9g0sjtwelrcc4APlJpwwyFlUN8dBq8GD5Q12XetyHwh4GV/+XL+XQxY1vr8bZpN6J6myr4NTRKjqjmGtCVVkttCMIPxRphmW4I0PqGRC5vOg1zZy+eORTGrOGJX3+VdIg+AKhVDRYtsBDHucqZQTWYMWNanAYLYsgDCpT2mkG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731544763; c=relaxed/simple;
	bh=L/hvnClXs3zfskqfegsCjY+Gfr0/vXVTOFeXVK+FNlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CB3y1k/ut2toAOV1x+6fQf69CmBEmB2/wOgpMRoio++sWk7VuE/HXE8JUjZdmLVljT2kWBgIUlYuj3zVkoCjeH95SCSow/t5I7onvzc2sRatkl6kkC8mdVXsEw/Y/Yq1x+sYSyabGFm4/t1B9a0rBRvqnRFpjqq4zhUT8yi3qLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ue+2OEIU; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4608e389407so429941cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 16:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731544760; x=1732149560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ui92GwdJMLYEeuUgce0xtSp+y54z2Swd5voIaLF3cpw=;
        b=Ue+2OEIU0SU7TKmDuOmUe7C8uIrirN2YNKYsD/vAO6wSHBwVrjzF2F1b+z06z/Qvxp
         s3b8iS4PWaYEWZ7pOny2tknGeWYovO2onRY3mgf2xgSCezB0reucoQWu6qb3vwKK2vsD
         spwvfJhaUVu93jWzpOi4i6qbTCyJRA8ynl3cBhsuPO4MjAV8g2T3KSASOXy7zyOpDzes
         TMcn92ywSgUvzYWq3O9MbgNapi2xYpFPy1k0970WJQ3/+0Gk0/OBloTktwYO3IhuwJOi
         IdveRXXoRAKY6yWszOOxQrprbsqiH1BxzDerRBbz1t/I0hZ2vq8PlFDIIZvegBVoCjb/
         5ffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731544760; x=1732149560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ui92GwdJMLYEeuUgce0xtSp+y54z2Swd5voIaLF3cpw=;
        b=njOELaVbHun2DRHFLbrZiGHERoTQJh91SfcPMzR9Iy/wrcVDlYZkjpe5zs/b7PHUSU
         8SzOBEV5USh24D7PV/MC39ARajgPRvs2z6/IjnDKINvf0RQbKevBlVXwv+SIaoCXQsyI
         MJd6ojGNyZ1gDDSuVC4l6EehhLoctVlUIf0G1GzlN4vyZ6rpk94nhNRsG8rx6wBvnaPo
         mKrAgYyOnMGlMe4iE/sehs1H2AlY3JiUP3uxlXwok1HNWUY2CxEErZhChOGrspNwdBfj
         lMiKIYB3AtxIYk1b3q2XhBXyoFI4Epu9Iy6qhgHMdlMKMyDBJ7oBlfxhc6n2IdCyhoTC
         D/BA==
X-Forwarded-Encrypted: i=1; AJvYcCXjkJLqNigY1J01q3a+A73eZjrNAubA76uoFyIJIuTR/5h0RlUAorvxosmi50F2oFgE0sFxRhkkiAfc1HYB@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7/PoLFhpHHl79UjRF3E8okaYFK6q8RCtvlLzt1K0ugT/xrQ7H
	ONZ2Y1KtGvaQ4AQ7laMoDzCEWe3BqZUsjENpJUDjKe+TPICpqAM8SycwBZ0eQQLjGbFlFOu8a4C
	ZzsPZk5A7HrvQ7FoXnZiz20WxaK0=
X-Google-Smtp-Source: AGHT+IEFBXoeA3UddAD4FhSSfshE8uACpQYHlp1nJYMICNz3NabjlaCML/zHdAQgVLMjzCFG5b61laABmgl8G6dWPuY=
X-Received: by 2002:a05:622a:18a4:b0:462:f5ca:5b06 with SMTP id
 d75a77b69052e-4630930ed42mr321207931cf.3.1731544760444; Wed, 13 Nov 2024
 16:39:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107235614.3637221-1-joannelkoong@gmail.com>
 <20241107235614.3637221-7-joannelkoong@gmail.com> <e85bd643-894e-4eb2-994b-62f0d642b4f1@linux.alibaba.com>
In-Reply-To: <e85bd643-894e-4eb2-994b-62f0d642b4f1@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 13 Nov 2024 16:39:09 -0800
Message-ID: <CAJnrk1bS6J9NXae5bXTF+MrKV2VZ-2bi=WqkyY1XY2BggA01TQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, shakeel.butt@linux.dev, 
	josef@toxicpanda.com, linux-mm@kvack.org, bernd.schubert@fastmail.fm, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 1:25=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
> Hi Joanne,
>
> On 11/8/24 7:56 AM, Joanne Koong wrote:
> > Currently, we allocate and copy data to a temporary folio when
> > handling writeback in order to mitigate the following deadlock scenario
> > that may arise if reclaim waits on writeback to complete:
> > * single-threaded FUSE server is in the middle of handling a request
> >   that needs a memory allocation
> > * memory allocation triggers direct reclaim
> > * direct reclaim waits on a folio under writeback
> > * the FUSE server can't write back the folio since it's stuck in
> >   direct reclaim
> >
> > To work around this, we allocate a temporary folio and copy over the
> > original folio to the temporary folio so that writeback can be
> > immediately cleared on the original folio. This additionally requires u=
s
> > to maintain an internal rb tree to keep track of writeback state on the
> > temporary folios.
> >
> > A recent change prevents reclaim logic from waiting on writeback for
> > folios whose mappings have the AS_WRITEBACK_MAY_BLOCK flag set in it.
> > This commit sets AS_WRITEBACK_MAY_BLOCK on FUSE inode mappings (which
> > will prevent FUSE folios from running into the reclaim deadlock describ=
ed
> > above) and removes the temporary folio + extra copying and the internal
> > rb tree.
> >
> > fio benchmarks --
> > (using averages observed from 10 runs, throwing away outliers)
> >
> > Setup:
> > sudo mount -t tmpfs -o size=3D30G tmpfs ~/tmp_mount
> >  ./libfuse/build/example/passthrough_ll -o writeback -o max_threads=3D4=
 -o source=3D~/tmp_mount ~/fuse_mount
> >
> > fio --name=3Dwriteback --ioengine=3Dsync --rw=3Dwrite --bs=3D{1k,4k,1M}=
 --size=3D2G
> > --numjobs=3D2 --ramp_time=3D30 --group_reporting=3D1 --directory=3D/roo=
t/fuse_mount
> >
> >         bs =3D  1k          4k            1M
> > Before  351 MiB/s     1818 MiB/s     1851 MiB/s
> > After   341 MiB/s     2246 MiB/s     2685 MiB/s
> > % diff        -3%          23%         45%
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>
> I think there are some places checking or waiting for writeback could be
> reconsidered if they are still needed or not after we dropping the temp
> page design.
>
> As they are inherited from the original implementation, at least they
> are harmless.  I think they could be remained in this patch, and could
> be cleaned up later if really needed.
>

Thank you for the thorough inspection!

>
> > @@ -891,7 +813,7 @@ static int fuse_do_readfolio(struct file *file, str=
uct folio *folio)
> >        * have writeback that extends beyond the lifetime of the folio. =
 So
> >        * make sure we read a properly synced folio.
> >        */
> > -     fuse_wait_on_folio_writeback(inode, folio);
> > +     folio_wait_writeback(folio);
>
> I doubt if wait-on-writeback is needed here, as now page cache won't be
> freed until the writeback IO completes.
>
> The routine attempts to free page cache, e.g. invalidate_inode_pages2()
> (generally called by distributed filesystems when the file content has
> been modified from remote) or truncate_inode_pages() (called from
> truncate(2) or inode eviction) will wait for writeback completion (if
> any) before freeing page.
>
> Thus I don't think there's any possibility that .read_folio() or
> .readahead() will be called when the writeback has not completed.
>

Great point. I'll remove this line and the comment above it too.

>
> > @@ -1172,7 +1093,7 @@ static ssize_t fuse_send_write_pages(struct fuse_=
io_args *ia,
> >       int err;
> >
> >       for (i =3D 0; i < ap->num_folios; i++)
> > -             fuse_wait_on_folio_writeback(inode, ap->folios[i]);
> > +             folio_wait_writeback(ap->folios[i]);
>
> Ditto.
>

Why did we need this fuse_wait_on_folio_writeback() even when we had
the temp pages? If I'm understanding it correctly,
fuse_send_write_pages() is only called for the writethrough case (by
fuse_perform_write()), so these folios would never even be under
writeback, no?

>
>
> >  static void fuse_writepage_args_page_fill(struct fuse_writepage_args *=
wpa, struct folio *folio,
> > -                                       struct folio *tmp_folio, uint32=
_t folio_index)
> > +                                       uint32_t folio_index)
> >  {
> >       struct inode *inode =3D folio->mapping->host;
> >       struct fuse_args_pages *ap =3D &wpa->ia.ap;
> >
> > -     folio_copy(tmp_folio, folio);
> > -
> > -     ap->folios[folio_index] =3D tmp_folio;
> > +     folio_get(folio);
>
> I still think this folio_get() here is harmless but redundant.
>
> Ditto page cache won't be freed before writeback completes.
>
> Besides, other .writepages() implementaions e.g. iomap_writepages() also
> doen't get the refcount when constructing the writeback IO.
>

Point taken. I'll remove this then, since other .writepages() also
don't obtain a refcount.

>
> > @@ -2481,7 +2200,7 @@ static int fuse_write_begin(struct file *file, st=
ruct address_space *mapping,
> >       if (IS_ERR(folio))
> >               goto error;
> >
> > -     fuse_wait_on_page_writeback(mapping->host, folio->index);
> > +     folio_wait_writeback(folio);
>
> I also doubt if wait_on_writeback() is needed here, as now there won't
> be duplicate writeback IOs for the same page.

What prevents there from being a duplicate writeback write for the
same page? This is the path I'm looking at:

ksys_write()
  vfs_write()
    new_sync_write()
       op->write_iter()
          fuse_file_write_iter()
            fuse_cache_write_iter()
               generic_file_write_iter()
                   __generic_file_write_iter()
                       generic_perform_write()
                           op->write_begin()
                               fuse_write_begin()

but I'm not seeing where there's anything that prevents a duplicate
write from happening.

>
>
> > @@ -2545,13 +2264,11 @@ static int fuse_launder_folio(struct folio *fol=
io)
> >  {
> >       int err =3D 0;
> >       if (folio_clear_dirty_for_io(folio)) {
> > -             struct inode *inode =3D folio->mapping->host;
> > -
> >               /* Serialize with pending writeback for the same page */
> > -             fuse_wait_on_page_writeback(inode, folio->index);
> > +             folio_wait_writeback(folio);
>
> I think folio_wait_writeback() is unneeded after dropping the temp page
> copying.  This is introduced in commit
> 3993382bb3198cc5e263c3519418e716bd57b056 ("fuse: launder page should
> wait for page writeback") since .launder_page() could be called when the
> previous writeback of the same page has not completed yet.  Since now we
> won't clear PG_writeback until the writeback completes, .launder_page()
> won't be called on the same page when the corresponding writeback IO is
> still inflight.
>

Nice catch, I'll remove this in v4.


Thanks,
Joanne

>
> --
> Thanks,
> Jingbo

