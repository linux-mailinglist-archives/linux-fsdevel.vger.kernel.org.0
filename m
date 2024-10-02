Return-Path: <linux-fsdevel+bounces-30738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B1298E134
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 18:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CC66282754
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 16:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2A11D12E2;
	Wed,  2 Oct 2024 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tr1phiLR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C7F14D717
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888115; cv=none; b=bEDA7taSfEHKt9Ks63qzmAlCd+gnaJeS2sXXPTseZc4eOt5ba/K/HRywlCS7MEUQLxNhEapO8oUUY0eRJ64BZvDdiO+dDbx8wIM1hRCVfxFHLIVEBdKiDFzlryuC8Gi1QLyrNT9S4jVP6Dk4KXn05y+swrRyAMp7ELHfz0bmbno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888115; c=relaxed/simple;
	bh=wRCFbcusqsKFSRoicHBumDiq3DkTkC0eUJEf8WD1/bM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lf8kEpwj6Gq/Hl1BxLLBqmX1QxbI2MNXAKcI4wmatnD8ihr7BYUXHLO9eDmWbLxPiOw7ixmXNIPjvIchSpei8ofeIEsJA0CUh1C16nMJxsfyVg0yZCpr56dXoW9QFQcALk0W8hc+Tsv84VFCO5c8tj1/Nus+rrwT7Y6zHtv14qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tr1phiLR; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6da395fb97aso91137b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2024 09:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727888113; x=1728492913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X3nveGfqgXT5hRq0tNgnU2jvNrUnP4KhuuewcSIEDgk=;
        b=Tr1phiLRitBSy1WNiH6H8/VMhqyV5I9JMdhH5HOlC/Ygzgqt7MXHFlcR6tD6X0G07b
         hRDz57HM6zJRtDBisl5eI8jshO9YpcAZ6s9gO3ILQnxuS8RK3Qsv3SWXo8zke5wtNduG
         SLB2xE7cNDkQt+EGWm6oDcMLGz5C6rJX5AEALeoXNGpUIfIsiI5gdtBPj0ZbR3RRbHdV
         zzByKmzBeZayQY78JUsKv/tVOuykG38biEi5llcHt7gEZGTgBN4+oBRYx0LzyRlWjumC
         o5+cioORxjlD+Viak8febbjtbLfzcff6hcdVq6wImNPRMb8/l2qz+Nta9jQPtWM7NQ2x
         BW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727888113; x=1728492913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3nveGfqgXT5hRq0tNgnU2jvNrUnP4KhuuewcSIEDgk=;
        b=gBVRHDl7WpDuSD3k/iBP0MfY64fpoBAe3zUpiP/AW3BMRSzBbGNBRn5i5ZyakyS1bh
         cL1t9b7bFa/H/V9PUSE8unBowa+pi/bwA0HrZFSnDaKqJVPBamAMceQPOYnp/5JiXohC
         ZJ64IjR74OKd6C2pSSh7RxXI/wqDuLicOltEOeiyzZ2RYe9c7rgIlpffVBBWwjmNTWWS
         E2I4TToOygmwdLXrPhptsi3klSPf91AmXMR2tyMiDL6QDd8wMBdP2sBVVk09Y1X67XyP
         InPRAUcfwLAZLZ7A7wRDPaoXVs8ypOUXFwpxb5DPJ6iqwaTmyhTwv05rFDZgni0v29sC
         ahqw==
X-Forwarded-Encrypted: i=1; AJvYcCW4BxwPVHxSTD0yMwNrzA+nHLXpe+Yfn2J4zXAcQcvrX2NHLCWSTvX/qfkASCjOzymi1oIl6UzuW7McPfmc@vger.kernel.org
X-Gm-Message-State: AOJu0YzCK7FlotuHnU3a2J4YrdCtEd96w4qvM/0lOO41eKmZE55V51FX
	Zxz8D8ygiZ7M2yomsDhn0P0OROk8TB1wAtz3IBHQgiTtcepFVXno
X-Google-Smtp-Source: AGHT+IEQ8VkNWpGHQsdi5R3kR9BETCD2xawpfvg494MmA9tDr5uepseYEYavYt8sxno7VdoffQ+NlA==
X-Received: by 2002:a05:690c:c09:b0:6a9:4fdd:94e5 with SMTP id 00721157ae682-6e2a2af64d2mr36205947b3.13.1727888113291;
        Wed, 02 Oct 2024 09:55:13 -0700 (PDT)
Received: from localhost (fwdproxy-nha-004.fbsv.net. [2a03:2880:25ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e24536a7f6sm25407687b3.99.2024.10.02.09.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 09:55:13 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH 00/13] fuse: use folios instead of pages for requests
Date: Wed,  2 Oct 2024 09:52:40 -0700
Message-ID: <20241002165253.3872513-1-joannelkoong@gmail.com>
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
enabling larger-size folios on fuse.

This patchset has no functional changes and have been run through fstests with
passthrough_hp.

This patchset is dependent on (and rebased on top of) Josef's folio conversions
patchset here:
https://lore.kernel.org/linux-fsdevel/cover.1727703714.git.josef@toxicpanda.com/

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
 fs/fuse/dev.c       |  40 +++---
 fs/fuse/dir.c       |  28 ++---
 fs/fuse/file.c      | 291 +++++++++++++++++++++++---------------------
 fs/fuse/fuse_i.h    |  36 +++++-
 fs/fuse/ioctl.c     |  31 +++--
 fs/fuse/readdir.c   |  20 +--
 fs/fuse/virtio_fs.c |  57 +++++----
 include/linux/mm.h  |   1 +
 mm/page-writeback.c |  12 ++
 10 files changed, 303 insertions(+), 244 deletions(-)

-- 
2.43.5


