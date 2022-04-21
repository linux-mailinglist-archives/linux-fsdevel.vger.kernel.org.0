Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F40E50A0C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 15:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239131AbiDUN1k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 09:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiDUN1i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:27:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7270735879
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Apr 2022 06:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650547488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y22ZubXxLrbUim9/2nYp/1QkaF1qr8akqy+ZFhTpdnw=;
        b=XFf7vb4VBczNpPUsTY3cASNupsb3qE9RRF3uJE9Fzh6b38F1kg0uYklVAZh8Jaiau2Ss6Y
        xcBXRQI+tUrfjADGR7pyRnR2iCs7UwB8GNMW32zD6WWZo85YQvwc+NS8KUDtgAp6JFtWGR
        SbDd/l3/gB3qr7h1bvS9WmGfLLf4ORY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-8hwKYX1aP-e_r0Kn_RdK6A-1; Thu, 21 Apr 2022 09:24:47 -0400
X-MC-Unique: 8hwKYX1aP-e_r0Kn_RdK6A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68A6A802803;
        Thu, 21 Apr 2022 13:24:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 77EA9C53B80;
        Thu, 21 Apr 2022 13:24:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220415123614.54024-2-jefflexu@linux.alibaba.com>
References: <20220415123614.54024-2-jefflexu@linux.alibaba.com> <20220415123614.54024-1-jefflexu@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com, zhangjiachen.jaycee@bytedance.com
Subject: Re: [PATCH v9 01/21] cachefiles: extract write routine
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1393748.1650547482.1@warthog.procyon.org.uk>
Date:   Thu, 21 Apr 2022 14:24:42 +0100
Message-ID: <1393749.1650547482@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeffle Xu <jefflexu@linux.alibaba.com> wrote:

> Extract the generic routine of writing data to cache files, and make it
> generally available.
> 
> This will be used by the following patch implementing on-demand read
> mode. Since it's called inside cachefiles module in this case, make the
> interface generic and unrelated to netfs_cache_resources.
> 
> It is worth noting that, ki->inval_counter is not initialized after
> this cleanup. It shall not make any visible difference, since
> inval_counter is no longer used in the write completion routine, i.e.
> cachefiles_write_complete().
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Acked-by: David Howells <dhowells@redhat.com>

