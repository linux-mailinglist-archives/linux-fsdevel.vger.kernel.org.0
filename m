Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BD768A429
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 22:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjBCVD5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Feb 2023 16:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbjBCVCk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 16:02:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44E0A8A2E
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Feb 2023 13:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675458037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZbR1ERx60swPmHLlvc4O0e0pHhwkZikBmUg0OVIfTvo=;
        b=hq4zoOglta4umyYeAWHPBCVlsTZwSjNDWENQLCjo2jviCCG1wgdl4Dde6yTDW1M7612neN
        B01XdBT0tdCj+i1bxhZXGAzMerjEd7P+TPzAj5/zhHgX6YpUcDcZglgUpIw1sape5PadpC
        1hMKOh7HBhyZIRbi09Ej8WHWKfdUk5c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-RkNDhaWsMSOYATnZHhV1Vg-1; Fri, 03 Feb 2023 16:00:34 -0500
X-MC-Unique: RkNDhaWsMSOYATnZHhV1Vg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B68DE101A521;
        Fri,  3 Feb 2023 20:59:50 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2332E410B1AD;
        Fri,  3 Feb 2023 20:59:49 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steve French <sfrench@samba.org>
Subject: [PATCH 07/11] cifs: Add a function to read into an iter from a socket
Date:   Fri,  3 Feb 2023 20:59:25 +0000
Message-Id: <20230203205929.2126634-8-dhowells@redhat.com>
In-Reply-To: <20230203205929.2126634-1-dhowells@redhat.com>
References: <20230203205929.2126634-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org

Link: https://lore.kernel.org/r/164928617874.457102.10021662143234315566.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/165211419563.3154751.18431990381145195050.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/165348879662.2106726.16881134187242702351.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/165364826398.3334034.12541600783145647319.stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/166126395495.708021.12328677373159554478.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/166697258876.61150.3530237818849429372.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/166732031039.3186319.10691316510079412635.stgit@warthog.procyon.org.uk/ # rfc
---
 fs/cifs/cifsproto.h |  3 +++
 fs/cifs/connect.c   | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index 1207b39686fb..cb7a3fe89278 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -244,6 +244,9 @@ extern int cifs_read_page_from_socket(struct TCP_Server_Info *server,
 					struct page *page,
 					unsigned int page_offset,
 					unsigned int to_read);
+int cifs_read_iter_from_socket(struct TCP_Server_Info *server,
+			       struct iov_iter *iter,
+			       unsigned int to_read);
 extern int cifs_setup_cifs_sb(struct cifs_sb_info *cifs_sb);
 void cifs_mount_put_conns(struct cifs_mount_ctx *mnt_ctx);
 int cifs_mount_get_session(struct cifs_mount_ctx *mnt_ctx);
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index b2a04b4e89a5..152b457b849f 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -765,6 +765,20 @@ cifs_read_page_from_socket(struct TCP_Server_Info *server, struct page *page,
 	return cifs_readv_from_socket(server, &smb_msg);
 }
 
+int
+cifs_read_iter_from_socket(struct TCP_Server_Info *server, struct iov_iter *iter,
+			   unsigned int to_read)
+{
+	struct msghdr smb_msg = { .msg_iter = *iter };
+	int ret;
+
+	iov_iter_truncate(&smb_msg.msg_iter, to_read);
+	ret = cifs_readv_from_socket(server, &smb_msg);
+	if (ret > 0)
+		iov_iter_advance(iter, ret);
+	return ret;
+}
+
 static bool
 is_smb_response(struct TCP_Server_Info *server, unsigned char type)
 {

