Return-Path: <linux-fsdevel+bounces-34968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD939CF3F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 19:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645861F21ED0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 18:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99276185B48;
	Fri, 15 Nov 2024 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nclNBoqv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F3817BB32
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731695410; cv=none; b=A7DfAIqHM76Ltdukh4NWmZ2nNNeSLuHcMsBIyIrUcnRNGVrxJEjS3rutckwdNChuQqM/aEnbB9xH/wvTP4Hq42hNRdt9nbAWjvf2e0Cvz+9wCSJLeLsR15mBIpOjvWwN5MsM1UNSQ1BVhAmMe8K6H4LWMvcYWtimwNUBcg3Gyqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731695410; c=relaxed/simple;
	bh=UEJYVr+w2axC63BoNZ8jRGBp8oglH6FCh557REC/RMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQAAylPH5Ih7d+xSzOViU1KXUmU21FuX0vPI60MJHkOUZEiiEXPlmFbyGF18+7a2Od/xb0cvWm6heoMK1fnf1tn8UemDY3AfwcdectJ/N1EA3RjcPea5y2fvtjjMAr58BR+vxpZz2h2c0uxCJHOMXtx7EDfU3wZpgplBNgGejzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nclNBoqv; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-460ace055d8so6874731cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 10:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731695407; x=1732300207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgWDIT45dQIM+h/phEG2pY1AjbP8LJBfsmHjONXWjVg=;
        b=nclNBoqv404pgFBl9Rh4Ul5bg/RuuiF6xShUj6yqqkJVOxXvIJ1WEHhZ3TIrdK6WV5
         vtQa4ZwmAZnrH65VmJJQiDg+PbFywruxTe1jFRXmUonLERWVJgNv08xIjKz5dkrRodqL
         rARqxRzjLlVl1xw3565NdAnTeiUmr8ao+zae1GsoX2DzUTdtLBIrpiPuT4PqvU2B53zp
         NazB/FNy5gas5nkleSeCAp1f3uH9Nw89/rmLBtArVOpq/03PtNv4FJXHlsk3uMnWFcsl
         M43ESWrNOQi+yKCusSPKet2DWPO8pFx54WWyvqRy7ENvhMYi7CPgct7jh6TsmTeBI8BX
         Onjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731695407; x=1732300207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgWDIT45dQIM+h/phEG2pY1AjbP8LJBfsmHjONXWjVg=;
        b=Iqs/8fEhzSABZbZan1SLZJjiRgln7MCTEx4zh2TD1QlQBzY0dVlgDT67xolNm7WfRu
         38pu3gzpqP59HjC96pFak+yiPx66Kf4wagK8GDJBJtoH+cb+Vem0eDEm0AvWEMe0MVK/
         yp+O6S90MoCs6QwTXR/EFrtTcYrnVEynbOAsAERSRYDSkQer+SraUU1myYb0mxajL3JP
         eVPHc/RxVYShp/Ar6gez9BdxEzzBiF2IK4Mf9s0mbbr4zT4paIq8U5Wl7b1/VvnnU4yw
         javIMFI2LM/1oG8PDNf+nQ1BRr9hx6lFeDU8Cp0ENBTyyN6OYx3Xg4QMc9RtQDXREgEv
         /DUw==
X-Forwarded-Encrypted: i=1; AJvYcCUqdGNcMRqG/U8SxECYqs4+ML+sVEGcbDHHQntMaAm4FrxaLpqpFCZ3SLtW0kXZphfRA2K+8nwgtBQG75Gq@vger.kernel.org
X-Gm-Message-State: AOJu0YydwP32dL0jZ0gfn0rEtcUIbJltM0OBjzCfvk3TmQvcRi+CVugm
	PM4thaUYT4U1MOpOKpr7tO+hXVI6RUiheeXBBwnzR8v648IFLvJqOXurnbNwsrfTiXSYLY4wuQn
	LYRZkTj2u5+Z454jyFmSzewYSZK4=
