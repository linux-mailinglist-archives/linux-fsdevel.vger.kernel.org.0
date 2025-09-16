Return-Path: <linux-fsdevel+bounces-61839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF11B7E6D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5DA4608F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 23:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900062D3A93;
	Tue, 16 Sep 2025 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGxiiRXh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6479122A4EE
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 23:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066629; cv=none; b=Ms41GpyuABS5Ig6r113VDln/2RaAWk+kY2uzEcOyjnlfcdgriyp3cwfYaCvBADwBsYR0bkzHYMRQIa3oWVywQcK0MEC/DEaCIWuod7HSIUg1QAy5yKi5QsDJLqNFlWOYDefY2VYAD1eYIgp4XwDaQBuf4/qzuEq+2FKQZUI72gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066629; c=relaxed/simple;
	bh=CQ5wphbbGZcfCMXuoQRLWmySU/l3Bjz51Ra1IpJNCvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tNllXFmczdq4oivH3tjh+RsMgpyYkPRiYk0zOA3D+KgyQd0gabjqqqnJRNXNV+yop3qjtHfcBktqxYWoa8RXg9gxY5nKcyMVhlPQCB9cRoDkMmDBRgGkxHr0YLXUzGcAunj0MWqzlc/grBqKSKnWwMSE1N7dKVgH2MAxcR1JtDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGxiiRXh; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7725de6b57dso7561783b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 16:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066627; x=1758671427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G2XC7y/IzrA5p9pqqTQ6NCyVnT17Dbt6lJEyhnZFvco=;
        b=CGxiiRXhhQbLN1TWA3EJCOITo0mLPi7KyyoukjYixoCVscn4rw6u+6d62nOr+zw9kF
         sVJkxdKjYezSY/N9JgBjRruA/V0tMAY0Ini131+NP88i2nEZWJvROivYnN3e7W1tAv5H
         /w/fAcahuFlmCL8aAtwspi78EAopIRSltfE7jQ1aJZxOOflXZyvT5cB66VyOOtUO5WgQ
         J5BU/jmAEjTixDWw98ymvjXov/23LPyGJbNi/F/cubhL0vyL9ZTOMnk42U5BdmQ/4YXP
         dSdq4SobNzqSHk2uGYzFU6aVmRDJfClToLPQkg9jRvfY9M3toPo0w21WpRH6NQ8xJpuG
         VoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066627; x=1758671427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2XC7y/IzrA5p9pqqTQ6NCyVnT17Dbt6lJEyhnZFvco=;
        b=Zj1U9LH/dlAs3clUabl+AO/1xbkfmg/gSLsfKpHZzRr87tbe+xSjaAv4GBUjgwZ8Yy
         gz1ZYfje0Ly/AHSExKv07U+9A+pwJR9saYG0z9nYBe/YyC3OCBsscHiiqFiw3SGhLTEk
         Hk9ostJ3IqSH5T55e2EHBdydwOsIwiwiXO02IKhkrq81w51iba2YLhhuCspRDw4oHawn
         sqr7HVMZ49Aq7t0rNfw2MqzN1EGMDUs5emCPEE5scLGxgPD6O2IxzWhJuQli4XwVkEBR
         D77riZ+es8ah5M21AhZ3mr0/KgEbrudQrW18AHWykdEMRVYSV6ho3pUAZsA05zjwOgsy
         Lonw==
X-Forwarded-Encrypted: i=1; AJvYcCU1chR/yz1GowfOMev2t6fCYkJ8ktChJBSGCJtPj+cTN8XqEetTuaau6eC4mDM45QCuno/EtwftfeY76R0y@vger.kernel.org
X-Gm-Message-State: AOJu0Yx888zipiWhhMYcPIgX49wvYUmZZek9xYcZhyMHXZC0rmGoXQoV
	p+41oUUwkrNv4wiQtdJVcgE3uBMtEeRykt2ry3BDxu3WcRP7zSj0pivl
X-Gm-Gg: ASbGncu3FZ/tKJqSEkvtG6beLuLzOZMLLFfspNi6/ZMP6mciwhcZQSE2X8Jy6/4R9Ls
	FOJaxfeyjQG1awWqwCdbligUbSYf7yCrVIhlfyxIF2wrXap61vc8vbbxrHGkov0wcVQdSL1uvMz
	jmYm8XBG6s1kSmaBm9CqjAPdlD1ERgR+QTQsHFFBeBR3ef9iKRv5ajfTDW1QqGiA7jIo25QwRJP
	qVTDLm5L9c/5/rPGklxCa+QAwnkujn0HgbGG+IukHvsPWUeoW7uQPvzGfKsFqUiM5YUrNnA7+Wb
	MD8dR2mYN76six8ftbIMfuzjWc9Pi2Ux1gUKqakHzkzCr3qFJxT0nmyLzz9mrhgZLw+u8uzOnUp
	rEMahJoYGX/SKnJ9Gjfuupx5/frqvcC/fPwaGcoRNY3fXHvRp2g==
