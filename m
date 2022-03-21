Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7414E2AB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 15:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349367AbiCUOaL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 10:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349153AbiCUO1w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:27:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 941FE17AAF
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Mar 2022 07:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647872478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zdZh+PVRiBzCL4O4BEAWERm5HcmHbh2Kl3rjp7JWCdo=;
        b=di2naun3FjqBnJpZdlOVQQOlzhAxKmOx2yeY0E3LWzBUtwYzBYGgKKVGSREyz5TAkshRw9
        VEfOAYj7itl2Ldu37aQIZ7M+x9kQQHOrXN3ysYj6Veb55xnXn6u76vxE1DXZy4+pqM42q/
        Cf7hB3eo4R4mjbU3jbLVpIQN02YlRrk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-d1NlD1fuNzyaxa169iA_sw-1; Mon, 21 Mar 2022 10:14:07 -0400
X-MC-Unique: d1NlD1fuNzyaxa169iA_sw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 422D180352D;
        Mon, 21 Mar 2022 14:14:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B96CD426353;
        Mon, 21 Mar 2022 14:14:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YjiAVezd5B9auhcP@casper.infradead.org>
References: <YjiAVezd5B9auhcP@casper.infradead.org> <20220316131723.111553-1-jefflexu@linux.alibaba.com> <20220316131723.111553-4-jefflexu@linux.alibaba.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Jeffle Xu <jefflexu@linux.alibaba.com>,
        linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com
Subject: Re: [PATCH v5 03/22] cachefiles: introduce on-demand read mode
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1029981.1647872043.1@warthog.procyon.org.uk>
Date:   Mon, 21 Mar 2022 14:14:03 +0000
Message-ID: <1029982.1647872043@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> Why do you have a separate rwlock when the xarray already has its own
> spinlock?  This is usually a really bad idea.

Jeffle wants to hold a lock across the CACHEFILES_DEAD check and the xarray
access.

However, he tells xarray to do a GFP_KERNEL alloc whilst holding the rwlock:-/

David