X-Google-Smtp-Source: AGHT+IFCTpzSuKNN8yphcjMu6Ku0wflbo+Dlo0yXROFq5GUOLZ+cx88al9g3ArsoqKVhUX8D+APpxzzrhxm0nNp+1MU=
X-Received: by 2002:a05:622a:c7:b0:460:7b6e:9475 with SMTP id
 d75a77b69052e-46363de8150mr42619061cf.10.1731695406832; Fri, 15 Nov 2024
 10:30:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107235614.3637221-1-joannelkoong@gmail.com>
 <20241107235614.3637221-7-joannelkoong@gmail.com> <e85bd643-894e-4eb2-994b-62f0d642b4f1@linux.alibaba.com>
 <CAJnrk1bS6J9NXae5bXTF+MrKV2VZ-2bi=WqkyY1XY2BggA01TQ@mail.gmail.com>
 <47661fe5-8616-4133-8d9c-faeb1ab96962@linux.alibaba.com> <CAJnrk1Y+CZq5uL72kp1vXxF4Vf1kf+Nk_oGmYFHA8b-uw2gfgQ@mail.gmail.com>
 <8cd0a96c-7d8f-4a38-afc6-2c48bc701da8@linux.alibaba.com>
In-Reply-To: <8cd0a96c-7d8f-4a38-afc6-2c48bc701da8@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 15 Nov 2024 10:29:56 -0800
Message-ID: <CAJnrk1Z05CP6dTu0Wym020OWf=cyt2BRSP7vNshRmDVqUHL0Yg@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, shakeel.butt@linux.dev, 
	josef@toxicpanda.com, linux-mm@kvack.org, bernd.schubert@fastmail.fm, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 6:18=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
>
>
> On 11/15/24 2:19 AM, Joanne Koong wrote:
> > On Wed, Nov 13, 2024 at 5:47=E2=80=AFPM Jingbo Xu <jefflexu@linux.aliba=
ba.com> wrote:
> >>
> >>
> >>
> >> On 11/14/24 8:39 AM, Joanne Koong wrote:
> >>> On Tue, Nov 12, 2024 at 1:25=E2=80=AFAM Jingbo Xu <jefflexu@linux.ali=
baba.com> wrote:
> >>>>
> >>>> Hi Joanne,
> >>>>
> >>>> On 11/8/24 7:56 AM, Joanne Koong wrote:
> >>>>> Currently, we allocate and copy data to a temporary folio when
> >>>>> handling writeback in order to mitigate the following deadlock scen=
ario
> >>>>> that may arise if reclaim waits on writeback to complete:
> >>>>> * single-threaded FUSE server is in the middle of handling a reques=
t
> >>>>>   that needs a memory allocation
> >>>>> * memory allocation triggers direct reclaim
> >>>>> * direct reclaim waits on a folio under writeback
> >>>>> * the FUSE server can't write back the folio since it's stuck in
> >>>>>   direct reclaim
> >>>>>
> >>>>> To work around this, we allocate a temporary folio and copy over th=
e
> >>>>> original folio to the temporary folio so that writeback can be
> >>>>> immediately cleared on the original folio. This additionally requir=
es us
> >>>>> to maintain an internal rb tree to keep track of writeback state on=
 the
