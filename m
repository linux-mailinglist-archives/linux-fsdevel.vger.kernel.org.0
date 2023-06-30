Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB96E743F5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 18:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjF3QBW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 12:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjF3QBU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:01:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020ED3C0A
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 09:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688140829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bGGz8DiANSWoI5a6kGLb5e94iILUQVr5jzEPV3uc4I0=;
        b=L9tAb+6Y6YS+YY+TV2FRhwDuJL8KHCXYykNHMBLOqRt8gGy9VWG6YzxAX8YsxGLSCuUXF0
        AwsJMja4ehXiYE5mKveqF+lRAPgRz4itqmkysAugj4KntFcMYeYttzd+ADkSPaAhTix56v
        8QNbAz61nqgv31GHkJ0sGEceihh19SM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-6IJV-npHPyCrw__XkncbgA-1; Fri, 30 Jun 2023 12:00:23 -0400
X-MC-Unique: 6IJV-npHPyCrw__XkncbgA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8911138035A6;
        Fri, 30 Jun 2023 16:00:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A5BE2166B2D;
        Fri, 30 Jun 2023 16:00:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <36eda01e-502e-b93d-9098-77ed5a16f33c@kernel.dk>
References: <36eda01e-502e-b93d-9098-77ed5a16f33c@kernel.dk> <20230630152524.661208-1-dhowells@redhat.com> <20230630152524.661208-4-dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
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
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [RFC PATCH 03/11] vfs: Use init_kiocb() to initialise new IOCBs
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <662383.1688140818.1@warthog.procyon.org.uk>
Date:   Fri, 30 Jun 2023 17:00:18 +0100
Message-ID: <662384.1688140818@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> wrote:

> One concern here is that we're using IOCB_WRITE here to tell if
> sb_start_write() has been done or not, and hence whether
> kiocb_end_write() needs to be called. You know set it earlier, which
> means if we get a failure if we need to setup async data, then we know
> have IOCB_WRITE set at that point even though we did not call
> sb_start_write().

Hmmm...  It's set earlier in a number of places anyway - __cachefiles_write()
for example.

Btw, can you please put some comments on the IOCB_* constants?  I have to
guess at what they mean and how they're meant to be used.  Or better still,
get Christoph to write Documentation/core-api/iocb.rst describing the API? ;-)

David

