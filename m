Return-Path: <linux-fsdevel+bounces-34992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DA59CFAFA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 00:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02BE1B2F4EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 22:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656FA191F94;
	Fri, 15 Nov 2024 22:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZOxB0zy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDBF191493
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 22:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731710816; cv=none; b=EXtkEm5ZmkEPDaBNqhNoVqDRA44TKAlkcz2znDaPbK1phIaSMg8IA741+BlqX9ST1PfDezsyBe3Jl+Z7OmEbL01w6QslsAU9QZJt8xbQ9tUZfjtQsTQSmMs+Z/T+2y6XteJ0yviqcEjnlfv2pTGzipEbw6RfHlNKLJwDUqpCz10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731710816; c=relaxed/simple;
	bh=jlyowYdr/t8RPv/74E08SFHtThEnUkw/IkI5JhIR6t4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VQerX88zCPi1GsPpusj6QN+3M3QXezmfZG4Mrbp4KIHLd+U4eKWyUHK7wye2vMKrltVW+VnQRYVH6nEeszIWmgrenGatpFd75z8FSkxT9k0BnW+PVJZBtdDXiXELdQGtcmRTDTF9MjMYhEUg9hgjXSwwqKg6p+dcoYXw82Zn4U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZOxB0zy; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ea15a72087so11189277b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 14:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731710814; x=1732315614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=710TuHEiZSo6JI5Ld9IOzGZQ5MPqx7fEXflm4wt35AA=;
        b=IZOxB0zyk/HzTt41E/3Gpdd/SDPkuIYXrDuaNjpeeZFJ9wpTd/q8HhhJW8Desqf6ll
         RkZor+6c96OmP7eqtiRw1mmE9ZOXRcik/CZZyHKpoAdqKzfcJDsr5Bj1Pz3loVNUixvh
         mrFOOv0DLGcTBj46ANzAZamqOBilaOZA1+k06YHEEXwSYtCCL15DPBcl2FcRO7TyavIp
         tRB+IjO5UiTjFKgaw+saeqsS2gsbBBAIM5CPPZgVsitVOjbh+wAQ2ijqC81jsFBTh0Uv
         kbeyx4kgBbLjmc5i+acD9iFFSd+n5jhGTEE7HVCsWUyf4+tXEMCaEXoG8kj+Y+jzOP7U
         dp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731710814; x=1732315614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=710TuHEiZSo6JI5Ld9IOzGZQ5MPqx7fEXflm4wt35AA=;
        b=AbKkOUtZ3/vw3bQ3bvKJOT1M/RMjf8p2VPRZ2ZytY5gvPZNAOlz9DoFzzDMapMH1pF
         pvL3/KXYT0qOrDof4xNNb3IBvza4AJtJj1+L8QRwgq0xk1kkkvZLXLzMK8W1yFXCiiJK
         gq5I8writxppoAy99mBHt21RSzTbRWCX86NcHc2tVVT3EqppW9y4+xO6h4pQLHupu4KG
         Nercks2YWWAl4utzRGblEVNzL9z9pkdYW1YRqxg3tZesvemiCY4FFPss6p+Pay7rdjCM
         vR6htB6bZrVCtVTfOtk99Xgb40g3Qknk38MF15af6s5DXQNINFz1U8k1AZ8zXEO1/5O1
         cv/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVd0NibnASPS9OIKdw6ZTWVN3JwXKbMKXofC6We0aTOQ/KkwTdsuMiNrzySY0y/6UTfBvkZBgS4ZGea26CL@vger.kernel.org
X-Gm-Message-State: AOJu0YylUAq6ZD6z6e7XA6PBMpgdFXvwK1r8CdQbFqQwRU2c9T8lMg3F
	Xgw6bDaW3r2Cg6qfdkH6QJI3FVT+CWCb2S8ssi6z3PLcZeiXKw3ydjfE8w==