> >>>>> temporary folios.
> >>>>>
> >>>>> A recent change prevents reclaim logic from waiting on writeback fo=
r
> >>>>> folios whose mappings have the AS_WRITEBACK_MAY_BLOCK flag set in i=
t.
> >>>>> This commit sets AS_WRITEBACK_MAY_BLOCK on FUSE inode mappings (whi=
ch
> >>>>> will prevent FUSE folios from running into the reclaim deadlock des=
cribed
> >>>>> above) and removes the temporary folio + extra copying and the inte=
rnal
> >>>>> rb tree.
> >>>>>
> >>>>> fio benchmarks --
> >>>>> (using averages observed from 10 runs, throwing away outliers)
> >>>>>
> >>>>> Setup:
> >>>>> sudo mount -t tmpfs -o size=3D30G tmpfs ~/tmp_mount
> >>>>>  ./libfuse/build/example/passthrough_ll -o writeback -o max_threads=
=3D4 -o source=3D~/tmp_mount ~/fuse_mount
> >>>>>
> >>>>> fio --name=3Dwriteback --ioengine=3Dsync --rw=3Dwrite --bs=3D{1k,4k=
,1M} --size=3D2G
> >>>>> --numjobs=3D2 --ramp_time=3D30 --group_reporting=3D1 --directory=3D=
/root/fuse_mount
> >>>>>
> >>>>>         bs =3D  1k          4k            1M
> >>>>> Before  351 MiB/s     1818 MiB/s     1851 MiB/s
> >>>>> After   341 MiB/s     2246 MiB/s     2685 MiB/s
> >>>>> % diff        -3%          23%         45%
> >>>>>
> >>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >>>>
> >>>> I think there are some places checking or waiting for writeback coul=
d be
> >>>> reconsidered if they are still needed or not after we dropping the t=
emp
> >>>> page design.
> >>>>
> >>>> As they are inherited from the original implementation, at least the=
y
> >>>> are harmless.  I think they could be remained in this patch, and cou=
ld
> >>>> be cleaned up later if really needed.
> >>>>
> >>>
> >>> Thank you for the thorough inspection!
> >>>
> >>>>
> >>>>> @@ -891,7 +813,7 @@ static int fuse_do_readfolio(struct file *file,=
 struct folio *folio)
> >>>>>        * have writeback that extends beyond the lifetime of the fol=
io.  So
> >>>>>        * make sure we read a properly synced folio.
> >>>>>        */
> >>>>> -     fuse_wait_on_folio_writeback(inode, folio);
> >>>>> +     folio_wait_writeback(folio);
> >>>>
> >>>> I doubt if wait-on-writeback is needed here, as now page cache won't=
 be
