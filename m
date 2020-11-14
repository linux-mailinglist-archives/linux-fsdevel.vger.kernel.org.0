Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE1A2B2EF9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 18:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbgKNR2H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Nov 2020 12:28:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59011 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbgKNR2F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Nov 2020 12:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605374884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yUMNWuTzcp6lgo8BaPHSOcXsQblkWlhKvdzAMy4JmaU=;
        b=dqdP2wLZnz2/u9J6Z7INgJGeAn4gIWPn+xysW3hk/hTFvcM6u8xbM/TyYdsjMgQAsx/42L
        dDENGlSQk/sPdNemlfqZsgUS1MR4jMlYpl7tbkqFYdHqlv9oEHEJ5wcRaKw1ApbdxbAaMe
        H5G9IqVMcf67PATDx00PW3QW+dWsaeg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-l2S-yheAPe2DDlEtxI6nGQ-1; Sat, 14 Nov 2020 12:28:00 -0500
X-MC-Unique: l2S-yheAPe2DDlEtxI6nGQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFA8A8E79E7;
        Sat, 14 Nov 2020 17:27:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-47.rdu2.redhat.com [10.10.115.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE61360C13;
        Sat, 14 Nov 2020 17:27:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix afs_write_end() when called with copied == 0 [ver
 #3]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 14 Nov 2020 17:27:57 +0000
Message-ID: <160537487717.3083111.4734306195916947822.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When afs_write_end() is called with copied == 0, it tries to set the dirty
region, but there's no way to actually encode a 0-length region in the
encoding in page->private.  "0,0", for example, indicates a 1-byte region
at offset 0.  The maths miscalculates this and sets it incorrectly.

Fix it to just do nothing but unlock and put the page in this case.  We
don't actually need to mark the page dirty as nothing presumably changed.

Fixes: 65dd2d6072d3 ("afs: Alter dirty range encoding in page->private")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/write.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 50371207f327..c9195fc67fd8 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -169,11 +169,14 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 	unsigned int f, from = pos & (PAGE_SIZE - 1);
 	unsigned int t, to = from + copied;
 	loff_t i_size, maybe_i_size;
-	int ret;
+	int ret = 0;
 
 	_enter("{%llx:%llu},{%lx}",
 	       vnode->fid.vid, vnode->fid.vnode, page->index);
 
+	if (copied == 0)
+		goto out;
+
 	maybe_i_size = pos + copied;
 
 	i_size = i_size_read(&vnode->vfs_inode);


