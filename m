Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F55636622
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 17:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239170AbiKWQp6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 11:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239169AbiKWQpy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:45:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BF3C1F74
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 08:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669221893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wmLo5b/TBcqyf/fyKj1XX69CJGukHZ7yEx4cmTraIL0=;
        b=eO7BG5ZDjh4UtV/IhUH+pgowP8fDpsRcnPyoIN0Veb7h5+MuAq2mkGNZpyMUHD62UI+rwL
        OYW6qldG3GQbYyl1lhGENkaSSvcZGNWwIoIXxE4sAgsNFzqX6Q2WKxIEqyrq0FxsKlkjfw
        SP/Eh0BYcpBDkMdLZYlQ/XtIVNh5qDY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-dIEnK4EDO6uePavw9I6IQg-1; Wed, 23 Nov 2022 11:44:47 -0500
X-MC-Unique: dIEnK4EDO6uePavw9I6IQg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 518EF1C2726A;
        Wed, 23 Nov 2022 16:44:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3311A1415114;
        Wed, 23 Nov 2022 16:44:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20221117053017.21074-2-jefflexu@linux.alibaba.com>
References: <20221117053017.21074-2-jefflexu@linux.alibaba.com> <20221117053017.21074-1-jefflexu@linux.alibaba.com>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, xiang@kernel.org, chao@kernel.org,
        jlayton@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] fscache,cachefiles: add prepare_ondemand_read() callback
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1609246.1669221883.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 23 Nov 2022 16:44:43 +0000
Message-ID: <1609247.1669221883@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> -/*
> - * Prepare a read operation, shortening it to a cached/uncached
> - * boundary as appropriate.
> - */
> -static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_sub=
request *subreq,
> -						      loff_t i_size)
> +static inline enum netfs_io_source
> +cachefiles_do_prepare_read(struct netfs_cache_resources *cres,
> +			   loff_t start, size_t *_len, loff_t i_size,
> +			   unsigned long *_flags)

That's not exactly what I meant, but I guess it would work as the compiler
would probably inline it into both callers.

> -		      __entry->netfs_inode, __entry->cache_inode)
> +		      __entry->cache_inode)

Can you not lose the netfs_inode number from the tracepoint, please?  Feel
free to display 0 there for your purposes.

David

