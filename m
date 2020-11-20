Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E123C2BAE8A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbgKTPRO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:17:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53355 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729528AbgKTPRM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:17:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605885430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ce7/c7lMlpvHwDgNHByQuhtYiVPrw7XCcrVKbBA4uqQ=;
        b=hsgo4kFe0MVJgDCN8BA1dM/+9HaGDjUOeJkq+yS1qQgMUTrOoS9M5IULNGruqn5+c68y0H
        paSPJ1R/VNgdrDyToXtZKP29sZ/b09WrjvsNTkfJu4cWsSsV+RA2YSH+F8b4zHpO3Bo/XX
        THwNP6bn0I2MhjoiLXTKKEaPS3wz1aE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-eaLXVXcjNSCVgADGgGstDw-1; Fri, 20 Nov 2020 10:17:05 -0500
X-MC-Unique: eaLXVXcjNSCVgADGgGstDw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19F7B10151E5;
        Fri, 20 Nov 2020 15:17:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43BC75D6AD;
        Fri, 20 Nov 2020 15:16:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 66/76] afs: Use the fs operation ops to handle FetchData
 completion
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:16:54 +0000
Message-ID: <160588541471.3465195.8807019223378490810.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the 'success' and 'aborted' afs_operations_ops methods and add a
'failed' method to handle the completion of an AFS.FetchData,
AFS.FetchData64 or YFS.FetchData64 RPC operation rather than directly
calling the done func pointed to by the afs_read struct from the call
delivery handler.

This means the done function will be called back on error also, not just on
successful completion.

This allows motion towards asynchronous data reception on data fetch calls
and allows any error to be handed off to the fscache read helper in the
same place as a successful completion.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/file.c         |   15 +++++++++++++++
 fs/afs/fs_operation.c |    4 +++-
 fs/afs/fsclient.c     |    3 ---
 fs/afs/internal.h     |    1 +
 fs/afs/yfsclient.c    |    3 ---
 5 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index b4a78afad643..38dda8990b4c 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -268,6 +268,19 @@ void afs_put_read(struct afs_read *req)
 	}
 }
 
+static void afs_fetch_data_notify(struct afs_operation *op)
+{
+	struct afs_read *req = op->fetch.req;
+	int error = op->error;
+
+	if (error == -ECONNABORTED)
+		error = afs_abort_to_error(op->ac.abort_code);
+	req->error = error;
+
+	if (req->done)
+		req->done(req);
+}
+
 static void afs_fetch_data_success(struct afs_operation *op)
 {
 	struct afs_vnode *vnode = op->file[0].vnode;
@@ -276,6 +289,7 @@ static void afs_fetch_data_success(struct afs_operation *op)
 	afs_vnode_commit_status(op, &op->file[0]);
 	afs_stat_v(vnode, n_fetches);
 	atomic_long_add(op->fetch.req->actual_len, &op->net->n_fetch_bytes);
+	afs_fetch_data_notify(op);
 }
 
 static void afs_fetch_data_put(struct afs_operation *op)
@@ -289,6 +303,7 @@ static const struct afs_operation_ops afs_fetch_data_operation = {
 	.issue_yfs_rpc	= yfs_fs_fetch_data,
 	.success	= afs_fetch_data_success,
 	.aborted	= afs_check_for_remote_deletion,
+	.failed		= afs_fetch_data_notify,
 	.put		= afs_fetch_data_put,
 };
 
diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index 97cab12b0a6c..938e28a00101 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -195,8 +195,10 @@ void afs_wait_for_operation(struct afs_operation *op)
 	case -ECONNABORTED:
 		if (op->ops->aborted)
 			op->ops->aborted(op);
-		break;
+		fallthrough;
 	default:
+		if (op->ops->failed)
+			op->ops->failed(op);
 		break;
 	}
 
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 31e6b3635541..5e34f4dbd385 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -392,9 +392,6 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		break;
 	}
 
-	if (req->done)
-		req->done(req);
-
 	_leave(" = 0 [done]");
 	return 0;
 }
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index ce1f05d5c94b..e7ec2f4acc4d 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -742,6 +742,7 @@ struct afs_operation_ops {
 	void (*issue_yfs_rpc)(struct afs_operation *op);
 	void (*success)(struct afs_operation *op);
 	void (*aborted)(struct afs_operation *op);
+	void (*failed)(struct afs_operation *op);
 	void (*edit_dir)(struct afs_operation *op);
 	void (*put)(struct afs_operation *op);
 };
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 363d6dd276c0..2b35cba8ad62 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -449,9 +449,6 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 		break;
 	}
 
-	if (req->done)
-		req->done(req);
-
 	_leave(" = 0 [done]");
 	return 0;
 }


