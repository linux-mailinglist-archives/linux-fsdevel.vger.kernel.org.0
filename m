Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF7C1E8AC2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 00:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgE2WCX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 18:02:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32206 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728664AbgE2WCQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 18:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590789734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=td3wUkgMmsmLo6pvsmyZIw+X4X46MZpbUJaWYRqcTg0=;
        b=MS01TzGZcQu6pVxVj7eZWqgF2On9eDL02+2Q713TA9rEkhtj7kbu+7LG6g7cidgCP4jWF3
        XVxnImZHOAkzMFQXxGPsIbUC6Y81MoXWaeYAVLsuZ2lApIE9fV+KvuButN2XUyGrjphvhW
        EH3/L+a+UDHdTidT+IJCWuYF2aPBBJc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-6PgsIy6aOIyOTYn091ozSw-1; Fri, 29 May 2020 18:02:10 -0400
X-MC-Unique: 6PgsIy6aOIyOTYn091ozSw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB9F380183C;
        Fri, 29 May 2020 22:02:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E598D5C1B5;
        Fri, 29 May 2020 22:02:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 17/27] afs: Implement client support for the YFSVL.GetCellName
 RPC op
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 29 May 2020 23:02:08 +0100
Message-ID: <159078972817.679399.17315198460101750263.stgit@warthog.procyon.org.uk>
In-Reply-To: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
References: <159078959973.679399.15496997680826127470.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement client support for the YFSVL.GetCellName RPC operation by which
YFS permits the canonical cell name to be queried from a VL server.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/afs.h               |    2 -
 fs/afs/afs_vl.h            |    1 
 fs/afs/internal.h          |    2 +
 fs/afs/protocol_yfs.h      |    2 -
 fs/afs/vlclient.c          |  111 ++++++++++++++++++++++++++++++++++++++++++++
 include/trace/events/afs.h |    4 ++
 6 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/fs/afs/afs.h b/fs/afs/afs.h
index f8e34406243e..432cb4b23961 100644
--- a/fs/afs/afs.h
+++ b/fs/afs/afs.h
@@ -10,7 +10,7 @@
 
 #include <linux/in.h>
 
-#define AFS_MAXCELLNAME		64  	/* Maximum length of a cell name */
+#define AFS_MAXCELLNAME		256  	/* Maximum length of a cell name */
 #define AFS_MAXVOLNAME		64  	/* Maximum length of a volume name */
 #define AFS_MAXNSERVERS		8   	/* Maximum servers in a basic volume record */
 #define AFS_NMAXNSERVERS	13  	/* Maximum servers in a N/U-class volume record */
diff --git a/fs/afs/afs_vl.h b/fs/afs/afs_vl.h
index e9b8029920ec..9c65ffb8a523 100644
--- a/fs/afs/afs_vl.h
+++ b/fs/afs/afs_vl.h
@@ -22,6 +22,7 @@ enum AFSVL_Operations {
 	VLGETENTRYBYNAMEU	= 527,	/* AFS Get VLDB entry by name (UUID-variant) */
 	VLGETADDRSU		= 533,	/* AFS Get addrs for fileserver */
 	YVLGETENDPOINTS		= 64002, /* YFS Get endpoints for file/volume server */
+	YVLGETCELLNAME		= 64014, /* YFS Get actual cell name */
 	VLGETCAPABILITIES	= 65537, /* AFS Get server capabilities */
 };
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index dce03e068cab..3606cfa50832 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -116,6 +116,7 @@ struct afs_call {
 		long			ret0;	/* Value to reply with instead of 0 */
 		struct afs_addr_list	*ret_alist;
 		struct afs_vldb_entry	*ret_vldb;
+		char			*ret_str;
 	};
 	struct afs_operation	*op;
 	unsigned int		server_index;
