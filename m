Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178D04CA799
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 15:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242800AbiCBOLD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 09:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242824AbiCBOK7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:10:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFFBAC792B
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Mar 2022 06:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646230146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cGRjm9CqiAVZuRkrubfLWr0efH+3TP9X7iGZR/3gMyI=;
        b=d+DreluKXSl0WgTDcyu7REEDDEWajhPvQFI7IDc1x9JE/SD5oPs8nz52o5+Hm6HpgJheRS
        cZiShTqpfvZ0936vfWWgdcgBl71g7PgNVAu0sHy++uxGd791loYIG9ITnrOuzd8rqESDVH
        CQT3bh9+5iHmGTFJG1BMlDrbqs7uqNw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-456-ZT2f9o0CMGKkc1FdMHK2vw-1; Wed, 02 Mar 2022 09:09:02 -0500
X-MC-Unique: ZT2f9o0CMGKkc1FdMHK2vw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 086C1824FA6;
        Wed,  2 Mar 2022 14:09:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 203317B8C1;
        Wed,  2 Mar 2022 14:08:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 18/19] netfs: Keep track of the actual remote file size
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 02 Mar 2022 14:08:57 +0000
Message-ID: <164623013727.3564931.17659955636985232717.stgit@warthog.procyon.org.uk>
In-Reply-To: <164622970143.3564931.3656393397237724303.stgit@warthog.procyon.org.uk>
References: <164622970143.3564931.3656393397237724303.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a place in which to keep track of the actual remote file size in
the netfs context.  This is needed because inode->i_size will be updated as
we buffer writes in the pagecache, but the server file size won't get
updated until we flush them back.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 include/linux/netfs.h |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index c925596c1bb3..7049782b41f0 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -126,6 +126,7 @@ struct netfs_i_context {
 #if IS_ENABLED(CONFIG_FSCACHE)
 	struct fscache_cookie	*cache;
 #endif
+	loff_t			remote_i_size;	/* Size of the remote file */
 };
 
 /*
@@ -324,6 +325,21 @@ static inline void netfs_i_context_init(struct inode *inode,
 
 	memset(ctx, 0, sizeof(*ctx));
 	ctx->ops = ops;
+	ctx->remote_i_size = i_size_read(inode);
+}
+
+/**
+ * netfs_resize_file - Note that a file got resized
+ * @inode: The inode being resized
+ * @new_i_size: The new file size
+ *
+ * Inform the netfs lib that a file got resized so that it can adjust its state.
+ */
+static inline void netfs_resize_file(struct inode *inode, loff_t new_i_size)
+{
+	struct netfs_i_context *ctx = netfs_i_context(inode);
+
+	ctx->remote_i_size = new_i_size;
 }
 
 /**