X-Google-Smtp-Source: AGHT+IGBQ3lcs9flGIlvjHdkHlY367LoO797EM5zdqL1aHzzI1E/+vB/7X98/euZDYslVVqMiLq5FQ==
X-Received: by 2002:a05:690c:7246:b0:6e3:34b9:960a with SMTP id 00721157ae682-6ee55b7e645mr48549607b3.17.1731710813924;
        Fri, 15 Nov 2024 14:46:53 -0800 (PST)
Received: from localhost (fwdproxy-nha-001.fbsv.net. [2a03:2880:25ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee712c2948sm856187b3.51.2024.11.15.14.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 14:46:53 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	linux-mm@kvack.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v5 0/5] fuse: remove temp page copies in writeback
Date: Fri, 15 Nov 2024 14:44:54 -0800
Message-ID: <20241115224459.427610-1-joannelkoong@gmail.com>
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
done so that writeback may be immediately cleared on the dirty page, and this 
in turn is done for two reasons:
a) in order to mitigate the following deadlock scenario that may arise if
reclaim waits on writeback on the dirty page to complete (more details can be
found in this thread [1]):
* single-threaded FUSE server is in the middle of handling a request
  that needs a memory allocation
* memory allocation triggers direct reclaim
* direct reclaim waits on a folio under writeback
* the FUSE server can't write back the folio since it's stuck in
  direct reclaim
b) in order to unblock internal (eg sync, page compaction) waits on writeback
without needing the server to complete writing back to disk, which may take
an indeterminate amount of time.

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

This patchset adds a new mapping flag, AS_WRITEBACK_INDETERMINATE, which
filesystems may set on its inode mappings to indicate that writeback
operations may take an indeterminate amount of time to complete. FUSE will set
this flag on its mappings. This patchset adds checks to the critical parts of
reclaim, sync, and page migration logic where writeback may be waited on.

Please note the following:
* For sync(2), waiting on writeback will be skipped for FUSE, but this has no
  effect on existing behavior. Dirty FUSE pages are already not guaranteed to
  be written to disk by the time sync(2) returns (eg writeback is cleared on
  the dirty page but the server may not have written out the temp page to disk
  yet). If the caller wishes to ensure the data has actually been synced to
  disk, they should use fsync(2)/fdatasync(2) instead.
* AS_WRITEBACK_INDETERMINATE does not indicate that the folios should never be
  waited on when in writeback. There are some cases where the wait is
  desirable. For example, for the sync_file_range() syscall, it is fine to
  wait on the writeback since the caller passes in a fd for the operation.

[1]
https://lore.kernel.org/linux-kernel/495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com/

Changelog
---------
v4:
https://lore.kernel.org/linux-fsdevel/20241107235614.3637221-1-joannelkoong@gmail.com/
Changes from v4 -> v5:
* AS_WRITEBACK_MAY_BLOCK -> AS_WRITEBACK_INDETERMINATE (Shakeel)
* Drop memory hotplug patch (David and Shakeel)
* Remove some more kunnecessary writeback waits in fuse code (Jingbo)
* Make commit message for reclaim patch more concise - drop part about deadlock and just
focus on how it may stall waits

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

Joanne Koong (5):
  mm: add AS_WRITEBACK_INDETERMINATE mapping flag
  mm: skip reclaiming folios in legacy memcg writeback indeterminate
    contexts
  fs/writeback: in wait_sb_inodes(), skip wait for
    AS_WRITEBACK_INDETERMINATE mappings
  mm/migrate: skip migrating folios under writeback with
    AS_WRITEBACK_INDETERMINATE mappings
  fuse: remove tmp folio for writebacks and internal rb tree

 fs/fs-writeback.c       |   3 +
 fs/fuse/file.c          | 339 +++-------------------------------------
 include/linux/pagemap.h |  11 ++
 mm/migrate.c            |   5 +-
 mm/vmscan.c             |  10 +-
 5 files changed, 45 insertions(+), 323 deletions(-)

-- 
2.43.5


