Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5AF519059
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 23:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242996AbiECVlI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 17:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243039AbiECVlH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 17:41:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0313D41622
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 May 2022 14:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651613853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=63TBRqaGwgLijgt8fgNSi7lo5POsvPg4XNS4ErtV2VM=;
        b=blbQdnYlaQ1bH6LiNWKOZUlIBh+X0qFN4nSmTGQSpYa9yUaDirlrXP57N0i1DYF5lTMj5T
        /5LZXRY+O0aiLxvigcZMnHZpwE0LgVADMJMu2P0eg6nFfLPoYjn5AjWNzegW2zgGiIe8+c
        6bCWToIHuhPjUOeTfQtRpsVhX/ieiaA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-9-mh8oGpCCMLG0b5HyfaPlBA-1; Tue, 03 May 2022 17:37:30 -0400
X-MC-Unique: mh8oGpCCMLG0b5HyfaPlBA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B277086B8D2;
        Tue,  3 May 2022 21:37:29 +0000 (UTC)
Received: from max.localdomain (unknown [10.40.194.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F90640D282C;
        Tue,  3 May 2022 21:37:28 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] iomap: iomap_write_end cleanup
Date:   Tue,  3 May 2022 23:37:27 +0200
Message-Id: <20220503213727.3273873-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In iomap_write_end(), only call iomap_write_failed() on the byte range
that has failed.  This should improve code readability, but doesn't fix
an actual bug because iomap_write_failed() is called after updating the
file size here and it only affects the memory beyond the end of the
file.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 358ee1fb6f0d..8fb9b2797fc5 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -734,7 +734,7 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 	folio_put(folio);
 
 	if (ret < len)
-		iomap_write_failed(iter->inode, pos, len);
+		iomap_write_failed(iter->inode, pos + ret, len - ret);
 	return ret;
 }
 
-- 
2.35.1

