Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583CF73EA69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 20:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjFZSrr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 14:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjFZSrq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:47:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D8C97;
        Mon, 26 Jun 2023 11:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XSBS7nnhjCZzBfZehcV6O1SYW8pWHbH7Bqsmx++CeEM=; b=UWz5jHfEbia2gvWf3/Oa8q2mON
        jYqy+4ZVuX6lXq/a1ZIc3OBKlnieDNQH1cYpleKNvkbSQPeMCTaXcQ6eJAUM5JHsUI7cr1uB5CYWK
        63YsNc2L+MxYPbtJyB7Wjmf5M8xv1+D2TAnkzdjItJEkJA1kEwv3/KILNOGVWoyYcff37IwtEKcXE
        2AUMEbUaO7LwFirgHdn5sL7AlgwZGWLEzFiJdzjDzhsIkhkZMGPG28U0escwfKenp5j5lqGJIAuKQ
        E8+nvkdeVYwFWfmeSww1yI/W4jfhrZU+CJNeYbV2JbggZ96jMFMRsD30F7IMR3Jw/m4EE1W0qpCYf
        fzajYOHw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qDrFW-001yDe-JM; Mon, 26 Jun 2023 18:47:42 +0000
Date:   Mon, 26 Jun 2023 19:47:42 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
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
Message-ID: <ZJndTjktg17nulcs@casper.infradead.org>
References: <ZJnTRfHND0Wi4YcU@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJnTRfHND0Wi4YcU@tpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 03:04:53PM -0300, Marcelo Tosatti wrote:
> Upon closer investigation, it was found that in current codebase, lookup_bh_lru
> is slower than __find_get_block_slow:
> 
>  114 ns per __find_get_block
>  68 ns per __find_get_block_slow
> 
> So remove the per-CPU buffer_head caching.

LOL.  That's amazing.  I can't even see why it's so expensive.  The
local_irq_disable(), perhaps?  Your test case is the best possible
one for lookup_bh_lru() where you're not even doing the copy.

Reviewed-by: Matthew Wilcox (oracle) <willy@infradead.org>
