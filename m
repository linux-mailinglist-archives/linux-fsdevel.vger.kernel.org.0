Return-Path: <linux-fsdevel+bounces-46218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E96A84958
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 18:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34D1C19E537D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 16:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912C01EDA02;
	Thu, 10 Apr 2025 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/MEWwxE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B5C196D90
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744301503; cv=none; b=SDYqEpLXpsHlTITsSedf+gc8CzU46oDQC/026+Hcthz6IrfCAaMI4wc1/TYey886ea2ImX46gJEtpE2t8TMtsRgpAslC7m0L/NPz5O3sp/oWWsWTW+AU6UP/WfPU8FG38i+sWbQpTyFQWc31+S09Bsx7qd4S+cK+AoXAc5xaW24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744301503; c=relaxed/simple;
	bh=kqWnCGJRO4LAg9CN4GjUV2b8GoYF+haOXX7eu96xHE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6PUtqwwAnANrCXsO3qNnwGSmef+vwFVeraPtFZI2fSONnghIQ8iucauKMLVSgnN4tnJBrIRNojqHwyr6GcdhOg4iS3jajOYZOe07Zh58yjo3TZgEXmvr5v02taQKGfH6J/g062ytVsA8WtJ9rjydcd1dKJEc3mZcz1JxG6k8XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/MEWwxE; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4766631a6a4so8742301cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 09:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744301499; x=1744906299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usXxrhDoknZeVBxvwY3ZQkR0+/Xv+tfgIblFwC2g8ns=;
        b=e/MEWwxEFHYAXrykTljMLLvcV6pFeSQoqcpIusyoU+iSAybRWoweRu0/yn0aFo80jX
         eN9DS4700uuPbSIgFzZlAUjWBMk7jJYjjs+a33r1AHc1zhffPRboQN4iKz/js1+fhsYn
         gth/RSRX3BnQxF+IsXJEzR8pJMVZmTAq7bFZO+DJVQimmvSqAQpMmIrWZGNwsf+FOqV9
         +wDoDmFGdF1sQC/YzKSIExF8/2oB23lP9UCRbuiWI6L9j55JNoVTwiqDFe36ra/cqjvF
         k5H9qZ03i5ycsoGGi7f6olNJ9XZcxWaL1sMhF2brmgVxtML/dbKh9eyVKqGfZVyq0+a0
         7iCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744301499; x=1744906299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usXxrhDoknZeVBxvwY3ZQkR0+/Xv+tfgIblFwC2g8ns=;
        b=L3kJKvmKu6KkWob7ez8+js/UjJPJDBnM1RYWbtd7K+wlDsPDwRJPxIokjUcjyG7V1i
         A6lX4IQYRkXuqOe1US6Jwm/jMxue04Fbtelnp93Ob2cMUedA5uYEa0TRVISognsKy/HB
         I0UG3A2PphGFmxT+C6Xn+TpA3HXZzG1r22o2tCcskzVy7KGJQ8gU+DVcWinHVpWGPL3t
         cq90S2S2/wTLe609Deyjf+Rh0AbDADmVvGohBq6aIJpjNLuOGfSOd2TmPI9NivdiPeLA
         6iq9y5MuLc1YIIjRzFdKPOD0XOOFN2P5o+eKxBxhr2dzZlE45kZkUJFGW2FmVjuYgJ6f
         umIw==
X-Forwarded-Encrypted: i=1; AJvYcCVQZA5f+vP1lsMylYJTApt4ZZB+vdevoV9ItHKW1DZZgYBIFQ2GBaWDgnAZF4bUd5Qe5jIlh59PQIj9kC/H@vger.kernel.org
X-Gm-Message-State: AOJu0YwrLOamn8a17FBWgK+N+ZNZe6iLdGE/C+N0F0tinyZt1lVDPQ7E
	niF5OUcFps0xw/rtHscTR3AAytZN4iclBAsI7yfRA5e8KwwWBLzJhtYoHLtKWE0Jk4kJbOSzD7h
	BYmSjKdUM3Y1Wz/5eua28rXlMOmc=
X-Gm-Gg: ASbGnct3tL9TS9g3oJs/frOmAOOvM/JjqV3HTyXuWNzri9G54ecc5WSbFP2bPOctO6F
	V7US4+IBKIsIPzU8/xvQXkKX8s4f9OqudoJZpOvKeh5kmvgGhV5W1cHJiq97kPy5knGf06/ho/M
	HhcUOrdsPKNDNVC9104VqjYA==
