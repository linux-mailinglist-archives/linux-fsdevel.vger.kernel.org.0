Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605BC4FBD7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 15:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbiDKNo4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 09:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiDKNoz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:44:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C31DA121
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 06:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649684561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SeAW1i7bP5vwPIJRU4t8M7oOEg6okFb42IgET/Pn4rE=;
        b=SqcJttfB0iGLFOvy5ykSb3xzJMA8cJJy4Gl4KmgAxL7kkUI1OFdpTm3JGcps64+bz+BKbB
        V5J/Pn7NjdKt9RBiDHiKlEwjcLNUkXnEz+TfUAjJtUDfDmL+wVSY9HV5LOF8UnhPsw+QjQ
        XL7mWavbmuIkO+hUXu1HO+8JxVud7aQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-1qS3aKYwOQyo5eXJq_KINw-1; Mon, 11 Apr 2022 09:42:38 -0400
X-MC-Unique: 1qS3aKYwOQyo5eXJq_KINw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16249811E78;
        Mon, 11 Apr 2022 13:42:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3071492D42;
        Mon, 11 Apr 2022 13:42:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <542f749c-b0f1-1de6-cb41-26e296afb2df@linux.alibaba.com>
References: <542f749c-b0f1-1de6-cb41-26e296afb2df@linux.alibaba.com> <20220406075612.60298-5-jefflexu@linux.alibaba.com> <20220406075612.60298-1-jefflexu@linux.alibaba.com> <1091405.1649680508@warthog.procyon.org.uk>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
Subject: Re: [PATCH v8 04/20] cachefiles: notify user daemon when withdrawing cookie
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1094492.1649684554.1@warthog.procyon.org.uk>
Date:   Mon, 11 Apr 2022 14:42:34 +0100
Message-ID: <1094493.1649684554@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

JeffleXu <jefflexu@linux.alibaba.com> wrote:

> > 
> >> +	if (fd == 0)
> >> +		return -ENOENT;
> > 
> > 0 is a valid fd.
> 
> Yeah, but IMHO fd 0 is always for stdin? I think the allocated anon_fd
> won't install at fd 0. Please correct me if I'm wrong.

If someone has closed 0, then you'll get 0 next, I'm pretty sure.  Try it and
see.

> In fact I wanna use "fd == 0" as the initial state as struct
> cachefiles_object is allocated with kmem_cache_zalloc().

I would suggest presetting it to something like -2 to avoid confusion.

David

