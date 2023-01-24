Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16B3679C74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 15:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbjAXOtL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 09:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbjAXOsp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:48:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E48D10A88
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 06:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674571678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VYbFvv6zMY5pTgiOjnD+IVJs3VYJUB3SOoUU0R9ljWs=;
        b=jQtW9UFwMVu2yPIgtdILsrVFz+cnMPqlH1H18ECik4Hk06cqPdR4Xx6Qi05depymOEDtyi
        phwhcbAdSghTAL0L3ucQVyRqJWKcmyNoSDb2OFAC2+A/kZhiW0IjBiJTbWzCyLauibCmdA
        q0Ighr+OGt2KqWMUNCXKX/r0u00lIzM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-rg6x1-L_NzmpzSCfvim6pQ-1; Tue, 24 Jan 2023 09:47:54 -0500
X-MC-Unique: rg6x1-L_NzmpzSCfvim6pQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 54D06857D0D;
        Tue, 24 Jan 2023 14:47:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E52D32026D4B;
        Tue, 24 Jan 2023 14:47:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <2431ffa0-4a37-56a2-17fa-74a5f681bcb8@redhat.com>
References: <2431ffa0-4a37-56a2-17fa-74a5f681bcb8@redhat.com> <20230123173007.325544-1-dhowells@redhat.com> <20230123173007.325544-8-dhowells@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 07/10] block: Switch to pinning pages.
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <874828.1674571671.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 24 Jan 2023 14:47:51 +0000
Message-ID: <874829.1674571671@warthog.procyon.org.uk>
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

> > +static inline void bio_set_cleanup_mode(struct bio *bio, struct iov_i=
ter *iter)
> > +{
> > +	unsigned int cleanup_mode =3D iov_iter_extract_mode(iter);
> > +
> > +	if (cleanup_mode & FOLL_GET)
> > +		bio_set_flag(bio, BIO_PAGE_REFFED);
> > +	if (cleanup_mode & FOLL_PIN)
> > +		bio_set_flag(bio, BIO_PAGE_PINNED);
> =

> Can FOLL_GET ever happen?

Yes - unless patches 8 and 9 are merged.  I had them as one, but Christoph
split them up.

David

