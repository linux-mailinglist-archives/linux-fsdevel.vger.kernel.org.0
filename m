Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B0850A20B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 16:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357522AbiDUOXO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 10:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389160AbiDUOWn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:22:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2141F21C
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Apr 2022 07:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650550792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gh/ekHtIZZN+60K/0LRwMMxguSuLO/6ec0oEYzv6z7I=;
        b=OcWCIeTcLsQU2goDuVaNae1vvZHkSJqSyYFsMv2Sn9/fz4afTTDn1mMp29sQhu7isLPHnn
        ZLBi6kfsswQwWmimfzqjMpDvYdgscvZ53rjYevD5MvWeDhn/fX3hpeNVlS8BPCHooMxl+M
        dKhzJZbK7IRZDnp7aACP2suGL1QOe74=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-457-RQwT9gTFMziTC2qMODELuw-1; Thu, 21 Apr 2022 10:19:47 -0400
X-MC-Unique: RQwT9gTFMziTC2qMODELuw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA0D62822A20;
        Thu, 21 Apr 2022 14:19:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65E59111E3FA;
        Thu, 21 Apr 2022 14:19:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220415123614.54024-8-jefflexu@linux.alibaba.com>
References: <20220415123614.54024-8-jefflexu@linux.alibaba.com> <20220415123614.54024-1-jefflexu@linux.alibaba.com>
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
Subject: Re: [PATCH v9 07/21] cachefiles: add tracepoints for on-demand read mode
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1445790.1650550783.1@warthog.procyon.org.uk>
Date:   Thu, 21 Apr 2022 15:19:43 +0100
Message-ID: <1445791.1650550783@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeffle Xu <jefflexu@linux.alibaba.com> wrote:

> Add tracepoints for on-demand read mode. Currently following tracepoints
> are added:
> 
> 	OPEN request / COPEN reply
> 	CLOSE request
> 	READ request / CREAD reply
> 	write through anonymous fd
> 	release of anonymous fd
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Acked-by: David Howells <dhowells@redhat.com>

