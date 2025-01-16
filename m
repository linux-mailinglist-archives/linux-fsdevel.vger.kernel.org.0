Return-Path: <linux-fsdevel+bounces-39452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9E4A146BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 00:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE7E13A9410
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 23:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171B71F91FD;
	Thu, 16 Jan 2025 23:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPY+3Nsf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1E31F91FC
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 23:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737070748; cv=none; b=Zc5gB/G3BxUd8uiO3wWeAJiCUVNWL5g+NNvv0gMau5Xc+GcsT7aDO0dAUc5ieHQ5Qq0lE1hwK08djbj/EvZ6gBNDFgxWVc+VUNQlfPz7jGyRdcanigBKaudVr0o6lorxwct9kpU/LBJ75yVHXYzpF3bh9BMnCmWmywLbPEVhyHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737070748; c=relaxed/simple;
	bh=tsKmemnAdFOqfrIP4jD9MK+qP4Jilr3SGvphFEJUlik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGg1JQ35vNatt2CxVD6J8MutyzYInSumBty/hRasmkZWoLg89uHlLEUdEiCXHAaPDrCQZzR4VlNxY4JaC5c3cgIxbha8eePaxjv8P2G0fh/aFJy4ACl+VbzPOQWIsUe0aLcI1mA78Hm+l9N3pcngFSqPqC72WzCL2yDNIWJ2Td8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPY+3Nsf; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b6e9586b82so116506285a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 15:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737070746; x=1737675546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ec6gpDyMajGjFuPKgHZQpk6/0XcA5rkPf0cH8wY4yms=;
        b=FPY+3Nsfp24woficFpHbduq8gpf6rkOIugHupQG3hww3d77KDhjsC1ls3HvnYEfcWg
         vVFC8Vw1vdHdMegOG9dZqTUeZd6sVm4y2pZXnwd4WuIMN1LlOTmR8s+Iutc9DOGbEVrD
         c5iWc9R5F1bT6FDAhwEy0+PvUjidevy0VqNlI1hLCchYr/29jmQxEXjJtYsCSM1iDuMD
         DdAILp4rCRmZCocF86awaN3k1WPxRwD1lSKyWo+WbDpSSH7SuNw3hOid8+cmFyUZgKW0
         0BeThZ77N5b3ZWoPJQ50PT9kO6SBWeexc5jTNywzT+/mLbIJsmdVXqT36U/wL1gGm+Ky
         6H5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737070746; x=1737675546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ec6gpDyMajGjFuPKgHZQpk6/0XcA5rkPf0cH8wY4yms=;
        b=pnlaVE8taRUXAJPW+QeN2GZQSxDCC0zyPwBc2wO+wzRteQ/zEZ1/vsWY/5osX+2NRi
         TCKC9YqdO1celgjXYXv2W9SMYADRFeUIwT1qf3v91TfYVWvoQ+DWKoDDE4klpUcUDywm
         w7R535CWJc5cCU1UCWTp3LqCfZOxb43x/l/4FvqRrrsJ3h80Wm9lEhPF7xDkkdGy7sW1
         8kFAhIvdnZFaHp6/KyzY/LZfUh8UVIi1yV6oqNd14o9f+247n71FnzFnjAxMM8yJ8sxi
         vQGLOiYPY9LOZkk018BbUVNr//DHlXFQ8qe2KnhOFWIRLa59ZRc4K26vMmG2932KjaWa
         gFJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiSEt3QzvEmJwWJSMzrp9KBnzSR/vTfc4qSJZvdiHPcVqRFPaM99DKE0DfQvCVdALS68gQCchNQ3ONuU3o@vger.kernel.org
X-Gm-Message-State: AOJu0YwtcyGwLhzmsz3RJsdEnQXYS488U54f1bM+SPNWxl8YXG2w7d7R
	//1hifGOA0vil3VZAX+kQyXnQi/PWhOzzoh6aCrCsgT7Gq1pCa1X09GQp2lxzFpjmuZFrgDduqJ
	QzuF0L7ICI1nNAnzmu7IxmK/WObOLm4R0WQA=
X-Gm-Gg: ASbGncvbf/80Jted7e8c8rFoEw1I9DliXETqOamSB+o+yPWKuDxJUcbnysICzbEgEsw
	KUb+yy2Hy4TENvYnkezBJSDQqwHrCCXLcT+tIDv8=
X-Google-Smtp-Source: AGHT+IEWFtMz2nZaQqlnyGV8W5jcAdcLz5ror57ZakuJPBarcMznbOgwAycJE73Q4N7/o0wFqbjpis4Zt5U2ZPJU8To=
X-Received: by 2002:a05:620a:2485:b0:7b6:d435:ccf7 with SMTP id
 af79cd13be357-7be6328903amr156470285a.50.1737070745620; Thu, 16 Jan 2025
 15:39:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJnrk1a38pv3OgFZRfdTiDMXuPWuBgN8KY47XfOsYHj=N2wxAg@mail.gmail.com>
 <whipjvd65hrc7e5b5qsoj3la556s6dt6ckokn25qmciedmiwqa@rsitf37ibyjw>
