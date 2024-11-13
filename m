Return-Path: <linux-fsdevel+bounces-34693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 499D79C7BC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 19:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5D21F2231B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 18:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DB1204095;
	Wed, 13 Nov 2024 18:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PT1wn2Oa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1965202630
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 18:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731524296; cv=none; b=OYgu+B5w3LK3DvsALX3Yq3m9J2ar18IEo6REsMiH9ajw78I0jfUiZZwC1JOVIsHrTiyCKRO5RZc+N+f9zT5/jhsVf6N34jgs4Ct70tSssHnwrX5VMP5WfsW5Q9ZDlcqj+DHJOnYHOiZ7DPO9Zg9j2RRSb5bqGoKcDKunEllSuUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731524296; c=relaxed/simple;
	bh=YMHtNMy28iMH414UngK1yCbOpeC9ibRqcbcxjOmyZYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uTBnP0U//gdG8EqM7yrWqX5sDxh+LLnRRRtumAs2m4zD0/uDII+/rwLEWa9Q4zmxZsr73paTztJLer7SvuFUF6+FA/RWsvipp2iz+G+VtyVaNLtpsdQN33kZzXsT6IHzG5ORydC+mmcjz57UJwyd15AkVxvia3ZeeVCfbOZHiow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PT1wn2Oa; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4608e389407so91240521cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 10:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731524294; x=1732129094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxT/h0gfD5YmPGu+ijQfJ1yxx/zW+VdERa6eL5u2oBg=;
        b=PT1wn2OaGinZoBxEAKs2KHCXz++B6Q5S6nQYXGmSJeSTIwSM2TUvE/7ApEuYXs+inE
         KbsH25O86deO5BRsQEVvHEfQJlQqHdi1Lx1RiKa6D3K6WvltHWhZuFYqbhSv0c2CghBS
         4hBzqYnlbjLqJhbJd5KX3pSq9Wvk0JANII28e4OUqKL6/MzpDeRZScp1GYnVIvO7jLf+
         PDBAUrAsAo5vXp55H6l+wOFjudZUZFdAc2UcYNuVNVmOmY77t8WqOB1kX0Zo126SxX+k
         VdEX33FNBQ7MR1rT8+ZgXCQZnlEh3YWGorBjGuQeMwJgDFLpbao3Kw6mLPBvT2ZrYbeF
         G0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731524294; x=1732129094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxT/h0gfD5YmPGu+ijQfJ1yxx/zW+VdERa6eL5u2oBg=;
        b=f8DR8i76Xpx4QDrU6BXSB51uCjOWoNH199PU+/8IlLhWYQaGtlmyNsq0gkKv9QC3Oj
         +VY4g6mVD76wFqFVTBdhejy/Ya3gZu/v9R60grZ2OTT2MG6dUntrbVcDDakuBfnrlMgK
         OwwI2YYfLTFWRIdeDl62vJb9pRFVhbX12cZUQFugt5onuhIp7nGf+xXK1SdRB2zZ4+2N
         iBH0Q6EUswcFQiyZ+F/l1NR4uwJtU31KU03ELcsfVq9stmwKsBL4hWvKzl8z3jmt0ywK
         r/sB3OvmSyBoK7yOFT/JzQ49db1Esbg+K5Ub+j9Itt955KCWytqs1jIhn8b76Ngdhpuf
         aGsw==
X-Forwarded-Encrypted: i=1; AJvYcCUturEx4uEJLPCNe62q2ZRYpFh4J8YuK4y1FoUknRcxejImWfIPPJZKbGl0ZRJdWfGChjgCaw+U3hRITcUZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxPxkJs1l64PzOM9y5oonRQIs/b9A/BM2KT98CrlF7eAeQRcUF0
	oD995ACYQUGHg7xPnqUznW0ycMduIZgxz08YXunt9BjRTZWh8IDdiYuCLanPjw8xmnsw3BM6MbQ
	8dCIc48tCQooN7bVEunu3aCT0mFs=
X-Google-Smtp-Source: AGHT+IEwcm1brWUSJautJ2Xbjfeaz2S/ap38Z2Z84fbvFkA1JfBK6noUcXagz+WN09A6sJBH7OvFjm/m+9KGelLXIHw=
X-Received: by 2002:ac8:7d56:0:b0:461:22f0:4f83 with SMTP id
 d75a77b69052e-463093fe4ddmr262917001cf.43.1731524293547; Wed, 13 Nov 2024
 10:58:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109001258.2216604-1-joannelkoong@gmail.com> <CAJnrk1ZhK6kAvPzjnzZYFg7XyytBKR=6d4ED9=dTDVwuskosxg@mail.gmail.com>