X-Google-Smtp-Source: AGHT+IHSPtu69tEnk4g5Qtsth9ma9q3bZ2PkuxzPvt3qU0RNuqbxMRBJv8Z6Mkpxy+Me1JPZLjg6EA==
X-Received: by 2002:a05:6a20:158a:b0:262:af30:e5c with SMTP id adf61e73a8af0-27aa3088778mr66517637.26.1758066626695;
        Tue, 16 Sep 2025 16:50:26 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5c::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a399081dsm15358684a12.43.2025.09.16.16.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:50:26 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 00/15] fuse: use iomap for buffered reads + readahead
Date: Tue, 16 Sep 2025 16:44:10 -0700
Message-ID: <20250916234425.1274735-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds fuse iomap support for buffered reads and readahead.
This is needed so that granular uptodate tracking can be used in fuse when
large folios are enabled so that only the non-uptodate portions of the folio
need to be read in instead of having to read in the entire folio. It also is
needed in order to turn on large folios for servers that use the writeback
cache since otherwise there is a race condition that may lead to data
corruption if there is a partial write, then a read and the read happens
before the write has undergone writeback, since otherwise the folio will not
be marked uptodate from the partial write so the read will read in the entire
folio from disk, which will overwrite the partial write.

This is on top of commit 1228c548bb98 ("Merge branch 'vfs-6.18.writeback' into
vfs.all") in Christian's vfs.all tree.

This series was run through fstests on fuse passthrough_hp with an
out-of kernel patch enabling fuse large folios.

This patchset does not enable large folios on fuse yet. That will be part
of a different patchset.

Thanks,
Joanne

Changelog
---------
v2:
https://lore.kernel.org/linux-fsdevel/20250908185122.3199171-1-joannelkoong@gmail.com/
v2 -> v3:
* Incorporate Christoph's feedback
- Change naming to iomap_bio_* instead of iomap_xxx_bio
- Take his patch for moving bio logic into its own file (patch 11)
- Make ->read_folio_range interface not need pos arg (patch 9)
- Make ->submit_read return void (patch 9)
- Merge cur_folio_in_bio rename w/ tracking folio_owned internally (patch 7)
- Drop patch propagating error and replace with void return (patch 12)
- Make bias code better to read (patch 10)
* Add WARN_ON_ONCE check in iteration refactoring (patch 4)
* Rename ->read_submit to ->submit_read (patch 9)

v1:
https://lore.kernel.org/linux-fsdevel/20250829235627.4053234-1-joannelkoong@gmail.com/
v1 -> v2:
* Don't pass in caller-provided arg through iter->private, pass it through
  ctx->private instead (Darrick & Christoph)
* Separate 'bias' for ifs->read_bytes_pending into separate patch (Christoph)
* Rework read/readahead interface to take in struct iomap_read_folio_ctx
  (Christoph)
* Add patch for removing fuse fc->blkbits workaround, now that Miklos's tree
  has been merged into Christian's

Joanne Koong (15):
  iomap: move bio read logic into helper function
  iomap: move read/readahead bio submission logic into helper function
  iomap: store read/readahead bio generically
  iomap: iterate over entire folio in iomap_readpage_iter()
  iomap: rename iomap_readpage_iter() to iomap_read_folio_iter()
  iomap: rename iomap_readpage_ctx struct to iomap_read_folio_ctx
  iomap: track read/readahead folio ownership internally
  iomap: add public start/finish folio read helpers
  iomap: add caller-provided callbacks for read and readahead
  iomap: add bias for async read requests
  iomap: move buffered io bio logic into new file
  iomap: make iomap_read_folio() a void return
  fuse: use iomap for read_folio
  fuse: use iomap for readahead
  fuse: remove fc->blkbits workaround for partial writes

 .../filesystems/iomap/operations.rst          |  45 +++
 block/fops.c                                  |   5 +-
 fs/erofs/data.c                               |   5 +-
 fs/fuse/dir.c                                 |   2 +-
 fs/fuse/file.c                                | 289 +++++++++++-------
 fs/fuse/fuse_i.h                              |   8 -
 fs/fuse/inode.c                               |  13 +-
 fs/gfs2/aops.c                                |   6 +-
 fs/iomap/Makefile                             |   3 +-
 fs/iomap/bio.c                                |  90 ++++++
 fs/iomap/buffered-io.c                        | 273 ++++++++---------
 fs/iomap/internal.h                           |  12 +
 fs/xfs/xfs_aops.c                             |   5 +-
 fs/zonefs/file.c                              |   5 +-
 include/linux/iomap.h                         |  65 +++-
 15 files changed, 530 insertions(+), 296 deletions(-)
 create mode 100644 fs/iomap/bio.c

-- 
2.47.3


