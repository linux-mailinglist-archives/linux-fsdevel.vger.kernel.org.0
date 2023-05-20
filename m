Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B3670A672
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 10:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjETIl5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 04:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjETIlz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 04:41:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4681B7
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 May 2023 01:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684572070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZfsN9u3tZvTje8ugz3SqEzdJkX9NnPmdfbSTVEwM6F0=;
        b=IqefbiZ5jdi9CPpfOVgUp+QQWA3G9IqQCFnGdXnugOqnv83uJXUjWVFh3lY9yVZVpAffRv
        VHNHGcUUQxJQAAhDtb8TLqwjOvitsXosDJJfrkHbYj2BLJPVXpBGT0c0wLoigm+C9cGt66
        2lpFiJR52kqBIdGebr9vbhFlgmik2Ms=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-CYBqTh54MsOJt7lOdtj2Og-1; Sat, 20 May 2023 04:41:04 -0400
X-MC-Unique: CYBqTh54MsOJt7lOdtj2Og-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 180A7101A52C;
        Sat, 20 May 2023 08:41:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90E2DC53524;
        Sat, 20 May 2023 08:41:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZGghr0/lFRKmaoAX@moria.home.lan>
References: <ZGghr0/lFRKmaoAX@moria.home.lan> <20230519074047.1739879-1-dhowells@redhat.com> <20230519074047.1739879-30-dhowells@redhat.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v20 29/32] block: Replace BIO_NO_PAGE_REF with BIO_PAGE_REFFED with inverted logic
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2292307.1684572059.1@warthog.procyon.org.uk>
Date:   Sat, 20 May 2023 09:40:59 +0100
Message-ID: <2292308.1684572059@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kent Overstreet <kent.overstreet@linux.dev> wrote:

> > Replace BIO_NO_PAGE_REF with a BIO_PAGE_REFFED flag that has the inverted
> > meaning is only set when a page reference has been acquired that needs to
> > be released by bio_release_pages().
> 
> What was the motivation for this patch?

We need to move to using FOLL_PIN for buffers derived from direct I/O to avoid
the fork vs async-DIO race.  Further, we shouldn't be taking a ref or a pin on
pages derived from internal kernel iterators such as KVEC or BVEC as the page
refcount might not be a valid way to control the lifetime of the data/buffers
in those pages (slab, for instance).  Rather, for internal kernel I/O, we need
to rely on the caller to hold onto the memory until we tell them we've
finished.

So we flip the polarity of the page-is-ref'd flag and then add a
page-is-pinned flag.  The intention is to ultimately drop the page-is-ref'd
flag - but we still need to keep the page-is-pinned flag.  This makes it
easier to take a stepwise approach - and having both flags working the same
way makes the logic easier to follow.

See iov_iter_extract_pages() and iov_iter_extract_will_pin().

David

