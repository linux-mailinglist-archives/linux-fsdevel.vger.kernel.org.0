Return-Path: <linux-fsdevel+bounces-34695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCE49C7BFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 20:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4D5281260
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 19:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01C816DEB4;
	Wed, 13 Nov 2024 19:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HS1rgDGN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931DF15ADA4
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 19:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731525077; cv=none; b=Nvfg8/irt+8PYEa0JhSg7dUzyXXmvYCgJzteZRm8jwI+24O1BvvyFQNx8rCi3hC/35p1ieHfgUAe7vPKJJaNtIS3qPPyC29wPTQ2woGCCi1uI2x1/+k5AFSm8UUAg2GF4k2/0bAxlcB8jZM9f0H/wXgBc3dZkaqThPL/r9uVIOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731525077; c=relaxed/simple;
	bh=dEvQZ/Rp8rdqbEfKHmYfGEPJgAxiLLFf60g/fUXYH7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AkoVCa/iaF72ZysJn0eq4KVPu1Q4yXPgUnsJgFRpQQE7MwWxSBfeqNgiEE2VLu3Wd8FMdHxD6fgyuE8JLEVxSiCRe5t5prkoa+znpQr2nS3vOFPikM1fVRD1jK5SYHbBxAmwHzWWcczq/WuGE+WUIw5LZCHoGvUKbJp3CCkCDok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HS1rgDGN; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4609beb631aso56224261cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 11:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731525074; x=1732129874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSBrut3N0dpd6LfoNRacxBDtM2RMZABYpokLf+z8bTU=;
        b=HS1rgDGNGK/gW42nYy62rQexfGzeZWX3ka6Y/IbjhzEojfD/bzLBkbPXQGR/yD3mov
         v8BjL7f4mIXQ2AFS4QB/maqwNhfo+biUAnSRBTguArxB7t6j2DC6rayGov4IVxyuwVvB
         6QybNF0FioTdV5m63opiIkFzIk8MFNz82IGQnrC3rYUqy/HhdtLCSeHqL+yotzhQgVUa
         uGOIIzNUgWPUaGgEu+ckK5dQht1kfOg+4iT84V3aO4iZuWw+ZWZ1kP+bZjdIC5uMpfkg
         Bt+ntXeXYlUqLXwP9UV6IknqjlqAwqXdlYULlKSH/JW4KTtz1PZQm33sHx57YUhGZmCg
         mang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731525074; x=1732129874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSBrut3N0dpd6LfoNRacxBDtM2RMZABYpokLf+z8bTU=;
        b=oBaeOlxaTl9GuADCLEHoy6dIGwuwGPaFS/vRgOCgLp3vFTyVnoI1hNuhH49XeNv+03
         pefZI7Ovp+lcPRhzEl8LoOsVUldxlojQ/x10TR3N00QxcAgcItIVfjL4VJYingE4ePBD
         nc1y3CPN0BoQYW3RDxxuFnlliprdKMhvu/Z6miTWut/XH8vH/egvwZ0EZEWQnAFsdrT8
         VTdPcj96qxPRcmqgBHsjwNfeHIdCRInuejf0MKP3dhjmf4MxfUTCcHaJWT2wtOSgz1+Z
         lVLkc7Wr+bOA6AAHpd720spb1zXV4bvtXk4YxAltsuttCrN+K9T9csTPWAkCj+Bq3R3a
         Tt6w==
X-Forwarded-Encrypted: i=1; AJvYcCWFeMdt7y1l0G0FGzii0LG2j/AnKP1jg2rRTzQtP3uNH6JkLA7/+sWHN3978yVB2U5+HMKPuy2yTd0vMkkI@vger.kernel.org
X-Gm-Message-State: AOJu0YwDZN/cSgyUPx/64Oz5TvF+1ExpxUujciPRu+noIUzkGo/3YyX6
	JYQ6H2PspHiDXEOtOtQkqgr0Q3OyzTylOIJchqc12aI2ezSkitW/HiexfCK0DJ9xrt9dSyNE3Mo
	RVAsMjejExpo3M8clvsVunqh39No/Mg8D
