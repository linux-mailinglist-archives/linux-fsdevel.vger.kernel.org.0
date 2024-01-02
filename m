Return-Path: <linux-fsdevel+bounces-7134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93763822089
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 18:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41F12B21ED9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 17:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA37154AB;
	Tue,  2 Jan 2024 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SeNwrq0G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B181549F
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jan 2024 17:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704217521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qpYK3XlrSVzoiQg06tW9BiOzquqDi+TLEnPuE5AD4b8=;
	b=SeNwrq0Gw1OiW+sUuvZoenGOjgVt5QvujesLy93Rd+jjJS9pprTSepBI7m48F/KeDokvN0
	Xit89YVqAR7CFyfW3tg4+P+lQnEe1OyTKQGno4ulhSQ2stZiruzKKobcJkNENC2xuCmUkK
	q93YIMgfKK+jUI6xFzuasRpq+C4pYxc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-ms8k78quM8idEC82V53Hmg-1; Tue, 02 Jan 2024 12:45:18 -0500
X-MC-Unique: ms8k78quM8idEC82V53Hmg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A1F285A589;
	Tue,  2 Jan 2024 17:45:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.68])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3B6441121313;
	Tue,  2 Jan 2024 17:45:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <140431.1704208899@warthog.procyon.org.uk>
References: <140431.1704208899@warthog.procyon.org.uk>
To: Jeffrey Altman <jaltman@auristor.com>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Fix error handling with lookup via FS.InlineBulkStatus
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <238256.1704217516.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jan 2024 17:45:16 +0000
Message-ID: <238257.1704217516@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Here's a version of the patch against v6.7-rc7 rather than my afs-fix-rota=
tion
branch.

---
afs: Fix error handling with lookup via FS.InlineBulkStatus

When afs does a lookup, it tries to use FS.InlineBulkStatus to preemptivel=
y
look up a bunch of files in the parent directory and cache this locally, o=
n
the basis that we might want to look at them too (for example if someone
does an ls on a directory, they may want want to then stat every file
listed).

FS.InlineBulkStatus can be considered a compound op with the normal abort
code applying to the compound as a whole.  Each status fetch within the
compound is then given its own individual abort code - but assuming no
error that prevents the bulk fetch from returning the compound result will
be 0, even if all the constituent status fetches failed.

At the conclusion of afs_do_lookup(), we should use the abort code from th=
e
appropriate status to determine the error to return, if any - but instead
it is assumed that we were successful if the op as a whole succeeded and w=
e
return an incompletely initialised inode, resulting in ENOENT, no matter
the actual reason.  In the particular instance reported, a vnode with no
permission granted to be accessed is being given a UAEACCES abort code
which should be reported as EACCES, but is instead being reported as
ENOENT.

Fix this by abandoning the inode (which will be cleaned up with the op) if
file[1] has an abort code indicated and turn that abort code into an error
instead.

Whilst we're at it, add a tracepoint so that the abort codes of the
individual subrequests of FS.InlineBulkStatus can be logged.  At the momen=
t
only the container abort code can be 0.

Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" conc=
ept")
Reported-by: Jeffrey Altman <jaltman@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/dir.c               |   11 ++++++++---
 include/trace/events/afs.h |   25 +++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 5219182e52e1..a9dcb9d994e4 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -707,6 +707,8 @@ static void afs_do_lookup_success(struct afs_operation=
 *op)
 			break;
 		}
 =

+		if (vp->scb.status.abort_code)
+			trace_afs_bulkstat_error(op, &vp->fid, i, vp->scb.status.abort_code);
 		if (!vp->scb.have_status && !vp->scb.have_error)
 			continue;
 =

@@ -895,12 +897,15 @@ static struct inode *afs_do_lookup(struct inode *dir=
, struct dentry *dentry,
 		afs_begin_vnode_operation(op);
 		afs_wait_for_operation(op);
 	}
-	inode =3D ERR_PTR(op->error);
 =

 out_op:
 	if (op->error =3D=3D 0) {
-		inode =3D &op->file[1].vnode->netfs.inode;
-		op->file[1].vnode =3D NULL;
+		if (op->file[1].scb.status.abort_code) {
+			op->error =3D afs_abort_to_error(op->file[1].scb.status.abort_code);
+		} else {
+			inode =3D &op->file[1].vnode->netfs.inode;
+			op->file[1].vnode =3D NULL;
+		}
 	}
 =

 	if (op->file[0].scb.have_status)
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index e9d412d19dbb..caec276515dc 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -1216,6 +1216,31 @@ TRACE_EVENT(afs_file_error,
 		      __print_symbolic(__entry->where, afs_file_errors))
 	    );
 =

+TRACE_EVENT(afs_bulkstat_error,
+	    TP_PROTO(struct afs_operation *op, struct afs_fid *fid, unsigned int=
 index, s32 abort),
+
+	    TP_ARGS(op, fid, index, abort),
+
+	    TP_STRUCT__entry(
+		    __field_struct(struct afs_fid,	fid)
+		    __field(unsigned int,		op)
+		    __field(unsigned int,		index)
+		    __field(s32,			abort)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->op =3D op->debug_id;
+		    __entry->fid =3D *fid;
+		    __entry->index =3D index;
+		    __entry->abort =3D abort;
+			   ),
+
+	    TP_printk("OP=3D%08x[%02x] %llx:%llx:%x a=3D%d",
+		      __entry->op, __entry->index,
+		      __entry->fid.vid, __entry->fid.vnode, __entry->fid.unique,
+		      __entry->abort)
+	    );
+
 TRACE_EVENT(afs_cm_no_server,
 	    TP_PROTO(struct afs_call *call, struct sockaddr_rxrpc *srx),
 =



