Return-Path: <linux-fsdevel+bounces-32577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD749A9A5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 09:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06B831C21C18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 07:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55C51474BF;
	Tue, 22 Oct 2024 07:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZSOPtAb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09FA770E4;
	Tue, 22 Oct 2024 07:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729580430; cv=none; b=bPpRA2afB1uCXdEBTSlmcsXq5WhW41IzqjSIKdWVUPoSsE60wgENJbtmPS6vOROZlxvo18hx0C7iYEaI8BnL6oV8aK5L34BeLOsRVpZz3g9Wg38EK61sm9fMfLbl69mM6zxqrDluLlprFC8vk8Xizh+rTDcK983vp/IEJREqfU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729580430; c=relaxed/simple;
	bh=xjZ/HQb4kFdPYIbSPx/ufDjsEPPQi7CDsOYKZujwI2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUzlzE1w/pKSz7FmAcBNvvwVsbkMr9mM5YknwmglbFu+f+5nRba3ci8hX/VMwojreZfWoL1yg/ppZqYHf7XpOekLD2nnyIC0bqWZu0UPrag5MPVUagP6cwhE9KJFO9mRclgWia2O+dpHDIdoLVERszL/u4lLg3uEayTI94WgoF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZSOPtAb; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so7002960e87.1;
        Tue, 22 Oct 2024 00:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729580425; x=1730185225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J/QdpXN0WcEqcqU/tmZ4vbBIxjMNJfjZeCiMVOuPScg=;
        b=PZSOPtAbsQQP/gblNJcVH4ByDif1wl0Vn/rvkRQHYdfcdm0CTgGwO/ZuaPMlfF6ndC
         O54yW5KRf0geAykj86EvJydzx4lJ6/W1yfUeCSWJb7S8smy600cN7q2h90W/p0nVSMXJ
         9nmDR7b0JLBX0Ep0oip6EmFli3yd3e0E9d/vhVFEZCmDOHOYKIfTEacnumcCrMUkcb1S
         RqiWD+U42y8zDp7/PIuRqRsrUOnoFvto2Z71gh/BDXayzaPNay7WZAdRQ4ZL1Mj7BAIm
         JzTUGz3m8bOExG1VAMtnE4b1Oc0NgczILkYxu47fu9HD3f+GZShs3+iEP/sQ5ep3K1JG
         yE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729580425; x=1730185225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J/QdpXN0WcEqcqU/tmZ4vbBIxjMNJfjZeCiMVOuPScg=;
        b=NwX6uhqibNDtmzVn0uM6cgZmnZjEGO2Gdhgn7AndHIOhHx6n3Na+k44Zjky1nMVpxw
         vTK8KLVeGY3Y32+nOZEMof494Ei6b/YGxb93eAW5PGKP4LK9z3wuSyPx2+gHUmsnEKYr
         x4B7+aI2A3p77aUqx7mMZn2oFe5UtC/tAmayQ0gLL6oM0vSBAgo0ChAwWoOf6M3KAnIX
         HeLeWnpVnfldaVKB/HBjU9MfUOpmJmZGCWwyhaRSkzZDU8N6XJHFOk9zQgufiFhca9NQ
         NOO9cmNPeXh3ZnZfKiJu3PUohapVuSx7BRIABJxtKAWsYy5Va3WW+HfX48+9CZwMv0jf
         +1qw==
X-Forwarded-Encrypted: i=1; AJvYcCV9r4gKGWjiwNTa8+DuBDXGtpcz+cxgqpfzU/tOT3xW0rXb1hAOaoqtFuxDtIi84OVbb8kxZqlFVvwEaQLy@vger.kernel.org, AJvYcCWgNxRZwbvGJ3oCTPdSwd1wvTpuMEUaF8quuGeRvqt/fy1LWGG2PIOZSENF7hIXg4Vp10N5nkd0xEtK7z42@vger.kernel.org
X-Gm-Message-State: AOJu0YzTpLzmwCt7/mPClYE3LJJOP/OklIoT5nzVYNFqFTynzJLI0+Fp
	yyaUb+s29vZvOw/CRbJyorxcVu17QqXx54yIVeKgciSvtRO4MPVVPGnxbaEWtYW34ENAMZrtBDK
	AQ7k4dRkq0ixGhEyxwbm15LSCB24=
