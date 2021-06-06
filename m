Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BE639D157
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 22:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhFFUX0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 16:23:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41422 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230020AbhFFUX0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 16:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623010895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PgbTCK1YIiFuYT988WXfXOtA5kqUfQ1QkojWk2wNgOo=;
        b=eiD43jOFl1dtBI99pisF5f/Fi0/w5RHReNXodCapeBnokH/R/BqP+ZNnPTScrDjmknzW6o
        1xW7uPLi5+w2C7WBCnvjlYIbu+7N694zM6DvKWp71VItVr5b5JIPuCNWsBOawqfp3mkO8p
        stmrTVDQv8gUla28Vaein1kexh5rg30=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-DYG879wAM_STbOEW1nyJgw-1; Sun, 06 Jun 2021 16:21:31 -0400
X-MC-Unique: DYG879wAM_STbOEW1nyJgw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A9D1801ADE;
        Sun,  6 Jun 2021 20:21:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CECFF19C71;
        Sun,  6 Jun 2021 20:21:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix partial writeback of large files on fsync and close
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 06 Jun 2021 21:21:27 +0100
Message-ID: <162301088792.4056509.11204909119570228223.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Marc Dionne <marc.dionne@auristor.com>

In commit e87b03f5830e ("afs: Prepare for use of THPs"), the return
value for afs_write_back_from_locked_page was changed from a number
of pages to a length in bytes.  The loop in afs_writepages_region uses
the return value to compute the index that will be used to find dirty
pages in the next iteration, but treats it as a number of pages and
wrongly multiplies it by PAGE_SIZE.  This gives a very large index value,
potentially skipping any dirty data that was not covered in the first
pass, which is limited to 256M.

This causes fsync(), and indirectly close(), to only do a partial
writeback of a large file's dirty data.  The rest is eventually written
back by background threads after dirty_expire_centisecs.

Fixes: e87b03f5830e ("afs: Prepare for use of THPs")
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/20210604175504.4055-1-marc.c.dionne@gmail.com/
---

 fs/afs/write.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index ff412fb430e0..ebf97833d81f 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -752,7 +752,7 @@ static int afs_writepages_region(struct address_space *mapping,
 			return ret;
 		}
 
-		start += ret * PAGE_SIZE;
+		start += ret;
 
 		cond_resched();
 	} while (wbc->nr_to_write > 0);


