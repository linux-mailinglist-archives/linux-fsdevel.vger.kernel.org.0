Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5C47A585B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 06:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjISEUb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 00:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjISEUa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 00:20:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760558F;
        Mon, 18 Sep 2023 21:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rkouqG7ezneLR9fXmWK2z8oVOJc/7J+HE9nJ0wqC52Y=; b=plJiV8FDPUDBI4qF+NloBKEGkW
        sjP88Q+Je4DqE07zwn4QkJTvUIW2BTfWyUsIlTh72QHODMmxjmJhITZPCtOE4E9iLra/UiKRYpdX7
        FVDc3aUxetTxkSiJF0WfxpVr7bg1Ki8cFYt6qtZ1OWGKp589GCmw4YBFSaYs7KTT+PkbyytSgdb8s
        4QbdhLWcjJxfuLepxUEy+ci9po9r0SAaqWcYRzVVBFaNj6TKS5iPgLFKybZ3cz3THYkWOE58WRv0N
        J1Ytx/vzXVxEty3t7Eq2ZySvC4nZKI9hI9Yhtj8B0QISswaK7uD6bAGKQHInb1uGnRYWcYJiB2S1D
        KN0/6UTA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiSDh-00F5MH-Ue; Tue, 19 Sep 2023 04:20:18 +0000
Date:   Tue, 19 Sep 2023 05:20:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Jan Kara <jack@suse.cz>, Philipp Stanner <pstanner@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v1 1/1] xarray: fix the data-race in xas_find_chunk() by
 using READ_ONCE()
Message-ID: <ZQkhgVb8nWGxpSPk@casper.infradead.org>
References: <20230918044739.29782-1-mirsad.todorovac@alu.unizg.hr>
 <20230918094116.2mgquyxhnxcawxfu@quack3>
 <22ca3ad4-42ef-43bc-51d0-78aaf274977b@alu.unizg.hr>
 <20230918113840.h3mmnuyer44e5bc5@quack3>
 <fb0f5ba9-7fe3-a951-0587-640e7672efec@alu.unizg.hr>
 <ZQhlt/EbRf3Y+0jT@yury-ThinkPad>
 <20230918155403.ylhfdbscgw6yek6p@quack3>
 <cda628df-1933-cce8-86cd-23346541e3d8@alu.unizg.hr>
 <ZQidZLUcrrITd3Vy@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQidZLUcrrITd3Vy@yury-ThinkPad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 11:56:36AM -0700, Yury Norov wrote:
> Guys, I lost the track of the conversation. In the other email Mirsad
> said:
>         Which was the basic reason in the first place for all this, because something changed
>         data from underneath our fingers ..
> 
> It sounds clearly to me that this is a bug in xarray, *revealed* by
> find_next_bit() function. But later in discussion you're trying to 'fix'
> find_*_bit(), like if find_bit() corrupted the bitmap, but it's not.

No, you're really confused.  That happens.

KCSAN is looking for concurrency bugs.  That is, does another thread
mutate the data "while" we're reading it.  It does that by reading
the data, delaying for a few instructions and reading it again.  If it
changed, clearly there's a race.  That does not mean there's a bug!

Some races are innocuous.  Many races are innocuous!  The problem is
that compilers sometimes get overly clever and don't do the obvious
thing you ask them to do.  READ_ONCE() serves two functions here;
one is that it tells the compiler not to try anything fancy, and
the other is that it tells KCSAN to not bother instrumenting this
load; no load-delay-reload.

> In previous email Jan said:
>         for any sane compiler the generated assembly with & without READ_ONCE()
>         will be exactly the same.
> 
> If the code generated with and without READ_ONCE() is the same, the
> behavior would be the same, right? If you see the difference, the code
> should differ.

Hopefully now you understand why this argument is wrong ...

> You say that READ_ONCE() in find_bit() 'fixes' 200 KCSAN BUG warnings. To
> me it sounds like hiding the problems instead of fixing. If there's a race
> between writing and reading bitmaps, it should be fixed properly by
> adding an appropriate serialization mechanism. Shutting Kcsan up with
> READ_ONCE() here and there is exactly the opposite path to the right direction.

Counterpoint: generally bitmaps are modified with set_bit() which
actually is atomic.  We define so many bitmap things as being atomic
already, it doesn't feel like making find_bit() "must be protected"
as a useful use of time.

But hey, maybe I'm wrong.  Mirsad, can you send Yury the bug reports
for find_bit and friends, and Yury can take the time to dig through them
and see if there are any real races in that mess?

> Every READ_ONCE must be paired with WRITE_ONCE, just like atomic
> reads/writes or spin locks/unlocks. Having that in mind, adding
> READ_ONCE() in find_bit() requires adding it to every bitmap function
> out there. And this is, as I said before, would be an overhead for
> most users.

I don't believe you.  Telling the compiler to stop trying to be clever
rarely results in a performance loss.
