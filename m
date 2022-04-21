Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB6750A7A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 20:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391070AbiDUSAs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 14:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391095AbiDUSAr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:00:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D7FC4AE26
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Apr 2022 10:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650563875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a4va1/Lq36cMvwBfvf9W3jL50NhUZUHTTW2j9bp+3cE=;
        b=TKJGwJZahb1IathZ+pxlpiwKLSYo3ci/Xx1aW/aPIouIQ12eiBO1DO9NFlOfLj6G213Hts
        B9Q1aJoK3rwXlUE7KKvXSsT3yudazdd94BRqCnK0jX3nov20l7TxRY2Jt0hxx0ueUeqL0J
        Yb5Y7xHrh1VhZ+TaOJR1T4qrcI6MvvY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-ryYKA82UMta93HSRiWfXaQ-1; Thu, 21 Apr 2022 13:57:51 -0400
X-MC-Unique: ryYKA82UMta93HSRiWfXaQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1198F1014A64;
        Thu, 21 Apr 2022 17:57:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9088240CFD22;
        Thu, 21 Apr 2022 17:57:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <2067a5c7-4e24-f449-4676-811d12e9ab72@linux.alibaba.com>
References: <2067a5c7-4e24-f449-4676-811d12e9ab72@linux.alibaba.com> <20220415123614.54024-3-jefflexu@linux.alibaba.com> <20220415123614.54024-1-jefflexu@linux.alibaba.com> <1447543.1650552898@warthog.procyon.org.uk>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com, zhangjiachen.jaycee@bytedance.com
Subject: Re: EMFILE/ENFILE mitigation needed in erofs?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1484180.1650563860.1@warthog.procyon.org.uk>
Date:   Thu, 21 Apr 2022 18:57:40 +0100
Message-ID: <1484181.1650563860@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

JeffleXu <jefflexu@linux.alibaba.com> wrote:

> 2. Our user daemon will configure rlimit-nofile to a reasonably large
> (e.g. 1 million) value, so that it won't fail when trying to allocate fds.

There's a system-wide limit also; simply increasing the rlimit won't override
that.

David

