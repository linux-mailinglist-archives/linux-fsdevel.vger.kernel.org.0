Return-Path: <linux-fsdevel+bounces-59681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FD7B3C5C4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 01:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A471B176E57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7806C2D6E6D;
	Fri, 29 Aug 2025 23:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J72c18n8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70869481B1;
	Fri, 29 Aug 2025 23:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756511898; cv=none; b=FvGsIsFog8V6icf2EAytA9usIaXSLFUTIL57+0UhgXx8BpPbrmiKx9vlfugyWAICplOubkLlavEzr9rVjeg9arelew7uE51RslUk0qpQdZvEtZcAp3z/U++UTtINrEYpFFIZIXroqr3Lljme1uN8Kv9eJBk+IWwYdz9TogTEp7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756511898; c=relaxed/simple;
	bh=vl9c4kTqz3SLLw+rED+J2iTTKawi9sEI6T5kGcU+gcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZVz6Pgw3HxBP+umqEUKIB+/vw88n8tZZGLrkRGEQejS3DWaBL+1/VBdQXCBTICGnU7A55qS3H28qCG6V1rhABBv5pobuOO11bZy4+syAiXUqlv7oUNNrWKzj32Ua7KSPoA34Ybzdzvbzi4BgUP7twvSZ1v/xYbNxdzX6CBRIDKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J72c18n8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-244582738b5so24087055ad.3;
        Fri, 29 Aug 2025 16:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756511897; x=1757116697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bLmwB6KBsGlj2aG6bie9QMntRArOGpl+oVFWR1t8ZFs=;
        b=J72c18n8G6ZYvzGzMhChtayIEEidviafKWE0bjIvAUouKe8SpmTjUfNFPofHPzVnHq
         AnWN8b7EGAtoRv5PmLJlhDb4Nilrg/ZUJYTEMugiX7RXxxmkWq5OlAG2eL5+0+YPTdLo
         5e2/bKndq6csHa3P89/FJa+mdoE9Poa6WyDHBrHRGa18mpoILaQmWJVjB+CoZQLsV/+Y
         9wTdOM6FC0VdHRP6fO8O52XoRLPObmppul0qua/Vdc8EC5mYNyfHhSYRiXuHCJg9Dhdn
         Bd3ahtz/jFqO0PxrOric4mksl0NTtGcTV86Rm4xIrymeEnuyaMazsblioWtfwzikwtln
         HIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756511897; x=1757116697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bLmwB6KBsGlj2aG6bie9QMntRArOGpl+oVFWR1t8ZFs=;
        b=QWG3wtMVMVduPo2mo3J7dkPnhlapsTVlXtAXK2U5v8q1Jnz/36T59kmQCmO9cIf4zS
         2tmGzy2dYu9UiGMtlOtH2pnxwRmoj83SaYpDb6NhH9o+uWPJq8AQq4Ga7N5FoDVHIy22
         HvI8xi/VYPVpE2+Rs7ck3pKiTnxwi9vvFhSELWRU7AqarCnUW105dioK8sCELDryNcZ3
         56NFMtpx4M8Iv+dFNFnvLNy+iou/BppI/hiM5h1dO+GJOh0yXqOWVUjZqTeZFufsHZNh
         Kjm8fFwmXSRQwdDyNW1zHp9eyp2rNZ2kArD8TtFXyRTx7quyTJhQdgLNSUX/SvFXnriV
         K+lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu175uhWDYSoAFW+sLdxCNZjKvkwA/2U6rZU3XOxo9AkNr4JKs8TojPYQ1JnxDP0xN7Bj4y4/QGx+Ng9w2Tw==@vger.kernel.org, AJvYcCX4x2wW3sNeMVkLfg/PeKLCOjqg4EA9JZ/S6vw3QmB1yxJvtz1exY3xs4wLSlaVA3nOxaRzPGClwZ8=@vger.kernel.org, AJvYcCX7sGYG2dFw5Wd4vqbOVZ307AwlBk5aoNx64hAyw+jGFfMUtEeHa9JnD0POiT3xEC3pbc2SUEsFtG4J@vger.kernel.org
X-Gm-Message-State: AOJu0YzEzFnwKHxlZumW0OFUakrkbJTNzZ+jU7NR643mrfmMHguB5obG
	yeGm0giDrdUQgxoNUNN46w5pZmoxzLDNTjxevboL9c+EgbDRiJsO9Uk3
