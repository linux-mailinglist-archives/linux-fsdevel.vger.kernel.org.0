Return-Path: <linux-fsdevel+bounces-36044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E119DB231
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 05:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD0A6282517
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 04:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B71113BC35;
	Thu, 28 Nov 2024 04:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fm54Osml"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849DD2745C;
	Thu, 28 Nov 2024 04:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732768318; cv=none; b=kk1O/nLdKtIOCDQ7U+OTxOrkAYwEiqM7oAaKPMLimXQLqWiqbhGhnEjtzvccWkHYXFhCfAHZiVXBBtOx5cAab7rilNPPLpOAPcKeXrvwXhoHZOIvc3ZlznRLTgJpZUnz6YfuSl7iItjJHd9yvkvwjOA/U/r8m1bibe8vuC1UMAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732768318; c=relaxed/simple;
	bh=fTkERx+JjPmIFN/w44dTJSVeYLnAT/xEJR0xipGroac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UcOnBemlJY/fZBImH71uZHKALSsCxMkMmPEsk9ReT30VWwdeuez0pMKNXW3Fr7VbWsYk7OknGpY9o/8zKK2n6VoEV9totvYtIJCfUGcW0nkC78u/j/xJ7KdPSMY3vYbvgVk+V/afVUlO+eoZtyV8hVnLGk8qNZhMYnnBJl+0xqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fm54Osml; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2973b53ec02so289248fac.1;
        Wed, 27 Nov 2024 20:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732768315; x=1733373115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQOBj303MyI84w3jEX3/YH04HKTcbV31FWEqAcUemuQ=;
        b=fm54Osml97098l6nBbeQplY2WTlkRbnxNbimfhZFdkVDXbcVEzqyEsvr3CFPtJh2Bs
         GLBgzbnd0A8pZRxb2LTP5nQFV8QQZpR9dD2o+sp78A0+aMTbKONdPXtPnyvh8M/HTKEr
         VndyoFeAJKodYJLX3iajV0poHD8pxoU1pwGo0hiAZJeSugRo/AdF8j/nSNvYsjddvHXv
         szgmu/sSGvI34dunwXpUYmKutIlws71Kx1LOd74PJXgIAkT70p/Sv6AnWOsmoQX26+XY
         qTuF8WFz6ll6nuq+gpPs/jHbbz9XJYV6Hfjfns0ojRmrEO9AShS8+G0saghVOtoEK7li
         BSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732768315; x=1733373115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQOBj303MyI84w3jEX3/YH04HKTcbV31FWEqAcUemuQ=;
        b=dhPq7fLhiCrosDP+/mXtCqoQiriB7qmSu4JuvlbYceIDS5TCcKa5Ncum/OiU8Ny/nF
         XG8acQHIUmkmNWhMq+DDxSYTErgmPCDnO52JeY5+CADYb26pkE0qiu3+MX2ljWIy0vCt
         jQDvF4URSX0Ii37B+FDZxekfUg8xZXTbfqVz1KV+uOe65cw7BqAghIb5AMn4mcZqC0d+
         FSnsj1gP0l5qWA+eXE4B8DTDiZv1MRih4xbcZCVuzDCpd1+g5ZdKoTp0o9gxlp7KnBjp
         NMmvPihSAo6/wpeeeBA9AgVYGKNmn7e/Az2g3sAHo3H/nDEzUGFbyliTlNEEdVRByZCL
         5rHw==
X-Forwarded-Encrypted: i=1; AJvYcCVXuJp72e2w/Of0eoZYgfy37D1Z7X31jYoNPZGOdbkKgx/CMAutJ8GDBsYPyERAdY3AFGx3Y3qI9R+RaGLQ@vger.kernel.org, AJvYcCVqjioEeFnIouybmRYjxHf70cwHzvKoOCHfwHdubmZ/HQumif83+laYlrsnN7udEgNtFPwOdZJKkOKnym15@vger.kernel.org
X-Gm-Message-State: AOJu0YwTDnL+Xh48a/JeWPpveyuo8DZCE6pUHAKHZUOrY1utgFt23oqL
	NbIu6VuPii9pBGagp2CCUQZzGrZhLEbYIi9KoRSEqvjTNBahFCid0mAeUSXT0aliBc5/Kn0kLmG
	/pIQSoIcOm5iytwNsIr19RgsFFK0=
X-Gm-Gg: ASbGncur4I5tQ0MEsGXNipwE/otJwLG0YIttGF8YQHepbMY5gpxUyZuO43H3SvA0l3G
	3r9akU80ZdETJsrDZPjckcmUnvNxaweE=
X-Google-Smtp-Source: AGHT+IF27rLYNUlhOO/6DrQbNpdU53t77/FyRdU+wOPQuy8q1Ub04s6i5Cycrua3W/Y7gxUbSkME97EYOwBEpXdg1aA=
X-Received: by 2002:a05:6871:a083:b0:297:28e3:db63 with SMTP id
 586e51a60fabf-29dc4181f75mr5143715fac.19.1732768315517; Wed, 27 Nov 2024
 20:31:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127054737.33351-1-bharata@amd.com> <CAGudoHGup2iLPUONz=ScsK1nQsBUHf_TrTrUcoStjvn3VoOr7Q@mail.gmail.com>
 <CAGudoHEvrML100XBTT=sBDud5L2zeQ3ja5BmBCL2TTYYoEC55A@mail.gmail.com>
 <3947869f-90d4-4912-a42f-197147fe64f0@amd.com> <CAGudoHEN-tOhBbdr5hymbLw3YK6OdaCSfsbOL6LjcQkNhR6_6A@mail.gmail.com>
 <5a517b3a-51b2-45d6-bea3-4a64b75dfd30@amd.com> <CAGudoHHBu663RSjQUwi14_d+Ln6mw_ESvYCc6dTec-O0Wi1-Eg@mail.gmail.com>
