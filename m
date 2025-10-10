Return-Path: <linux-fsdevel+bounces-63724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56674BCBC79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 08:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 313E04E7216
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 06:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C532376FD;
	Fri, 10 Oct 2025 06:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVpvYMxg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366D522258C
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 06:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760077539; cv=none; b=uB59AUQ6wHNzcqQedV+etZXnNTCBAPl5fqcXhijLEtpb1NDEXjzIu4qz15IizQlFvXXE46tQDbf+mhr0q1EOd6r2clfGNADmeFjD/81BVOKsuKXV4Yk7fT27obRupTjdQa/eMNDBVlpTLKlJaDUqnaHjVq3wWBBcFt/4lCmS1+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760077539; c=relaxed/simple;
	bh=S9pKXp1mceGitAT8F7nE1DIMm5o+Yfn5ytYnNhoHYYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bgh5igDdRDZTEAsvgmorbExMs1Tr89h4b6PL7Qcj/xYDN1+KUXGvHuYhDLjhmc5hsUFWzp2pc3bJupMbyp9F548FsCjxLLvaRaE9aZNXuf5u0ydJx1hEjONgyLMXSrGFRuz/rkGTugqfw0l/8zRyWXq3uCx7Gb3j4FeZAuLO6LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVpvYMxg; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-6354a3dbe97so248477d50.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 23:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760077536; x=1760682336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QfbWcG5kCfyEKR1UKuhCeI2DEJzoEgMMDIvKNtEeRM=;
        b=eVpvYMxg6IY0vb0eA9W16KwJGb5BaXQci+qyD+SUgvVKRFh+Iyzar7qkHH5xcuLOa/
         GrqQLOezSA1rSNoG7qcaw92kj+JGE4kkQ4C40H+jk95yEkHnB59HETZrFxf5nNJGXW0j
         IaQ/qERmBfCpAdDX9Kt5mRVln9lUPFaPE8B3z0xO/fTqZioedllGU3ewaWwamB6nfxL+
         TQk941Qf8N9RUKh1D582DMXJ/f5Y+qtFVh4TmYC3yps8c2kDpkN0bGyI7WE4/2bINhMd
         MNmyt1h9FC8pjexL3YFy+0FPaeICrBvWmQba9+1MhNgNsb+/vMDV8wPMwNsEPXF0oySN
         2cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760077536; x=1760682336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/QfbWcG5kCfyEKR1UKuhCeI2DEJzoEgMMDIvKNtEeRM=;
        b=qkBIzxRQuTfMX1Rkfhh2go3BTJbZzfEsE2ZCea7pLq1AJGn9nLpN2fQ94X3RiIsFE/
         7LOT80RAx1oR3r4Glr2G6Ow4La3ScJEidNzguSrdCaVaJ9TIV4kh+ROQBCqz+Y+urG9A
         gbYv221H8kW8RdcaE/UDsh5gQEMKhN+n6dlG9zrC9mhRl9u9cvwcHCpNFvjcdJLR8egJ
         fBzwybzZ5+cs2qEFSqJ5hyE0dt2Pz5Iv/qF0xU7ktZfOOs1WYjYpedu1vBxxO3ldMhhd
         nz1deaz86qYuwjtOTabgRQNecHONjLr6vrL6k7s3hWCapepcB4B9WLYBk9ARpgpyH1Nx
         yKxA==
X-Forwarded-Encrypted: i=1; AJvYcCVJk7/+6512woSvnRP2IfKI0JZuNRwTk0j8fVO5BIfQ0m3y1lEegUL9lUBPLAGdSOG+7EkAjOab8uwOgSIC@vger.kernel.org
X-Gm-Message-State: AOJu0YzY00uozbuS73ZFF9BirQuta4O07mnlfXLRC+F+Tm6P6V5M9ffW
	OTPoq2O1U0CP9rWqh+pqLa8LWQaObwGMAs827NU1rd8VZawWi0jt3uQyht8fqLf61CAuPUZjckE
	pLbWGNNjgcJiXYBSA19nX6a6JXO+CxEw=