X-Google-Smtp-Source: AGHT+IHG4M8gnvXz0MHWDQzlmkW+/B5smow6VQbFIz3vpP6Qq2eVpEgQwOIsLv7AigMwkJzu62mwXV9XkamWyw+afz0=
X-Received: by 2002:a05:6512:1111:b0:539:fcb7:8d53 with SMTP id
 2adb3069b0e04-53a1544afd4mr7279071e87.46.1729580424419; Tue, 22 Oct 2024
 00:00:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
In-Reply-To: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Tue, 22 Oct 2024 08:59:48 +0200
Message-ID: <CA+icZUWKGBKOxEaSUJv4up46b0i8=R-RgbnpHEV20HC_210syw@mail.gmail.com>
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

On Tue, Oct 22, 2024 at 5:13=E2=80=AFAM Zhang Yi <yi.zhang@huaweicloud.com>=
 wrote:
>
> From: Zhang Yi <yi.zhang@huawei.com>
>
> Hello=EF=BC=81
>
> This patch series is the latest version based on my previous RFC
> series[1], which converts the buffered I/O path of ext4 regular files to
> iomap and enables large folios. After several months of work, almost all
> preparatory changes have been upstreamed, thanks a lot for the review
> and comments from Jan, Dave, Christoph, Darrick and Ritesh. Now it is
> time for the main implementation of this conversion.
>
> This series is the main part of iomap buffered iomap conversion, it's
> based on 6.12-rc4, and the code context is also depend on my anohter
> cleanup series[1] (I've put that in this seris so we can merge it
> directly), fixed all minor bugs found in my previous RFC v4 series.
> Additionally, I've update change logs in each patch and also includes
> some code modifications as Dave's suggestions. This series implements
> the core iomap APIs on ext4 and introduces a mount option called
> "buffered_iomap" to enable the iomap buffered I/O path. We have already
> supported the default features, default mount options and bigalloc
> feature. However, we do not yet support online defragmentation, inline
> data, fs_verify, fs_crypt, ext3, and data=3Djournal mode, ext4 will fall
> to buffered_head I/O path automatically if you use those features and
> options. Some of these features should be supported gradually in the
> near future.
>
> Most of the implementations resemble the original buffered_head path;
> however, there are four key differences.
>
> 1. The first aspect is the block allocation in the writeback path. The
>    iomap frame will invoke ->map_blocks() at least once for each dirty
>    folio. To ensure optimal writeback performance, we aim to allocate a
>    range of delalloc blocks that is as long as possible within the
>    writeback length for each invocation. In certain situations, we may
>    allocate a range of blocks that exceeds the amount we will actually
>    write back. Therefore,
> 1) we cannot allocate a written extent for those blocks because it may
>    expose stale data in such short write cases. Instead, we should
>    allocate an unwritten extent, which means we must always enable the
>    dioread_nolock option. This change could also bring many other
>    benefits.
> 2) We should postpone updating the 'i_disksize' until the end of the I/O
>    process, based on the actual written length. This approach can also
>    prevent the exposure of zero data, which may occur if there is a
>    power failure during an append write.
> 3) We do not need to pre-split extents during write-back, we can
>    postpone this task until the end I/O process while converting
>    unwritten extents.
>
> 2. The second reason is that since we always allocate unwritten space
>    for new blocks, there is no risk of exposing stale data. As a result,
>    we do not need to order the data, which allows us to disable the
>    data=3Dordered mode. Consequently, we also do not require the reserved
>    handle when converting the unwritten extent in the final I/O worker,
>    we can directly start with the normal handle.
>
> Series details:
>
> Patch 1-10 is just another series of mine that refactors the fallocate
> functions[1]. This series relies on the code context of that but has no
> logical dependencies. I put this here just for easy access and merge.
>
> Patch 11-21 implement the iomap buffered read/write path, dirty folio
> write back path and mmap path for ext4 regular file.
>
> Patch 22-23 disable the unsupported online-defragmentation function and
> disable the changing of the inode journal flag to data=3Djournal mode.
> Please look at the following patch for details.
>
> Patch 24-27 introduce "buffered_iomap" mount option (is not enabled by
> default now) to partially enable the iomap buffered I/O path and also
> enable large folio.
>
>
> About performance:
>
> Fio tests with psync on my machine with Intel Xeon Gold 6240 CPU with
> 400GB system ram, 200GB ramdisk and 4TB nvme ssd disk.
>
>  fio -directory=3D/mnt -direct=3D0 -iodepth=3D$iodepth -fsync=3D$sync -rw=
=3D$rw \
>      -numjobs=3D${numjobs} -bs=3D${bs} -ioengine=3Dpsync -size=3D$size \
>      -runtime=3D60 -norandommap=3D0 -fallocate=3Dnone -overwrite=3D$overw=
rite \
>      -group_reportin -name=3D$name --output=3D/tmp/test_log
>

