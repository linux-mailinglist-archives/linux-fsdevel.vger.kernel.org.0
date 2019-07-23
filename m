Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8974771AA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 16:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390591AbfGWOnW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jul 2019 10:43:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43835 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388075AbfGWOnW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jul 2019 10:43:22 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so13716585pld.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jul 2019 07:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CXJioUohNIJ0NhODmyNgtJL+ymWSK/aS70/EguesA7s=;
        b=Tv4nwW9qgJhM1gi/kpZBvJdAFTNRF7o+uiQbdbJA+CEkh0nwv//1WqBl78VW2pztXN
         6XH3F1oxedjEAfMghwEzZjJalzPyL21+Q3og8Z7lcMpWDls0IhHhwkgjSmZD2Nu0h0gQ
         7qNXpRxPi4soMPYIewpFbmfSmFU3zNV61f93I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CXJioUohNIJ0NhODmyNgtJL+ymWSK/aS70/EguesA7s=;
        b=Mt5GzI+h7LtFMbJ1mH0iXp9Gm4Zx5Zzmdh65vV5P32tLaqTVfARp5k2e6b5RwuANk9
         GJ01/1CM+pWUkbBwOpwz3wWP2d6Hq8tLNV9j+UyzmKkVJcrfMp39+3EwX7q+fxMo5WGt
         ZJ9NQcOMAuxmz6OyDnodqefqksDCnGfqZi73kgYH3ie78oO+KqMuQs4NdOwmWCwvj54+
         OE1XuBac0ObRyJUI1AIFLFQN7tfFjKa6wxwRQQaHvzjYRttvWKLDtbs4md319JFX1P+N
         0FSgUtY5pWKhnPKEc4WIxud1v3pfmtbHCvRj8olV1zMeB6xY+On6bO1f1DPLNmahH4wR
         VI2g==
X-Gm-Message-State: APjAAAUhDVxteGRo96O6YGlcYUCxFEpHaq6ah6PVDE4vDcWGANaOAhO/
        63yawOEJZPzdHDxkMT4Df20=
X-Google-Smtp-Source: APXvYqxq0XgaN2rBscmyFhGxyiLm9xRaeQ7cSnaC3QUCLqtyr5vXEKfMewiKHzKVKUeilH0kxvA+mw==
X-Received: by 2002:a17:902:9a95:: with SMTP id w21mr23521616plp.126.1563893001022;
        Tue, 23 Jul 2019 07:43:21 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 2sm74645858pgm.39.2019.07.23.07.43.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 07:43:20 -0700 (PDT)
Date:   Tue, 23 Jul 2019 10:43:18 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, vdavydov.dev@gmail.com,
        Brendan Gregg <bgregg@netflix.com>, kernel-team@android.com,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, carmenjackson@google.com,
        Christian Hansen <chansen3@cisco.com>,
        Colin Ian King <colin.king@canonical.com>, dancol@google.com,
        David Howells <dhowells@redhat.com>, fmayer@google.com,
        joaodias@google.com, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>, minchan@google.com,
        minchan@kernel.org, namhyung@google.com, sspatil@google.com,
        surenb@google.com, Thomas Gleixner <tglx@linutronix.de>,
        timmurray@google.com, tkjos@google.com,
        Vlastimil Babka <vbabka@suse.cz>, wvw@google.com
Subject: Re: [PATCH v1 1/2] mm/page_idle: Add support for per-pid page_idle
 using virtual indexing
Message-ID: <20190723144318.GF104199@google.com>
References: <20190722213205.140845-1-joel@joelfernandes.org>
 <20190722150639.27641c63b003dd04e187fd96@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722150639.27641c63b003dd04e187fd96@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 22, 2019 at 03:06:39PM -0700, Andrew Morton wrote:
> On Mon, 22 Jul 2019 17:32:04 -0400 "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> 
> > The page_idle tracking feature currently requires looking up the pagemap
> > for a process followed by interacting with /sys/kernel/mm/page_idle.
> > This is quite cumbersome and can be error-prone too. If between
> > accessing the per-PID pagemap and the global page_idle bitmap, if
> > something changes with the page then the information is not accurate.
> 
> Well, it's never going to be "accurate" - something could change one
> nanosecond after userspace has read the data...
> 
> Presumably with this approach the data will be "more" accurate.  How
> big a problem has this inaccuracy proven to be in real-world usage?

Has proven to be quite a thorn. But the security issue is the main problem..

> > More over looking up PFN from pagemap in Android devices is not
> > supported by unprivileged process and requires SYS_ADMIN and gives 0 for
> > the PFN.

..as mentioned here.

I should have emphasized on the security issue more, will do so in the next
revision.

