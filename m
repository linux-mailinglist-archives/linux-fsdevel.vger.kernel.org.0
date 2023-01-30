Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86813681DDA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 23:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjA3WNc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 17:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjA3WNb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:13:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B2249961
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 14:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675116746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f/esCj1MNnOe1fnqJrap230ikN63PqOGL5vL8Wutmq8=;
        b=CPUKgJupR2MJ9sK9gfJYsWcd8kgLVZgd8mOBLRlbKd9mgbzqWP/rbOzZ2RP0XWN0XzZjGO
        qBh4eQJgg9SVErOhY1c5yqCwL0OUJAyGc5zSnxnpWwnzSlvllI9CVdLBrGEOqAfUo6c1FP
        PDSJQYbgaVuetft6qyXPAiwrEPeXXaM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-O5GrhKaEPI-knDkSOqp-UQ-1; Mon, 30 Jan 2023 17:12:23 -0500
X-MC-Unique: O5GrhKaEPI-knDkSOqp-UQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D10A882822;
        Mon, 30 Jan 2023 22:12:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABC721121314;
        Mon, 30 Jan 2023 22:12:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <e68c5cab-c3a6-1872-98fa-9f909f23be79@nvidia.com>
References: <e68c5cab-c3a6-1872-98fa-9f909f23be79@nvidia.com> <3351099.1675077249@warthog.procyon.org.uk> <fd0003a0-a133-3daf-891c-ba7deafad768@kernel.dk> <f57ee72f-38e9-6afa-182f-2794638eadcb@kernel.dk> <e8480b18-08af-d101-a721-50d213893492@kernel.dk>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "David Hildenbrand" <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Logan Gunthorpe" <logang@deltatee.com>,
        Jeff Layton <jlayton@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] iov_iter: Improve page extraction (pin or just list)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3520517.1675116740.1@warthog.procyon.org.uk>
Date:   Mon, 30 Jan 2023 22:12:20 +0000
Message-ID: <3520518.1675116740@warthog.procyon.org.uk>
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

John Hubbard <jhubbard@nvidia.com> wrote:

> This is something that we say when adding pin_user_pages_fast(),
> yes. I doubt that I can quickly find the email thread, but we
> measured it and weren't immediately able to come up with a way
> to make it faster.

percpu counters maybe - add them up at the point of viewing?

David

