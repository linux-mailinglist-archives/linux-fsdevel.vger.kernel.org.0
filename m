Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB5759E879
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 19:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343632AbiHWRBu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 13:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343783AbiHWRAW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:00:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251E8BD1D2
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Aug 2022 07:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661263960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lhtiF7hdKprlGB08erOtNjv1PAYsuUxkpe37U67kgjk=;
        b=fLpomK+jic4DKewxDPJ5ooEmjPxI6KUB/o784v8TPAHOW7ybyCxc6n4lr9GYe62DS9Srpc
        pAc3gc85lps7IYKvJCM8w9+Yg/GTfiEt3CaDJNxX92uEFkDYyPuvNEKbW+cfBejUJsdHWh
        DfqivhduUqKtBVj+Z3eo25rwJMKNY70=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-47-Xuy5Y1BmNQKVYBkRvzAjTA-1; Tue, 23 Aug 2022 10:12:37 -0400
X-MC-Unique: Xuy5Y1BmNQKVYBkRvzAjTA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0A9929DD990;
        Tue, 23 Aug 2022 14:12:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8045518EA8;
        Tue, 23 Aug 2022 14:12:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 4/7] cifs: Add a function to read into an iter from a socket
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        linux-cifs@vger.kernel.org, dhowells@redhat.com,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 23 Aug 2022 15:12:34 +0100
Message-ID: <166126395495.708021.12328677373159554478.stgit@warthog.procyon.org.uk>
In-Reply-To: <166126392703.708021.14465850073772688008.stgit@warthog.procyon.org.uk>
References: <166126392703.708021.14465850073772688008.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a helper function to read data from a socket into the given iterator.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: linux-cifs@vger.kernel.org
---

 fs/cifs/cifsproto.h |    3 +++
 fs/cifs/connect.c   |   16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index 3bc94bcc7177..ba19f9b03fc6 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -241,6 +241,9 @@ extern int cifs_read_page_from_socket(struct TCP_Server_Info *server,
 					unsigned int page_offset,
 					unsigned int to_read);
 extern int cifs_setup_cifs_sb(struct cifs_sb_info *cifs_sb);
+extern int cifs_read_iter_from_socket(struct TCP_Server_Info *server,
+				      struct iov_iter *iter,
+				      unsigned int to_read);
 extern int cifs_match_super(struct super_block *, void *);
 extern int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx);
 extern void cifs_umount(struct cifs_sb_info *);
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 3da5da9f16b0..b81853846bd5 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -795,6 +795,22 @@ cifs_read_page_from_socket(struct TCP_Server_Info *server, struct page *page,
 	return cifs_readv_from_socket(server, &smb_msg);
 }
 
+int
+cifs_read_iter_from_socket(struct TCP_Server_Info *server, struct iov_iter *iter,
+			   unsigned int to_read)
+{
+	struct msghdr smb_msg;
+	int ret;
+
+	smb_msg.msg_iter = *iter;
+	if (smb_msg.msg_iter.count > to_read)
+		smb_msg.msg_iter.count = to_read;
+	ret = cifs_readv_from_socket(server, &smb_msg);
+	if (ret > 0)
+		iov_iter_advance(iter, ret);
+	return ret;
+}
+
 static bool
 is_smb_response(struct TCP_Server_Info *server, unsigned char type)
 {


