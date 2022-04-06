Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9EC4F6E5F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 01:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237683AbiDFXHK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 19:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237646AbiDFXGe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 19:06:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0BF0E5
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Apr 2022 16:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649286275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q1tSsE6QNgYZ78bN7KiJubCT50PcBaB/EJFk09P7vaY=;
        b=BYMrTjQ7iBqdvoaEOMjjz9f9cmJ54D/rMfKI2g7G7P3f7PBTwRrR54sKBYEBNVD7G0oSnj
        j1FE5v/ByzAPKrI6YzrsJa14XY89v89lbOMs+aEsf6R8lIysExm0pOMY1ihT5chlqZkpRZ
        s0RBvzOOCBe0dWOjEPHNqZw2ZF74ULs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-363-tq_9NYBMMFGQEmOalP5MjA-1; Wed, 06 Apr 2022 19:04:31 -0400
X-MC-Unique: tq_9NYBMMFGQEmOalP5MjA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C36C100BAA6;
        Wed,  6 Apr 2022 23:04:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 065CCC28102;
        Wed,  6 Apr 2022 23:04:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 09/14] cifs: Put credits into cifs_io_subrequest,
 not on the stack
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        linux-cifs@vger.kernel.org, dhowells@redhat.com,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@redhat.com>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Date:   Thu, 07 Apr 2022 00:04:29 +0100
Message-ID: <164928626929.457102.8462570553817391746.stgit@warthog.procyon.org.uk>
In-Reply-To: <164928615045.457102.10607899252434268982.stgit@warthog.procyon.org.uk>
References: <164928615045.457102.10607899252434268982.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the credits into the cifs_io_subrequest struct rather than placing them
on the stack.  They are then allocated by netfslib when it allocates its
netfs_io_subrequest.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: linux-cifs@vger.kernel.org
---

 fs/cifs/file.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index fb2885134154..fc3a46f7e2cf 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3450,7 +3450,6 @@ static void cifs_req_issue_read(struct netfs_io_subrequest *subreq)
 	struct cifs_io_subrequest *rdata = container_of(subreq, struct cifs_io_subrequest, subreq);
 	struct cifsFileInfo *open_file = rreq->netfs_priv;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(rreq->inode->i_sb);
-	struct cifs_credits credits_on_stack, *credits = &credits_on_stack;
 	unsigned int xid;
 	pid_t pid;
 	int rc = 0;
@@ -3482,7 +3481,8 @@ static void cifs_req_issue_read(struct netfs_io_subrequest *subreq)
 			server->ops->negotiate_rsize(tlink_tcon(open_file->tlink),
 						     cifs_sb->ctx);
 
-	rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->rsize, &rsize, credits);
+	rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->rsize, &rsize,
+					   &rdata->credits);
 	if (rc)
 		goto out;
 
@@ -3492,7 +3492,6 @@ static void cifs_req_issue_read(struct netfs_io_subrequest *subreq)
 	rdata->offset	= subreq->start + subreq->transferred;
 	rdata->bytes	= subreq->len   - subreq->transferred;
 	rdata->pid	= pid;
-	rdata->credits	= credits_on_stack;
 
 	rc = adjust_credits(server, &rdata->credits, rdata->bytes);
 	if (!rc) {
@@ -3502,11 +3501,6 @@ static void cifs_req_issue_read(struct netfs_io_subrequest *subreq)
 			rc = server->ops->async_readv(rdata);
 	}
 
-	if (rc) {
-		add_credits_and_wake_if(server, &rdata->credits, 0);
-		/* Fallback to the readpage in error/reconnect cases */
-	}
-
 out:
 	free_xid(xid);
 	if (rc)
@@ -3584,6 +3578,8 @@ static void cifs_free_subrequest(struct netfs_io_subrequest *subreq)
 			rdata->mr = NULL;
 		}
 #endif
+
+		add_credits_and_wake_if(rdata->server, &rdata->credits, 0);
 		if (rdata->cfile)
 			cifsFileInfo_put(rdata->cfile);
 	}