X-Gm-Gg: ASbGnctA+biMG2mxg99ta8z5iI0Ex4d0Fydu+vtuZXzM/JgIJK9kMcxmvTAUo88uErs
	CkGff6CoDA+SeyLUBChwCTjaWMIkanb8UdtCpu78CrwQMcJo8YbFkdX3Wz/wAi+6e3Bt0sVDHvP
	SwMM901lzcYxtn21gF9k2ZgdJr7yDoWp/B/HSGVBzgYWqOC59fW0mWVz7HgM3QLv6K6E32QgNNu
	QS5E+AuExHoOETkteIuIWfO
X-Google-Smtp-Source: AGHT+IE4GbEPO50CbgxPQAOSwezrDo7dIzpcSAQrlWm6QC827CxwK/94NY2Q1K02ANxH3vAAqI/PdQy15/ZmW11DAJo=
X-Received: by 2002:a53:ec01:0:b0:636:1fd9:1c2 with SMTP id
 956f58d0204a3-63ccb8410e1mr4299532d50.3.1760077535974; Thu, 09 Oct 2025
 23:25:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009110623.3115511-1-giveme.gulu@gmail.com>
 <CAJnrk1aZ4==a3-uoRhH=qDKA36-FE6GoaKDZB7HX3o9pKdibYA@mail.gmail.com> <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
In-Reply-To: <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
From: lu gu <giveme.gulu@gmail.com>
Date: Fri, 10 Oct 2025 14:25:22 +0800
X-Gm-Features: AS18NWBll---7cq99BfcA-9wIIccCh9eibmg4TJShI91BXN-i1ipDktLOHedHKI
Message-ID: <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Resend, plain-text only: previous version was rejected due to HTML formatt=
ing]
Hi Joanne,

Thank you again for the detailed explanation. I've been thinking
carefully about your feedback and the deadlock issue related to
holding the page lock.
I now understand that keeping a low-level page lock while waiting for
a userspace reply is dangerous and can easily lead to deadlocks with
the memory manager. So my original patch was  not the right approach.

Your explanation really filled in the missing piece for me. Now, I
understand the core problem sequence correctly:

    A concurrent read operation may trigger a GETATTR request when the
attribute cache expires.
    The result of this GETATTR can cause the kernel to invalidate the
page cache for the inode.
    As a result, the read operation ignores the (new) cached data and
fetches data again from the backend.
    The backend then returns stale data, which overwrites the updated
page cache contents, leading to the data mismatch I observed.

I=E2=80=99ve been thinking about how to implement proper synchronization
without holding the page lock. Here=E2=80=99s an idea I=E2=80=99d like your=
 thoughts
on:

    1. Keep the early unlock_page() in fuse_fill_write_pages().

    2. In fuse_perform_write(), before sending the FUSE_WRITE request,
we insert an entry representing the affected page/offset range into a
new RB-tree on the fuse_inode. This structure, similar to how
writeback is tracked (e.g., fuse_page_is_writeback), will be named
sync_writes_in_flight.

    3. In the read path (e.g., fuse_readpage()), before issuing a
FUSE_READ, check this tree for any overlapping ranges.

    4. If an overlap is found, the read operation waits on a wait
queue associated with this synchronization structure.

    5. When the FUSE_WRITE completes in fuse_perform_write(), remove
the entry from the tree and wake up any waiting readers.

This should serialize backend reads and writes for overlapping ranges
while avoiding the deadlock risk, since the waiting happens at the
FUSE layer rather than under a page lock.

Does this approach sound reasonable to you? I=E2=80=99d really appreciate y=
our
feedback on whether this design makes sense, or if you see any
potential pitfalls I=E2=80=99ve missed.

Thanks,
guangming.zhao