In-Reply-To: <CAGudoHHBu663RSjQUwi14_d+Ln6mw_ESvYCc6dTec-O0Wi1-Eg@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 28 Nov 2024 05:31:38 +0100
Message-ID: <CAGudoHHo4sLNpoVw-WTGVCc-gL0xguYWfUWfV1CSsQo6-bGnFg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Large folios in block buffered IO path
To: Bharata B Rao <bharata@amd.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, nikunj@amd.com, 
	willy@infradead.org, vbabka@suse.cz, david@redhat.com, 
	akpm@linux-foundation.org, yuzhao@google.com, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, joshdon@google.com, 
	clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 5:22=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Thu, Nov 28, 2024 at 5:02=E2=80=AFAM Bharata B Rao <bharata@amd.com> w=
rote:
> >
> > The contention with inode_lock is gone after your above changes. The ne=
w
> > top 10 contention data looks like this now:
> >
> >   contended   total wait     max wait     avg wait         type   calle=
r
> >
> > 2441494015    172.15 h       1.72 ms    253.83 us     spinlock
> > folio_wait_bit_common+0xd5
> >                          0xffffffffadbf60a3
> > native_queued_spin_lock_slowpath+0x1f3
> >                          0xffffffffadbf5d01  _raw_spin_lock_irq+0x51
> >                          0xffffffffacdd1905  folio_wait_bit_common+0xd5
> >                          0xffffffffacdd2d0a  filemap_get_pages+0x68a
> >                          0xffffffffacdd2e73  filemap_read+0x103
> >                          0xffffffffad1d67ba  blkdev_read_iter+0x6a
> >                          0xffffffffacf06937  vfs_read+0x297
> >                          0xffffffffacf07653  ksys_read+0x73
> >    25269947      1.58 h       1.72 ms    225.44 us     spinlock
> > folio_wake_bit+0x62
> >                          0xffffffffadbf60a3
> > native_queued_spin_lock_slowpath+0x1f3
> >                          0xffffffffadbf537c  _raw_spin_lock_irqsave+0x5=
c
> >                          0xffffffffacdcf322  folio_wake_bit+0x62
> >                          0xffffffffacdd2ca7  filemap_get_pages+0x627
> >                          0xffffffffacdd2e73  filemap_read+0x103
> >                          0xffffffffad1d67ba  blkdev_read_iter+0x6a
> >                          0xffffffffacf06937  vfs_read+0x297
> >                          0xffffffffacf07653  ksys_read+0x73
> >    44757761      1.05 h       1.55 ms     84.41 us     spinlock
> > folio_wake_bit+0x62
> >                          0xffffffffadbf60a3
> > native_queued_spin_lock_slowpath+0x1f3
> >                          0xffffffffadbf537c  _raw_spin_lock_irqsave+0x5=
c
> >                          0xffffffffacdcf322  folio_wake_bit+0x62
> >                          0xffffffffacdcf7bc  folio_end_read+0x2c
> >                          0xffffffffacf6d4cf  mpage_read_end_io+0x6f
> >                          0xffffffffad1d8abb  bio_endio+0x12b
> >                          0xffffffffad1f07bd  blk_mq_end_request_batch+0=
x12d
> >                          0xffffffffc05e4e9b  nvme_pci_complete_batch+0x=
bb
> [snip]
> > However a point of concern is that FIO bandwidth comes down drastically
> > after the change.
> >
>
> Nicely put :)
>
> >                 default                         inode_lock-fix
> > rw=3D30%
> > Instance 1      r=3D55.7GiB/s,w=3D23.9GiB/s         r=3D9616MiB/s,w=3D4=
121MiB/s
> > Instance 2      r=3D38.5GiB/s,w=3D16.5GiB/s         r=3D8482MiB/s,w=3D3=
635MiB/s
> > Instance 3      r=3D37.5GiB/s,w=3D16.1GiB/s         r=3D8609MiB/s,w=3D3=
690MiB/s
> > Instance 4      r=3D37.4GiB/s,w=3D16.0GiB/s         r=3D8486MiB/s,w=3D3=
637MiB/s
> >
>
> This means that the folio waiting stuff has poor scalability, but
> without digging into it I have no idea what can be done. The easy way
> out would be to speculatively spin before buggering off, but one would
> have to check what happens in real workloads -- presumably the lock
> owner can be off cpu for a long time (I presume there is no way to
> store the owner).
>
> The now-removed lock uses rwsems which behave better when contested
> and was pulling contention away from folios, artificially *helping*
> performance by having the folio bottleneck be exercised less.
>
> The right thing to do in the long run is still to whack the llseek
> lock acquire, but in the light of the above it can probably wait for
> better times.

WIlly mentioned the folio wait queue hash table could be grown, you
can find it in mm/filemap.c:
  1062 #define PAGE_WAIT_TABLE_BITS 8
  1063 #define PAGE_WAIT_TABLE_SIZE (1 << PAGE_WAIT_TABLE_BITS)
  1064 static wait_queue_head_t folio_wait_table[PAGE_WAIT_TABLE_SIZE]
__cacheline_aligned;
  1065
  1066 static wait_queue_head_t *folio_waitqueue(struct folio *folio)
  1067 {
  1068 =E2=94=82       return &folio_wait_table[hash_ptr(folio, PAGE_WAIT_T=
ABLE_BITS)];
  1069 }

Can you collect off cpu time? offcputime-bpfcc -K > /tmp/out

On debian this ships with the bpfcc-tools package.


--=20
Mateusz Guzik <mjguzik gmail.com>

