Return-Path: <linux-fsdevel+bounces-39442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BCAA142DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 21:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91E1B18841F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 20:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B6222DF8A;
	Thu, 16 Jan 2025 20:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGp1dLmi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510CF81727
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 20:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058503; cv=none; b=IBn1Psm7SuCdlM6/y1AOmPEjuZqXrHYU8xB/upCsFNV9K0HBqJVZk6rUS4vwUtfFjQg9l+E89mmk4PF9KBgRN/1qUpOAwp791yoBv4sMg94ucHe4ohAeM9+gkg2S6HrpR/PeacqjeKmUJ3gMs72MR78D/frVKKUMAQnUCA5G+kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058503; c=relaxed/simple;
	bh=//4ODmcKDWahdZyGwFv3QCAHNPbLRuGH8AVI9vujlf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T6KUqbB1qippW30dcGZrYRsLgyYxbXAlmGEYllXH9ERQ8TaarE1xL5lA5RnnCdRK9XBsnS65NVHgFNRF0jqVdBGPv4wB/i5ZI5UhlpvLlCQDpPQoRNQFwz5s/IMxa7J45uQ9qCY5ibKK4teHnGfgrbIYZHqICdh4VuLTwL6btLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGp1dLmi; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-467918c360aso17038401cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 12:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737058500; x=1737663300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1u06/6NefMqF/hqn0Wz6QaN/ufqBA3YdyfxR4C0J6I=;
        b=YGp1dLmiI7uHI2KY9YnYLIEQCLOJlzqLhL2w4i9hOvLkXCsTgY+3ArrKs46oWlmqpu
         ARE1YqE1lWdIt+XPmPf05w2cIVBTbjs+Ye9Lf+Nz2Fj62kCNGYpGTSMBAzWxTdOdciy3
         ZfBy2PY/+nwN6VXA5qaLxh8sxfqGUSxA4mKHw3CV495QG7InqTRTz0A0WmMdCLpanKqj
         wBfGP+46w1ZBFzpTIn8tMD9+GPo4W84FMOVwhcBb3HzvUYAciC7gMaJERFeRbFPOO54u
         56kCIO6aZfG4D/qHPVOUAN83/fUW1yEuhVA/TC/ZDCiz2kCltcqy9xpZ/w59+IAOLw+9
         fL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737058500; x=1737663300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1u06/6NefMqF/hqn0Wz6QaN/ufqBA3YdyfxR4C0J6I=;
        b=wktiaqGlr/wKBjWotdG8C1jIrZfB0odamSTF4dvt85HOgj/evKeGXJYt3rz52pEo25
         /lT+R3jLqNwoYfXgBS1NIVVDvprLvcG3ntd9uxunfQD3s4INN8WzOkYKU47OzNVUrYR7
         f0/7PMgFjph7vBfYQ1rMAJBcdyMUs4EFSpfgmjnAIr02VtmUVlk7lIsNvYN55CttGAmh
         1Q6k0i8leAT1l8AGFRG8vKUGyT2T4H83BvVbHT7cEgME5gy8AjtXWKqHLb5VnXWTqpab
         u0ooOQR1qK/0JS/NksRe+MYrN/bFaaiJsYBmoOgaTLsdZ17iOQu7wgP7EYMotLAsODE9
         bwlw==
X-Forwarded-Encrypted: i=1; AJvYcCUaGvPtdw8JlGQjiYYGOb2wq7zoWV7MQIGoo9dEQL3DlSxR+ZhQ1TY/qU2eudUgEWsTd41QCCnh6j81tWNW@vger.kernel.org
X-Gm-Message-State: AOJu0YzJfBu9ISWNYaamMQ/Pwa9dSn2zF9JobhMCL8FfhEA9b9gJ0dt2
	3+KrB71sHd/bs5zfiht895eT5RxNmh9e9GVqgo0esJKQDGlDq7l23ov8zYiedqaxAPxnnkpVTuQ
	aGTugT6wnMKDipgatlYcpTc5ytbM=
X-Gm-Gg: ASbGncvIjR6kIkd1o+XRGhRuVQRopzAXaJqHR3Yl9s7B22oDFutcFh3IaFJZT9xQq8y
	1q85unKPoNR5xeaMAK3lLBo2et6KQQ5u+7BzR2jM=
