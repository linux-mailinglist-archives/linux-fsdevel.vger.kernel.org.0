Return-Path: <linux-fsdevel+bounces-60581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B479B498CE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 20:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60DC3AC9B3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 18:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA19A31C598;
	Mon,  8 Sep 2025 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjrX61xD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB65A1A5BBE;
	Mon,  8 Sep 2025 18:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357537; cv=none; b=Q6lnFIhbVrqoHkSekdcunbw6hfoEbb5uS4mg/biguIlzFgdc7RpO17UlP0DYV+JAbQ60Kcn9FkNzLDmt6taWVCaLmpKdtmwKd5v+FyAPc/75ss4fq/FQ7sVbyJ4nPlQqtMEcoOI1wmvF+h+GGyDP6jVzFctAiOF3CFKp28BlVXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357537; c=relaxed/simple;
	bh=gCN5SxT5vP1NX+CbbCHkHf478+/hzyRd7OEKpfS6fDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hyrmoYhVfJrxvbqYDyzwk3sYV82kWL8vGxJUiAbA3nsjhG9/CXF6kj7Ad9Ufc5skxH1irZY7Mem96nFGH1Jiq4+N39pWG9C8F/ukHWH25oaNK6qBDLpPAPO0TdC1qpxBWmaMcd9NuQyM9GS+GErkOyonn/uRpE3ScnR+RZTF7JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjrX61xD; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7741991159bso4054544b3a.0;
        Mon, 08 Sep 2025 11:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357535; x=1757962335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lm3Imf0pgBjvWBHNU/XQYZEiSLH4qTMAkyxrgY5m5W0=;
        b=DjrX61xD2vnnmdEcCYky7HuhrQLIUfXN75RoGwcfkd1dX1AarzB/BKZyPo4jGRQfuM
         dFYB2U/oTyhDxFk9APrC60wBCfGSpJvLNowS0lNTyG+zHYzhKgPLmkHrO7ZjraNDaTsW
         /ioeTk0QJb47QRb0PJO0911VouflWwcFHaBl+avPNZ8XhN1KRGHaldUijLLFzxOULkPn
         qSRlL+5XQoOOitVYTP3iu3lF52D5CMRd2ZWQrMnK9WkLGWWoNrrAUQUwRHikC6KVqRTV
         mlm0mnQLeU94Rr6iPzXKTiDgyTojSfnNbODgV0YETXSE8ruYc2L4YBeQRkPpkH17QQTy
         8KkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357535; x=1757962335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lm3Imf0pgBjvWBHNU/XQYZEiSLH4qTMAkyxrgY5m5W0=;
        b=dfxCPGuOmG+VC7XQMgmvtNx1rAFHdHZFqy73sMtt9nbNLpK17gS3r5g6pt6LmuAo4Z
         7fJfKmu+ptuYBq3f03C9bgDOEFBh4v18ET3CHkpKRikUQzTP4CyHQjMDXmPzJnpkyO7h
         ghYgiXIasflUQ2worEQ9VM8UhVaA9SQfkXPuBLf6joyLguwCeOplsTdJlygmcdFYrkkU
         gdsDSK2ahgh/FzRYdT5NZCmNMM2G8BFfxTfpqqNvn0NYN20CXjKVpfXXMTHS4gqcPgA1
         /WEa4darEf9vRYeSlUha3U+jEX2QnhvDy0XFATQsiVZLGDYdNUsjm9vsTcsBqHB01/RW
         WxUw==
X-Forwarded-Encrypted: i=1; AJvYcCVTaySNOOyN3hClXhBfb9rWxrOWK44tFGDj+xDis15T8RwF7MKp5qqqA+hWUus/ddwp1zGlsG9Zbzwd@vger.kernel.org, AJvYcCW5vw+z2FtyPObHxmEeyh+1NWYeWMI9Jnr2VUNBdqoSuXvPDGtKlbDHUTe9XAF2LDDGtRm68nLHKYn6IQ==@vger.kernel.org, AJvYcCWfQyJM1VO47SUCuQUMBszKEbJTGT9XQcseEmZ9dNgy0gqAABPQoPQDFsobDjymQBppdMJmAnB9bj329T1xuQ==@vger.kernel.org, AJvYcCXO60Xc+g9+c+4UMJj801+D58kS0iOPNluyvtQ/GLlQiqobfwQCO60wo5aICtiqHdUdDuVBR6l3EQO9@vger.kernel.org
X-Gm-Message-State: AOJu0YwIQqkfnQvwGyL/n8wOm9k8Fs7gKQr2L1H3NKUzTo4SatX6Bs6Z
	wuoCvYIbxacNstlRPtBgYlTEyP5O6fom1JxTCvciCLIapssz44Whs/UQ
