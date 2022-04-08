Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9764F9FFA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Apr 2022 01:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiDHXJa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 19:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240043AbiDHXJX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 19:09:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B448211B28
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Apr 2022 16:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649459237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bvSHWMhXrguWfA8ykwu8Ao+oi4066Cw7VetN1MG5uYo=;
        b=HttlmKsJdskMTz14musy+zIyk25eoD+FF0HPs+t5vAGN0JhN1t1kiy4hgMe8P36T962PJo
        8iedTE6dpimkE8I7OL5jZL55V1+ZVdr2wItKHurHxEClyCqC27iSF1haDh40xOVltq5AF4
        d68BLukjfUNN2GK7VA6IcC2SxTj4baw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-2-7BPcXmMrKbgA_frKP0ww-1; Fri, 08 Apr 2022 19:07:12 -0400
X-MC-Unique: 2-7BPcXmMrKbgA_frKP0ww-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BC078038E3;
        Fri,  8 Apr 2022 23:07:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DAB388145;
        Fri,  8 Apr 2022 23:07:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 7/8] fscache: Use wrapper fscache_set_cache_state() directly
 when relinquishing
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
        Jeff Layton <jlayton@kernel.org>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Yue Hu <huyue2@coolpad.com>, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Sat, 09 Apr 2022 00:07:02 +0100
Message-ID: <164945922215.773423.3235931910808608985.stgit@warthog.procyon.org.uk>
In-Reply-To: <164945915630.773423.14655306154231712324.stgit@warthog.procyon.org.uk>
References: <164945915630.773423.14655306154231712324.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
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

From: Yue Hu <huyue2@coolpad.com>

We already have the wrapper function to set cache state.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>
cc: linux-cachefs@redhat.com
Link: https://listman.redhat.com/archives/linux-cachefs/2022-April/006648.html # v1
---

 fs/fscache/cache.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fscache/cache.c b/fs/fscache/cache.c
index 2749933852a9..d645f8b302a2 100644
--- a/fs/fscache/cache.c
+++ b/fs/fscache/cache.c
@@ -214,7 +214,7 @@ void fscache_relinquish_cache(struct fscache_cache *cache)
 
 	cache->ops = NULL;
 	cache->cache_priv = NULL;
-	smp_store_release(&cache->state, FSCACHE_CACHE_IS_NOT_PRESENT);
+	fscache_set_cache_state(cache, FSCACHE_CACHE_IS_NOT_PRESENT);
 	fscache_put_cache(cache, where);
 }
 EXPORT_SYMBOL(fscache_relinquish_cache);