X-Google-Smtp-Source: AGHT+IHOMKNDcjT83ijbG7cVz9nkjKDhfcORp5mkizohR3T5dQeIgZsw9Iz92fWM33rFrVyo+F81AdObBNWx5Ui1m+8=
X-Received: by 2002:a05:622a:11cf:b0:474:f4a4:2ca9 with SMTP id
 d75a77b69052e-4796cbc4b84mr40317001cf.25.1744301498809; Thu, 10 Apr 2025
 09:11:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404181443.1363005-1-joannelkoong@gmail.com>
 <20250404181443.1363005-4-joannelkoong@gmail.com> <db4f1411-f6de-4206-a6a3-5c9cf6b6d59d@linux.alibaba.com>
 <CAJnrk1bTGFXy+ZTchC7p4OYUnbfKZ7TtVkCsrsv87Mg1r8KkGA@mail.gmail.com>
 <7e9b1a40-4708-42a8-b8fc-44fa50227e5b@linux.alibaba.com> <CAJnrk1Z7Wi_KPe_TJckpYUVhv9mKX=-YTwaoQRgjT2z0fxD-7g@mail.gmail.com>
 <9a3cfb55-faae-4551-9bef-b9650432848a@linux.alibaba.com>
In-Reply-To: <9a3cfb55-faae-4551-9bef-b9650432848a@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 10 Apr 2025 09:11:28 -0700
X-Gm-Features: ATxdqUHBqT9PC48ClM1VKz8vkcfzG5ve54G0Utl1ySAgNzES2LqGM6vvDM6LZ9s
Message-ID: <CAJnrk1a_YL-Dg4HeVWnmwUVH2tCN2MYu30kiV5KSv4mkezWOZg@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, shakeel.butt@linux.dev, 
	david@redhat.com, bernd.schubert@fastmail.fm, ziy@nvidia.com, 
	jlayton@kernel.org, kernel-team@meta.com, 
	Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 8:11=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
> On 4/10/25 11:07 PM, Joanne Koong wrote:
> > On Wed, Apr 9, 2025 at 7:12=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibab=
a.com> wrote:
> >>
> >>
> >>
> >> On 4/10/25 7:47 AM, Joanne Koong wrote:
> >>>   On Tue, Apr 8, 2025 at 7:43=E2=80=AFPM Jingbo Xu <jefflexu@linux.al=
ibaba.com> wrote:
> >>>>
> >>>> Hi Joanne,
> >>>>
> >>>> On 4/5/25 2:14 AM, Joanne Koong wrote:
> >>>>> In the current FUSE writeback design (see commit 3be5a52b30aa
> >>>>> ("fuse: support writable mmap")), a temp page is allocated for ever=
y
> >>>>> dirty page to be written back, the contents of the dirty page are c=
opied over
> >>>>> to the temp page, and the temp page gets handed to the server to wr=
ite back.
> >>>>>
> >>>>> This is done so that writeback may be immediately cleared on the di=
rty page,
> >>>>> and this in turn is done in order to mitigate the following deadloc=
k scenario
> >>>>> that may arise if reclaim waits on writeback on the dirty page to c=
omplete:
> >>>>> * single-threaded FUSE server is in the middle of handling a reques=
t
> >>>>>   that needs a memory allocation
> >>>>> * memory allocation triggers direct reclaim
> >>>>> * direct reclaim waits on a folio under writeback
> >>>>> * the FUSE server can't write back the folio since it's stuck in
> >>>>>   direct reclaim
> >>>>>
> >>>>> With a recent change that added AS_WRITEBACK_INDETERMINATE and miti=
gates
> >>>>> the situations described above, FUSE writeback does not need to use
> >>>>> temp pages if it sets AS_WRITEBACK_INDETERMINATE on its inode mappi=
ngs.
> >>>>>
> >>>>> This commit sets AS_WRITEBACK_INDETERMINATE on the inode mappings
> >>>>> and removes the temporary pages + extra copying and the internal rb
> >>>>> tree.
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
> >>>>> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> >>>>> Acked-by: Miklos Szeredi <mszeredi@redhat.com>
> >>>>
> >>>
> >>> Hi Jingbo,
> >>>
> >>> Thanks for sharing your analysis for this.
> >>>
> >>>> Overall this patch LGTM.
> >>>>
> >>>> Apart from that, IMO the fi->writectr and fi->queued_writes mechanis=
m is
> >>>> also unneeded then, at least the DIRECT IO routine (i.e.
> >>>
> >>> I took a look at fi->writectr and fi->queued_writes and my
> >>> understanding is that we do still need this. For example, for
> >>> truncates (I'm looking at fuse_do_setattr()), I think we still need t=
o
> >>> prevent concurrent writeback or else the setattr request and the
> >>> writeback request could race which would result in a mismatch between
> >>> the file's reported size and the actual data written to disk.
> >>
> >> I haven't looked into the truncate routine yet.  I will see it later.
> >>
> >>>
> >>>> fuse_direct_io()) doesn't need fuse_sync_writes() anymore.  That is
> >>>> because after removing the temp page, the DIRECT IO routine has alre=
ady
> >>>> been waiting for all inflight WRITE requests, see
> >>>>
> >>>> # DIRECT read
> >>>> generic_file_read_iter
> >>>>   kiocb_write_and_wait
> >>>>     filemap_write_and_wait_range
> >>>
> >>> Where do you see generic_file_read_iter() getting called for direct i=
o reads?
> >>
> >> # DIRECT read
> >> fuse_file_read_iter
> >>   fuse_cache_read_iter
> >>     generic_file_read_iter
> >>       kiocb_write_and_wait
> >>        filemap_write_and_wait_range
> >>       a_ops->direct_IO(),i.e. fuse_direct_IO()
> >>
> >
> > Oh I see, I thought files opened with O_DIRECT automatically call the
> > .direct_IO handler for reads/writes but you're right, it first goes
> > through .read_iter / .write_iter handlers, and the .direct_IO handler
> > only gets invoked through generic_file_read_iter() /
> > generic_file_direct_write() in mm/filemap.c
> >
> > There's two paths for direct io in FUSE:
> > a) fuse server sets fi->direct_io =3D true when a file is opened, which
> > will set the FOPEN_DIRECT_IO bit in ff->open_flags on the kernel side
> > b) fuse server doesn't set fi->direct_io =3D true, but the client opens
> > the file with O_DIRECT
> >
> > We only go through the stack trace you listed above for the b) case.
> > For the a) case, we'll hit
> >
> >         if (ff->open_flags & FOPEN_DIRECT_IO)
> >                 return fuse_direct_read_iter(iocb, to);
> >
> > and
> >
> >         if (ff->open_flags & FOPEN_DIRECT_IO)
> >                 return fuse_direct_write_iter(iocb, from);
> >
> > which will invoke fuse_direct_IO() / fuse_direct_io() without going
> > through the kiocb_write_and_wait() -> filemap_write_and_wait_range() /
> > kiocb_invalidate_pages() -> filemap_write_and_wait_range() you listed
> > above.
> >
> > So for the a) case I think we'd still need the fuse_sync_writes() in
> > case there's still pending writeback.
> >
> > Do you agree with this analysis or am I missing something here?
>
> Yeah, that's true.  But instead of calling fuse_sync_writes(), we can
> call filemap_wait_range() or something similar here.
>

