Return-Path: <linux-fsdevel+bounces-10241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991C98493CE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 07:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C8E284225
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 06:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BCFC139;
	Mon,  5 Feb 2024 06:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RU9sXSsN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE21BE48;
	Mon,  5 Feb 2024 06:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707114093; cv=none; b=pDRdeKmrF2+6giYhXeEM/OFoLrhkWpLm1+CWvzDqGMhraHvf9UmnUeeBsgh2IdGRttB6SlpQaA5tT0w0GY5b3SNf9e8ev2Zav+gATDYWj2zyMXyNw3m7reLqtpigM+QN91cHqUT83yJmqX7ofNrPDahzbYtF54fI7s7qihfxYmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707114093; c=relaxed/simple;
	bh=rFVBM0Rfe1ppqZxGSGpFt9mP4YPxyA+6uxlqAlDa3cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y80643CjS/TSuLIfgY9+6hefxt3NHWuuHDzj/7mbiKP9CB/MM9D0SbaSK/3fVWeDBS2ULVuuw0nKnSuZSNt2HFUvZh5Ay4M/RFxSFB16z/CAFdNXOcVwqM1VG6u64RY43ckiJExapbmyaEKMEb7FZl4YxPQU7PDn6tWbmUEwNB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RU9sXSsN; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d0b2cd472bso603201fa.1;
        Sun, 04 Feb 2024 22:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707114088; x=1707718888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaWNuOILZHZY1oqA6xOgowQE3jgWO75+70QGsK+HL8s=;
        b=RU9sXSsNzfJjoHU4oMaLBDCBaUBQrua6cxMJOOy4cj2K23bsCDprMQPUMFroS9m3nI
         ipxymsVCKuNLB4lmKNz6JRohksDgRSvHvSoKJy+B0c/JR6+FuSiUaCIhxmGNvnF0A9+/
         pL27NONGX+QScSOeikfcz9ynoKoHtekAk6mJqoxFVEDSPXOmuTy2gRk+WZTurVz/DhLo
         1f6opCfluR1nC+ALFwZA8PRiAJ5W6Fs+W0InVJZ8hEeKcFuD3O0lDL2fEzFOkoSZX7Y2
         AQiMapTURLr8tcN2lbUYoNkvv3RWHbaihKhbJDvZaGN+LE+B8kwiPG/m6xVViyTyCsie
         dJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707114088; x=1707718888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaWNuOILZHZY1oqA6xOgowQE3jgWO75+70QGsK+HL8s=;
        b=bBCDOOIyboirDPrX9vxquvNEbUKyE3hX7FD6XInO50xiVRjjhlE16/ZGOXzUS0ixfv
         yt0H1LRQXDC6r74wmExoney2fv8Yvysww52g39BBy6KARU48NA/pdxzkHj3wZG9dMVmn
         cq+b0IluMJr4eec+mQ18byWi9Oi0SGAleEjiCsdxlIsWBu6JmZb/OQha/Gx3CtwlPJ+m
         AkXyvAmpqJq4ci8vNWF/IU8v3y2ao2s3TFFLtS8qwer/OsxAVe5BFfVpkbBBFZ37d/xS
         lLypK7UO1nxWjeuPA4yTzHSZ3PBrCQzo8Z0VjqOS/SnmJyoiGRzmBjv5i7Xvczmqeot1
         6QPw==
X-Gm-Message-State: AOJu0YzDChSZREKvxPBzLBefIPkh1pxvRiuWjpW7J5fEQDS3TMFeSL57
	8lR1GrI5h+PssWnVxFGu6CkOR1X866TlmCP4J4y4Afg64Z0HaJt5AMSsAyKFYAQA/677NiIg+3I
	pAyHfilXy9AiWZSEAw3UeuGDhFJg=
X-Google-Smtp-Source: AGHT+IE9f2NBnAqNBzef7vKo8wpcbfvglPKtAaBkBv+2RobGyfBRmQoopET1iarmhHn8EjvEcFBi68OUgj5/PlehGgo=
X-Received: by 2002:a2e:b616:0:b0:2d0:8294:27c7 with SMTP id
 r22-20020a2eb616000000b002d0829427c7mr1660212ljn.1.1707114088291; Sun, 04 Feb
 2024 22:21:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205055705.7078-1-zhaoyang.huang@unisoc.com>
