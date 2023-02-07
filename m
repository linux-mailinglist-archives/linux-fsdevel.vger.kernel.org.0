Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EBF68DCE5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 16:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjBGPXS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Feb 2023 10:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjBGPXI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:23:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AF8EB4F
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Feb 2023 07:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675783331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l+MitBe2EyJwjQSROuNpetHX6JtYUVSt9jGRlkcNJ9A=;
        b=WblU9YGVGb7p6GPuUHWyJRM724C1rNr/qIkD9WahlVF06yzNmaFn/SutWTNWXHCy5odwrV
        sSeX13u/8ziXdLaKjt82U9cY5WgCJKbTWox6JTGYQDppe8vEyfJhJywje/1VjoSgra5xKQ
        Ezieu5f9YgBMMw+TH6HnMfGErZE5AYE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-Lfrk-Rt4O2m45zEoYlywPg-1; Tue, 07 Feb 2023 10:22:07 -0500
X-MC-Unique: Lfrk-Rt4O2m45zEoYlywPg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 49E9F101B44E;
        Tue,  7 Feb 2023 15:22:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78412492B21;
        Tue,  7 Feb 2023 15:22:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230207133916.3109147-1-dhowells@redhat.com>
References: <20230207133916.3109147-1-dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/2] iomap, splice: Fix DIO/splice_read race memory corruptor and kill off ITER_PIPE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3417264.1675783322.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 07 Feb 2023 15:22:02 +0000
Message-ID: <3417265.1675783322@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jens,

> [!] Jens: Note that there's a window in the linux-block/for-next branch
>     with a memory corruptor bug that someone bisecting might hit.  These
>     two patches would be better pushed to the front of my iov-extract
>     branch to eliminate the window.  Would it be possible for you to
>     replace my branch in your for-next branch at this point?

In case you would prefer to do this, I've updated my iov-extract[*] branch=
 to
put these two patches at the bottom and pushed the other patches back on t=
op
of it, dropping the pipe extraction bits from the iov_iter_extract_pages()
patch in case you want to use that.

I've also removed the FOLL_PIN that was in that patch as it's implied by
calling pin_user_pages_fast() and is being made private to mm/.

I can also repost the full set of patches if that would be useful.

David

[*] https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/=
log/?h=3Diov-extract