Agreed. Actually, the more I look at this, the more I think we can
replace all fuse_sync_writes() and get rid of it entirely. Right now,
fuse_sync_writes() is called in:

fuse_fsync():
        /*
         * Start writeback against all dirty pages of the inode, then
         * wait for all outstanding writes, before sending the FSYNC
         * request.
         */
        err =3D file_write_and_wait_range(file, start, end);
        if (err)
                goto out;

        fuse_sync_writes(inode);

        /*
         * Due to implementation of fuse writeback
         * file_write_and_wait_range() does not catch errors.
         * We have to do this directly after fuse_sync_writes()
         */
        err =3D file_check_and_advance_wb_err(file);
        if (err)
                goto out;


      We can get rid of the fuse_sync_writes() and
file_check_and_advance_wb_err() entirely since now without temp pages,
the file_write_and_wait_range() call actually ensures that writeback
is completed



fuse_writeback_range():
        static int fuse_writeback_range(struct inode *inode, loff_t
start, loff_t end)
        {
                int err =3D
filemap_write_and_wait_range(inode->i_mapping, start, LLONG_MAX);

                if (!err)
                        fuse_sync_writes(inode);

                return err;
        }


      We can replace fuse_writeback_range() entirely with
filemap_write_and_wait_range().



fuse_direct_io():
        if (fopen_direct_io && fc->direct_io_allow_mmap) {
                res =3D filemap_write_and_wait_range(mapping, pos, pos +
count - 1);
                if (res) {
                        fuse_io_free(ia);
                        return res;
                }
        }
        if (!cuse && filemap_range_has_writeback(mapping, pos, (pos +
count - 1))) {
                if (!write)
                        inode_lock(inode);
                fuse_sync_writes(inode);
                if (!write)
                        inode_unlock(inode);
        }


       I think this can just replaced with
                if (fopen_direct_io && (fc->direct_io_allow_mmap || !cuse))=
 {
                        res =3D filemap_write_and_wait_range(mapping,
pos, pos + count - 1);
                        if (res) {
                                fuse_io_free(ia);
                                return res;
                        }
                }
       since for the !fopen_direct_io case, it will already go through
filemap_write_and_wait_range(), as you mentioned in your previous
message. I think this also fixes a bug (?) in the original code - in
the fopen_direct_io && !fc->direct_io_allow_mmap case, I think we
still need to write out dirty pages first, which we don't currently
do.


What do you think?

Thanks for all your careful review on this patchset throughout all of
its iterations.

>
>
> >> filp_close()
> >>    filp_flush()
> >>        filp->f_op->flush()
> >>            fuse_flush()
> >>              write_inode_now
> >>                 writeback_single_inode(WB_SYNC_ALL)
> >>                   do_writepages
> >>                     # flush dirty page
> >>                   filemap_fdatawait
> >>                     # wait for WRITE completion
> >
> > Nice. I missed that write_inode_now() will invoke filemap_fdatawait().
> > This seems pretty straightforward. I'll remove the fuse_sync_writes()
> > call in fuse_flush() when I send out v8.
> >
> > The direct io one above is less straight-forward. I won't add that to
> > v8 but that can be done in a separate future patch when we figure that
> > out.
>
> Thanks for keep working on this. Appreciated.
>
> --
> Thanks,
> Jingbo

