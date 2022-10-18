Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91FE602E7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 16:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiJRO34 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 10:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiJRO3w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:29:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D66E47BA1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Oct 2022 07:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666103390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qiVFV2t+M/+lfmdFLeh4ebLdxAISyofZ2gUq83Bj66k=;
        b=bOd/QHHBfazUop4C7jrJ8xK03tsuyLmbXT8EX2WRCd0Pbb85wGfgrW+TXi18PYGRu9uUFg
        W2Mf1wVHgRxonk8pl9JEdzC8qaj2vXW60dcHd4N0PPkLTbmnUEEBOlYowuTRcj5FCoV2MR
        xrD9lKvPoFizTxgd72YWFL9UZCXxIqU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-Xw8YjcKmNWy3jRDaVtICLg-1; Tue, 18 Oct 2022 10:29:44 -0400
X-MC-Unique: Xw8YjcKmNWy3jRDaVtICLg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B0D5803D48;
        Tue, 18 Oct 2022 14:29:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E12F40C206B;
        Tue, 18 Oct 2022 14:29:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Yy5pzHiQ4GRCOoXV@ZenIV>
References: <Yy5pzHiQ4GRCOoXV@ZenIV> <3750754.1662765490@warthog.procyon.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, jlayton@redhat.com, smfrench@gmail.com,
        hch@infradead.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] iov_iter: Add extraction functions
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <281329.1666103382.1@warthog.procyon.org.uk>
Date:   Tue, 18 Oct 2022 15:29:42 +0100
Message-ID: <281330.1666103382@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> wrote:

> IDGI.  Essentially, you are passing a callback disguised as enum, only to
> lose any type safety.

Granted, but this is how struct iov_iter works.  I'm keeping the enum inside
the internal functions where it can't be got at by external code.

Now, I could just copy the code three times, once for iter=>bvec, once for
iter=>sg and once for iter=>rdma.  I can also grant that iter=>bvec is really
only needed for UBUF/IOVEC-class iterators; I think I can make the assumption
that kernel-supplied buffers are good for the lifetime of the operation.

> How is it better than "iov_iter_get_pages2() into a
> fixed-sized array and handle the result" done in a loop?

Note that iov_iter_get_pages2() doesn't handle KVEC-class iterators, which
this code does - for kmalloc'd, vmalloc'd and vmap'd memory and for global and
stack variables.  What I've written gets the physical addresses but
doesn't/can't pin it (which probably means I can't just move my code into
iov_iter_get_pages2()).

Further, my code also treats multipage folios as single units which
iov_iter_get_pages2() also doesn't - at least from XARRAY-class iterators.

The UBUF-/IOVEC-extraction code doesn't handle multipage folios because
get_user_pages_fast() doesn't - though perhaps it will need to at some point.

David

