Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137DC673F34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 17:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjASQpt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 11:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjASQpp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:45:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D85E7
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 08:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674146697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=guUDzcYcYwMFnknqXHCyHjuKgr1G1lOnW/X0/GRq4JQ=;
        b=KWN8/tiZYoinoJIG/ABtGMqUbahDgaGCHQ/la7dFNpzRL+KPb35riYauewn5+WbSQDmN6S
        dPz9hVzkRvH4vCxCag5nk6Zm+0XWioQ5qU63fPx70W2Bbefv+E60jaqm2ZZqnGkSOKUHRY
        krrL/FraCVg+m88/ePq/Znl2+sLyyZE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-_H9fMNALMY6LF6QrvrotQw-1; Thu, 19 Jan 2023 11:44:53 -0500
X-MC-Unique: _H9fMNALMY6LF6QrvrotQw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FC323C16E94;
        Thu, 19 Jan 2023 16:44:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6BF33112131E;
        Thu, 19 Jan 2023 16:44:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y8iwXJ2gMcCyXzm4@ZenIV>
References: <Y8iwXJ2gMcCyXzm4@ZenIV> <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk> <167391063242.2311931.3275290816918213423.stgit@warthog.procyon.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs-developer@lists.sourceforge.net,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 21/34] 9p: Pin pages rather than ref'ing if appropriate
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3030211.1674146654.1@warthog.procyon.org.uk>
Date:   Thu, 19 Jan 2023 16:44:14 +0000
Message-ID: <3030212.1674146654@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> wrote:

> Wait a sec; just how would that work for ITER_KVEC?  AFAICS, in your
> tree that would blow with -EFAULT...

You're right.  I wonder if I should handle ITER_KVEC in
iov_iter_extract_pages(), though I'm sure I've been told that a kvec might
point to data that doesn't have a matching page struct.  Or maybe it's that
the refcount shouldn't be changed on it.

A question for the 9p devs:

Looking more into p9_virtio_zc_request(), it might be better to use
netfs_extract_iter_to_sg(), since the page list is going to get turned into
one, instead of calling p9_get_mapped_pages() and pack_sg_list().

This would, however, require that chan->sg[] be populated outside of the
spinlock'd section - is there any reason that this can't be the case?  There's
nothing inside the locked section that makes sure the chan can be used before
it launches into loading up the scatterlist.  There is a wait afterwards, but
it has to drop the lock first, so wouldn't stop a parallel op from clobbering
chan->sg[] anyway.

Further, if virtqueue_add_sgs() fails with -ENOSPC and we go round again to
req_retry_pinned, do we actually need to reload chan->sg[]?

David

