Return-Path: <linux-fsdevel+bounces-32659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298989AC9CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 14:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D898B2232A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 12:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC061ABEBD;
	Wed, 23 Oct 2024 12:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWSq2Ei6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D561AB6ED;
	Wed, 23 Oct 2024 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729685650; cv=none; b=sC4hVoy4Zdye8tUeB1w8Um+Rw3ofyt9ixhLP9qJwvSK1/20oUnk8FrFBkRE7K2NBuBEnxsCjr3JJeUp49ZvaubiYPWVQu4SLALYee3Vqp3yMvodEUEZvJcFcJbKf09xw1Pw2cP8L2TEp68SMpRu5q/7Ijrvk8E6gRWvrLHCDMxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729685650; c=relaxed/simple;
	bh=bJkMmN/W4uVaExl4jLRMAT0sboN3UXWxlQfvrxmTBPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMfEqQuYGxQ8p2rdTNRiaZT9fGhNFt0OOrBsqnHDnDdG/bwHC/KBt5G0ONKsyuLGRjfs5W9PHhQ4uDSbAGLz+G3DctnoNaXEQMl5OcbwFy+48caxiQtDeeeoCAo8BZf4eFUFzRObYIeXhmV1uB2ud4fib11ElsGBPL57ZQrLTY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWSq2Ei6; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso93548791fa.1;
        Wed, 23 Oct 2024 05:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729685646; x=1730290446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6Ul2SkOK/fCLRiNqMVFjlJcv/8NLnzzPzp/o0ZA7dLQ=;
        b=BWSq2Ei6jOsVtoXe6HdvXPaI3giAQb92c5YuZZl8SGqllaniJWFny9PuVb/rTuKP/a
         +zTB02Np45ESnJf3JYbNTlfav307/oNf4CuXMgc4LQNGwIsR3lkDGk/vRqcnylNHekav
         Tlh5Vo2Pes+Ykk9/quqEkx70Dodk22gk5pVcfdn/wn1Uugl44uj2FXJzo5vHQNqNyUE/
         HdFUNFYYBkyhAUlC5fhntwwY2pHsQvbEMDnNFwXo1IJfl47J2oxn62oOMwcoZ8nZsOm5
         aEncQvdlX4TprEE1+q3rl7LEBxO9NlxR0uJq2fhVzd68RwIztsimjDrQo4lmlQgeWDoo
         LtnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729685646; x=1730290446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Ul2SkOK/fCLRiNqMVFjlJcv/8NLnzzPzp/o0ZA7dLQ=;
        b=A4Nf54qqaoQFbnt53RwkcoSmL7xVAQjTDsHDOvuAxEBeTyx7ibxn9H6FnupPN1ZD4U
         492M2oixgvD+2kziPewIGxf4m4CxHZtwhpdFZURHxtJA/lt7Ht9mgLOt34vwDA319LP4
         shrGhkcJasoPlpWkrrDfBU/IeIKcwZRZm1SAzqrw0c1p4/MIg6PEVRjqwbje5w9aY3Pq
         3713Mec0/C2QikfwxWsMoEAPC7UwLfoISrrgOFFn7ZDQ3SO8OQGO+jWoNTP5hoPcgLn5
         IC6UwQbyRKtkS90JsA5LOQk1OFvhKIus3GC5bGrL39VWit1OOXF8GyR3WPRYl0CPd67x
         6amg==
X-Forwarded-Encrypted: i=1; AJvYcCV8zdU8yeoHipIQPrfDMoOUksRHRU+Em13sZtu3IGMtiiI9rwqfLAHdR8oYUFqp8TNrDrsF7p/xbvxwVGZ4@vger.kernel.org, AJvYcCVf1K3wRO4m4oHZKYWSa6tBpqswGecW98GLwgLVnDPcaQi3Z2g5AlSej3ZyRpdnnKDNevm5XpVUEuwpozS/@vger.kernel.org
X-Gm-Message-State: AOJu0YxJPQSNrB0QR9B0y1odBgaQICSUxWh8rUI6ZmnyCOnTmf/J0nuX
	Sst01ouMz3fZ8YT5Rm4mC7Zn1dRNLk3BnDJTwe+9E324Wf8Dh685gT6fNuS9zWTg//wXBfqi+50
	BSQJdD13SS+WUoRWU/S7xvEa9Pbc=