In-Reply-To: <20240205055705.7078-1-zhaoyang.huang@unisoc.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Mon, 5 Feb 2024 14:21:16 +0800
Message-ID: <CAGWkznFqwXJBEuJzmfvqEkFdyzwcSv5SZtRZ0967K1D_OO-Y+w@mail.gmail.com>
Subject: Re: [PATCHv7 1/1] block: introduce content activity based ioprio
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>, Yu Zhao <yuzhao@google.com>, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ps: This commit is verified based on the deadline io scheduler and two
blkcg configured[2]. The modified fs files are listed in [2]

[1]
/dev/blkio # cat background/blkio.prio.class
no-change
dev/blkio # cat foreground/blkio.prio.class
none-to-rt

[2]

diff --git a/fs/buffer.c b/fs/buffer.c
index 12e9a71..ef91374 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -50,6 +50,7 @@
 #include <linux/fscrypt.h>
 #include <linux/fsverity.h>
 #include <linux/sched/isolation.h>
+#include <linux/act_ioprio.h>

 #include "internal.h"

@@ -2823,6 +2824,8 @@
  wbc_account_cgroup_owner(wbc, bh->b_page, bh->b_size);
  }

+ bio_set_active_ioprio(bio);
+
  submit_bio(bio);
 }

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index a7e6847..53ae283 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -8,6 +8,7 @@
 #include <linux/psi.h>
 #include <linux/cpuhotplug.h>
 #include <trace/events/erofs.h>
+#include <linux/act_ioprio.h>

 #define Z_EROFS_PCLUSTER_MAX_PAGES (Z_EROFS_PCLUSTER_MAX_SIZE / PAGE_SIZE)
 #define Z_EROFS_INLINE_BVECS 2
@@ -1688,6 +1689,7 @@
  if (bio && (cur !=3D last_index + 1 ||
     last_bdev !=3D mdev.m_bdev)) {
 submit_bio_retry:
+ bio_set_active_ioprio(bio);
  submit_bio(bio);
  if (memstall) {
  psi_memstall_leave(&pflags);
@@ -1729,6 +1731,7 @@
  } while (owned_head !=3D Z_EROFS_PCLUSTER_TAIL);

  if (bio) {
+ bio_set_active_ioprio(bio);
  submit_bio(bio);
  if (memstall)
  psi_memstall_leave(&pflags);
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index dfdd7e5..400b6b5 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/sched/mm.h>
+#include <linux/act_ioprio.h>

 #include "ext4_jbd2.h"
 #include "xattr.h"
@@ -375,6 +376,7 @@
  if (bio) {
  if (io->io_wbc->sync_mode =3D=3D WB_SYNC_ALL)
  io->io_bio->bi_opf |=3D REQ_SYNC;
+ bio_set_active_ioprio(io->io_bio);
  submit_bio(io->io_bio);
  }
  io->io_bio =3D NULL;
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 3e7d160..6374cf5a9 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -43,6 +43,7 @@
 #include <linux/writeback.h>
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
+#include <linux/act_ioprio.h>

 #include "ext4.h"

@@ -351,6 +352,7 @@
  if (bio && (last_block_in_bio !=3D blocks[0] - 1 ||
     !fscrypt_mergeable_bio(bio, inode, next_block))) {
  submit_and_realloc:
+ bio_set_active_ioprio(bio);
  submit_bio(bio);
  bio =3D NULL;
  }
@@ -377,6 +379,7 @@
  if (((map.m_flags & EXT4_MAP_BOUNDARY) &&
      (relative_block =3D=3D map.m_len)) ||
     (first_hole !=3D blocks_per_page)) {
+ bio_set_active_ioprio(bio);
  submit_bio(bio);
  bio =3D NULL;
  } else
@@ -384,6 +387,7 @@
  continue;
  confused:
  if (bio) {
+ bio_set_active_ioprio(bio);
  submit_bio(bio);
  bio =3D NULL;
  }
@@ -394,8 +398,10 @@
 next_page:
  ; /* A label shall be followed by a statement until C23 */
  }
- if (bio)
+ if (bio) {
+ bio_set_active_ioprio(bio);
  submit_bio(bio);
+ }
  return 0;
 }

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2893054..6613e104 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -21,6 +21,7 @@
 #include <linux/sched/signal.h>
 #include <linux/fiemap.h>
 #include <linux/iomap.h>
