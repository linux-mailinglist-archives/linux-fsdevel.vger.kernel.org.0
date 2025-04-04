Return-Path: <linux-fsdevel+bounces-45787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BF2A7C320
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 20:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9353BA556
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 18:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FAA219A90;
	Fri,  4 Apr 2025 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/ayOn7c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881F215DBB3
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743790495; cv=none; b=k/cnUU6fvyO0d/cvpCuxlfpB25SySSrYlg4TC7QQ+LxywTAEXUUnPLg91isUE6rvEeyIepCnoNghmqlImlJJmIYMVUGSx3j7dtl+65FHx3feLD2hEO/Tkwe+XMwTaKYHy7DSTdbl74lbFepxILecz0SdwqxV2uYVecjh9CDnWto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743790495; c=relaxed/simple;
	bh=9Hqqk1GoZMxIjJgyDmuHUXWph483mRGdsuzxtkwvh9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W45gpn+sJAZMoDvX3mpdYuYS/sjhy1/eI4J20G5l/N+fCHWpK0zZS65cEULY+r0JwI+jMFXtP5FH7wAfN1fqIZPbg2IA97jPoJNcmukma0uIUlxfq5udoMaVcAGx1jGolLWxeduEBpFUmLapv32CfdmUWA3OdFnIUDxGC2AMWyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/ayOn7c; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-224341bbc1dso22524525ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Apr 2025 11:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743790492; x=1744395292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aSkmJg5ac6Byx1YjNxRyiIUlORI2T8jiR1BS3qTlfTs=;
        b=H/ayOn7coryTMMrh2vdIoV2xDMt29zTFwifSu8Ma0SuGlObSdJZKhhwUgcvqEZ63CU
         fcNEu/CJM3BslSzXiLWyRxt5zYTF8BVyibuHnLqs3YgU4CPWThKtlBpECJTUDkm+IxBE
         I0wtrVZXuJEMCvzaHTGYmQpR5fdWM+Yzk/LTYndYDV/sXol5TVncYbeZ7jFoPvHtU4/o
         UrOsjhL1QeJdfXHgVKdQsvSbXj/ye/0In6so4+Mfij5Auekw0SEi23y83GSRR3AGugVh
         ZTC4a1bB1WMrlue8ujkaMnfPDVzse+4WB4QseAldEB/OrTXGiSM/s3IfPXPuuDi+27E5
         919A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743790492; x=1744395292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aSkmJg5ac6Byx1YjNxRyiIUlORI2T8jiR1BS3qTlfTs=;
        b=iHbEk2pLEzFS67IAQko2b7HdjiTUn2OmecRBT+BhPg9IEApnyPDB2OKhITUeoJeIQi
         uqIhqKV0Aj/6W5LPc487RFKwvE9YO6ucYY0LlROPLPBdduRiWmQM8w2mkyufv0MI2Hy3
         lwgvYxzzHe4mBCsqIKdjHNVMAWGr1AzdJkP6zut0sRgcVuL1ZXCyIzodyTEkzvL+KwGC
         hIhxsatT4d5ze8sOSjYigJuwzELsUbW6XAc9ZscefhLeUW1Fh6FjqhU1PuCSgEg5ZqM0
         euEgYqJdo1Q/W5MKKdmryu0LB3/UekJPBGZqdmlcC9nl7z5t2/0LDw72CGrT91xBPNj/
         hahA==
X-Forwarded-Encrypted: i=1; AJvYcCXNlZWh4vDnrhKMcjgprsXbkpW7/EIPbEeYTciRvw6csJuv+fsFlshJVMex2n6y/F7UeFYtwBnSuhXwE6tR@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdn50p8Q1ZVo5Z0DNWzz/F/P+XBddaebR/O2ZXvyd6pRf5DEu5
	9/sLAyNdtvFE3NXKlvjfjEN1NK1zXAH/VGMWt74u6RYUrhTKGwjU
X-Gm-Gg: ASbGncszHVEFeA2dqLqcsHVz2cOx9IBN6aajCOAHUUVs7RtKN1d4lKGhEWdr1uLT7bz
	MP20Mn4mOhLO48UtJUCKub3CeVBncgsjzl8YE73zonBYgh3a1uOE5MEvq6N22EHA3IKrcjzq4zv
	JjOsIDgEuIVRtrkWwlBiuk4QEiVSqpq/3do7OCnPzXuNqLDAKfugyGrnNqztV0KDfBwe97Dm4U3
	wKY99UYUJjz1Fg1mA3D5j5PBpIWe1+NDJaQCCtJZkihqJWEO72xL9HHVSWHnrgKLOFJMWISzmPY
	i4sCLR7dRsRDyFBU7pk5R3VbM/hFKhYGQkKv
