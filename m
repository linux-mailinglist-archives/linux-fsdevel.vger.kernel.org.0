Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98824557E87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 17:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiFWPWK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 11:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiFWPWJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 11:22:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB1903ED23
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jun 2022 08:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655997727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pGXQUj0zTYVU0RQx7cTrA7UMRS2rXC5fJpSYt40ps0w=;
        b=iNjbOP8B5NXF5cyHbSPB2Qkq8c55bmQqJdR+u6SsOQ9b87uz7hd4aTJz2Wpo7ZVxw0SEQO
        t7Gxjgt3QWKoRyY8VNW6W4uQ8llxIyrCxrl6sjyAQPvPosbxLoFNtLB1ZJuOEyPEZC8RqW
        14zE/H7Uubt8dP03yRCXo7qqDJYN8GU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-zvw4ivYGOHe2Ae4uCDq-_w-1; Thu, 23 Jun 2022 11:21:55 -0400
X-MC-Unique: zvw4ivYGOHe2Ae4uCDq-_w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C69880174C;
        Thu, 23 Jun 2022 15:21:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F0E2492CA5;
        Thu, 23 Jun 2022 15:21:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YrKWRCOOWXPHRCKg@ZenIV>
References: <YrKWRCOOWXPHRCKg@ZenIV>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC][CFT][PATCHSET] iov_iter stuff
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1937817.1655997712.1@warthog.procyon.org.uk>
Date:   Thu, 23 Jun 2022 16:21:52 +0100
Message-ID: <1937818.1655997712@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> wrote:

> 
> 13/44: splice: stop abusing iov_iter_advance() to flush a pipe
> 	A really odd (ab)use of iov_iter_advance() - in case of error
> generic_file_splice_read() wants to free all pipe buffers ->read_iter()
> has produced.  Yes, forcibly resetting ->head and ->iov_offset to
> original values and calling iov_iter_advance(i, 0) will trigger
> pipe_advance(), which will trigger pipe_truncate(), which will free
> buffers.  Or we could just go ahead and free the same buffers;
> pipe_discard_from() does exactly that, no iov_iter stuff needs to
> be involved.

Can ->splice_read() and ->splice_write() be given pipe-class iov_iters rather
than pipe_inode_info structs?

David

