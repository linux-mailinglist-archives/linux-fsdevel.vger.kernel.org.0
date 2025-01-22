Return-Path: <linux-fsdevel+bounces-39882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B1AA19B6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 00:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3E877A4649
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 23:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6861CAA67;
	Wed, 22 Jan 2025 23:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJxl+wQW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15FE1C3C1A
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 23:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737588201; cv=none; b=SvrbDHT2v926MF6fdwv4rx/FBoWtIurwc4Xq/8tl+Md+ThU/M7pNVXAGNf/eO83niRXQ5k+A8jPx7EkC6Oe46c9hxMhab69RtOWnGt4BVFhMBcXIaPJ0QkDhF17J1X/HkTtZbqtN9J+e+Xx5VqX0h120Q5H8zcHeL5Sv5Z90ovg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737588201; c=relaxed/simple;
	bh=s1alVnADfkMQnLzTZVHUk1KP0xKaA4nfPAReSGPPbXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trQw7mLfWtTiN+z0LkyymZolPHmMpjQ4NSHW0XGIxDDbF6gIF5bmXEO9FC28VbI49k4Yuv+KVQGtvpQWeR1z1zM2o2re56fksm9Vq/5Y3wkIdSa259QLYezWvS7brYLMZM4cLFxOyV/WgxOXcsQrDqLopzNWqKdCuWFZw+5vxLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJxl+wQW; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6dce7263beaso3763926d6.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 15:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737588199; x=1738192999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ys/e6UxQtsLFgLg7ZJ5CA6/h091ZID30tEusgU/NGd8=;
        b=QJxl+wQW/I7yNFaj808OcvBTZJ7wc05KwEqScKEdhPrlz5vBe6adtRTqrOFWw60oI0
         zwQes1Cs9+rTkJOlwGa+EfZLMVQkOh46+AHtusmsqZWwXRwVxD9y6qNRBcjV21bJfoFt
         iGp04Fyw/derTx3rJDHw/1otexOn8igERwWT8wKo5Ji2XONh6fIT7vQu74ZbXg3yCSmz
         FWRgfTJh0WtvimSZdvOXuhqqpLMZpZuDyOyhwgt75MYbLWCUpXAIhGnDrwWFiFcrQ/0V
         nUOhToSYKVtRUlUDZMeWOQ1ozO15fbseynbaPuO1IzjmtCZjXKJZm0SWc2mGknUuSqtT
         kknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737588199; x=1738192999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ys/e6UxQtsLFgLg7ZJ5CA6/h091ZID30tEusgU/NGd8=;
        b=ooeAEbY23EFRf6LMZa2A2FevQH/a5RHQw+KIGlLaKaKji5AlhBotc9L/RyNXkJMJvo
         xbDxCesU3TUYCQVl4MmckMmtWY9Q64hanY3KRuJ21UBTZQQdhD63m6Oj3QmEypY4MzG8
         r4scPcIEP8JT6d7wP2A7vRyhTMniw7hUoN0oiYGM4zQaVJar0TNwIus08tOUSB2KVLfs
         zlNthyGLiujfHY0ia6zupXutEaJbD/2ayTt0/if8jpbGwLMH/E+InqRwffP+UrYQ3n3d
         vGXM/RFgDTgeQYfeOeE+eZuDo02cbKyedWK0+gtDn46fuC425hYb5ucNNEDs8QNZHcsD
         ANlg==
X-Forwarded-Encrypted: i=1; AJvYcCVY+G4d3y/NokAKLK0k0xpjwl3uapvs6eO2qOInDJyX4FxMczF+nanY8Yi4AVcO1O56G901xAewS+4Aq5OF@vger.kernel.org
X-Gm-Message-State: AOJu0YyXa6dNG+N0w3pHbymH+SH8LCzS3U6ZVt36CGD0OccK6TMxwGl5
	Fz/g1YgGDwMH9ystJ9iM5KE9Lb2WOu2FFS8rqHC8OX45ZA/nIRLGcZch4okuyyHawUp8EHJiT/Y
	ZwUyMkJhRLBhcXsEkPldS/D6KBJLaHmzUbc4=
X-Gm-Gg: ASbGncsLp8bKbaCut7AMZUaAYWTdQ0qG/uUYwMgTOojuRqC5ByabjErOw+1bUC4ZZwH
	U8SCs6D1Rlohc51io/zJLgXUPU8qLxWrKH4Szr8ZegVK6vodTIxJH
X-Google-Smtp-Source: AGHT+IElM7qy8SvFjVn5ndUeHH1XPe3+f3dTF/lI7J023JvBdpbhgyRIxxZO831GG8wLor3khirT4MwDqnEHAhh8iLs=
X-Received: by 2002:a05:6214:5349:b0:6d4:2910:7f13 with SMTP id
 6a1803df08f44-6e1b2213dd2mr396406936d6.32.1737588198649; Wed, 22 Jan 2025
 15:23:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213221818.322371-1-joannelkoong@gmail.com>