X-Google-Smtp-Source: AGHT+IFPJJbBhxVGcgdqW6QLdVkip9zPAmkCQZfT1n2oiMB44YjAHmM9BN8yFhK0Lj+ep5pHWcYyslrgxfA5PY7+JrY=
X-Received: by 2002:ac8:598d:0:b0:461:15a1:7889 with SMTP id
 d75a77b69052e-4630933b004mr332251821cf.16.1731525074427; Wed, 13 Nov 2024
 11:11:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107235614.3637221-1-joannelkoong@gmail.com>
 <20241107235614.3637221-7-joannelkoong@gmail.com> <9c0dbdac-0aed-467c-86c7-5b9a9f96d89d@linux.alibaba.com>
 <CAJnrk1YUPZhCUhGqu+bBngzrG-yCCRLZc7fiOfXQZ0dxCHJV8Q@mail.gmail.com> <0f585a7c-678b-492a-9492-358f21e57291@linux.alibaba.com>
In-Reply-To: <0f585a7c-678b-492a-9492-358f21e57291@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 13 Nov 2024 11:11:03 -0800
Message-ID: <CAJnrk1YvCj2t123iRgyewfWkMBYBMJsw+s47su-=13u4dF7W3Q@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, shakeel.butt@linux.dev, 
	josef@toxicpanda.com, linux-mm@kvack.org, bernd.schubert@fastmail.fm, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 6:31=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
>
>
> On 11/12/24 5:30 AM, Joanne Koong wrote:
> > On Mon, Nov 11, 2024 at 12:32=E2=80=AFAM Jingbo Xu <jefflexu@linux.alib=
aba.com> wrote:
> >>
> >> Hi, Joanne and Miklos,
> >>
> >> On 11/8/24 7:56 AM, Joanne Koong wrote:
> >>> Currently, we allocate and copy data to a temporary folio when
> >>> handling writeback in order to mitigate the following deadlock scenar=
io
> >>> that may arise if reclaim waits on writeback to complete:
> >>> * single-threaded FUSE server is in the middle of handling a request
> >>>   that needs a memory allocation
> >>> * memory allocation triggers direct reclaim
> >>> * direct reclaim waits on a folio under writeback
> >>> * the FUSE server can't write back the folio since it's stuck in
> >>>   direct reclaim
> >>>
> >>> To work around this, we allocate a temporary folio and copy over the
> >>> original folio to the temporary folio so that writeback can be
> >>> immediately cleared on the original folio. This additionally requires=
 us
