Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DCE679CD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 16:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbjAXPA0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 10:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbjAXPAW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:00:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9EE2737
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 06:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674572376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aQxbsi78Hz1Qd5wzRG4R5ZnR0IhxcARdPOHrwXDM8L8=;
        b=AksEbDJY7cOV6riWu7zYDRswC0iCsaFO0bEtEz2xv/hhEXmo2j8z6o9uEW/6V082nCNtss
        rbzL/2QAyTWOhOO6SbU2oA1FPu2RdaxnMjFhmbym4FzcaCUZc599d+uA2ia1iTPBSjyIjP
        h+WndbXQc6tqKEijIrhz4C3C64dzvIs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-A1rUvzD4NZW2fCJOm8U1kA-1; Tue, 24 Jan 2023 09:59:29 -0500
X-MC-Unique: A1rUvzD4NZW2fCJOm8U1kA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD6CF1C0040F;
        Tue, 24 Jan 2023 14:59:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52C032166B34;
        Tue, 24 Jan 2023 14:59:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y8/rx6PQ4z9Tk8qQ@nvidia.com>
References: <Y8/rx6PQ4z9Tk8qQ@nvidia.com> <Y8/hhvfDtVcsgQd6@nvidia.com> <Y8/ZekMEAfi8VeFl@nvidia.com> <20230123173007.325544-1-dhowells@redhat.com> <20230123173007.325544-11-dhowells@redhat.com> <31f7d71d-0eb9-2250-78c0-2e8f31023c66@nvidia.com> <84721e8d-d40e-617c-b75e-ead51c3e1edf@nvidia.com> <852117.1674567983@warthog.procyon.org.uk> <852914.1674568628@warthog.procyon.org.uk> <859142.1674569510@warthog.procyon.org.uk> <864109.1674570473@warthog.procyon.org.uk>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     dhowells@redhat.com, John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 10/10] mm: Renumber FOLL_PIN and FOLL_GET down
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <875205.1674572365.1@warthog.procyon.org.uk>
Date:   Tue, 24 Jan 2023 14:59:25 +0000
Message-ID: <875206.1674572365@warthog.procyon.org.uk>
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

Jason Gunthorpe <jgg@nvidia.com> wrote:

> What is the 3rd state?

Consider a network filesystem message generated for a direct I/O that the
network filesystem does zerocopy on.  You may have an sk_buff that has
fragments from one or more of three different sources:

 (1) Fragments consisting of specifically allocated pages, such as the
     IP/UDP/TCP headers that have refs taken on them.

 (2) Fragments consisting of zerocopy kernel buffers that has neither refs nor
     pins belonging to the sk_buff.

     iov_iter_extract_pages() will not take pins when extracting from, say, an
     XARRAY-type or KVEC-type iterator.  iov_iter_extract_mode() will return
     0.

 (3) Fragments consisting of zerocopy user buffers that have pins taken on
     them belonging to the sk_buff.

     iov_iter_extract_pages() will take pins when extracting from, say, a
     UBUF-type or IOVEC-type iterator.  iov_iter_extract_mode() will return
     FOLL_PIN (at the moment).

So you have three states: Ref'd, pinned and no-retention.

David

