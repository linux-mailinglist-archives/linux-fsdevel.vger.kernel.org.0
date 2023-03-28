Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFADB6CC1CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 16:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjC1OOy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 10:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbjC1OOt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:14:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D319EE6
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 07:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680012751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jFnQl8ATxoafGr28+mJKj23xjOS1vRu21jhKl7IouiY=;
        b=F0JPUNpBrkVFD/YdmFLTn6pSOHwy/lnmmVsvm+Tp1fz5OFfjU4eeDsJtj2bD6OThB7ziDI
        I/lM/XSbvqtSdzLCaarb6V8j9eXC4lwGgDKJNa0ZOojYedD8T53mJECuROlpiC67JoiDug
        G2OAvziAQ+49Xvj5HuLwjaEgl7H+UTw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-ycdylGt2MaKNYmlGjU3KkA-1; Tue, 28 Mar 2023 10:12:27 -0400
X-MC-Unique: ycdylGt2MaKNYmlGjU3KkA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD323100DEAE;
        Tue, 28 Mar 2023 14:12:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88E5C492C13;
        Tue, 28 Mar 2023 14:12:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230111052515.53941-4-zhujia.zj@bytedance.com>
References: <20230111052515.53941-4-zhujia.zj@bytedance.com> <20230111052515.53941-1-zhujia.zj@bytedance.com>
To:     Jia Zhu <zhujia.zj@bytedance.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xin Yin <yinxin.x@bytedance.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH V4 3/5] cachefiles: resend an open request if the read request's object is closed
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <132776.1680012744.1@warthog.procyon.org.uk>
Date:   Tue, 28 Mar 2023 15:12:24 +0100
Message-ID: <132777.1680012744@warthog.procyon.org.uk>
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

> +	struct cachefiles_object *object =
> +		((struct cachefiles_ondemand_info *)work)->object;

container_of().

> +			continue;
> +		} else if (cachefiles_ondemand_object_is_reopening(object)) {

The "else" is unnecessary.

> +static void ondemand_object_worker(struct work_struct *work)
> +{
> +	struct cachefiles_object *object =
> +		((struct cachefiles_ondemand_info *)work)->object;
> +
> +	cachefiles_ondemand_init_object(object);
> +}

I can't help but feel there's some missing exclusion/locking.  This feels like
it really ought to be driven from the fscache object state machine.

