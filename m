Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055496C5332
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 19:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjCVSCV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 14:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjCVSCU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:02:20 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860CF637E2;
        Wed, 22 Mar 2023 11:02:05 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id g18so19882957ljl.3;
        Wed, 22 Mar 2023 11:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679508123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JwUCDjhYJ2a7073mqWzTvGLtdUHwAkcfH5JIKPsTW68=;
        b=oqLHMXCYsY+gsau0mwJiKS5TtN9SSBtg8MhQcPo3fZGD4yrR5kQWGqzul2ampzdd65
         BETpw0014C2YFyzW/u0xYdaG4atUoJPcEZM2bWD4LRIj/cUcdxbJ3b6fjermOzTqr7hm
         ZTEwEAMBtWuNyiYOgpdg7f9tc2SEg/mMxwCSkSWs38GEJSgaFGIt245t0QxsJShEwXPi
         v0hBhu4OEc37arP46tBLtjEoj+sdMUM+EBx7gv+n2X7TL4XWebUHKxhzCGkGOhhtv+gB
         HA3+rMZ7xtsxJqSZryWQsTkFJalOdG9HivXsQgw6zAs4vL7vvk9rOts2r1SqTmzxa58N
         GF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679508123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwUCDjhYJ2a7073mqWzTvGLtdUHwAkcfH5JIKPsTW68=;
        b=ajkscsYxQxSksnKlEcdNzztcEvP0qE1qJJcPEN3rKQyTSUxzDzZ6W/f9yREQ3GWWbd
         8FhuQYxaWgVTQpR0ALsDM44hPZHsOn+VOM3aWCbpCs2hCfm2mTkXXGqysqLA7evlJuxL
         cJKuFN/6dufK4ig7tflinomuO+UaUl/z5cn7oU5+F9M8lT87eK7SqmpBh34D2C8Mv89W
         jxUaAlwXBbEbl0LMuOjamTB5NIQ0FMEkqiXn14snwcINOup3MxqUTvqI/irRJLddXG8z
         Ou4GzB2RZ3vQxXwIWs6gfDHOeQTb1ZPCdTm1Uh9xmW2cGLvYtnOgiDQ0bixq2HWDkD8/
         uJbg==
X-Gm-Message-State: AO0yUKW01Cpk8z+G7htVn5+z946mGLxoEMeofeooNowLjD3AFQFbgCJx
        a0+oOVAg3uT/EFlszDc/rrseu+Wywd/wSA==
X-Google-Smtp-Source: AK7set+WrGPgWrQYQT8Sd3u2awKK6uK0q077O1POjdtMhbP9qjZvEUHtIhG31F+lYJvU2LqMVppR3g==
X-Received: by 2002:a2e:994a:0:b0:299:a7c7:d4ce with SMTP id r10-20020a2e994a000000b00299a7c7d4cemr2994468ljj.21.1679508123346;
        Wed, 22 Mar 2023 11:02:03 -0700 (PDT)
Received: from pc636 (host-90-233-209-15.mobileonline.telia.com. [90.233.209.15])
        by smtp.gmail.com with ESMTPSA id v21-20020a2e7a15000000b00295b1ad177csm2608383ljc.68.2023.03.22.11.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 11:02:02 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 22 Mar 2023 19:01:59 +0100
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 2/4] mm: vmalloc: use rwsem, mutex for vmap_area_lock
 and vmap_block->lock
Message-ID: <ZBtCl34dolg2YE+3@pc636>
References: <cover.1679209395.git.lstoakes@gmail.com>
 <6c7f1ac0aeb55faaa46a09108d3999e4595870d9.1679209395.git.lstoakes@gmail.com>
 <ZBkDuLKLhsOHNUeG@destitution>
 <ZBsAG5cpOFhFZZG6@pc636>
 <ZBs/MGH+xUAZXNTz@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBs/MGH+xUAZXNTz@casper.infradead.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 22, 2023 at 05:47:28PM +0000, Matthew Wilcox wrote:
> On Wed, Mar 22, 2023 at 02:18:19PM +0100, Uladzislau Rezki wrote:
> > Hello, Dave.
> > 
> > > 
> > > I'm travelling right now, but give me a few days and I'll test this
> > > against the XFS workloads that hammer the global vmalloc spin lock
> > > really, really badly. XFS can use vm_map_ram and vmalloc really
> > > heavily for metadata buffers and hit the global spin lock from every
> > > CPU in the system at the same time (i.e. highly concurrent
> > > workloads). vmalloc is also heavily used in the hottest path
> > > throught the journal where we process and calculate delta changes to
> > > several million items every second, again spread across every CPU in
> > > the system at the same time.
> > > 
> > > We really need the global spinlock to go away completely, but in the
> > > mean time a shared read lock should help a little bit....
> > > 
> > Could you please share some steps how to run your workloads in order to
> > touch vmalloc() code. I would like to have a look at it in more detail
> > just for understanding the workloads.
> > 
> > Meanwhile my grep agains xfs shows:
> > 
> > <snip>
> > urezki@pc638:~/data/raid0/coding/linux-rcu.git/fs/xfs$ grep -rn vmalloc ./
> 
> You're missing:
> 
> fs/xfs/xfs_buf.c:                       bp->b_addr = vm_map_ram(bp->b_pages, bp->b_page_count,
> 
> which i suspect is the majority of Dave's workload.  That will almost
> certainly take the vb_alloc() path.
>
Then it has nothing to do with vmalloc contention(i mean global KVA allocator), IMHO.
Unless:

<snip>
void *vm_map_ram(struct page **pages, unsigned int count, int node)
{
	unsigned long size = (unsigned long)count << PAGE_SHIFT;
	unsigned long addr;
	void *mem;

	if (likely(count <= VMAP_MAX_ALLOC)) {
		mem = vb_alloc(size, GFP_KERNEL);
		if (IS_ERR(mem))
			return NULL;
		addr = (unsigned long)mem;
	} else {
		struct vmap_area *va;
		va = alloc_vmap_area(size, PAGE_SIZE,
				VMALLOC_START, VMALLOC_END, node, GFP_KERNEL);
		if (IS_ERR(va))
			return NULL;
<snip>

number of pages > VMAP_MAX_ALLOC.

That is why i have asked about workloads because i would like to understand
where a "problem" is. A vm_map_ram() access the global vmap space but it happens 
when a new vmap block is required and i also think it is not a problem.

But who knows, therefore it makes sense to have a lock at workload.

--
Uladzislau Rezki
