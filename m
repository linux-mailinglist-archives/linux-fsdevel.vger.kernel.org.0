Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE9452F982
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 May 2022 09:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240595AbiEUHSk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 May 2022 03:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbiEUHSi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 May 2022 03:18:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FBB61611FF
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 May 2022 00:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653117514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1yTCoDRJvqGj7AA5Nj4TtGqeOJVmsCsgoM9y6NAj+ic=;
        b=RjGA6VRuhzvffFj7CAHDeKhAm8JuZM1vMRPJl1iBNOFkdOE6/5FaGwfd4NNcfX77m89PQp
        zd+a+WwgqZ8AL3JNpM0+bvIpFc3zSq8dOmfKpDek6H9309brmW7ZloIK1HWoxEBEB0uLXK
        JgC3xs7wHD8/nD9O+7DFcisuyuNdIc0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-320-uxnVpYHIP5mRzaBOfMBHMw-1; Sat, 21 May 2022 03:18:30 -0400
X-MC-Unique: uxnVpYHIP5mRzaBOfMBHMw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA2EB185A79C;
        Sat, 21 May 2022 07:18:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C150C492C3B;
        Sat, 21 May 2022 07:18:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix afs_getattr() to refetch file status if callback
 break occurred
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Markus Suvanto <markus.suvanto@gmail.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        Markus Suvanto <markus.suvanto@gmail.com>,
        kafs-testing+fedora34_64checkkafs-build-496@auristor.com,
        dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 May 2022 08:18:28 +0100
Message-ID: <165311750805.192844.10284715285667771691.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a callback break occurs (change notification), afs_getattr() needs to
issue an FS.FetchStatus RPC operation to update the status of the file
being examined by the stat-family of system calls.

Fix afs_getattr() to do this if AFS_VNODE_CB_PROMISED has been cleared on a
vnode by a callback break.  Skip this if AT_STATX_DONT_SYNC is set.

This can be tested by appending to a file on one AFS client and then using
"stat -L" to examine its length on a machine running kafs.  This can also
be watched through tracing on the kafs machine.  The callback break is
seen:

     kworker/1:1-46      [001] .....   978.910812: afs_cb_call: c=0000005f YFSCB.CallBack
     kworker/1:1-46      [001] ...1.   978.910829: afs_cb_break: 100058:23b4c:242d2c2 b=2 s=1 break-cb
     kworker/1:1-46      [001] .....   978.911062: afs_call_done:    c=0000005f ret=0 ab=0 [0000000082994ead]

And then the stat command generated no traffic if unpatched, but with this
change a call to fetch the status can be observed:

            stat-4471    [000] .....   986.744122: afs_make_fs_call: c=000000ab 100058:023b4c:242d2c2 YFS.FetchStatus
            stat-4471    [000] .....   986.745578: afs_call_done:    c=000000ab ret=0 ab=0 [0000000087fc8c84]

Fixes: 08e0e7c82eea ("[AF_RXRPC]: Make the in-kernel AFS filesystem use AF_RXRPC.")
Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Tested-by: Markus Suvanto <markus.suvanto@gmail.com>
Tested-by: kafs-testing+fedora34_64checkkafs-build-496@auristor.com
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216010
Link: https://lore.kernel.org/r/165308359800.162686.14122417881564420962.stgit@warthog.procyon.org.uk/ # v1
---

 fs/afs/inode.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 2fe402483ad5..30b066299d39 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -740,10 +740,22 @@ int afs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct afs_vnode *vnode = AFS_FS_I(inode);
-	int seq = 0;
+	struct key *key;
+	int ret, seq = 0;
 
 	_enter("{ ino=%lu v=%u }", inode->i_ino, inode->i_generation);
 
+	if (!(query_flags & AT_STATX_DONT_SYNC) &&
+	    !test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
+		key = afs_request_key(vnode->volume->cell);
+		if (IS_ERR(key))
+			return PTR_ERR(key);
+		ret = afs_validate(vnode, key);
+		key_put(key);
+		if (ret < 0)
+			return ret;
+	}
+
 	do {
 		read_seqbegin_or_lock(&vnode->cb_lock, &seq);
 		generic_fillattr(&init_user_ns, inode, stat);


