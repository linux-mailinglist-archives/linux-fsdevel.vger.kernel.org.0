Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49143C6092
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 18:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbhGLQbH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 12:31:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25582 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234515AbhGLQbG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626107297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5E7IshE9NLQ2Kj2GuNhx4kqMxjYIKwnvKCJI5uNcwyg=;
        b=OzMs9QtdqykXzqAJWYuKlAx+u+Z0kqfKxlE7DzdXOFPXS8tY5Vu33JK5YwVQMkdluitCls
        XMfNrDGiOoRiHmAUcVtROU/a6Enmjyhold32A0YKxRS024erM6VcJwW9iieM1PLyYoxmrZ
        kaT2fNebsxoFWuW9gwpxDTzP/lzI+9A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-igQ4jQStPM6jHKiyjyH7YA-1; Mon, 12 Jul 2021 12:28:13 -0400
X-MC-Unique: igQ4jQStPM6jHKiyjyH7YA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 958C3800C78;
        Mon, 12 Jul 2021 16:28:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-19.rdu2.redhat.com [10.10.118.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5523110023B5;
        Mon, 12 Jul 2021 16:28:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 4/4] afs: Remove redundant assignment to ret
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Marc Dionne <marc.dionne@auristor.com>, dhowells@redhat.com,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 12 Jul 2021 17:28:10 +0100
Message-ID: <162610729052.3408253.17364333638838151299.stgit@warthog.procyon.org.uk>
In-Reply-To: <162610726011.3408253.2771348573083023654.stgit@warthog.procyon.org.uk>
References: <162610726011.3408253.2771348573083023654.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Variable ret is set to -ENOENT and -ENOMEM but this value is never
read as it is overwritten or not used later on, hence it is a
redundant assignment and can be removed.

Cleans up the following clang-analyzer warning:

fs/afs/dir.c:2014:4: warning: Value stored to 'ret' is never read
[clang-analyzer-deadcode.DeadStores].

fs/afs/dir.c:659:2: warning: Value stored to 'ret' is never read
[clang-analyzer-deadcode.DeadStores].

[DH made the following modifications:

 - In afs_rename(), -ENOMEM should be placed in op->error instead of ret,
   rather than the assignment being removed entirely.  afs_put_operation()
   will pick it up from there and return it.

 - If afs_sillyrename() fails, its error code should be placed in op->error
   rather than in ret also.
]

Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" concept")
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/1619691492-83866-1-git-send-email-jiapeng.chong@linux.alibaba.com
Link: https://lore.kernel.org/r/162609465444.3133237.7562832521724298900.stgit@warthog.procyon.org.uk/ # v1
---

 fs/afs/dir.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 78719f2f567e..ac829e63c570 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -656,7 +656,6 @@ static int afs_do_lookup_one(struct inode *dir, struct dentry *dentry,
 		return ret;
 	}
 
-	ret = -ENOENT;
 	if (!cookie.found) {
 		_leave(" = -ENOENT [not found]");
 		return -ENOENT;
@@ -2020,17 +2019,20 @@ static int afs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 
 		if (d_count(new_dentry) > 2) {
 			/* copy the target dentry's name */
-			ret = -ENOMEM;
 			op->rename.tmp = d_alloc(new_dentry->d_parent,
 						 &new_dentry->d_name);
-			if (!op->rename.tmp)
+			if (!op->rename.tmp) {
+				op->error = -ENOMEM;
 				goto error;
+			}
 
 			ret = afs_sillyrename(new_dvnode,
 					      AFS_FS_I(d_inode(new_dentry)),
 					      new_dentry, op->key);
-			if (ret)
+			if (ret) {
+				op->error = ret;
 				goto error;
+			}
 
 			op->dentry_2 = op->rename.tmp;
 			op->rename.rehash = NULL;


