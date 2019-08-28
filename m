Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1A79FC78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 10:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfH1IAL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 04:00:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:43356 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726658AbfH1IAK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:00:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6891BAD79;
        Wed, 28 Aug 2019 08:00:07 +0000 (UTC)
Date:   Wed, 28 Aug 2019 10:00:06 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Waiman Long <longman@redhat.com>,
        Dan Williams <dan.j.williams@gmail.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] fs/proc/page: Skip uninitialized page when iterating
 page structures
Message-ID: <20190828080006.GG7386@dhcp22.suse.cz>
References: <20190826124336.8742-1-longman@redhat.com>
 <20190827142238.GB10223@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827142238.GB10223@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 27-08-19 16:22:38, Michal Hocko wrote:
> Dan, isn't this something we have discussed recently?

This was http://lkml.kernel.org/r/20190725023100.31141-3-t-fukasawa@vx.jp.nec.com
and talked about /proc/kpageflags but this is essentially the same thing
AFAIU. I hope we get a consistent solution for both issues.

> On Mon 26-08-19 08:43:36, Waiman Long wrote:
> > It was found that on a dual-socket x86-64 system with nvdimm, reading
> > /proc/kpagecount may cause the system to panic:
> > 
> > ===================
> > [   79.917682] BUG: unable to handle page fault for address: fffffffffffffffe
> > [   79.924558] #PF: supervisor read access in kernel mode
> > [   79.929696] #PF: error_code(0x0000) - not-present page
> > [   79.934834] PGD 87b60d067 P4D 87b60d067 PUD 87b60f067 PMD 0
> > [   79.940494] Oops: 0000 [#1] SMP NOPTI
> > [   79.944157] CPU: 89 PID: 3455 Comm: cp Not tainted 5.3.0-rc5-test+ #14
> > [   79.950682] Hardware name: Dell Inc. PowerEdge R740/07X9K0, BIOS 2.2.11 06/13/2019
> > [   79.958246] RIP: 0010:kpagecount_read+0xdb/0x1a0
> > [   79.962859] Code: e8 09 83 e0 3f 48 0f a3 02 73 2d 4c 89 f7 48 c1 e7 06 48 03 3d fe da de 00 74 1d 48 8b 57 08 48 8d 42 ff 83 e2 01 48 0f 44 c7 <48> 8b 00 f6 c4 02 75 06 83 7f 30 80 7d 62 31 c0 4c 89 f9 e8 5d c9
> > [   79.981603] RSP: 0018:ffffb0d9c950fe70 EFLAGS: 00010202
> > [   79.986830] RAX: fffffffffffffffe RBX: ffff8beebe5383c0 RCX: ffffb0d9c950ff00
> > [   79.993963] RDX: 0000000000000001 RSI: 00007fd85b29e000 RDI: ffffe77a22000000
> > [   80.001095] RBP: 0000000000020000 R08: 0000000000000001 R09: 0000000000000000
> > [   80.008226] R10: 0000000000000000 R11: 0000000000000001 R12: 00007fd85b29e000
> > [   80.015358] R13: ffffffff893f0480 R14: 0000000000880000 R15: 00007fd85b29e000
> > [   80.022491] FS:  00007fd85b312800(0000) GS:ffff8c359fb00000(0000) knlGS:0000000000000000
> > [   80.030576] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   80.036321] CR2: fffffffffffffffe CR3: 0000004f54a38001 CR4: 00000000007606e0
> > [   80.043455] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [   80.050586] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [   80.057718] PKRU: 55555554
> > [   80.060428] Call Trace:
> > [   80.062877]  proc_reg_read+0x39/0x60
> > [   80.066459]  vfs_read+0x91/0x140
> > [   80.069686]  ksys_read+0x59/0xd0
> > [   80.072922]  do_syscall_64+0x59/0x1e0
> > [   80.076588]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [   80.081637] RIP: 0033:0x7fd85a7f5d75
> > ===================
> > 
> > It turns out the panic was caused by the kpagecount_read() function
> > hitting an uninitialized page structure at PFN 0x880000 where all its
> > fields were set to -1. The compound_head value of -1 will mislead the
> > kernel to treat -2 as a pointer to the head page of the compound page
> > leading to the crash.
> > 
> > The system have 12 GB of nvdimm ranging from PFN 0x880000-0xb7ffff.
> > However, only PFN 0x88c200-0xb7ffff are released by the nvdimm
> > driver to the kernel and initialized. IOW, PFN 0x880000-0x88c1ff
> > remain uninitialized. Perhaps these 196 MB of nvdimm are reserved for
> > internal use.
> > 
> > To fix the panic, we need to find out if a page structure has been
> > initialized. This is done now by checking if the PFN is in the range
> > of a memory zone assuming that pages in a zone is either correctly
> > marked as not present in the mem_section structure or have their page
> > structures initialized.
> > 
> > Signed-off-by: Waiman Long <longman@redhat.com>
> > ---
> >  fs/proc/page.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 65 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/proc/page.c b/fs/proc/page.c
> > index 544d1ee15aee..fee55ad95893 100644
> > --- a/fs/proc/page.c
> > +++ b/fs/proc/page.c
> > @@ -21,6 +21,64 @@
> >  #define KPMMASK (KPMSIZE - 1)
> >  #define KPMBITS (KPMSIZE * BITS_PER_BYTE)
> >  
> > +/*
> > + * It is possible a page structure is contained in a mem_section that is
> > + * regarded as valid but the page structure itself is not properly
> > + * initialized. For example, portion of the device memory may be used
> > + * internally by device driver or firmware without being managed by the
> > + * kernel and hence their page structures may not be initialized.
> > + *
> > + * An uninitialized page structure may cause the PFN iteration code
> > + * in this file to panic the system. To safe-guard against this
> > + * possibility, an additional check of the PFN is done to make sure
> > + * that it is in a valid range in one of the memory zones:
> > + *
> > + *	[zone_start_pfn, zone_start_pfn + spanned_pages)
> > + *
> > + * It is possible that some of the PFNs within a zone is not present.
> > + * In this case, it will have to rely on the current mem_section check
> > + * as well as the affected page structures are still properly initialized.
> > + */
> > +struct zone_range {
> > +	unsigned long pfn_start;
> > +	unsigned long pfn_end;
> > +};
> > +
> > +static void find_next_zone_range(struct zone_range *range)
> > +{
> > +	unsigned long start, end;
> > +	pg_data_t *pgdat;
> > +	struct zone *zone;
> > +	int i;
> > +
> > +	/*
> > +	 * Scan all the zone structures to find the next closest one.
> > +	 */
> > +	start = end = -1UL;
> > +	for (pgdat = first_online_pgdat(); pgdat;
> > +	     pgdat = next_online_pgdat(pgdat)) {
> > +		for (zone = pgdat->node_zones, i = 0; i < MAX_NR_ZONES;
> > +		     zone++, i++) {
> > +			if (!zone->spanned_pages)
> > +				continue;
> > +			if ((zone->zone_start_pfn >= range->pfn_end) &&
> > +			    (zone->zone_start_pfn < start)) {
> > +				start = zone->zone_start_pfn;
> > +				end   = start + zone->spanned_pages;
> > +			}
> > +		}
> > +	}
> > +	range->pfn_start = start;
> > +	range->pfn_end   = end;
> > +}
> > +
> > +static inline bool pfn_in_zone(unsigned long pfn, struct zone_range *range)
> > +{
> > +	if (pfn >= range->pfn_end)
> > +		find_next_zone_range(range);
> > +	return pfn >= range->pfn_start && pfn < range->pfn_end;
> > +}
> > +
> >  /* /proc/kpagecount - an array exposing page counts
> >   *
> >   * Each entry is a u64 representing the corresponding
> > @@ -31,6 +89,7 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
> >  {
> >  	u64 __user *out = (u64 __user *)buf;
> >  	struct page *ppage;
> > +	struct zone_range range = { 0, 0 };
> >  	unsigned long src = *ppos;
> >  	unsigned long pfn;
> >  	ssize_t ret = 0;
> > @@ -42,10 +101,11 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
> >  		return -EINVAL;
> >  
> >  	while (count > 0) {
> > -		if (pfn_valid(pfn))
> > +		if (pfn_valid(pfn) && pfn_in_zone(pfn, &range))
> >  			ppage = pfn_to_page(pfn);
> >  		else
> >  			ppage = NULL;
> > +
> >  		if (!ppage || PageSlab(ppage) || page_has_type(ppage))
> >  			pcount = 0;
> >  		else
> > @@ -206,6 +266,7 @@ static ssize_t kpageflags_read(struct file *file, char __user *buf,
> >  {
> >  	u64 __user *out = (u64 __user *)buf;
> >  	struct page *ppage;
> > +	struct zone_range range = { 0, 0 };
> >  	unsigned long src = *ppos;
> >  	unsigned long pfn;
> >  	ssize_t ret = 0;
> > @@ -216,7 +277,7 @@ static ssize_t kpageflags_read(struct file *file, char __user *buf,
> >  		return -EINVAL;
> >  
> >  	while (count > 0) {
> > -		if (pfn_valid(pfn))
> > +		if (pfn_valid(pfn) && pfn_in_zone(pfn, &range))
> >  			ppage = pfn_to_page(pfn);
> >  		else
> >  			ppage = NULL;
> > @@ -250,6 +311,7 @@ static ssize_t kpagecgroup_read(struct file *file, char __user *buf,
> >  {
> >  	u64 __user *out = (u64 __user *)buf;
> >  	struct page *ppage;
> > +	struct zone_range range = { 0, 0 };
> >  	unsigned long src = *ppos;
> >  	unsigned long pfn;
> >  	ssize_t ret = 0;
> > @@ -261,7 +323,7 @@ static ssize_t kpagecgroup_read(struct file *file, char __user *buf,
> >  		return -EINVAL;
> >  
> >  	while (count > 0) {
> > -		if (pfn_valid(pfn))
> > +		if (pfn_valid(pfn) && pfn_in_zone(pfn, &range))
> >  			ppage = pfn_to_page(pfn);
> >  		else
> >  			ppage = NULL;
> > -- 
> > 2.18.1
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Michal Hocko
SUSE Labs
