Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F173E12D9C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2019 16:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfLaPZK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Dec 2019 10:25:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59332 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727122AbfLaPZJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Dec 2019 10:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577805909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MmNBZkwBy1szGWacQmXBphuROcFRHJi+XYFCIYFXOoM=;
        b=QMTZlpzg0aTpWFtU8FRuBnWTq27NklR55wTUTgqZxipQeITBoeXTM7T0cHpQP0Dq/eCBsw
        mjDiuSVCHmCS3+sCik74L5IdG6tRl2XZJCFdBWeFSpBZaWNeCWbD6SvulxvYc6eipvRP5N
        9lrPYghuUcIl7UO0uGtjNAz4BhhmuMw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-2Js2s053NvmFzobCKbM2CA-1; Tue, 31 Dec 2019 10:25:05 -0500
X-MC-Unique: 2Js2s053NvmFzobCKbM2CA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62D2D1800D4E;
        Tue, 31 Dec 2019 15:25:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57F7B5D9E1;
        Tue, 31 Dec 2019 15:25:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/3] afs: Fix afs_lookup() to not clobber the version on a
 new dentry
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, dhowells@redhat.com
Date:   Tue, 31 Dec 2019 15:25:02 +0000
Message-ID: <157780590246.25571.8995170375088979996.stgit@warthog.procyon.org.uk>
In-Reply-To: <157780588822.25571.7926816048227538205.stgit@warthog.procyon.org.uk>
References: <157780588822.25571.7926816048227538205.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

