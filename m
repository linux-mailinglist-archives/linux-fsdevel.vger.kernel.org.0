Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA2843D028
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 19:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240153AbhJ0R6W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 13:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236956AbhJ0R6U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 13:58:20 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70990C061570;
        Wed, 27 Oct 2021 10:55:54 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u21so7839139lff.8;
        Wed, 27 Oct 2021 10:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rcGfcajvU3WsNLuno0BLLT5c2SXf+7yDyUVgH/5EtJ0=;
        b=pGgt/sKC5tdZ0XnZWX1AekLlFrJwaVMWQIiXwaHWYYGkQ7viDPhGS7tHaQ+C+HpcJ3
         NgOLAi9SX5ieR1r+ZRIsikSrizfYlnQ1eqZ5MSSxF0uhPZ5+WCNoDOBI1iu70yZgvFmz
         LAJ/ikw7O5+f8jJcpV6C1rbIM3lM6avuPvTvIAVGdY7LXnV92m3XCPAKDRYkuSoh9/NK
         PChdRAcghhXbyeoBX3kaRshkA1etLrbumZkTXaoKTVS9DfV+VlNkfwquevtF0B90FnuA
         C3cWtyr6JxBWgvPXMu7cqQcV1MCrgwwFVFEJtjoW3HvEveHBbBkOJUTF82JT+R38Gfy1
         6/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rcGfcajvU3WsNLuno0BLLT5c2SXf+7yDyUVgH/5EtJ0=;
        b=s8IgG6u0B/6bDmHadeXJY4eN+H5I3RU81h6Camsgt5fSGE1Hjv8CKJU308xlFgOPHG
         8H/nVXVMKGkqH6T8L84iHEr2nKXHNW7O38xyjQHLih+TfkQd/13CybPWj9Z0RFP8tPM6
         HKBdRlOqn+G4DXVXuGHFy7KeK+VNNfWjjpSiYYXOcnNS441C6V4ANL1sKe3OHIEgsZdL
         S96kKdE60dlq4hTKvdMDXDvYbgNYoYmnXhZ5kVR1vhlIRr6Cp6hY5ZC5ZGNQXtePq9YA
         bChZOMejhL6YU40cST3cgyBq9mYNzgB1SLxUdBdUxv3X7zsHNfJw7b1I4o9R9tW+8mhN
         CHXA==
X-Gm-Message-State: AOAM530+qQAm9DTzLbWfK4AZKx5LDlRz5+Qq8sak326QNI+jMFYczDvc
        YMvlM2mhTNAv+jwZAN+W2dw=
X-Google-Smtp-Source: ABdhPJy3nzz/o1ioToBJAxUtyKS+4YAa4BFU5E5uInLMfnISst6r17sY00QthpTohOrmErmxXSHzqg==
X-Received: by 2002:a05:6512:ace:: with SMTP id n14mr29804819lfu.460.1635357352725;
        Wed, 27 Oct 2021 10:55:52 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id d5sm62273lfi.96.2021.10.27.10.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 10:55:52 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 27 Oct 2021 19:55:50 +0200
To:     Michal Hocko <mhocko@suse.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <20211027175550.GA1776@pc638.lan>
References: <20211025150223.13621-1-mhocko@kernel.org>
 <20211025150223.13621-3-mhocko@kernel.org>
 <CA+KHdyVqOuKny7bT+CtrCk8BrnARYz744Ze6cKMuy2BXo5e7jw@mail.gmail.com>
 <YXgsxF/NRlHjH+Ng@dhcp22.suse.cz>
 <20211026193315.GA1860@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026193315.GA1860@pc638.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 26, 2021 at 09:33:15PM +0200, Uladzislau Rezki wrote:
