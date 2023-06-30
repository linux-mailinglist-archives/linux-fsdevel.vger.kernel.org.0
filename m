Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111B0743ED8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 17:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjF3P2c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 11:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjF3P1Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:27:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A5F3C38
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 08:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688138751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7s8hoY7EpXAbXFSpowadN1tdtKV1KZLtOvJuBTKdpmw=;
        b=Lr1mt6/FzEJLOy/mgkm6vnkERCZ9L45DWFD9H9GvABk1sJ/o6vtNaEXogz1LYlJNau90/X
        yvs1SyhdlNbtUSBdb23c0guk7EkDin54zqlFG4DWIWs0oVXVRY0EcfHR8oQs4JtefjGTTP
        d1ZxZk+AQmT6Ar6av15g1mzASAdfrAg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-Zp02hgoBNIOVX0nerBYChA-1; Fri, 30 Jun 2023 11:25:50 -0400
X-MC-Unique: Zp02hgoBNIOVX0nerBYChA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C5C23C0E456;
        Fri, 30 Jun 2023 15:25:49 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18E074087C6A;
        Fri, 30 Jun 2023 15:25:45 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        linux-cifs@vger.kernel.org
Subject: [RFC PATCH 07/11] cifs: Drop the check using iov_iter_rw()
Date:   Fri, 30 Jun 2023 16:25:20 +0100
Message-ID: <20230630152524.661208-8-dhowells@redhat.com>
In-Reply-To: <20230630152524.661208-1-dhowells@redhat.com>
References: <20230630152524.661208-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

smbd_recv() has a check that the iterator is the correct direction.  Drop
this check as we're getting rid of iov_iter_rw().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@cjr.nz>
cc: Ronnie Sahlberg <lsahlber@redhat.com>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christian Brauner <christian@brauner.io>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: linux-cifs@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/smbdirect.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index 223e17c16b60..672078d00207 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -1906,14 +1906,6 @@ int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
 	unsigned int to_read, page_offset;
 	int rc;
 
-	if (iov_iter_rw(&msg->msg_iter) == WRITE) {
-		/* It's a bug in upper layer to get there */
-		cifs_dbg(VFS, "Invalid msg iter dir %u\n",
-			 iov_iter_rw(&msg->msg_iter));
-		rc = -EINVAL;
-		goto out;
-	}
-
 	switch (iov_iter_type(&msg->msg_iter)) {
 	case ITER_KVEC:
 		buf = msg->msg_iter.kvec->iov_base;
@@ -1935,7 +1927,6 @@ int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
 		rc = -EINVAL;
 	}
 
-out:
 	/* SMBDirect will read it all or nothing */
 	if (rc > 0)
 		msg->msg_iter.count = 0;

