Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E00662AE7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 23:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiKOWpR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 17:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiKOWpL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:45:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F7618B0A
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Nov 2022 14:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668552250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Sr5cmUXaaquPODOsp7wOywLMH70ji6BY41qEcJlkct8=;
        b=KNho62hQ6wlOIXiDdjTfToTVyQ/GRmHYkrjPsXndFfUO3V8agkyMQcubKF1mAQz2iR15jL
        Klj+W+vGu9EAm2kk9QQpQD6OQRO30xTb22z9nIiWinl1g7uZI95UEUJD7WRGJ/mWT93VSy
        01oZ038ruq17bRfNoSBDawxctX5DmIY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-qYs-SrBBO5qTlAyD7FTboQ-1; Tue, 15 Nov 2022 17:44:06 -0500
X-MC-Unique: qYs-SrBBO5qTlAyD7FTboQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 47DD9800B23;
        Tue, 15 Nov 2022 22:44:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40F4B40C6EC3;
        Tue, 15 Nov 2022 22:44:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] cifs: Fix problem with encrypted RDMA data read
From:   David Howells <dhowells@redhat.com>
To:     smfrench@gmail.com, tom@talpey.com
Cc:     Long Li <longli@microsoft.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Stefan Metzmacher <metze@samba.org>,
        linux-cifs@vger.kernel.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 15 Nov 2022 22:44:02 +0000
Message-ID: <166855224228.1998592.2212551359609792175.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
---

 fs/cifs/smb2ops.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 880cd494afea..8d459f60f27b 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -4726,6 +4726,9 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 		iov.iov_base = buf + data_offset;
 		iov.iov_len = data_len;
 		iov_iter_kvec(&iter, WRITE, &iov, 1, data_len);
+	} else if (use_rdma_mr) {
+		/* The data was delivered directly by RDMA. */
+		rdata->got_bytes = data_len;
 	} else {
 		/* read response payload cannot be in both buf and pages */
 		WARN_ONCE(1, "buf can not contain only a part of read data");


