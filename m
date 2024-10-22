Return-Path: <linux-fsdevel+bounces-32598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DAD9AB63C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 20:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 668921C231A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 18:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5961CC17C;
	Tue, 22 Oct 2024 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZgJWZko"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7621CC14A
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 18:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729623291; cv=none; b=LGX8pNiJG/7cYCA/FKo6rAtyAbBQSuNHTUsTH1O2AJmCxM122OazeXRgRwIYEBeCBH5df6RXjMy705IZLiD9X1M9nIKaB+5UAVs8PP8q3FqbHYpAHWaFwES6grBGdTmXvGrqRKFBfKY4DJ+zQLOR34j9T7CMUbglylk5uAxGUoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729623291; c=relaxed/simple;
	bh=ZN14uDZJiDedeF7/kL/vX0ytYRct6wRo4XCQvaAdamo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FR4g+LjlPfy8ErgGqNbLeHQvvaKhC12ltyuHZhvKLrOrzUIm5il8KMYT5tNI9aON6VUeKItd8RICOODEIFZQ+LCzk9lp0rkPJWT8aru8tjvrWy9QWNvJRDxLNDH/NgjFXBFMClE07ZxphpJ7qcPJ7t3+LR1q2Y55txIIiuT5Vks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZgJWZko; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e34339d41bso53020877b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 11:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729623289; x=1730228089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rVRzUdQLkOXN6vY24zrdl38IpLdO/ra1R+eqpgzr714=;
        b=FZgJWZkoP0kXJUAKIg0n84KqZQImumkVUbnE0lqM7rP7FjvprR3zfgKfMPDCswLiRa
         OfJDbNVagskAkQ5Vtk2dbn7BZzXhJ7RZrsvED+jN6OqgVQj7I2uliWgGIHT7B0BNlGFk
         elwoJYfKwPh2kqhSWXqgPgS0OKuRCqKCmeG08TuXDk2sFmtNPustBrF0VHU+Ugpugv7F
         9yG+AE/XNuaPU1DyoHbdKTQ5pTdwtG1fcTVmpWogAZsocyOdKrXtnvwViBaXDK/QEHrb
         BF/oF3YEhjlU+lmlVyb+O3XZWf0/pFNbnmMOzdUQqGg5ldD00LEu1x8YtEje097wF5ix
         FkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729623289; x=1730228089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rVRzUdQLkOXN6vY24zrdl38IpLdO/ra1R+eqpgzr714=;
        b=LIEl82YL011/4iV/to1uH4t4QB1TwH8GypU/pSP1H2M2EsTvEV0in5aKMJ0M2sM30a
         j43ke3FDXG6pl7l2J1OCsoBXB6xWQbJf/UWePWBTQtJJE4vjq4muWO85sUSAg7q3Pevc
         Ux8eLBwPmJRV/lrWoX+MzGINXGFv2qrHvbWlJOCAS+sxKcJRug6bEjvSTeEYY1O3mllE
         6FcY/6zSuM7g665GAvWsjMFlJLSz6ZzY3YrDJ+Ye2sK7tS76fpvQgrrcf2lugzQkd55Q
         UQK5iWo7OhSTee7tTZOyHpABd+rYdwEJ9tFHNf4HYiUZt6pBp/RweOF86g736ou9hORg
         Yg5w==
X-Forwarded-Encrypted: i=1; AJvYcCV55fpJXNHCNvgvJbByRasnepSO0FblVJS4L/oPXbQxa2PUrSP63rSDxXuYOCVBfrsMhS1uPvfihUnJHyVp@vger.kernel.org
X-Gm-Message-State: AOJu0YyJW90a2kvbmA7CbbPavXf2wnRbPgQtjOyawmHgyOKfiQYbrK1X
	V5Fr+vGeHeClILv47pnh4iwUGGuQcqhxuFjJrwVgDjZyFWm9LsgQ
X-Google-Smtp-Source: AGHT+IFyiraoJC7yDNQMkt5eRIB1tMDJK3v1sPKLljBtFFDwj3dvmORLKkcuUO8w0FYkXH3pfJb3Wg==
X-Received: by 2002:a05:690c:7487:b0:6e7:e68b:f883 with SMTP id 00721157ae682-6e7e68bfe48mr26556047b3.39.1729623288776;
        Tue, 22 Oct 2024 11:54:48 -0700 (PDT)
Received: from localhost (fwdproxy-nha-115.fbsv.net. [2a03:2880:25ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5d13172sm11728267b3.125.2024.10.22.11.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 11:54:48 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v2 00/13] fuse: use folios instead of pages for requests
Date: Tue, 22 Oct 2024 11:54:30 -0700
Message-ID: <20241022185443.1891563-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset converts fuse requests to use folios instead of pages. Right
now, all folios in fuse are one page, but a subsequent patchset will be
enabling larger-size folios on fuse. This patchset has no functional
changes. Any multi-page allocations for requests (eg ioctl request) will
also be optimized in a subsequent patchset as well.

v1: https://lore.kernel.org/linux-fsdevel/20241002165253.3872513-1-joannelkoong@gmail.com/

Changes from v1 -> v2:
* Address Josef's comments on v1
  - Clarify comment about folio replacement in page cache 
  - Remove unused fuse_page_descs_length_init() and fuse_pages_alloc()
  - Copy comment to folio_mark_dirty_lock()
* Add Josef's Reviewed-bys
* Refactor page_set_dirty_lock() to use folio_mark_dirty_lock()
* Keep using variable naming "nr_pages" in some places (eg fuse_direct_io)
  instead of "nr_folios" to make accounting more clear for max_pages, which
  reduce variable naming churn in subsequent patchset that supports large folio.

Joanne Koong (13):
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

 fs/fuse/cuse.c      |  31 ++---
 fs/fuse/dev.c       |  42 ++++---
 fs/fuse/dir.c       |  28 ++---
 fs/fuse/file.c      | 268 +++++++++++++++++++++++---------------------
 fs/fuse/fuse_i.h    |  36 +++---
 fs/fuse/ioctl.c     |  31 +++--
 fs/fuse/readdir.c   |  20 ++--
 fs/fuse/virtio_fs.c |  58 +++++-----
 include/linux/mm.h  |   1 +
 mm/folio-compat.c   |   6 +
 mm/page-writeback.c |  22 ++--
 11 files changed, 292 insertions(+), 251 deletions(-)

-- 
2.43.5


