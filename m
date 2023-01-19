Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFC2673707
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 12:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjASLfs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 06:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjASLfZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:35:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00DD460A4
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 03:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674128074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wENbE+nHAam7hm4getAL3jIsMYX9GXCSRwsVpNwJFgw=;
        b=It8r5FLjTvsoF56WWU63NX37QKu8Q0lKXjErZaae83dnpTGe5ISXZ6fEVM6n2XXgp8bTk+
        Mmc6ktWBoWFyU7z3NGpIzRatmvn0L2ixYwe81TsZ8x3qYW8dB6w8PnD/JY2mwiPCUqqvbB
        lL5LN5nKVJBuWED15rU6Shq3uVzfo7I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-QrqReUFLP0iOyErLHa8brw-1; Thu, 19 Jan 2023 06:34:29 -0500
X-MC-Unique: QrqReUFLP0iOyErLHa8brw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 49A6818A6461;
        Thu, 19 Jan 2023 11:34:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01638492C1B;
        Thu, 19 Jan 2023 11:34:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y8jYrahu45kkCRlq@infradead.org>
References: <Y8jYrahu45kkCRlq@infradead.org> <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk> <167391048988.2311931.1567396746365286847.stgit@warthog.procyon.org.uk> <Y8ZTyx7vM8NpnUAj@infradead.org> <Y8huoSe4j6ysLUTT@ZenIV>
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
Content-ID: <2731229.1674128066.1@warthog.procyon.org.uk>
Date:   Thu, 19 Jan 2023 11:34:26 +0000
Message-ID: <2731230.1674128066@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

> We want to be consistent for sync vs async submission.  So I think yes,
> we want to do the get_current_ioprio for most of them, exceptions
> beeing aio and io_uring - those could use a __init_iocb or
> init_iocb_ioprio variant that passs in the explicit priority if we want
> to avoid the call if it would be overriden later.

io_uring is a bit problematic in this regard.  io_prep_rw() starts the
initialisation of the kiocb, so io_read() and io_write() can't just
reinitialise it.  OTOH, I'm not sure io_prep_rw() has sufficient information
to hand.

I wonder if I should add a flag to struct io_op_def to indicate that this is
going to be a write operation and maybe add a REQ_F_WRITE flag that gets set
by that.

David

