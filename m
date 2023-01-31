Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3B5683557
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 19:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjAaSbo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 13:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjAaSa6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:30:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C103759254
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 10:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675189803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eyDj/YozGMP7rLtsc0cWS+zeHfZsaS4iMdGY5XNJpoE=;
        b=JFim05CVIchBE3rpyyeZJvZyFg1RJsteorMJFS9SktS3OEGzGRMrNGIRtuYZvpDYyUYtxm
        0ArwVHDA2gCGCZVcpq1750N0YVOxTQcaB4DIuK3m2irkKGgojSCcjvaO/pxjW+9858ZcmA
        bGtztNqLaOMJYKdKwPVsrjuo/Tq51cw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-HP0ebrMgPvOTCqiYZVeThg-1; Tue, 31 Jan 2023 13:29:59 -0500
X-MC-Unique: HP0ebrMgPvOTCqiYZVeThg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1DBD89522E;
        Tue, 31 Jan 2023 18:29:26 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14B9C422F2;
        Tue, 31 Jan 2023 18:29:24 +0000 (UTC)
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
        Long Li <longli@microsoft.com>,
        Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 11/12] cifs: Fix problem with encrypted RDMA data read
Date:   Tue, 31 Jan 2023 18:28:54 +0000
Message-Id: <20230131182855.4027499-12-dhowells@redhat.com>
In-Reply-To: <20230131182855.4027499-1-dhowells@redhat.com>
References: <20230131182855.4027499-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When the cifs client is talking to the ksmbd server by RDMA and the ksmbd
server has "smb3 encryption = yes" in its config file, the normal PDU
stream is encrypted, but the directly-delivered data isn't in the stream
(and isn't encrypted), but is rather delivered by DDP/RDMA packets (at
least with IWarp).

Currently, the direct delivery fails with:

   buf can not contain only a part of read data
   WARNING: CPU: 0 PID: 4619 at fs/cifs/smb2ops.c:4731 handle_read_data+0x393/0x405
   ...
   RIP: 0010:handle_read_data+0x393/0x405
   ...
    smb3_handle_read_data+0x30/0x37
    receive_encrypted_standard+0x141/0x224
    cifs_demultiplex_thread+0x21a/0x63b
    kthread+0xe7/0xef
    ret_from_fork+0x22/0x30

The problem apparently stemming from the fact that it's trying to manage
the decryption, but the data isn't in the smallbuf, the bigbuf or the page
array).

This can be fixed simply by inserting an extra case into handle_read_data()
that checks to see if use_rdma_mr is true, and if it is, just setting
rdata->got_bytes to the length of data delivered and allowing normal
continuation.

This can be seen in an IWarp packet trace.  With the upstream code, it does
a DDP/RDMA packet, which produces the warning above and then retries,
retrieving the data inline, spread across several SMBDirect messages that
get glued together into a single PDU.  With the patch applied, only the
DDP/RDMA packet is seen.

Note that this doesn't happen if the server isn't told to encrypt stuff and
it does also happen with softRoCE.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <smfrench@gmail.com>
cc: Tom Talpey <tom@talpey.com>
cc: Long Li <longli@microsoft.com>
cc: Namjae Jeon <linkinjeon@kernel.org>
cc: Stefan Metzmacher <metze@samba.org>
cc: linux-cifs@vger.kernel.org

Link: https://lore.kernel.org/r/166855224228.1998592.2212551359609792175.stgit@warthog.procyon.org.uk/ # v1
---
 fs/cifs/smb2ops.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index cea578a45ed8..73b66ac86abf 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -4733,6 +4733,9 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 		if (length < 0)
 			return length;
 		rdata->got_bytes = data_len;
+	} else if (use_rdma_mr) {
+		/* The data was delivered directly by RDMA. */
+		rdata->got_bytes = data_len;
 	} else {
 		/* read response payload cannot be in both buf and pages */
 		WARN_ONCE(1, "buf can not contain only a part of read data");