On Fri, Oct 10, 2025 at 1:17=E2=80=AFPM lu gu <giveme.gulu@gmail.com> wrote=
:
>
> Hi Joanne,
>
> Thank you again for the detailed explanation. I've been thinking carefull=
y about your feedback and the deadlock issue related to holding the page lo=
ck.
> I now understand that keeping a low-level page lock while waiting for a u=
serspace reply is dangerous and can easily lead to deadlocks with the memor=
y manager. So my original patch was  not the right approach.
>
> Your explanation really filled in the missing piece for me. Now, I unders=
tand the core problem sequence correctly:
>
>     A concurrent read operation may trigger a GETATTR request when the at=
tribute cache expires.
>     The result of this GETATTR can cause the kernel to invalidate the pag=
e cache for the inode.
>     As a result, the read operation ignores the (new) cached data and fet=
ches data again from the backend.
>     The backend then returns stale data, which overwrites the updated pag=
e cache contents, leading to the data mismatch I observed.
>
> I=E2=80=99ve been thinking about how to implement proper synchronization =
without holding the page lock. Here=E2=80=99s an idea I=E2=80=99d like your=
 thoughts on:
>
>     1. Keep the early unlock_page() in fuse_fill_write_pages().
>
>     2. In fuse_perform_write(), before sending the FUSE_WRITE request, we=
 insert an entry representing the affected page/offset range into a new RB-=
tree on the fuse_inode. This structure, similar to how writeback is tracked=
 (e.g., fuse_page_is_writeback), will be named sync_writes_in_flight.
>
>     3. In the read path (e.g., fuse_readpage()), before issuing a FUSE_RE=
AD, check this tree for any overlapping ranges.
>
>     4. If an overlap is found, the read operation waits on a wait queue a=
ssociated with this synchronization structure.
>
>     5. When the FUSE_WRITE completes in fuse_perform_write(), remove the =
entry from the tree and wake up any waiting readers.
>
> This should serialize backend reads and writes for overlapping ranges whi=
le avoiding the deadlock risk, since the waiting happens at the FUSE layer =
rather than under a page lock.
>
> Does this approach sound reasonable to you? I=E2=80=99d really appreciate=
 your feedback on whether this design makes sense, or if you see any potent=
