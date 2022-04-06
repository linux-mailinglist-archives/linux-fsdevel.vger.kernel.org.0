Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F314F6E66
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 01:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbiDFXI3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 19:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237881AbiDFXHM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 19:07:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BEFD8BE35
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Apr 2022 16:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649286304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YNMo/SAmN5COvruoOaXWNV1vlVqErYE4oAVAoDsX+LI=;
        b=Ctk9aRi6rgrFF/2r1UaMJy0zt9eiXJZT2n8uUBzL4XYk6RtBc4LqjegiIORcRTU1T/pQ5D
        sqdgAZvRUmBuysaXOJ9jL/E+75Ri8IvYFqpcW/TZDJ5vp417ljE0S9JAHeEpZTgr4B4EXH
        B+o/iR+UklD2hx83OUKSGjjcPvw9ucQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-2m7hPG_RNVeMAqxk3W9wNg-1; Wed, 06 Apr 2022 19:05:01 -0400
X-MC-Unique: 2m7hPG_RNVeMAqxk3W9wNg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 951C68038E3;
        Wed,  6 Apr 2022 23:05:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33D0B40470ED;
        Wed,  6 Apr 2022 23:04:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 13/14] cifs: Split the smb3_add_credits tracepoint
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
Date:   Thu, 07 Apr 2022 00:04:58 +0100
Message-ID: <164928629846.457102.2012832611244620467.stgit@warthog.procyon.org.uk>
In-Reply-To: <164928615045.457102.10607899252434268982.stgit@warthog.procyon.org.uk>
References: <164928615045.457102.10607899252434268982.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split the smb3_add_credits tracepoint to make it more obvious when looking
at the logs which line corresponds to what credit change.  Also add a
tracepoint for credit overflow when it's being added back.

Note that it might be better to add another field to the tracepoint to store
the information rather than splitting it.  It would also be useful to store
the MID potentially, though that isn't available when the credits are first
obtained.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: linux-cifs@vger.kernel.org
---

 fs/cifs/connect.c   |    2 +-
 fs/cifs/smb2ops.c   |    9 ++++++---
 fs/cifs/trace.h     |    7 +++++++
 fs/cifs/transport.c |    4 ++--
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 080e19e9ee47..dab0e9f93708 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -1062,7 +1062,7 @@ smb2_add_credits_from_hdr(char *buffer, struct TCP_Server_Info *server)
 		spin_unlock(&server->req_lock);
 		wake_up(&server->request_q);
 
-		trace_smb3_add_credits(server->CurrentMid,
+		trace_smb3_hdr_credits(server->CurrentMid,
 				server->conn_id, server->hostname, scredits,
 				le16_to_cpu(shdr->CreditRequest), in_flight);
 		cifs_server_dbg(FYI, "%s: added %u credits total=%d\n",
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 03bd64933b7b..cf248309528a 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -86,6 +86,9 @@ smb2_add_credits(struct TCP_Server_Info *server,
 	if (*val > 65000) {
 		*val = 65000; /* Don't get near 64K credits, avoid srv bugs */
 		pr_warn_once("server overflowed SMB3 credits\n");
+		trace_smb3_overflow_credits(server->CurrentMid,
+					    server->conn_id, server->hostname, *val,
+					    add, server->in_flight);
 	}
 	server->in_flight--;
 	if (server->in_flight == 0 &&
@@ -251,7 +254,7 @@ smb2_wait_mtu_credits(struct TCP_Server_Info *server, unsigned int size,
 	in_flight = server->in_flight;
 	spin_unlock(&server->req_lock);
 
-	trace_smb3_add_credits(server->CurrentMid,
+	trace_smb3_wait_credits(server->CurrentMid,
 			server->conn_id, server->hostname, scredits, -(credits->value), in_flight);
 	cifs_dbg(FYI, "%s: removed %u credits total=%d\n",
 			__func__, credits->value, scredits);
@@ -300,7 +303,7 @@ smb2_adjust_credits(struct TCP_Server_Info *server,
 	spin_unlock(&server->req_lock);
 	wake_up(&server->request_q);
 
-	trace_smb3_add_credits(server->CurrentMid,
+	trace_smb3_adj_credits(server->CurrentMid,
 			server->conn_id, server->hostname, scredits,
 			credits->value - new_val, in_flight);
 	cifs_dbg(FYI, "%s: adjust added %u credits total=%d\n",
@@ -2492,7 +2495,7 @@ smb2_is_status_pending(char *buf, struct TCP_Server_Info *server)
 		spin_unlock(&server->req_lock);
 		wake_up(&server->request_q);
 
-		trace_smb3_add_credits(server->CurrentMid,
+		trace_smb3_pend_credits(server->CurrentMid,
 				server->conn_id, server->hostname, scredits,
 				le16_to_cpu(shdr->CreditRequest), in_flight);
 		cifs_dbg(FYI, "%s: status pending add %u credits total=%d\n",
diff --git a/fs/cifs/trace.h b/fs/cifs/trace.h
index c85cf0971eee..d783b14c24ef 100644
--- a/fs/cifs/trace.h
+++ b/fs/cifs/trace.h
@@ -1112,6 +1112,13 @@ DEFINE_SMB3_CREDIT_EVENT(credit_timeout);
 DEFINE_SMB3_CREDIT_EVENT(insufficient_credits);
 DEFINE_SMB3_CREDIT_EVENT(too_many_credits);
 DEFINE_SMB3_CREDIT_EVENT(add_credits);
+DEFINE_SMB3_CREDIT_EVENT(adj_credits);
+DEFINE_SMB3_CREDIT_EVENT(hdr_credits);
+DEFINE_SMB3_CREDIT_EVENT(nblk_credits);
+DEFINE_SMB3_CREDIT_EVENT(pend_credits);
+DEFINE_SMB3_CREDIT_EVENT(wait_credits);
+DEFINE_SMB3_CREDIT_EVENT(waitff_credits);
+DEFINE_SMB3_CREDIT_EVENT(overflow_credits);
 DEFINE_SMB3_CREDIT_EVENT(set_credits);
 
 #endif /* _CIFS_TRACE_H */
diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index c74aa12ecc7c..4e7a3a0ddd8b 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -515,7 +515,7 @@ wait_for_free_credits(struct TCP_Server_Info *server, const int num_credits,
 		in_flight = server->in_flight;
 		spin_unlock(&server->req_lock);
 
-		trace_smb3_add_credits(server->CurrentMid,
+		trace_smb3_nblk_credits(server->CurrentMid,
 				server->conn_id, server->hostname, scredits, -1, in_flight);
 		cifs_dbg(FYI, "%s: remove %u credits total=%d\n",
 				__func__, 1, scredits);
@@ -621,7 +621,7 @@ wait_for_free_credits(struct TCP_Server_Info *server, const int num_credits,
 			in_flight = server->in_flight;
 			spin_unlock(&server->req_lock);
 
-			trace_smb3_add_credits(server->CurrentMid,
+			trace_smb3_waitff_credits(server->CurrentMid,
 					server->conn_id, server->hostname, scredits,
 					-(num_credits), in_flight);
 			cifs_dbg(FYI, "%s: remove %u credits total=%d\n",


