Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2178A44C62B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 18:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbhKJRsO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 12:48:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31257 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232601AbhKJRsM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 12:48:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636566324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=so+sBHeqgvGbAB6xWn0/t+WSQWf4kEYIfTA/NVWhLec=;
        b=a5v8sfocXf8d37zIqAAuvKDO73QjThyv0QlMTrlwex4LWTGDM/gISNr2I/3WEyWkCbIT9P
        eQNccQoaI8gy2TJX2bmhra3VfTxgRcb078ng8clBp70fP3wSgCALi4dQLybz55bE6fV36I
        Y8iHdhUx79RHRmDPiT0/GJLi9xMQRFA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-TFgoIEASPvmUOv5u9kZK0Q-1; Wed, 10 Nov 2021 12:45:19 -0500
X-MC-Unique: TFgoIEASPvmUOv5u9kZK0Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 084D1100C612;
        Wed, 10 Nov 2021 17:45:18 +0000 (UTC)
Received: from max.localdomain (unknown [10.40.195.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7173367854;
        Wed, 10 Nov 2021 17:44:58 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com
Subject: [RFC] gfs2: Prevent endless loops in gfs2_file_buffered_write
Date:   Wed, 10 Nov 2021 18:44:57 +0100
Message-Id: <20211110174457.533866-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

in commit 00bfe02f4796 ("gfs2: Fix mmap + page fault deadlocks for
buffered I/O"), I've managed to introduce a hang in gfs2 due to the
following check in iomap_write_iter:

  if (unlikely(fault_in_iov_iter_readable(i, bytes))) {

which fails if any of the iov iterator cannot be faulted in for reading.
At the filesystem level, we're retrying the rest of the write if any of
the iov iterator can be faulted in, so we can end up in a loop without
ever making progress.  The fix in iomap_write_iter would be as follows:

  if (unlikely(fault_in_iov_iter_readable(i, bytes) == bytes)) {

The same bug exists in generic_perform_write, but I'm not aware of any
callers of generic_perform_write that have page faults turned off.

Is this fix still appropriate for 5.16, or should we work around it in
the filesystem as below for now?

A related post-5.16 option would be to turn the pre-faulting in
iomap_write_iter and generic_perform_write into post-faulting, but at
the very least, that still needs a bit of performance analysis:

  https://lore.kernel.org/linux-fsdevel/20211026094430.3669156-1-agruenba@redhat.com/
  https://lore.kernel.org/linux-fsdevel/20211027212138.3722977-1-agruenba@redhat.com/

Thanks,
Andreas

---
 fs/gfs2/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index c486b702e00f..3e718cfc19a7 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1013,6 +1013,7 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb,
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	struct gfs2_holder *statfs_gh = NULL;
 	size_t prev_count = 0, window_size = 0;
+	size_t orig_count = iov_iter_count(from);
 	size_t read = 0;
 	ssize_t ret;
 
@@ -1057,6 +1058,7 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb,
 	if (inode == sdp->sd_rindex)
 		gfs2_glock_dq_uninit(statfs_gh);
 
+	from->count = orig_count - read;
 	if (should_fault_in_pages(ret, from, &prev_count, &window_size)) {
 		size_t leftover;
 
@@ -1064,6 +1066,7 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb,
 		leftover = fault_in_iov_iter_readable(from, window_size);
 		gfs2_holder_disallow_demote(gh);
 		if (leftover != window_size) {
+			from->count = min(from->count, window_size - leftover);
 			if (!gfs2_holder_queued(gh)) {
 				if (read)
 					goto out_uninit;
-- 
2.31.1

