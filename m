Return-Path: <linux-fsdevel+bounces-33981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41339C12C9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 00:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EE3CB2278F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 23:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F291A1F4FAC;
	Thu,  7 Nov 2024 23:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPeY4JGS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5271F4264
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 23:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731023790; cv=none; b=Mabu5BnCUQfqzWSneBT3CKcRyP9rDZJ4R1aR7q4770+qMVCQzT0xlJy2a+641A+rYuAjmKGyteyj3qm66QWIdfZLIjRYpcL6LdxOYz+XJQFQe4/9jQwBgZFAzzh6x80Vm+lOp47Ttmu7NpNIUwBFTX4NbNK9sKdukSYvbsU3rz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731023790; c=relaxed/simple;
	bh=PMEazXzP6M0UPy5TWy4F2vUNWcKJD+S50WZksER41Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pza43sXIf0RDGlbWdubNolNKzunUPYQ7r1RDIzkbM7BNtNeWk/JojbASwoXvFNRFFwe3+g/PC9UlBMzwxtcjU+wPFAQXTX3bIxI5a1sq/2TpCLpWOEik2BuiL1nzFd+7YXwE+48oWsYZazWlXquqd0J0cdHYUy+uWIXBMPMwKRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPeY4JGS; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e30d0d84d23so1451809276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2024 15:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731023788; x=1731628588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V3jh+zXPjAH8B5UH7TxKcV2Z2agxWj09beON9xy7gjs=;
        b=KPeY4JGSZESQjHaYcnX4bXuCJBQNuhUBgskvsnu7k/1Gjjb18m6+STwhcC4fssf/vp
         UUN30nehDm1vM71BYUqWqJkeJRqIcWg4Tll4VwE1mJTLjVtjjZEV+LdRtVZHCecTWPdB
         E0f8dlMcA4GjlVmk85GPHS1399rnOY5YLgtVsx5B/1B6do2bCP3r0yfqKJUt4+XGltZe
         mNizgqpcKbJ6c6gDWwDGx0xGk1jkuq8XHwYW078tmHysZqRKAPa5ejp4fTb72SX5zLEN
         yvXaB03K3wKM/DD22paRxAoPvCedQ2C9BE2HOpHEsfQxOdvYCleLANEU8/QOMKrYyPq+
         uA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731023788; x=1731628588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3jh+zXPjAH8B5UH7TxKcV2Z2agxWj09beON9xy7gjs=;
        b=YiDKzz7ENxCWs5JZbASc+UNZu7+hpxetgZm4Ib4Dg7EwGNjY2Lt3PPVbAw15eLbOkZ
         +IlWG+iDyqN8isdWfdCcoX9A8Pd7fpBN52I0VVg5avOuj2hWQ+W8PZZtshmR/4wzfPJr
         i1JvE5yqlhGQzaujlG27HVFN+S1mn/EhBOXf74Tuw56RRfUHNclQNG431w2K8Gt/ykl5
         /ghePvMBKfarDQVZu5kQSOUMvDrc72F0npkFODio/SHcLGLQAtFBVhBKrLl4Qh8uDgg/
         wsTqC0dTts8wOwGnGNIDGvyzNx+t0FkYWV5RXKEVw64hxPpxHwW4MH9GD5Q1JOCpgFfH
         jh0g==
X-Forwarded-Encrypted: i=1; AJvYcCV8ibgoGVzRqwb6R17BaTEaifwMYX/je/bkhfwoqJ+yypirQbtLUwyDw1CncO3LRGLzBq8A080dQiMI7av7@vger.kernel.org
X-Gm-Message-State: AOJu0YwsbWJXlgHORbPlHFwc4Gj8KWqdsEXxrICxA2mLmEhDJUE/yqZm
	Zzf7AcBRI5RhOHm/nbvak76643b7MPq/cFqfnaJ65GG7e3wImDQa
X-Google-Smtp-Source: AGHT+IHAJfLgCEcVPQgLi9Kit0YVBYjIC3gw+daVe5E2PG27h0cJnecO/WA7oHuw4flyoEPWA1d2Ng==
X-Received: by 2002:a05:6902:1684:b0:e33:1486:79e1 with SMTP id 3f1490d57ef6-e337f8fe504mr1024382276.43.1731023787572;
        Thu, 07 Nov 2024 15:56:27 -0800 (PST)
