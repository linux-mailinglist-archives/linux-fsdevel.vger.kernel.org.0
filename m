Return-Path: <linux-fsdevel+bounces-30273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B34CD988B67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 22:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64B8C1F217D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 20:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813DF1C2DC1;
	Fri, 27 Sep 2024 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="uNxL84I7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C73179654
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 20:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727469942; cv=none; b=iVn0o+EpzWjpaPFXSjiBqi2e7vtmx0988N7mFU6O415eVNjpxt9WZmeL2UKFG9oZkATZtMjbdLFZf0pG1HYs+Z2KafCkvCwIPZRyLb3rb96OAtzpsT1HNgn9fEtbuUf5GINw1jii8q/0dbla+6C0Fg1gq/RTVxtHw0hNeY3JtRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727469942; c=relaxed/simple;
	bh=4JhMalXxkV77OEkgZZ354b7RdFkLZ6WDhxenoIXvgoE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=B1F+kvjAmfdx1qXK1Z3AUP0HnC/l2km/d/cfu6GV82i43KIFKwkvRVfojDJadQYn/GfN4Z8uNj3xxDe5Iyc11BDJA0YjnDW1T0ByzYzUHV/tMOa7jAqIoyMTe+jwi9PZfCumf3Tsm02hw7i0RdoeorUOVgufbxbQR9fIxO8EG4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=uNxL84I7; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6dbc5db8a31so20413997b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 13:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727469939; x=1728074739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=u5c7tiy2UOWJDSyWap7g1Y7+4uM5/VKDGLfh8pE8TjA=;
        b=uNxL84I7GYdAiLF97dYD78hlHJDBDB4muzZIbLo7sZJVpz0UEbwrxr5ThQy8NheUYT
         D51yDby7m+lq7MNC3x1chKJxwye4iLtvLUB1T5+741mfcYaNjxsw8BtP8+wE3w6ELmU9
         L4nSv4hl/zU2MDr0j5PppTEBO+E8dPMNaqB3qi0TfutHmOBvOXi6OLN6KrqVvmmzDA4y
         /nzzTVosfh/flJgLq/ZzXYXsKrWSitcIoiGMMioSlC/nZKOV7ledYBFIjkpNn4HIy81n
         0Ms+9O2udtobEoc+gS2rHUkjHj0xhT3NOHMeiyzL6rj5BHNjaBXu7mbxV762gyEpfLl5
         kTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727469939; x=1728074739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u5c7tiy2UOWJDSyWap7g1Y7+4uM5/VKDGLfh8pE8TjA=;
        b=ON5wGp0xn8NiXJFimwKm8i84ZrSAc90Xli1gMz0GqY5XFvyMLBnkvI4XXwYKw7CSR5
         8qp06zKBbfLo8y8uCiSFhMvwItzZTlWU8vLHcwjBZ+cqtXdLxhosnKHewwS2MipLebYJ
         x4frs6yS86qpuVdsA92B9vO+nK2H/1UBSoVCb6SQTPYckuVAejd4toc/FJC9r7yjghkY
         DU1GKyJcZCcrk9Lh5rkD+Jf0Ikuq3UHBVA1R+KGC4HHlwakCvlh/RWGDrOwqDY858EFG
         PnH36s+pZuYKbaSTmDfLYfEI4Ni536MPYVcjuva6V64cGQJeu6oTEttVrybrkslE/z08
         LT4w==
X-Gm-Message-State: AOJu0Yw/H370pI2aaCIJJKzzCnWFt0FE+d2/EqxJHHruaCsizcTPw4+n
	u3if+cRQD/QBbe8G1QDGVk4wULCuEn4yLJk8iCZFSUYPuFTfrURFMzx+nCR0/cPX65UV7PXYesr
	K
X-Google-Smtp-Source: AGHT+IEtYmk/ftILLuXZpyN50gARemojLhsPvOLpbq+9xJnsi1oQRi1AjOkIZ9YxGP8Smz+zSrA2eg==
X-Received: by 2002:a05:690c:668f:b0:6d5:7617:950e with SMTP id 00721157ae682-6e245386844mr41458117b3.18.1727469939279;
        Fri, 27 Sep 2024 13:45:39 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2452f7c26sm4127847b3.11.2024.09.27.13.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 13:45:38 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	kernel-team@fb.com
Subject: [PATCH v3 00/10] fuse: folio conversions
Date: Fri, 27 Sep 2024 16:44:51 -0400
Message-ID: <cover.1727469663.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2: https://lore.kernel.org/linux-fsdevel/cover.1724879414.git.josef@toxicpanda.com/
v1: https://lore.kernel.org/linux-fsdevel/cover.1724791233.git.josef@toxicpanda.com/

v2->v3:
- Discussions with Willy at Plumbers helped clarify expectations around large
  folio usage, he had already converted the generic_perform_write to deal with
  large folios, so I dropped the iomap conversion since it's a bit overkill for
  FUSE's buffered use case.
- Rebased onto linus + fuse/for-next.  I had to combine the branches because
  fuse/for-next is behind linus and there are fixes from Jann and Willy that
  aren't in the FUSE tree.
- Pushed a new GH branch since I had to combine everything
  https://github.com/josefbacik/linux/tree/fuse-folio-prep

v1->v2:
- Fixed my fstests setup to use --nopassthrough so my code actually got tested
  this time.
- Fixed a bug where we double put on the folio in readpages, because previous
  behavior was the reference was maintained until the endio, but
  readahead_folio() drops the reference on the folio, so we need to not call put
  in the endio anymore.
- Fixed the IS_ERR inversion pointed out by Joanne.
- Made the various adjustments pointed out by Willy.
- Updated the Kconfig per hch's suggestion.
- Pushed to my GH tree since there are dependencies to make it easier to see
  what the code is https://github.com/josefbacik/linux/tree/fuse-iomap

--- Original email ---
Hello,

This is a prep series for my work to enable large folios on fuse.  It has two
dependencies, one is Joanne's writeback clean patches

https://lore.kernel.org/linux-fsdevel/20240826211908.75190-1-joannelkoong@gmail.com/

and an iomap patch to allow us to pass the file through the buffered write path

https://lore.kernel.org/linux-fsdevel/7f55c7c32275004ba00cddf862d970e6e633f750.1724755651.git.josef@toxicpanda.com/

I've run these through an fstests run with passthrough_hp --direct-io,
everything looks good.

The last remaining bit that needs to be made to use folios is the splice/pipe
code, which I need to be a lot more careful about.  The next step is to plumb
through the ability to handle large folios.  But this is a decent start and
removes the bulk of FUSE's use of struct page, and is relatively safe and
straightforward.  Thanks,

Josef

Josef Bacik (10):
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

 fs/fuse/dev.c  |  38 ++++++------
 fs/fuse/file.c | 163 ++++++++++++++++++++++++++++---------------------
 2 files changed, 116 insertions(+), 85 deletions(-)

-- 
2.43.0