X-Google-Smtp-Source: AGHT+IG/UsYNoneEhInaBUDvmE42muCV/d+2Uc6LPwOaJycuqCs3nkq0w48TR6bPSH9/94I8nMwv3qLqTe4N9cAkFnE=
X-Received: by 2002:a05:6512:1586:b0:539:8f3c:4586 with SMTP id
 2adb3069b0e04-53b1a3ac8ecmr2115589e87.55.1729685645901; Wed, 23 Oct 2024
 05:14:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
 <CA+icZUWKGBKOxEaSUJv4up46b0i8=R-RgbnpHEV20HC_210syw@mail.gmail.com> <bf6dcc97-a204-473c-9e25-54db430e9a58@huaweicloud.com>
In-Reply-To: <bf6dcc97-a204-473c-9e25-54db430e9a58@huaweicloud.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Wed, 23 Oct 2024 14:13:29 +0200
Message-ID: <CA+icZUWjruYjiBVgV_-a6dMgovRRdRpWpfU=9Ly1bFcD8i=XLw@mail.gmail.com>
Subject: Re: [PATCH 00/27] ext4: use iomap for regular file's buffered I/O
 path and enable large folio
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, ritesh.list@gmail.com, hch@infradead.org, djwong@kernel.org, 
	david@fromorbit.com, zokeefe@google.com, yi.zhang@huawei.com, 
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 11:22=E2=80=AFAM Zhang Yi <yi.zhang@huaweicloud.com=
> wrote:
>
> On 2024/10/22 14:59, Sedat Dilek wrote:
> > On Tue, Oct 22, 2024 at 5:13=E2=80=AFAM Zhang Yi <yi.zhang@huaweicloud.=
com> wrote:
> >>
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> Hello=EF=BC=81
> >>
> >> This patch series is the latest version based on my previous RFC
> >> series[1], which converts the buffered I/O path of ext4 regular files =
to
> >> iomap and enables large folios. After several months of work, almost a=
ll
> >> preparatory changes have been upstreamed, thanks a lot for the review
> >> and comments from Jan, Dave, Christoph, Darrick and Ritesh. Now it is
> >> time for the main implementation of this conversion.
> >>
> >> This series is the main part of iomap buffered iomap conversion, it's
> >> based on 6.12-rc4, and the code context is also depend on my anohter
> >> cleanup series[1] (I've put that in this seris so we can merge it
> >> directly), fixed all minor bugs found in my previous RFC v4 series.
> >> Additionally, I've update change logs in each patch and also includes
> >> some code modifications as Dave's suggestions. This series implements
> >> the core iomap APIs on ext4 and introduces a mount option called
> >> "buffered_iomap" to enable the iomap buffered I/O path. We have alread=
y
> >> supported the default features, default mount options and bigalloc
> >> feature. However, we do not yet support online defragmentation, inline
> >> data, fs_verify, fs_crypt, ext3, and data=3Djournal mode, ext4 will fa=
ll
> >> to buffered_head I/O path automatically if you use those features and
> >> options. Some of these features should be supported gradually in the
> >> near future.
> >>
> >> Most of the implementations resemble the original buffered_head path;
> >> however, there are four key differences.
> >>
> >> 1. The first aspect is the block allocation in the writeback path. The
> >>    iomap frame will invoke ->map_blocks() at least once for each dirty
> >>    folio. To ensure optimal writeback performance, we aim to allocate =
a
> >>    range of delalloc blocks that is as long as possible within the
> >>    writeback length for each invocation. In certain situations, we may
> >>    allocate a range of blocks that exceeds the amount we will actually
> >>    write back. Therefore,
> >> 1) we cannot allocate a written extent for those blocks because it may
> >>    expose stale data in such short write cases. Instead, we should
> >>    allocate an unwritten extent, which means we must always enable the
> >>    dioread_nolock option. This change could also bring many other
> >>    benefits.
> >> 2) We should postpone updating the 'i_disksize' until the end of the I=
/O
> >>    process, based on the actual written length. This approach can also
> >>    prevent the exposure of zero data, which may occur if there is a
> >>    power failure during an append write.
> >> 3) We do not need to pre-split extents during write-back, we can
> >>    postpone this task until the end I/O process while converting
> >>    unwritten extents.
> >>
> >> 2. The second reason is that since we always allocate unwritten space
> >>    for new blocks, there is no risk of exposing stale data. As a resul=
t,
> >>    we do not need to order the data, which allows us to disable the
> >>    data=3Dordered mode. Consequently, we also do not require the reser=
ved
> >>    handle when converting the unwritten extent in the final I/O worker=
,
> >>    we can directly start with the normal handle.
> >>
> >> Series details:
> >>
> >> Patch 1-10 is just another series of mine that refactors the fallocate
> >> functions[1]. This series relies on the code context of that but has n=
o
> >> logical dependencies. I put this here just for easy access and merge.
> >>
> >> Patch 11-21 implement the iomap buffered read/write path, dirty folio
> >> write back path and mmap path for ext4 regular file.
> >>
> >> Patch 22-23 disable the unsupported online-defragmentation function an=
d
> >> disable the changing of the inode journal flag to data=3Djournal mode.
> >> Please look at the following patch for details.
> >>
> >> Patch 24-27 introduce "buffered_iomap" mount option (is not enabled by
> >> default now) to partially enable the iomap buffered I/O path and also
> >> enable large folio.
> >>
> >>
> >> About performance:
> >>
> >> Fio tests with psync on my machine with Intel Xeon Gold 6240 CPU with
> >> 400GB system ram, 200GB ramdisk and 4TB nvme ssd disk.
> >>
> >>  fio -directory=3D/mnt -direct=3D0 -iodepth=3D$iodepth -fsync=3D$sync =
-rw=3D$rw \
> >>      -numjobs=3D${numjobs} -bs=3D${bs} -ioengine=3Dpsync -size=3D$size=
 \
