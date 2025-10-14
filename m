Return-Path: <linux-fsdevel+bounces-64098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 016EBBD8404
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 10:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71B5F4FAF50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 08:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7781530FF36;
	Tue, 14 Oct 2025 08:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yc1pSKep"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1474C30F95D
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 08:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431411; cv=none; b=uzVrXcN7MZJziU01cc6k1ymMKd9oyeUXdbyA3XREnKPvTP7EKS9gASs2jwlft6ZI0oCby6KcADM6UPMQSv4W1yYD0yOnbklhWlefKN4rnJIUL6bUDGzqHRcaHVqvwxzyjnkfQsQYkLSIiqb0RoFHiDa5bqDC9j8FthyEkkOszsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431411; c=relaxed/simple;
	bh=bTMHxBb+5YCedN6r5fvrLH6mNlb+3hO9ULFtaU//N+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBzHm7AJNGuNmbwEeXlrRWxS6gWB209QmGxNhGzqe2retbEbSp/ft+etY1w00tSD24wLNFCiFesAkVQZ9E1Wk1KWY1OjPGxY773e8r6In4BlAdXxm02UoLeSXx5GhAW3riQPXaT5zTF5Yrm8o3g5/jtMGfUhFdDqOMxAj57iH7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yc1pSKep; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3ee18913c0so819902666b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 01:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760431408; x=1761036208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSK3NkeD2NEuNOL5TTqE0ObiS0+vzDyCtYzALrqfk6E=;
        b=Yc1pSKep++8Q+EI5kByBZJ/DVSyMT1HBPk36u9CY/1oStoLVU3WTnZqOX4cy5GdUHN
         R93TLpk3xd6/eaIvt3ELq1cyCxrmqD5jTtIsZwlUxvwxu2glXF8O5kGDVPLk1TRxnt58
         l0c7UxXrmjvwq5CtKyrdqeC5Iky+8U1MKhP3No4nkDY/b19XWYVnnKvO19g/4aAL93zr
         oyzzY5u7qzZMbHZD6EYltRwDQ4y93Q2OJL2uuDNFGmTkCy+lz+fkSH3Wx6re24/VIKLr
         GP//HgxVM5IXnX8BPpNG+lx6cygqyu5/M71MSMdMnAjt5tNUqMPtEavn2MwF/rS9QtqY
         3Grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760431408; x=1761036208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSK3NkeD2NEuNOL5TTqE0ObiS0+vzDyCtYzALrqfk6E=;
        b=bTFjsEFMMjuN/pNpqxO8OyhDrh2pLNLXUQPC4UpYyj4+9he/zNNoov5QzcX8edTz1v
         LkdVQ5tLT25oiHhd6M9CRSbGCWW9I1rTOrBxXtZ8tzbnJiCiqcXin0pwkWNHeKlecxkU
         U6okzmxEKf/B919CSMIRp46EXypRrpkgytH/CsPF9i/mLHx8HNdDQYRKY/kQzMFj2yMC
         bT0dPCyQD32ruiKaJu/9Y4YJhPBIyzYRThb1kNBSGTSU8XDF1OIT1q51p8vPNoP0GGZX
         aBd65qtZdmi19VQLGq3IUwiRx8I3qtSLtfYZJEWBLal/t0PbQmGDejytsIFRuZtU0pyE
         5xlQ==
X-Forwarded-Encrypted: i=1; AJvYcCX97NA1e0Jh1qjbmGoqhtgKHSs45EYaYQcHw0dIvYrMyrk7CthaFPtx6rnLDY9dSqla9nEsgYW7vsHOvgSU@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3vRb6qdyosI5fxw7AurXssMJjPFX6VfWfznrIevZ4MGtvRaom
	ZGooOgKh8p6oxy+nWWmHpAq0TF8prUZdJJTTz02RSaIWEP3Am6hm8zl3xg7B//MqHDp5xAXrzlm
	Rvg+GKz5wMvrzyou+xPgUcfILmCLf7gc=
X-Gm-Gg: ASbGncsgFDHF94qX8YMYHKsJzQxlvBzQuGTrKbxn0yoKqfPZzH6/abZQJzx9TtTHbwj
	YZP9oXtvqX1rw4vdorQvJd+8QeS82wSx+qafdJnRn9XCYkvoFtZBPuvCfJb4W+Fwh/iZTVlBB/C
	dbrlTsr/Aq5/2OJST1vykmpfpCzLsDdX7OjnVlObp5bnnnH538DDyoU5B9RVq5zynyG0MJERutt
	EV33CqtbvAVyCYMLpB2ECCqhCQsOqlqVFY=
