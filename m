Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40F7E12D9BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2019 16:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfLaPZD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Dec 2019 10:25:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54871 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726709AbfLaPZD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Dec 2019 10:25:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577805902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PbZ2iYquyHL3/ESJhoyXhT4LrB0J4rJjHgCtbtkH6oU=;
        b=MUi/Z6EcDQ6BnRJNnyW8/43MOaWp43nL5W0Je5NayqDOTWLQyXPRrcUJABJAHDwWZLz2ST
        UcmofnnVlTO1Kl696cYPuJ6S5BZBaYb4LxFtcdil5aeEKhT+lK7SAtljsOR9B3AG3d4FGA
        hoBKs+szk1EZCs70651pkxfMqca1Tcw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-rr9HIQspOn-0-B7a57xWlQ-1; Tue, 31 Dec 2019 10:24:58 -0500
X-MC-Unique: rr9HIQspOn-0-B7a57xWlQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BDF21883520;
        Tue, 31 Dec 2019 15:24:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A20381E35;
        Tue, 31 Dec 2019 15:24:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/3] afs: Fix use-after-loss-of-ref
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        dhowells@redhat.com
Date:   Tue, 31 Dec 2019 15:24:55 +0000
Message-ID: <157780589537.25571.1965637589354532477.stgit@warthog.procyon.org.uk>
In-Reply-To: <157780588822.25571.7926816048227538205.stgit@warthog.procyon.org.uk>
References: <157780588822.25571.7926816048227538205.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

