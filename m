Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB38274044C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 22:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjF0UJ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 16:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjF0UJ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:09:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16E826B3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 13:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687896521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o49YVz6zjhepi8Xmg4g4xUo0hw9c73jq1r9IaIy9q2o=;
        b=MrwusZ9PddY5Nae7pH4TlttYk74K8CU4aJnLmndXigJAhI55EuDZWLC2+3cphy1HsBE/F3
        LXUA78IEh7Gq9qWCWgx/cybYDtYc1vMYdEU58JPwzeAKjhwpD32wQbemHxKB9y5hXEAedv
        dVzI18JKB2LNxpr6DQQdu4AUIl13cuk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-L8xX7TwjMq6D_ynhzpfbgQ-1; Tue, 27 Jun 2023 16:08:37 -0400
X-MC-Unique: L8xX7TwjMq6D_ynhzpfbgQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EBAC8104D51F;
        Tue, 27 Jun 2023 20:08:35 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B16340C6F5A;
        Tue, 27 Jun 2023 20:08:35 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id CC6B8400E5693; Tue, 27 Jun 2023 14:53:52 -0300 (-03)
Date:   Tue, 27 Jun 2023 14:53:52 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Leonardo Bras <leobras@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>, P J P <ppandit@redhat.com>
Subject: Re: [PATCH] fs/buffer.c: remove per-CPU buffer_head lookup cache
Message-ID: <ZJsiMPAZyxQlvrC7@tpad>
References: <ZJnTRfHND0Wi4YcU@tpad>
 <ZJndTjktg17nulcs@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJndTjktg17nulcs@casper.infradead.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 07:47:42PM +0100, Matthew Wilcox wrote:
> On Mon, Jun 26, 2023 at 03:04:53PM -0300, Marcelo Tosatti wrote:
> > Upon closer investigation, it was found that in current codebase, lookup_bh_lru
> > is slower than __find_get_block_slow:
> > 
> >  114 ns per __find_get_block
> >  68 ns per __find_get_block_slow
> > 
> > So remove the per-CPU buffer_head caching.
> 
> LOL.  That's amazing.  I can't even see why it's so expensive.  The
> local_irq_disable(), perhaps?  Your test case is the best possible
> one for lookup_bh_lru() where you're not even doing the copy.

Oops, that was due to incorrect buffer size being looked up versus
installed size. 

About 15ns is due to irq disablement.
6ns due to checking preempt is disabled (from __this_cpu_read).

So the actual numbers for the single block lookup are 
(searching for the same block number repeatedly):

42 ns per __find_get_block
68 ns per __find_get_block_slow

And increases linearly as the test increases the number of blocks which 
are searched for:

	say mod 3 is

	__find_get_block(blocknr=1)
	__find_get_block(blocknr=2)
	__find_get_block(blocknr=3)

41 ns per __find_get_block  mod=1
41 ns per __find_get_block  mod=2
42 ns per __find_get_block  mod=3
43 ns per __find_get_block  mod=4
45 ns per __find_get_block  mod=5
48 ns per __find_get_block  mod=6
48 ns per __find_get_block  mod=7
49 ns per __find_get_block  mod=8
51 ns per __find_get_block  mod=9
52 ns per __find_get_block  mod=10
54 ns per __find_get_block  mod=11
56 ns per __find_get_block  mod=12
58 ns per __find_get_block  mod=13
60 ns per __find_get_block  mod=14
61 ns per __find_get_block  mod=15
63 ns per __find_get_block  mod=16
138 ns per __find_get_block  mod=17
138 ns per __find_get_block  mod=18
138 ns per __find_get_block  mod=19		<-- results from first patch, when
						    lookup_bh_lru is a miss
70 ns per __find_get_block_slow mod=1
71 ns per __find_get_block_slow mod=2
71 ns per __find_get_block_slow mod=3
71 ns per __find_get_block_slow mod=4
71 ns per __find_get_block_slow mod=5
72 ns per __find_get_block_slow mod=6
71 ns per __find_get_block_slow mod=7
72 ns per __find_get_block_slow mod=8
71 ns per __find_get_block_slow mod=9
71 ns per __find_get_block_slow mod=10
71 ns per __find_get_block_slow mod=11
71 ns per __find_get_block_slow mod=12
71 ns per __find_get_block_slow mod=13
71 ns per __find_get_block_slow mod=14
71 ns per __find_get_block_slow mod=15
71 ns per __find_get_block_slow mod=16
71 ns per __find_get_block_slow mod=17
72 ns per __find_get_block_slow mod=18
72 ns per __find_get_block_slow mod=19

ls on home directory:
hits: 2 misses: 91

find on a linux-2.6 git tree:
hits: 25453 misses: 51084

make clean on a linux-2.6 git tree:
hits: 247615 misses: 32855

make on a linux-2.6 git tree:
hits: 1410414 misses: 166896

In more detail, where each bucket below indicates which index into
per-CPU buffer lookup_bh_lru was found:

hits idx1   idx2  ...                                                          idx16
hits 139506 24299 21597 7462 15790 19108 6477 1349 1237 938 845 636 637 523 431 454 misses: 65773

So i think it makes more sense to just disable the cache for isolated
CPUs.

> Reviewed-by: Matthew Wilcox (oracle) <willy@infradead.org>

Thanks.