> > This patch adds support to directly interact with page_idle tracking at
> > the PID level by introducing a /proc/<pid>/page_idle file. This
> > eliminates the need for userspace to calculate the mapping of the page.
> > It follows the exact same semantics as the global
> > /sys/kernel/mm/page_idle, however it is easier to use for some usecases
> > where looking up PFN is not needed and also does not require SYS_ADMIN.
> > It ended up simplifying userspace code, solving the security issue
> > mentioned and works quite well. SELinux does not need to be turned off
> > since no pagemap look up is needed.
> > 
> > In Android, we are using this for the heap profiler (heapprofd) which
> > profiles and pin points code paths which allocates and leaves memory
> > idle for long periods of time.
> > 
> > Documentation material:
> > The idle page tracking API for virtual address indexing using virtual page
> > frame numbers (VFN) is located at /proc/<pid>/page_idle. It is a bitmap
> > that follows the same semantics as /sys/kernel/mm/page_idle/bitmap
> > except that it uses virtual instead of physical frame numbers.
> > 
> > This idle page tracking API can be simpler to use than physical address
> > indexing, since the pagemap for a process does not need to be looked up
> > to mark or read a page's idle bit. It is also more accurate than
> > physical address indexing since in physical address indexing, address
> > space changes can occur between reading the pagemap and reading the
> > bitmap. In virtual address indexing, the process's mmap_sem is held for
> > the duration of the access.
> > 
> > ...
> >
> > --- a/mm/page_idle.c
> > +++ b/mm/page_idle.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/mmu_notifier.h>
> >  #include <linux/page_ext.h>
> >  #include <linux/page_idle.h>
> > +#include <linux/sched/mm.h>
> >  
> >  #define BITMAP_CHUNK_SIZE	sizeof(u64)
> >  #define BITMAP_CHUNK_BITS	(BITMAP_CHUNK_SIZE * BITS_PER_BYTE)
> > @@ -28,15 +29,12 @@
> >   *
> >   * This function tries to get a user memory page by pfn as described above.
> >   */
> 
> Above comment needs updating or moving?
> 
> > -static struct page *page_idle_get_page(unsigned long pfn)
> > +static struct page *page_idle_get_page(struct page *page_in)
> >  {
> >  	struct page *page;
> >  	pg_data_t *pgdat;
> >  
> > -	if (!pfn_valid(pfn))
> > -		return NULL;
> > -
> > -	page = pfn_to_page(pfn);
> > +	page = page_in;
> >  	if (!page || !PageLRU(page) ||
> >  	    !get_page_unless_zero(page))
> >  		return NULL;
> >
> > ...
> >
> > +static int page_idle_get_frames(loff_t pos, size_t count, struct mm_struct *mm,
> > +				unsigned long *start, unsigned long *end)
> > +{
> > +	unsigned long max_frame;
> > +
> > +	/* If an mm is not given, assume we want physical frames */
> > +	max_frame = mm ? (mm->task_size >> PAGE_SHIFT) : max_pfn;
> > +
> > +	if (pos % BITMAP_CHUNK_SIZE || count % BITMAP_CHUNK_SIZE)
> > +		return -EINVAL;
> > +
> > +	*start = pos * BITS_PER_BYTE;
> > +	if (*start >= max_frame)
> > +		return -ENXIO;
> 
> Is said to mean "The system tried to use the device represented by a
> file you specified, and it couldnt find the device.  This can mean that
> the device file was installed incorrectly, or that the physical device
> is missing or not correctly attached to the computer."
> 
> This doesn't seem appropriate in this usage and is hence possibly
> misleading.  Someone whose application fails with ENXIO will be
> scratching their heads.

This actually keeps it consistent with the current code. I refactored that
code a bit and I'm reusing parts of it to keep lines of code less. See
page_idle_bitmap_write where it returns -ENXIO in current upstream.

However note that I am actually returning 0 if page_idle_bitmap_write()
returns -ENXIO:

+	ret = page_idle_get_frames(pos, count, NULL, &pfn, &end_pfn);
+	if (ret == -ENXIO)
+		return 0;  /* Reads beyond max_pfn do nothing */

The reason I do it this way is, I am using page_idle_get_frames() in the old
code and the new code, a bit confusing I know! But it is the cleanest way I
could find to keep this code common.

> > +	*end = *start + count * BITS_PER_BYTE;
> > +	if (*end > max_frame)
> > +		*end = max_frame;
> > +	return 0;
> > +}
> > +
> >
> > ...
> >
> > +static void add_page_idle_list(struct page *page,
> > +			       unsigned long addr, struct mm_walk *walk)
> > +{
> > +	struct page *page_get;
> > +	struct page_node *pn;
> > +	int bit;
> > +	unsigned long frames;
> > +	struct page_idle_proc_priv *priv = walk->private;
> > +	u64 *chunk = (u64 *)priv->buffer;
> > +
> > +	if (priv->write) {
> > +		/* Find whether this page was asked to be marked */
> > +		frames = (addr - priv->start_addr) >> PAGE_SHIFT;
> > +		bit = frames % BITMAP_CHUNK_BITS;
> > +		chunk = &chunk[frames / BITMAP_CHUNK_BITS];
> > +		if (((*chunk >> bit) & 1) == 0)
> > +			return;
> > +	}
> > +
> > +	page_get = page_idle_get_page(page);
> > +	if (!page_get)
> > +		return;
> > +
> > +	pn = kmalloc(sizeof(*pn), GFP_ATOMIC);
> 
> I'm not liking this GFP_ATOMIC.  If I'm reading the code correctly,
> userspace can ask for an arbitrarily large number of GFP_ATOMIC
> allocations by doing a large read.  This can potentially exhaust page
> reserves which things like networking Rx interrupts need and can make
> this whole feature less reliable.

Ok, I will look into this more and possibly do the allocation another way.
spinlocks are held hence I use GFP_ATOMIC..

thanks,

 - Joel

