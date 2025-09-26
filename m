Return-Path: <linux-fsdevel+bounces-62822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2CABA20E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 02:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A407656062E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 00:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B355813B7A3;
	Fri, 26 Sep 2025 00:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjtJb4tm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5E1DDA9
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 00:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846566; cv=none; b=LZ43JCLNX7WH3Lt1qzlIjOAyeONotHZ/g1/mjOTzY5uxLoD+jyOHj60kpR0lvD+HDByBn9iyBpRa1ySuH8oa/3eEDNtDawgzK1I5BjiAEgaaqem+kA93VokQ4kRLi5blmErnunJZGMobITRamMo2FcqEMs1zd2h5whB7q6jI10A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846566; c=relaxed/simple;
	bh=0W/7hs78HuUmwTCQkUj3WBChFwPbbkB8GVUDQwx06qI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rA6i+16DdNGxDr0SfXt0SpzB6JRwx9SWlKy81oo4lHH+787TlWkLsOPWg1SrsJNho0R5iaSsLGXu6CCtXVCNWCqTWNLDc/IbR2JGJmPQvHUBMARRiBoTsb6roWVdmcSlUSqbagQ1P4VcmKP0RffKRiv4vdTPir0YWBU3Y0Jpi1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjtJb4tm; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-271d1305ad7so23129585ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 17:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758846564; x=1759451364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HMJD9Q3ddlq5CyOM+oz055Su9+4BhIKjGA1980+1kzg=;
        b=ZjtJb4tmQ+8Sf1otFalVt2FYW3yYYOD1XWHW/rmw19AOD7BGG3coOU9qgdfQk3gmBu
         qin6/N3qTtMiToBGpgide3O7zs7Z6oJAA+04s7HlUkFaljeodWd+TyKVesYXKpZ1IpQi
         0Jnmz2P5MiMbcwmMdI+/m9VFNjE7GPQdGxtg/5qJlW9hjmBU88OyL6Jm1Q6G9gqhZOGV
         tbzKJbpDRL4yLbJQfISIIMTF0N9mg0LJ7x2wp1RbFEDpZmUXHq1Kd04viTXor01+7fb4
         pK6XKMmPvssTDM9HuSv2dZRbSh8irsvuX5PQguwghAagy3eSCu+Ihsa4VM1h1HWMBlga
         pHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758846564; x=1759451364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HMJD9Q3ddlq5CyOM+oz055Su9+4BhIKjGA1980+1kzg=;
        b=EgrzCy55c+HPOr6oaKDYOq7DUWErweyXUY+2/zgPfYeLNaA9v5ixUlt0BQAcWWtlRd
         jcS1a4yczsJsuSxAUFVXTqYPSx13SNyKUyPJ+nDk0yKR4jfe3zcL0PV8YrbDgUbXDQVe
         WmYPcWbSnPSAvSX2WWajixmL+mGfWrQXLP+ddLkYC720O0fQqfghap4O/99EIFUNR6l1
         ad94e0zXwxESicegGgRUSvQRTrYwrXzK4KH32wK47M2gRiO9X3GT8eiCUEuLrsXXotzq
         TQ8eLYiTjvGhV4ejbC0ghOezYl50hDV6xtDkaKPNY/Z66q4fNwwrgL9v3QMQKb0St4R0
         bXtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8Lwf/qxedqXdSM7UG6e46SY3LgiNuN/B1kWWw1jFJRUVLMUg8dmF6JLJPEQJnj1mOygUVemcGe29TjYA4@vger.kernel.org
X-Gm-Message-State: AOJu0YzgW9VOtzFTFL3r1VEKojj+Fu/a8GgQl+cs6BAovnJVf8MDMikm
	wM3Z3z5k1vI9nDfKuTuNhVl+z8RwW4vZ013zXz9ELewmoVcTjWIcEpRZ
X-Gm-Gg: ASbGncs7nzyjTz4rfxwU62SlHH7YQHj26xt7Hc5SL1Gp8guVswKy5BB6C554Jza8Fr4
	U1ZLe7qhy62aONJWuwTWVJJFvIYGPDBA2PlnancuSqI93N8yqTPaoevYuFcQlX/OzKikEy5v7bL
	EnVUW1LMrJe6H11uXCVYysPGuwvkCklpe+Fj4Fp3rKphYzRhFWtU3RWNN1VpARARbP9UXHxnvHM
	tkbt/CJ6F7xrpi911fq90qDhOUPwttoS1LT4fOnKUipBY01BV7P1HXF+Nknq1Jh4uCOpCeEcbH+
	KTeubpn31emqPzR/lv2JGqwSHU6ELEeZIFvQtaa8UWId3mB3YKY4uzzVLIH1j8OGZSVo86z5nQB
	B9sZC+A6HYWiUlt6RN4Bx8SDraOAfbPna8LXIKeia6ANR5SnD
