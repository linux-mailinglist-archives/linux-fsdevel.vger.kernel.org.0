Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8819A2B53D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 22:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbgKPV2J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 16:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbgKPV2J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 16:28:09 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19105C0613D2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2020 13:28:09 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id n89so17445467otn.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2020 13:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=xbx+XzcPct/46zaNl1olGwUlxfEGJ/8djflBdlJjy9s=;
        b=uanpSTuRyE6qBHQPB9Uzp1JeNZCVlz9ZnTZjVNE17hT3vF1opz2Iu22yaD8LvRPOl2
         1FC/kdUyLbX2jcGvS60cnowHpo/Uj1A3Kg14sgt7K6Jhs0+ttpaUmnwOlFN+isKv82Df
         vYWiOJ00WWE6cpvywFEJ3Rdv3Z5fG5iJkJixs+V5sqKybgg+sSKf2F0Aygb96k0PAex9
         WbDdCOnUP+AzZpF4vX6W7TE+a0CRC0RyQE3394IC4m5YWDHwGjZROy6lJYo+PBWMpeCR
         Vp4i/kBxiLWfa0mW8PGGqvznjf/UKdnsB/4yHSE4f0Oe7rBN1JF8s2ZX0nok87/6dCo1
         l79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=xbx+XzcPct/46zaNl1olGwUlxfEGJ/8djflBdlJjy9s=;
        b=bdKldgzoFMourm78aa9zrFwZIv1UUur1IO1hVDDyOD27JF2RpLY/fdF7Hb7cVHNt8F
         387C/M4sqfY2XwzZYMHxkJQUWhBNGNDw1Z82OCs2l7beeysfLkvR4g4icxk8J1we5Nay
         wWm5g7dFcwoiZP90gHS0jpSRRANoLkl7WUyIt5tYnvKNy5EwzgOasvAxXDTU2fcqy0Zw
         sGfeK6LtaoLKNhH5uAT5YG+TTw8twE4x2879xjKT95iLF15t+ULT0cnixqB8gtbQ6ofT
         aTTrILTCLR33D71EiaAszvGPJYHJp6+F8/XiT0RCB+GDaduz+B996ja5EOMKZUcx0Xh9
         zQPw==
X-Gm-Message-State: AOAM533JT6VVhAld3KPnYYsJw2pwKRx7BaePjk+Hdno3gsiWhb7YvMti
        7RI5hBNBnnghK6r7VC8fuWiKEA==
X-Google-Smtp-Source: ABdhPJwLCs4aAHTGw/t7fwa4Lc3WRXdKVDyfGTyNBrrOzucIHBytPaP212fyMahz0+2uVmNg+4Di4w==
X-Received: by 2002:a9d:69d5:: with SMTP id v21mr985210oto.176.1605562087950;
        Mon, 16 Nov 2020 13:28:07 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m17sm5053643otq.57.2020.11.16.13.28.05
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 16 Nov 2020 13:28:06 -0800 (PST)
Date:   Mon, 16 Nov 2020 13:27:47 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/16] Overhaul multi-page lookups for THP
In-Reply-To: <20201116151444.GB29991@casper.infradead.org>
Message-ID: <alpine.LSU.2.11.2011161145320.1071@eggly.anvils>
References: <20201112212641.27837-1-willy@infradead.org> <alpine.LSU.2.11.2011160128001.1206@eggly.anvils> <20201116151444.GB29991@casper.infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 16 Nov 2020, Matthew Wilcox wrote:
> On Mon, Nov 16, 2020 at 02:34:34AM -0800, Hugh Dickins wrote:
> > On Thu, 12 Nov 2020, Matthew Wilcox (Oracle) wrote:
> > 
> > > This THP prep patchset changes several page cache iteration APIs to only
> > > return head pages.
> > > 
> > >  - It's only possible to tag head pages in the page cache, so only
> > >    return head pages, not all their subpages.
> > >  - Factor a lot of common code out of the various batch lookup routines
> > >  - Add mapping_seek_hole_data()
> > >  - Unify find_get_entries() and pagevec_lookup_entries()
> > >  - Make find_get_entries only return head pages, like find_get_entry().
> > > 
> > > These are only loosely connected, but they seem to make sense together
> > > as a series.
> > > 
> > > v4:
> > >  - Add FGP_ENTRY, remove find_get_entry and find_lock_entry
> > >  - Rename xas_find_get_entry to find_get_entry
> > >  - Add "Optimise get_shadow_from_swap_cache"
> > >  - Move "iomap: Use mapping_seek_hole_data" to this patch series
> > >  - Rebase against next-20201112
> > 
> > I hope next-20201112 had nothing vital for this series, I applied
> > it to v5.10-rc3, and have been busy testing huge tmpfs on that.
> 
> Thank you.  It's plain I'm not able to hit these cases ... I do run
> xfstests against shmem, but that's obviously not good enough.  Can
> you suggest something I should be running to improve my coverage?