Received: from localhost (fwdproxy-nha-011.fbsv.net. [2a03:2880:25ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336ee20911sm456732276.8.2024.11.07.15.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 15:56:27 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	linux-mm@kvack.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v4 0/6] fuse: remove temp page copies in writeback
Date: Thu,  7 Nov 2024 15:56:08 -0800
Message-ID: <20241107235614.3637221-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The purpose of this patchset is to help make writeback-cache write
performance in FUSE filesystems as fast as possible.

In the current FUSE writeback design (see commit 3be5a52b30aa
("fuse: support writable mmap"))), a temp page is allocated for every dirty
page to be written back, the contents of the dirty page are copied over to the
temp page, and the temp page gets handed to the server to write back. This is
done so that writeback may be immediately cleared on the dirty page, which is
done in order to mitigate the following deadlock scenario that may arise if
reclaim waits on writeback on the dirty page to complete (more details can be
found in this thread [1]):
* single-threaded FUSE server is in the middle of handling a request
  that needs a memory allocation
* memory allocation triggers direct reclaim
* direct reclaim waits on a folio under writeback
* the FUSE server can't write back the folio since it's stuck in
  direct reclaim

Allocating and copying dirty pages to temp pages is the biggest performance
bottleneck for FUSE writeback. This patchset aims to get rid of the temp page
altogether (which will also allow us to get rid of the internal FUSE rb tree
that is needed to keep track of writeback status on the temp pages).
Benchmarks show approximately a 20% improvement in throughput for 4k
block-size writes and a 45% improvement for 1M block-size writes.

With removing the temp page, writeback state is now only cleared on the dirty
page after the server has written it back to disk. This may take an
indeterminate amount of time. As well, there is also the possibility of
malicious or well-intentioned but buggy servers where writeback may in the
worst case scenario, never complete. This means that any
folio_wait_writeback() on a dirty page belonging to a FUSE filesystem needs to
be carefully audited.

In particular, these are the cases that need to be accounted for:
* potentially deadlocking in reclaim, as mentioned above
* potentially stalling sync(2)
* potentially stalling page migration / compaction

This patchset adds a new mapping flag, AS_WRITEBACK_MAY_BLOCK, which
filesystems may set on its inode mappings to indicate that writeback
operations
may take an indeterminate amount of time to complete. FUSE will set this flag
on its mappings. This patchset adds checks to the critical parts of reclaim,
sync, and page migration logic where writeback may be waited on.

Please note the following:
* For sync(2), waiting on writeback will be skipped for FUSE, but this has no
  effect on existing behavior. Dirty FUSE pages are already not guaranteed to
  be written to disk by the time sync(2) returns (eg writeback is cleared on
  the dirty page but the server may not have written out the temp page to disk
  yet). If the caller wishes to ensure the data has actually been synced to
  disk, they should use fsync(2)/fdatasync(2) instead.
* AS_WRITEBACK_MAY_BLOCK does not indicate that the folios should never be
  waited on when in writeback. There are some cases where the wait is
  desirable. For example, for the sync_file_range() syscall, it is fine to
  wait on the writeback since the caller passes in a fd for the operation.

[1]
https://lore.kernel.org/linux-kernel/495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com/

Changelog
---------
v3:
https://lore.kernel.org/linux-fsdevel/20241107191618.2011146-1-joannelkoong@gmail.com/
Changes from v3 -> v4:
* Use filemap_fdatawait_range() instead of filemap_range_has_writeback() in
  readahead

v2:
https://lore.kernel.org/linux-fsdevel/20241014182228.1941246-1-joannelkoong@gmail.com/
Changes from v2 -> v3:
* Account for sync and page migration cases as well (Miklos)
* Change AS_NO_WRITEBACK_RECLAIM to the more generic AS_WRITEBACK_MAY_BLOCK
* For fuse inodes, set mapping_writeback_may_block only if fc->writeback_cache
  is enabled

v1:
https://lore.kernel.org/linux-fsdevel/20241011223434.1307300-1-joannelkoong@gmail.com/T/#t
Changes from v1 -> v2:
* Have flag in "enum mapping_flags" instead of creating asop_flags (Shakeel)
* Set fuse inodes to use AS_NO_WRITEBACK_RECLAIM (Shakeel)

Joanne Koong (6):
  mm: add AS_WRITEBACK_MAY_BLOCK mapping flag
  mm: skip reclaiming folios in legacy memcg writeback contexts that may
    block
  fs/writeback: in wait_sb_inodes(), skip wait for
    AS_WRITEBACK_MAY_BLOCK mappings
  mm/memory-hotplug: add finite retries in offline_pages() if migration
    fails
  mm/migrate: skip migrating folios under writeback with
    AS_WRITEBACK_MAY_BLOCK mappings
  fuse: remove tmp folio for writebacks and internal rb tree

 fs/fs-writeback.c       |   3 +
 fs/fuse/file.c          | 339 ++++------------------------------------
 include/linux/pagemap.h |  11 ++
 mm/memory_hotplug.c     |  13 +-
 mm/migrate.c            |   5 +-
 mm/vmscan.c             |  10 +-
 6 files changed, 60 insertions(+), 321 deletions(-)

-- 
2.43.5