X-Google-Smtp-Source: AGHT+IFBOC7sSbj5IFvRNx7Jv4sa7XYTGAtKLXSj+8uiMY+K39fFGvNnEV8ul9fibW4RMGLttUsXrQ==
X-Received: by 2002:a17:903:1209:b0:267:44e6:11d3 with SMTP id d9443c01a7336-27ed49d2bf5mr60472315ad.21.1758846563773;
        Thu, 25 Sep 2025 17:29:23 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671d8a2sm36696485ad.55.2025.09.25.17.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 17:29:23 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: djwong@kernel.org,
	hch@infradead.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v5 00/14] fuse: use iomap for buffered reads + readahead
Date: Thu, 25 Sep 2025 17:25:55 -0700
Message-ID: <20250926002609.1302233-1-joannelkoong@gmail.com>
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

This is on top of two locally-patched iomap patches [1] [2] patched on top of
commit f1c864be6e88 ("Merge branch 'vfs-6.18.async' into vfs.all") in
Christian's vfs.all tree.

This series was run through fstests on fuse passthrough_hp with an
out-of kernel patch enabling fuse large folios.

This patchset does not enable large folios on fuse yet. That will be part
of a different patchset.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20250919214250.4144807-1-joannelkoong@gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/20250922180042.1775241-1-joannelkoong@gmail.com/

Changelog
---------
v4: 
https://lore.kernel.org/linux-fsdevel/20250923002353.2961514-1-joannelkoong@gmail.com/
v4 -> v5:
* Add commit for tracking pending read bytes more optimally (patch 7), which
  was suggested by Darrick and improves both the performance and the interface
* Merged "track read/readahead folio ownership internally" patch into patch 7
* Split iomap iter pos change into its own commit (Darrick) (patch 8)

v3:
https://lore.kernel.org/linux-fsdevel/20250916234425.1274735-1-joannelkoong@gmail.com/
v3 -> v4:
* Rebase this on top of patches [1] and [2]
* Fix readahead logic back to checking offset == 0 (patch 4)
* Bias needs to be before/after iomap_iter() (patch 10)
* Rename cur_folio_owned to folio_owned for read_folio (patch 7) (Darrick)

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

Joanne Koong (14):
  iomap: move bio read logic into helper function
  iomap: move read/readahead bio submission logic into helper function
  iomap: store read/readahead bio generically
  iomap: iterate over folio mapping in iomap_readpage_iter()
  iomap: rename iomap_readpage_iter() to iomap_read_folio_iter()
  iomap: rename iomap_readpage_ctx struct to iomap_read_folio_ctx
  iomap: track pending read bytes more optimally
  iomap: set accurate iter->pos when reading folio ranges
  iomap: add caller-provided callbacks for read and readahead
  iomap: move buffered io bio logic into new file
  iomap: make iomap_read_folio() a void return
  fuse: use iomap for read_folio
  fuse: use iomap for readahead
  fuse: remove fc->blkbits workaround for partial writes

 .../filesystems/iomap/operations.rst          |  44 +++
 block/fops.c                                  |   5 +-
 fs/erofs/data.c                               |   5 +-
 fs/fuse/dir.c                                 |   2 +-
 fs/fuse/file.c                                | 288 +++++++++++-------
 fs/fuse/fuse_i.h                              |   8 -
 fs/fuse/inode.c                               |  13 +-
 fs/gfs2/aops.c                                |   6 +-
 fs/iomap/Makefile                             |   3 +-
 fs/iomap/bio.c                                |  88 ++++++
 fs/iomap/buffered-io.c                        | 246 +++++++--------
 fs/iomap/internal.h                           |  12 +
 fs/xfs/xfs_aops.c                             |   5 +-
 fs/zonefs/file.c                              |   5 +-
 include/linux/iomap.h                         |  63 +++-
 15 files changed, 505 insertions(+), 288 deletions(-)
 create mode 100644 fs/iomap/bio.c

-- 
2.47.3


