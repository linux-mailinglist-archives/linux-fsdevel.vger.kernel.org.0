Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 367C013AF02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 17:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgANQQe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 11:16:34 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53821 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727102AbgANQQd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579018592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PbZ2iYquyHL3/ESJhoyXhT4LrB0J4rJjHgCtbtkH6oU=;
        b=gwQM15VlRb96B++eNvhozToW2kKXuCmfvOLeWgr0QOxDm/0/f5/c7HpRjfvMkd+XFeDoVD
        G/zQ1vY4JQG6KCg2sPvSw+ky4RHUVBQ42ND2l/DLSYNKWuUu7bcqSvssDzDj4xiyLHys0z
        AD8nbF7JVJXP9+CpYb1Xv4hcFG6SMgo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-KJa4clGFPE60OmZjNLAIbg-1; Tue, 14 Jan 2020 11:16:29 -0500
X-MC-Unique: KJa4clGFPE60OmZjNLAIbg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B008C10513C7;
        Tue, 14 Jan 2020 16:16:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 53D4026E43;
        Tue, 14 Jan 2020 16:16:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix use-after-loss-of-ref
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 14 Jan 2020 16:16:25 +0000
Message-ID: <157901858546.1172.10059769927247020179.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

afs_lookup() has a tracepoint to indicate the outcome of d_splice_alias(),
passing it the inode to retrieve the fid from.  However, the function gave
up its ref on that inode when it called d_splice_alias(), which may have
failed and dropped the inode.

Fix this by caching the fid.

Fixes: 80548b03991f ("afs: Add more tracepoints")
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/dir.c               |   12 +++++++-----
 include/trace/events/afs.h |   12 +++---------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 497f979018c2..813db1708494 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -908,6 +908,7 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 				 unsigned int flags)
 {
 	struct afs_vnode *dvnode = AFS_FS_I(dir);
+	struct afs_fid fid = {};
 	struct inode *inode;
 	struct dentry *d;
 	struct key *key;
@@ -957,15 +958,16 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 		dentry->d_fsdata =
 			(void *)(unsigned long)dvnode->status.data_version;
 	}
+
+	if (!IS_ERR_OR_NULL(inode))
+		fid = AFS_FS_I(inode)->fid;
+
 	d = d_splice_alias(inode, dentry);
 	if (!IS_ERR_OR_NULL(d)) {
 		d->d_fsdata = dentry->d_fsdata;
-		trace_afs_lookup(dvnode, &d->d_name,
-				 inode ? AFS_FS_I(inode) : NULL);
+		trace_afs_lookup(dvnode, &d->d_name, &fid);
 	} else {
-		trace_afs_lookup(dvnode, &dentry->d_name,
-				 IS_ERR_OR_NULL(inode) ? NULL
-				 : AFS_FS_I(inode));
+		trace_afs_lookup(dvnode, &dentry->d_name, &fid);
 	}
 	return d;
 }
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index d5ec4fac82ae..564ba1b5cf57 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -915,9 +915,9 @@ TRACE_EVENT(afs_call_state,
 
 TRACE_EVENT(afs_lookup,
 	    TP_PROTO(struct afs_vnode *dvnode, const struct qstr *name,
-		     struct afs_vnode *vnode),
+		     struct afs_fid *fid),
 
-	    TP_ARGS(dvnode, name, vnode),
+	    TP_ARGS(dvnode, name, fid),
 
 	    TP_STRUCT__entry(
 		    __field_struct(struct afs_fid,	dfid		)
@@ -928,13 +928,7 @@ TRACE_EVENT(afs_lookup,
 	    TP_fast_assign(
 		    int __len = min_t(int, name->len, 23);
 		    __entry->dfid = dvnode->fid;
-		    if (vnode) {
-			    __entry->fid = vnode->fid;
-		    } else {
-			    __entry->fid.vid = 0;
-			    __entry->fid.vnode = 0;
-			    __entry->fid.unique = 0;
-		    }
+		    __entry->fid = *fid;
 		    memcpy(__entry->name, name->name, __len);
 		    __entry->name[__len] = 0;
 			   ),

