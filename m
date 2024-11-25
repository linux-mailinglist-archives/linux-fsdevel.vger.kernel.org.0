Return-Path: <linux-fsdevel+bounces-35835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 891DB9D89D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 16:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4881B4684E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A591B21B7;
	Mon, 25 Nov 2024 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JZpFYDpv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EB11AF0DB
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732547165; cv=none; b=JaRjCj1kujs+kQZuob9z+0t9PX7xSJpxlEDEvWlT/N0N1uPXqz8k7QScgdIJD8biFp1llVpaQo2J32QmGkwZ8ddHCSxQ2/e4yqpeW1PKCZSJR3hePzpqZ9vs0NQ5iC2/kYQvVe9KGpoebcBRY9O4TIhfjXZpmFMVYY0BNOkr7jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732547165; c=relaxed/simple;
	bh=LxMztgNW0LfIP5/lVtd+yyO75BoseyhoayRS76gWIVU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=r6tktJgmP6c8T7ZVaChtGnJR3pkARtUhOJFOYFwpTRcEP3GgiQlUj+7utR9PSn706NzFr7BcDVVBSRbi2BF/nufffAF0cf281CBIrVT+cZED10vInSH8LgNWZGFmeDWyOIbVZXafUA49IHSGU2oDBnmV2Kmr5LEGzhVoo0LXt9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=JZpFYDpv; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-466897883dcso12416181cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 07:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1732547160; x=1733151960; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Odb6HwBqhVtcHxBeQOFJ5xJTqDGEvgjNBkYIdkylyWg=;
        b=JZpFYDpvlAAVhar2x21fKe3lZ3TQf8GCZNVsmj01Yt4E4N/PWUa1l+trdnodSxDHaG
         S3FanrbH3olK6AbR/uP/sH4JLKa9RdV9z/P5cJbnbODJG4WKAYFxnbKWx2JzXT3Mlxr0
         0NGNYjEDTzon4QGdg/2Q62Y/X7ISFqFNNVNyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732547160; x=1733151960;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Odb6HwBqhVtcHxBeQOFJ5xJTqDGEvgjNBkYIdkylyWg=;
        b=bPLmwYCrfsFJ30lVcSOHRkmmdtP1AzUlB88knejrTR/oITODtRVyd6dJQh2AFanB1P
         4C8jdBY2r0hldvo1EbJr3FENVL/loVfxQeVOQ2RHcvs5+vfPxjmuJJoKvIC7EvbLnPsz
         P4v6rNKh6IayVM9iuryAVgDYfBQSQTObUji6ngo+fjW4iXORJJpsICWdu+3Vjff8E9oP
         qN7BrkdQ44nMHdt8Ygbs9LCafmIgHBjPgNVF1iDF41mAYFHfND4E3ebYIKXyum0uOEU0
         qD4xY9QFCL7SSBfvbLpXJ+TU6ZPC4wFeTSd5qrwlyrSJfdVUHjZIiEcRBpnOXbkSbPFq
         rtIg==
X-Gm-Message-State: AOJu0YzRuLSZJO2fRBuuF3n0ec/Cu/cCmStwDAAfCN4g93GdTZMjNwHV
	cTvOyhtmhJM9KKGg62vHg6QMqLnJD58lDCUQA/swR1HGBD3SUWbfEwrwFqvXLCTKE8PsZwDJSIZ
	tnM2QyuBMGQgRk4qWZXX59666vpr62LDobQrMWm0hlt4vIcUk5Yo=
X-Gm-Gg: ASbGncuf1zDw7yZ6oSoPr6SLRNr/iTTVgAb4wmha1tBea03XKvF/2JpvfLPrRL9yurl
	zYbpfyWqW1+ABTEF1CjM4Wnz/ICHjdMkZEQ==
