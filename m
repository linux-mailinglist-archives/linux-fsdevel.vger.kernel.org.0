Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771AF67BF1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 22:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbjAYVte (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 16:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236667AbjAYVsU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:48:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1725D937
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 13:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674683185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TREYAwJageIukWTSjR1QmDBqozeTGEzkTCcOqfCkCRk=;
        b=QfG75EK9IITDSVeX/HBPMbK1ZQui169AaugQm2vcZQPTg5yWE31eSNczNdJHFeq7q75KWV
        oNWhJPEFzNkvU1FzaYDmgZNBTe1Mc42Cxv8x4HdxVtc5RTMMjYZA3I9+NRJ9NPYRUHLfW8
        GZ13/Bk4g4uBsToht2puo186k9CofuE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-bwc2LBG4PqONbHKjuCviSw-1; Wed, 25 Jan 2023 16:46:20 -0500
X-MC-Unique: bwc2LBG4PqONbHKjuCviSw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5237A38041D7;
        Wed, 25 Jan 2023 21:46:19 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7343B1121330;
        Wed, 25 Jan 2023 21:46:17 +0000 (UTC)
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
Subject: [RFC 12/13] cifs: Fix problem with encrypted RDMA data read
Date:   Wed, 25 Jan 2023 21:45:42 +0000
Message-Id: <20230125214543.2337639-13-dhowells@redhat.com>
In-Reply-To: <20230125214543.2337639-1-dhowells@redhat.com>
References: <20230125214543.2337639-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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
index 335080893ebc..aba6643e0869 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -4721,6 +4721,9 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 		if (length < 0)
 			return length;
 		rdata->got_bytes = data_len;
+	} else if (use_rdma_mr) {
+		/* The data was delivered directly by RDMA. */
+		rdata->got_bytes = data_len;
 	} else {
 		/* read response payload cannot be in both buf and pages */
 		WARN_ONCE(1, "buf can not contain only a part of read data");

