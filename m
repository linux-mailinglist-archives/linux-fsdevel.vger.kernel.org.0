Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B5A1F6236
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 09:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgFKHXI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 03:23:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44148 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726559AbgFKHXH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591860185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rTjWKx86t+Cil0yXSIdKV7v4L5KnY0ijXJXmVkgzvUg=;
        b=BiCBzrT4hiKq87KxorNKiLw/5EmHm0FUc7IjKw/ggqmTWp+YFUElp7NM7D15OkKWzk+bJv
        OpGIzB4TgCn7K17rJRxhuBe/W8vNr7K5h/mmFo9bkY4BJSDdYq9qhw+B4lEVRUhsoNC2cx
        oDJL9bVEdjN7It7tKG1xA/Tr0SkKseQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-lv1MmWNJMrCyiNAkR1bmOw-1; Thu, 11 Jun 2020 03:23:03 -0400
X-MC-Unique: lv1MmWNJMrCyiNAkR1bmOw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEB62872FE1;
        Thu, 11 Jun 2020 07:23:02 +0000 (UTC)
Received: from localhost (ovpn-12-163.pek2.redhat.com [10.72.12.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3AF71891E2;
        Thu, 11 Jun 2020 07:22:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH] fs/fs-writeback.c: not WARN on unregistered BDI
Date:   Thu, 11 Jun 2020 15:22:51 +0800
Message-Id: <20200611072251.474246-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

BDI is unregistered from del_gendisk() which is usually done in device's
release handler from device hotplug or error handling context, so BDI
can be unregistered anytime.

It should be normal for __mark_inode_dirty to see un-registered BDI,
so kill the WARN().

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Brian Foster <bfoster@redhat.com>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/fs-writeback.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a605c3dddabc..5e718580d4bf 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2318,10 +2318,6 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 
 			wb = locked_inode_to_wb_and_lock_list(inode);
 
-			WARN(bdi_cap_writeback_dirty(wb->bdi) &&
-			     !test_bit(WB_registered, &wb->state),
-			     "bdi-%s not registered\n", bdi_dev_name(wb->bdi));
-
 			inode->dirtied_when = jiffies;
 			if (dirtytime)
 				inode->dirtied_time_when = jiffies;
-- 
2.25.2

