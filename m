Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BA86F486E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 18:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbjEBQhs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 12:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbjEBQhU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 12:37:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F80271C
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 09:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683045344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wV8lRfszHcQUBFiJ03SQYtrFihBDDfl7rukuI3tTTP0=;
        b=PHFRaXSeVUj9Qv1Ky3QyduYYPz75G2nNRtFcKjfyvy1tpEB9vmNeefX+K++DSEMBGKeg/+
        0U+NsOoueAJbZs9HjJFiXCaaXxYL0ky7uJ9sh7pOBKR1zjHfHSuQ1HwyaFikD74kN16xF4
        Os6TXBu2nqD3CaJU0Tiwn8NvOp1KELc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-T2kRHgaYOKieljbTt65cPA-1; Tue, 02 May 2023 12:35:40 -0400
X-MC-Unique: T2kRHgaYOKieljbTt65cPA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92C48101A550;
        Tue,  2 May 2023 16:35:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C17D52166B26;
        Tue,  2 May 2023 16:35:38 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] afs: Fix getattr to report server i_size on dirs, not local size
Date:   Tue,  2 May 2023 17:35:27 +0100
Message-Id: <20230502163528.1564398-3-dhowells@redhat.com>
In-Reply-To: <20230502163528.1564398-1-dhowells@redhat.com>
References: <20230502163528.1564398-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix afs_getattr() to report the server's idea of the file size of a
directory rather than the local size.  The local size may differ as we edit
the local copy to avoid having to redownload it and we may end up with a
differently structured blob of a different size.

However, if the directory is discarded from the pagecache we then download
it again and the user may see the directory file size apparently change.

Fixes: 63a4681ff39c ("afs: Locally edit directory data for mkdir/create/unlink/...")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/inode.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 82edd3351734..866bab860a88 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -450,7 +450,7 @@ static void afs_get_inode_cache(struct afs_vnode *vnode)
 				    0 : FSCACHE_ADV_SINGLE_CHUNK,
 				    &key, sizeof(key),
 				    &aux, sizeof(aux),
-				    vnode->status.size));
+				    i_size_read(&vnode->netfs.inode)));
 #endif
 }
 
@@ -777,6 +777,13 @@ int afs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		if (test_bit(AFS_VNODE_SILLY_DELETED, &vnode->flags) &&
 		    stat->nlink > 0)
 			stat->nlink -= 1;
+
+		/* Lie about the size of directories.  We maintain a locally
+		 * edited copy and may make different allocation decisions on
+		 * it, but we need to give userspace the server's size.
+		 */
+		if (S_ISDIR(inode->i_mode))
+			stat->size = vnode->netfs.remote_i_size;
 	} while (need_seqretry(&vnode->cb_lock, seq));
 
 	done_seqretry(&vnode->cb_lock, seq);

