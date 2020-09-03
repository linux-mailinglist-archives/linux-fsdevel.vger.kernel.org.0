Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603AE25C78D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 18:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgICQ4q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 12:56:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50490 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728514AbgICQ4p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599152204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YAdtu4wMk+fDL1zMc9RkOIclCF2kveRlgVkmIcPTrJ4=;
        b=WQsVmzMK3Pd1gLlPYZyd5cltku52I7Iq2rtf9LfQojt9ya51yqC4HPUHsPuspZl2qO9y8w
        TNAJU7k9vBXkmA2ENsvHPg/LFeGQpWfhrKmkwIZlp6PdjnSxit3cF0DX0AcsLDcVQG6u2F
        x/lv+pLrjdDHoM6SDNb1HpRxcFVMSi0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-zLPjFgCmMNWB_1VJEgJueg-1; Thu, 03 Sep 2020 12:56:40 -0400
X-MC-Unique: zLPjFgCmMNWB_1VJEgJueg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17D821DE09;
        Thu,  3 Sep 2020 16:56:39 +0000 (UTC)
Received: from max.home.com (unknown [10.40.194.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93C1410027A6;
        Thu,  3 Sep 2020 16:56:34 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, cluster-devel@redhat.com,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] iomap: Fix direct I/O write consistency check
Date:   Thu,  3 Sep 2020 18:56:32 +0200
Message-Id: <20200903165632.1338996-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a direct I/O write falls back to buffered I/O entirely, dio->size
will be 0 in iomap_dio_complete.  Function invalidate_inode_pages2_range
will try to invalidate the rest of the address space.  If there are any
dirty pages in that range, the write will fail and a "Page cache
invalidation failure on direct I/O" error will be logged.

On gfs2, this can be reproduced as follows:

  xfs_io \
    -c "open -ft foo" -c "pwrite 4k 4k" -c "close" \
    -c "open -d foo" -c "pwrite 0 4k"

Fix this by recognizing 0-length writes.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap/direct-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index c1aafb2ab990..c9d6b4eecdb7 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -108,7 +108,7 @@ static ssize_t iomap_dio_complete(struct iomap_dio *dio)
 	 * ->end_io() when necessary, otherwise a racing buffer read would cache
 	 * zeros from unwritten extents.
 	 */
-	if (!dio->error &&
+	if (!dio->error && dio->size &&
 	    (dio->flags & IOMAP_DIO_WRITE) && inode->i_mapping->nrpages) {
 		int err;
 		err = invalidate_inode_pages2_range(inode->i_mapping,
-- 
2.26.2

