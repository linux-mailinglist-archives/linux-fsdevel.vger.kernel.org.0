Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A211FF188
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 14:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgFRMYR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 08:24:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26807 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726975AbgFRMYQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592483055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yPVHlKRsFrSZNn3IJFrG3whV+618Yr3uyXoo1MoST1k=;
        b=AvEMy08vOXaIRWRyY3LHsp4ylu9/L0lrtE5UGnwnQKqjmY1wKkbN+QMvhCacD/s9jMzOsR
        J4ey0LfjMh6ybyEhDrgPT+xNspGBK1sj95lnDIB39d+gHT+TP2QbGGJE+mWn0H5cNv3nCG
        KBkyl7DgpzICvfF6e+JD4eSo6ixKAaQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-naZsk118N7uGyiO776mB3g-1; Thu, 18 Jun 2020 08:24:13 -0400
X-MC-Unique: naZsk118N7uGyiO776mB3g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D937107ACF4;
        Thu, 18 Jun 2020 12:24:12 +0000 (UTC)
Received: from max.home.com (unknown [10.40.195.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94D891002393;
        Thu, 18 Jun 2020 12:24:10 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Bob Peterson <rpeterso@redhat.com>
Subject: [PATCH v2] iomap: Make sure iomap_end is called after iomap_begin
Date:   Thu, 18 Jun 2020 14:24:08 +0200
Message-Id: <20200618122408.1054092-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make sure iomap_end is always called when iomap_begin succeeds.

Without this fix, iomap_end won't be called when a filesystem's
iomap_begin operation returns an invalid mapping, bypassing any
unlocking done in iomap_end.  With this fix, the unlocking would
at least still happen.

This iomap_apply bug was found by Bob Peterson during code review.
It's unlikely that such iomap_begin bugs will survive to affect
users, so backporting this fix seems unnecessary.

Fixes: ae259a9c8593 ("fs: introduce iomap infrastructure")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap/apply.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
index 76925b40b5fd..32daf8cb411c 100644
--- a/fs/iomap/apply.c
+++ b/fs/iomap/apply.c
@@ -46,10 +46,11 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
 	ret = ops->iomap_begin(inode, pos, length, flags, &iomap, &srcmap);
 	if (ret)
 		return ret;
-	if (WARN_ON(iomap.offset > pos))
-		return -EIO;
-	if (WARN_ON(iomap.length == 0))
-		return -EIO;
+	if (WARN_ON(iomap.offset > pos) ||
+	    WARN_ON(iomap.length == 0)) {
+		written = -EIO;
+		goto out;
+	}
 
 	trace_iomap_apply_dstmap(inode, &iomap);
 	if (srcmap.type != IOMAP_HOLE)
@@ -80,6 +81,7 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
 	written = actor(inode, pos, length, data, &iomap,
 			srcmap.type != IOMAP_HOLE ? &srcmap : &iomap);
 
+out:
 	/*
 	 * Now the data has been copied, commit the range we've copied.  This
 	 * should not fail unless the filesystem has had a fatal error.

base-commit: 69119673bd50b176ded34032fadd41530fb5af21
-- 
2.26.2

