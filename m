Return-Path: <linux-fsdevel+bounces-35616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F269D664A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 00:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E283E281EB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 23:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFCC198E7B;
	Fri, 22 Nov 2024 23:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzJ39YKp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D0018A94C
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 23:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732317866; cv=none; b=QQwDNvBSKROpyVPVr09IRixxmLjjKZbRoiwGR7hz4zrxFDnRsoZ5QY1KrRf/8cO6d6OKf1ncg7xjZ6SkZWVV9XJf0k1P/+o4QYPQFSOe7QD09njy5EfpY/caIXx+6dKn/b60Fbq86GCMMZnqS8kM0CvoKKNUk1GN9fCy2xoQCEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732317866; c=relaxed/simple;
	bh=6ZtxjlNsuRG1ESX4ndNrijoYSwTNh68oVuQvDj8Sl0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g7Sx5wR4e6eIFC4mr4xgCFEND6ow/n06pSF7O8bRs4ztWlrY6/vJnib3sdXME43rb6EgIYdMnp4WuDDEnNy0yghqEQXx+lspq6qqt1rXmoDS2TiiZzSmR6p3doqtXgn6bvhPgeaafYkwdvuldVgNMkEbzkyhxlyqvbgGqlts7dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzJ39YKp; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6eb0c2dda3cso33763317b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 15:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732317864; x=1732922664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mCcxFgoC08WddjgvVQJDhFHo6qtZVyPlemIEDQaPX6g=;
        b=mzJ39YKpf+50uAkgsaYGyUAiBCUWR3pzjYodcdTgryaS0nM2ZFMVgPE6fB1VfQpQNr
         G3vlYFbnAFjEd0EyXbY749bh9PLQ2EsDUz9/+R9XK0nAV2XichbuwhCtySQJ1VxQ39LA
         dQEewaEy1eAU0h0qtrQwaet56uao8w4ax1hgu7t4zQLX8+mNMSazBGeWZmLfZF3QnzF3
         DhkQ4MvBp8ALxqCrQ+UpnuL2SCFQRFM15S7HJmJTsUITbBFfyuw+/bn4Ds7rlz3eHn0W
         djer2/LR0x9rSkSHnRjxTJOMMpeuzddCTXdwDBW5o4HeDWv+VeJauJdARVRgHMFtQW+V
         TXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732317864; x=1732922664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mCcxFgoC08WddjgvVQJDhFHo6qtZVyPlemIEDQaPX6g=;
        b=rvejYQMsKOa2zPh7iuG0V+KnR9lx9hEEcW+qjyk1/103IuRolu5ElZtj8nyQsBV/5E
         o2+wr4UJ+UgvtpFrj8mnhC2NnfTjIljb6+o3EQnM7VPqgOyMPN+IfnhWK9jZX1lWO/1q
         pAfFIXgpa6xOLjN/VeTAbveLr8F4giwzwamxmD7xqhZ8VCGbyGWUNGMiAmHIUaf08/Hr
         X7CD6Pa2BdZz9ZhMerWt2Fa3l2sPKNlWCkxl7vHCJ8lRbd88k5D2gRB7ajJEb/ByJY7W
         OkUqaVvO+bUkbKSXtJQ0gHzaDlGJFEfqwzrVXWOOl1HncWSyu0w0Vz0KeLW6w7pqOwIU
         Wu5A==
X-Forwarded-Encrypted: i=1; AJvYcCW545qjyFiwyIx9x0Mrp9BkalvAcrmqtOSlWznjEyXul9cG2yvWkyMpRUM1cV2hvEOqrEbefCKM1gdXgIlm@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5xiMU4RHuKJ1De3IaXWPWFlYQPafG0U0tqGRuJNPWzeOEmXNA
	2V62rWUtcCUHR21SPTWbYhCF7/CX1vy+c3idy4iBcMthEQSxj/uL
X-Gm-Gg: ASbGncsj/Dh/ZZ8qQakcPBAvhq8v0mdXHlpx8PW5QPk26y+tgD3k/jr6/aQ7blR71uD
	BbigEn7386NbRQ0IR0VCn61pIAyYljvHcDjC3hpqVWCc+UVQ8/6w18lqJsS1Bae5FFseWJeOY8D
	j0mlcwXcsEgA/yQYL8RmxOvr1A2Vktea0GAVIBeM44uuQrOA9IHS++94y2oYpJRKdSxwyU/Mkc3
	A4qYQIqXcSO5d/cOixJxw1IIhtG4IggpBXsE9pr46IynncmTjjzLErTTAwUFMDSpKp4UENCjry0
	LDN8FrZgZQ==
X-Google-Smtp-Source: AGHT+IEq4lVU89WONK6PJHk6F5A/Atbo44HCgzN+1qkcDp+xp+kLy/RNIRz5cIx6oN7Ci5cVSnsqjA==
X-Received: by 2002:a05:690c:700a:b0:6e5:bf26:574 with SMTP id 00721157ae682-6eee0a49959mr57594887b3.27.1732317863681;
        Fri, 22 Nov 2024 15:24:23 -0800 (PST)
Received: from localhost (fwdproxy-nha-114.fbsv.net. [2a03:2880:25ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eeeebc5d93sm2170897b3.116.2024.11.22.15.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 15:24:23 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH v6 0/5] fuse: remove temp page copies in writeback
Date: Fri, 22 Nov 2024 15:23:54 -0800
Message-ID: <20241122232359.429647-1-joannelkoong@gmail.com>
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
 fs/fuse/file.c          | 360 ++++------------------------------------
 fs/fuse/fuse_i.h        |   3 -
 include/linux/pagemap.h |  11 ++
 mm/migrate.c            |   5 +-
 mm/vmscan.c             |  10 +-
 6 files changed, 53 insertions(+), 339 deletions(-)

-- 
2.43.5


