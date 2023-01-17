Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F61666D831
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 09:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbjAQI31 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 03:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236115AbjAQI3U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:29:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF5D222E4
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 00:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673944112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=klkiVSCpY++au35oajKGu2DLvY6hcJmrE6UdavRFD3Y=;
        b=DA+tFioBzNCB8iphpuHnshEW5N90oTu5wWbANTpArXd+Gmhma4w82KVC5IXUjpOvKOg5FB
        2wHQhASifSK9qLOwfCGZAJrxfN5mshLHhNZLUZNUKUMvy+Nrv/6ztcsatU8Bmh4TfHprPr
        6mmIKqxUMIzXmLNG0K9cWQXG3BEGLR0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-466-uebr828wOSKoOig1xd0BvA-1; Tue, 17 Jan 2023 03:28:27 -0500
X-MC-Unique: uebr828wOSKoOig1xd0BvA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71D4E29AA2D8;
        Tue, 17 Jan 2023 08:28:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B44540C2064;
        Tue, 17 Jan 2023 08:28:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y8ZTyx7vM8NpnUAj@infradead.org>
References: <Y8ZTyx7vM8NpnUAj@infradead.org> <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk> <167391048988.2311931.1567396746365286847.stgit@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/34] vfs: Unconditionally set IOCB_WRITE in call_write_iter()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2330919.1673944104.1@warthog.procyon.org.uk>
Date:   Tue, 17 Jan 2023 08:28:24 +0000
Message-ID: <2330920.1673944104@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

> I suspect the best is to:
> 
>  - rename init_sync_kiocb to init_kiocb
>  - pass a new argument for the destination

Do you mean the direction rather than the destination?

>    to it.  I'm not entirely
>    sure if flags is a good thing, or an explicit READ/WRITE might be
>    better because it's harder to get wrong, even if a the compiler
>    might generate worth code for it.
>  - also use it in the async callers (io_uring, aio, overlayfs, loop,
>    nvmet, target, cachefs, file backed swap)

David

