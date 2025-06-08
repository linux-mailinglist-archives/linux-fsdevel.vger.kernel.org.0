Return-Path: <linux-fsdevel+bounces-50937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 419A7AD13F5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 21:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1CA3188A03C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 19:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4851DDA09;
	Sun,  8 Jun 2025 19:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxW/U1v6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A25C176242;
	Sun,  8 Jun 2025 19:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749409989; cv=none; b=B8T1F6+8dhQDTwXcJcj4rJDivjize0WUzrwi3JQlsgPNz+1hgZ4kO0nCfjWQCpvLFBDGqlOa9tws3hYbAVsJG+JyRjBlLpS45Q6z6NhFk+d4g0YO3CRhTvTI0VtRGz37gP2JTgxMX43gmUu/2/D36H8mlaAIflkFAOClM0GTBwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749409989; c=relaxed/simple;
	bh=J1LCM0a/uMaN4jrc00hrqJKVQzgIO9i3MzBc5sonchA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EpxmkcRs21dGrn97zbYgOyz3Ie/2jBRk5tyzvxCkDLsrh3ilM2/4Y5Vqve8APC6DZPrmI/UTirgRd1ilifyzVi289PkGXpqGwlujd197ZDnNg+F79S1a4l/Bv9sfatgRJyGlGw8xS07djhdcxUCrYe326erLtw/ELkxR7UOqbbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxW/U1v6; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ade58ef47c0so79200566b.1;
        Sun, 08 Jun 2025 12:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749409986; x=1750014786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lLrm60rBkCVc7LQ6+3woFQ80YL0visFy66/hf73vE4=;
        b=HxW/U1v61ABxMwG0luCpR7x7TL7dcGolqk9bTtzdCa6a4tdCvUSgk53WdoItS02o5K
         iYTiLYlltJh0Ho3Svp+GTAuNZy4jyYYqa6owjKkOhSw7A6fNOzaTX63iQHDFXyWV2o7q
         DL7NPa3EmbpIvHmFTn9tEpdHEocsrps0kW/rCdm9DXl1Fu2idzqH7vDhAXA4HkIXwojv
         9qebeYgDwDQSqZbmSgF6Zes53aGrUyuvaFx7nFIksfPKcxNjbDvhYg0Kg32nsdqXA3zy
         pU53DhPx1NX/y2wk5qeScMYJJTcIT5FVUuVtV+Hk39to+tnl17wppuoiYk/hFEaPFn4l
         uH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749409986; x=1750014786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lLrm60rBkCVc7LQ6+3woFQ80YL0visFy66/hf73vE4=;
        b=e29exf5eL14KqmInsjz60lYVyXaszcMeAXRjmCihQwmUKt1+Gsdyj8wleVmNYyiKOQ
         IB22eIcPV7RaVPnzqFiQweNO5YAdz+pGWUj2vrMPeFyhXikD0Wh9jBsjoVtg8VtzF6GZ
         UqPalo5vt0wxMcBVyngDXCkE69MwZfHWxem0jAhuFqxWfHHC89rHDRfeD0zQt0pKl0vQ
         DIlTdVe+5oJNtV8lZxmjs9NWcxl9UPeStTi4IEu3xkgSBd61VPH+fXN0wniYS80BIjBc
         CZs2nQd1IE2jVBKdOFmvAAtSHZSg7x+f/wj9IgNOVSBtuqR8CNnkkZ9GaSpH7+fAAUc3
         YjXA==
X-Forwarded-Encrypted: i=1; AJvYcCUiMzD/arM+yewI4L9z/YHX1ZRymp/gIm6nv645taR1tpjB98FcrugXg0l78m8xp3pseIppxox4UVt/@vger.kernel.org, AJvYcCV1xWklEuZkCUg4lzgV1QrOicltKSMav1qrdRNpqk5jnmFcBcPZsxmyGGfsF39+xJrnZ2cfTUJOSmc0GGgx@vger.kernel.org
X-Gm-Message-State: AOJu0YwmgiIZcKK+cz89Rh1wkoIfvYdCdNl3JYNnuCRsU2Gv86cmG9li
	nZrjNo8JNdvTgPBstl2luNaVn9KASefjgIUqhp7miufgsR3El39qFknMpXEIwQ40dgymEVNaiam
	xhZi+EIgUQs/MKTThB78ua3Yyd3cg2Q==
X-Gm-Gg: ASbGncsQOG+2hYvWGPMAvw4XXiIrVzcLyu0okbCZRiY/wCKDFswZuNr9JZ0UBnCwlQ6
	Dmohkouef51uru7jsFlDkDIXW0GBvkJcFzAcRuxBuEHHpWNWdKYN2075rxu8nOzzpgmcczMQuKa
	LaqmXNQ4iwRocs/k/+ourv8HR6tmdXXNf4xzZwELsN6VZBgalD2XxLEjsUab5TS/HUP2n7cxn4e
	g==