X-Google-Smtp-Source: AGHT+IHjN7cES20yV4cclSrrmnbaK0fqWc6ccM3AGykYSVlbj1C3MTT7UhPU4hSgR40r01TigrqnT/OclkyhNYbG2E0=
X-Received: by 2002:ac8:584e:0:b0:467:7295:b75f with SMTP id
 d75a77b69052e-46c71083e8amr587925221cf.38.1737058500158; Thu, 16 Jan 2025
 12:15:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJnrk1a38pv3OgFZRfdTiDMXuPWuBgN8KY47XfOsYHj=N2wxAg@mail.gmail.com>
 <Z4cNoWIWnC7XwCT8@dread.disaster.area>
In-Reply-To: <Z4cNoWIWnC7XwCT8@dread.disaster.area>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 16 Jan 2025 12:14:49 -0800
X-Gm-Features: AbW1kvaRsQV9SGQM08TpPYtrvLDidDlX3gTwCZe3t_AMuuLA74Dez_9XFzMQ_8A
Message-ID: <CAJnrk1aqHbR5j4VVU0RkuZfpBT7CTN3V71Cu4m95KHAdDZeZ1g@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Improving large folio writeback performance
To: Dave Chinner <david@fromorbit.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 5:21=E2=80=AFPM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Tue, Jan 14, 2025 at 04:50:53PM -0800, Joanne Koong wrote:
> > Hi all,
> >
> > I would like to propose a discussion topic about improving large folio
> > writeback performance. As more filesystems adopt large folios, it
> > becomes increasingly important that writeback is made to be as
> > performant as possible. There are two areas I'd like to discuss:
> >
> >
> > =3D=3D Granularity of dirty pages writeback =3D=3D
> > Currently, the granularity of writeback is at the folio level. If one
> > byte in a folio is dirty, the entire folio will be written back. This
> > becomes unscalable for larger folios and significantly degrades
> > performance, especially for workloads that employ random writes.
>
> This sounds familiar, probably because we fixed this exact issue in
> the iomap infrastructure some while ago.
>
> commit 4ce02c67972211be488408c275c8fbf19faf29b3
> Author: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Date:   Mon Jul 10 14:12:43 2023 -0700
>
>     iomap: Add per-block dirty state tracking to improve performance
>
>     When filesystem blocksize is less than folio size (either with
>     mapping_large_folio_support() or with blocksize < pagesize) and when =
the
>     folio is uptodate in pagecache, then even a byte write can cause
>     an entire folio to be written to disk during writeback. This happens
>     because we currently don't have a mechanism to track per-block dirty
>     state within struct iomap_folio_state. We currently only track uptoda=
te
>     state.
>
>     This patch implements support for tracking per-block dirty state in
>     iomap_folio_state->state bitmap. This should help improve the filesys=
tem
>     write performance and help reduce write amplification.
>
>     Performance testing of below fio workload reveals ~16x performance
>     improvement using nvme with XFS (4k blocksize) on Power (64K pagesize=
)
>     FIO reported write bw scores improved from around ~28 MBps to ~452 MB=
ps.
>
>     1. <test_randwrite.fio>
>     [global]
>             ioengine=3Dpsync
>             rw=3Drandwrite
>             overwrite=3D1
>             pre_read=3D1
>             direct=3D0
>             bs=3D4k
>             size=3D1G
>             dir=3D./
>             numjobs=3D8
>             fdatasync=3D1
>             runtime=3D60
>             iodepth=3D64
>             group_reporting=3D1
>
>     [fio-run]
>
>     2. Also our internal performance team reported that this patch improv=
es
>        their database workload performance by around ~83% (with XFS on Po=
wer)
>
>     Reported-by: Aravinda Herle <araherle@in.ibm.com>
>     Reported-by: Brian Foster <bfoster@redhat.com>
>     Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>     Reviewed-by: Darrick J. Wong <djwong@kernel.org>
>
>
> > One idea is to track dirty pages at a smaller granularity using a
> > 64-bit bitmap stored inside the folio struct where each bit tracks a
> > smaller chunk of pages (eg for 2 MB folios, each bit would track 32k
> > pages), and only write back dirty chunks rather than the entire folio.
>
> Have a look at how sub-folio state is tracked via the
> folio->iomap_folio_state->state{} bitmaps.
>
> Essentially it is up to the subsystem to track sub-folio state if
> they require it; there is some generic filesystem infrastructure
> support already in place (like iomap), but if that doesn't fit a
> filesystem then it will need to provide it's own dirty/uptodate
> tracking....

Great, thanks for the info. I'll take a look at how the iomap layer does th=
is.

>
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com