> On Tue, Oct 26, 2021 at 06:28:52PM +0200, Michal Hocko wrote:
> > On Tue 26-10-21 17:48:32, Uladzislau Rezki wrote:
> > > > From: Michal Hocko <mhocko@suse.com>
> > > >
> > > > Dave Chinner has mentioned that some of the xfs code would benefit from
> > > > kvmalloc support for __GFP_NOFAIL because they have allocations that
> > > > cannot fail and they do not fit into a single page.
> > > >
> > > > The larg part of the vmalloc implementation already complies with the
> > > > given gfp flags so there is no work for those to be done. The area
> > > > and page table allocations are an exception to that. Implement a retry
> > > > loop for those.
> > > >
> > > > Add a short sleep before retrying. 1 jiffy is a completely random
> > > > timeout. Ideally the retry would wait for an explicit event - e.g.
> > > > a change to the vmalloc space change if the failure was caused by
> > > > the space fragmentation or depletion. But there are multiple different
> > > > reasons to retry and this could become much more complex. Keep the retry
> > > > simple for now and just sleep to prevent from hogging CPUs.
> > > >
> > > > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > > > ---
> > > >  mm/vmalloc.c | 10 +++++++++-
> > > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index c6cc77d2f366..602649919a9d 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -2941,8 +2941,12 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> > > >         else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
> > > >                 flags = memalloc_noio_save();
> > > >
> > > > -       ret = vmap_pages_range(addr, addr + size, prot, area->pages,
> > > > +       do {
> > > > +               ret = vmap_pages_range(addr, addr + size, prot, area->pages,
> > > >                         page_shift);
> > > > +               if (ret < 0)
> > > > +                       schedule_timeout_uninterruptible(1);
> > > > +       } while ((gfp_mask & __GFP_NOFAIL) && (ret < 0));
> > > >
> > > 
> > > 1.
> > > After that change a below code:
> > > 
> > > <snip>
> > > if (ret < 0) {
> > >     warn_alloc(orig_gfp_mask, NULL,
> > >         "vmalloc error: size %lu, failed to map pages",
> > >         area->nr_pages * PAGE_SIZE);
> > >     goto fail;
> > > }
> > > <snip>
> > > 
> > > does not make any sense anymore.
> > 
> > Why? Allocations without __GFP_NOFAIL can still fail, no?
> > 
> Right. I meant one thing but wrote slightly differently. In case of
> vmap_pages_range() fails(if __GFP_NOFAIL is set) should we emit any
> warning message? Because either we can recover on a future iteration
> or it stuck there infinitely so a user does not understand what happened.
> From the other hand this is how __GFP_NOFAIL works, hm..
> 
> Another thing, i see that schedule_timeout_uninterruptible(1) is invoked
> for all cases even when __GFP_NOFAIL is not set, in that scenario we do
> not want to wait, instead we should return back to a caller asap. Or am
> i missing something here?
> 
> > > 2.
> > > Can we combine two places where we handle __GFP_NOFAIL into one place?
> > > That would look like as more sorted out.
> > 
> > I have to admit I am not really fluent at vmalloc code so I wanted to
> > make the code as simple as possible. How would I unwind all the allocated
> > memory (already allocated as GFP_NOFAIL) before retrying at
> > __vmalloc_node_range (if that is what you suggest). And isn't that a
> > bit wasteful?
> > 
> > Or did you have anything else in mind?
> >
> It depends on how often all this can fail. But let me double check if
> such combining is easy.
> 
I mean something like below. The idea is to not spread the __GFP_NOFAIL
across the vmalloc file keeping it in one solid place:

<snip>
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d77830ff604c..f4b7927e217e 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2889,8 +2889,14 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	unsigned long array_size;
 	unsigned int nr_small_pages = size >> PAGE_SHIFT;
 	unsigned int page_order;
+	unsigned long flags;
+	int ret;
 
 	array_size = (unsigned long)nr_small_pages * sizeof(struct page *);
+
+	/*
+	 * This is i do not understand why we do not want to see warning messages.
+	 */
 	gfp_mask |= __GFP_NOWARN;
 	if (!(gfp_mask & (GFP_DMA | GFP_DMA32)))
 		gfp_mask |= __GFP_HIGHMEM;
@@ -2930,8 +2936,23 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		goto fail;
 	}
 
-	if (vmap_pages_range(addr, addr + size, prot, area->pages,
-			page_shift) < 0) {
+	/*
+	 * page tables allocations ignore external gfp mask, enforce it
+	 * by the scope API
+	 */
+	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
+		flags = memalloc_nofs_save();
+	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
+		flags = memalloc_noio_save();
+
+	ret = vmap_pages_range(addr, addr + size, prot, area->pages, page_shift);
+
+	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
+		memalloc_nofs_restore(flags);
+	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
+		memalloc_noio_restore(flags);
+
+	if (ret < 0) {
 		warn_alloc(gfp_mask, NULL,
 			"vmalloc error: size %lu, failed to map pages",
 			area->nr_pages * PAGE_SIZE);
@@ -2984,6 +3005,12 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 		return NULL;
 	}
 
+	/*
+	 * Suppress all warnings for __GFP_NOFAIL allocation.
+	 */
+	if (gfp_mask & __GFP_NOFAIL)
+		gfp_mask |= __GFP_NOWARN;
+
 	if (vmap_allow_huge && !(vm_flags & VM_NO_HUGE_VMAP)) {
 		unsigned long size_per_node;
 
@@ -3010,16 +3037,22 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 	area = __get_vm_area_node(real_size, align, shift, VM_ALLOC |
 				  VM_UNINITIALIZED | vm_flags, start, end, node,
 				  gfp_mask, caller);
-	if (!area) {
-		warn_alloc(gfp_mask, NULL,
-			"vmalloc error: size %lu, vm_struct allocation failed",
-			real_size);
-		goto fail;
-	}
+	if (area)
+		addr = __vmalloc_area_node(area, gfp_mask, prot, shift, node);
+
+	if (!area || !addr) {
+		if (gfp_mask & __GFP_NOFAIL) {
+			schedule_timeout_uninterruptible(1);
+			goto again;
+		}
+
+		if (!area)
+			warn_alloc(gfp_mask, NULL,
+				"vmalloc error: size %lu, vm_struct allocation failed",
+				real_size);
 
-	addr = __vmalloc_area_node(area, gfp_mask, prot, shift, node);
-	if (!addr)
 		goto fail;
+	}
 
 	/*
 	 * In this function, newly allocated vm_struct has VM_UNINITIALIZED
<snip>

--
Vlad Rezki
