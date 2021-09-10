Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6201C4072DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 23:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbhIJVUk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 17:20:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22183 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229669AbhIJVUb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 17:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631308752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HVue8DZkwpi3TQg63alM0ZDd2xgCyutp+tbVdRFDU8A=;
        b=cdrECxZJxbli7bakME+pWoegDqNeyULQjopsShD7RgaSlMLeTiBo1tZ8Rra/Szidk6Omv8
        +6Gv5v0q3VprZXiIx7/fn7qrczuO0hMg18BPFnCDPHlNeE78n+dfwCg2jJ2aylVCw/cCUu
        IsV13ZJ5Gv6wVq/4BMjRBc3JxmiGZXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-7L6MxjnyM1iZ_Vqz43xusw-1; Fri, 10 Sep 2021 17:19:11 -0400
X-MC-Unique: 7L6MxjnyM1iZ_Vqz43xusw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBBDF835DE0;
        Fri, 10 Sep 2021 21:19:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79CF91000320;
        Fri, 10 Sep 2021 21:19:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <163111665183.283156.17200205573146438918.stgit@warthog.procyon.org.uk>
References: <163111665183.283156.17200205573146438918.stgit@warthog.procyon.org.uk>
To:     linux-afs@lists.infradead.org, openafs-devel@openafs.org
Cc:     dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
        Markus Suvanto <markus.suvanto@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/6] afs: Fix corruption in reads at fpos 2G-4G from an OpenAFS server
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <951331.1631308745.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 10 Sep 2021 22:19:05 +0100
Message-ID: <951332.1631308745@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

    =

AFS-3 has two data fetch RPC variants, FS.FetchData and FS.FetchData64, an=
d
Linux's afs client switches between them when talking to a non-YFS server
if the read size, the file position or the sum of the two have the upper 3=
2
bits set of the 64-bit value.

This is a problem, however, since the file position and length fields of
FS.FetchData are *signed* 32-bit values.

Fix this by capturing the capability bits obtained from the fileserver whe=
n
it's sent an FS.GetCapabilities RPC, rather than just discarding them, and
then picking out the VICED_CAPABILITY_64BITFILES flag.  This can then be
used to decide whether to use FS.FetchData or FS.FetchData64 - and also
FS.StoreData or FS.StoreData64 - rather than using upper_32_bits() to
switch on the parameter values.

This capabilities flag could also be used to limit the maximum size of the
file, but all servers must be checked for that.

Note that the issue does not exist with FS.StoreData - that uses *unsigned=
*
32-bit values.  It's also not a problem with Auristor servers as its
YFS.FetchData64 op uses unsigned 64-bit values.

This can be tested by cloning a git repo through an OpenAFS client to an
OpenAFS server and then doing "git status" on it from a Linux afs
client[1].  Provided the clone has a pack file that's in the 2G-4G range,
the git status will show errors like:

        error: packfile .git/objects/pack/pack-5e813c51d12b6847bbc0fcd97c2=
bca66da50079c.pack does not match index
        error: packfile .git/objects/pack/pack-5e813c51d12b6847bbc0fcd97c2=
bca66da50079c.pack does not match index

This can be observed in the server's FileLog with something like the
following appearing:

Sun Aug 29 19:31:39 2021 SRXAFS_FetchData, Fid =3D 2303380852.491776.32631=
14, Host 192.168.11.201:7001, Id 1001
Sun Aug 29 19:31:39 2021 CheckRights: len=3D0, for host=3D192.168.11.201:7=
001
Sun Aug 29 19:31:39 2021 FetchData_RXStyle: Pos 18446744071815340032, Len =
3154
Sun Aug 29 19:31:39 2021 FetchData_RXStyle: file size 2400758866
...
Sun Aug 29 19:31:40 2021 SRXAFS_FetchData returns 5

Note the file position of 18446744071815340032.  This is the requested fil=
e
position sign-extended.

Fixes: b9b1f8d5930a ("AFS: write support fixes")
Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
Tested-by: Markus Suvanto <markus.suvanto@gmail.com>
cc: linux-afs@lists.infradead.org
cc: openafs-devel@openafs.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D214217#c9 [1]
---
 fs/afs/fs_probe.c     |    8 +++++++-
 fs/afs/fsclient.c     |   31 ++++++++++++++++++++-----------
 fs/afs/internal.h     |    1 +
 fs/afs/protocol_afs.h |   15 +++++++++++++++
 fs/afs/protocol_yfs.h |    6 ++++++
 5 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index e7e98ad63a91..c0031a3ab42f 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include "afs_fs.h"
 #include "internal.h"
+#include "protocol_afs.h"
 #include "protocol_yfs.h"
 =

 static unsigned int afs_fs_probe_fast_poll_interval =3D 30 * HZ;
@@ -102,7 +103,7 @@ void afs_fileserver_probe_result(struct afs_call *call=
)
 	struct afs_addr_list *alist =3D call->alist;
 	struct afs_server *server =3D call->server;
 	unsigned int index =3D call->addr_ix;
-	unsigned int rtt_us =3D 0;
+	unsigned int rtt_us =3D 0, cap0;
 	int ret =3D call->error;
 =

 	_enter("%pU,%u", &server->uuid, index);
@@ -159,6 +160,11 @@ void afs_fileserver_probe_result(struct afs_call *cal=
l)
 			clear_bit(AFS_SERVER_FL_IS_YFS, &server->flags);
 			alist->addrs[index].srx_service =3D call->service_id;
 		}
