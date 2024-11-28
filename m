Return-Path: <linux-fsdevel+bounces-36043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 028069DB221
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 05:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5C0167C2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 04:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0468B13BACB;
	Thu, 28 Nov 2024 04:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNxm61Us"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78CE137742;
	Thu, 28 Nov 2024 04:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732767777; cv=none; b=iwwRi8YJU346CplgpcCd5Vm2p/vsmBHR6ZEbqZnfsuD2RLDB7ZC82N3Ilh2oS6smUn5xts5ftcC5SpkjrT+l1MyIOmpkCQYaNOi3jbkroO3bbarP2gEtGMxXR7igI+q7hXCc8W0owQ8exL26rcQZ4PQGNJciA8djdMnPc5MLLc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732767777; c=relaxed/simple;
	bh=KnAesF+QZCA/He8Aeek4BvyxlL4pMysNfgQlkaYm9vY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxGMDz7R+jER5KvX6Oq3rR/AVonA8aqtiikMgzglw7/fLI9Wm9hBodthF8UPLMSqfW5pgscBRWNdgxhoxd1hYwtqq/hGAw/iFEkMN/ehSeziWcwR+55OOcrS7MlxPhkAIc0Zbx7Eu4rG2NvjJoW+N/YDQ68otb2bGZ0r9675ya0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNxm61Us; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cedf5fe237so478547a12.3;
        Wed, 27 Nov 2024 20:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732767774; x=1733372574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ux7GUH7n8ejrcL8zDOd21JVXw9InCTifNch8P3hDOE=;
        b=NNxm61UsFiBiBkWkf/KeAlEocLoLn1cRgzgv4p+mYOGxkDLmDRyGhLDgzqbiucMFlJ
         ObpobzZkYk9g6UaQVHo+j7nOYeRSsD05LMJ3z961fDK0Z5n3ztSqDucu6yd3XGXzbnWG
         NXo+PqqNpHGeO7+mqYtNFpmluq8BxmrCTTpfU4fRyjpkHObcbTtt4c5kNuD1yKpwKKQH
         HvVxOa2OQMWS9gT4/mBCVAMbP2tCTr1MQ4kUXpjLcuMEwB0uPOZsMqq0wNhRdBqyXCRP
         HoDSch9Xxc98YTYbKjM7EARC64nLnvqVBoKnhWktmT/TpQDo2zJpqaFV69CmN100edtg
         2zUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732767774; x=1733372574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ux7GUH7n8ejrcL8zDOd21JVXw9InCTifNch8P3hDOE=;
        b=AFU3X0EaUIjM2kBB7cDTDpmLepH0nboTPWc1/jlD2DZ4KkAXcGuXgunOFe8Z0V3ubl
         33eEB2npZ5NKSNpmUKligzd1jt1PxiSiZGtvvCapDdgNeUqPw9tIVljdUGJ87fYTRVKT
         mfhjv9qyUE+gmhSrFzuAp89O8PXbG7ycbeMWZeqNAjrcR8Rw6ZfA2VU+E969+RGJHEp8
         TJwaeFdvPQejZHqVUBNH3IOCWtMUEekj/IBu+QIdnGv2nUOzE0QgyRGJwiqvNbBH5PEm
         FMShCdr5ExUal46mfvcYQQXpL4lroGkpaFfqewHGSgYlYSQq1KCJ000JSUUujmfAG12T
         bZQA==
X-Forwarded-Encrypted: i=1; AJvYcCV6DmcLH+ZVvmAcpDruZbvLBYQFsNwkKiqzdnA/C0EtxeMPA5m9ZOsCuUAetfiYyOTF3EOfd7CJxf2lImgY@vger.kernel.org, AJvYcCWGVOz398vEJRqRjOMXZVIPAB1YxnG4spT7Hb54H2PXK5KtNyXRWzdIyrDjAj5qs/mEIEOAGbkECp++qcGx@vger.kernel.org
X-Gm-Message-State: AOJu0Yz81MivVskhJ7ZC8Lqw20nupIO076oBt0TWXXP5OtxSNkJW1CQw
	nomti2q3zmcZBoDxUcvDOczmEysry6EULqi91SruT2JlrAmLASdaI1ofRKfuANnaqdOxEmMewdk
	DYph0XVQN53tq8EMhRZ4VnHm4aSY=
X-Gm-Gg: ASbGncsTguIJcUrkdH7nEheugHIUVdyf5RkFmSbqk6IpPRt6AE4aoFM9lCGCocit8eo
	d+a/NTi2fqy7drlUXC6s/VLNItAFFxj0=