> >>>> freed until the writeback IO completes.
> >>>>
> >>>> The routine attempts to free page cache, e.g. invalidate_inode_pages=
2()
> >>>> (generally called by distributed filesystems when the file content h=
as
> >>>> been modified from remote) or truncate_inode_pages() (called from
> >>>> truncate(2) or inode eviction) will wait for writeback completion (i=
f
> >>>> any) before freeing page.
> >>>>
> >>>> Thus I don't think there's any possibility that .read_folio() or
> >>>> .readahead() will be called when the writeback has not completed.
> >>>>
> >>>
> >>> Great point. I'll remove this line and the comment above it too.
> >>>
> >>>>
> >>>>> @@ -1172,7 +1093,7 @@ static ssize_t fuse_send_write_pages(struct f=
use_io_args *ia,
> >>>>>       int err;
> >>>>>
> >>>>>       for (i =3D 0; i < ap->num_folios; i++)
> >>>>> -             fuse_wait_on_folio_writeback(inode, ap->folios[i]);
> >>>>> +             folio_wait_writeback(ap->folios[i]);
> >>>>
> >>>> Ditto.
> >>
> >> Actually this is a typo and I originally meant that waiting for
> >> writeback in fuse_send_readpages() is unneeded as page cache won't be
> >> freed until the writeback IO completes.
> >>
> >>> -     wait_event(fi->page_waitq, !fuse_range_is_writeback(inode, firs=
t, last));
> >>> +     filemap_fdatawait_range(inode->i_mapping, first, last);
> >>
> >
> > Gotcha and agreed. I'll remove this wait from readahead().
> >
> >>
> >> In fact the above waiting for writeback in fuse_send_write_pages() is
> >> needed.  The reason is as follows:
> >>
> >>>>
> >>>
> >>> Why did we need this fuse_wait_on_folio_writeback() even when we had
> >>> the temp pages? If I'm understanding it correctly,
> >>> fuse_send_write_pages() is only called for the writethrough case (by
> >>> fuse_perform_write()), so these folios would never even be under
> >>> writeback, no?
> >>
> >> I think mmap write could make the page dirty and the writeback could b=
e
> >> triggered then.
> >>
> >
> > Ohhh I see, thanks for the explanation.
> >
> >>>
> >>>>
> >>>>
> >>>>>  static void fuse_writepage_args_page_fill(struct fuse_writepage_ar=
gs *wpa, struct folio *folio,
> >>>>> -                                       struct folio *tmp_folio, ui=
nt32_t folio_index)
> >>>>> +                                       uint32_t folio_index)
> >>>>>  {
> >>>>>       struct inode *inode =3D folio->mapping->host;
> >>>>>       struct fuse_args_pages *ap =3D &wpa->ia.ap;
> >>>>>
> >>>>> -     folio_copy(tmp_folio, folio);
> >>>>> -
> >>>>> -     ap->folios[folio_index] =3D tmp_folio;
> >>>>> +     folio_get(folio);
> >>>>
> >>>> I still think this folio_get() here is harmless but redundant.
> >>>>
> >>>> Ditto page cache won't be freed before writeback completes.
> >>>>
> >>>> Besides, other .writepages() implementaions e.g. iomap_writepages() =
also
> >>>> doen't get the refcount when constructing the writeback IO.
> >>>>
> >>>
> >>> Point taken. I'll remove this then, since other .writepages() also
> >>> don't obtain a refcount.
> >>>
> >>>>
> >>>>> @@ -2481,7 +2200,7 @@ static int fuse_write_begin(struct file *file=
, struct address_space *mapping,
> >>>>>       if (IS_ERR(folio))
> >>>>>               goto error;
> >>>>>
> >>>>> -     fuse_wait_on_page_writeback(mapping->host, folio->index);
> >>>>> +     folio_wait_writeback(folio);
> >>>>
> >>>> I also doubt if wait_on_writeback() is needed here, as now there won=
't
> >>>> be duplicate writeback IOs for the same page.
> >>>
> >>> What prevents there from being a duplicate writeback write for the
> >>> same page? This is the path I'm looking at:
> >>>
> >>> ksys_write()
> >>>   vfs_write()
> >>>     new_sync_write()
> >>>        op->write_iter()
> >>>           fuse_file_write_iter()
> >>>             fuse_cache_write_iter()
> >>>                generic_file_write_iter()
> >>>                    __generic_file_write_iter()
> >>>                        generic_perform_write()
> >>>                            op->write_begin()
> >>>                                fuse_write_begin()
> >>>
> >>> but I'm not seeing where there's anything that prevents a duplicate
> >>> write from happening.
> >>
> >> I mean there won't be duplicate *writeback* rather than *write* for th=
e
> >> same page.  You could write the page cache and make it dirty at the ti=
me
> >> when the writeback for the same page is still on going, as long as we
> >> can ensure that even when the page is dirtied again, there won't be a
> >> duplicate writeback IO for the same page when the previous writeback I=
O
> >> has not completed yet.
> >>
> >
> > I think we still need this folio_wait_writeback() since we're calling
> > fuse_do_readfolio() and removing the folio_wait_writeback() from
> > fuse_do_readfolio(). else we could read back stale data if the
> > writeback hasn't gone through yet.
> > I think we could probably move the folio_wait_writeback() here in
> > fuse_write_begin() to be right before the fuse_do_readfolio() call and
> > skip waiting on writeback if we hit the "success" gotos.
>
> IIUC if cache hit when fuse_write_begin() is called, the page is marked
> with PG_update which indicates that (.readpage()) the IO request reading
> data from disk to page is already done.  Thus fuse_write_begin() will do
> nothing and return directly.
>
> >       if (folio_test_uptodate(folio) || len >=3D folio_size(folio))
> >               goto success;
>
> Otherwise fuse_do_readfolio() is called to read data when cache miss,
> i.e. the page doesn't exist in the page cache before or it gets
> invalidated previously.  Since we can ensure that no page can be
> invalidated until the writeback IO completes, we can ensure that there's
> no in-flight writeback IO when fuse_do_readfolio() is called.
>
> Other folks can also correct me if I get wrong, since I also attempts to
> figure out all these details about the page cache management recently.
>

You're right, this writeback wait is unneeded. I'll remove this for v5.

Thanks,
Joanne
>
> --
> Thanks,
> Jingbo

