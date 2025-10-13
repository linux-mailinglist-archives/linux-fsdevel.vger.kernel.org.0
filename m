Return-Path: <linux-fsdevel+bounces-63909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3E6BD17CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 07:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4B53BDEAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 05:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFC92DCBE6;
	Mon, 13 Oct 2025 05:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+I7ZrtE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F25B2DC770
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 05:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760334272; cv=none; b=ebJQgNYHaNcFc/vHOjFsyS8Tj64jJGF/rsBuLlT+TfgIieYU91K1QJllOaHMgOlgfb1kqHsZtFk+RXyDpADi0L3ZQ8xFLkS5G8ITB95RY5SLA59rcJy/cNVyUYwt4+muH964IPBgfKH1AqusPoY+RMA0wfSeE/OxPZ4giRm9rv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760334272; c=relaxed/simple;
	bh=Vluz9ytPQeMtlO7P9ORKtagTdZgZUvCkj7WhJdLaLOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GdTEhYHU7TQVQUDjgK34Dlksr47bzwh379MUAX3EK+7uF6KLyJlXOASgpnAWOydpfCKAArUCQbX3bb9Yhik73lQS0mxMqVIhbSU8lxOz+iE3qowecv7tQ0484MYjkmYjlRDZ2wfAjEEWuH2DxECOqXZYP3oiAjCzznZUU7XVgDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+I7ZrtE; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5d40e0106b6so1932431137.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Oct 2025 22:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760334270; x=1760939070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfZ0cjDYVK5lhFzxXW1zOC477aQ4q/mTU1VD2TvA1nQ=;
        b=Y+I7ZrtEUyrbBVyxb/pwVHSPm/NUjdcUN7p2QIOR2Gc76JioaCNAHT0DpUo4aQJBuh
         6U3XRCAD4pT22cE0CZIrWjFoF94AIvPb3sECA4AIwObH5az4F4oBgbgRjAHJ04DUSgIN
         cgJWnI10SIM9wQD8DIf6C2A8ZivTesUbfjQGHDwE2Xta85NwyTJaH02gd6HZZnUc2Iqh
         /b9tlDquyWgeVVEOknwdr29PWPcBZODGzVtZOZKagmwsoSyx+ITO/MQ4LKrvzqej7/Nv
         t+me5XWphNc1k+F81d5qH4Z8A1bOgpxWdzw1oKqHAm1sQO0Uy4SnSje7hng2iB1YlAnS
         JpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760334270; x=1760939070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PfZ0cjDYVK5lhFzxXW1zOC477aQ4q/mTU1VD2TvA1nQ=;
        b=G6Ck3yMMuxgbG5qIQz3tLVXH9fLWAjaEX4DdXTNC9KYYdz5rBIecTke72+SEyCh9g8
         KSmH5YixKBga5owtl8r846Cha72HakJGa51ex+Zduoxa+2zhOm3fRsnTsRaS3fxj5VYM
         W1l4osZCbRVQaYM1u42guZDAtuI8KC4U4g4kcUFrnglVSKAphX5/fsu/TY20F97xKgsH
         wIJng8fVUmfVXBhMELD4rgvAMvVBtOooC6WoYU2ChJ0zPPiOpAxr8kJo9lKUXd9cmvCo
         cGd3RPNQBF9VXp9UBogqUJVWtJUalU3PDRDh91TqV/9DWo3bjteJBYD27kvpQ62lf7f3
         ZwRA==
X-Forwarded-Encrypted: i=1; AJvYcCVO3UofIXfRnTHXFGBd3OUmlrpAL7DpCfTkbvuFcqM/7UBe4r0QiIlJOCXRuR2kxdJPDe+nO0bweyz0JTqh@vger.kernel.org
X-Gm-Message-State: AOJu0YxJpnXalTavp9nfbJZyPH3HFW5R5Mi1424bOnahr/LAhMIsUd2l
	3kML1Ve+uboafKXnkxRkdjfZIL1T2ID3gjz/W89Y+epwLwYhvPqTDjz7zUGunupeH7QVYlv/pfu
	PQ+G+hpjwy0BsYc1svIPLEytI/ICsrWI=
X-Gm-Gg: ASbGncvSObTX4L45DxbPkt+RllWoGnJWqQlgbOGhclKGji0OGybi98sZjTTf7VsxNVM
	c+1NeGkCmX1fXqHHnurhUuESd3FLMlWLyWhugr9dvUckMK+fkPfIIvJAAgUDeX+GtybJ4BEZ+a3
	U64G8lmQRlLfBrcnEm4aEbFS/wVJZYYMtnGJ/sZYor9GdIDdDQKWBXnbCAYswGOjgKy3+0709bF
	nPVQAPop6GxRk7p16URvnXvD/s=
X-Google-Smtp-Source: AGHT+IHpSmXJAORlFvfBjiO5EpZknUsClCESfr6miv9ORXUHlNjIb1jckJtzwj7e3Gce86ucBxKeE0hLKTbq4g4SBL8=
X-Received: by 2002:a67:e009:0:10b0:5d5:f437:92d5 with SMTP id
 ada2fe7eead31-5d5f43792efmr3865770137.3.1760334270191; Sun, 12 Oct 2025
 22:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251011013312.20698-1-changfengnan@bytedance.com> <aOyLlFUNEKi2_vXT@fedora>
In-Reply-To: <aOyLlFUNEKi2_vXT@fedora>
From: fengnan chang <fengnanchang@gmail.com>
Date: Mon, 13 Oct 2025 13:44:19 +0800
X-Gm-Features: AS18NWD8kq6UQsDDGG0qKmrz3bfZhv6wKElSNkMZ019t6wf6DXrrEBmZE82HmfY
Message-ID: <CALWNXx_J5L1fjTrVA5ChXsPdGk5E5HSuNHUO183mVat6GZdo=g@mail.gmail.com>
Subject: Re: [PATCH] block: enable per-cpu bio cache by default
To: Ming Lei <ming.lei@redhat.com>
Cc: Fengnan Chang <changfengnan@bytedance.com>, axboe@kernel.dk, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, asml.silence@gmail.com, willy@infradead.org, 
	djwong@kernel.org, hch@infradead.org, ritesh.list@gmail.com, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 1:19=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Sat, Oct 11, 2025 at 09:33:12AM +0800, Fengnan Chang wrote:
> > Per cpu bio cache was only used in the io_uring + raw block device,
> > after commit 12e4e8c7ab59 ("io_uring/rw: enable bio caches for IRQ
> > rw"),  bio_put is safe for task and irq context, bio_alloc_bioset is
> > safe for task context and no one calls in irq context, so we can enable
> > per cpu bio cache by default.
> >
> > Benchmarked with t/io_uring and ext4+nvme:
> > taskset -c 6 /root/fio/t/io_uring  -p0 -d128 -b4096 -s1 -c1 -F1 -B1 -R1
> > -X1 -n1 -P1  /mnt/testfile
> > base IOPS is 562K, patch IOPS is 574K. The CPU usage of bio_alloc_biose=
t
> > decrease from 1.42% to 1.22%.
> >
> > The worst case is allocate bio in CPU A but free in CPU B, still use
> > t/io_uring and ext4+nvme:
> > base IOPS is 648K, patch IOPS is 647K.
>
> Just be curious, how do you run the remote bio free test? If the nvme is =
1:1
> mapping, you may not trigger it.

I modified the nvme driver, reduce the number of queues.

>
> BTW, ublk has this kind of remote bio free trouble, but not see IOPS drop
> with this patch.
>
> The patch itself looks fine for me.
>
>
> Thanks,
> Ming
>
>

