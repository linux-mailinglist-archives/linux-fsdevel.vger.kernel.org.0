Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6703C67918F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 08:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjAXHG4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 02:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbjAXHGz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 02:06:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92522113E4
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 23:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674543964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rhCMs9O93TP3iVRzGs1BbEvUjRACrPO+EAB004pe+8U=;
        b=OWz+ZaqdrJxJHhdMIO04YLM5xVI6fAeKVAYdvuR+l9zlsnp0Qg+WsM8tjyIfgPASnsl4Ey
        RMAMQCm88hfhhddPh4dJmUXlOJPzPxOup1Km0513XlTxhEqnH4/ivgUClq/3hQAJRNaZr5
        js669rSuv3YpEbBlRjK+Pj50ipJg6js=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-E8IQKbPzP6aPaqoZBUn9Iw-1; Tue, 24 Jan 2023 02:06:00 -0500
X-MC-Unique: E8IQKbPzP6aPaqoZBUn9Iw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B9D02811E6E;
        Tue, 24 Jan 2023 07:05:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83142C15BA0;
        Tue, 24 Jan 2023 07:05:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <31f7d71d-0eb9-2250-78c0-2e8f31023c66@nvidia.com>
References: <31f7d71d-0eb9-2250-78c0-2e8f31023c66@nvidia.com> <20230123173007.325544-1-dhowells@redhat.com> <20230123173007.325544-11-dhowells@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, "Jan Kara" <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Christoph Hellwig" <hch@lst.de>,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 10/10] mm: Renumber FOLL_PIN and FOLL_GET down
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <545460.1674543956.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 24 Jan 2023 07:05:56 +0000
Message-ID: <545461.1674543956@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

> > Renumber FOLL_PIN and FOLL_GET down to bit 0 and 1 respectively so tha=
t
> > they are coincidentally the same as BIO_PAGE_PINNED and BIO_PAGE_REFFE=
D and
> > also so that they can be stored in the bottom two bits of a page point=
er
> > (something I'm looking at for zerocopy socket fragments).
> > (Note that BIO_PAGE_REFFED should probably be got rid of at some point=
,
> > hence why FOLL_PIN is at 0.)
> > Also renumber down the other FOLL_* flags to close the gaps.
> =

> Should we also get these sorted into internal-to-mm and public sets?
> Because Jason (+Cc) again was about to split them apart into
> mm/internal.h [1] and that might make that a little cleaner.

My plan was to push this patch by itself through akpm since it's only an
optimisation and not necessary to the rest of the patches here.

David

