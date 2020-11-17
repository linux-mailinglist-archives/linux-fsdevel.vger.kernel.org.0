Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119432B69FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 17:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgKQQ03 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 11:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgKQQ03 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:26:29 -0500
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E0EC0617A6
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2020 08:26:28 -0800 (PST)
Received: by mail-oo1-xc41.google.com with SMTP id y3so4867597ooq.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2020 08:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=z75qkcvTDD7D5ZVAs+uCqlqVE13UoCxrYrBW5Z0YsDk=;
        b=NbWG5mavXseC8TwQhZgdUwUaEBWIg13azPa/dMhqYJ71H7R1Z/qeTEhVaPbUVfXyE7
         cuuDbCoMHIkFBt9qXX+uZsQB+89riqdLmQ+Ffxx0ad4LOr351/dC7ap3Si3KFvSK4Mbu
         qKKfB3tCkpSSeKQ40lQuoVQzZYl8KLmUe7l8MnAJpt/8rqT5/DrPdYZfW0upTES0dNdI
         a6Yxcj79g/bjpQENWeUZUTpbfKlPhhN0tzEyTZrTW7+jaOqhRfIEw5d0vt2cZc8xGLWG
         VGnbiU/hV7wmCd9cvERoCxcrALe9HXxE5vyEiqOzyoKTFOR/LBmkiop+NMI7MROxwuoU
         oyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=z75qkcvTDD7D5ZVAs+uCqlqVE13UoCxrYrBW5Z0YsDk=;
        b=kncr3UtKM+Y239RywvSRN4Lwivk/yVcfzgHzRtNqjw/ebc0LPQSOuRhzVs7YqikP7p
         seN6zqICNuTxqdEYngs5sRZsY+dScg5aViXwSJupuHYXrs6iQp7w7phY935GGxCNivRW
         ILKlLgxwNVU6W5jiyv+iJ9G4yG9IrsxPNojOio2WewqeAqU1LP3GnyJIcfy0LOYjKRxH
         EilYyYqn4VO8KrjhyLVwLTv3nySCWsfqszDcQJYqYFGWGmcqVRNQJ4KTJeFuFRcvXpQ8
         89z3D2gKHGUHDQElBwlybbL6TgRCMKCxa2UI1d4QrhvqiHSfHm1j1/0fECbheVJKfh0m
         RPPA==
X-Gm-Message-State: AOAM530PeoiPI/UuCUgvledNW5XIRjnniBm1fLdRWor/WT7ZPbaPGiMl
        Ne8WwDfdTp8fjj3V4JDpxhdJlw==
X-Google-Smtp-Source: ABdhPJwEbtJaSAIffWbfsiQiaPRdu+CN3ysGQxSh48oJAho68bZkA6+kWULhGCBChKSe1hVhZ9aP1w==
X-Received: by 2002:a4a:e5ce:: with SMTP id r14mr3587297oov.11.1605630387621;
        Tue, 17 Nov 2020 08:26:27 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b123sm6262913oii.47.2020.11.17.08.26.25
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 17 Nov 2020 08:26:26 -0800 (PST)
Date:   Tue, 17 Nov 2020 08:26:03 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/16] Overhaul multi-page lookups for THP
In-Reply-To: <20201117153947.GL29991@casper.infradead.org>
Message-ID: <alpine.LSU.2.11.2011170820030.1014@eggly.anvils>
References: <20201112212641.27837-1-willy@infradead.org> <alpine.LSU.2.11.2011160128001.1206@eggly.anvils> <20201117153947.GL29991@casper.infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 17 Nov 2020, Matthew Wilcox wrote:
> On Mon, Nov 16, 2020 at 02:34:34AM -0800, Hugh Dickins wrote:
> > Fix to [PATCH v4 15/16] mm/truncate,shmem: Handle truncates that split THPs.
> > One machine ran fine, swapping and building in ext4 on loop0 on huge tmpfs;
> > one machine got occasional pages of zeros in its .os; one machine couldn't
> > get started because of ext4_find_dest_de errors on the newly mkfs'ed fs.
> > The partial_end case was decided by PAGE_SIZE, when there might be a THP
> > there.  The below patch has run well (for not very long), but I could
> > easily have got it slightly wrong, off-by-one or whatever; and I have
> > not looked into the similar code in mm/truncate.c, maybe that will need
> > a similar fix or maybe not.
> 
> Thank you for the explanation in your later email!  There is indeed an
> off-by-one, although in the safe direction.
> 
> > --- 5103w/mm/shmem.c	2020-11-12 15:46:21.075254036 -0800
> > +++ 5103wh/mm/shmem.c	2020-11-16 01:09:35.431677308 -0800
> > @@ -874,7 +874,7 @@ static void shmem_undo_range(struct inod
> >  	long nr_swaps_freed = 0;
> >  	pgoff_t index;
> >  	int i;
> > -	bool partial_end;
> > +	bool same_page;
> >  
> >  	if (lend == -1)
> >  		end = -1;	/* unsigned, so actually very big */
> > @@ -907,16 +907,12 @@ static void shmem_undo_range(struct inod
> >  		index++;
> >  	}
> >  
> > -	partial_end = ((lend + 1) % PAGE_SIZE) > 0;
> > +	same_page = (lstart >> PAGE_SHIFT) == end;
> 
> 'end' is exclusive, so this is always false.  Maybe something "obvious":
> 
> 	same_page = (lstart >> PAGE_SHIFT) == (lend >> PAGE_SHIFT);
> 
> (lend is inclusive, so lend in 0-4095 are all on the same page)

My brain is not yet in gear this morning, so I haven't given this the
necessary thought: but I do have to question what you say there, and
throw it back to you for the further thought -

the first shmem_getpage(inode, lstart >> PAGE_SHIFT, &page, SGP_READ);
the second shmem_getpage(inode, end, &page, SGP_READ).
So same_page = (lstart >> PAGE_SHIFT) == end
had seemed right to me.

> 
> >  	page = NULL;
> >  	shmem_getpage(inode, lstart >> PAGE_SHIFT, &page, SGP_READ);
> >  	if (page) {
> > -		bool same_page;
> > -
> >  		page = thp_head(page);
> >  		same_page = lend < page_offset(page) + thp_size(page);
> > -		if (same_page)
> > -			partial_end = false;
> >  		set_page_dirty(page);
> >  		if (!truncate_inode_partial_page(page, lstart, lend)) {
> >  			start = page->index + thp_nr_pages(page);
> > @@ -928,7 +924,7 @@ static void shmem_undo_range(struct inod
> >  		page = NULL;
> >  	}
> >  
> > -	if (partial_end)
> > +	if (!same_page)
> >  		shmem_getpage(inode, end, &page, SGP_READ);
> >  	if (page) {
> >  		page = thp_head(page);
> 
