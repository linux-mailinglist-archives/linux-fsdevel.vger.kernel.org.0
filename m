Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8858666FBF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 11:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjALKfW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 05:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbjALKev (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:34:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6CFE24
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 02:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673519325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G1PS7mB2JtEkDjLUk4xftZvEMD5IXSfO99hn6l84qLI=;
        b=GLapLaTtXoAXgEXWqgsyYJ6P7w9dpPbNdlg1Zm/ieAAltxtmGbmuoxkXxNJDHT0Y2NwtUr
        owZifzVTwR9k56jAm0kTd9dE6Ij3pD1QhuRhX1lLrxwuDGS4qaqaKttF5F5I2atv+1NoUC
        gqIcQ1Ouw+nu1qPdKlk58S6tMe3vZy0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-gBYO1yzCOQS1GiMIxPZReQ-1; Thu, 12 Jan 2023 05:28:44 -0500
X-MC-Unique: gBYO1yzCOQS1GiMIxPZReQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6339B101A521;
        Thu, 12 Jan 2023 10:28:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B298AC15BA0;
        Thu, 12 Jan 2023 10:28:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y7+6YVkhZsvdW+Hr@infradead.org>
References: <Y7+6YVkhZsvdW+Hr@infradead.org> <167344725490.2425628.13771289553670112965.stgit@warthog.procyon.org.uk> <167344731521.2425628.5403113335062567245.stgit@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 8/9] iov_iter, block: Make bio structs pin pages rather than ref'ing if appropriate
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15236.1673519321.1@warthog.procyon.org.uk>
Date:   Thu, 12 Jan 2023 10:28:41 +0000
Message-ID: <15237.1673519321@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> 	if (cleanup_mode & FOLL_GET) {
> 		WARN_ON_ONCE(bio_test_flag(bio, BIO_PAGE_PINNED));
> 		bio_set_flag(bio, BIO_PAGE_REFFED);
> 	}
> 	if (cleanup_mode & FOLL_PIN) {
> 		WARN_ON_ONCE(bio_test_flag(bio, BIO_PAGE_REFFED));
> 		bio_set_flag(bio, BIO_PAGE_PINNED);
> 	}

That won't necessarily work as you might get back cleanup_mode == 0, in which
case both flags are cleared - and neither warning will trip on the next
addition.

I could change it so that rather than using a pair of flags, it uses a
four-state variable (which can be stored in bi_flags): BIO_PAGE_DEFAULT,
BIO_PAGE_REFFED, BIO_PAGE_PINNED, BIO_PAGE_NO_CLEANUP, say.

Or I could add an extra flag to say that the setting is locked.  Or we could
just live with the scenario I outlined possibly happening.

David

