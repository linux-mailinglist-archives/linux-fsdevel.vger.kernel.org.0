Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B52677CB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 14:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjAWNji (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 08:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjAWNjh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:39:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7542529F
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 05:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674481121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WPilpoakSHmLf1IHUm8451fbPrKn+kFkLmYeiPr3VRk=;
        b=LGBp9OOy2UaccOpxBLOknhvDbXMZIhg0ue83OYbVg4L8Cjiu/g0zHFr8LSb5Yy5CNzOYqi
        lKv/VTQRAsIszRP9jjQhaLMBiNl08dfhwshFpNe6pxxzmh5bYg8cmNczQTEKWDGmXVRT+b
        20A2IK+6hzlx1Ybg9t6hzDWvww9t34o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-W9xSYacsPoiXHiW6bj2Uzw-1; Mon, 23 Jan 2023 08:38:34 -0500
X-MC-Unique: W9xSYacsPoiXHiW6bj2Uzw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0B5A857F43;
        Mon, 23 Jan 2023 13:38:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E46F2026D2A;
        Mon, 23 Jan 2023 13:38:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <c742e47b-dcc0-1fef-dc8c-3bf85d26b046@redhat.com>
References: <c742e47b-dcc0-1fef-dc8c-3bf85d26b046@redhat.com> <7bbcccc9-6ebf-ffab-7425-2a12f217ba15@redhat.com> <246ba813-698b-8696-7f4d-400034a3380b@redhat.com> <20230120175556.3556978-1-dhowells@redhat.com> <20230120175556.3556978-3-dhowells@redhat.com> <3814749.1674474663@warthog.procyon.org.uk> <3903251.1674479992@warthog.procyon.org.uk>
To:     David Hildenbrand <david@redhat.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
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
Content-ID: <3911636.1674481111.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 23 Jan 2023 13:38:31 +0000
Message-ID: <3911637.1674481111@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Hildenbrand <david@redhat.com> wrote:

> That would be the ideal case: whenever intending to access page content,=
 use
> FOLL_PIN instead of FOLL_GET.
> =

> The issue that John was trying to sort out was that there are plenty of
> callsites that do a simple put_page() instead of calling
> unpin_user_page(). IIRC, handling that correctly in existing code -- wha=
t was
> pinned must be released via unpin_user_page() -- was the biggest workite=
m.
> =

> Not sure how that relates to your work here (that's why I was asking): i=
f you
> could avoid FOLL_GET, that would be great :)

Well, it simplifies things a bit.

I can make the new iov_iter_extract_pages() just do "pin" or "don't pin" a=
nd
do no ref-getting at all.  Things can be converted over to "unpin the page=
s or
doing nothing" as they're converted over to using iov_iter_extract_pages()
from iov_iter_get_pages*().

The block bio code then only needs a single bit of state: pinned or not
pinned.

For cifs RDMA, do I need to make it pass in FOLL_LONGTERM?  And does that =
need
a special cleanup?

sk_buff fragment handling could still be tricky.  I'm thinking that in tha=
t
code I'll need to store FOLL_GET/PIN in the bottom two bits of the frag pa=
ge
pointer.  Sometimes it allocates a new page and attaches it (have ref);
sometimes it does zerocopy to/from a page (have pin) and sometimes it may =
be
pointing to a kernel buffer (don't pin or ref).

David

