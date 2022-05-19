Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D966252CD8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 09:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbiESHvp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 03:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbiESHvm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 03:51:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2747E47562
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 00:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652946698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ssTWorodC5pMj1HhfpY4c6Y6MlpWFF/JjDikA8vi2Wc=;
        b=T0LTHAwXVHxyWS6F9kpH8mSF4vGfmlJSkVi4b6GZJDHBOs1JXziQ0azVhUy5P3uzx/D2UH
        kBBFGky5A4sLBpgzrtW/wdfPJrIKrTz2sV8tQ9lRvTFlY7VWvde/VF+Fk8IMTflIsjJTvb
        UJOFvdWI9lBuTvHSf2kfgGfYIEPwd48=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-327-u23PA9BJOPa_-rAtHZ2msQ-1; Thu, 19 May 2022 03:51:35 -0400
X-MC-Unique: u23PA9BJOPa_-rAtHZ2msQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88C0A19705A8;
        Thu, 19 May 2022 07:51:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB2FA40C1421;
        Thu, 19 May 2022 07:51:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] nfs: Fix fscache volume key rendering for endianness
From:   David Howells <dhowells@redhat.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     Dave Wysochanski <dwysocha@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-cachefs@redhat.com, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 19 May 2022 08:51:32 +0100
Message-ID: <165294669215.3283481.13374322806917745974.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix fscache volume key rendering for endianness.  Convert the BE numbers in
the address to host-endian before printing them so that they're consistent
if the cache is copied between architectures.

Question: This change could lead to misidentification of a volume directory
in the cache on a LE machine (it's unlikely because the port number as well
as the address numbers all get flipped), but it was introduced in -rc1 in
this cycle so probably isn't in any distro kernels yet.  Should I add a
version number to enforce non-matching?

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Dave Wysochanski <dwysocha@redhat.com>
cc: Trond Myklebust <trond.myklebust@hammerspace.com>
cc: Anna Schumaker <anna@kernel.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-nfs@vger.kernel.org
cc: linux-cachefs@redhat.com
---

 fs/nfs/fscache.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index f73c09a9cf0a..0e5572b192b2 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -54,17 +54,17 @@ static bool nfs_fscache_get_client_key(struct nfs_client *clp,
 
 	switch (clp->cl_addr.ss_family) {
 	case AF_INET:
-		if (!nfs_append_int(key, _len, sin->sin_port) ||
-		    !nfs_append_int(key, _len, sin->sin_addr.s_addr))
+		if (!nfs_append_int(key, _len, ntohs(sin->sin_port)) ||
+		    !nfs_append_int(key, _len, ntohl(sin->sin_addr.s_addr)))
 			return false;
 		return true;
 
 	case AF_INET6:
-		if (!nfs_append_int(key, _len, sin6->sin6_port) ||
-		    !nfs_append_int(key, _len, sin6->sin6_addr.s6_addr32[0]) ||
-		    !nfs_append_int(key, _len, sin6->sin6_addr.s6_addr32[1]) ||
-		    !nfs_append_int(key, _len, sin6->sin6_addr.s6_addr32[2]) ||
-		    !nfs_append_int(key, _len, sin6->sin6_addr.s6_addr32[3]))
+		if (!nfs_append_int(key, _len, ntohs(sin6->sin6_port)) ||
+		    !nfs_append_int(key, _len, ntohl(sin6->sin6_addr.s6_addr32[0])) ||
+		    !nfs_append_int(key, _len, ntohl(sin6->sin6_addr.s6_addr32[1])) ||
+		    !nfs_append_int(key, _len, ntohl(sin6->sin6_addr.s6_addr32[2])) ||
+		    !nfs_append_int(key, _len, ntohl(sin6->sin6_addr.s6_addr32[3])))
 			return false;
 		return true;
 