In-Reply-To: <CAJnrk1ZhK6kAvPzjnzZYFg7XyytBKR=6d4ED9=dTDVwuskosxg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 13 Nov 2024 10:58:02 -0800
Message-ID: <CAJnrk1awYqMeRGG5x13tS2S4=PqurUa88yS=MAKwa6_LA6RzUQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] fuse: support large folios
To: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, bernd.schubert@fastmail.fm, 
	jefflexu@linux.alibaba.com, willy@infradead.org, shakeel.butt@linux.dev, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 4:22=E2=80=AFPM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> On Fri, Nov 8, 2024 at 4:13=E2=80=AFPM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
> >
> > This patchset adds support for folios larger than one page size in FUSE=
.
> >
> > This patchset is rebased on top of the (unmerged) patchset that removes=
 temp
> > folios in writeback [1]. (There is also a version of this patchset that=
 is
> > independent from that change, but that version has two additional patch=
es
> > needed to account for temp folios and temp folio copying, which may req=
uire
> > some debate to get the API right for as these two patches add generic
> > (non-FUSE) helpers. For simplicity's sake for now, I sent out this patc=
hset
> > version rebased on top of the patchset that removes temp pages)
> >
> > This patchset was tested by running it through fstests on passthrough_h=
p.
>
> Will be updating this thread with some fio benchmark results early next w=
eek.
>

For reads I'm seeing about a ~45% increase in throughput.

This is the setup I used:

-- Set up server --
 ./libfuse/build/example/passthrough_hp --bypass-rw=3D1 ~/libfuse
~/mounts/fuse/ --nopassthrough
(using libfuse patched with Bernd's passthrough_hp benchmark pr
https://github.com/libfuse/libfuse/pull/807)

-- Run fio --
 fio --name=3Dread --ioengine=3Dsync --rw=3Dread --bs=3D1M --size=3D1G
--numjobs=3D2 --ramp_time=3D30 --group_reporting=3D1
--directory=3Dmounts/fuse/

I tested on 2 machines and saw the following:
Machine 1:
    No large folios:     ~4400 MiB/s
    Large folios:         ~7100 MiB/s

Machine 2:
    No large folios:     ~3700 MiB/s
    Large folios:         ~6400 MiB/s

I also did see variability (on both ends) between runs and threw away outli=
ers.


For writes, we're still sending out one page folios (see thread on the
4th patch in this series [1]), so there is no difference. Benchmarks
showed that trying to get the largest folios possible from
__filemap_get_folio() is an over-optimization and ends up being
significantly more expensive. I think it'd probably be an improvement
if we set some reasonably sized order to the __filemap_get_folio()
call (order 2?), but that can be optimized in the future in another
patchset.

[1] https://lore.kernel.org/linux-fsdevel/CAJnrk1aPVwNmv2uxYLwtdwGqe=3DQURO=
UXmZc8BiLAV=3DuqrnCrrw@mail.gmail.com/

> >
> > [1] https://lore.kernel.org/linux-fsdevel/20241107235614.3637221-1-joan=
nelkoong@gmail.com/
> >
> > Joanne Koong (12):
> >   fuse: support copying large folios
> >   fuse: support large folios for retrieves
> >   fuse: refactor fuse_fill_write_pages()
> >   fuse: support large folios for non-writeback writes
> >   fuse: support large folios for folio reads
> >   fuse: support large folios for symlinks
> >   fuse: support large folios for stores
> >   fuse: support large folios for queued writes
> >   fuse: support large folios for readahead
> >   fuse: support large folios for direct io
> >   fuse: support large folios for writeback
> >   fuse: enable large folios
> >
> >  fs/fuse/dev.c  | 131 +++++++++++++++++++++++-----------------------
> >  fs/fuse/dir.c  |   8 +--
> >  fs/fuse/file.c | 138 +++++++++++++++++++++++++++++++------------------
> >  3 files changed, 159 insertions(+), 118 deletions(-)
> >
> > --
> > 2.43.5
> >

