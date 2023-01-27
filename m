Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B51167DA32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 01:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjA0AI3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 19:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjA0AI2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:08:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EBD3A84
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 16:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674778067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TK72M4FENFjbB9THU3/S1wxX9UWbMydjKuCR6+HxByY=;
        b=Uz0IuI2t6PR5wD7Ym+b4zuXuVy+g4/oLQ5rT2LmVTmTQZuR6ksTAVxFa2oMcTmoVX7E0CA
        sEPzXisL8hhVvqV539r7/fGJ721yiOj1N6tL12tJKmU2HF9H0rCFedDEgCsqrdyWRQUivf
        hjtF659NJbhpH0YL3BVEOJr2QOszmI8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-375-Ee95FHhTOrqnUsBfAbgZ5g-1; Thu, 26 Jan 2023 19:07:10 -0500
X-MC-Unique: Ee95FHhTOrqnUsBfAbgZ5g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 827023C02551;
        Fri, 27 Jan 2023 00:06:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4992492C14;
        Fri, 27 Jan 2023 00:05:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <5a1796f3-e49c-80e8-2dd6-9a6e82939271@redhat.com>
References: <5a1796f3-e49c-80e8-2dd6-9a6e82939271@redhat.com> <7bbcccc9-6ebf-ffab-7425-2a12f217ba15@redhat.com> <246ba813-698b-8696-7f4d-400034a3380b@redhat.com> <20230120175556.3556978-1-dhowells@redhat.com> <20230120175556.3556978-3-dhowells@redhat.com> <3814749.1674474663@warthog.procyon.org.uk> <3903251.1674479992@warthog.procyon.org.uk> <c742e47b-dcc0-1fef-dc8c-3bf85d26b046@redhat.com> <Y9L7cRFFZh9A7kZY@ZenIV>
To:     David Hildenbrand <david@redhat.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
Subject: Re: [PATCH v7 2/8] iov_iter: Add a function to extract a page list from an iterator
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2907559.1674777959.1@warthog.procyon.org.uk>
Date:   Fri, 27 Jan 2023 00:05:59 +0000
Message-ID: <2907560.1674777959@warthog.procyon.org.uk>
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

David Hildenbrand <david@redhat.com> wrote:

> As raised already somewhere in the whole discussion by me, the right way to
> take such a long-term ping as vmsplice() does is to use
> FOLL_PIN|FOLL_LONGTERM.

So the pipe infrastructure would have to be able to pin pages instead of
carrying refs on them?  What about pages just allocated and added to the pipe
ring in normal pipe use?

David