In-Reply-To: <20241213221818.322371-1-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 22 Jan 2025 15:23:08 -0800
X-Gm-Features: AbW1kvb2BRX8ODQ2Y78eMaBI88k08TxUto3L5fr58fe7mMkCGGb8DNb2O033HG0
Message-ID: <CAJnrk1a8fP7JQRWNhq7uvM=k=RbKrW+V9bOj1CQo=v4ZoNGQ3w@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] fuse: support large folios
To: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, bernd.schubert@fastmail.fm, willy@infradead.org, 
	jefflexu@linux.alibaba.com, shakeel.butt@linux.dev, jlayton@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 2:23=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> This patchset adds support for folios larger than one page size in FUSE.
>
> This patchset is rebased on top of the (unmerged) patchset that removes t=
emp
> folios in writeback [1]. This patchset was tested by running it through f=
stests
> on passthrough_hp.
>
> Please note that writes are still effectively one page size. Larger write=
s can
> be enabled by setting the order on the fgp flag passed in to __filemap_ge=
t_folio()
> but benchmarks show this significantly degrades performance. More investi=
gation
> needs to be done into this. As such, buffered writes will be optimized in=
 a
> future patchset.
>
> Benchmarks show roughly a ~45% improvement in read throughput.
>
> Benchmark setup:
>
> -- Set up server --
>  ./libfuse/build/example/passthrough_hp --bypass-rw=3D1 ~/libfuse
> ~/mounts/fuse/ --nopassthrough
> (using libfuse patched with https://github.com/libfuse/libfuse/pull/807)
>
> -- Run fio --
>  fio --name=3Dread --ioengine=3Dsync --rw=3Dread --bs=3D1M --size=3D1G
> --numjobs=3D2 --ramp_time=3D30 --group_reporting=3D1
> --directory=3Dmounts/fuse/
>
> Machine 1:
>     No large folios:     ~4400 MiB/s
>     Large folios:        ~7100 MiB/s
>
> Machine 2:
>     No large folios:     ~3700 MiB/s
>     Large folios:        ~6400 MiB/s
>
>
> [1] https://lore.kernel.org/linux-fsdevel/20241122232359.429647-1-joannel=
koong@gmail.com/
>

A couple of updates on this:
* I'm going to remove the writeback patch (patch 11/12) in this series
and resubmit, and leave large folios writeback to be done as a
separate future patchset. Getting writeback to work with large folios
has a dependency on [1], which unfortunately does not look like it'll
be resolved anytime soon. If we cannot remove tmp pages, then we'll
likely need to use a different data structure than the rb tree to
account for large folios w/ tmp pages. I believe we can still enable
large folios overall even without large folios writeback, as even with
the inode->i_mapping set to a large folio order range, writeback will
still only operate on 4k folios until fgf_set_order() is explicitly
set in fuse_write_begin() for the __filemap_get_folio() call.

* There's a discussion here [2] about perf degradation for writeback
writes on large folios due to writeback throttling when balancing
dirty pages. This is due to fuse enabling bdi strictlimit. More
experimentation will be needed to figure out what a good folio order
is, and whether it's possible to do something like remove the
strictlimit for privileged servers.

* Writeback on FUSE will need support for more granular dirty
tracking, so that we don't have to write back the entire large folio
if only a few pages in it are dirtied. I'm planning to take a look at
iomap and netfs and see if maybe FUSE can hook into that for it.


Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20241122232359.429647-1-joannelko=
ong@gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/CAJnrk1a38pv3OgFZRfdTiDMXuPWuBgN8=
KY47XfOsYHj=3DN2wxAg@mail.gmail.com/

> Changelog:
> v2: https://lore.kernel.org/linux-fsdevel/20241125220537.3663725-1-joanne=
lkoong@gmail.com/
> v2 -> v3:
> * Fix direct io parsing to check each extracted page instead of assuming =
all
>   pages in a large folio will be used (Matthew)
>
> v1: https://lore.kernel.org/linux-fsdevel/20241109001258.2216604-1-joanne=
lkoong@gmail.com/
> v1 -> v2:
> * Change naming from "non-writeback write" to "writethrough write"
> * Fix deadlock for writethrough writes by calling fault_in_iov_iter_reada=
ble()
> * first
>   before __filemap_get_folio() (Josef)
> * For readahead, retain original folio_size() for descs.length (Josef)
> * Use folio_zero_range() api in fuse_copy_folio() (Josef)
> * Add Josef's reviewed-bys
>
> Joanne Koong (12):
>   fuse: support copying large folios
>   fuse: support large folios for retrieves
>   fuse: refactor fuse_fill_write_pages()
>   fuse: support large folios for writethrough writes
>   fuse: support large folios for folio reads
>   fuse: support large folios for symlinks
>   fuse: support large folios for stores
>   fuse: support large folios for queued writes
>   fuse: support large folios for readahead
>   fuse: optimize direct io large folios processing
>   fuse: support large folios for writeback
>   fuse: enable large folios
>
>  fs/fuse/dev.c  | 128 ++++++++++++++++++++++---------------------
>  fs/fuse/dir.c  |   8 +--
>  fs/fuse/file.c | 144 +++++++++++++++++++++++++++++++++----------------
>  3 files changed, 166 insertions(+), 114 deletions(-)
>
> --
> 2.43.5
>

