Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C83F4D23A8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 22:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiCHVxy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 16:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiCHVxx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:53:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A90F31EEC5
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 13:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646776374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NzjXlBirb+xRpK0AjbCq+oEkMZQAkLue8HFEU88UcqU=;
        b=hh7iowQ9Ec9wULVO4accRcyIZbXLmY4+YbmfH8KMgZ8E9jPQ3OKB/hwzbjpt0B8jqH+Pnl
        zZVxD4q6pJTgLS3lOQr+RSlvCtbkAiYHusawsFdr3gNORLSrgDFao5MaLHYjy+z1NUew+g
        +SxVjCvabbiT+FyXLVITSE26pNNIOyM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-14iLTJPnONOwL58BgUFfrQ-1; Tue, 08 Mar 2022 16:52:53 -0500
X-MC-Unique: 14iLTJPnONOwL58BgUFfrQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D395800050;
        Tue,  8 Mar 2022 21:52:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4284EADF1;
        Tue,  8 Mar 2022 21:52:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] cachefiles: Fix volume coherency attribute
From:   David Howells <dhowells@redhat.com>
To:     rohiths.msft@gmail.com
Cc:     Steve French <smfrench@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-cachefs@redhat.com, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 08 Mar 2022 21:52:41 +0000
Message-ID: <164677636135.1191348.1664733858863676368.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A network filesystem may set coherency data on a volume cookie, and if
given, cachefiles will store this in an xattr on the directory in the cache
corresponding to the volume.

The function that sets the xattr just stores the contents of the volume
coherency buffer directly into the xattr, with nothing added; the checking
function, on the other hand, has a cut'n'paste error whereby it tries to
interpret the xattr contents as would be the xattr on an ordinary file
(using the cachefiles_xattr struct).  This results in a failure to match
the coherency data because the buffer ends up being shifted by 18 bytes.

Fix this by defining a structure specifically for the volume xattr and
making both the setting and checking functions use it.

Since the volume coherency doesn't work if used, take the opportunity to
insert a reserved field for future use, set it to 0 and check that it is 0.
Log mismatch through the appropriate tracepoint.

Note that this only affects cifs; 9p, afs, ceph and nfs don't use the
volume coherency data at the moment.

Fixes: 32e150037dce ("fscache, cachefiles: Store the volume coherency data")
Reported-by: Rohith Surabattula <rohiths.msft@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <smfrench@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: linux-cachefs@redhat.com
---

 fs/cachefiles/xattr.c             |   23 ++++++++++++++++++++---
 include/trace/events/cachefiles.h |    2 ++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 83f41bd0c3a9..35465109d9c4 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -28,6 +28,11 @@ struct cachefiles_xattr {
 static const char cachefiles_xattr_cache[] =
 	XATTR_USER_PREFIX "CacheFiles.cache";
 
+struct cachefiles_vol_xattr {
+	__be32	reserved;	/* Reserved, should be 0 */
+	__u8	data[];		/* netfs volume coherency data */
+} __packed;
+
 /*
  * set the state xattr on a cache file
  */
@@ -185,6 +190,7 @@ void cachefiles_prepare_to_write(struct fscache_cookie *cookie)
  */
 bool cachefiles_set_volume_xattr(struct cachefiles_volume *volume)
 {
+	struct cachefiles_vol_xattr *buf;
 	unsigned int len = volume->vcookie->coherency_len;
 	const void *p = volume->vcookie->coherency;
 	struct dentry *dentry = volume->dentry;
@@ -192,10 +198,17 @@ bool cachefiles_set_volume_xattr(struct cachefiles_volume *volume)
 
 	_enter("%x,#%d", volume->vcookie->debug_id, len);
 
+	len += sizeof(*buf);
+	buf = kmalloc(len, GFP_KERNEL);
+	if (!buf)
+		return false;
+	buf->reserved = cpu_to_be32(0);
+	memcpy(buf->data, p, len);
+
 	ret = cachefiles_inject_write_error();
 	if (ret == 0)
 		ret = vfs_setxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
-				   p, len, 0);
+				   buf, len, 0);
 	if (ret < 0) {
 		trace_cachefiles_vfs_error(NULL, d_inode(dentry), ret,
 					   cachefiles_trace_setxattr_error);
@@ -209,6 +222,7 @@ bool cachefiles_set_volume_xattr(struct cachefiles_volume *volume)
 					       cachefiles_coherency_vol_set_ok);
 	}
 
+	kfree(buf);
 	_leave(" = %d", ret);
 	return ret == 0;
 }
@@ -218,7 +232,7 @@ bool cachefiles_set_volume_xattr(struct cachefiles_volume *volume)
  */
 int cachefiles_check_volume_xattr(struct cachefiles_volume *volume)
 {
-	struct cachefiles_xattr *buf;
+	struct cachefiles_vol_xattr *buf;
 	struct dentry *dentry = volume->dentry;
 	unsigned int len = volume->vcookie->coherency_len;
 	const void *p = volume->vcookie->coherency;
@@ -228,6 +242,7 @@ int cachefiles_check_volume_xattr(struct cachefiles_volume *volume)
 
 	_enter("");
 
+	len += sizeof(*buf);
 	buf = kmalloc(len, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
@@ -245,7 +260,9 @@ int cachefiles_check_volume_xattr(struct cachefiles_volume *volume)
 					"Failed to read xattr with error %zd", xlen);
 		}
 		why = cachefiles_coherency_vol_check_xattr;
-	} else if (memcmp(buf->data, p, len) != 0) {
+	} else if (buf->reserved != cpu_to_be32(0)) {
+		why = cachefiles_coherency_vol_check_resv;
+	} else if (memcmp(buf->data, p, len - sizeof(*buf)) != 0) {
 		why = cachefiles_coherency_vol_check_cmp;
 	} else {
 		why = cachefiles_coherency_vol_check_ok;
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index 002d0ae4f9bc..311c14a20e70 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -56,6 +56,7 @@ enum cachefiles_coherency_trace {
 	cachefiles_coherency_set_ok,
 	cachefiles_coherency_vol_check_cmp,
 	cachefiles_coherency_vol_check_ok,
+	cachefiles_coherency_vol_check_resv,
 	cachefiles_coherency_vol_check_xattr,
 	cachefiles_coherency_vol_set_fail,
 	cachefiles_coherency_vol_set_ok,
@@ -139,6 +140,7 @@ enum cachefiles_error_trace {
 	EM(cachefiles_coherency_set_ok,		"SET ok  ")		\
 	EM(cachefiles_coherency_vol_check_cmp,	"VOL BAD cmp ")		\
 	EM(cachefiles_coherency_vol_check_ok,	"VOL OK      ")		\
+	EM(cachefiles_coherency_vol_check_resv,	"VOL BAD resv")	\
 	EM(cachefiles_coherency_vol_check_xattr,"VOL BAD xatt")		\
 	EM(cachefiles_coherency_vol_set_fail,	"VOL SET fail")		\
 	E_(cachefiles_coherency_vol_set_ok,	"VOL SET ok  ")


