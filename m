Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB60470EF8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 09:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239963AbjEXHgz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 03:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239952AbjEXHgx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 03:36:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC619E41
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 00:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684913746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vvK6Z2AVFSI9O3ecKj+peO5KkO7IQHk2/yqFJ3/8oK8=;
        b=JKA4l12t1VVVcbzOXNXspMc6BkHYVfeMSNpFFxSaQnAKu++e3M0VipFeVWmuBELL3T/MbO
        Ff3whrPEZHakxV/nltH2rF9Uz+ghaFNsNxQspYv466CTBr7smtoEnfPoSTEYBYLadIqXel
        c1WqMq2xk24rqzkWNkueJXgrzWOgbPU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-49PEef-7NZij7YL6FX6QFA-1; Wed, 24 May 2023 03:35:43 -0400
X-MC-Unique: 49PEef-7NZij7YL6FX6QFA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 38BCF80027F;
        Wed, 24 May 2023 07:35:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCF04492B0A;
        Wed, 24 May 2023 07:35:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZG2mKMus29qquHia@infradead.org>
References: <ZG2mKMus29qquHia@infradead.org> <20230522205744.2825689-1-dhowells@redhat.com> <168487791137.449781.3170440352656135902.b4-ty@kernel.dk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v21 0/6] block: Use page pinning
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3206938.1684913738.1@warthog.procyon.org.uk>
Date:   Wed, 24 May 2023 08:35:39 +0100
Message-ID: <3206939.1684913739@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> > Applied, thanks!
> 
> This ended up on the for-6.5/block branch, but I think it needs to be
> on the splice one, as that is pre-requisite unless I'm missing
> something.

Indeed.  As I noted in the cover note:

    This requires the splice-read patchset to have been applied first,
    otherwise reversion of the ITER_PAGE iterator can race with truncate and
    return pages to the allocator whilst they're still undergoing DMA[2].

David