X-Google-Smtp-Source: AGHT+IH2R1VLWEQk2u6NYseAiav0WBUws3NmAen1u9K8pxLydyfmlQ+GNF+VF71b4XAUvve4j/yUHoPAFV4BW2yNTtA=
X-Received: by 2002:a05:6402:3546:b0:5cf:e71c:ff8e with SMTP id
 4fb4d7f45d1cf-5d080b998b2mr4836167a12.12.1732767773809; Wed, 27 Nov 2024
 20:22:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127054737.33351-1-bharata@amd.com> <CAGudoHGup2iLPUONz=ScsK1nQsBUHf_TrTrUcoStjvn3VoOr7Q@mail.gmail.com>
 <CAGudoHEvrML100XBTT=sBDud5L2zeQ3ja5BmBCL2TTYYoEC55A@mail.gmail.com>
 <3947869f-90d4-4912-a42f-197147fe64f0@amd.com> <CAGudoHEN-tOhBbdr5hymbLw3YK6OdaCSfsbOL6LjcQkNhR6_6A@mail.gmail.com>
 <5a517b3a-51b2-45d6-bea3-4a64b75dfd30@amd.com>
In-Reply-To: <5a517b3a-51b2-45d6-bea3-4a64b75dfd30@amd.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 28 Nov 2024 05:22:41 +0100
Message-ID: <CAGudoHHBu663RSjQUwi14_d+Ln6mw_ESvYCc6dTec-O0Wi1-Eg@mail.gmail.com>
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

On Thu, Nov 28, 2024 at 5:02=E2=80=AFAM Bharata B Rao <bharata@amd.com> wro=
te:
>
> The contention with inode_lock is gone after your above changes. The new
> top 10 contention data looks like this now:
>
>   contended   total wait     max wait     avg wait         type   caller
>
> 2441494015    172.15 h       1.72 ms    253.83 us     spinlock
> folio_wait_bit_common+0xd5
>                          0xffffffffadbf60a3
> native_queued_spin_lock_slowpath+0x1f3
>                          0xffffffffadbf5d01  _raw_spin_lock_irq+0x51
>                          0xffffffffacdd1905  folio_wait_bit_common+0xd5
>                          0xffffffffacdd2d0a  filemap_get_pages+0x68a
>                          0xffffffffacdd2e73  filemap_read+0x103
>                          0xffffffffad1d67ba  blkdev_read_iter+0x6a
>                          0xffffffffacf06937  vfs_read+0x297
>                          0xffffffffacf07653  ksys_read+0x73
>    25269947      1.58 h       1.72 ms    225.44 us     spinlock
> folio_wake_bit+0x62
>                          0xffffffffadbf60a3
> native_queued_spin_lock_slowpath+0x1f3
>                          0xffffffffadbf537c  _raw_spin_lock_irqsave+0x5c
>                          0xffffffffacdcf322  folio_wake_bit+0x62
>                          0xffffffffacdd2ca7  filemap_get_pages+0x627
>                          0xffffffffacdd2e73  filemap_read+0x103
>                          0xffffffffad1d67ba  blkdev_read_iter+0x6a
>                          0xffffffffacf06937  vfs_read+0x297
>                          0xffffffffacf07653  ksys_read+0x73
>    44757761      1.05 h       1.55 ms     84.41 us     spinlock
> folio_wake_bit+0x62
>                          0xffffffffadbf60a3
> native_queued_spin_lock_slowpath+0x1f3
>                          0xffffffffadbf537c  _raw_spin_lock_irqsave+0x5c
>                          0xffffffffacdcf322  folio_wake_bit+0x62
>                          0xffffffffacdcf7bc  folio_end_read+0x2c
>                          0xffffffffacf6d4cf  mpage_read_end_io+0x6f
>                          0xffffffffad1d8abb  bio_endio+0x12b
>                          0xffffffffad1f07bd  blk_mq_end_request_batch+0x1=
2d
>                          0xffffffffc05e4e9b  nvme_pci_complete_batch+0xbb
[snip]
> However a point of concern is that FIO bandwidth comes down drastically
> after the change.
>

Nicely put :)

>                 default                         inode_lock-fix
> rw=3D30%
> Instance 1      r=3D55.7GiB/s,w=3D23.9GiB/s         r=3D9616MiB/s,w=3D412=
1MiB/s
> Instance 2      r=3D38.5GiB/s,w=3D16.5GiB/s         r=3D8482MiB/s,w=3D363=
5MiB/s
> Instance 3      r=3D37.5GiB/s,w=3D16.1GiB/s         r=3D8609MiB/s,w=3D369=
0MiB/s
> Instance 4      r=3D37.4GiB/s,w=3D16.0GiB/s         r=3D8486MiB/s,w=3D363=
7MiB/s
>

This means that the folio waiting stuff has poor scalability, but
without digging into it I have no idea what can be done. The easy way
out would be to speculatively spin before buggering off, but one would
have to check what happens in real workloads -- presumably the lock
owner can be off cpu for a long time (I presume there is no way to
store the owner).

The now-removed lock uses rwsems which behave better when contested
and was pulling contention away from folios, artificially *helping*
performance by having the folio bottleneck be exercised less.

The right thing to do in the long run is still to whack the llseek
lock acquire, but in the light of the above it can probably wait for
better times.
--=20
Mateusz Guzik <mjguzik gmail.com>

