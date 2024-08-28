Return-Path: <linux-fsdevel+bounces-27646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0BF9633A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E3B928341F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 21:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0B01AC8A9;
	Wed, 28 Aug 2024 21:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="nRjvRQ6w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11EE45C1C
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 21:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879682; cv=none; b=D3fUiMb8G6HVy0k0oQdgr6blJSi04Fk6FAlIctxcS0YOpYSYlwEGy9Nfg3pB+o69P62kUuVbPpNn/klp4UnYsADJ5f9OZRTwIK4nlJm0iOyFAV4TxDYkSrBEPRBikERS2gIaWRyocl6u2MHXevEYXdcVIvIrQ4nBcMT97ILl9kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879682; c=relaxed/simple;
	bh=wDocM1nibkJgFPtzX3nNihUrjJkuqGJ/uWfgIhDKhR4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Mo0Xdq7LOXMedkuhhqumrsuPTfiFUG5C8ir3HSPmkX9gQfCnuiDH5ipcn1Tp3zKVdBpNLMhjJLabv5XumvNmU9ZmwCcqcVWmxGoa6lidvn65VInROJ4Ikg4S4X/60HVyCG3D5Mv5YvsAvibsSWkI7Iq+5aENr1DOyJ8l0jLStw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=nRjvRQ6w; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6bf7707dbb6so9094226d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 14:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724879679; x=1725484479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4STFdGAzcN+DnHOdAyG33gatjZ2EZ2Gs7/Q0wf64nwc=;
        b=nRjvRQ6wiJJ8UaBoD3LvjeBPEA/KsmC09+L/43AOaOEsPdV4g+0PhVN0pKQoF3HrUS
         jbyu3xERjMsRfiPznPjpZPJdBzofGLkIEHgFBX4ZNHm02U33LqyQ3LXStOTlC6QOji7V
         brv9EmEPFeQZ1E9MTPnEaOuGLR0VpqHNIKokFRLJ3bu3fM7wOjiLSvWRudyTnPcOkNkR
         0z2MpisRcTP1oWKeEoRDxNqoDZb2BCnkXBAiii0daytGh4guS3y/TmZ5YCwK4SabjvIj
         VdQZ2sdeblY5yGoRkXhQv++j2sb6BUPLdaa/dexWwmKc26CqMjPhg58CK1lMEOKzY3wV
         qoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724879679; x=1725484479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4STFdGAzcN+DnHOdAyG33gatjZ2EZ2Gs7/Q0wf64nwc=;
        b=YcLN/BRFi1dtrTXeNmEJRZSmpMQqTdvudPS1Fge834qiobXp28ukEYN8DemgAMwDCl
         Kjp14otfDP0Cw7NnQrDRuEr1VYimWQeVXUi0armlkB6+CJKxJKSPwnimLh+kcKcc/MRP
         eLs1ccc1NNWgXh3RhYpw07zBySUP44XOosWt5/sYpCp2oLwT4d6jVt24bfFKquVJocTZ
         oJd3oj9K9tJWSEkFZa43A/82D43AQi8GtqV7co+V269fqGFYz89+vUrKLDR4W3T4KHsu
         +1Sl7qmu83jSA9MIt9Yh2nkOKommI/L9IhBXuluELagbzTOmyyTITqKCyqPnhldQw4sC
         jYGg==
X-Gm-Message-State: AOJu0YwlfDpuC9jllPF8GSNoUHvKBfNVGekvWPsFID93ee9/rTRu0KQ/
	fmSlSVMu864xkyl7QxwiTYWT5fEYim6kqIvnw1M491g1uzb75UbOR1U0GnPOtsEwvg9ie6o/WBI
	+
X-Google-Smtp-Source: AGHT+IHbKCKwEdQDcaewESL5Zdx4Zf4acDQMWgvODZGGlktPnUax6yJrSAmecFbrwbbzn9bI1GSLXw==
X-Received: by 2002:a05:6214:1946:b0:6bf:7efc:1117 with SMTP id 6a1803df08f44-6c33f33d66emr9516396d6.9.1724879679337;
        Wed, 28 Aug 2024 14:14:39 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162dcd10esm67937616d6.105.2024.08.28.14.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 14:14:38 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	joannelkoong@gmail.com,
	bschubert@ddn.com,
	willy@infradead.org
Subject: [PATCH v2 00/11] fuse: convert to using folios and iomap
Date: Wed, 28 Aug 2024 17:13:50 -0400
Message-ID: <cover.1724879414.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/linux-fsdevel/cover.1724791233.git.josef@toxicpanda.com/

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

Josef Bacik (11):
  fuse: convert readahead to use folios
  fuse: convert fuse_send_write_pages to use folios
  fuse: convert fuse_fill_write_pages to use folios
  fuse: convert fuse_page_mkwrite to use folios
  fuse: use kiocb_modified in buffered write path
  fuse: use iomap for writeback cache buffered writes
  fuse: convert fuse_do_readpage to use folios
  fuse: convert fuse_writepage_need_send to take a folio
  fuse: use the folio based vmstat helpers
  fuse: convert fuse_retrieve to use folios
  fuse: convert fuse_notify_store to use folios

 fs/fuse/Kconfig |   2 +
 fs/fuse/dev.c   |  38 +++---
 fs/fuse/file.c  | 315 ++++++++++++++++++++++++------------------------
 3 files changed, 183 insertions(+), 172 deletions(-)

-- 
2.43.0


