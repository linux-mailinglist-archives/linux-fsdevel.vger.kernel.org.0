Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1332769B916
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 10:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjBRJ0G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Feb 2023 04:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjBRJ0E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Feb 2023 04:26:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678F223DAA
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Feb 2023 01:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676712320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pdGdALM3vDuQShb1BnFFi6PogQZvGQG8yp/KLX/QzU0=;
        b=Y+yvQx/lVJkutL2oBaCCSMrnLcDluyk9ZkOg8ENZ1QRZWkdY8ylj9LmAt8ZUy5i0ulKaxd
        iAkJrsPnEBGzD/MunQJ/wYG5BWGEfYj3PTS4Sw9v8W9ejSdCAleDWAZbsqNKkiJBgt8jlS
        CXUtBPuRhRWI+dNYdqZPMOjqqiCiVas=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-Ju0ujkZFOMmZjdPqfTMn8g-1; Sat, 18 Feb 2023 04:25:17 -0500
X-MC-Unique: Ju0ujkZFOMmZjdPqfTMn8g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69C491C05B0F;
        Sat, 18 Feb 2023 09:25:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22046492B11;
        Sat, 18 Feb 2023 09:25:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y/A67a6LovSYHhHz@T590>
References: <Y/A67a6LovSYHhHz@T590> <20230214171330.2722188-1-dhowells@redhat.com> <20230214171330.2722188-3-dhowells@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v14 02/17] splice: Add a func to do a splice from a buffered file without ITER_PIPE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1085803.1676712307.1@warthog.procyon.org.uk>
Date:   Sat, 18 Feb 2023 09:25:07 +0000
Message-ID: <1085804.1676712307@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ming Lei <ming.lei@redhat.com> wrote:

> > +	/* Work out how much data we can actually add into the pipe */
> > +	used = pipe_occupancy(pipe->head, pipe->tail);
> > +	npages = max_t(ssize_t, pipe->max_usage - used, 0);
> > +	len = min_t(size_t, len, npages * PAGE_SIZE);
> 
> Do we need to consider offset in 1st page here?

Well, it won't break since we check further on that we don't overrun the ring,
but it's probably a bit more efficient to subtract the offset into the page at
this point.

That said, we don't know how big the first folio is yet, though I'm not sure
if that matters.

David