> >>> to maintain an internal rb tree to keep track of writeback state on t=
he
> >>> temporary folios.
> >>>
> >>> A recent change prevents reclaim logic from waiting on writeback for
> >>> folios whose mappings have the AS_WRITEBACK_MAY_BLOCK flag set in it.
> >>> This commit sets AS_WRITEBACK_MAY_BLOCK on FUSE inode mappings (which
> >>> will prevent FUSE folios from running into the reclaim deadlock descr=
ibed
> >>> above) and removes the temporary folio + extra copying and the intern=
al
> >>> rb tree.
> >>>
> >>> fio benchmarks --
> >>> (using averages observed from 10 runs, throwing away outliers)
> >>>
> >>> Setup:
> >>> sudo mount -t tmpfs -o size=3D30G tmpfs ~/tmp_mount
> >>>  ./libfuse/build/example/passthrough_ll -o writeback -o max_threads=
=3D4 -o source=3D~/tmp_mount ~/fuse_mount
> >>>
> >>> fio --name=3Dwriteback --ioengine=3Dsync --rw=3Dwrite --bs=3D{1k,4k,1=
M} --size=3D2G
> >>> --numjobs=3D2 --ramp_time=3D30 --group_reporting=3D1 --directory=3D/r=
oot/fuse_mount
> >>>
> >>>         bs =3D  1k          4k            1M
> >>> Before  351 MiB/s     1818 MiB/s     1851 MiB/s
> >>> After   341 MiB/s     2246 MiB/s     2685 MiB/s
> >>> % diff        -3%          23%         45%
> >>>
> >>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >>
> >>
> >> IIUC this patch seems to break commit
> >> 8b284dc47291daf72fe300e1138a2e7ed56f38ab ("fuse: writepages: handle sa=
me
> >> page rewrites").
> >>
> >
> > Interesting!  My understanding was that we only needed that commit
> > because we were clearing writeback on the original folio before
> > writeback had actually finished.
> >
> > Now that folio writeback state is accounted for normally (eg through
> > writeback being set/cleared on the original folio), does the
> > folio_wait_writeback() call we do in fuse_page_mkwrite() not mitigate
> > this?
>
> Yes, after inspecting the writeback logic more, it seems that the second
> writeback won't be initiated if the first one has not completed yet, see
>
> ```
> a_ops->writepages
>   write_cache_pages
>     writeback_iter
>       writeback_get_folio
>         folio_prepare_writeback
>           if folio_test_writeback(folio):
>             folio_wait_writeback(folio)
> ```
>
> and thus it won't be an issue to remove the auxiliary list ;)
>

Awesome, thanks for double-checking!

> >
> >>> -     /*
> >>> -      * Being under writeback is unlikely but possible.  For example=
 direct
> >>> -      * read to an mmaped fuse file will set the page dirty twice; o=
nce when
> >>> -      * the pages are faulted with get_user_pages(), and then after =
the read
> >>> -      * completed.
> >>> -      */
> >>
> >> In short, the target scenario is like:
> >>
> >> ```
> >> # open a fuse file and mmap
> >> fd1 =3D open("fuse-file-path", ...)
> >> uaddr =3D mmap(fd1, ...)
> >>
> >> # DIRECT read to the mmaped fuse file
> >> fd2 =3D open("ext4-file-path", O_DIRECT, ...)
> >> read(fd2, uaddr, ...)
> >>     # get_user_pages() of uaddr, and triggers faultin
> >>     # a_ops->dirty_folio() <--- mark PG_dirty
> >>
> >>     # when DIRECT IO completed:
> >>     # a_ops->dirty_folio() <--- mark PG_dirty
> >
> > If you have the direct io function call stack at hand, could you point
> > me to the function where the direct io completion marks this folio as
> > dirty?
>
>
> FYI The full call stack is like:
>
> ```
> # DIRECT read(2) to the mmaped fuse file
> read(fd2, uaddr1, ...)
>   f_ops->read_iter()
>     (iomap-based ) iomap_dio_rw
>       # for READ && user_backed_iter(iter):
>         dio->flags |=3D IOMAP_DIO_DIRTY
>       iomap_dio_iter
>         iomap_dio_bio_iter
>           # add user or kernel pages to a bio
>           bio_iov_iter_get_pages
>             ...
>             pin_user_pages_fast(..., FOLL_WRITE, ...)
>               # find corresponding vma of dest buffer (fuse page cache)
>               # search page table (pet) to find corresponding page
>               # if not fault yet, trigger explicit faultin:
>                 faultin_page(..., FOLL_WRITE, ...)
>                   handle_mm_fault(..., FAULT_FLAG_WRITE)
>                     handle_pte_fault
>                       do_wp_page
>                         (vma->vm_flags & VM_SHARED) wp_page_shared
>                           ...
>                           fault_dirty_shared_page
>                             folio_mark_dirty
>                               a_ops->dirty_folio(), i.e.,
> filemap_dirty_folio()
>                                 # set PG_dirty
>                                 folio_test_set_dirty(folio)
>                                 # set PAGECACHE_TAG_DIRTY
>                                 __folio_mark_dirty
>
>
>           # if dio->flags & IOMAP_DIO_DIRTY:
>           bio_set_pages_dirty
>             (for each dest page) folio_mark_dirty
>                a_ops->dirty_folio(), i.e., filemap_dirty_folio()
>                  # set PG_dirty
>                  folio_test_set_dirty(folio)
>                  # set PAGECACHE_TAG_DIRTY
>                  __folio_mark_dirty
> ```
>

Thanks for this info, Jingbo.

>
> >
> >> ```
> >>
> >> The auxiliary write request list was introduced to fix this.
> >>
> >> I'm not sure if there's an alternative other than the auxiliary list t=
o
> >> fix it, e.g. calling folio_wait_writeback() in a_ops->dirty_folio() so
> >> that the same folio won't get dirtied when the writeback has not
> >> completed yet?
> >>
> >
> > I'm curious how other filesystems solve for this - this seems like a
> > generic situation other filesystems would run into as well.
> >
>
> As mentioned above, the writeback path will prevent the duplicate
> writeback request on the same page when the first writeback IO has not
> completed yet.
>
> Sorry for the noise...
>
> --
> Thanks,
> Jingbo