In-Reply-To: <whipjvd65hrc7e5b5qsoj3la556s6dt6ckokn25qmciedmiwqa@rsitf37ibyjw>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 16 Jan 2025 15:38:54 -0800
X-Gm-Features: AbW1kvZvnpMlLJqTdGWsmX8nxNgsEexSx9HfrAfmc--5BYIHMDIaqcbuSZnDF00
Message-ID: <CAJnrk1aZYpGe+x3=Fz0W30FfXB9RADutDpp+4DeuoBSVHp9XHA@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Improving large folio writeback performance
To: Jan Kara <jack@suse.cz>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 3:01=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
>
> Hello!
>
> On Tue 14-01-25 16:50:53, Joanne Koong wrote:
> > I would like to propose a discussion topic about improving large folio
> > writeback performance. As more filesystems adopt large folios, it
> > becomes increasingly important that writeback is made to be as
> > performant as possible. There are two areas I'd like to discuss:
> >
> > =3D=3D Granularity of dirty pages writeback =3D=3D
> > Currently, the granularity of writeback is at the folio level. If one
> > byte in a folio is dirty, the entire folio will be written back. This
> > becomes unscalable for larger folios and significantly degrades
> > performance, especially for workloads that employ random writes.
> >
> > One idea is to track dirty pages at a smaller granularity using a
> > 64-bit bitmap stored inside the folio struct where each bit tracks a
> > smaller chunk of pages (eg for 2 MB folios, each bit would track 32k
> > pages), and only write back dirty chunks rather than the entire folio.
>
> Yes, this is known problem and as Dave pointed out, currently it is upto
> the lower layer to handle finer grained dirtiness handling. You can take
> inspiration in the iomap layer that already does this, or you can convert
> your filesystem to use iomap (preferred way).
>
> > =3D=3D Balancing dirty pages =3D=3D
> > It was observed that the dirty page balancing logic used in
> > balance_dirty_pages() fails to scale for large folios [1]. For
> > example, fuse saw around a 125% drop in throughput for writes when
> > using large folios vs small folios on 1MB block sizes, which was
> > attributed to scheduled io waits in the dirty page balancing logic. In
> > generic_perform_write(), dirty pages are balanced after every write to
> > the page cache by the filesystem. With large folios, each write
> > dirties a larger number of pages which can grossly exceed the
> > ratelimit, whereas with small folios each write is one page and so
> > pages are balanced more incrementally and adheres more closely to the
> > ratelimit. In order to accomodate large folios, likely the logic in
> > balancing dirty pages needs to be reworked.
>
> I think there are several separate issues here. One is that
> folio_account_dirtied() will consider the whole folio as needing writebac=
k
> which is not necessarily the case (as e.g. iomap will writeback only dirt=
y
> blocks in it). This was OKish when pages were 4k and you were using 1k
> blocks (which was uncommon configuration anyway, usually you had 4k block
> size), it starts to hurt a lot with 2M folios so we might need to find a
> way how to propagate the information about really dirty bits into writeba=
ck
> accounting.

Agreed. The only workable solution I see is to have some sort of api
similar to filemap_dirty_folio() that takes in the number of pages
dirtied as an arg, but maybe there's a better solution.

>
> Another problem *may* be that fast increments to dirtied pages (as we dir=
ty
> 512 pages at once instead of 16 we did in the past) cause over-reaction i=
n
> the dirtiness balancing logic and we throttle the task too much. The
> heuristics there try to find the right amount of time to block a task so
> that dirtying speed matches the writeback speed and it's plausible that
> the large increments make this logic oscilate between two extremes leadin=
g
> to suboptimal throughput. Also, since this was observed with FUSE, I beli=
ve
> a significant factor is that FUSE enables "strictlimit" feature of the BD=
I
> which makes dirty throttling more aggressive (generally the amount of
> allowed dirty pages is lower). Anyway, these are mostly speculations from
> my end. This needs more data to decide what exactly (if anything) needs
> tweaking in the dirty throttling logic.
>

I tested this experimentally and you're right, on FUSE this is
impacted a lot by the "strictlimit". I didn't see any bottlenecks when
strictlimit wasn't enabled on FUSE. AFAICT, the strictlimit affects
the dirty throttle control freerun flag (which gets used to determine
whether throttling can be skipped) in the balance_dirty_pages() logic.
For FUSE, we can't turn off strictlimit for unprivileged servers, but
maybe we can make the throttling check more permissive by upping the
value of the min_pause calculation in wb_min_pause() for writes that
support large folios? As of right now, the current logic makes writing
large folios unfeasible in FUSE (estimates show around a 75% drop in
throughput).


Thanks,
Joanne


>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