@@ -1373,6 +1374,7 @@ extern struct afs_addr_list *afs_vl_get_addrs_u(struct afs_vl_cursor *, const uu
 extern struct afs_call *afs_vl_get_capabilities(struct afs_net *, struct afs_addr_cursor *,
 						struct key *, struct afs_vlserver *, unsigned int);
 extern struct afs_addr_list *afs_yfsvl_get_endpoints(struct afs_vl_cursor *, const uuid_t *);
+extern char *afs_yfsvl_get_cell_name(struct afs_vl_cursor *);
 
 /*
  * vl_probe.c
diff --git a/fs/afs/protocol_yfs.h b/fs/afs/protocol_yfs.h
index 32be9c698348..b5bd03b1d3c7 100644
--- a/fs/afs/protocol_yfs.h
+++ b/fs/afs/protocol_yfs.h
@@ -8,7 +8,7 @@
 #define YFS_FS_SERVICE	2500
 #define YFS_CM_SERVICE	2501
 
-#define YFSCBMAX 1024
+#define YFSCBMAX	1024
 
 enum YFS_CM_Operations {
 	YFSCBProbe		= 206,	/* probe client */
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index d0c85623ce8f..fd82850cd424 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -645,3 +645,114 @@ struct afs_addr_list *afs_yfsvl_get_endpoints(struct afs_vl_cursor *vc,
 	afs_make_call(&vc->ac, call, GFP_KERNEL);
 	return (struct afs_addr_list *)afs_wait_for_call_to_complete(call, &vc->ac);
 }
+
+/*
+ * Deliver reply data to a YFSVL.GetCellName operation.
+ */
+static int afs_deliver_yfsvl_get_cell_name(struct afs_call *call)
+{
+	char *cell_name;
+	u32 namesz, paddedsz;
+	int ret;
+
+	_enter("{%u,%zu/%u}",
+	       call->unmarshall, iov_iter_count(call->iter), call->count);
+
+	switch (call->unmarshall) {
+	case 0:
+		afs_extract_to_tmp(call);
+		call->unmarshall++;
+
+		/* Fall through - and extract the cell name length */
+	case 1:
+		ret = afs_extract_data(call, true);
+		if (ret < 0)
+			return ret;
+
+		namesz = ntohl(call->tmp);
+		if (namesz > AFS_MAXCELLNAME)
+			return afs_protocol_error(call, afs_eproto_cellname_len);
+		paddedsz = (namesz + 3) & ~3;
+		call->count = namesz;
+		call->count2 = paddedsz - namesz;
+
+		cell_name = kmalloc(namesz + 1, GFP_KERNEL);
+		if (!cell_name)
+			return -ENOMEM;
+		cell_name[namesz] = 0;
+		call->ret_str = cell_name;
+
+		afs_extract_begin(call, cell_name, namesz);
+		call->unmarshall++;
+
+		/* Fall through - and extract cell name */
+	case 2:
+		ret = afs_extract_data(call, true);
+		if (ret < 0)
+			return ret;
+
+		afs_extract_discard(call, call->count2);
+		call->unmarshall++;
+
+		/* Fall through - and extract padding */
+	case 3:
+		ret = afs_extract_data(call, false);
+		if (ret < 0)
+			return ret;
+
+		call->unmarshall++;
+		break;
+	}
+
+	_leave(" = 0 [done]");
+	return 0;
+}
+
+static void afs_destroy_yfsvl_get_cell_name(struct afs_call *call)
+{
+	kfree(call->ret_str);
+	afs_flat_call_destructor(call);
+}
+
+/*
+ * VL.GetCapabilities operation type
+ */
+static const struct afs_call_type afs_YFSVLGetCellName = {
+	.name		= "YFSVL.GetCellName",
+	.op		= afs_YFSVL_GetCellName,
+	.deliver	= afs_deliver_yfsvl_get_cell_name,
+	.destructor	= afs_destroy_yfsvl_get_cell_name,
+};
+
+/*
+ * Probe a volume server for the capabilities that it supports.  This can
+ * return up to 196 words.
+ *
+ * We use this to probe for service upgrade to determine what the server at the
+ * other end supports.
+ */
+char *afs_yfsvl_get_cell_name(struct afs_vl_cursor *vc)
+{
+	struct afs_call *call;
+	struct afs_net *net = vc->cell->net;
+	__be32 *bp;
+
+	_enter("");
+
+	call = afs_alloc_flat_call(net, &afs_YFSVLGetCellName, 1 * 4, 0);
+	if (!call)
+		return ERR_PTR(-ENOMEM);
+
+	call->key = vc->key;
+	call->ret_str = NULL;
+	call->max_lifespan = AFS_VL_MAX_LIFESPAN;
+
+	/* marshall the parameters */
+	bp = call->request;
+	*bp++ = htonl(YVLGETCELLNAME);
+
+	/* Can't take a ref on server */
+	trace_afs_make_vl_call(call);
+	afs_make_call(&vc->ac, call, GFP_KERNEL);
+	return (char *)afs_wait_for_call_to_complete(call, &vc->ac);
+}
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index f4d66919fb22..f320b3ad54da 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -111,6 +111,7 @@ enum afs_vl_operation {
 	afs_VL_GetEntryByNameU	= 527,		/* AFS Get Vol Entry By Name operation ID */
 	afs_VL_GetAddrsU	= 533,		/* AFS Get FS server addresses */
 	afs_YFSVL_GetEndpoints	= 64002,	/* YFS Get FS & Vol server addresses */
+	afs_YFSVL_GetCellName	= 64014,	/* YFS Get actual cell name */
 	afs_VL_GetCapabilities	= 65537,	/* AFS Get VL server capabilities */
 };
 
@@ -143,6 +144,7 @@ enum afs_eproto_cause {
 	afs_eproto_bad_status,
 	afs_eproto_cb_count,
 	afs_eproto_cb_fid_count,
+	afs_eproto_cellname_len,
 	afs_eproto_file_type,
 	afs_eproto_ibulkst_cb_count,
 	afs_eproto_ibulkst_count,
@@ -316,6 +318,7 @@ enum afs_cb_break_reason {
 	EM(afs_VL_GetEntryByNameU,		"VL.GetEntryByNameU") \
 	EM(afs_VL_GetAddrsU,			"VL.GetAddrsU") \
 	EM(afs_YFSVL_GetEndpoints,		"YFSVL.GetEndpoints") \
+	EM(afs_YFSVL_GetCellName,		"YFSVL.GetCellName") \
 	E_(afs_VL_GetCapabilities,		"VL.GetCapabilities")
 
 #define afs_edit_dir_ops				  \
@@ -345,6 +348,7 @@ enum afs_cb_break_reason {
 	EM(afs_eproto_bad_status,	"BadStatus") \
 	EM(afs_eproto_cb_count,		"CbCount") \
 	EM(afs_eproto_cb_fid_count,	"CbFidCount") \
+	EM(afs_eproto_cellname_len,	"CellNameLen") \
 	EM(afs_eproto_file_type,	"FileTYpe") \
 	EM(afs_eproto_ibulkst_cb_count,	"IBS.CbCount") \
 	EM(afs_eproto_ibulkst_count,	"IBS.FidCount") \