+		cap0 =3D ntohl(call->tmp);
+		if (cap0 & AFS3_VICED_CAPABILITY_64BITFILES)
+			set_bit(AFS_SERVER_FL_HAS_FS64, &server->flags);
+		else
+			clear_bit(AFS_SERVER_FL_HAS_FS64, &server->flags);
 	}
 =

 	if (rxrpc_kernel_get_srtt(call->net->socket, call->rxcall, &rtt_us) &&
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index dd3f45d906d2..4943413d9c5f 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -456,9 +456,7 @@ void afs_fs_fetch_data(struct afs_operation *op)
 	struct afs_read *req =3D op->fetch.req;
 	__be32 *bp;
 =

-	if (upper_32_bits(req->pos) ||
-	    upper_32_bits(req->len) ||
-	    upper_32_bits(req->pos + req->len))
+	if (test_bit(AFS_SERVER_FL_HAS_FS64, &op->server->flags))
 		return afs_fs_fetch_data64(op);
 =

 	_enter("");
@@ -1113,9 +1111,7 @@ void afs_fs_store_data(struct afs_operation *op)
 	       (unsigned long long)op->store.pos,
 	       (unsigned long long)op->store.i_size);
 =

-	if (upper_32_bits(op->store.pos) ||
-	    upper_32_bits(op->store.size) ||
-	    upper_32_bits(op->store.i_size))
+	if (test_bit(AFS_SERVER_FL_HAS_FS64, &op->server->flags))
 		return afs_fs_store_data64(op);
 =

 	call =3D afs_alloc_flat_call(op->net, &afs_RXFSStoreData,
@@ -1229,7 +1225,7 @@ static void afs_fs_setattr_size(struct afs_operation=
 *op)
 	       key_serial(op->key), vp->fid.vid, vp->fid.vnode);
 =

 	ASSERT(attr->ia_valid & ATTR_SIZE);
-	if (upper_32_bits(attr->ia_size))
+	if (test_bit(AFS_SERVER_FL_HAS_FS64, &op->server->flags))
 		return afs_fs_setattr_size64(op);
 =

 	call =3D afs_alloc_flat_call(op->net, &afs_RXFSStoreData_as_Status,
@@ -1657,20 +1653,33 @@ static int afs_deliver_fs_get_capabilities(struct =
afs_call *call)
 			return ret;
 =

 		count =3D ntohl(call->tmp);
-
 		call->count =3D count;
 		call->count2 =3D count;
-		afs_extract_discard(call, count * sizeof(__be32));
+		if (count =3D=3D 0) {
+			call->unmarshall =3D 4;
+			call->tmp =3D 0;
+			break;
+		}
+
+		/* Extract the first word of the capabilities to call->tmp */
+		afs_extract_to_tmp(call);
 		call->unmarshall++;
 		fallthrough;
 =

-		/* Extract capabilities words */
 	case 2:
 		ret =3D afs_extract_data(call, false);
 		if (ret < 0)
 			return ret;
 =

-		/* TODO: Examine capabilities */
+		afs_extract_discard(call, (count - 1) * sizeof(__be32));
+		call->unmarshall++;
+		fallthrough;
+
+		/* Extract remaining capabilities words */
+	case 3:
+		ret =3D afs_extract_data(call, false);
+		if (ret < 0)
+			return ret;
 =

 		call->unmarshall++;
 		break;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index c97618855b46..b0fe27ae60db 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -520,6 +520,7 @@ struct afs_server {
 #define AFS_SERVER_FL_IS_YFS	16		/* Server is YFS not AFS */
 #define AFS_SERVER_FL_NO_IBULK	17		/* Fileserver doesn't support FS.Inlin=
eBulkStatus */
 #define AFS_SERVER_FL_NO_RM2	18		/* Fileserver doesn't support YFS.Remove=
File2 */
+#define AFS_SERVER_FL_HAS_FS64	19		/* Fileserver supports FS.{Fetch,Store=
}Data64 */
 	atomic_t		ref;		/* Object refcount */
 	atomic_t		active;		/* Active user count */
 	u32			addr_version;	/* Address list version */
diff --git a/fs/afs/protocol_afs.h b/fs/afs/protocol_afs.h
new file mode 100644
index 000000000000..0c39358c8b70
--- /dev/null
+++ b/fs/afs/protocol_afs.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* AFS protocol bits
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+
+#define AFSCAPABILITIESMAX 196 /* Maximum number of words in a capability=
 set */
+
+/* AFS3 Fileserver capabilities word 0 */
+#define AFS3_VICED_CAPABILITY_ERRORTRANS	0x0001 /* Uses UAE errors */
+#define AFS3_VICED_CAPABILITY_64BITFILES	0x0002 /* FetchData64 & StoreDat=
a64 supported */
+#define AFS3_VICED_CAPABILITY_WRITELOCKACL	0x0004 /* Can lock a file even=
 without lock perm */
+#define AFS3_VICED_CAPABILITY_SANEACLS		0x0008 /* ACLs reviewed for sanit=
y - don't use */
diff --git a/fs/afs/protocol_yfs.h b/fs/afs/protocol_yfs.h
index b5bd03b1d3c7..e4cd89c44c46 100644
--- a/fs/afs/protocol_yfs.h
+++ b/fs/afs/protocol_yfs.h
@@ -168,3 +168,9 @@ enum yfs_lock_type {
 	yfs_LockMandatoryWrite	=3D 0x101,
 	yfs_LockMandatoryExtend	=3D 0x102,
 };
+
+/* RXYFS Viced Capability Flags */
+#define YFS_VICED_CAPABILITY_ERRORTRANS		0x0001 /* Deprecated v0.195 */
+#define YFS_VICED_CAPABILITY_64BITFILES		0x0002 /* Deprecated v0.195 */
+#define YFS_VICED_CAPABILITY_WRITELOCKACL	0x0004 /* Can lock a file even =
without lock perm */
+#define YFS_VICED_CAPABILITY_SANEACLS		0x0008 /* Deprecated v0.195 */

