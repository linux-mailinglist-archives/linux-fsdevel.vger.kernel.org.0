Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419FB1F601E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 04:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgFKCoi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 22:44:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58946 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726290AbgFKCoi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 22:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591843477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1+nAH9EHymRayJcALo1XTuzbnoiP4s/FKdOqqpv2KIg=;
        b=S5z/tGIx6GLqyGtIxiYMrv8wJsCsXfUhDUFclsYbEVBXnakTMNsANQsbEqljCwdjt2g7MO
        YAlcNVVSKBQo1+aC/xIgBL4HJ5yLc1ZX6QCuKsAEhJwoVjoZy8iUQsoJWHRJg9qFFnJYgj
        5SDDilu6HCnqdJp5Qn4zfOyj5F8oTBg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-QNvqgyMpP4qnCHYamqyxfw-1; Wed, 10 Jun 2020 22:44:35 -0400
X-MC-Unique: QNvqgyMpP4qnCHYamqyxfw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A15B1005513;
        Thu, 11 Jun 2020 02:44:34 +0000 (UTC)
Received: from localhost (ovpn-12-163.pek2.redhat.com [10.72.12.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C97141002382;
        Thu, 11 Jun 2020 02:44:29 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH] fs/fs-writeback.c: don't WARN on unregistered BDI
Date:   Thu, 11 Jun 2020 10:44:17 +0800
Message-Id: <20200611024417.462479-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

BDI is unregistered from del_gendisk() which is usually done in device's
release handler from device hotplug or error handling context, so BDI
can be unregistered anytime.

It should be normal for __mark_inode_dirty to see un-registered BDI,
so replace the WARN() with pr_debug() just for debug purpose.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Brian Foster <bfoster@redhat.com>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/fs-writeback.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a605c3dddabc..5b7a5f5803ff 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2318,9 +2318,10 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 
 			wb = locked_inode_to_wb_and_lock_list(inode);
 
-			WARN(bdi_cap_writeback_dirty(wb->bdi) &&
-			     !test_bit(WB_registered, &wb->state),
-			     "bdi-%s not registered\n", bdi_dev_name(wb->bdi));
+			if (bdi_cap_writeback_dirty(wb->bdi) &&
+			     !test_bit(WB_registered, &wb->state))
+				pr_debug("bdi-%s not registered\n",
+						bdi_dev_name(wb->bdi));
 
 			inode->dirtied_when = jiffies;
 			if (dirtytime)
-- 
2.25.2

