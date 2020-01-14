Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3BC13AF04
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 17:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgANQRB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 11:17:01 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53816 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726450AbgANQRB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579018620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MmNBZkwBy1szGWacQmXBphuROcFRHJi+XYFCIYFXOoM=;
        b=gzfyc8+ZPiPFPjoukb2gx+HkP4JWvMOorBR+Rc0VZ8iOu7VXvuU1Bwg4v6pVtjyJjZFgTE
        /0YRPB/BsH8QEKVtkjFBYJkXpHvzt7B/Y6/wLIxZoH3MC3bu117h0aF5DOiZubIDw0a8Co
        wZKbl7cE9/j5wLkE6HPZ+rqPn5jToBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-dIecYhpBPyKNb0Hd40mSXg-1; Tue, 14 Jan 2020 11:16:57 -0500
X-MC-Unique: dIecYhpBPyKNb0Hd40mSXg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BD568DD348;
        Tue, 14 Jan 2020 16:16:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 03D2680F5C;
        Tue, 14 Jan 2020 16:16:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix afs_lookup() to not clobber the version on a new
 dentry
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 14 Jan 2020 16:16:54 +0000
Message-ID: <157901861423.1394.15115986296413304429.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix afs_lookup() to not clobber the version set on a new dentry by
afs_do_lookup() - especially as it's using the wrong version of the version
(we need to use the one given to us by whatever op the dir contents
correspond to rather than what's in the afs_vnode).

Fixes: 9dd0b82ef530 ("afs: Fix missing dentry data version updating")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/dir.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 813db1708494..5c794f4b051a 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -952,12 +952,8 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 	afs_stat_v(dvnode, n_lookup);
 	inode = afs_do_lookup(dir, dentry, key);
 	key_put(key);
-	if (inode == ERR_PTR(-ENOENT)) {
+	if (inode == ERR_PTR(-ENOENT))
 		inode = afs_try_auto_mntpt(dentry, dir);
-	} else {
-		dentry->d_fsdata =
-			(void *)(unsigned long)dvnode->status.data_version;
-	}
 
 	if (!IS_ERR_OR_NULL(inode))
 		fid = AFS_FS_I(inode)->fid;