> >>      -runtime=3D60 -norandommap=3D0 -fallocate=3Dnone -overwrite=3D$ov=
erwrite \
> >>      -group_reportin -name=3D$name --output=3D/tmp/test_log
> >>
> >
> > Hi Zhang Yi,
> >
> > can you clarify about the FIO values for the diverse parameters?
> >
>
> Hi Sedat,
>
> Sure, the test I present here is a simple single-thread and single-I/O
> depth case with psync ioengine. Most of the FIO parameters are shown
> in the tables below.
>

Hi Zhang Yi,

Thanks for your reply.

Can you share a FIO config file with all (relevant) settings?
Maybe it is in the below link?

Link: https://packages.debian.org/sid/all/fio-examples/filelist

> For the rest, the 'iodepth' and 'numjobs' are always set to 1 and the
> 'size' is 40GB. During the write cache test, I also disable the write
> back process through:
>
>  echo 0 > /proc/sys/vm/dirty_writeback_centisecs
>  echo 100 > /proc/sys/vm/dirty_background_ratio
>  echo 100 > /proc/sys/vm/dirty_ratio
>

^^ Ist this info in one of the patches? If not - can you add this info
to the next version's cover-letter?

The patchset and improvements are valid only for powerful servers or
has a notebook user any benefits of this?
If you have benchmark data, please share this.

I can NOT promise if I will give that patchset a try.

Best thanks.

Best regards,
-Sedat-

