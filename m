Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122F866D880
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 09:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbjAQIpn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 03:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236275AbjAQIpW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:45:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB54E2E0D4
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 00:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673945063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c67qk7OnPaxl+dFH8J1vvUn1qi1Q5Jd+6lO39BMhpQ4=;
        b=bVM7bY2zxoH8G5/wHmoVDaz55GBcLXd6o3gh3wj6eiS1vLGqqXR5+57JSWbS05a7uNHqAU
        IiSK+eZLSWEXQ/ytVVF+w9mrH3x7WlNgW2SeHp/EtLTzxcBS+ouq/+KKQQ74VGLq+IfNQJ
        U6bOsdZoEBJhKR9/m+0SjkJUuL0TTa0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-3va1GWDUOD-6VU-y9Sk50A-1; Tue, 17 Jan 2023 03:44:18 -0500
X-MC-Unique: 3va1GWDUOD-6VU-y9Sk50A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 510563C0E456;
        Tue, 17 Jan 2023 08:44:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC2C52166B29;
        Tue, 17 Jan 2023 08:44:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y8ZU1Jjx5VSetvOn@infradead.org>
References: <Y8ZU1Jjx5VSetvOn@infradead.org> <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk> <167391050409.2311931.7103784292954267373.stgit@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v6 03/34] iov_iter: Pass I/O direction into iov_iter_get_pages*()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2331409.1673945056.1@warthog.procyon.org.uk>
Date:   Tue, 17 Jan 2023 08:44:16 +0000
Message-ID: <2331410.1673945056@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> On Mon, Jan 16, 2023 at 11:08:24PM +0000, David Howells wrote:
> > Define FOLL_SOURCE_BUF and FOLL_DEST_BUF to indicate to get_user_pages*()
> > and iov_iter_get_pages*() how the buffer is intended to be used in an I/O
> > operation.  Don't use READ and WRITE as a read I/O writes to memory and
> > vice versa - which causes confusion.
> > 
> > The direction is checked against the iterator's data_source.
> 
> Why can't we use the existing FOLL_WRITE?

Because FOLL_WRITE doesn't mean the same as WRITE:

 (1) It looks like it should really be FOLL_CHECK_PTES_WRITABLE.  It's not
     defined as being anything to do with the I/O.

 (2) The reason Al added ITER_SOURCE and ITER_DEST is that the use of READ and
     WRITE with the iterators is confusing and kind of inverted - and the same
     would apply with using FOLL_WRITE:

	if (rw == READ)
		gup_flags |= FOLL_WRITE;

So my thought is to make how you are using the buffer described by the
iterator explicit: "I'm using it as a source buffer" or "I'm using it as a
destination buffer".

Also, I don't want it to be FOLL_WRITE or 0.  I want it to be written
explicitly in both cases.  If you're going to insist on using FOLL_WRITE, then
there should be a FOLL_READ to go with it, even if it's #defined to 0.

David

