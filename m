Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23031535E9F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 12:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244983AbiE0Kqy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 06:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351147AbiE0KpH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 06:45:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E085D3C705
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 03:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653648306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m7BeKJHp4Run0Ug5EhP4SxprBH86cV+tauhT+NDg3e8=;
        b=KHAW4BdUg1xdPcTrrBhqS03eYB7hqNV6KmIEZUDDj18uKpz1VyTJVXAif3BOOFOxdJoANN
        tIeptphtTJ8VgKoLyCTrGLIqixu46xcdgTKVCQQYaMVTekP7dlshb7bvyQClHlcvDC1piG
        QxBi9wR160h7ZF+oc1esFI7CMIENtv0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-225-YtvydkA8MhSpA7Q0Xd4snw-1; Fri, 27 May 2022 06:45:02 -0400
X-MC-Unique: YtvydkA8MhSpA7Q0Xd4snw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CE003804078;
        Fri, 27 May 2022 10:45:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32D5D2166B26;
        Fri, 27 May 2022 10:45:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 9/9] cifs, ksmbd: Fix MAX_SGE count for softiwarp
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     dhowells@redhat.com, Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 May 2022 11:45:00 +0100
Message-ID: <165364830049.3334034.6534387884012702192.stgit@warthog.procyon.org.uk>
In-Reply-To: <165364823513.3334034.11209090728654641458.stgit@warthog.procyon.org.uk>
References: <165364823513.3334034.11209090728654641458.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Namjae Jeon <linkinjeon@kernel.org>


---

 fs/cifs/smbdirect.h       |    2 +-
 fs/ksmbd/transport_rdma.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/smbdirect.h b/fs/cifs/smbdirect.h
index 3a0d39e148e8..12a92054324a 100644
--- a/fs/cifs/smbdirect.h
+++ b/fs/cifs/smbdirect.h
@@ -226,7 +226,7 @@ struct smbd_buffer_descriptor_v1 {
 } __packed;
 
 /* Default maximum number of SGEs in a RDMA send/recv */
-#define SMBDIRECT_MAX_SGE	16
+#define SMBDIRECT_MAX_SGE	6
 /* The context for a SMBD request */
 struct smbd_request {
 	struct smbd_connection *info;
diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
index e646d79554b8..70662b3bd590 100644
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -42,7 +42,7 @@
 /* SMB_DIRECT negotiation timeout in seconds */
 #define SMB_DIRECT_NEGOTIATE_TIMEOUT		120
 
-#define SMB_DIRECT_MAX_SEND_SGES		8
+#define SMB_DIRECT_MAX_SEND_SGES		6
 #define SMB_DIRECT_MAX_RECV_SGES		1
 
 /*