Hi Zhang Yi,

can you clarify about the FIO values for the diverse parameters?

Thanks.

BR,
-Sedat-

>  =3D=3D buffer read =3D=3D
>
>                 buffer_head        iomap + large folio
>  type     bs    IOPS    BW(MiB/s)  IOPS    BW(MiB/s)
>  -------------------------------------------------------
>  hole     4K    576k    2253       762k    2975     +32%
>  hole     64K   48.7k   3043       77.8k   4860     +60%
>  hole     1M    2960    2960       4942    4942     +67%
>  ramdisk  4K    443k    1732       530k    2069     +19%
>  ramdisk  64K   34.5k   2156       45.6k   2850     +32%
>  ramdisk  1M    2093    2093       2841    2841     +36%
>  nvme     4K    339k    1323       364k    1425     +8%
>  nvme     64K   23.6k   1471       25.2k   1574     +7%
>  nvme     1M    2012    2012       2153    2153     +7%
>
>
>  =3D=3D buffer write =3D=3D
>
>                                        buffer_head  iomap + large folio
>  type   Overwrite Sync Writeback  bs   IOPS   BW    IOPS   BW(MiB/s)
>  ----------------------------------------------------------------------
>  cache      N    N    N    4K     417k    1631    440k    1719   +5%
>  cache      N    N    N    64K    33.4k   2088    81.5k   5092   +144%
>  cache      N    N    N    1M     2143    2143    5716    5716   +167%
>  cache      Y    N    N    4K     449k    1755    469k    1834   +5%
>  cache      Y    N    N    64K    36.6k   2290    82.3k   5142   +125%
>  cache      Y    N    N    1M     2352    2352    5577    5577   +137%
>  ramdisk    N    N    Y    4K     365k    1424    354k    1384   -3%
>  ramdisk    N    N    Y    64K    31.2k   1950    74.2k   4640   +138%
>  ramdisk    N    N    Y    1M     1968    1968    5201    5201   +164%
>  ramdisk    N    Y    N    4K     9984    39      12.9k   51     +29%
>  ramdisk    N    Y    N    64K    5936    371     8960    560    +51%
>  ramdisk    N    Y    N    1M     1050    1050    1835    1835   +75%
>  ramdisk    Y    N    Y    4K     411k    1609    443k    1731   +8%
>  ramdisk    Y    N    Y    64K    34.1k   2134    77.5k   4844   +127%
>  ramdisk    Y    N    Y    1M     2248    2248    5372    5372   +139%
>  ramdisk    Y    Y    N    4K     182k    711     186k    730    +3%
>  ramdisk    Y    Y    N    64K    18.7k   1170    34.7k   2171   +86%
>  ramdisk    Y    Y    N    1M     1229    1229    2269    2269   +85%
>  nvme       N    N    Y    4K     373k    1458    387k    1512   +4%
>  nvme       N    N    Y    64K    29.2k   1827    70.9k   4431   +143%
>  nvme       N    N    Y    1M     1835    1835    4919    4919   +168%
>  nvme       N    Y    N    4K     11.7k   46      11.7k   46      0%
>  nvme       N    Y    N    64K    6453    403     8661    541    +34%
>  nvme       N    Y    N    1M     649     649     1351    1351   +108%
>  nvme       Y    N    Y    4K     372k    1456    433k    1693   +16%
>  nvme       Y    N    Y    64K    33.0k   2064    74.7k   4669   +126%
>  nvme       Y    N    Y    1M     2131    2131    5273    5273   +147%
>  nvme       Y    Y    N    4K     56.7k   222     56.4k   220    -1%
>  nvme       Y    Y    N    64K    13.4k   840     19.4k   1214   +45%
>  nvme       Y    Y    N    1M     714     714     1504    1504   +111%
>
> Thanks,
> Yi.
>
> Major changes since RFC v4:
>  - Disable unsupported online defragmentation, do not fall back to
>    buffer_head path.
>  - Wite and wait data back while doing partial block truncate down to
>    fix a stale data problem.
>  - Disable the online changing of the inode journal flag to data=3Djourna=
l
>    mode.
>  - Since iomap can zero out dirty pages with unwritten extent, do not
>    write data before zeroing out in ext4_zero_range(), and also do not
>    zero partial blocks under a started journal handle.
>
> [1] https://lore.kernel.org/linux-ext4/20241010133333.146793-1-yi.zhang@h=
uawei.com/
>
> ---
> RFC v4: https://lore.kernel.org/linux-ext4/20240410142948.2817554-1-yi.zh=
ang@huaweicloud.com/
> RFC v3: https://lore.kernel.org/linux-ext4/20240127015825.1608160-1-yi.zh=
ang@huaweicloud.com/
> RFC v2: https://lore.kernel.org/linux-ext4/20240102123918.799062-1-yi.zha=
ng@huaweicloud.com/
> RFC v1: https://lore.kernel.org/linux-ext4/20231123125121.4064694-1-yi.zh=
ang@huaweicloud.com/
>
>
> Zhang Yi (27):
>   ext4: remove writable userspace mappings before truncating page cache
>   ext4: don't explicit update times in ext4_fallocate()
>   ext4: don't write back data before punch hole in nojournal mode
>   ext4: refactor ext4_punch_hole()
>   ext4: refactor ext4_zero_range()
>   ext4: refactor ext4_collapse_range()
>   ext4: refactor ext4_insert_range()
>   ext4: factor out ext4_do_fallocate()
>   ext4: move out inode_lock into ext4_fallocate()
>   ext4: move out common parts into ext4_fallocate()
>   ext4: use reserved metadata blocks when splitting extent on endio
>   ext4: introduce seq counter for the extent status entry
>   ext4: add a new iomap aops for regular file's buffered IO path
>   ext4: implement buffered read iomap path
>   ext4: implement buffered write iomap path
>   ext4: don't order data for inode with EXT4_STATE_BUFFERED_IOMAP
>   ext4: implement writeback iomap path
>   ext4: implement mmap iomap path
>   ext4: do not always order data when partial zeroing out a block
>   ext4: do not start handle if unnecessary while partial zeroing out a
>     block
>   ext4: implement zero_range iomap path
>   ext4: disable online defrag when inode using iomap buffered I/O path
>   ext4: disable inode journal mode when using iomap buffered I/O path
>   ext4: partially enable iomap for the buffered I/O path of regular
>     files
>   ext4: enable large folio for regular file with iomap buffered I/O path
>   ext4: change mount options code style
>   ext4: introduce a mount option for iomap buffered I/O path
>
>  fs/ext4/ext4.h              |  17 +-
>  fs/ext4/ext4_jbd2.c         |   3 +-
>  fs/ext4/ext4_jbd2.h         |   8 +
>  fs/ext4/extents.c           | 568 +++++++++++----------------
>  fs/ext4/extents_status.c    |  13 +-
>  fs/ext4/file.c              |  19 +-
>  fs/ext4/ialloc.c            |   5 +
>  fs/ext4/inode.c             | 755 ++++++++++++++++++++++++++++++------
>  fs/ext4/move_extent.c       |   7 +
>  fs/ext4/page-io.c           | 105 +++++
>  fs/ext4/super.c             | 185 ++++-----
>  include/trace/events/ext4.h |  57 +--
>  12 files changed, 1153 insertions(+), 589 deletions(-)
>
> --
> 2.46.1
>
>

