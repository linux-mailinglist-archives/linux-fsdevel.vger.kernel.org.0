Return-Path: <linux-fsdevel+bounces-54311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B348AAFD9F8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 23:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C572189C085
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 21:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FD7246772;
	Tue,  8 Jul 2025 21:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGiZlfYw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40431A8F84;
	Tue,  8 Jul 2025 21:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752010265; cv=none; b=K4lTxru4WtW98bAmiZG7uyEq55YQBkDEyG4q+3GKjLW6FGzzMbYmucLwtvUDsIX1g2WaWJ0CiBA5O4NWha02ONBOJqaTRZsazPHT3B0oAlqi1aX8j3xMlbepmYzjHHH4juUhsRH53znCM2RNurA+iMCYT5hyoTIKSLSAPrmwipU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752010265; c=relaxed/simple;
	bh=pHbIZYR/cPjhqgkSQJwswTCukX1J3YAVEComlN6LLFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=as0JiPskw7RXb+Vqy/L0KhPCFIjmTesDWwp6D3IRMtSwEbnNV86UmBi2X2sPRb0+W9cm6dku/fa9NWAnLO8gYtp4Q4TroTOkdudB8HUBbfro77JmG5rgyO3f6o2goJQ5EoLPaQ5cpf1UgTpknCoTQSMmsVCRB8IBLadO5+IHP14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGiZlfYw; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d45f5fde50so456763685a.2;
        Tue, 08 Jul 2025 14:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752010263; x=1752615063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUU5TRDaN6ALyyrygW/6RzwmiAYhH4pOYiMcpic0/PY=;
        b=TGiZlfYwgMTQ1JipyMsF2y5AHWGNvuFoP0/4nyoGKkPQa5deV9SioM4YgT3oiktl/y
         cewroEIdxfjHsoaCGdAzTI8SnqwIc8UG+Ai6wWfDYaPt/JqlhAx3JaWkbw8eS792V5dq
         x5N1cOz8yN5qC9+Od3yaapW/9y7CT05oni1nM7q94Nekjmog5QYUHdej18wt7CwcFGbf
         X6Oyh/JoamqltAa1DAEpUcFEVS1dcteQkCg8Z6h3jeW3PMPT7YMjNgsCo2b68CMFWaS6
         8ZhsGZ/skLWRf5XgKXqFxtCI9c1nJodCbd++Yg1PLJTJAaUnhd/fW4Z+WjwdKZhCKcLM
         iZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752010263; x=1752615063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZUU5TRDaN6ALyyrygW/6RzwmiAYhH4pOYiMcpic0/PY=;
        b=H2tx0bvkB/9pCLEzpAx/TfKEz4B+AM/XhE4AazSSpIeHwmGIaYYlaP228pJ4cn9nUM
         xtd8vrniavadx8n3zIiy6LIbbJLeg/RHZeOSMl/+14KiQbWZpn8hOYMEbYviGHZklFIk
         /0L/RuzzT/tXviHCSQTIuGM5sPoXwotMVVQ9w1QJL5mLs7O9Ls2T4rUNm8p7HhI6CQAB
         MRhTLN2roWc7ruqLjUtGZigcBS4c1jPWaiR44GHbGlMmTN3boo/Pmjh610ewsLHVu5i5
         EMrnLplHei/gc8fMMZMNrGfDeAZPD2REvbiYaTyvdrcG3q8KU2FGl447YjFtr4teeMUi
         z+bA==
X-Forwarded-Encrypted: i=1; AJvYcCU4aQGEPN7SH2DdhNkpDT7j9QoHriZ7iD++LjZktj9w0bGSg/KL7+llG5lINTmvu+HqgbxVClFrYhoh8g==@vger.kernel.org, AJvYcCVIUhB3HTfw/If4gK32OrfETT7nFtfZlt2LZTbyaYq9cFKvLqV52iyZtkkZApqgqjIRiMKSKLqbN8cb@vger.kernel.org, AJvYcCWhQGNYv29gOtJhsPFSLx1Nl+16EcFsMILfyKaaUjVMne7qzAsv1wz2qeVCkvogho4+IuSupTai6ZcwY/EXaA==@vger.kernel.org, AJvYcCX4B4565C3+PNNMDqNuBjSJbsSa/PfW87Y66hRn3MCahh6D42M9i8wsPY+hkRLg+3Xy8c1+ROv5wmeL@vger.kernel.org
X-Gm-Message-State: AOJu0YyrhwXfoqKCdMITdzG9tBYKxXcLa+vC7fY1UC0xhm2VewL8PDim
	f476EvLT2aDbTBycBzmP+7nCXbnSG9mDjtqY153i3qVXC7ZD+YXV1d454T1wluu4TMZFy679z5P
	z6jk3E60QmZ1fZuiWSkEdIWMOhZnQCzo=
