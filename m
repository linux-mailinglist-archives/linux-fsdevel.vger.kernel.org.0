Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25F86BA19B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 22:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjCNVwz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 17:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCNVwz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 17:52:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B0D5293C
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 14:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678830734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KL7RUrUlJgDEAxq9GYJFCawiEJWge2p1Oaahbua9byM=;
        b=NymZW1cNArKA4tyoK7T6WafryMP69XvmUV9mtRz9RaZSH526BKQlYEPqB25d0WmAIvnPke
        PUEoYlsHRblLrbZzaBz/tss4dpxUfVEIl4/vNyQMSXEMHmjnhtjSufrGRsQs87cnrXohAh
        MF4GxOh4tj1Xm1+0zuWxB/ErbNFedPg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-uS-EDXNSN3qnzq1H8duDKw-1; Tue, 14 Mar 2023 17:52:11 -0400
X-MC-Unique: uS-EDXNSN3qnzq1H8duDKw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76942385F36D;
        Tue, 14 Mar 2023 21:52:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21BD9C164E7;
        Tue, 14 Mar 2023 21:52:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZBCvqQyOgEa626ON@infradead.org>
References: <ZBCvqQyOgEa626ON@infradead.org> <20230308165251.2078898-1-dhowells@redhat.com> <20230308165251.2078898-8-dhowells@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Steve French <smfrench@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-cifs@vger.kernel.org
Subject: Re: [PATCH v17 07/14] splice: Do splice read from a file without using ITER_PIPE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3826684.1678830727.1@warthog.procyon.org.uk>
Date:   Tue, 14 Mar 2023 21:52:07 +0000
Message-ID: <3826685.1678830727@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

> > Make cifs use generic_file_splice_read() rather than doing it for itself.
> 
> Please split the cifs patch out into a separate one.

Okay - I've done that.  It needs to go after this one and the unexport of
filemap_splice_read() needs to go with it (or in a separate follow-up patch).

David