X-Gm-Gg: ASbGnctQ72EZDXq+LSH+/WH8hiaq5Lz8cxBSNqA9qB/fLYN1LkfutaoettMCM1HyIbZ
	8ZEjDYqjRxS5zNQxriuS5FDbKG4uIUTEVSTeoOPt6wQgrR/tX15jr3hIQv9A3jikaJfc66JAO3K
	IAR4Y341SKRnfW1qTE0qOXeqWTJErPPqE/sXxfMZIp8CHJxr8Wk1f2KgI8KsOTIGJQLlmyNJ3wx
	0FlO+AkCx0rCxcuIv0CVqPCEsFP+c8iui9h+XWzilgLVoS7NagKbdW1KvQ89GGYY7WFaa/lctDG
	mkHhVeK5KD2u0wbvf0nrI9LzXluhhbEcbVDRm/30ugHHN1QRpapSbbTShuetZiwydmKl1Qs13NA
	GLTHdAgZ67sRxrailYA==
X-Google-Smtp-Source: AGHT+IGnmMqqlzwM9mrNGPUNp9GAQTzB7+anrvFRmDh84yoGPBWyLuckp9pOut3whPAzUyXjbtDHdg==
X-Received: by 2002:a17:903:1a2e:b0:240:52c8:2564 with SMTP id d9443c01a7336-24944a0f8fcmr4978255ad.26.1756511896630;
        Fri, 29 Aug 2025 16:58:16 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1a::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249066e1158sm36172585ad.144.2025.08.29.16.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:58:16 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v1 00/16] fuse: use iomap for buffered reads + readahead
Date: Fri, 29 Aug 2025 16:56:11 -0700
Message-ID: <20250829235627.4053234-1-joannelkoong@gmail.com>
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
large folios are enabled so that only the needed portions of the folio need to
be read in instead of having to read in the entire folio. It also is needed in
order to turn on large folios for servers that use the writeback cache since
otherwise there is a race condition that may lead to data corruption if there
is a partial write, then a read and the read happens before the write has
undergone writeback, since otherwise the folio will not be marked uptodate
from the partial write so the read will read in the entire folio from disk,
which will overwrite the partial write.

Part of this work is modifying the iomap interface to support non-bio
reads and to work on environments that do not have CONFIG_BLOCK enabled,
which is what patchsets 1 to 6 do.

This is on top of commit 4f702205 ("Merge branch 'vfs-6.18.rust' into
vfs.all") in Christian's vfs tree.

This series was run through fstests on fuse passthrough_hp with an
out-of kernel patch enabling fuse large folios.

This patchset does not enable large folios on fuse yet. That will be part
of a different patchset.

Thanks,
Joanne

Joanne Koong (16):
  iomap: move async bio read logic into helper function
  iomap: rename cur_folio_in_bio to folio_unlocked
  iomap: refactor read/readahead completion
  iomap: use iomap_iter->private for stashing read/readahead bio
  iomap: propagate iomap_read_folio() error to caller
  iomap: move read/readahead logic out of CONFIG_BLOCK guard
  iomap: iterate through entire folio in iomap_readpage_iter()
  iomap: rename iomap_readpage_iter() to iomap_readfolio_iter()
  iomap: rename iomap_readpage_ctx struct to iomap_readfolio_ctx
  iomap: add iomap_start_folio_read() helper
  iomap: make start folio read and finish folio read public APIs
  iomap: add iomap_read_ops for read and readahead
  iomap: add a private arg for read and readahead
  fuse: use iomap for read_folio
  fuse: use iomap for readahead
  fuse: remove fuse_readpages_end() null mapping check

 .../filesystems/iomap/operations.rst          |  19 ++
 block/fops.c                                  |   4 +-
 fs/erofs/data.c                               |   4 +-
 fs/fuse/file.c                                | 298 +++++++++-------
 fs/gfs2/aops.c                                |   4 +-
 fs/iomap/buffered-io.c                        | 321 +++++++++++-------
 fs/xfs/xfs_aops.c                             |   4 +-
 fs/zonefs/file.c                              |   4 +-
 include/linux/iomap.h                         |  24 +-
 9 files changed, 412 insertions(+), 270 deletions(-)

-- 
2.47.3


