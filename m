Return-Path: <linux-fsdevel+bounces-51066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 165DBAD2712
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 21:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6411891EF6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 19:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B7C220694;
	Mon,  9 Jun 2025 19:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+mnC8CX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4FE15B102;
	Mon,  9 Jun 2025 19:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749499173; cv=none; b=E/Lyvo7wqBj6++5a3a0qURNpo2aE1aQTLBTBn72Y7YGX+6LpB7LE1VoXVNhfXxUb8NYdrSiRod47bE3USQJASxvqGj6Euaqb5niBKlMnZ2hvBGkPDeoXeLDHU85iNeYo6sEZR/fx74g3MUpbNCxbvlqZ6ZL0AZhCSi6Nlt0/kV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749499173; c=relaxed/simple;
	bh=qZ5QauLZsHDM7iwoMzXasuRRgrs+fJs7ACJz7ORfGF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLyrPKCYBMwTcMVNbeM6dEnxZIDacighh7XnKYizk4N8bO7h85ClzY0j7uRyL8UwS6Hb0xuCZl33HZ964sVxh7Csd5gJIFL+daVJYfZSypNiAd2eTo338QKvonb9UW7iZ2k1B6luc4wdvPgi/YwQ3MjSHTvq5OEtESLygHbT4nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+mnC8CX; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a44b9b2af8so29197411cf.3;
        Mon, 09 Jun 2025 12:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749499171; x=1750103971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Q3u9Wt3iJWwnXKGNA+7vBREjJPyAR28UKKcGRJ46m0=;
        b=c+mnC8CXlDuV/KHMS3OpuLhWgTLcCuV26eLTAiIns+kXJoT71bLxox49M7HMHhF/kZ
         sW0nOdOmdtxyFXXO+zoNTCrW3qfYxtRCXZ/BplkPX7mPh+xbqNUgtnnh12W4jzIDxQ3Q
         I8vjUNOQZ+BucdWdgO3FFPSKUh0Ma43FXh/JSNGjFkvMeiLP4fA26wUUQpQeBxk7BolV
         MWKR4XVVzJon2g4IJbI+BWamkYrA6TDPiHAeRQX5eHM3BMxSNj0QDDwexK5b2ZvQxGlx
         ZtkEzTwXjUpNPP5phtepI42SImyPpDma1QJzHrwEHEdoBF8DG75rUF3q6ZkiOYe3dpQj
         hwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749499171; x=1750103971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Q3u9Wt3iJWwnXKGNA+7vBREjJPyAR28UKKcGRJ46m0=;
        b=J6GWCAHSaDRD+SZzlcmY91bXfk+Cn9opC2UJqjFgxPvNMNQ4e/8u3UN449VPywSkmi
         SF5HBdQOqTOxRqY+oekInKb5aR97ufp9MjFGCbECH3F/5EQg1udGRexdbzjS6T8M9XTx
         0EiDxsekbLUTePdBBj+PGlDILk6k8QbiwNePlN333qylSvGEqIDqXjTujA4+Pn7V72/i
         wfYvBgoblwnOlNylJ+ovusDYJfqOBqbCXosHqEdo01V7YFDmotK8lEOngF1G9J+zxOKV
         7PZvGQVzX/CCVJqcrIUQps+kjbDNBa0KUNFVL83AZLnLO0R6dZbSEcDdjYQQmt26xGUJ
         HbRg==
X-Forwarded-Encrypted: i=1; AJvYcCXKSweZaNEBhhSeP7iJtXgCDbilFCDiCuv4TThvwzjkVV6WyELeGzWGCEepYBkVk1gs93/vVhx9hEGvgUSj@vger.kernel.org, AJvYcCXyobYWZxW4LMov7daoX6PCtLZRIz8u+VFYsFcauOguzf33KoDq0lKP9dib3ybswBHAOXWFsJjIO2JW@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd0TSYWkh1s/lMBv1Y15pjBpW0f+zVHNepOpsoEpPvG8s47EaH
	RRi+wUudE++VLN0fkP1tZ/nWEmg0agkRpTUI2RFHjtwk5ExOZfvoY5wQ3kBUTPgpLfQj5Oq7SD3
	esy2UAM9nWnYXicXB1rDjB2QXdF/ghig=
X-Gm-Gg: ASbGncv7KMfi0Tw9Y38bWj/dMIeHjh0cI4OUx6+OxmpFuqmaUcHX7aKcXGapbdrgxGA
	3DNtic/afKeOhzCSJFphfFNprZqqFFG3ubkOAI6kelKaqVJnfceAqr+BevYOhSByIAeLDFmEbGM
	3N+9RHoxYv41LRvOP/q4zJkEGtajfuBIVq
X-Google-Smtp-Source: AGHT+IEHxZC4odj94pFMas5a4eoVQxOKYodd8JQY6H4K+wS4orcosfDXhNYCenA6z1rBalbrVjte2q5aaPs3aFePeX0=
X-Received: by 2002:a05:622a:1346:b0:4a6:f4ca:68e8 with SMTP id
 d75a77b69052e-4a6f4ca6c97mr116300701cf.48.1749499170990; Mon, 09 Jun 2025
 12:59:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606233803.1421259-1-joannelkoong@gmail.com> <CACzX3As_tiO3c0ko9WJKTOt10dj0q9gNqPym3zFdUbLxib=YNw@mail.gmail.com>
