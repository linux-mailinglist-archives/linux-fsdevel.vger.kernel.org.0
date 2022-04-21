Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D0950A161
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 15:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383508AbiDUOAG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 10:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344635AbiDUOAF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:00:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B09E937A2F
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Apr 2022 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650549433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wyJ48PjrvsX9JqxBm3IYuFdA5jrIuvJQc3ntFnd644o=;
        b=IdjauqVyx6iWm3cwFZJCgqe1XPYUgBD9qhcViKhxct3r+5q5+yCZMoxMPaYTtY4M1T+Y7W
        rwWbRVj78t1XbT7ocIM9Ig2RmrVIjZyz38B0l2smSdMXKLWR95nzg5pxD9xK8/U2jVXvwq
        /FgnVXcbfJW140qjcSEf15IMH0GeHBs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-xSh8CwBaOWON3J9evyzuiA-1; Thu, 21 Apr 2022 09:57:07 -0400
X-MC-Unique: xSh8CwBaOWON3J9evyzuiA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF20D80A0AD;
        Thu, 21 Apr 2022 13:57:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62F2C145BA52;
        Thu, 21 Apr 2022 13:57:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220415123614.54024-3-jefflexu@linux.alibaba.com>
References: <20220415123614.54024-3-jefflexu@linux.alibaba.com> <20220415123614.54024-1-jefflexu@linux.alibaba.com>
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
Subject: Re: [PATCH v9 02/21] cachefiles: notify user daemon when looking up cookie
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1444649.1650549423.1@warthog.procyon.org.uk>
Date:   Thu, 21 Apr 2022 14:57:03 +0100
Message-ID: <1444650.1650549423@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeffle Xu <jefflexu@linux.alibaba.com> wrote:

> +	help
> +	  This permits on-demand read mode of cachefiles.  In this mode, when
> +	  cache miss, the cachefiles backend instead of netfs, is responsible
> +	  for fetching data, e.g. through user daemon.

How about:

	help
	  This permits userspace to enable the cachefiles on-demand read mode.
	  In this mode, when a cache miss occurs, responsibility for fetching
	  the data lies with the cachefiles backend instead of with the netfs
	  and is delegated to userspace.

> +	/*
> +	 * 1) Cache has been marked as dead state, and then 2) flush all
> +	 * pending requests in @reqs xarray. The barrier inside set_bit()
> +	 * will ensure that above two ops won't be reordered.
> +	 */

What set_bit()?  What "above two ops"?  And that's not how barriers work; they
provide a partial ordering relative to another pair of barriered ops.

Also, set_bit() can't be relied upon to imply a barrier - see
Documentation/memory-barriers.txt.

> +	if (IS_ENABLED(CONFIG_CACHEFILES_ONDEMAND) &&
> +	    test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags)) {

It might be worth abstracting this into an inline function in internal.h:

	static inline bool cachefiles_in_ondemand_mode(cache)
	{
		return IS_ENABLED(CONFIG_CACHEFILES_ONDEMAND) &&
			test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags)
	}

> +#ifdef CONFIG_CACHEFILES_ONDEMAND

This looks like it ought to be superfluous, given the preceding test - though
I can see why you need it:

> +#ifdef CONFIG_CACHEFILES_ONDEMAND
> +	struct xarray			reqs;		/* xarray of pending on-demand requests */
> +	struct xarray			ondemand_ids;	/* xarray for ondemand_id allocation */
> +	u32				ondemand_id_next;
> +#endif

I'm tempted to say that you should just make them non-conditional.  It's not
like there's likely to be more than one or two cachefiles_cache structs on a
system.

David

