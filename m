Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D7E675708
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 15:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjATOZn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 09:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjATOZk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:25:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E15C79297
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 06:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674224590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ktA29KQbuXCcCEef4794rmdBepFoDQxAni7+bjVmiGA=;
        b=CQIl2hen3t6+moC/YYx8fRh7B5hkHr5C4LA2AtViC35pHMVee0xzV1E5WcIOwUsMoRACFc
        oydLJ1mRTFqvIbE38donDyzUzZp05QchvWajk/aj7WyHqkQMlShJOeNnFrmO8BOAZqwY5L
        TPrRjA092UXlxxK0dTcLpgiQNYewpws=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-572-Rl19rg0-PrCGQtmOxIjdxQ-1; Fri, 20 Jan 2023 09:11:53 -0500
X-MC-Unique: Rl19rg0-PrCGQtmOxIjdxQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C88928030CF;
        Fri, 20 Jan 2023 14:11:52 +0000 (UTC)
Received: from pasta.redhat.com (ovpn-192-72.brq.redhat.com [10.40.192.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6878E140EBF6;
        Fri, 20 Jan 2023 14:11:51 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com
Subject: [PATCH] Revert "gfs2: stop using generic_writepages in gfs2_ail1_start_one"
Date:   Fri, 20 Jan 2023 15:11:50 +0100
Message-Id: <20230120141150.1278819-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit b2b0a5e97855 switched from generic_writepages() to
filemap_fdatawrite_wbc() in gfs2_ail1_start_one() on the path to
replacing ->writepage() with ->writepages() and eventually eliminating
the former.  Function gfs2_ail1_start_one() is called from
gfs2_log_flush(), our main function for flushing the filesystem log.

Unfortunately, at least as implemented today, ->writepage() and
->writepages() are entirely different operations for journaled data
inodes: while the former creates and submits transactions covering the
data to be written, the latter flushes dirty buffers out to disk.

With gfs2_ail1_start_one() now calling ->writepages(), we end up
creating filesystem transactions while we are in the course of a log
flush, which immediately deadlocks on the sdp->sd_log_flush_lock
semaphore.

Work around that by going back to how things used to work before commit
b2b0a5e97855 for now; figuring out a superior solution will take time we
don't have available right now.  However ...

Since the removal of generic_writepages() is imminent, open-code it
here.  We're already inside a blk_start_plug() ...  blk_finish_plug()
section here, so skip that part of the original generic_writepages().

This reverts commit b2b0a5e978552e348f85ad9c7568b630a5ede659.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/log.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 723639376ae2..61323deb80bc 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -80,6 +80,15 @@ void gfs2_remove_from_ail(struct gfs2_bufdata *bd)
 	brelse(bd->bd_bh);
 }
 
+static int __gfs2_writepage(struct page *page, struct writeback_control *wbc,
+		       void *data)
+{
+	struct address_space *mapping = data;
+	int ret = mapping->a_ops->writepage(page, wbc);
+	mapping_set_error(mapping, ret);
+	return ret;
+}
+
 /**
  * gfs2_ail1_start_one - Start I/O on a transaction
  * @sdp: The superblock
@@ -131,7 +140,7 @@ __acquires(&sdp->sd_ail_lock)
 		if (!mapping)
 			continue;
 		spin_unlock(&sdp->sd_ail_lock);
-		ret = filemap_fdatawrite_wbc(mapping, wbc);
+		ret = write_cache_pages(mapping, wbc, __gfs2_writepage, mapping);
 		if (need_resched()) {
 			blk_finish_plug(plug);
 			cond_resched();
-- 
2.39.0

