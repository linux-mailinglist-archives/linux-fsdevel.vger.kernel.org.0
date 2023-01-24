Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBBC6799B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 14:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbjAXNlP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 08:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbjAXNlN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:41:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0795B38658
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 05:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674567628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dc2lpk1IhYXovbMeoOSgyQn9kH0NS6oWJutu8QaUfdE=;
        b=NLD4+SjlF9ocE3GbBlBNZxXbUOFTiBCVV/AkN4IFam1+MNvugpWJ2i1Vnt2PaFRgetleSG
        rLvUjZhGJm16oRQom215pt36aTu/2ENX+oVCo6CVeW5HbEdkyC0mUAg3TQJM67PBl1OC+J
        XaQOIdu3Vii41MyASw2J0fTCZfS+WLI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-252-G2D2RqR8MR2toSQPLiUuOA-1; Tue, 24 Jan 2023 08:40:25 -0500
X-MC-Unique: G2D2RqR8MR2toSQPLiUuOA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 527461C06913;
        Tue, 24 Jan 2023 13:40:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73784140EBF5;
        Tue, 24 Jan 2023 13:40:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y8/ZekMEAfi8VeFl@nvidia.com>
References: <Y8/ZekMEAfi8VeFl@nvidia.com> <20230123173007.325544-1-dhowells@redhat.com> <20230123173007.325544-11-dhowells@redhat.com> <31f7d71d-0eb9-2250-78c0-2e8f31023c66@nvidia.com> <84721e8d-d40e-617c-b75e-ead51c3e1edf@nvidia.com>
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
Content-ID: <831745.1674567621.1@warthog.procyon.org.uk>
Date:   Tue, 24 Jan 2023 13:40:21 +0000
Message-ID: <831747.1674567621@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

> Though, I'm not so keen on using FOLL_ internal flags inside the block
> layer.. Can you stick with the BIO versions of these?

It's used in a new iov_iter function and will be used in a bunch of
filesystems including network filesystems.  I'm also looking at using it in
the sk_buff handling also.

David

