Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F5361F3EE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Nov 2022 14:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiKGNEY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Nov 2022 08:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiKGNEW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:04:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4A5BAA
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Nov 2022 05:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667826202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+cEiL9IFBvjHgRX8A9E1dFy3V6d+XvdXPIdvJQshRw0=;
        b=b7aoMnGv/mGee9VvR6AkUD8WhNrsF+fCwXf8Prrhje11kv3fNwEty+KWPdImKyjLU+AbBK
        4FLSl62v9bl/6r3YbQwHHVjRtsICK9zter0ErG+agWDrvUChhW9LktbWJ9yeR4SYAiaeI2
        Adv1Vzny/lo3V387WDngsZdEMSfp9Bk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-wgZRUeZBOxe-M3M_KuO2gA-1; Mon, 07 Nov 2022 08:03:17 -0500
X-MC-Unique: wgZRUeZBOxe-M3M_KuO2gA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68A9529ABA35;
        Mon,  7 Nov 2022 13:03:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F1A140C6EC2;
        Mon,  7 Nov 2022 13:03:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y2S/q11ijXEqr8ue@infradead.org>
References: <Y2S/q11ijXEqr8ue@infradead.org> <Y2IyTx0VwXMxzs0G@infradead.org> <cover.1666928993.git.ritesh.list@gmail.com> <886076cfa6f547d22765c522177d33cf621013d2.1666928993.git.ritesh.list@gmail.com> <20221028210422.GC3600936@dread.disaster.area> <Y19EXLfn8APg3adO@casper.infradead.org> <7699.1667487070@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFC 2/2] iomap: Support subpage size dirty tracking to improve write performance
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1530986.1667826195.1@warthog.procyon.org.uk>
Date:   Mon, 07 Nov 2022 13:03:15 +0000
Message-ID: <1530987.1667826195@warthog.procyon.org.uk>
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

Christoph Hellwig <hch@infradead.org> wrote:

> The core iomap code (fs/iomap/iter.c) does not.  Most users of it
> are block device centric right now, but for example the dax.c uses
> iomap for byte level DAX accesses without ever looking at a bdev,
> and seek.c and fiemap.c do not make any assumptions on the backend
> implementation.

Whilst that is true, what's in iter.c is extremely minimal and most definitely
not sufficient.  There's no retry logic, for example: what happens when we try
poking the cache and the cache says "no data"?  We have to go back and
redivide the missing bits of the request as the netfs granularity may not
match that of the cache.  Also, how to deal with writes that have to be
duplicated to multiple servers that don't all have the same wsize?

Then functions like iomap_read_folio(), iomap_readahead(), etc. *do* use
submit_bio().  These would seem like they're meant to be the main entry points
into iomap.

Add to that struct iomap_iter has two bdev pointers and two dax pointers and
the iomap_ioend struct assumes bio structs are going to be involved.

Also, there's struct iomap_page - I'm hoping to avoid the need for a dangly
struct on each page.  I *think* I only need an extra couple of bits per page
to discriminate between pages that need writing to the cache, pages that need
writing to the server, and pages that need to go to both - but I think it
might be possible to keep track of that in a separate list.  The vast majority
of write patterns are {open,write,write,...,write,close} and for such I just
need a single tracking struct.

David

