Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50BA43AF5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 11:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbhJZJrW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 05:47:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57986 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235081AbhJZJrK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 05:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635241485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xaM9TTYxS+zHZ2czT8usDFfzNg+0Vbk9+uFHYAEJF0k=;
        b=BVJUfSXsQ1d6Flk63m8DcRXItAOROGzHperpYOG55uubc/XwSEHnHBpXdFKn6OczRASQ6I
        xPxgXLePxSi+2andItOfceEtVzHggMs5+iLQNFTzhxT/MKZUDADHFYhSpszt6/Pp8amb/7
        Wo9m0AdcPtWLmd2Eh3p7cYfrerCI6nw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-saoAI_GvNBugHIjyLU4dsQ-1; Tue, 26 Oct 2021 05:44:42 -0400
X-MC-Unique: saoAI_GvNBugHIjyLU4dsQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0955887950D;
        Tue, 26 Oct 2021 09:44:40 +0000 (UTC)
Received: from max.com (unknown [10.40.193.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9B8419C79;
        Tue, 26 Oct 2021 09:44:31 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v8 00/17] gfs2: Fix mmap + page fault deadlocks
Date:   Tue, 26 Oct 2021 11:44:30 +0200
Message-Id: <20211026094430.3669156-1-agruenba@redhat.com>
In-Reply-To: <YXeOVZqer+GFBkXO@mit.edu>
References: <YXeOVZqer+GFBkXO@mit.edu> <20211019134204.3382645-1-agruenba@redhat.com> <CAHk-=wh0_3y5s7-G74U0Pcjm7Y_yHB608NYrQSvgogVNBxsWSQ@mail.gmail.com> <YXBFqD9WVuU8awIv@arm.com> <CAHk-=wgv=KPZBJGnx_O5-7hhST8CL9BN4wJwtVuycjhv_1MmvQ@mail.gmail.com> <YXCbv5gdfEEtAYo8@arm.com> <CAHk-=wgP058PNY8eoWW=5uRMox-PuesDMrLsrCWPS+xXhzbQxQ@mail.gmail.com> <YXL9tRher7QVmq6N@arm.com> <CAHc6FU6JC4ZOwA8t854WbNdmuiNL9DPq0FPga8guATaoCtvsaw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ted,

here's an updated version of Dave Hansen's original commit, but note
that generic/208 won't run on ext4 with data journaling enabled:

  $ MOUNT_OPTIONS='-o data=journal' TEST_DIR=/mnt/test TEST_DEV=/dev/vdb ./tests/generic/208
  QA output created by 208
  208 not run: ext4 data journaling doesn't support O_DIRECT

Thanks,
Andreas

--

Based on commit 998ef75ddb57 ("fs: do not prefault sys_write() user
buffer pages") by Dave Hansen <dave.hansen@linux.intel.com>, but:

* Fix generic_perform_write as well as iomap_write_iter.

* copy_page_from_iter_atomic() doesn't trigger page faults, so there's no need
  to disable page faults around it [see commit 9e8c2af96e0d ("callers of
  iov_copy_from_user_atomic() don't need pagecache_disable()")].

* If fault_in_iov_iter_readable() fails to fault in the entire buffer,
  we still want to read everything up to the fault position.  This depends on
  commit a6294593e8a1 ("iov_iter: Turn iov_iter_fault_in_readable into
  fault_in_iov_iter_readable").

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap/buffered-io.c | 20 +++++++-------------
 mm/filemap.c           | 20 +++++++-------------
 2 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 1753c26c8e76..d8809cd9ab31 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -744,17 +744,6 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		if (bytes > length)
 			bytes = length;
 
-		/*
-		 * Bring in the user page that we'll copy from _first_.
-		 * Otherwise there's a nasty deadlock on copying from the
-		 * same page as we're writing to, without it being marked
-		 * up-to-date.
-		 */
-		if (unlikely(fault_in_iov_iter_readable(i, bytes))) {
-			status = -EFAULT;
-			break;
-		}
-
 		status = iomap_write_begin(iter, pos, bytes, &page);
 		if (unlikely(status))
 			break;
@@ -777,9 +766,14 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 			 * halfway through, might be a race with munmap,
 			 * might be severe memory pressure.
 			 */
-			if (copied)
+			if (copied) {
 				bytes = copied;
-			goto again;
+				goto again;
+			}
+			if (fault_in_iov_iter_readable(i, bytes) != bytes)
+				goto again;
+			status = -EFAULT;
+			break;
 		}
 		pos += status;
 		written += status;
diff --git a/mm/filemap.c b/mm/filemap.c
index 4dd5edcd39fd..467cdb7d086d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3751,17 +3751,6 @@ ssize_t generic_perform_write(struct file *file,
 						iov_iter_count(i));
 
 again:
-		/*
-		 * Bring in the user page that we will copy from _first_.
-		 * Otherwise there's a nasty deadlock on copying from the
-		 * same page as we're writing to, without it being marked
-		 * up-to-date.
-		 */
-		if (unlikely(fault_in_iov_iter_readable(i, bytes))) {
-			status = -EFAULT;
-			break;
-		}
-
 		if (fatal_signal_pending(current)) {
 			status = -EINTR;
 			break;
@@ -3794,9 +3783,14 @@ ssize_t generic_perform_write(struct file *file,
 			 * halfway through, might be a race with munmap,
 			 * might be severe memory pressure.
 			 */
-			if (copied)
+			if (copied) {
 				bytes = copied;
-			goto again;
+				goto again;
+			}
+			if (fault_in_iov_iter_readable(i, bytes) != bytes)
+				goto again;
+			status = -EFAULT;
+			break;
 		}
 		pos += status;
 		written += status;
-- 
2.26.3

