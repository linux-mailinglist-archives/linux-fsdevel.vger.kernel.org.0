Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A5820D2F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 21:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgF2SyC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 14:54:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51664 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729848AbgF2Sx2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593456808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8NrvFqPEaCZo73ucPretnHpW8WPus9if7ARiejz/tmU=;
        b=Dc8eWgNg6COMUEZWjRPHq1uYFB3XswXwWe1x8PxdQvzx27FHxqzEdfnAF2Nqubh7wLjd0A
        zO/JzjZuTF1Hs6E0u/C5gX1UyJnilF+3M+w9F7Xk/KPghq9cuT2RDYzruOPaXDqKX1drtD
        ujKnK4TLqZzFmvajvWbzWlN59pyU6ZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-cCtqttAgN7imsvssRYmaig-1; Mon, 29 Jun 2020 05:51:22 -0400
X-MC-Unique: cCtqttAgN7imsvssRYmaig-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A67780183C;
        Mon, 29 Jun 2020 09:51:21 +0000 (UTC)
Received: from max.home.com (unknown [10.40.195.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 413B95D9D3;
        Mon, 29 Jun 2020 09:51:20 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v3] iomap: Make sure iomap_end is called after iomap_begin
Date:   Mon, 29 Jun 2020 11:51:18 +0200
Message-Id: <20200629095118.1366261-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make sure iomap_end is always called when iomap_begin succeeds.

Without this fix, iomap_end won't be called when a filesystem's
iomap_begin operation returns an invalid mapping, bypassing any
unlocking done in iomap_end.  With this fix, the unlocking will still
happen.

This bug was found by Bob Peterson during code review.  It's unlikely
that such iomap_begin bugs will survive to affect users, so backporting
this fix seems unnecessary.

Fixes: ae259a9c8593 ("fs: introduce iomap infrastructure")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap/apply.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
index 76925b40b5fd..26ab6563181f 100644
--- a/fs/iomap/apply.c
+++ b/fs/iomap/apply.c
@@ -46,10 +46,14 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
 	ret = ops->iomap_begin(inode, pos, length, flags, &iomap, &srcmap);
 	if (ret)
 		return ret;
-	if (WARN_ON(iomap.offset > pos))
-		return -EIO;
-	if (WARN_ON(iomap.length == 0))
-		return -EIO;
+	if (WARN_ON(iomap.offset > pos)) {
+		written = -EIO;
+		goto out;
+	}
+	if (WARN_ON(iomap.length == 0)) {
+		written = -EIO;
+		goto out;
+	}
 
 	trace_iomap_apply_dstmap(inode, &iomap);
 	if (srcmap.type != IOMAP_HOLE)
@@ -80,6 +84,7 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
 	written = actor(inode, pos, length, data, &iomap,
 			srcmap.type != IOMAP_HOLE ? &srcmap : &iomap);
 
+out:
 	/*
 	 * Now the data has been copied, commit the range we've copied.  This
 	 * should not fail unless the filesystem has had a fatal error.

base-commit: 69119673bd50b176ded34032fadd41530fb5af21
-- 
2.26.2