X-Google-Smtp-Source: AGHT+IEU99F/tET5BQpjTRxdIwcoWzkKLcdyY4xKK2M3J/d5m268qvD7qO1OR2jZ03tq1RVPPypmq77CV31jlipMVS8=
X-Received: by 2002:a17:907:da1:b0:b3a:e4b3:eeb9 with SMTP id
 a640c23a62f3a-b50abfcd075mr2581054866b.55.1760431408020; Tue, 14 Oct 2025
 01:43:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013-reduced-nr-ring-queues_3-v3-0-6d87c8aa31ae@ddn.com>
In-Reply-To: <20251013-reduced-nr-ring-queues_3-v3-0-6d87c8aa31ae@ddn.com>
From: Gang He <dchg2000@gmail.com>
Date: Tue, 14 Oct 2025 16:43:16 +0800
X-Gm-Features: AS18NWCTcVCV8Q4JYtCe3jYyhCWK1DHTXuDg0Jwlievxv16Xs9XecQmiF5C7vtg
Message-ID: <CAGmFzSdgfjfdAGNrzb224+t5+UPvUWz3t7iCuW7CvSxd199KdA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] fuse: {io-uring} Allow to reduce the number of
 queues and request distribution
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>, 
	linux-fsdevel@vger.kernel.org, Luis Henriques <luis@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bernd,

Thank for your optimization patches.
I applied these patches, for asynchronous IO(iodepth > 1), it looks
the patches can improve the performance as expected.
But, for synchronous IO(iodepth =3D1), it looks there is  a regression
problem here(performance drop).
Did you check the above regression issue?

Thanks
Gang

Bernd Schubert <bschubert@ddn.com> =E4=BA=8E2025=E5=B9=B410=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=BA=8C 01:10=E5=86=99=E9=81=93=EF=BC=9A
>
> This adds bitmaps that track which queues are registered and which queues
> do not have queued requests.
> These bitmaps are then used to map from request core to queue
> and also allow load distribution. NUMA affinity is handled and
> fuse client/server protocol does not need changes, all is handled
> in fuse client internally.
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
> Changes in v3:
> - removed FUSE_URING_QUEUE_THRESHOLD (Luis)
> - Fixed accidentaly early return of queue1 in fuse_uring_best_queue()
> - Fixed similar early return 'best_global'
> - Added sanity checks for cpu_to_node()
> - Removed retry loops in fuse_uring_best_queue() for code simplicity
> - Reduced local numa retries in fuse_uring_get_queue
> - Added 'FUSE_URING_REDUCED_Q' FUSE_INIT flag to inform userspace
>   about the possibility to reduced queues
> - Link to v2: https://lore.kernel.org/r/20251003-reduced-nr-ring-queues_3=
-v2-0-742ff1a8fc58@ddn.com
> - Removed wake-on-same cpu patch from this series,
>   it will be send out independently
> - Used READ_ONCE(queue->nr_reqs) as the value is updated (with a lock bei=
ng
>   hold) by other threads and possibly cpus.
>
> ---
> Bernd Schubert (6):
>       fuse: {io-uring} Add queue length counters
>       fuse: {io-uring} Rename ring->nr_queues to max_nr_queues
>       fuse: {io-uring} Use bitmaps to track registered queues
>       fuse: {io-uring} Distribute load among queues
>       fuse: {io-uring} Allow reduced number of ring queues
>       fuse: {io-uring} Queue background requests on a different core
>
>  fs/fuse/dev_uring.c       | 260 ++++++++++++++++++++++++++++++++++++----=
------
>  fs/fuse/dev_uring_i.h     |  14 ++-
>  fs/fuse/inode.c           |   2 +-
>  include/uapi/linux/fuse.h |   3 +
>  4 files changed, 224 insertions(+), 55 deletions(-)
> ---
> base-commit: ec714e371f22f716a04e6ecb2a24988c92b26911
> change-id: 20250722-reduced-nr-ring-queues_3-6acb79dad978
>
> Best regards,
> --
> Bernd Schubert <bschubert@ddn.com>
>