+#include <linux/act_ioprio.h>

 #include "f2fs.h"
 #include "node.h"
@@ -525,6 +526,7 @@
  trace_f2fs_submit_read_bio(sbi->sb, type, bio);

  iostat_update_submit_ctx(bio, type);
+ bio_set_active_ioprio(bio);
  submit_bio(bio);
 }

@@ -575,6 +577,7 @@

  trace_f2fs_submit_write_bio(sbi->sb, type, bio);
  iostat_update_submit_ctx(bio, type);
+ bio_set_active_ioprio(bio);
  submit_bio(bio);
 }

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 2bc0aa2..4a85690 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -17,6 +17,7 @@
 #include <linux/bio.h>
 #include <linux/sched/signal.h>
 #include <linux/migrate.h>
+#include <linux/act_ioprio.h>
 #include "trace.h"

 #include "../internal.h"
@@ -369,8 +370,10 @@
  gfp_t orig_gfp =3D gfp;
  unsigned int nr_vecs =3D DIV_ROUND_UP(length, PAGE_SIZE);

- if (ctx->bio)
+ if (ctx->bio) {
+ bio_set_active_ioprio(ctx->bio);
  submit_bio(ctx->bio);
+ }

  if (ctx->rac) /* same as readahead_gfp_mask */
  gfp |=3D __GFP_NORETRY | __GFP_NOWARN;
@@ -423,6 +426,7 @@
  folio_set_error(folio);

  if (ctx.bio) {
+ bio_set_active_ioprio(ctx.bio);
  submit_bio(ctx.bio);
  WARN_ON_ONCE(!ctx.cur_folio_in_bio);
  } else {
@@ -495,8 +499,10 @@
  while (iomap_iter(&iter, ops) > 0)
  iter.processed =3D iomap_readahead_iter(&iter, &ctx);

- if (ctx.bio)
+ if (ctx.bio) {
+ bio_set_active_ioprio(ctx.bio);
  submit_bio(ctx.bio);
+ }
  if (ctx.cur_folio) {
  if (!ctx.cur_folio_in_bio)
  folio_unlock(ctx.cur_folio);
@@ -624,6 +630,7 @@
  bio_init(&bio, iomap->bdev, &bvec, 1, REQ_OP_READ);
  bio.bi_iter.bi_sector =3D iomap_sector(iomap, block_start);
  bio_add_folio_nofail(&bio, folio, plen, poff);
+ bio_set_active_ioprio(&bio);
  return submit_bio_wait(&bio);
 }

@@ -1648,7 +1655,7 @@
  bio_endio(ioend->io_bio);
  return error;
  }
-
+ bio_set_active_ioprio(ioend->io_bio);
  submit_bio(ioend->io_bio);
  return 0;
 }
@@ -1697,6 +1704,7 @@

  bio_chain(prev, new);
  bio_get(prev); /* for iomap_finish_ioend */
+ bio_set_active_ioprio(prev);
  submit_bio(prev);
  return new;
 }
