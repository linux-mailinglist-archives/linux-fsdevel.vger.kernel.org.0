Return-Path: <linux-fsdevel+bounces-51620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69BBAD97A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 23:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73FA24A0854
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 21:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DCB28D857;
	Fri, 13 Jun 2025 21:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8cEVu7L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93D81FA15E;
	Fri, 13 Jun 2025 21:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749851436; cv=none; b=pifuxosLiYcEc5JIooKIAyZwg67QhqAYXbdcONJlHfzAWNwxyOx/KA0ho3CqfTHOi9c7w8buzhfk8x2noz4ufFSTFcz/2vnUnThrWsSrp4mTp+vRRDhUtXl52OW6t6SCy7N58DNgD11huYupQ4YsF2nNZ/5nBmwGLUPP/pS5kf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749851436; c=relaxed/simple;
	bh=NdzhgVeiaINDFPXpjhnhawuq1y3xXntYJDgV1MQh0jg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EPnkrF4aOJzbENToadYUTTzQ6ox8ROXLPmqMUk3mbFR17mzOIMsi/DSDNbuI3/0bQo+CfWfNRIeSohQK4FNC7917apLlfBotOuI3U1/TATn5mJ463NKr9HJjfTOO9GPR2/6ypME87VgWoibYrkIuKj/BSnMaK8NZOjAfflcDhs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8cEVu7L; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2352e3db62cso24466755ad.2;
        Fri, 13 Jun 2025 14:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749851434; x=1750456234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O7FznX3wvJF0yVoembBCFQNi+2De21rRhXV7yM0+RQ4=;
        b=W8cEVu7LHn0nfH0hjgRlTh2IlScvYbs+vyt1MUtviMHsCwhWNlh1sPB6PUo4ffs4Ze
         VLA9UjJ1BJ/4wIs7VlWdYN6yHVeKb8DJEj4hLazVEU2mUm1+s6lJcth1xnpD95mAcKQU
         qMFvNlizllXSDrJJxIHNxhHdCLJ4pFs3EqTjI1VaAeW8jdhCsfncFQkrR6apl3i6JdRy
         49rwSUthIhJ23TqJpitztYl/KepxHhHzxdTFNJiLLrNhpBOjlrqhQ6Gkcx5Mg/WA0AyQ
         ewQ//P6sbRjxHhH8FlG3ct+bxPhxSksmHgj3t6OrvFx5JPIhq63Pvv1XFT2sYjGs3nB4
         F2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749851434; x=1750456234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7FznX3wvJF0yVoembBCFQNi+2De21rRhXV7yM0+RQ4=;
        b=WLmjkfkk/cdentoy++/YAn/Ig9K3cOIrbNioVHUZFpnQZXpsrsdtBVsW4J7wnyVj3R
         5T9sferi5bTHjLneoFGziC0SmjGB617MjSmGAmaGrvAAGRDa5ZwBogZVBow9GnMbeWfs
         0XJIxzrajKaoybeBC36JKpgk8ewH+lvMAPz9PElziMONG0RJgKGPf8GRFm7ygf5hFGqg
         GvDFegYdgQEDknWsoebn30c+t2c3g3Aq4SaQIwlcozFBJyZtx9sTrGpPr+WiTkvPZJyT
         9EavoehUHlZVMsmY3F+KgPUp/kEFc6zHkR1cvEJE0s3ncG/BuT9E2awUc0xpITsajMIa
         P8sw==
X-Forwarded-Encrypted: i=1; AJvYcCX1Wo1h0TVHVKSfqAcQJ18tY+i037YCk9aPSQrKYYuePOO7XvSyvf5AXmumLNViBgRYIm5lBOwku3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ8255SXVztTuPxuoFUWzLb2G+8cTrTQz60sQkfeWOTU7m/RA5
	lCDjKf/7xRiz8wfJbBwHy2sLpfg0e4hkxhBdsGiyfK/NIL83r3keTZ1MPQugDQ==
X-Gm-Gg: ASbGncuhGuUGcnf/VIhssNuM6xogAOQTLwo/P2Mi/XfIxH2xgoO4LRhcuOS6+RSgg+C
	x1ZhRU5y3EhbXqz8nnRfzf1KF9syxJnNFOCgyezxGpz4TMNLWmo2OdaTtmu7tHAjDfhC5kq4fja
	VuKR1HtMyTuP4RAmQT0V0fvVwiDQES0LGKJLjt3HEJA9c779K88b/pNBxtz9b3OrXw6Whrkw4/s
	pzxPF1DoHFoZ/KkDKl6UsvGfHYRB6hATLq78N384zo4QortcAVkHkTZLt9OEAjCOn1T2LXH1BPu
	B15N2NTUPMxMej3UF0KGgF8fJayyzimApC0Y6FcIyk3HS4AwJ7+8HDdD