X-Google-Smtp-Source: AGHT+IH4FK3pxXyj6yK9+A0fTBrhkqanZClwwPaVmKPyBQncRhwuV4Hf2ZFWDJwr3ZXNBIZOOJ4YxnDliIBX3IsuAsI=
X-Received: by 2002:a17:907:9308:b0:ad5:6174:f947 with SMTP id
 a640c23a62f3a-ade0782b7b0mr1189196866b.22.1749409986049; Sun, 08 Jun 2025
 12:13:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
In-Reply-To: <20250606233803.1421259-1-joannelkoong@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 9 Jun 2025 00:42:28 +0530
X-Gm-Features: AX0GCFtmVHzRbzGV6hiAVP0_doQZRtyBwh-AtH02y_h_0siWOhav7AK91K6lDH4
Message-ID: <CACzX3As_tiO3c0ko9WJKTOt10dj0q9gNqPym3zFdUbLxib=YNw@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] fuse: use iomap for buffered writes + writeback
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, djwong@kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com, 
	Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 7, 2025 at 5:12=E2=80=AFAM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> This series adds fuse iomap support for buffered writes and dirty folio
> writeback. This is needed so that granular dirty tracking can be used in
> fuse when large folios are enabled so that if only a few bytes in a large
> folio are dirty, only a smaller portion is written out instead of the ent=
ire
> folio.
>
> In order to do so, a new iomap type, IOMAP_IN_MEM, is added that is more
> generic and does not depend on the block layer. The parts of iomap buffer=
 io
> that depend on bios and CONFIG_BLOCK is moved to a separate file,
> buffered-io-bio.c, in order to allow filesystems that do not have CONFIG_=
BLOCK
> set to use IOMAP_IN_MEM buffered io.
>
> This series was run through fstests with large folios enabled and through
> some quick sanity checks on passthrough_hp with a) writing 1 GB in 1 MB c=
hunks
> and then going back and dirtying a few bytes in each chunk and b) writing=
 50 MB
> in 1 MB chunks and going through dirtying the entire chunk for several ru=
ns.
> a) showed about a 40% speedup increase with iomap support added and b) sh=
owed
> roughly the same performance.
>
> This patchset does not enable large folios yet. That will be sent out in =
a
> separate future patchset.
>
>
> Thanks,
> Joanne

Hi Joanne,

I tried experimenting with your patch series to evaluate its impact. To
measure the improvement, I enabled large folios for FUSE. In my setup,
I observed a ~43% reduction in writeback time.

Here=E2=80=99s the script[1] I used to benchmark FUSE writeback performance
based on the details you shared: It formats and mounts an XFS volume,
runs the passthrough_hp FUSE daemon, writes 1MB chunks to populate the
file, and then issues 4-byte overwrites to test fine-grained writeback
behavior.

If I=E2=80=99ve missed anything or there=E2=80=99s a better way to evaluate=
 this, I=E2=80=99d
really appreciate your input =E2=80=94 I=E2=80=99m still getting up to spee=
d with FUSE
internals.

[1]

#!/bin/bash
set -e

DEVICE=3D"/dev/nvme0n1"
BACKING_MNT=3D"/mnt"
FUSE_MNT=3D"/tmp/fusefs"
CHUNK_MB=3D1
TOTAL_MB=3D1024
DIRTY_BYTES=3D4
REPEATS=3D5
LOGFILE=3D"fuse_test_results.csv"
DIR=3D$(date +"%H-%M-%S-%d-%m-%y")

mkdir $DIR
echo "$DIR created"

mkdir -p "$BACKING_MNT" "$FUSE_MNT"

echo "run,duration_seconds" > "$LOGFILE"

for run in $(seq 1 $REPEATS); do
    echo "[Run $run] Formatting $DEVICE with XFS..."
    mkfs.xfs -f "$DEVICE"

    echo "[Run $run] Mounting XFS to $BACKING_MNT..."
    mount "$DEVICE" "$BACKING_MNT"

    echo "[Run $run] Starting passthrough_hp on $FUSE_MNT..."
    ./passthrough_hp --nopassthrough "$BACKING_MNT" "$FUSE_MNT" &
    sleep 2

    echo "[Run $run] Dropping caches and syncing..."
    sync
    echo 3 > /proc/sys/vm/drop_caches

    TEST_FILE=3D"$FUSE_MNT/testfile_run${run}"

    for ((i=3D0; i<$TOTAL_MB; i++)); do
        dd if=3D/dev/urandom bs=3D1M count=3D1 oflag=3Ddirect seek=3D$i
of=3D$TEST_FILE status=3Dnone
    done

    START=3D$(date +%s.%N)
    for ((i=3D0; i<$TOTAL_MB; i++)); do
        offset=3D$((i * 1048576 + 1048572))
        #offset=3D$((i * 1048576))
        dd if=3D/dev/urandom bs=3D1 count=3D$DIRTY_BYTES of=3D$TEST_FILE
seek=3D$offset status=3Dnone
    done

    fusermount -u "$FUSE_MNT"
    umount "$BACKING_MNT"

    END=3D$(date +%s.%N)
    DURATION=3D$(echo "$END - $START" | bc)
    echo "$run,$DURATION" >> $DIR/"$LOGFILE"
    echo "[Run $run] Duration: ${DURATION}s"
done

echo "All runs complete. Results saved to $DIR/$LOGFILE."