Not quickly.

I'll send you a builds.tar.xz of my tmpfs kernel builds swapping load,
like I sent Alex Shi for his lru_lock testing back in March: but no
point in resending exactly that, before I've updated its source patch
to suit less ancient compilers.  Sometime in the next week.  It's hard
to get working usefully in new environments: probably better as source
of ideas (like building kernel in ext4 on loop on huge tmpfs while
swapping) than as something to duplicate and run directly.

I haven't tried LTP on your series yet, will do so later today.
I install into a huge tmpfs mounted at /opt/ltp and run it there,
with /sys/kernel/mm/transparent_hugepage/shmem_enabled "force"
and khugepaged expedited.  Doesn't usually find anything, but
well worth a go.  I'll be doing it based on 5.10-rc3 or rc4:
avoiding mmotm or linux-next at the moment, because I've noticed
that Rik's shmem THP gfp_mask mods have severely limited the use
of huge pages in my testing there: maybe I just need to tweak defrag,
or maybe I'll want the patches adjusted - I just haven't looked yet,
making your series safe took priority.  (And aside from Rik's, there
seemed to be something else affecting the use of huge pages in mmotm,
not investigated yet.)

xfstests: awkward time to ask, since I'm amidst transitioning from
my old internal hack for user xattrs to what I had hoped to get into
next release (enabling them, but restricting to the nr_inodes space),
but too late for that now.  So I have a few workaround patches to the
xfstests tree, and a few tmpfs patches to the kernel tree, but in flux
at the moment.  Not that user xattrs are much related to your series.
If you've got xfstests going on tmpfs, probably the easiest thing to
add is /sys/kernel/mm/transparent_hugepage/shmem_enabled "force",
so that mounts are huge=always by default.

I do have six xfstests failing with your series, that passed before;
but I have not had time to analyse those yet, and don't even want to
enumerate them yet.  Some will probably be "not run"s in a standard
tree, so hard for you to try; and maybe all of them will turn out to
depend on different interpretations of small holes in huge pages -
not necessarily anything to worry about.  But I wonder if they might
relate to failures to split: your truncate_inode_partial_page() work
is very nice, but for better or worse it does skip all the retries
implicit in the previous way of proceeding.

> 
> > Fix to [PATCH v4 06/16] mm/filemap: Add helper for finding pages.
> > I hit that VM_BUG_ON_PAGE(!thp_contains) when swapping, it is not
> > safe without page lock, during the interval when shmem is moving a
> > page between page cache and swap cache.  It could be tightened by
> > passing in a new FGP to distinguish whether searching page or swap
> > cache, but I think never tight enough in the swap case - because there
> > is no rule for persisting page->private as there is for page->index.
> > The best I could do is:
> 
> I'll just move this out to the caller who actually locks the page:
> 
> +++ b/mm/filemap.c
> @@ -1839,7 +1839,6 @@ static inline struct page *find_get_entry(struct xa_state *xas, pgoff_t max,
>                 put_page(page);
>                 goto reset;
>         }
> -       VM_BUG_ON_PAGE(!thp_contains(page, xas->xa_index), page);
>  
>         return page;
>  reset:
> @@ -1923,6 +1922,8 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
>                                 goto put;
>                         if (page->mapping != mapping || PageWriteback(page))
>                                 goto unlock;
> +                       VM_BUG_ON_PAGE(!thp_contains(page, xas->xa_index),
> +                                       page);
>                 }
>                 indices[pvec->nr] = xas.xa_index;
>                 if (!pagevec_add(pvec, page))
> 

Okay, up to you: that's obviously much cleaner-looking than what I did;
and if it covers all the cases you're most concerned about, fine (but
your original placing did check some other usages, and I didn't want to
weaken them - though now I notice that e.g. mapping_get_entry() has no
equivalent check, so the find_get_entry() check was exceptional).

