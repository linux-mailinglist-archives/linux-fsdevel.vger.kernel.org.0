Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A456B16BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 00:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCHXnS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 18:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCHXnR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:43:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19EA6230D
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Mar 2023 15:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678318963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z4+90+ZxONY2XZZy5o49XHYJX/j1G6CBk1SjoO4mL6Q=;
        b=gWWJhCdB7q8/Cfv8zYX1M+k/muejMDW0CWdX/qx6Gt7NUtCdjsbBDdfXmgBKsVCZKPZ1cF
        HQ8LW9eUHc7VxVmaRqFSuArCvb+Vm0lAnDATS0YQ3hq1QxC72QAJEtWhAjnvlS+2PeQW4F
        rQc40yHEu/ZMepp0uz3Xnzituj4ApeQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-WEXlRhpyMhWZy7SX8kvLaw-1; Wed, 08 Mar 2023 18:42:37 -0500
X-MC-Unique: WEXlRhpyMhWZy7SX8kvLaw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78A1E101A521;
        Wed,  8 Mar 2023 23:42:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E59B440C945A;
        Wed,  8 Mar 2023 23:42:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wjYR3h5Q-_i3Q2Et=P8WsrjwNA20fYpEQf9nafHwBNALA@mail.gmail.com>
References: <CAHk-=wjYR3h5Q-_i3Q2Et=P8WsrjwNA20fYpEQf9nafHwBNALA@mail.gmail.com> <20230308165251.2078898-1-dhowells@redhat.com> <20230308165251.2078898-4-dhowells@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
        linux-mm@kvack.org, Daniel Golle <daniel@makrotopia.org>,
        Guenter Roeck <groeck7@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v17 03/14] shmem: Implement splice-read
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2139516.1678318952.1@warthog.procyon.org.uk>
Date:   Wed, 08 Mar 2023 23:42:32 +0000
Message-ID: <2139517.1678318952@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> I get the feeling that the zeropage case just isn't so important that we'd
> need to duplicate filemap_splice_read() just for that, and I think that the
> code should either
> 
>  (a) just make a silly "read_folio()" for shmfs that just clears the page.
> 
>      Ugly but maybe simple and not horrid?

The problem with that is that once a page is in the pagecache attached to a
shmem file, we can't get rid of it without deleting or truncating the file...
At least, I think that the case.  For all other regular filesystems, a page
full of zeros can be flushed/discarded by the LRU.

shmem also has its own function for allocating folios in its pagecache, the
caller of ->read_folio() would probably have to use that.

>  (b) teach filemap_splice_read() that a NULL 'read_folio' function
> means "use the zero page"
> 
>      That might not be splice() itself, but maybe in
> filemap_get_pages() or something.

It would require some special handling in filemap_get_pages() - and/or
probably better filemap_splice_read() since, for shmem, it's only relevant to
splice.  An additional flag could be added to filemap_get_pages() to tell it
to stop at a hole in the pagecache rather than invoking readahead.
filemap_splice_read() would then need to examine the pagecache to work out how
big the hole is and insert the appropriate number of zeropages before calling
back into filemap_get_pages() again.  Possibly it could use SEEK_DATA.

> or
> 
>  (c) go even further, and teach read_folio() in general about file
> holes, and allow *any* filesystem to read zeroes that way in general
> without creating a folio for it.

Nice idea, but we'd need a way to store a "negative" marker (as opposed to
"unknown") in the pagecache for the filemap code to be able to use it.  This
sort of thing might become easier if xarray gets switched to a maple tree
implementation as that would better allow for caching of a known file hole of
arbitrary size with a single entry.

But for the moment, the filemap code would have to jump through a filesystem's
->readahead or ->read_folio vectors to work out if there's a hole there or not
- but in both cases it must already have allocated the pages it wants to
query.

David

