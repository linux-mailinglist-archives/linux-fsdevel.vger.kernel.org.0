Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13C3759F40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 22:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjGSUFD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 16:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjGSUFB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:05:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E264B1FD8;
        Wed, 19 Jul 2023 13:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hXgD7wQYE14rWhctIq9t136yN3UHwMAmBUim8bApvMM=; b=gStURRZCpkgITnErx9hIkk61Lx
        DF8f8kxmD+8R85SGQnqpxzXLL+lDwRtceFxe8OWmayO+7Vi/sqalrpsGF/YWCtk3UOgTaZx6jAP+M
        2lKQOosAAN9B6+LdTTh5e9ImUwacnGeulmXuR6INNrL7WEOKGF0T+1jrodQGiyou+xP8/D00r6jH8
        DuORStFBx5r3/aellYX/2tWZo/DbvbKjKQoQfDyS6gsg4yuuH3fJjiU7sHOTDnp+JT617dwu2gvoK
        PPnnEnTkky0WjE1Oxw1U28aySqR4ba0H27m8VvNzuzAI1llU2+v+wDLuCd7aJyqROh86hFVvp82k3
        l/M7Q66A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qMDPp-006Qbx-7h; Wed, 19 Jul 2023 20:04:53 +0000
Date:   Wed, 19 Jul 2023 21:04:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Matt Whitlock <kernel@mattwhitlock.name>,
        David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@kvack.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] splice: Fix corruption of spliced data after
 splice() returns
Message-ID: <ZLhB5ZTFpqRBTlpJ@casper.infradead.org>
References: <20230629155433.4170837-1-dhowells@redhat.com>
 <20230629155433.4170837-2-dhowells@redhat.com>
 <CAJfpegsJuvXJDcXpo9T19Gw0tDuvyOJdv44Y2bt04MEf1JLxGg@mail.gmail.com>
 <c634a18e-9f2b-4746-bd8f-aa1d41e6ddf7@mattwhitlock.name>
 <CAJfpegvq4M_Go7fHiWVBBkrK6h4ChLqQTd0+EOKbRWZDcVerWA@mail.gmail.com>
 <ZLg9HbhOVnLk1ogA@casper.infradead.org>
 <CAJfpegtYQXgAyejoYWRVkf+9y91O70jaTu+mm+3zhnGPJhKwcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtYQXgAyejoYWRVkf+9y91O70jaTu+mm+3zhnGPJhKwcA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 19, 2023 at 09:56:44PM +0200, Miklos Szeredi wrote:
> On Wed, 19 Jul 2023 at 21:44, Matthew Wilcox <willy@infradead.org> wrote:
> > So what's the API that provides the semantics of _copying_?
> 
> What's your definition of copying?

Future modifications to the pagecache do not affect the data after the
syscall has returned success.  Modifications to the pagecache while
the syscall is in progress may or may not affect the data received at
the destination.
