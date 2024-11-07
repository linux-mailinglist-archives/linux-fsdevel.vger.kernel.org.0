Return-Path: <linux-fsdevel+bounces-33948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6049C0EB9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 20:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8CC1F27BDC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 19:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE9C502B1;
	Thu,  7 Nov 2024 19:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ufwyrp2Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03564186E58
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 19:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731007044; cv=none; b=hE+04rpfrjF245fu+GGKjwuNrbH0nJBxtsN5zNjy9mTy5S4RRjxJlCxxieZZYxEUNwHTodKVlIpCwRfFZTE0Bw6T7wpZ49LOEN2l8gplrR5Jt9F4UbnXhZD/hi64MlHWPHpfgp77S6bwQ36ooTfBvIX19YaiIm57mv1zDWKoR7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731007044; c=relaxed/simple;
	bh=ydpckOyCYzdgoMi1jJXzDZzh51c1ff9QhzqQEQqZRhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IdYYPDdEO2OBH3FcDeSk2vcL0iHIx7gzjp+6qwhgaMsuhxGbGUn6kk9Ug39/06pH2imaUmufywpXRmcwweK2ijnB3HarhGbX2p6I6zybJDtL+gGSiD+GBMmd7C2sj0MWZ5pwOwbRM3jYTaVPfumrblEKik8ZKAtUz0aS+rlGrAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ufwyrp2Y; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e30d212b6b1so1279428276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2024 11:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731007042; x=1731611842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pxi6yoj64cQ9czpC+D4wrwOjjSzqAojTERl6ENP/U04=;
        b=Ufwyrp2Y92A2H2/LwCUPLPOtmBGlYehCNU6M5w3jqxtujCIUXILXWFxYOEUl8GRN/Z
         pjLqUi4LMI+Y6Kv6Sd96vVqEldlrqxmXhYWJ1r+J+VGUQhDDuZ1JBgNmKp0UKpFVUEl/
         qmKlX86gkqga2164lE2t4SjIND12h73GHbVOZlOPAEt7XvUe3IPxiR9nAwckr4vGbyGq
         g3igklzvUSSbfete3FZY/CM3MNSxC8GtKrVxpBOZ3nkH39b3I+tnaNo9t360j0t6DlX/
         Xp6Qa2GG84b90dJZcdxqLJ7GWjIShWvwu78PizWJtFuI5RroM7H7CA3xdNmZdStg+Dny
         Oisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731007042; x=1731611842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pxi6yoj64cQ9czpC+D4wrwOjjSzqAojTERl6ENP/U04=;
        b=S4yTyu7U9XRxHZ3SfskoILl0+nxtA/gVIxAErT5ryarvNAmjgWFU4DDOdWOuzQuRK7
         oDuEYF84BFju1GIk1Y3Qaj3p/Sky9GUSgjnAeTiKmPrK0a2qDW1bur+LRc0iZ2xxDbGz
         YNjLTL5+QCyD/hZfZyVpIsnVPpV/dHd5DLF47Za4v/ie1KYJ75J+pBV2EhKNvyV6u/Ub
         qOQPu/1vm4swX2uzDifxs/rZ9Q5FVM0CkM5k8HGXlA51F4EyKBRzY1+dJX4huopj2KFz
         diN2pvh1bDw1JUrKJ8fbWNc5FKQVDufkg0hLcIgoieHgn6slVdDpsuMSZn9sxtreisqo
         tk5g==
X-Forwarded-Encrypted: i=1; AJvYcCWBUrw96ebu/HkNvWuMhK6W3vXJQOzfP+zitcs1lklLiAyOD60CtbIwmEvWGButWy6hOAaQ8tDZmufXJorC@vger.kernel.org
X-Gm-Message-State: AOJu0YzvbnykbZjz2A9AheIPGGMfbrwFMX9sKh2bKeyxHuFIiLYM2SbF
	3R56I6sLKes1762fywdl0mRQwOlua2+2uAisip2QqOBJcqqpVuoS
X-Google-Smtp-Source: AGHT+IG1WGDh4ehAkF86pveSou4rq40tAmvLsS+TVJw87dAgZSm9fauqWKEk7n0I6v+B9dgJSTfFQw==
X-Received: by 2002:a05:6902:c0d:b0:e30:cc34:af19 with SMTP id 3f1490d57ef6-e337f8d8ecdmr118363276.44.1731007041892;
        Thu, 07 Nov 2024 11:17:21 -0800 (PST)
Received: from localhost (fwdproxy-nha-112.fbsv.net. [2a03:2880:25ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336f1baaefsm369047276.44.2024.11.07.11.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 11:17:21 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	linux-mm@kvack.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v3 0/6] fuse: remove temp page copies in writeback
Date: Thu,  7 Nov 2024 11:16:11 -0800
Message-ID: <20241107191618.2011146-1-joannelkoong@gmail.com>
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
filesystems may set on its inode mappings to indicate that writeback operations
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

[1] https://lore.kernel.org/linux-kernel/495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com/

Changelog
---------
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
 6 files changed, 61 insertions(+), 320 deletions(-)

-- 
2.43.5