X-Google-Smtp-Source: AGHT+IHSQAEQV/dX5KqHjaKvV26q7I4AlYPFvdyP8SsLzg/2MiZDHrqrK2H6tGhfXxDyKO9uEtwhEA==
X-Received: by 2002:a17:902:cf0b:b0:220:ea90:191e with SMTP id d9443c01a7336-22a955141b4mr7487475ad.4.1743790491637;
        Fri, 04 Apr 2025 11:14:51 -0700 (PDT)
Received: from localhost ([2a03:2880:ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ad982sm35448425ad.25.2025.04.04.11.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 11:14:51 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Cc: jefflexu@linux.alibaba.com,
	shakeel.butt@linux.dev,
	david@redhat.com,
	bernd.schubert@fastmail.fm,
	ziy@nvidia.com,
	jlayton@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v7 0/3] fuse: remove temp page copies in writeback
Date: Fri,  4 Apr 2025 11:14:40 -0700
Message-ID: <20250404181443.1363005-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The purpose of this patchset is to help make writeback in FUSE filesystems as
fast as possible.

In the current FUSE writeback design (see commit 3be5a52b30aa
("fuse: support writable mmap"))), a temp page is allocated for every dirty
page to be written back, the contents of the dirty page are copied over to the
temp page, and the temp page gets handed to the server to write back. This is
done so that writeback may be immediately cleared on the dirty page, and this 
in turn is done in order to mitigate the following deadlock scenario that may
arise if reclaim waits on writeback on the dirty page to complete (more details
can be found in this thread [1]):
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

In the current reclaim code, there is one scenario where writeback is waited
on, which is the case where the system is running legacy cgroupv1 and reclaim
encounters a folio that already has the reclaim flag set and the caller did
not have __GFP_FS (or __GFP_IO if swap) set.

This patchset adds a new mapping flag, AS_WRITEBACK_INDETERMINATE, which
filesystems may set on its inode mappings to indicate that writeback
operations may take an indeterminate amount of time to complete. FUSE will set
this flag on its mappings. Reclaim for the legacy cgroup v1 case described
above will skip reclaim of folios with that flag set.

With this change, writeback state is now only cleared on the dirty page after
the server has written it back to disk. If the server is deliberately
malicious or well-intentioned but buggy, this may stall sync(2) and page
migration, but for sync(2), a malicious server may already stall this by not
replying to the FUSE_SYNCFS request and for page migration, there are already
many easier ways to stall this by having FUSE permanently hold the folio lock.
A fuller discussion on this can be found in [2]. Long-term, there needs to be
a more comprehensive solution for addressing migration of FUSE pages that
handles all scenarios where FUSE may permanently hold the lock, but that is
outside the scope of this patchset and will be done as future work. Please
also note that this change also now ensures that when sync(2) returns, FUSE
filesystems will have persisted writeback changes.

[1] https://lore.kernel.org/linux-kernel/495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com/
[2] https://lore.kernel.org/linux-fsdevel/20241122232359.429647-1-joannelkoong@gmail.com/

Changelog
---------
v6:
https://lore.kernel.org/linux-fsdevel/20241122232359.429647-1-joannelkoong@gmail.com/
Changes from v6 -> v7:
* Drop migration and sync patches, as they are useless if a server is
  determined to be malicious

v5:
https://lore.kernel.org/linux-fsdevel/20241115224459.427610-1-joannelkoong@gmail.com/
Changes from v5 -> v6:
* Add Shakeel and Jingbo's reviewed-bys 
* Move folio_end_writeback() to fuse_writepage_finish() (Jingbo)
* Embed fuse_writepage_finish_stat() logic inline (Jingbo)
* Remove node_stat NR_WRITEBACK inc/sub (Jingbo)

v4:
https://lore.kernel.org/linux-fsdevel/20241107235614.3637221-1-joannelkoong@gmail.com/
Changes from v4 -> v5:
* AS_WRITEBACK_MAY_BLOCK -> AS_WRITEBACK_INDETERMINATE (Shakeel)
* Drop memory hotplug patch (David and Shakeel)
* Remove some more kunnecessary writeback waits in fuse code (Jingbo)
* Make commit message for reclaim patch more concise - drop part about
  deadlock and just focus on how it may stall waits

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

Joanne Koong (3):
  mm: add AS_WRITEBACK_INDETERMINATE mapping flag
  mm: skip reclaiming folios in legacy memcg writeback indeterminate
    contexts
  fuse: remove tmp folio for writebacks and internal rb tree

 fs/fuse/file.c          | 360 ++++------------------------------------
 fs/fuse/fuse_i.h        |   3 -
 include/linux/pagemap.h |  11 ++
 mm/vmscan.c             |  10 +-
 4 files changed, 46 insertions(+), 338 deletions(-)

-- 
2.47.1


