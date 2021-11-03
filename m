Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A33444BC2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 00:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhKCXqY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 19:46:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38126 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229561AbhKCXqX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 19:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635983026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TY3Hzrdo8eAbxokPf+Hgzthrnx4D+WJ0/5UlAdCUFUc=;
        b=APiF7uycoEBv0IIllGbL9EuRRTU9GbtNpYNBxMejV8uH/09omfzTpP7fdM87YJh2cRxdz8
        w02JT1Rlxn9b4HqM5m2ASg9N/HHpsjpfiqOSKp6lrhRKPZLuWiXfnYdVjLqeqsnHM41299
        IhcI7GL1luJscSPkpqSOE0Ow/eScd90=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-_5gveUDqMF2UbP-vjO6A3Q-1; Wed, 03 Nov 2021 19:43:45 -0400
X-MC-Unique: _5gveUDqMF2UbP-vjO6A3Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BF9B8066F4;
        Wed,  3 Nov 2021 23:43:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55F9E19C79;
        Wed,  3 Nov 2021 23:43:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix ENOSPC,
 EDQUOT and other errors to fail a write rather than retrying
From:   David Howells <dhowells@redhat.com>
To:     marc.dionne@auristor.com
Cc:     Jeffrey E Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 03 Nov 2021 23:43:20 +0000
Message-ID: <163598300034.1327800.8060660349996331911.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, at the completion of a storage RPC from writepages, the errors
ENOSPC, EDQUOT, ENOKEY, EACCES, EPERM, EKEYREJECTED and EKEYREVOKED cause
the pages involved to be redirtied and the write to be retried by the VM at
a future time.

However, this is probably not the right thing to do, and, instead, the
writes should be discarded so that the system doesn't get blocked (though
unmounting will discard the uncommitted writes anyway).

Fix this by making afs_write_back_from_locked_page() call afs_kill_pages()
instead of afs_redirty_pages() in those cases.

EKEYEXPIRED is left to redirty the pages on the assumption that the caller
just needs to renew their key.  Unknown errors also do that, though it
might be better to squelch those too.

This can be triggered by the generic/285 xfstest.  The writes can be
observed in the server logs.  If a write fails with ENOSPC (ie. CODE
49733403, UAENOSPC) because a file is made really large, e.g.:

Wed Nov 03 23:21:35.794133 2021 [1589] EVENT YFS_SRX_StData CODE 49733403 NAME --UnAuth-- HOST [192.168.1.2]:7001 ID 32766 FID 1048664:0.172306:30364251 UINT64 17592187027456 UINT64 65536 UINT64 17592187092992 UINT64 0

this should be seen once and not repeated.

Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeffrey E Altman <jaltman@auristor.com>
cc: linux-afs@lists.infradead.org
---

 fs/afs/write.c |   14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 8b1d9c2f6bec..04f3f87b15cb 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -620,22 +620,18 @@ static ssize_t afs_write_back_from_locked_page(struct address_space *mapping,
 	default:
 		pr_notice("kAFS: Unexpected error from FS.StoreData %d\n", ret);
 		fallthrough;
-	case -EACCES:
-	case -EPERM:
-	case -ENOKEY:
 	case -EKEYEXPIRED:
-	case -EKEYREJECTED:
-	case -EKEYREVOKED:
 		afs_redirty_pages(wbc, mapping, start, len);
 		mapping_set_error(mapping, ret);
 		break;
 
+	case -EACCES:
+	case -EPERM:
+	case -ENOKEY:
+	case -EKEYREJECTED:
+	case -EKEYREVOKED:
 	case -EDQUOT:
 	case -ENOSPC:
-		afs_redirty_pages(wbc, mapping, start, len);
-		mapping_set_error(mapping, -ENOSPC);
-		break;
-
 	case -EROFS:
 	case -EIO:
 	case -EREMOTEIO:


