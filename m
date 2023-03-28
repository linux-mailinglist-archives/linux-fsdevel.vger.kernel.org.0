Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC23B6CC18F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 15:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjC1N7d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 09:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbjC1N7X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:59:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2029218B
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 06:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680011913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r/qQMzMODq2NJQFTscBdpgqP90R/mKK82eNeMCBGbBc=;
        b=HmynSuVY23g4MP4Xt+DZfnKnLDuJ0tiNdpoU4gMaYyd/WCGy8OWsnvB3SumuyE13wb4lOU
        qEUk4GIjlodoop1wPq1RW7DW9YluEiyOxvxDIgfHfXAB2zWiyG8hQQexOe7Ok2zAYmgFFj
        w6GT7MIC9zQtqTd2i93pPLI7HO04kb4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-88GSLgrJOO-ZtuAQA0V4cw-1; Tue, 28 Mar 2023 09:58:30 -0400
X-MC-Unique: 88GSLgrJOO-ZtuAQA0V4cw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 91F44185A78F;
        Tue, 28 Mar 2023 13:58:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B9AC3492C14;
        Tue, 28 Mar 2023 13:58:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230111052515.53941-3-zhujia.zj@bytedance.com>
References: <20230111052515.53941-3-zhujia.zj@bytedance.com> <20230111052515.53941-1-zhujia.zj@bytedance.com>
To:     Jia Zhu <zhujia.zj@bytedance.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH V4 2/5] cachefiles: extract ondemand info field from cachefiles_object
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <132136.1680011908.1@warthog.procyon.org.uk>
Date:   Tue, 28 Mar 2023 14:58:28 +0100
Message-ID: <132137.1680011908@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

> @@ -65,10 +71,7 @@ struct cachefiles_object {
>  	enum cachefiles_content		content_info:8;	/* Info about content presence */
>  	unsigned long			flags;
>  #define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
> -#ifdef CONFIG_CACHEFILES_ONDEMAND
> -	int				ondemand_id;
> -	enum cachefiles_object_state	state;
> -#endif
> +	struct cachefiles_ondemand_info	*private;

Why is this no longer inside "#ifdef CONFIG_CACHEFILES_ONDEMAND"?

Also, please don't call it "private", but rather something like "ondemand" or
"ondemand_info".

David