ial pitfalls I=E2=80=99ve missed.
>
> Thanks,
> guangming.zhao
>
> On Fri, Oct 10, 2025 at 6:11=E2=80=AFAM Joanne Koong <joannelkoong@gmail.=
com> wrote:
>>
>> On Thu, Oct 9, 2025 at 4:09=E2=80=AFAM guangming.zhao <giveme.gulu@gmail=
.com> wrote:
>> >
>>
>> Hi Guangming,
>>
>> > The race occurs as follows:
>> > 1. A write operation locks a page, fills it with new data, marks it
>> >    Uptodate, and then immediately unlocks it within fuse_fill_write_pa=
ges().
>> > 2. This opens a window before the new data is sent to the userspace da=
emon.
>> > 3. A concurrent read operation for the same page may decide to re-vali=
date
>> >    its cache from the daemon. The fuse_wait_on_page_writeback()
>> >    mechanism does not protect this synchronous writethrough path.
>> > 4. The read request can be processed by the multi-threaded daemon *bef=
ore*
>> >    the write request, causing it to reply with stale data from its bac=
kend.
>> > 5. The read syscall returns this stale data to userspace, causing data
>> >    verification to fail.
>>
>> I don't think the issue is that the read returns stale data (the
>> client is responsible for synchronizing reads and writes, so if the
>> read is issued before the write has completed then it should be fine
>> that the read returned back stale data) but that the read will
>> populate the page cache with stale data (overwriting the write data in
>> the page cache), which makes later subsequent reads that are issued
>> after the write has completed return back stale data.
>>
>> >
>> > This can be reliably reproduced on a mainline kernel (e.g., 6.1.x)
>> > using iogen and a standard multi-threaded libfuse passthrough filesyst=
em.
>> >
>> > Steps to Reproduce:
>> > 1. Mount a libfuse passthrough filesystem (must be multi-threaded):
>> >    $ ./passthrough /path/to/mount_point
>> >
>> > 2. Run the iogen/doio test from LTP (Linux Test Project) with mixed
>> >    read/write operations (example):
>> >    $ /path/to/ltp/iogen -N iogen01 -i 120s -s read,write 500k:/path/to=
/mount_point/file1 | \
>> >      /path/to/ltp/doio -N iogen01 -a -v -n 2 -k
>> >
>> > 3. A data comparison error similar to the following will be reported:
>> >    *** DATA COMPARISON ERROR ***
>> >    check_file(/path/to/mount_point/file1, ...) failed
>> >    expected bytes:  X:3091346:gm-arco:doio*X:3091346
>> >    actual bytes:    91346:gm-arco:doio*C:3091346:gm-
>> >
>> > The fix is to delay unlocking the page until after the data has been
>> > successfully sent to the daemon. This is achieved by moving the unlock
>> > logic from fuse_fill_write_pages() to the completion path of
>> > fuse_send_write_pages(), ensuring the page lock is held for the entire
>> > critical section and serializing the operations correctly.
>> >
>> > [Note for maintainers]
>> > This patch is created and tested against the 5.15 kernel. I have obser=
ved
>> > that recent kernels have migrated to using folios, and I am not confid=
ent
>> > in porting this fix to the new folio-based code myself.
>> >
>> > I am submitting this patch to clearly document the race condition and =
a
>> > proven fix on an older kernel, in the hope that a developer more
>> > familiar with the folio conversion can adapt it for the mainline tree.
>> >
>> > Signed-off-by: guangming.zhao <giveme.gulu@gmail.com>
>> > ---
>> > [root@gm-arco example]# uname -a
>> > Linux gm-arco 6.16.8-arch3-1 #1 SMP PREEMPT_DYNAMIC Mon, 22 Sep 2025 2=
2:08:35 +0000 x86_64 GNU/Linux
>> > [root@gm-arco example]# ./passthrough /tmp/test/
>> > [root@gm-arco example]# mkdir /tmp/test/yy
>> > [root@gm-arco example]# /home/gm/code/ltp/testcases/kernel/fs/doio/iog=
en -N iogen01 -i 120s -s read,write 500b:/tmp/test/yy/kk1 1000b:/tmp/test/y=
y/kk2 | /home/gm/code/ltp/testcases/kernel/fs/doio/doio -N iogen01 -a -v -n=
 2 -k
