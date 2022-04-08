Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BD24F9FEE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Apr 2022 01:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240027AbiDHXIz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 19:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240011AbiDHXIk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 19:08:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A77481E5219
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Apr 2022 16:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649459190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wTSvM9Gxm0d1vIugP2SnYYUrmC7i4QnSLhBlJMsrgSQ=;
        b=aS/mYuN9aKrf/3jOnkrffgCRlUi9n7jFMJYuafJieGTcf79C3NOV5mvPFv1MW7BDyjd6fQ
        U6bvNGWfGGp1F4GDOkey0pVI/4pbjF+tpt2W37WlD48JM7xCzFAl/uR7z+fLRzA6K92IiO
        stwT+/hfkFU/N0VFujeXfEwr/qNFQLk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-jRY-8940O66B7p7_6ZPoNA-1; Fri, 08 Apr 2022 19:06:27 -0400
X-MC-Unique: jRY-8940O66B7p7_6ZPoNA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3677A899EC2;
        Fri,  8 Apr 2022 23:06:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1CDC6145B980;
        Fri,  8 Apr 2022 23:06:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/8] docs: filesystems: caching/backend-api.rst: correct two
 relinquish APIs use
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Yue Hu <huyue2@coolpad.com>, dhowells@redhat.com,
        Jeff Layton <jlayton@kernel.org>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Yue Hu <huyue2@coolpad.com>, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Sat, 09 Apr 2022 00:06:25 +0100
Message-ID: <164945918538.773423.2711900023519571229.stgit@warthog.procyon.org.uk>
In-Reply-To: <164945915630.773423.14655306154231712324.stgit@warthog.procyon.org.uk>
References: <164945915630.773423.14655306154231712324.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yue Hu <huyue2@coolpad.com>

1. cache backend is using fscache_relinquish_cache() rather than
   fscache_relinquish_cookie() to reset the cache cookie.

2. No fscache_cache_relinquish() helper currently, it should be
   fscache_relinquish_cache().

Signed-off-by: Yue Hu <huyue2@coolpad.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://listman.redhat.com/archives/linux-cachefs/2022-April/006703.html # v1
Link: https://listman.redhat.com/archives/linux-cachefs/2022-April/006704.html # v2
---

 Documentation/filesystems/caching/backend-api.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/caching/backend-api.rst b/Documentation/filesystems/caching/backend-api.rst
index be793c49a772..d7b2df5fd607 100644
--- a/Documentation/filesystems/caching/backend-api.rst
+++ b/Documentation/filesystems/caching/backend-api.rst
@@ -73,7 +73,7 @@ busy.
 If successful, the cache backend can then start setting up the cache.  In the
 event that the initialisation fails, the cache backend should call::
 
-	void fscache_relinquish_cookie(struct fscache_cache *cache);
+	void fscache_relinquish_cache(struct fscache_cache *cache);
 
 to reset and discard the cookie.
 
@@ -125,7 +125,7 @@ outstanding accesses on the volume to complete before returning.
 When the the cache is completely withdrawn, fscache should be notified by
 calling::
 
-	void fscache_cache_relinquish(struct fscache_cache *cache);
+	void fscache_relinquish_cache(struct fscache_cache *cache);
 
 to clear fields in the cookie and discard the caller's ref on it.
 