X-Gm-Gg: ASbGncupF/6VGnoJ4Q3B2QZIxtqazMuTpFjR0kD/srjrUvu3UlhiwCh8iEj0VYaY8F6
	1FbD2Bg3/GezPYriINgpg8IGWTWbRCT/upudOpCgCy4rJUX3cKnplp/DYMVDZHP6phN95NUpJCy
	Sa0FbssTGrszjF486Qt2BkDKgbIozNorohN6KhLaOITMU=
X-Google-Smtp-Source: AGHT+IH0d/vk43vmyXPKIpP94pCK3w1qCzYdnwJNVDW8qW5d8MHocQso6Lt/gQSIfRkmy6R/U41ZJn66Xk4Bv0SJdK0=
X-Received: by 2002:a05:620a:2544:b0:7d5:d0a1:c907 with SMTP id
 af79cd13be357-7db7cfa32f5mr45846185a.30.1752010262414; Tue, 08 Jul 2025
 14:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708135132.3347932-1-hch@lst.de>
In-Reply-To: <20250708135132.3347932-1-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 8 Jul 2025 14:30:51 -0700
X-Gm-Features: Ac12FXwa5YtLizBFDxdywhwayE5_QcC1_suEMiJs_748sHEtc47znVbUJrRxab8
Message-ID: <CAJnrk1byAutqR6A1fyqKHvoAisK=MfrfD1p778dPqZDBPsp+Wg@mail.gmail.com>
Subject: Re: refactor the iomap writeback code v4
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 6:51=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> Hi all,
>
> this is an alternative approach to the writeback part of the
> "fuse: use iomap for buffered writes + writeback" series from Joanne.
> It doesn't try to make the code build without CONFIG_BLOCK yet.
>
> The big difference compared to Joanne's version is that I hope the
> split between the generic and ioend/bio based writeback code is a bit
> cleaner here.  We have two methods that define the split between the
> generic writeback code, and the implemementation of it, and all knowledge
> of ioends and bios now sits below that layer.
>
> This version passes testing on xfs, and gets as far as mainline for
> gfs2 (crashes in generic/361).
>
> Changes since v3:
>  - add a patch to drop unused includes
>  - drop the iomap_writepage_ctx renaming - we should do this separately a=
nd
>    including the variable names if desired
>  - add a comment about special casing of holes in iomap_writeback_range
>  - split the cleanups to iomap_read_folio_sync into a separate prep patch
>  - explain the IOMAP_HOLE check in xfs_iomap_valid
>  - explain the iomap_writeback_folio later folio unlock vs dropbehind
>  - some cargo culting for the #$W# RST formatting
>  - "improve" the documentation coverage a bit
>
> Changes since v2:
>  - rename iomap_writepage_ctx to iomap_writeback_ctx
>  - keep local map_blocks helpers in XFS
>  - allow buildinging the writeback and write code for !CONFIG_BLOCK
>
> Changes since v1:
>  - fix iomap reuse in block/zonefs/gfs2
>  - catch too large return value from ->writeback_range
>  - mention the correct file name in a commit log
>  - add patches for folio laundering
>  - add patches for read/modify write in the generic write helpers
>
> Diffstat:
>  Documentation/filesystems/iomap/design.rst     |    3
>  Documentation/filesystems/iomap/operations.rst |   57 +-
>  block/fops.c                                   |   37 +
>  fs/gfs2/aops.c                                 |    8
>  fs/gfs2/bmap.c                                 |   48 +-
>  fs/gfs2/bmap.h                                 |    1
>  fs/gfs2/file.c                                 |    3
>  fs/iomap/Makefile                              |    6
>  fs/iomap/buffered-io.c                         |  554 +++++++-----------=
-------
>  fs/iomap/direct-io.c                           |    5
>  fs/iomap/fiemap.c                              |    3
>  fs/iomap/internal.h                            |    1
>  fs/iomap/ioend.c                               |  220 +++++++++
>  fs/iomap/iter.c                                |    1
>  fs/iomap/seek.c                                |    4
>  fs/iomap/swapfile.c                            |    3
>  fs/iomap/trace.c                               |    1
>  fs/iomap/trace.h                               |    4
>  fs/xfs/xfs_aops.c                              |  212 +++++----
>  fs/xfs/xfs_file.c                              |    6
>  fs/xfs/xfs_iomap.c                             |   12
>  fs/xfs/xfs_iomap.h                             |    1
>  fs/xfs/xfs_reflink.c                           |    3
>  fs/zonefs/file.c                               |   40 +
>  include/linux/iomap.h                          |   82 ++-
>  25 files changed, 705 insertions(+), 610 deletions(-)

Thanks Christoph for all your work on this. I'll pull this and put v4
of the fuse iomap changes on top of this. I'll send that out this
week.