>> >
>> > iogen(iogen01) starting up with the following:
>> >
>> > Out-pipe:              stdout
>> > Iterations:            120 seconds
>> > Seed:                  3091343
>> > Offset-Mode:           sequential
>> > Overlap Flag:          off
>> > Mintrans:              1           (1 blocks)
>> > Maxtrans:              131072      (256 blocks)
>> > O_RAW/O_SSD Multiple:  (Determined by device)
>> > Syscalls:              read write
>> > Aio completion types:  none
>> > Flags:                 buffered sync
>> >
>> > Test Files:
>> >
>> > Path                                          Length    iou   raw iou =
file
>> >                                               (bytes) (bytes) (bytes) =
type
>> > ----------------------------------------------------------------------=
-------
>> > /tmp/test/yy/kk1                               256000       1     512 =
regular
>> > /tmp/test/yy/kk2                               512000       1     512 =
regular
>> >
>> > doio(iogen01) (3091346) 17:43:50
>> > ---------------------
>> > *** DATA COMPARISON ERROR ***
>> > check_file(/tmp/test/yy/kk2, 116844, 106653, X:3091346:gm-arco:doio*, =
23, 0) failed
>> >
>> > Comparison fd is 3, with open flags 0
>> > Corrupt regions follow - unprintable chars are represented as '.'
>> > -----------------------------------------------------------------
>> > corrupt bytes starting at file offset 116844
>> >     1st 32 expected bytes:  X:3091346:gm-arco:doio*X:3091346
>> >     1st 32 actual bytes:    91346:gm-arco:doio*C:3091346:gm-
>> > Request number 13873
>> > syscall:  write(4, 02540107176414100, 106653)
>> >           fd 4 is file /tmp/test/yy/kk2 - open flags are 04010001
>> >           write done at file offset 116844 - pattern is X:3091346:gm-a=
rco:doio*
>> >
>> > doio(iogen01) (3091344) 17:43:50
>> > ---------------------
>> > (parent) pid 3091346 exited because of data compare errors
>> >
>> >  fs/fuse/file.c | 36 ++++++++++--------------------------
>> >  1 file changed, 10 insertions(+), 26 deletions(-)
>> >
>> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> > index 5c5ed58d9..a832c3122 100644
>> > --- a/fs/fuse/file.c
>> > +++ b/fs/fuse/file.c
>> > @@ -1098,7 +1098,6 @@ static ssize_t fuse_send_write_pages(struct fuse=
_io_args *ia,
>> >         struct fuse_file *ff =3D file->private_data;
>> >         struct fuse_mount *fm =3D ff->fm;
>> >         unsigned int offset, i;
>> > -       bool short_write;
>> >         int err;
>> >
>> >         for (i =3D 0; i < ap->num_pages; i++)
>> > @@ -1113,26 +1112,21 @@ static ssize_t fuse_send_write_pages(struct fu=
se_io_args *ia,
>> >         if (!err && ia->write.out.size > count)
>> >                 err =3D -EIO;
>> >
>> > -       short_write =3D ia->write.out.size < count;
>> >         offset =3D ap->descs[0].offset;
>> >         count =3D ia->write.out.size;
>> >         for (i =3D 0; i < ap->num_pages; i++) {
>> >                 struct page *page =3D ap->pages[i];
>> >
>> > -               if (err) {
>> > -                       ClearPageUptodate(page);
>> > -               } else {
>> > -                       if (count >=3D PAGE_SIZE - offset)
>> > -                               count -=3D PAGE_SIZE - offset;
>> > -                       else {
>> > -                               if (short_write)
>> > -                                       ClearPageUptodate(page);
>> > -                               count =3D 0;
>> > -                       }
>> > -                       offset =3D 0;
>> > -               }
>> > -               if (ia->write.page_locked && (i =3D=3D ap->num_pages -=
 1))
>> > -                       unlock_page(page);
>> > +        if (!err && !offset && count >=3D PAGE_SIZE)
>> > +            SetPageUptodate(page);
>> > +
>> > +        if (count > PAGE_SIZE - offset)
>> > +            count -=3D PAGE_SIZE - offset;
>> > +        else
>> > +            count =3D 0;
>> > +        offset =3D 0;
>> > +
>> > +        unlock_page(page);
>> >                 put_page(page);
>> >         }
>> >
>> > @@ -1195,16 +1189,6 @@ static ssize_t fuse_fill_write_pages(struct fus=
e_io_args *ia,
>> >                 if (offset =3D=3D PAGE_SIZE)
>> >                         offset =3D 0;
>> >
>> > -               /* If we copied full page, mark it uptodate */
>> > -               if (tmp =3D=3D PAGE_SIZE)
>> > -                       SetPageUptodate(page);
>> > -
>> > -               if (PageUptodate(page)) {
>> > -                       unlock_page(page);
>> > -               } else {
>> > -                       ia->write.page_locked =3D true;
>> > -                       break;
>> > -               }
>>
>> I think this will run into the deadlock described here
>> https://lore.kernel.org/linux-fsdevel/CAHk-=3Dwh9Eu-gNHzqgfvUAAiO=3DvJ+p=
Wnzxkv+tX55xhGPFy+cOw@mail.gmail.com/,
>> so I think we would need a different solution. Maybe one idea is doing
>> something similar to what the fi->writectr bias does - that at least
>> seems simpler to me than having to unlock all the pages in the array
>> if we have to fault in the iov iter and then having to relock the
>> pages while making sure everything is all consistent.
>>
>> Thanks,
>> Joanne
>>
>> >                 if (!fc->big_writes)
>> >                         break;
>> >         } while (iov_iter_count(ii) && count < fc->max_write &&
>> > --
>> > 2.51.0
>> >
>> >

