Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FC0611692
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 17:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiJ1P62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 11:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiJ1P5j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:57:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DBA103DA6
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 08:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666972595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8mz49wttlzj7st73tGZCyVzXgiU4Srd49oYynmDnpsc=;
        b=ejife7c5sawwMBolx+QCTf9WYlo1RNTFL/KHZsacR3fTI4ijwohV2riCoAxf13byjprbjg
        Su8gmG0nH8yJ84Wtk5eLu4Wz3c6qApOaLuL6iPikhJJMqt8BWrUous24Y8AAf44rGf462a
        bCJ7KuEvqmpgdO1UlquL8j9gDSU/3dE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-hQrdFcQeMhyxzMYYdKQMxA-1; Fri, 28 Oct 2022 11:56:31 -0400
X-MC-Unique: hQrdFcQeMhyxzMYYdKQMxA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C5273185A794;
        Fri, 28 Oct 2022 15:56:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5AF3FFD48;
        Fri, 28 Oct 2022 15:56:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 6/9] cifs: Add a function to read into an iter from a
 socket
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        linux-cifs@vger.kernel.org, dhowells@redhat.com,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Oct 2022 16:56:28 +0100
Message-ID: <166697258876.61150.3530237818849429372.stgit@warthog.procyon.org.uk>
In-Reply-To: <166697254399.61150.1256557652599252121.stgit@warthog.procyon.org.uk>
References: <166697254399.61150.1256557652599252121.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
index 83e83d8beabb..c5e39cf26e93 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -240,6 +240,9 @@ extern int cifs_read_page_from_socket(struct TCP_Server_Info *server,
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
index ffb291579bb9..bcd34fdd8798 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -790,6 +790,22 @@ cifs_read_page_from_socket(struct TCP_Server_Info *server, struct page *page,
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


