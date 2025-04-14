Return-Path: <linux-fsdevel+bounces-46418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01084A88EFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 00:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0101617BFD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 22:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186281F3B8B;
	Mon, 14 Apr 2025 22:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxL27rtr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C2A1F12FF
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 22:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744669352; cv=none; b=tMMnxOyVIHmO3gNTP/6HzJkt6rQ+cnUYvKczXI9NO9mPTC52DZscOPXiq8VDiwzY9bRxJBY5UE2+2UdGc4m7UBQ6mWLnxBQJg0L4g4xOwGC3s6AZnE89g7Y3S80qsc+vpOnOk6pTVqyBLEzcRI+BQf3agJo4p50Aq0rkdXMEtoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744669352; c=relaxed/simple;
	bh=gKFj4V5RWmPnYDF+s6acXjzdHG6u7RioUhxmlG/l4NA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HslfO70bMt2wUuBDcNFmCWwyy+3fUFsrJSHtjqAOdRAUYgEQyw35HqOc8sZWwDm+xs/7Y7fP0zEh6aLlej634mLJp9dOybMFFMUUpnpCbSHWyXJFsRL5DKUr8XzlFNPkLFiY2vPeAQBxtHlQln3gps68KQvy44U+dzWTqIu3j8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxL27rtr; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736c062b1f5so3988600b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 15:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744669350; x=1745274150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CXyTK49lUIGEYMX0uNAmIhRrzBLysbx4YJ2RpRUIBEY=;
        b=IxL27rtrhxMwko22kV8M5bOWnrsquUueEW5R9LzFw/7hALk+eXQXzMliRuI+HuddnK
         bBl60FaAhMjvvx4LveRuMGRjTvj9CrtYhwx8Uc3iCaRfANfdfreSNBNgUasksN6fJo4z
         hBETCWlVUpm1b6mLAFQbGXmWFfjLtynoewb++SioNPvz+BESCgMxxk6dPQyJvjUPwmZr
         losWVUD1PJdad4FYI98UZxHRMnlQxjo+dc9+Fv1gIhTGJxPicmJYR5N7F88SD6XoPgxU
         ueQXXe3EC9NdhP9AT9B4bcl6z3WS2UQw3UiHA2RbHzgsbJh0JYt3TuU5wRal51DgvEhV
         KdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744669350; x=1745274150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CXyTK49lUIGEYMX0uNAmIhRrzBLysbx4YJ2RpRUIBEY=;
        b=VsBOt2icICZZvf1zXeM8toybm1mOJ0hKRmitSdB86/oxpJ19Il1Wv4fJ82FGqt5tmy
         eQ1B+bwWLA7tKwzdbiUVtHD4hzgXisEc6N7KTEqxJyz0nrAFJFBiG1EXDwgVDN9NQWfv
         6TkegMJafmVAKefNAs6vVYqEDPzfTwWyS4LK35KC2R95M+1H+upV+fjdsRbuVE3uD3ir
         8PEGvEkxyey2XMPxPgCFkbrLMlK8nG2Msj4iEZTOs/x1//Ksw7MLv2CY4+v9Fb0uiNdM
         WArh9gWSIMtcvB7aJ7SIUX9BGLzlKbG5hSqVy6URxRuV+gSv33+h2qxLgyKz5OcW5fRz
         /olQ==
X-Forwarded-Encrypted: i=1; AJvYcCWruivKvUja0WgY7+Kfa8tZkC0sS8ZhMD0Yac1H4mEksJzb0JrvrVAwTwCEEsStoOrQj1VfUfUcBphCEZXx@vger.kernel.org
X-Gm-Message-State: AOJu0YwfVoHlSFsuyI2+tmqhS6lFoPY9sehjGaQf8HZD5cSPRgmQHMGp
	/bH8402j+R4eMOldjbraMMhYeLztxdrJDQ3tG4BPhhB6wvgSXGuF
X-Gm-Gg: ASbGnctWQ68tOiwfHvZ4H5uQFmn+pyqzjjeW05Q+xwI91aQIBXdhNyn29ip+8/tV9zO
	O1LybvyWygZZFtd1/qlEkbIq3uDvxKwGm74MVRsVE3YjXXdnbpoQg5YYjXnU3ibtLeYrxHWWv+D
	RgK5sJ4bX9rjsHYy9gWiu71HEmyEX+RSTY2NyK3oC8+zvwqZNiQpCBeDBe5lK/L/XlvEydZoTY+
	aO3Ohc+NUeqJo0NBUEVk518iyM2oh1hQFPtKqiiKDuqAYFA4Jn3+GRJ0IvvRC7h1OjjV1TKkS5k
	lBtDOpz2fcfwCkm4FO8mzg6n3oWRcuWLO9A=
X-Google-Smtp-Source: AGHT+IG2FugvAZ+utBclVT+TiH0mbGXIvsffVv0W7/ugtCZZzFMpzNcwBH38C4sdRes4hKTNPlETAA==
X-Received: by 2002:a05:6a00:3d4b:b0:736:55ec:ea8b with SMTP id d2e1a72fcca58-73bd12c94d3mr21082350b3a.24.1744669350029;
        Mon, 14 Apr 2025 15:22:30 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a0cf3604sm9873735a12.25.2025.04.14.15.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 15:22:29 -0700 (PDT)
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
Subject: [PATCH v8 0/2] fuse: remove temp page copies in writeback
Date: Mon, 14 Apr 2025 15:22:08 -0700
Message-ID: <20250414222210.3995795-1-joannelkoong@gmail.com>
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
arise if reclaim waits on writeback on the dirty page to complete (more
details
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

This patchset adds a new mapping flag, AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM,
which filesystems may set on its inode mappings to indicate that reclaim
should not wait on writeback. FUSE will set this flag on its mappings. Reclaim
for the legacy cgroup v1 case described above will skip reclaim of folios with
that flag set. With this flag set, now FUSE can remove temp pages altogether.

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

For this patchset, it would be ideal if the first patch could be taken by
Andrew to the mm tree and the second patch could be taken by Miklos into the
fuse tree, as the fuse large folios patchset [3] depends on the second patch.

Thanks,
Joanne

[1]
https://lore.kernel.org/linux-kernel/495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com/
[2]
https://lore.kernel.org/linux-fsdevel/20241122232359.429647-1-joannelkoong@gmail.com/
[3] 
https://lore.kernel.org/linux-fsdevel/20241213221818.322371-1-joannelkoong@gmail.com/

Changelog
---------
v7:
https://lore.kernel.org/linux-fsdevel/20250404181443.1363005-1-joannelkoong@gmail.com/
Changes from v7 -> v8:
* Rename from AS_WRITEBACK_INDETERMINATE to
  AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM (David) and merge patch 1 + 2
* Remove unnecessary fuse_sync_writes() call in fuse_flush() (Jingbo)

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

Joanne Koong (2):
  mm: skip folio reclaim in legacy memcg contexts for deadlockable
    mappings
  fuse: remove tmp folio for writebacks and internal rb tree

 fs/fuse/file.c          | 364 ++++------------------------------------
 fs/fuse/fuse_i.h        |   3 -
 include/linux/pagemap.h |  11 ++
 mm/vmscan.c             |  12 +-
 4 files changed, 48 insertions(+), 342 deletions(-)

-- 
2.47.1


