Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAFB6C7761
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 06:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjCXFcD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 01:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCXFcC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 01:32:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E01DDF;
        Thu, 23 Mar 2023 22:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1BmTo3I8QkfWboWz9yBcSlQ5saXqUc+9dJqdWN9G/vU=; b=AfM5t8sCUNWR8N6YGgoFczZsvS
        fFFet8zV//rwbX+LCjJZVLEGh2ryAto1FOB9Mt9aDndLMi1O6gCTwGsZ8U/ZYwtPTtyjXbxQkCQvw
        4lko75Guk0XFB7N0VMUMq2CQCyShHKE5Jm7LtngaCV11rBjjzFS+Pk8c3vEgp3vF/GdYrHCYFJdKh
        qb6JsVf3Q2Xo0KiKUU8svLDa/TNPjWx5UhZ6UA/unNSgDUcuAjgtQsxOee/QIvyGvetM6eQjTlz+0
        sEkC+VdWrliorsh+Ttbwz+/Ogd9P6Efn+NOFJiIwDEX7vHf5wgE8MTO7Jc1BtSDInewrBNaksrpEf
        eNJLscTw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfa1s-004bzx-0b; Fri, 24 Mar 2023 05:31:56 +0000
Date:   Fri, 24 Mar 2023 05:31:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 2/4] mm: vmalloc: use rwsem, mutex for vmap_area_lock
 and vmap_block->lock
Message-ID: <ZB01yw3MpOswyL1e@casper.infradead.org>
References: <cover.1679209395.git.lstoakes@gmail.com>
 <6c7f1ac0aeb55faaa46a09108d3999e4595870d9.1679209395.git.lstoakes@gmail.com>
 <ZBkDuLKLhsOHNUeG@destitution>
 <ZBsAG5cpOFhFZZG6@pc636>
 <ZB00U2S4g+VqzDPL@destitution>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB00U2S4g+VqzDPL@destitution>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 24, 2023 at 04:25:39PM +1100, Dave Chinner wrote:
> Did you read the comment above this function? I mean, it's all about
> how poorly kvmalloc() works for the highly concurrent, fail-fast
> context that occurs in the journal commit fast path, and how we open
> code it with kmalloc and vmalloc to work "ok" in this path.
> 
> Then if you go look at the commits related to it, you might find
> that XFS developers tend to write properly useful changelogs to
> document things like "it's better, but vmalloc will soon have lock
> contention problems if we hit it any harder"....

The problem with writing whinges like this is that mm developers don't
read XFS changelogs.  I certainly had no idea this was a problem, and
I doubt anybody else who could make a start at fixing this problem had
any idea either.  Why go to all this effort instead of sending an email
to linux-mm?