> > Fix to [PATCH v4 07/16] mm/filemap: Add mapping_seek_hole_data.
> > Crashed on a swap entry 0x2ff09, fairly obvious...
> 
> Whoops.  Thanks.
> 
> > Fix to [PATCH v4 15/16] mm/truncate,shmem: Handle truncates that split THPs.
> > One machine ran fine, swapping and building in ext4 on loop0 on huge tmpfs;
> > one machine got occasional pages of zeros in its .os; one machine couldn't
> > get started because of ext4_find_dest_de errors on the newly mkfs'ed fs.
> > The partial_end case was decided by PAGE_SIZE, when there might be a THP
> > there.  The below patch has run well (for not very long), but I could
> > easily have got it slightly wrong, off-by-one or whatever; and I have
> > not looked into the similar code in mm/truncate.c, maybe that will need
> > a similar fix or maybe not.
> > 
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
> >  	page = NULL;
> >  	shmem_getpage(inode, lstart >> PAGE_SHIFT, &page, SGP_READ);
> >  	if (page) {
> > -		bool same_page;
> > -
> >  		page = thp_head(page);
> >  		same_page = lend < page_offset(page) + thp_size(page);
> > -		if (same_page)
> > -			partial_end = false;
> 
> I don't object to this patch at all, at least partly because it's shorter
> and simpler!  I don't understand what it's solving, though.  The case
> where there's a THP which covers partial_end is supposed to be handled
> by the three lines above.

I'm glad to hear it's not obvious to you,
I was ashamed of how long it took me to see.  The initial
	partial_end = ((lend + 1) % PAGE_SIZE) > 0;
left partial_end false if the end is nicely PAGE_SIZE aligned.

If the lstart shmem_getpage() finds a page, THP or small,
and the lend is covered by the same page, all is well.  But if 
the lend is covered by a THP, PAGE_SIZE aligned but not page_size()
aligned (forgive my eliding off-by-ones wrt lend), then partial_end
remains false, so there's no shmem_getpage() of the end, no discovery
that it's a THP, and no attempt to split it as intended.

I think then "end" goes forward unadjusted, and that whole ending THP
will be truncated out: when it should have been split, and only its
first pages removed.  Hence zeroes appearing where they should not.

> 
> > Fix to [PATCH v4 15/16] mm/truncate,shmem: Handle truncates that split THPs.
> > xfstests generic/012 on huge tmpfs hit this every time (when checking
> > xfs_io commands available: later decides "not run" because no "fiemap").
> > I grabbed this line unthinkingly from one of your later series, it fixes
> > the crash; but once I actually thought about it when trying to track down
> > weirder behaviours, realize that the kmap_atomic() and flush_dcache_page()
> > in zero_user_segments() are not prepared for a THP - so highmem and
> > flush_dcache_page architectures will be disappointed. If I searched
> > through your other series, I might find the complete fix; or perhaps
> > it's already there in linux-next, I haven't looked.
> 
> zero_user_segments() is fixed by "mm: Support THPs in zero_user_segments".
> I think most recently posted here:
> https://lore.kernel.org/linux-mm/20201026183136.10404-2-willy@infradead.org/
> 
> My fault for not realising this patch depended on that patch.  I did
> test these patches stand-alone, but it didn't trigger this problem.
> 
> flush_dcache_page() needs to be called once for each sub-page.  We
> really need a flush_dcache_thp() so that architectures can optimise this.

Right.

> Although maybe now that's going to be called flush_dcache_folio().

Yes, I was delighted to notice the return of "folio":
https://lore.kernel.org/linux-mm/Pine.LNX.4.21.0107051737340.1577-100000@localhost.localdomain/

> 
> > I also had noise from the WARN_ON(page_to_index(page) != index)
> > in invalidate_inode_pages2_range(): but that's my problem, since
> > for testing I add a dummy shmem_direct_IO() (return 0): for that
> > I've now added a shmem_mapping() check at the head of pages2_range().
> 
> Ah, I have a later fix for invalidate_inode_pages2_range():
> https://lore.kernel.org/linux-mm/20201026183136.10404-6-willy@infradead.org/
> 
> I didn't post it earlier because there aren't any filesystems currently
> which use THPs and directIO ;-)

Yes, I'd seen your exchange with Jan about that.  And initially I ported
in your later fix; but later decided it was better to decouple my testing
mods from whatever is decided in your series.  If tmpfs does (pretend to)
support directIO, it is correct that invalidate_inode_pages2_range() do
nothing on it: because the pretended IO is to and from the tmpfs backing
store, which is the page cache.

> 
> > That's all for now: I'll fire off more overnight testing.
> 
> Thanks!

All running fine.

Hugh
