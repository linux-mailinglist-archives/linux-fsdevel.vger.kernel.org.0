Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCA04FBC0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 14:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346065AbiDKMbS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 08:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346053AbiDKMbS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:31:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4EBC9BCA
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 05:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649680142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZZxI4JpPALM+cig/mNfvr19ofAGALyaSEU5a24joVus=;
        b=BKi3UdjrGrdygUh+G2Le7FFmeMeLU8k/VfDOIVyEk3txmxkRFdvKs9ibr18L3ZRO/xx4q2
        ktQ892Vwb9iBq2R4Kz8g1GM9JUyVAuzQuOmjGVs510f+zC8bTGIEsotPOCSyzASZoNfOFA
        iv50UOmio3q39QFy5mHDVoSYbGMjn74=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-cVdYnBS4P_6E-9tLZGI5oQ-1; Mon, 11 Apr 2022 08:29:01 -0400
X-MC-Unique: cVdYnBS4P_6E-9tLZGI5oQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DB8C185A7A4;
        Mon, 11 Apr 2022 12:29:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2EE741639E;
        Mon, 11 Apr 2022 12:28:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220406075612.60298-4-jefflexu@linux.alibaba.com>
References: <20220406075612.60298-4-jefflexu@linux.alibaba.com> <20220406075612.60298-1-jefflexu@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
Subject: Re: [PATCH v8 03/20] cachefiles: notify user daemon with anon_fd when looking up cookie
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1091117.1649680137.1@warthog.procyon.org.uk>
Date:   Mon, 11 Apr 2022 13:28:57 +0100
Message-ID: <1091118.1649680137@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeffle Xu <jefflexu@linux.alibaba.com> wrote:

> +	  This permits on-demand read mode of cachefiles. In this mode, when
> +	  cache miss, the cachefiles backend instead of netfs, is responsible
> +          for fetching data, e.g. through user daemon.

That third line should probably begin with a tab as the other two line do.

> +static inline void cachefiles_flush_reqs(struct cachefiles_cache *cache)

If it's in a .c file, there's no need to mark it "inline".  The compiler will
inline it anyway if it decides it should.

> +#ifdef CONFIG_CACHEFILES_ONDEMAND
> +	cachefiles_flush_reqs(cache);
> +	xa_destroy(&cache->reqs);
> +#endif

If cachefiles_flush_reqs() is only used in this one place, the xa_destroy()
should possibly be moved into it.

David

