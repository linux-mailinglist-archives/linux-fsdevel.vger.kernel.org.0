Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1AF67A417
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 21:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbjAXUmu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 15:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjAXUmt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:42:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68E24DCE7
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 12:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674592922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3huE8CdVQlsjcqy3c/Rtnp6KMjNzs41mKKeUkR+HEO0=;
        b=HJZ5CLiERpClvW6bv14+qfOcgh22keIZmL4gxCLkln1fs9RBj0wAdb1TkVGjZl14NmKxcW
        kwSxAUlGA6s7SfgBEBD1vXb2lU6fefbBIPxRqjZQbAWIOsd/hB8lRnZgLiHNzSjeZ7ar6q
        pBlzrIhJLythvg5C/LDCTeWaudWJIe8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-F4JiLlV8Pl66PD56XCXeWg-1; Tue, 24 Jan 2023 15:41:56 -0500
X-MC-Unique: F4JiLlV8Pl66PD56XCXeWg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2457D3804501;
        Tue, 24 Jan 2023 20:41:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36309400D795;
        Tue, 24 Jan 2023 20:41:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y9Aq7eJ/RKSDiliq@infradead.org>
References: <Y9Aq7eJ/RKSDiliq@infradead.org> <20230124170108.1070389-1-dhowells@redhat.com> <20230124170108.1070389-4-dhowells@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/8] iomap: Don't get an reference on ZERO_PAGE for direct I/O block zeroing
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1296568.1674592913.1@warthog.procyon.org.uk>
Date:   Tue, 24 Jan 2023 20:41:53 +0000
Message-ID: <1296569.1674592913@warthog.procyon.org.uk>
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

> On Tue, Jan 24, 2023 at 05:01:03PM +0000, David Howells wrote:
> > ZERO_PAGE can't go away, no need to hold an extra reference.
> > 
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> If you send this on this needs your signoff as well, btw.

Um.  You quoted my signoff.  Do you mean your signoff?

David

