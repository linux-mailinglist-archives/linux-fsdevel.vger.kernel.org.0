Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0C4679B3C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 15:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbjAXONC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 09:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbjAXONA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:13:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464DB42BE6
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 06:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674569529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QqZGwflqtmW5gx1YYpxSf8Ian1OgFOTlCjwpTEMfDZc=;
        b=TWioszNB1pLBNjy+KyZhqtgmABonN/SslaPbgJA1vfp8MDnPcsdrCwAh7r2uJuHnlRrOTE
        fklYab6Bc5xnXuki/v7/G//9xatQVIIBJgQuEPDyFviBq7J1149ddn2pmHdF09ybWmGzXU
        YvpY8miyi/mGf7oCkLvEjCEflaDhYLA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-bbXy74RkPMmszM7E1OBB2g-1; Tue, 24 Jan 2023 09:11:53 -0500
X-MC-Unique: bbXy74RkPMmszM7E1OBB2g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A62B42804822;
        Tue, 24 Jan 2023 14:11:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 113AA492C3E;
        Tue, 24 Jan 2023 14:11:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y8/kfPEp1GkZKklc@nvidia.com>
References: <Y8/kfPEp1GkZKklc@nvidia.com> <Y8/hhvfDtVcsgQd6@nvidia.com> <Y8/ZekMEAfi8VeFl@nvidia.com> <20230123173007.325544-1-dhowells@redhat.com> <20230123173007.325544-11-dhowells@redhat.com> <31f7d71d-0eb9-2250-78c0-2e8f31023c66@nvidia.com> <84721e8d-d40e-617c-b75e-ead51c3e1edf@nvidia.com> <852117.1674567983@warthog.procyon.org.uk> <852914.1674568628@warthog.procyon.org.uk>
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
Content-ID: <859141.1674569510.1@warthog.procyon.org.uk>
Date:   Tue, 24 Jan 2023 14:11:50 +0000
Message-ID: <859142.1674569510@warthog.procyon.org.uk>
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

Jason Gunthorpe <jgg@nvidia.com> wrote:

> if (cleanup_flags & PAGE_CLEANUP_UNPIN)
>    gup_put_folio(folio, 1, true);
> else if (cleanup_flags & PAGE_CLEANUP_PUT)
>    gup_put_folio(folio, 1, false);

gup_put_folio() doesn't take a bool - it takes FOLL_PIN and FOLL_GET:

static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)

though I could do:

	if (cleanup_flags & PAGE_CLEANUP_UNPIN)
		gup_put_folio(folio, 1, FOLL_PIN);
	else if (cleanup_flags & PAGE_CLEANUP_PUT)
		gup_put_folio(folio, 1, FOLL_GET);

But the reason I wrote it like this:

 		gup_flags |= cleanup_flags & PAGE_CLEANUP_UNPIN ? FOLL_PIN : 0;
 		gup_flags |= cleanup_flags & PAGE_CLEANUP_PUT ? FOLL_GET : 0;

is that if PAGE_CLEANUP_UNPIN == FOLL_PIN and PAGE_CLEANUP_PUT == FOLL_GET,
the C compiler optimiser should be able to turn all of that into a single AND
instruction.

David

