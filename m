Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFED521601
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 14:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241356AbiEJM5h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 08:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238553AbiEJM5d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 08:57:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3650F201336
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 May 2022 05:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652187215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lbzQNHvRgmAKJHhChSsDKGEqh0+N/1gADq6UqyTU0po=;
        b=KbOBBBhCp7Onr8trsaBRCEA6m68Vc23Tk+mkdAt/IR03xSiNZyrpO8DU+X8grEiRGgOKbn
        HPFq0OmHxfCkMLsTvNJVq/1t4Yn+dB46QmmC2Y5eHuMSKudHNPZqNMQ2d4l11c1O+VTmBW
        /lccbAH2DvRNVpkdw9610e0TbPZ0DT0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-UjOvT2dzP5K19VuLQAl7qQ-1; Tue, 10 May 2022 08:53:29 -0400
X-MC-Unique: UjOvT2dzP5K19VuLQAl7qQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E2431C08979;
        Tue, 10 May 2022 12:53:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73CDB40CFD74;
        Tue, 10 May 2022 12:53:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220509074028.74954-4-jefflexu@linux.alibaba.com>
References: <20220509074028.74954-4-jefflexu@linux.alibaba.com> <20220509074028.74954-1-jefflexu@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        yinxin.x@bytedance.com, zhangjiachen.jaycee@bytedance.com,
        zhujia.zj@bytedance.com
Subject: Re: [PATCH v11 03/22] cachefiles: unbind cachefiles gracefully in on-demand mode
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3509260.1652187198.1@warthog.procyon.org.uk>
Date:   Tue, 10 May 2022 13:53:18 +0100
Message-ID: <3509261.1652187198@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeffle Xu <jefflexu@linux.alibaba.com> wrote:

> Add a refcount to avoid the deadlock in on-demand read mode. The
> on-demand read mode will pin the corresponding cachefiles object for
> each anonymous fd. The cachefiles object is unpinned when the anonymous
> fd gets closed. When the user daemon exits and the fd of
> "/dev/cachefiles" device node gets closed, it will wait for all
> cahcefiles objects getting withdrawn. Then if there's any anonymous fd
> getting closed after the fd of the device node, the user daemon will
> hang forever, waiting for all objects getting withdrawn.
> 
> To fix this, add a refcount indicating if there's any object pinned by
> anonymous fds. The cachefiles cache gets unbound and withdrawn when the
> refcount is decreased to 0. It won't change the behaviour of the
> original mode, in which case the cachefiles cache gets unbound and
> withdrawn as long as the fd of the device node gets closed.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Acked-by: David Howells <dhowells@redhat.com>

