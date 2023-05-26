Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D157971223E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 10:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242696AbjEZIc2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 04:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242692AbjEZIc0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 04:32:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB5112C
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 May 2023 01:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685089897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9x40KdygSXIWGnbkte2M+HVRzUVagP25yP4BkTs6dKs=;
        b=GlSayKpsKubr8K0MzMjBuSf+PT1k96EEcUscZ59GHEoBOPEXgUvp2cx8uGwBazmZL48uLT
        M1YngeH5H3w1MG+LC3lfJr3OHYijDdPIKus0dHtxs2KDhW7bb/hoczntGll0RpnqGzYT/f
        s8AooeB2dhrYDZWLwDidYUBzuG2XEXE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-uWGuQWl-PUm_FXH94Jwp5A-1; Fri, 26 May 2023 04:31:34 -0400
X-MC-Unique: uWGuQWl-PUm_FXH94Jwp5A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2612085A5AA;
        Fri, 26 May 2023 08:31:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E584200AD47;
        Fri, 26 May 2023 08:31:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZHBrwrRiY4/WTuYe@infradead.org>
References: <ZHBrwrRiY4/WTuYe@infradead.org> <20230525223953.225496-1-dhowells@redhat.com> <20230525223953.225496-3-dhowells@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, David Hildenbrand <david@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH v2 2/3] mm: Provide a function to get an additional pin on a page
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <520384.1685089889.1@warthog.procyon.org.uk>
Date:   Fri, 26 May 2023 09:31:29 +0100
Message-ID: <520385.1685089889@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> > +void page_get_additional_pin(struct page *page)
> 
> page_get_additional_pin seems like an odd name, mixing the get and
> pin terminologies.  What about repin_page?

I considered that, though repin_page() suggests putting a pin back in after
one is removed, but I can go with that if no one objects.

> Or move to a folio interface from the start can call it folio_repin?

I also considered this, but the entire gup interface is page-based at the
moment, but I can do that too:-/

David

