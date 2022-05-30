Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF9A53846A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 May 2022 17:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239817AbiE3PKs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 May 2022 11:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiE3PK1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 May 2022 11:10:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDD94694BD
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 May 2022 07:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653919740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=B2gLpclaR1OD0ds87WG+CHvKTXHfN/d11Umv3JQ16uk=;
        b=P1Car6t7N+XHRZesaYQ460tt7L1aOtiv/LHjCmm5BVFEqaUA/pgvKrS4v6FCI6HjBh86dS
        qqOuunoV5KvPXdCyDKaSd4iSq2iwwVhDLjRiVNegf8k4iG2geTzvT/6RPFTObzL5oJwOkf
        MnKQuBTmqo+A1+up/67M/leudN3bNLs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-UzopWHUSOW202Wxlj5ukTw-1; Mon, 30 May 2022 10:08:56 -0400
X-MC-Unique: UzopWHUSOW202Wxlj5ukTw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60F6180013E;
        Mon, 30 May 2022 14:08:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA74EC15E72;
        Mon, 30 May 2022 14:08:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix infinite loop found by xfstest generic/676
From:   David Howells <dhowells@redhat.com>
To:     marc.dionne@auristor.com
Cc:     linux-afs@lists.infradead.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 30 May 2022 15:08:54 +0100
Message-ID: <165391973497.110268.2939296942213894166.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
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


