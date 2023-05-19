Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250F4709CDC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 18:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjESQt0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 12:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjESQtJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 12:49:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206EA1B7
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 09:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684514829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kGTp4YSqe8PMCEMeYpjLy5orX2bqNMMdtWu7X7iaM3w=;
        b=A+26S3A5DuKHEtR4zZJjR1slABjq5+0gNe9oAvXkFBkQKfhYD37OSTC8mcOiBuf8K1+JiW
        ODMGbyRcMKJK0Nu1pi/plVQVKUxG8stl47AB48jyBa4rUmGciFY2sV8/Z+f8cYzSDWSUGN
        g5xABYkTT0HaZeAa+X8y8ca9Qwnrruk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-qFD4N4mXO-uljX8bPPuivw-1; Fri, 19 May 2023 12:47:07 -0400
X-MC-Unique: qFD4N4mXO-uljX8bPPuivw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 769E6101A585;
        Fri, 19 May 2023 16:47:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD76B2166B25;
        Fri, 19 May 2023 16:47:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=whX+mAESz01NJZssoLMsgEpFjx7LDLO1_uW1qaDY2Jidw@mail.gmail.com>
References: <CAHk-=whX+mAESz01NJZssoLMsgEpFjx7LDLO1_uW1qaDY2Jidw@mail.gmail.com> <20230519074047.1739879-1-dhowells@redhat.com> <20230519074047.1739879-4-dhowells@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v20 03/32] splice: Make direct_read_splice() limit to eof where appropriate
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1845767.1684514823.1@warthog.procyon.org.uk>
Date:   Fri, 19 May 2023 17:47:03 +0100
Message-ID: <1845768.1684514823@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > +       if (S_ISREG(file_inode(in)->i_mode) ||
> > +           S_ISBLK(file_inode(in)->i_mode)) {
> 
> This really feels fundamentally wrong to me.
> 
> If block and regular files have this limit, they should have their own
> splice_read() function that implements that limit.
> 
> Not make everybody else check it.
> 
> IOW, this should be a separate function ("block_splice_read()" or
> whatever), not inside a generic function that other users use.

This is just an optimisation to cut down the amount of bufferage allocated, so
I could just drop it and leave it to userspace for now as the filesystem/block
layer will stop anyway if it hits the EOF.  Christoph would prefer that I call
direct_splice_read() from generic_file_splice_read() in all O_DIRECT cases, if
that's fine with you.

David

