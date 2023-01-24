Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B33567A439
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 21:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbjAXUrd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 15:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbjAXUrc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:47:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E80D1BF8
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 12:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674593209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eKtZvwqzU1zdDUPLV4MwCF6fXOf/BSsXF6ji+U7tv7M=;
        b=OgcPIcOR/Rim0kAHGMijer/SauVYXatS6PpUAlFrrZpruAHUsq+Of5Ur5IyhsnUWpNI/dy
        4+Rrkt16np4VOAYHQ2nnIb9GmiDmNAjjInDYA0lrkkzlwV1L1OrKMZfsFXfRs+2X2LQsws
        s6LTAGRKdcRHUAKwCSjvPhUo1566VR8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-V3QInB5qOQ2qeNIC5WskVg-1; Tue, 24 Jan 2023 15:46:44 -0500
X-MC-Unique: V3QInB5qOQ2qeNIC5WskVg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6970E85A588;
        Tue, 24 Jan 2023 20:46:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A49C1121330;
        Tue, 24 Jan 2023 20:46:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <689058d5-618b-d487-c168-5e8d3733321d@nvidia.com>
References: <689058d5-618b-d487-c168-5e8d3733321d@nvidia.com> <20230124170108.1070389-1-dhowells@redhat.com> <20230124170108.1070389-8-dhowells@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, "Jan Kara" <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Christoph Hellwig" <hch@lst.de>
Subject: Re: [PATCH v9 7/8] block: Convert bio_iov_iter_get_pages to use iov_iter_extract_pages
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1296793.1674593200.1@warthog.procyon.org.uk>
Date:   Tue, 24 Jan 2023 20:46:40 +0000
Message-ID: <1296794.1674593200@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

John Hubbard <jhubbard@nvidia.com> wrote:

> A quite minor point: it seems like the last two args got reversed more
> or less by accident. It's not worth re-spinning or anything, but it
> seems better to leave the order the same between these two routines.

I pushed the extra return value to the end.  It seems better that way.

David

