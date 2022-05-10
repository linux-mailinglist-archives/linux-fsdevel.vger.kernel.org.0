Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A2B5215EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 14:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238317AbiEJMzX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 08:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242046AbiEJMzI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 08:55:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 572242B9CBF
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 May 2022 05:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652187036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xkxzad1cbht/jlusqrH8a1D+QFGOt7FrMJEjOw9H5po=;
        b=c4ereZtXtCMh99pDNh5mO7uPxM1CoE0ZL2GPJTiXyI4JQw9DL2dLPzt2ZHU2QUAJIeTKE9
        uXLCZYtQFLjgQjaYLko+JESJUksEpuKuEjLr8YcwGkxm+JOBk23bslzH5nh+YoE0gBBb+Y
        WvR3NeyXd9zYZDBALZptqdeh58SqOiM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-Isfs8HFjNPW5aaZjgDRhpA-1; Tue, 10 May 2022 08:50:20 -0400
X-MC-Unique: Isfs8HFjNPW5aaZjgDRhpA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F3C71C06910;
        Tue, 10 May 2022 12:50:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 483D714C1D4D;
        Tue, 10 May 2022 12:50:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220509074028.74954-3-jefflexu@linux.alibaba.com>
References: <20220509074028.74954-3-jefflexu@linux.alibaba.com> <20220509074028.74954-1-jefflexu@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        yinxin.x@bytedance.com, zhangjiachen.jaycee@bytedance.com,
        zhujia.zj@bytedance.com
Subject: Re: [PATCH v11 02/22] cachefiles: notify the user daemon when looking up cookie
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3509080.1652187015.1@warthog.procyon.org.uk>
Date:   Tue, 10 May 2022 13:50:15 +0100
Message-ID: <3509081.1652187015@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeffle Xu <jefflexu@linux.alibaba.com> wrote:

> Fscache/CacheFiles used to serve as a local cache for a remote
> networking fs. A new on-demand read mode will be introduced for
> CacheFiles, which can boost the scenario where on-demand read semantics
> are needed, e.g. container image distribution.
> 
> The essential difference between these two modes is seen when a cache
> miss occurs: In the original mode, the netfs will fetch the data from
> the remote server and then write it to the cache file; in on-demand
> read mode, fetching the data and writing it into the cache is delegated
> to a user daemon.
> 
> As the first step, notify the user daemon when looking up cookie. In
> this case, an anonymous fd is sent to the user daemon, through which the
> user daemon can write the fetched data to the cache file. Since the user
> daemon may move the anonymous fd around, e.g. through dup(), an object
> ID uniquely identifying the cache file is also attached.
> 
> Also add one advisory flag (FSCACHE_ADV_WANT_CACHE_SIZE) suggesting that
> the cache file size shall be retrieved at runtime. This helps the
> scenario where one cache file contains multiple netfs files, e.g. for
> the purpose of deduplication. In this case, netfs itself has no idea the
> size of the cache file, whilst the user daemon should give the hint on
> it.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Acked-by: David Howells <dhowells@redhat.com>

