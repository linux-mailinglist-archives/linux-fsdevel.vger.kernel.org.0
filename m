Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2C353A46F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 13:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbiFALzV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 07:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbiFALzT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:55:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8A575003C
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jun 2022 04:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654084515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=A1XdIemq8frjYfv4a28xhmhvY/SFwVpocirLnr3lxtY=;
        b=huoGnDuj7jedsALjJuPNKVayWcQH8q2suQ8UXJnDsIpUjIKqkxdqse5ZC6hvDDSBlA+TMU
        gpOVBMTyitiYVskGGK9bVAbHoCaNJZ3jWN/t3cQTZ8NWINaHw38pHNxltyy/OaJ+qRuuFr
        YxY3PfdBjo6cJr9bHg+szUY4eU9l2Sw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-AwrvSifIOhi-RiCzV8sH6w-1; Wed, 01 Jun 2022 07:55:13 -0400
X-MC-Unique: AwrvSifIOhi-RiCzV8sH6w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 481E22949BA3;
        Wed,  1 Jun 2022 11:55:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A37CC23DBF;
        Wed,  1 Jun 2022 11:55:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix dynamic root getattr
From:   David Howells <dhowells@redhat.com>
To:     marc.dionne@auristor.com
Cc:     linux-afs@lists.infradead.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 01 Jun 2022 12:55:07 +0100
Message-ID: <165408450783.1031787.7941404776393751186.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The recent patch to make afs_getattr consult the server didn't account for
the pseudo-inodes employed by the dynamic root-type afs superblock not
having a volume or a server to access, and thus an oops occurs if such a
directory is stat'd.

Fix this by checking to see if the vnode->volume pointer actually points
anywhere before following it in afs_getattr().

This can be tested by stat'ing a directory in /afs.  It may be sufficient
just to do "ls /afs" and the oops looks something like:

	BUG: kernel NULL pointer dereference, address: 0000000000000020
	...
	RIP: 0010:afs_getattr+0x8b/0x14b
	...
	Call Trace:
	 <TASK>
	 vfs_statx+0x79/0xf5
	 vfs_fstatat+0x49/0x62

Fixes: 2aeb8c86d499 ("afs: Fix afs_getattr() to refetch file status if callback break occurred")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
---

 fs/afs/inode.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 30b066299d39..33ecbfea0199 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -745,7 +745,8 @@ int afs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 
 	_enter("{ ino=%lu v=%u }", inode->i_ino, inode->i_generation);
 
-	if (!(query_flags & AT_STATX_DONT_SYNC) &&
+	if (vnode->volume &&
+	    !(query_flags & AT_STATX_DONT_SYNC) &&
 	    !test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
 		key = afs_request_key(vnode->volume->cell);
 		if (IS_ERR(key))


