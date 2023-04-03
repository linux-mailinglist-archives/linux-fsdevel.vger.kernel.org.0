Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41696D4155
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 11:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjDCJxl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 05:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjDCJxY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:53:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9281111E8F
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 02:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680515453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fhMzb4M7buCw/z89I96CjAU7IGJVjjKJKkPGs/PZ09w=;
        b=G7slEEDAMruZ7G9z/a9Es+Apl9zIXGbX+hXqeSIHv5Lo6qL8exM/j1w8AxeJafiS+7PMrD
        WENgRugehiJOe7cYXVG95zG5KH1LP3ZNjytjSgkU7zkPjzUY3sVc+PhXQZDTO7gliDmHpH
        IltxnHVVHZ4GHb6idSpc1/RNH3MGrQA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-39-4-IXX9ZSPZipH8aFkS7Z8Q-1; Mon, 03 Apr 2023 05:50:50 -0400
X-MC-Unique: 4-IXX9ZSPZipH8aFkS7Z8Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 416BE1C05147;
        Mon,  3 Apr 2023 09:50:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52E2BC15BA0;
        Mon,  3 Apr 2023 09:50:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <64299af9e8861_2d2a20208e6@willemb.c.googlers.com.notmuch>
References: <64299af9e8861_2d2a20208e6@willemb.c.googlers.com.notmuch> <20230331160914.1608208-1-dhowells@redhat.com> <20230331160914.1608208-16-dhowells@redhat.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 15/55] ip, udp: Support MSG_SPLICE_PAGES
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1818503.1680515446.1@warthog.procyon.org.uk>
Date:   Mon, 03 Apr 2023 10:50:46 +0100
Message-ID: <1818504.1680515446@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> > +	} else if ((flags & MSG_SPLICE_PAGES) && length) {
> > +		if (inet->hdrincl)
> > +			return -EPERM;
> > +		if (rt->dst.dev->features & NETIF_F_SG)
> > +			/* We need an empty buffer to attach stuff to */
> > +			initial_length = transhdrlen;
> 
> I still don't entirely understand what initial_length means.
> 
> More importantly, transhdrlen can be zero. If not called for UDP
> but for RAW. Or if this is a subsequent call to a packet that is
> being held with MSG_MORE.
> 
> This works fine for existing use-cases, which go to alloc_new_skb.
> Not sure how this case would be different. But the comment alludes
> that it does.

The problem is that in the non-MSG_ZEROCOPY case, __ip_append_data() assumes
that it's going to copy the data it is given and will allocate sufficient
space in the skb in advance to hold it - but I don't want to do that because I
want to splice in the pages holding the data instead.  However, I do need to
allocate space to hold the transport header.

Maybe I should change 'initial_length' to 'initial_alloc'?  It represents the
amount I think we should allocate.  Or maybe I should have a separate
allocation clause for MSG_SPLICE_PAGES?

I also wonder if __ip_append_data() really needs two places that call
getfrag().

David