diff --git a/fs/mpage.c b/fs/mpage.c
index 242e213..bb1abe7 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -29,6 +29,7 @@
 #include <linux/writeback.h>
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
+#include <linux/act_ioprio.h>
 #include "internal.h"

 /*
@@ -79,6 +80,7 @@
 {
  bio->bi_end_io =3D mpage_read_end_io;
  guard_bio_eod(bio);
+ bio_set_active_ioprio(bio);
  submit_bio(bio);
  return NULL;
 }
@@ -87,6 +89,7 @@
 {
  bio->bi_end_io =3D mpage_write_end_io;
  guard_bio_eod(bio);
+ bio_set_active_ioprio(bio);
  submit_bio(bio);
  return NULL;
 }

On Mon, Feb 5, 2024 at 1:59=E2=80=AFPM zhaoyang.huang <zhaoyang.huang@uniso=
c.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> Currently, request's ioprio are set via task's schedule priority(when no
> blkcg configured), which has high priority tasks possess the privilege on
> both of CPU and IO scheduling. Furthermore, most of the write requestes
> are launched asynchronosly from kworker which can't know the submitter's
> priorities.
> This commit works as a hint of original policy by promoting the request
> ioprio based on the page/folio's activity. The original idea comes from
> LRU_GEN which provides more precised folio activity than before. This
> commit try to adjust the request's ioprio when certain part of its folios
> are hot, which indicate that this request carry important contents and
> need be scheduled ealier.
> The filesystem should call bio_set_active_ioprio() before submit_bio on t=
he
> spot where they want(buffered read/write/sync etc).
>
> This commit is verified on a v6.6 6GB RAM android14 system via 4 test cas=
es
> by calling bio_set_active_ioprio in erofs, ext4, f2fs and blkdev(raw
> partition of gendisk)
>
> Case 1:
> script[a] which get significant improved fault time as expected[b]*
> where dd's cost also shrink from 55s to 40s.
> (1). fault_latency.bin is an ebpf based test tool which measure all task'=
s
>    iowait latency during page fault when scheduled out/in.
> (2). costmem generate page fault by mmaping a file and access the VA.
> (3). dd generate concurrent vfs io.
>
> [a]
> ./fault_latency.bin 1 5 > /data/dd_costmem &
> costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
> costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
> costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
> costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
> dd if=3D/dev/block/sda of=3D/data/ddtest bs=3D1024 count=3D2048000 &
> dd if=3D/dev/block/sda of=3D/data/ddtest1 bs=3D1024 count=3D2048000 &
> dd if=3D/dev/block/sda of=3D/data/ddtest2 bs=3D1024 count=3D2048000 &
> dd if=3D/dev/block/sda of=3D/data/ddtest3 bs=3D1024 count=3D2048000
> [b]
>                        mainline         commit
> io wait                736us            523us
>
> * provide correct result for test case 1 in v7 which was compared between
> EMMC and UFS wrongly.
>
> Case 2:
> fio -filename=3D/dev/block/by-name/userdata -rw=3Drandread -direct=3D0 -b=
s=3D4k -size=3D2000M -numjobs=3D8 -group_reporting -name=3Dmytest
> mainline: 513MiB/s
> READ: bw=3D531MiB/s (557MB/s), 531MiB/s-531MiB/s (557MB/s-557MB/s), io=3D=
15.6GiB (16.8GB), run=3D30137-30137msec
> READ: bw=3D543MiB/s (569MB/s), 543MiB/s-543MiB/s (569MB/s-569MB/s), io=3D=
15.6GiB (16.8GB), run=3D29469-29469msec
> READ: bw=3D474MiB/s (497MB/s), 474MiB/s-474MiB/s (497MB/s-497MB/s), io=3D=
15.6GiB (16.8GB), run=3D33724-33724msec
> READ: bw=3D535MiB/s (561MB/s), 535MiB/s-535MiB/s (561MB/s-561MB/s), io=3D=
15.6GiB (16.8GB), run=3D29928-29928msec
> READ: bw=3D523MiB/s (548MB/s), 523MiB/s-523MiB/s (548MB/s-548MB/s), io=3D=
15.6GiB (16.8GB), run=3D30617-30617msec
> READ: bw=3D492MiB/s (516MB/s), 492MiB/s-492MiB/s (516MB/s-516MB/s), io=3D=
15.6GiB (16.8GB), run=3D32518-32518msec
> READ: bw=3D533MiB/s (559MB/s), 533MiB/s-533MiB/s (559MB/s-559MB/s), io=3D=
15.6GiB (16.8GB), run=3D29993-29993msec
> READ: bw=3D524MiB/s (550MB/s), 524MiB/s-524MiB/s (550MB/s-550MB/s), io=3D=
15.6GiB (16.8GB), run=3D30526-30526msec
> READ: bw=3D529MiB/s (554MB/s), 529MiB/s-529MiB/s (554MB/s-554MB/s), io=3D=
15.6GiB (16.8GB), run=3D30269-30269msec
> READ: bw=3D449MiB/s (471MB/s), 449MiB/s-449MiB/s (471MB/s-471MB/s), io=3D=
15.6GiB (16.8GB), run=3D35629-35629msec
>
> commit: 633MiB/s
> READ: bw=3D668MiB/s (700MB/s), 668MiB/s-668MiB/s (700MB/s-700MB/s), io=3D=
15.6GiB (16.8GB), run=3D23952-23952msec
> READ: bw=3D589MiB/s (618MB/s), 589MiB/s-589MiB/s (618MB/s-618MB/s), io=3D=
15.6GiB (16.8GB), run=3D27164-27164msec
> READ: bw=3D638MiB/s (669MB/s), 638MiB/s-638MiB/s (669MB/s-669MB/s), io=3D=
15.6GiB (16.8GB), run=3D25071-25071msec
> READ: bw=3D714MiB/s (749MB/s), 714MiB/s-714MiB/s (749MB/s-749MB/s), io=3D=
15.6GiB (16.8GB), run=3D22409-22409msec
> READ: bw=3D600MiB/s (629MB/s), 600MiB/s-600MiB/s (629MB/s-629MB/s), io=3D=
15.6GiB (16.8GB), run=3D26669-26669msec
> READ: bw=3D592MiB/s (621MB/s), 592MiB/s-592MiB/s (621MB/s-621MB/s), io=3D=
15.6GiB (16.8GB), run=3D27036-27036msec
> READ: bw=3D691MiB/s (725MB/s), 691MiB/s-691MiB/s (725MB/s-725MB/s), io=3D=
15.6GiB (16.8GB), run=3D23150-23150msec
> READ: bw=3D569MiB/s (596MB/s), 569MiB/s-569MiB/s (596MB/s-596MB/s), io=3D=
15.6GiB (16.8GB), run=3D28142-28142msec
> READ: bw=3D563MiB/s (590MB/s), 563MiB/s-563MiB/s (590MB/s-590MB/s), io=3D=
15.6GiB (16.8GB), run=3D28429-28429msec
> READ: bw=3D712MiB/s (746MB/s), 712MiB/s-712MiB/s (746MB/s-746MB/s), io=3D=
15.6GiB (16.8GB), run=3D22478-22478msec
>
> Case 3:
> This commit is also verified by the case of launching camera APP which is
> usually considered as heavy working load on both of memory and IO, which
> shows 12%-24% improvement.
>
>                 ttl =3D 0         ttl =3D 50        ttl =3D 100
> mainline        2267ms          2420ms          2316ms
> commit          1992ms          1806ms          1998ms
>
> case 4:
> androbench has no improvment as well as regression in RD/WR test item
> while make a 3% improvement in sqlite items.
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
> change of v2: calculate page's activity via helper function
> change of v3: solve layer violation by move API into mm
> change of v4: keep block clean by removing the page related API
> change of v5: introduce the macros of bio_add_folio/page for read dir.
> change of v6: replace the macro of bio_add_xxx by submit_bio which
>                 iterating the bio_vec before launching bio to block layer
> change of v7: introduce the function bio_set_active_ioprio
>               provide updated test result
> ---
> ---
>  block/Kconfig       | 15 ++++++++++++
>  block/bio.c         | 56 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/bio.h |  1 +
>  3 files changed, 72 insertions(+)
>
> diff --git a/block/Kconfig b/block/Kconfig
> index f1364d1c0d93..2dbcd8d92052 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -228,6 +228,21 @@ config BLOCK_HOLDER_DEPRECATED
>  config BLK_MQ_STACKING
>         bool
>
> +config BLK_CONT_ACT_BASED_IOPRIO
> +       bool "Enable content activity based ioprio"
> +       depends on LRU_GEN
> +       default n
> +       help
> +         This item enable the feature of adjust bio's priority by
> +         calculating its content's activity.
> +         This feature works as a hint of original bio_set_ioprio
> +         which means rt task get no change of its bio->bi_ioprio
> +         while other tasks have the opportunity to raise the ioprio
> +         if the bio take certain numbers of active pages.
> +         The file system should use this by modifying their buffered
> +         read/write/sync function to raise the bio->bi_ioprio before
> +         calling submit_bio.
> +
>  source "block/Kconfig.iosched"
>
>  endif # BLOCK
> diff --git a/block/bio.c b/block/bio.c
> index 816d412c06e9..9e2d1e018c98 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1476,6 +1476,62 @@ void bio_set_pages_dirty(struct bio *bio)
>  }
>  EXPORT_SYMBOL_GPL(bio_set_pages_dirty);
>
> +/*
> + * bio_set_active_ioprio() is helper function for fs to adjust the bio's=
 ioprio via
> + * calculating the content's activity which measured from MGLRU.
> + * The file system should call this function before submit_bio for the b=
uffered
> + * read/write/sync.
> + */
> +#ifdef CONFIG_BLK_CONT_ACT_BASED_IOPRIO
> +void bio_set_active_ioprio(struct bio *bio)
> +{
> +       struct bio_vec bv;
> +       struct bvec_iter iter;
> +       struct page *page;
> +       int class, level, hint;
> +       int activity =3D 0;
> +       int cnt =3D 0;
> +
> +       class =3D IOPRIO_PRIO_CLASS(bio->bi_ioprio);
> +       level =3D IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
> +       hint =3D IOPRIO_PRIO_HINT(bio->bi_ioprio);
> +       /*apply legacy ioprio policy on RT task*/
> +       if (task_is_realtime(current)) {
> +               bio->bi_ioprio =3D IOPRIO_PRIO_VALUE_HINT(IOPRIO_CLASS_RT=
, level, hint);
> +               return;
> +       }
> +       bio_for_each_bvec(bv, bio, iter) {
> +               page =3D bv.bv_page;
> +               activity +=3D PageWorkingset(page) ? 1 : 0;
> +               cnt++;
> +               if (activity > bio->bi_vcnt / 2) {
> +                       class =3D IOPRIO_CLASS_RT;
> +                       break;
> +               } else if (activity > bio->bi_vcnt / 4) {
> +                       /*
> +                        * all itered pages are all active so far
> +                        * then raise to RT directly
> +                        */
> +                       if (activity =3D=3D cnt) {
> +                               class =3D IOPRIO_CLASS_RT;
> +                               break;
> +                       } else
> +                               class =3D max(IOPRIO_PRIO_CLASS(get_curre=
nt_ioprio()),
> +                                               IOPRIO_CLASS_BE);
> +               }
> +       }
> +       if (!class && activity > cnt / 2)
> +               class =3D IOPRIO_CLASS_RT;
> +       else if (!class && activity > cnt / 4)
> +               class =3D max(IOPRIO_PRIO_CLASS(get_current_ioprio()), IO=
PRIO_CLASS_BE);
> +
> +       bio->bi_ioprio =3D IOPRIO_PRIO_VALUE_HINT(class, level, hint);
> +}
> +#else
> +void bio_set_active_ioprio(struct bio *bio) {}
> +#endif
> +EXPORT_SYMBOL_GPL(bio_set_active_ioprio);
> +
>  /*
>   * bio_check_pages_dirty() will check that all the BIO's pages are still=
 dirty.
>   * If they are, then fine.  If, however, some pages are clean then they =
must
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 41d417ee1349..58e33d8b0f5f 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -487,6 +487,7 @@ void bio_iov_bvec_set(struct bio *bio, struct iov_ite=
r *iter);
>  void __bio_release_pages(struct bio *bio, bool mark_dirty);
>  extern void bio_set_pages_dirty(struct bio *bio);
>  extern void bio_check_pages_dirty(struct bio *bio);
> +extern void bio_set_active_ioprio(struct bio *bio);
>
>  extern void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_it=
er,
>                                struct bio *src, struct bvec_iter *src_ite=
r);
> --
> 2.25.1
>

