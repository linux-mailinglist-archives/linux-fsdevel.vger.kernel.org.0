Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9463538CE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 10:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244873AbiEaIat (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 04:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244855AbiEaIas (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 04:30:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F36A612B0
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 May 2022 01:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653985846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dejbYOzfjKF6dMJXhvNBnCnEVYYCsLU8eaE5kLKtEMo=;
        b=WvwJPdx/xVw36jL3nx9o9TI5Rhw5CaFC7qN1t3WAaZEPivQ3lzucDcCLOTXL8KMpwM96fc
        r9mHRbyKgy2JL8ARh+1RCkZWCajdW5bRRhcLYzD79f2Ym0xzGUbHTq1I1xQ1nHZSS9CCP5
        dPrj4z1VIkI6+TQTVpEyqcv7NVhZzC4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-Ej6uU4mePMuU1vbZOWgMYQ-1; Tue, 31 May 2022 04:30:42 -0400
X-MC-Unique: Ej6uU4mePMuU1vbZOWgMYQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BDC63C11052;
        Tue, 31 May 2022 08:30:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DFBB492C3B;
        Tue, 31 May 2022 08:30:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix infinite loop found by xfstest generic/676
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 31 May 2022 09:30:40 +0100
Message-ID: <165398584061.263049.2347678478539579934.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In AFS, a directory is handled as a file that the client downloads and
parses locally for the purposes of performing lookup and getdents
operations.  The in-kernel afs filesystem has a number of functions that do
this.  A directory file is arranged as a series of 2K blocks divided into
32-byte slots, where a directory entry occupies one or more slots, plus
each block starts with one or more metadata blocks.

When parsing a block, if the last slots are occupied by a dirent that
occupies more than a single slot and the file position points at a slot
that's not the initial one, the logic in afs_dir_iterate_block() that skips
over it won't advance the file pointer to the end of it.  This will cause
an infinite loop in getdents() as it will keep retrying that block and
failing to advance beyond the final entry.

Fix this by advancing the file pointer if the next entry will be beyond it
when we skip a block.

This was found by the generic/676 xfstest but can also be triggered with
something like:

	~/xfstests-dev/src/t_readdir_3 /xfstest.test/z 4000 1

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
Tested-by: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Link: http://lore.kernel.org/r/165391973497.110268.2939296942213894166.stgit@warthog.procyon.org.uk/
---

 fs/afs/dir.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 932e61e28e5d..bdac73554e6e 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -463,8 +463,11 @@ static int afs_dir_iterate_block(struct afs_vnode *dvnode,
 		}
 
 		/* skip if starts before the current position */
-		if (offset < curr)
+		if (offset < curr) {
+			if (next > curr)
+				ctx->pos = blkoff + next * sizeof(union afs_xdr_dirent);
 			continue;
+		}
 
 		/* found the next entry */
 		if (!dir_emit(ctx, dire->u.name, nlen,