> Thanks,
> Yi.
>
> >
> >>  =3D=3D buffer read =3D=3D
> >>
> >>                 buffer_head        iomap + large folio
> >>  type     bs    IOPS    BW(MiB/s)  IOPS    BW(MiB/s)
> >>  -------------------------------------------------------
> >>  hole     4K    576k    2253       762k    2975     +32%
> >>  hole     64K   48.7k   3043       77.8k   4860     +60%
> >>  hole     1M    2960    2960       4942    4942     +67%
> >>  ramdisk  4K    443k    1732       530k    2069     +19%
> >>  ramdisk  64K   34.5k   2156       45.6k   2850     +32%
> >>  ramdisk  1M    2093    2093       2841    2841     +36%
> >>  nvme     4K    339k    1323       364k    1425     +8%
> >>  nvme     64K   23.6k   1471       25.2k   1574     +7%
> >>  nvme     1M    2012    2012       2153    2153     +7%
> >>
> >>
> >>  =3D=3D buffer write =3D=3D
> >>
> >>                                        buffer_head  iomap + large foli=
o
> >>  type   Overwrite Sync Writeback  bs   IOPS   BW    IOPS   BW(MiB/s)
> >>  ---------------------------------------------------------------------=
-
> >>  cache      N    N    N    4K     417k    1631    440k    1719   +5%
> >>  cache      N    N    N    64K    33.4k   2088    81.5k   5092   +144%
> >>  cache      N    N    N    1M     2143    2143    5716    5716   +167%
> >>  cache      Y    N    N    4K     449k    1755    469k    1834   +5%
> >>  cache      Y    N    N    64K    36.6k   2290    82.3k   5142   +125%
> >>  cache      Y    N    N    1M     2352    2352    5577    5577   +137%
> >>  ramdisk    N    N    Y    4K     365k    1424    354k    1384   -3%
> >>  ramdisk    N    N    Y    64K    31.2k   1950    74.2k   4640   +138%
> >>  ramdisk    N    N    Y    1M     1968    1968    5201    5201   +164%
> >>  ramdisk    N    Y    N    4K     9984    39      12.9k   51     +29%
> >>  ramdisk    N    Y    N    64K    5936    371     8960    560    +51%
> >>  ramdisk    N    Y    N    1M     1050    1050    1835    1835   +75%
> >>  ramdisk    Y    N    Y    4K     411k    1609    443k    1731   +8%
> >>  ramdisk    Y    N    Y    64K    34.1k   2134    77.5k   4844   +127%
> >>  ramdisk    Y    N    Y    1M     2248    2248    5372    5372   +139%
> >>  ramdisk    Y    Y    N    4K     182k    711     186k    730    +3%
> >>  ramdisk    Y    Y    N    64K    18.7k   1170    34.7k   2171   +86%
> >>  ramdisk    Y    Y    N    1M     1229    1229    2269    2269   +85%
> >>  nvme       N    N    Y    4K     373k    1458    387k    1512   +4%
> >>  nvme       N    N    Y    64K    29.2k   1827    70.9k   4431   +143%
> >>  nvme       N    N    Y    1M     1835    1835    4919    4919   +168%
> >>  nvme       N    Y    N    4K     11.7k   46      11.7k   46      0%
> >>  nvme       N    Y    N    64K    6453    403     8661    541    +34%
> >>  nvme       N    Y    N    1M     649     649     1351    1351   +108%
> >>  nvme       Y    N    Y    4K     372k    1456    433k    1693   +16%
> >>  nvme       Y    N    Y    64K    33.0k   2064    74.7k   4669   +126%
> >>  nvme       Y    N    Y    1M     2131    2131    5273    5273   +147%
> >>  nvme       Y    Y    N    4K     56.7k   222     56.4k   220    -1%
> >>  nvme       Y    Y    N    64K    13.4k   840     19.4k   1214   +45%
> >>  nvme       Y    Y    N    1M     714     714     1504    1504   +111%
> >>
> >> Thanks,
> >> Yi.
> >>
> >> Major changes since RFC v4:
> >>  - Disable unsupported online defragmentation, do not fall back to
> >>    buffer_head path.
> >>  - Wite and wait data back while doing partial block truncate down to
> >>    fix a stale data problem.
> >>  - Disable the online changing of the inode journal flag to data=3Djou=
rnal
> >>    mode.
> >>  - Since iomap can zero out dirty pages with unwritten extent, do not
> >>    write data before zeroing out in ext4_zero_range(), and also do not
> >>    zero partial blocks under a started journal handle.
> >>
> >> [1] https://lore.kernel.org/linux-ext4/20241010133333.146793-1-yi.zhan=
g@huawei.com/
> >>
> >> ---
> >> RFC v4: https://lore.kernel.org/linux-ext4/20240410142948.2817554-1-yi=
.zhang@huaweicloud.com/
> >> RFC v3: https://lore.kernel.org/linux-ext4/20240127015825.1608160-1-yi=
.zhang@huaweicloud.com/
> >> RFC v2: https://lore.kernel.org/linux-ext4/20240102123918.799062-1-yi.=
zhang@huaweicloud.com/
> >> RFC v1: https://lore.kernel.org/linux-ext4/20231123125121.4064694-1-yi=
.zhang@huaweicloud.com/
> >>
> >>
> >> Zhang Yi (27):
> >>   ext4: remove writable userspace mappings before truncating page cach=
e
> >>   ext4: don't explicit update times in ext4_fallocate()
> >>   ext4: don't write back data before punch hole in nojournal mode
> >>   ext4: refactor ext4_punch_hole()
> >>   ext4: refactor ext4_zero_range()
> >>   ext4: refactor ext4_collapse_range()
> >>   ext4: refactor ext4_insert_range()
> >>   ext4: factor out ext4_do_fallocate()
> >>   ext4: move out inode_lock into ext4_fallocate()
> >>   ext4: move out common parts into ext4_fallocate()
> >>   ext4: use reserved metadata blocks when splitting extent on endio
> >>   ext4: introduce seq counter for the extent status entry
> >>   ext4: add a new iomap aops for regular file's buffered IO path
> >>   ext4: implement buffered read iomap path
> >>   ext4: implement buffered write iomap path
> >>   ext4: don't order data for inode with EXT4_STATE_BUFFERED_IOMAP
> >>   ext4: implement writeback iomap path
> >>   ext4: implement mmap iomap path
> >>   ext4: do not always order data when partial zeroing out a block
> >>   ext4: do not start handle if unnecessary while partial zeroing out a
> >>     block
> >>   ext4: implement zero_range iomap path
> >>   ext4: disable online defrag when inode using iomap buffered I/O path
> >>   ext4: disable inode journal mode when using iomap buffered I/O path
> >>   ext4: partially enable iomap for the buffered I/O path of regular
> >>     files
> >>   ext4: enable large folio for regular file with iomap buffered I/O pa=
th
> >>   ext4: change mount options code style
> >>   ext4: introduce a mount option for iomap buffered I/O path
> >>
> >>  fs/ext4/ext4.h              |  17 +-
> >>  fs/ext4/ext4_jbd2.c         |   3 +-
> >>  fs/ext4/ext4_jbd2.h         |   8 +
> >>  fs/ext4/extents.c           | 568 +++++++++++----------------
> >>  fs/ext4/extents_status.c    |  13 +-
> >>  fs/ext4/file.c              |  19 +-
> >>  fs/ext4/ialloc.c            |   5 +
> >>  fs/ext4/inode.c             | 755 ++++++++++++++++++++++++++++++-----=
-
> >>  fs/ext4/move_extent.c       |   7 +
> >>  fs/ext4/page-io.c           | 105 +++++
> >>  fs/ext4/super.c             | 185 ++++-----
> >>  include/trace/events/ext4.h |  57 +--
> >>  12 files changed, 1153 insertions(+), 589 deletions(-)
> >>
> >> --
> >> 2.46.1
> >>
> >>
>

