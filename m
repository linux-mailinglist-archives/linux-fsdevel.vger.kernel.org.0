Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CB36CC1F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 16:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjC1OUI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 10:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjC1OUH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:20:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7356198
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 07:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680013160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f/m5SehYf6RbF0mCNKIuKWpkgQ5bnk3BT8O942PeKag=;
        b=chfRJlWfHMdarwszvcGNJHyzNowQVKtNsO+pr9sBEdbz5lcnYI/4gnIYA5GttIX70QFgdH
        2pV9AWfRin11gCYksUKjy3rdZvkdgZVwVAynaKXihml7/qSkoP7uPEFR9AQrCIYscC9CWs
        dwm06Ah/pwh0ZqOOWVHVjhuUlPYcQWk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-_y0_tW6pN42bkhsN1F0pfg-1; Tue, 28 Mar 2023 10:19:16 -0400
X-MC-Unique: _y0_tW6pN42bkhsN1F0pfg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A076E848B68;
        Tue, 28 Mar 2023 14:19:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9DD891121330;
        Tue, 28 Mar 2023 14:19:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230111052515.53941-5-zhujia.zj@bytedance.com>
References: <20230111052515.53941-5-zhujia.zj@bytedance.com> <20230111052515.53941-1-zhujia.zj@bytedance.com>
To:     Jia Zhu <zhujia.zj@bytedance.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xin Yin <yinxin.x@bytedance.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH V4 4/5] cachefiles: narrow the scope of triggering EPOLLIN events in ondemand mode
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <133077.1680013145.1@warthog.procyon.org.uk>
Date:   Tue, 28 Mar 2023 15:19:05 +0100
Message-ID: <133078.1680013145@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jia Zhu <zhujia.zj@bytedance.com> wrote:

> +		if (!xa_empty(xa)) {
> +			xa_lock(xa);
> +			xa_for_each_marked(xa, index, req, CACHEFILES_REQ_NEW) {
> +				if (!cachefiles_ondemand_is_reopening_read(req)) {
> +					mask |= EPOLLIN;
> +					break;
> +				}
> +			}
> +			xa_unlock(xa);
> +		}

I wonder if there's a more efficient way to do this.  I guess it depends on
how many reqs you expect to get in a queue.  It might be worth taking the
rcu_read_lock before calling xa_lock() and holding it over the whole loop.

David

