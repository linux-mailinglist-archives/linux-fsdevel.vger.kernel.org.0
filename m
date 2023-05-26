Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BD4712332
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 11:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242969AbjEZJQX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 05:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242956AbjEZJQV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 05:16:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A5B135
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 May 2023 02:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685092534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/vGFdqik0rBjuVyxRP6fkQFD2f5M7p6nEHdizh76LOg=;
        b=bG8XpERStbgnKZVcGH0GW3/6YUi+lBqc8ypffggh74IF6kN8HWyYjHcelWEqfmCMNdxMzA
        7MgrIkkbF1XL8XrgmDjWeMywBDGZEITjjkC+Tx6XLKSMRM2PEL9Ri4ByCNZB6CfXRYjcCb
        IjntslPT2gRiz2ey30gwZuhwuJExypI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-xsMc0qpcOM-rMmA8xGTNwA-1; Fri, 26 May 2023 05:15:31 -0400
X-MC-Unique: xsMc0qpcOM-rMmA8xGTNwA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22CC71C08DAC;
        Fri, 26 May 2023 09:15:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 756EE492B00;
        Fri, 26 May 2023 09:15:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <4f479af6-2865-4bb3-98b9-78bba9d2065f@lucifer.local>
References: <4f479af6-2865-4bb3-98b9-78bba9d2065f@lucifer.local> <89c7f535-8fc5-4480-845f-de94f335d332@lucifer.local> <20230525223953.225496-1-dhowells@redhat.com> <20230525223953.225496-2-dhowells@redhat.com> <520730.1685090615@warthog.procyon.org.uk>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     dhowells@redhat.com, Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
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
Subject: Re: [RFC PATCH v2 1/3] mm: Don't pin ZERO_PAGE in pin_user_pages()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <522653.1685092526.1@warthog.procyon.org.uk>
Date:   Fri, 26 May 2023 10:15:26 +0100
Message-ID: <522654.1685092526@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Lorenzo Stoakes <lstoakes@gmail.com> wrote:

> > iov_iter_extract_pages(), on the other hand, is only used in two places
> > with these patches and the pins are always released with
> > unpin_user_page*() so it's a lot easier to audit.
> 
> Thanks for the clarification. I guess these are the cases where you're
> likely to see zero page usage, but since this is changing all PUP*() callers
> don't you need to audit all of those too?

I don't think it should be necessary.  This only affects pages obtained from
gup with FOLL_PIN - and, so far as I know, those always have to be released
with unpin_user_page*() which is part of the gup API and thus it should be
transparent to the users.

Pages obtained FOLL_GET, on the other hand, aren't freed through the gup API -
and there are a bunch of ways of releasing them - and getting additional refs
too.

David

