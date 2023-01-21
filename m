Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D4F67667F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 14:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjAUNbr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 08:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjAUNbl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 08:31:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA1447432
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Jan 2023 05:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674307857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cXm8Pm2BadAWYr5hSrE/IvaR3sVGcjvJzTtpdOs1lcg=;
        b=IlLyrCDgOBVGJR0u1+H0SUx/Xntjfe0mbJzO+DH9gKi2GzfSsKwelW4975QDG6q19vXlwP
        WjW/3su8viliVAjt/NXsYA4B6DWVF/02HhIDf1u5pzTB1o4MApQBanyETA9UWYQ0wWOcDJ
        ncjXjsVlLkyHc4XntjUSz8EryHDBRzs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-Pm5zKtl0PO-PRws9-C3mdw-1; Sat, 21 Jan 2023 08:30:50 -0500
X-MC-Unique: Pm5zKtl0PO-PRws9-C3mdw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80AE31C0512D;
        Sat, 21 Jan 2023 13:30:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA07B1121315;
        Sat, 21 Jan 2023 13:30:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y8vkOk68ZFWPr9vq@infradead.org>
References: <Y8vkOk68ZFWPr9vq@infradead.org> <20230120175556.3556978-1-dhowells@redhat.com> <20230120175556.3556978-3-dhowells@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
Subject: Re: [PATCH v7 2/8] iov_iter: Add a function to extract a page list from an iterator
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3598254.1674307847.1@warthog.procyon.org.uk>
Date:   Sat, 21 Jan 2023 13:30:47 +0000
Message-ID: <3598255.1674307847@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

> On Fri, Jan 20, 2023 at 05:55:50PM +0000, David Howells wrote:
> >  (3) Any other sort of iterator.
> > 
> >      No refs or pins are obtained on the page, the assumption is made that
> >      the caller will manage page retention.  ITER_ALLOW_P2PDMA is not
> >      permitted.
> 
> The ITER_ALLOW_P2PDMA check here is fundamentally wrong and will
> break things like io_uring to fixed buffers on NVMe.  ITER_ALLOW_P2PDMA
> should strictly increase the group of acceptable iters, it does must
> not restrict anything.

So just drop the check?  Or do I actually need to do something to the pages to
make it work?  If I understand the code correctly, it's not actually operable
right now on any page that doesn't have an appropriately marked PTE.

David

