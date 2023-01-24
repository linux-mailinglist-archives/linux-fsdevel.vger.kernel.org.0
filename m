Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A199767A478
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 22:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbjAXVAF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 16:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjAXVAE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 16:00:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D74C3D097
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 12:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674593958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ITSRXrxe9LThDX6/w0/l0eds/y424Ud/UX3BCP7I4YI=;
        b=QlPrdxEv312BsH8Av7efySs74W3/dXlV/TrXC0I82fCM3zB2WbJqU/2p0G7YOMBCIirYcC
        qUZkjFM+2gWmc9YgsdgfPIrMZEn9et5uND01bSCtON8SGguE6sL3A9N/Pvz6zE2gtlcyQf
        3eb+O6osSyRoECi9PCMVXq+brBx2Uyg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-78-W5n_P-06OaynFbzeqK7EDQ-1; Tue, 24 Jan 2023 15:59:14 -0500
X-MC-Unique: W5n_P-06OaynFbzeqK7EDQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B86EA101A521;
        Tue, 24 Jan 2023 20:59:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09C2E1121330;
        Tue, 24 Jan 2023 20:59:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y9ArYfXEix7t3gVI@infradead.org>
References: <Y9ArYfXEix7t3gVI@infradead.org> <20230124170108.1070389-1-dhowells@redhat.com> <20230124170108.1070389-7-dhowells@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v9 6/8] block: Switch to pinning pages.
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1297803.1674593951.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 24 Jan 2023 20:59:11 +0000
Message-ID: <1297804.1674593951@warthog.procyon.org.uk>
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

Christoph Hellwig <hch@infradead.org> wrote:

> > Add BIO_PAGE_PINNED to indicate that the pages in a bio are pinned
> > (FOLL_PIN) and that the pin will need removing.
> =

> The subject is odd when this doesn't actually switch anything,
> but just adds the infrastructure to unpin pages.

How about:

	block: Add BIO_PAGE_PINNED and associated infrastructure

> > +static inline void bio_set_cleanup_mode(struct bio *bio, struct iov_i=
ter *iter)
> ...
> At this point I'd be tempted to just open code these two lines
> instead of adding a helper, but I can live with the helper if you
> prefer it.

I can do that.  It makes sense to put the call to that next to the call to
iov_iter_extract_pages().

David

