Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E6C553516
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jun 2022 17:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352177AbiFUPAJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jun 2022 11:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352105AbiFUPAG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:00:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C85A26558
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 08:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655823603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DXSrhSZvaWyzVBh2O00gGtnoAZnTCy8whfaR0jeknu4=;
        b=UBdWAEoFfwTenYutpXcX2sKnCYU69qrbvPSv5vG5Sc1JHtjLOC6dKGimmz8ypinsVl9BV3
        RrhqEEaz1R7gHQt/davt0knWnUYdlyQnuyUtFunhLQ4ghAx+mVcZqgUksoiJBEBPSF+bZJ
        AWDKpRUfZI2cXlAFEGphLW+psCnRAHs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-ZTgjpt9YNhSFnLQ48_68_Q-1; Tue, 21 Jun 2022 10:59:59 -0400
X-MC-Unique: ZTgjpt9YNhSFnLQ48_68_Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 115A1811E75;
        Tue, 21 Jun 2022 14:59:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 347F2C23DBF;
        Tue, 21 Jun 2022 14:59:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, marc.dionne@auristor.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Fix dynamic root getattr
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1273399.1655823597.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 21 Jun 2022 15:59:57 +0100
Message-ID: <1273400.1655823597@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Could you apply this please?  It fixes an oops inadvertently introduced by
the fix to make afs_getattr() update the status from the server if it was
no longer valid.

Thanks,
David
---
afs: Fix dynamic root getattr

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

Fixes: 2aeb8c86d499 ("afs: Fix afs_getattr() to refetch file status if cal=
lback break occurred")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
Tested-by: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/165408450783.1031787.7941404776393751186.s=
tgit@warthog.procyon.org.uk/
---
 fs/afs/inode.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 89630acbc2cc..64dab70d4a4f 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -745,7 +745,8 @@ int afs_getattr(struct user_namespace *mnt_userns, con=
st struct path *path,
 =

 	_enter("{ ino=3D%lu v=3D%u }", inode->i_ino, inode->i_generation);
 =

-	if (!(query_flags & AT_STATX_DONT_SYNC) &&
+	if (vnode->volume &&
+	    !(query_flags & AT_STATX_DONT_SYNC) &&
 	    !test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
 		key =3D afs_request_key(vnode->volume->cell);
 		if (IS_ERR(key))