X-Google-Smtp-Source: AGHT+IGqI/9AP9tR1c34m3O1hWJP5tde7AZlFq0uo8d5BqgaPIdV+Ewn2Nb2TMQwz+/g+1aEM9UFoa/p7NSxI+zaQIA=
X-Received: by 2002:ac8:5d07:0:b0:458:4a68:7d15 with SMTP id
 d75a77b69052e-4653d627dfcmr176791061cf.44.1732547160336; Mon, 25 Nov 2024
 07:06:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 25 Nov 2024 16:05:49 +0100
Message-ID: <CAJfpegvCr7hBSqU8iqKUCZ3i5wUyiiyfbCtP_NO37OGMA2RVPw@mail.gmail.com>
Subject: [GIT PULL] fuse update for 6.13
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from:

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
tags/fuse-update-6.13

- Add page -> folio conversions (Joanne Koong, Josef Bacik)

- Allow max size of fuse requests to be configurable with a sysctl
(Joanne Koong)

- Allow FOPEN_DIRECT_IO to take advantage of async code path (yangyun)

- Fix large kernel reads (like a module load) in virtio_fs (Hou Tao)

- Fix attribute inconsistency in case readdirplus (and plain lookup in
corner cases) is racing with inode eviction (Zhang Tianci)

- Fix a WARN_ON triggered by virtio_fs (Asahi Lina)

Thanks,
Miklos
---

Asahi Lina (1):
      virtiofs: dax: remove ->writepages() callback

Hou Tao (2):
      virtiofs: use pages instead of pointer for kernel direct IO
      virtiofs: use GFP_NOFS when enqueuing request through kworker

Joanne Koong (14):
      fuse: enable dynamic configuration of fuse max pages limit
(FUSE_MAX_MAX_PAGES)
      fuse: support folios in struct fuse_args_pages and fuse_copy_pages()
      fuse: add support in virtio for requests using folios
      fuse: convert cuse to use folios
      fuse: convert readlink to use folios
      fuse: convert readdir to use folios
      fuse: convert reads to use folios
      fuse: convert writes (non-writeback) to use folios
      fuse: convert ioctls to use folios
      fuse: convert retrieves to use folios
      fuse: convert writebacks to use folios
      mm/writeback: add folio_mark_dirty_lock()
      fuse: convert direct io to use folios
      fuse: remove pages for requests and exclusively use folios

Josef Bacik (11):
      fuse: use fuse_range_is_writeback() instead of iterating pages
      fuse: convert readahead to use folios
      fuse: convert fuse_send_write_pages to use folios
      fuse: convert fuse_fill_write_pages to use folios
      fuse: convert fuse_page_mkwrite to use folios
      fuse: use kiocb_modified in buffered write path
      fuse: convert fuse_do_readpage to use folios
      fuse: convert fuse_writepage_need_send to take a folio
      fuse: use the folio based vmstat helpers
      fuse: convert fuse_retrieve to use folios
      fuse: convert fuse_notify_store to use folios

Zhang Tianci (1):
      fuse: check attributes staleness on fuse_iget()

yangyun (1):
      fuse: remove useless IOCB_DIRECT in fuse_direct_read/write_iter

---
 Documentation/admin-guide/sysctl/fs.rst |  10 +
 fs/fuse/Makefile                        |   1 +
 fs/fuse/cuse.c                          |  29 ++-
 fs/fuse/dax.c                           |  11 -
 fs/fuse/dev.c                           |  66 +++--
 fs/fuse/dir.c                           |  37 +--
 fs/fuse/file.c                          | 449 ++++++++++++++++++--------------
 fs/fuse/fuse_i.h                        |  68 +++--
 fs/fuse/inode.c                         |  67 ++++-
 fs/fuse/ioctl.c                         |  35 +--
 fs/fuse/readdir.c                       |  33 +--
 fs/fuse/sysctl.c                        |  40 +++
 fs/fuse/virtio_fs.c                     |  77 +++---
 include/linux/mm.h                      |   1 +
 mm/folio-compat.c                       |   6 +
 mm/page-writeback.c                     |  22 +-
 16 files changed, 578 insertions(+), 374 deletions(-)
 create mode 100644 fs/fuse/sysctl.c

