Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652FE4D4EF5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 17:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241562AbiCJQXP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 11:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244334AbiCJQW6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:22:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D0E419BE4B
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 08:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646929236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4VDtuLWXavBV/HS2lCkWzp80ZEjJiDU9cATmIiTQeMQ=;
        b=H6t8Iy5cVI5RoYEQ/HNw3I+ozz8Ws42NIln+dYVAPBq0Htdrt0+zJUg7LmTmSKHOM1dZAx
        x1HkK1aCZzio5+aoAoXheJ24WTBHs7lkJ1eGkGKVGhoewo84Jnh76HHGqcR1IEuSWFvauQ
        QFepy7lSUedUFtIGqHTznr2elkU0Fno=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-85-fKSWy9FZOjiXgqUdR_ymBA-1; Thu, 10 Mar 2022 11:20:34 -0500
X-MC-Unique: fKSWy9FZOjiXgqUdR_ymBA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA8921006AA5;
        Thu, 10 Mar 2022 16:20:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81B261073025;
        Thu, 10 Mar 2022 16:20:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 19/20] netfs: Keep track of the actual remote file size
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Jeff Layton <jlayton@kernel.org>, dhowells@redhat.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
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
Date:   Thu, 10 Mar 2022 16:20:18 +0000
Message-ID: <164692921865.2099075.5310757978508056134.stgit@warthog.procyon.org.uk>
In-Reply-To: <164692883658.2099075.5745824552116419504.stgit@warthog.procyon.org.uk>
References: <164692883658.2099075.5745824552116419504.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/164623013727.3564931.17659955636985232717.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/164678219305.1200972.6459431995188365134.stgit@warthog.procyon.org.uk/ # v2
---

 include/linux/netfs.h |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 8458b30172a5..c7bf1eaf51d5 100644
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


