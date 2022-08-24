Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E7A59F79C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 12:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbiHXK0h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 06:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236838AbiHXK0A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:26:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5313ECE4
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Aug 2022 03:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661336675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ByJYQ9d2EyTDdp4Or70+vFEvPSOjYImFoxgIkeer7ZI=;
        b=ZJ26YhDSFmqYSdlCgvh5q9VG6NJYYIzm/NoDSWqh4cOMiCNZfkgBlmYRvGKrD7gICfdQ3O
        EhJ3jeUUTE6Sb2jZuLFnbhqDslPnYF1aAGzAljx2ZaJ9S5x+at2Ms6CRB2Rj/lj8J6XZIq
        s522E5gKbD+LXJmKolJUcFnc/i1w9bk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-CaVLOv-cOiuMbVhNJUVGYA-1; Wed, 24 Aug 2022 06:24:32 -0400
X-MC-Unique: CaVLOv-cOiuMbVhNJUVGYA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94D1880A0C3;
        Wed, 24 Aug 2022 10:24:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8737D400E726;
        Wed, 24 Aug 2022 10:24:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Yvy2LWrMMktWPAdk@B-P7TQMD6M-0146.local>
References: <Yvy2LWrMMktWPAdk@B-P7TQMD6M-0146.local> <20220817065200.11543-1-yinxin.x@bytedance.com> <YvyVOfzkITlvgtQ6@B-P7TQMD6M-0146.local> <CAK896s71E8a_iAYwEtzp7XKopQnVT5-YnkuC3yTewOfdmvf2VQ@mail.gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     dhowells@redhat.com, Xin Yin <yinxin.x@bytedance.com>,
        xiang@kernel.org, jefflexu@linux.alibaba.com,
        linux-fsdevel@vger.kernel.org, zhujia.zj@bytedance.com,
        linux-cachefs@redhat.com, Yongqing Li <liyongqing@bytedance.com>
Subject: Re: [Linux-cachefs] [External] Re: [PATCH] cachefiles: make on-demand request distribution fairer
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3711026.1661336669.1@warthog.procyon.org.uk>
Date:   Wed, 24 Aug 2022 11:24:29 +0100
Message-ID: <3711027.1661336669@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> If David is fine with "req_id_next", I'm okay with that as well.

I can live with it.

Did you want to give me an R-b line?

David