X-Google-Smtp-Source: AGHT+IF1vT1ljdrfC4fFS/VFf1aedmLB7zrjZnuwlGX9HrhWr/i6ImrDFYKM2vNmvDEncpVQWY2C/A==
X-Received: by 2002:a17:903:2ac3:b0:234:f19a:eead with SMTP id d9443c01a7336-2366b13ae96mr16242905ad.43.1749851433686;
        Fri, 13 Jun 2025 14:50:33 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de783f3sm19369635ad.130.2025.06.13.14.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 14:50:33 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	anuj1072538@gmail.com,
	miklos@szeredi.hu,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 00/16] fuse: use iomap for buffered writes + writeback
Date: Fri, 13 Jun 2025 14:46:25 -0700
Message-ID: <20250613214642.2903225-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds fuse iomap support for buffered writes and dirty folio
writeback. This is needed so that granular uptodate and dirty tracking can
be used in fuse when large folios are enabled. This has two big advantages.
Now for writes, instead of the entire folio needing to be read into the page
cache, only the relevant portions need to be. Now for writeback, only the
dirty portions need to be written back instead of the entire folio.

This patchset does 3 things, in order of sequence:
a) Decouple iomap/buffered-io.c code from the CONFIG_BLOCK dependency, as some
environments that run fuse may not have CONFIG_BLOCK set
b) Add support to iomap buffered io for generic write and writeback that is
not dependent on bios
c) Add fuse integration with iomap

Patches 3 and 5 are obviated by the refactoring done later on in patches 10
and 11 but I left this patchset in this order in the hopes of making it
more logically easier to follow.

This series was run through fstests with large folios enabled and through
some quick sanity checks on passthrough_hp with a) writing 1 GB in 1 MB chunks
and then going back and dirtying a few bytes in each chunk and b) writing 50
MB in 1 MB chunks and going through dirtying the entire chunk for several runs.
a) showed about a 40% speedup increase with iomap support added and b) showed
roughly the same performance.

This patchset does not enable large folios yet. That will be sent out in a
separate future patchset.

This series is on top of commit 27605c8c0 ("Merge tag 'net-6.16-rc2'...") in
the linux tree.


Thanks,
Joanne


Changeset
-------
v1 -> v2:
* Drop IOMAP_IN_MEM type and just use IOMAP_MAPPED for fuse
* Separate out new helper functions added to iomap into separate commits
* Update iomap documentation
* Clean up iomap_writeback_dirty_folio() locking logic w/ christoph's
  recommendation 
* Refactor ->map_blocks() to generic ->writeback_folio()
* Refactor ->submit_ioend() to generic ->writeback_complete()
* Add patch for changing 'count' to 'async_writeback'
* Rebase commits onto linux branch instead of fuse branch
v1: https://lore.kernel.org/linux-fsdevel/20250606233803.1421259-1-joannelkoong@gmail.com/


Joanne Koong (16):
  iomap: move buffered io CONFIG_BLOCK dependent logic into separate
    file
  iomap: iomap_read_folio_sync() -> iomap_bio_read_folio_sync()
  iomap: iomap_add_to_ioend() -> iomap_bio_add_to_ioend()
  iomap: add wrapper function iomap_bio_readpage()
  iomap: add wrapper function iomap_bio_ioend_error()
  iomap: add wrapper function iomap_submit_bio()
  iomap: decouple buffered-io.o from CONFIG_BLOCK
  iomap: add read_folio_sync() handler for buffered writes
  iomap: change 'count' to 'async_writeback'
  iomap: replace ->map_blocks() with generic ->writeback_folio() for
    writeback
  iomap: replace ->submit_ioend() with generic ->writeback_complete()
    for writeback
  iomap: support more customized writeback handling
  iomap: add iomap_writeback_dirty_folio()
  fuse: use iomap for buffered writes
  fuse: use iomap for writeback
  fuse: use iomap for folio laundering

 .../filesystems/iomap/operations.rst          |  65 ++-
 block/fops.c                                  |   7 +-
 fs/fuse/Kconfig                               |   1 +
 fs/fuse/file.c                                | 308 +++++-------
 fs/gfs2/bmap.c                                |   7 +-
 fs/iomap/Makefile                             |   5 +-
 fs/iomap/buffered-io-bio.c                    | 365 ++++++++++++++
 fs/iomap/buffered-io.c                        | 471 +++---------------
 fs/iomap/internal.h                           |  40 ++
 fs/xfs/xfs_aops.c                             |  28 +-
 fs/zonefs/file.c                              |   7 +-
 include/linux/iomap.h                         |  88 +++-
 12 files changed, 775 insertions(+), 617 deletions(-)
 create mode 100644 fs/iomap/buffered-io-bio.c

-- 
2.47.1