In-Reply-To: <CACzX3As_tiO3c0ko9WJKTOt10dj0q9gNqPym3zFdUbLxib=YNw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 9 Jun 2025 12:59:19 -0700
X-Gm-Features: AX0GCFuQRx2Rc1DHMWP4Jl2WYSAmw53k0XXXaqlV66suXieKl1Wprkxnd0EXqaU
Message-ID: <CAJnrk1Z2QSVbALJpt2-nXjg+gFDH2mdnXUDTMEkyhxcvwh8B5A@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] fuse: use iomap for buffered writes + writeback
To: Anuj gupta <anuj1072538@gmail.com>
Cc: miklos@szeredi.hu, djwong@kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com, 
	Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 12:13=E2=80=AFPM Anuj gupta <anuj1072538@gmail.com> =
wrote:
>
> On Sat, Jun 7, 2025 at 5:12=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
> >
> > This series adds fuse iomap support for buffered writes and dirty folio
> > writeback. This is needed so that granular dirty tracking can be used i=
n
> > fuse when large folios are enabled so that if only a few bytes in a lar=
ge
> > folio are dirty, only a smaller portion is written out instead of the e=
ntire
> > folio.
> >
> > In order to do so, a new iomap type, IOMAP_IN_MEM, is added that is mor=
e
> > generic and does not depend on the block layer. The parts of iomap buff=
er io
> > that depend on bios and CONFIG_BLOCK is moved to a separate file,
> > buffered-io-bio.c, in order to allow filesystems that do not have CONFI=
G_BLOCK
> > set to use IOMAP_IN_MEM buffered io.
> >
> > This series was run through fstests with large folios enabled and throu=
gh
> > some quick sanity checks on passthrough_hp with a) writing 1 GB in 1 MB=
 chunks
> > and then going back and dirtying a few bytes in each chunk and b) writi=
ng 50 MB
> > in 1 MB chunks and going through dirtying the entire chunk for several =
runs.
> > a) showed about a 40% speedup increase with iomap support added and b) =
showed
> > roughly the same performance.
> >
> > This patchset does not enable large folios yet. That will be sent out i=
n a
> > separate future patchset.
> >
> >
> > Thanks,
> > Joanne
>
> Hi Joanne,
>
> I tried experimenting with your patch series to evaluate its impact. To
> measure the improvement, I enabled large folios for FUSE. In my setup,
> I observed a ~43% reduction in writeback time.
>
> Here=E2=80=99s the script[1] I used to benchmark FUSE writeback performan=
ce
> based on the details you shared: It formats and mounts an XFS volume,
> runs the passthrough_hp FUSE daemon, writes 1MB chunks to populate the
> file, and then issues 4-byte overwrites to test fine-grained writeback
> behavior.
>
> If I=E2=80=99ve missed anything or there=E2=80=99s a better way to evalua=
te this, I=E2=80=99d
> really appreciate your input =E2=80=94 I=E2=80=99m still getting up to sp=
eed with FUSE
> internals.

Hi Anuj,

Thanks for testing it out locally and sharing the benchmarks. Your
test is pretty much the same as mine (except the underlying filesystem
I used for passthrough is ext4). I saw roughly a 40% speedup as well
for buffered writes.

My main concern was whether iomap overhead ends up slowing down writes
that don't need granular dirty tracking. I didn't see any noticeable
difference in performance though when I tested it out by writing out
all entire chunks.

>
> [1]
>
> #!/bin/bash
> set -e
>
> DEVICE=3D"/dev/nvme0n1"
> BACKING_MNT=3D"/mnt"
> FUSE_MNT=3D"/tmp/fusefs"
> CHUNK_MB=3D1
> TOTAL_MB=3D1024
> DIRTY_BYTES=3D4
> REPEATS=3D5
> LOGFILE=3D"fuse_test_results.csv"
> DIR=3D$(date +"%H-%M-%S-%d-%m-%y")
>
> mkdir $DIR
> echo "$DIR created"
>
> mkdir -p "$BACKING_MNT" "$FUSE_MNT"
>
> echo "run,duration_seconds" > "$LOGFILE"
>
> for run in $(seq 1 $REPEATS); do
>     echo "[Run $run] Formatting $DEVICE with XFS..."
>     mkfs.xfs -f "$DEVICE"
>
>     echo "[Run $run] Mounting XFS to $BACKING_MNT..."
>     mount "$DEVICE" "$BACKING_MNT"
>
>     echo "[Run $run] Starting passthrough_hp on $FUSE_MNT..."
>     ./passthrough_hp --nopassthrough "$BACKING_MNT" "$FUSE_MNT" &
>     sleep 2
>
>     echo "[Run $run] Dropping caches and syncing..."
>     sync
>     echo 3 > /proc/sys/vm/drop_caches
>
>     TEST_FILE=3D"$FUSE_MNT/testfile_run${run}"
>
>     for ((i=3D0; i<$TOTAL_MB; i++)); do
>         dd if=3D/dev/urandom bs=3D1M count=3D1 oflag=3Ddirect seek=3D$i
> of=3D$TEST_FILE status=3Dnone
>     done
>
>     START=3D$(date +%s.%N)
>     for ((i=3D0; i<$TOTAL_MB; i++)); do
>         offset=3D$((i * 1048576 + 1048572))
>         #offset=3D$((i * 1048576))
>         dd if=3D/dev/urandom bs=3D1 count=3D$DIRTY_BYTES of=3D$TEST_FILE
> seek=3D$offset status=3Dnone
>     done
>
>     fusermount -u "$FUSE_MNT"
>     umount "$BACKING_MNT"
>
>     END=3D$(date +%s.%N)
>     DURATION=3D$(echo "$END - $START" | bc)
>     echo "$run,$DURATION" >> $DIR/"$LOGFILE"
>     echo "[Run $run] Duration: ${DURATION}s"
> done
>
> echo "All runs complete. Results saved to $DIR/$LOGFILE."