X-Gm-Gg: ASbGncvrua52osfzfCxcT1UxB5T7CUsPGvUhZ5z5qFaL23mctOVdODdlBKyS3fkCZ1z
	5eF1Z0UbSYu9he1bMXDNPKuGpVsEUNfQyIfwVmQmDizqGQ++snCxVfvqkJluR2ly5TepFPk0XCB
	FcCuxbF6ORFBq0V4ViDRcBzuqXV2tQuflv7e6q388HEJPJk32jGVETDggyQlMHkorE/4+81BZBK
	COl6nbtoWxCw/m25DSibyKKmycYuNkMaEAatJ5Qa2VTVG5yEhr4/eBqEVKU09hrMVWeUuuNIr6U
	7BrIhzfrFtNS0Xdf+ecxZGx3fzGxB2q9hqPNr/QhojjF3lD3RHRRbTgR/AkaRTUKg0BZ1kwiFfC
	73UwpECgr2nwz7X9+vBDGzO2eWgls
X-Google-Smtp-Source: AGHT+IHt7wUFngbPJ1fb9lzSML52MmUa09gdmnjs+gYzwN3cD9RrhRVdwNduOqUtB5yJFavDHOvpJw==
X-Received: by 2002:a05:6a00:4f8b:b0:772:3b9d:70f0 with SMTP id d2e1a72fcca58-7742dd64e08mr11340077b3a.2.1757357535099;
        Mon, 08 Sep 2025 11:52:15 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2d97acsm30230068b3a.41.2025.09.08.11.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:52:14 -0700 (PDT)
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
Subject: [PATCH v2 00/16] fuse: use iomap for buffered reads + readahead 
Date: Mon,  8 Sep 2025 11:51:06 -0700
Message-ID: <20250908185122.3199171-1-joannelkoong@gmail.com>
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

This is on top of commit d02ae3528998 ("Merge branch 'kernel-6.18.clone3'
into vfs.all") in Christian's vfs tree.

This series was run through fstests on fuse passthrough_hp with an
out-of kernel patch enabling fuse large folios.

This patchset does not enable large folios on fuse yet. That will be part
of a different patchset.

Thanks,
Joanne

Changelog
---------
v1: https://lore.kernel.org/linux-fsdevel/20250829235627.4053234-1-joannelkoong@gmail.com/
v1 -> v2:
* Don't pass in caller-provided arg through iter->private, pass it through
  ctx->private instead (Darrick & Christoph)
* Separate 'bias' for ifs->read_bytes_pending into separate patch (Christoph)
* Rework read/readahead interface to take in struct iomap_read_folio_ctx
  (Christoph)
* Add patch for removing fuse fc->blkbits workaround, now that Miklos's tree
  has been merged into Christian's

Joanne Koong (16):
  iomap: move async bio read logic into helper function
  iomap: move read/readahead bio submission logic into helper function
  iomap: rename cur_folio_in_bio to folio_owned
  iomap: store read/readahead bio generically
  iomap: propagate iomap_read_folio() error to caller
  iomap: iterate over entire folio in iomap_readpage_iter()
  iomap: rename iomap_readpage_iter() to iomap_read_folio_iter()
  iomap: rename iomap_readpage_ctx struct to iomap_read_folio_ctx
  iomap: add public start/finish folio read helpers
  iomap: make iomap_read_folio_ctx->folio_owned internal
  iomap: add caller-provided callbacks for read and readahead
  iomap: add bias for async read requests
  iomap: move read/readahead logic out of CONFIG_BLOCK guard
  fuse: use iomap for read_folio
  fuse: use iomap for readahead
  fuse: remove fc->blkbits workaround for partial writes

 .../filesystems/iomap/operations.rst          |  42 +++
 block/fops.c                                  |  14 +-
 fs/erofs/data.c                               |  14 +-
 fs/fuse/dir.c                                 |   2 +-
 fs/fuse/file.c                                | 291 ++++++++++-------
 fs/fuse/fuse_i.h                              |   8 -
 fs/fuse/inode.c                               |  13 +-
 fs/gfs2/aops.c                                |  21 +-
 fs/iomap/buffered-io.c                        | 307 ++++++++++--------
 fs/xfs/xfs_aops.c                             |  14 +-
 fs/zonefs/file.c                              |  14 +-
 include/linux/iomap.h                         |  45 ++-
 12 files changed, 509 insertions(+), 276 deletions(-)

-- 
2.47.3


