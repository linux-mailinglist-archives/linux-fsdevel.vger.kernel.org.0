Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8087771A24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 16:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388082AbfGWOUx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jul 2019 10:20:53 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37960 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388080AbfGWOUx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jul 2019 10:20:53 -0400
Received: by mail-pl1-f196.google.com with SMTP id az7so20661862plb.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jul 2019 07:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ydaFxZZNC8YD2F3MtHEn/FIPg0XqwS6OYm0MQprhJzI=;
        b=ZRXvD9ZlkO1oLYooCbR7DdQE2NjVHOE+XDJ4QCsoiCYkvUsbsKDoqU+3y2vWQ/nv+u
         PZUT1nfV378ts13ih9A4kOosbVFROS/+TRHuMykExNGQkyvicSttqdZ47r4I9qRsctnL
         Wb1FKVwatMMb7WHHFI7xVb7RwRRJPo+SR+Ot8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ydaFxZZNC8YD2F3MtHEn/FIPg0XqwS6OYm0MQprhJzI=;
        b=LAJYy8KFGiE9fIfL0JwewZFKmF8gFHuz/Donpr/B5B/F2xzYtDLfMyE+MRGe+4c7G7
         zNvpQtuaxNvPxckgo9SZaSm4AxwYpAP3CRAH9V0GjnnYnOiqOxYqdk+8uQ7PNZ3PZ8EM
         KE/TQJOnlDwGCuqF5uml6ns8b0xSsqKq2RG5BjiorGiRyJ3WjLAUBegNstQOKfVeCNfM
         qPvijTFor4c3Gk1NWca8i7LLL182J+vLT9t6+RuNE/VTCEckJya0rJahWN05jyzOkUW/
         NJQqKxKh2HFhNHR2LeS5aKVuOm1+s+vYgAYghPmtqMzIDLcG2L8PHbEIEvq4j+ySxTxm
         hloA==
X-Gm-Message-State: APjAAAXZtSIob2NyBB+64xUPkuMaRepJcsj+jFNDFLvAFTtxI3mPVxq0
        vF0zPRc7nFqjIq8WAX1WEYU=
X-Google-Smtp-Source: APXvYqwsY76bRDXBZsD0rs4v1xdknsCgNNjuct5Kp0HdlQkIfJiJI6JB+YNGrJsgNFc9uaI/Gjj9rA==
X-Received: by 2002:a17:902:290b:: with SMTP id g11mr79392974plb.26.1563891652125;
        Tue, 23 Jul 2019 07:20:52 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id f14sm42875797pfn.53.2019.07.23.07.20.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 07:20:51 -0700 (PDT)
Date:   Tue, 23 Jul 2019 10:20:49 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, vdavydov.dev@gmail.com,
        Brendan Gregg <bgregg@netflix.com>, kernel-team@android.com,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        carmenjackson@google.com, Christian Hansen <chansen3@cisco.com>,
        Colin Ian King <colin.king@canonical.com>, dancol@google.com,
        David Howells <dhowells@redhat.com>, fmayer@google.com,
        joaodias@google.com, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>, namhyung@google.com,
        sspatil@google.com, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, timmurray@google.com,
        tkjos@google.com, Vlastimil Babka <vbabka@suse.cz>, wvw@google.com
Subject: Re: [PATCH v1 1/2] mm/page_idle: Add support for per-pid page_idle
 using virtual indexing
Message-ID: <20190723142049.GC104199@google.com>
References: <20190722213205.140845-1-joel@joelfernandes.org>
 <20190723061358.GD128252@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723061358.GD128252@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 23, 2019 at 03:13:58PM +0900, Minchan Kim wrote:
> Hi Joel,
> 
> On Mon, Jul 22, 2019 at 05:32:04PM -0400, Joel Fernandes (Google) wrote:
> > The page_idle tracking feature currently requires looking up the pagemap
> > for a process followed by interacting with /sys/kernel/mm/page_idle.
> > This is quite cumbersome and can be error-prone too. If between
> 
> cumbersome: That's the fair tradeoff between idle page tracking and
> clear_refs because idle page tracking could check even though the page
> is not mapped.

It is fair tradeoff, but could be made simpler. The userspace code got
reduced by a good amount as well.

> error-prone: What's the error?

We see in normal Android usage, that some of the times pages appear not to be
idle even when they really are idle. Reproducing this is a bit unpredictable
and happens at random occasions. With this new interface, we are seeing this
happen much much lesser.

> > accessing the per-PID pagemap and the global page_idle bitmap, if
> > something changes with the page then the information is not accurate.
> 
> What you mean with error is this timing issue?
> Why do you need to be accurate? IOW, accurate is always good but what's
> the scale of the accuracy?

There is a time window between looking up pagemap and checking if page is
idle. Anyway, see below for the primary goals as you asked:

> > More over looking up PFN from pagemap in Android devices is not
> > supported by unprivileged process and requires SYS_ADMIN and gives 0 for
> > the PFN.
> > 
> > This patch adds support to directly interact with page_idle tracking at
> > the PID level by introducing a /proc/<pid>/page_idle file. This
> > eliminates the need for userspace to calculate the mapping of the page.
> > It follows the exact same semantics as the global
> > /sys/kernel/mm/page_idle, however it is easier to use for some usecases
> > where looking up PFN is not needed and also does not require SYS_ADMIN.
> 
> Ah, so the primary goal is to provide convinience interface and it would
> help accurary, too. IOW, accuracy is not your main goal?

There are a couple of primary goals: Security, conveience and also solving
the accuracy/reliability problem we are seeing. Do keep in mind looking up
PFN has security implications. The PFN field in pagemap is zeroed if the user
does not have CAP_SYS_ADMIN.

> > In Android, we are using this for the heap profiler (heapprofd) which
> > profiles and pin points code paths which allocates and leaves memory
> > idle for long periods of time.
> 
> So the goal is to detect idle pages with idle memory tracking?

Isn't that what idle memory tracking does?

> It couldn't work well because such idle pages could finally swap out and
> lose every flags of the page descriptor which is working mechanism of
> idle page tracking. It should have named "workingset page tracking",
> not "idle page tracking".

The heap profiler that uses page-idle tracking is not to measure working set,
but to look for pages that are idle for long periods of time.

Thanks for bringing up the swapping corner case..  Perhaps we can improve
the heap profiler to detect this by looking at bits 0-4 in pagemap. While it
is true that we would lose access information during the window, there is a
high likelihood that the page was not accessed which is why it was swapped.
Thoughts?

thanks,

 - Joel



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
> > Cc: vdavydov.dev@gmail.com
> > Cc: Brendan Gregg <bgregg@netflix.com>
> > Cc: kernel-team@android.com
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > ---
> > Internal review -> v1:
> > Fixes from Suren.
> > Corrections to change log, docs (Florian, Sandeep)
> > 
> >  fs/proc/base.c            |   3 +
> >  fs/proc/internal.h        |   1 +
> >  fs/proc/task_mmu.c        |  57 +++++++
> >  include/linux/page_idle.h |   4 +
> >  mm/page_idle.c            | 305 +++++++++++++++++++++++++++++++++-----
> >  5 files changed, 330 insertions(+), 40 deletions(-)
> > 
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index 77eb628ecc7f..a58dd74606e9 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -3021,6 +3021,9 @@ static const struct pid_entry tgid_base_stuff[] = {
> >  	REG("smaps",      S_IRUGO, proc_pid_smaps_operations),
> >  	REG("smaps_rollup", S_IRUGO, proc_pid_smaps_rollup_operations),
> >  	REG("pagemap",    S_IRUSR, proc_pagemap_operations),
> > +#ifdef CONFIG_IDLE_PAGE_TRACKING
> > +	REG("page_idle", S_IRUSR|S_IWUSR, proc_page_idle_operations),
> > +#endif
> >  #endif
> >  #ifdef CONFIG_SECURITY
> >  	DIR("attr",       S_IRUGO|S_IXUGO, proc_attr_dir_inode_operations, proc_attr_dir_operations),
> > diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> > index cd0c8d5ce9a1..bc9371880c63 100644
> > --- a/fs/proc/internal.h
> > +++ b/fs/proc/internal.h
> > @@ -293,6 +293,7 @@ extern const struct file_operations proc_pid_smaps_operations;
> >  extern const struct file_operations proc_pid_smaps_rollup_operations;
> >  extern const struct file_operations proc_clear_refs_operations;
> >  extern const struct file_operations proc_pagemap_operations;
> > +extern const struct file_operations proc_page_idle_operations;
> >  
> >  extern unsigned long task_vsize(struct mm_struct *);
> >  extern unsigned long task_statm(struct mm_struct *,
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 4d2b860dbc3f..11ccc53da38e 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -1642,6 +1642,63 @@ const struct file_operations proc_pagemap_operations = {
> >  	.open		= pagemap_open,
> >  	.release	= pagemap_release,
> >  };
> > +
> > +#ifdef CONFIG_IDLE_PAGE_TRACKING
> > +static ssize_t proc_page_idle_read(struct file *file, char __user *buf,
> > +				   size_t count, loff_t *ppos)
> > +{
> > +	int ret;
> > +	struct task_struct *tsk = get_proc_task(file_inode(file));
> > +
> > +	if (!tsk)
> > +		return -EINVAL;
> > +	ret = page_idle_proc_read(file, buf, count, ppos, tsk);
> > +	put_task_struct(tsk);
> > +	return ret;
> > +}
> > +
> > +static ssize_t proc_page_idle_write(struct file *file, const char __user *buf,
> > +				 size_t count, loff_t *ppos)
> > +{
> > +	int ret;
> > +	struct task_struct *tsk = get_proc_task(file_inode(file));
> > +
> > +	if (!tsk)
> > +		return -EINVAL;
> > +	ret = page_idle_proc_write(file, (char __user *)buf, count, ppos, tsk);
> > +	put_task_struct(tsk);
> > +	return ret;
> > +}
> > +
> > +static int proc_page_idle_open(struct inode *inode, struct file *file)
> > +{
> > +	struct mm_struct *mm;
> > +
> > +	mm = proc_mem_open(inode, PTRACE_MODE_READ);
> > +	if (IS_ERR(mm))
> > +		return PTR_ERR(mm);
> > +	file->private_data = mm;
> > +	return 0;
> > +}
> > +
> > +static int proc_page_idle_release(struct inode *inode, struct file *file)
> > +{
> > +	struct mm_struct *mm = file->private_data;
> > +
> > +	if (mm)
> > +		mmdrop(mm);
> > +	return 0;
> > +}
> > +
> > +const struct file_operations proc_page_idle_operations = {
> > +	.llseek		= mem_lseek, /* borrow this */
> > +	.read		= proc_page_idle_read,
> > +	.write		= proc_page_idle_write,
> > +	.open		= proc_page_idle_open,
> > +	.release	= proc_page_idle_release,
> > +};
> > +#endif /* CONFIG_IDLE_PAGE_TRACKING */
> > +
> >  #endif /* CONFIG_PROC_PAGE_MONITOR */
> >  
> >  #ifdef CONFIG_NUMA
> > diff --git a/include/linux/page_idle.h b/include/linux/page_idle.h
> > index 1e894d34bdce..f1bc2640d85e 100644
> > --- a/include/linux/page_idle.h
> > +++ b/include/linux/page_idle.h
> > @@ -106,6 +106,10 @@ static inline void clear_page_idle(struct page *page)
> >  }
> >  #endif /* CONFIG_64BIT */
> >  
> > +ssize_t page_idle_proc_write(struct file *file,
> > +	char __user *buf, size_t count, loff_t *ppos, struct task_struct *tsk);
> > +ssize_t page_idle_proc_read(struct file *file,
> > +	char __user *buf, size_t count, loff_t *ppos, struct task_struct *tsk);
> >  #else /* !CONFIG_IDLE_PAGE_TRACKING */
> >  
> >  static inline bool page_is_young(struct page *page)
> > diff --git a/mm/page_idle.c b/mm/page_idle.c
> > index 295512465065..874a60c41fef 100644
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
> > @@ -51,6 +49,15 @@ static struct page *page_idle_get_page(unsigned long pfn)
> >  	return page;
> >  }
> >  
> > +static struct page *page_idle_get_page_pfn(unsigned long pfn)
> > +{
> > +
> > +	if (!pfn_valid(pfn))
> > +		return NULL;
> > +
> > +	return page_idle_get_page(pfn_to_page(pfn));
> > +}
> > +
> >  static bool page_idle_clear_pte_refs_one(struct page *page,
> >  					struct vm_area_struct *vma,
> >  					unsigned long addr, void *arg)
> > @@ -118,6 +125,47 @@ static void page_idle_clear_pte_refs(struct page *page)
> >  		unlock_page(page);
> >  }
> >  
> > +/* Helper to get the start and end frame given a pos and count */
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
> > +
> > +	*end = *start + count * BITS_PER_BYTE;
> > +	if (*end > max_frame)
> > +		*end = max_frame;
> > +	return 0;
> > +}
> > +
> > +static bool page_really_idle(struct page *page)
> > +{
> > +	if (!page)
> > +		return false;
> > +
> > +	if (page_is_idle(page)) {
> > +		/*
> > +		 * The page might have been referenced via a
> > +		 * pte, in which case it is not idle. Clear
> > +		 * refs and recheck.
> > +		 */
> > +		page_idle_clear_pte_refs(page);
> > +		if (page_is_idle(page))
> > +			return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> >  static ssize_t page_idle_bitmap_read(struct file *file, struct kobject *kobj,
> >  				     struct bin_attribute *attr, char *buf,
> >  				     loff_t pos, size_t count)
> > @@ -125,35 +173,21 @@ static ssize_t page_idle_bitmap_read(struct file *file, struct kobject *kobj,
> >  	u64 *out = (u64 *)buf;
> >  	struct page *page;
> >  	unsigned long pfn, end_pfn;
> > -	int bit;
> > -
> > -	if (pos % BITMAP_CHUNK_SIZE || count % BITMAP_CHUNK_SIZE)
> > -		return -EINVAL;
> > -
> > -	pfn = pos * BITS_PER_BYTE;
> > -	if (pfn >= max_pfn)
> > -		return 0;
> > +	int bit, ret;
> >  
> > -	end_pfn = pfn + count * BITS_PER_BYTE;
> > -	if (end_pfn > max_pfn)
> > -		end_pfn = max_pfn;
> > +	ret = page_idle_get_frames(pos, count, NULL, &pfn, &end_pfn);
> > +	if (ret == -ENXIO)
> > +		return 0;  /* Reads beyond max_pfn do nothing */
> > +	else if (ret)
> > +		return ret;
> >  
> >  	for (; pfn < end_pfn; pfn++) {
> >  		bit = pfn % BITMAP_CHUNK_BITS;
> >  		if (!bit)
> >  			*out = 0ULL;
> > -		page = page_idle_get_page(pfn);
> > -		if (page) {
> > -			if (page_is_idle(page)) {
> > -				/*
> > -				 * The page might have been referenced via a
> > -				 * pte, in which case it is not idle. Clear
> > -				 * refs and recheck.
> > -				 */
> > -				page_idle_clear_pte_refs(page);
> > -				if (page_is_idle(page))
> > -					*out |= 1ULL << bit;
> > -			}
> > +		page = page_idle_get_page_pfn(pfn);
> > +		if (page && page_really_idle(page)) {
> > +			*out |= 1ULL << bit;
> >  			put_page(page);
> >  		}
> >  		if (bit == BITMAP_CHUNK_BITS - 1)
> > @@ -170,23 +204,16 @@ static ssize_t page_idle_bitmap_write(struct file *file, struct kobject *kobj,
> >  	const u64 *in = (u64 *)buf;
> >  	struct page *page;
> >  	unsigned long pfn, end_pfn;
> > -	int bit;
> > +	int bit, ret;
> >  
> > -	if (pos % BITMAP_CHUNK_SIZE || count % BITMAP_CHUNK_SIZE)
> > -		return -EINVAL;
> > -
> > -	pfn = pos * BITS_PER_BYTE;
> > -	if (pfn >= max_pfn)
> > -		return -ENXIO;
> > -
> > -	end_pfn = pfn + count * BITS_PER_BYTE;
> > -	if (end_pfn > max_pfn)
> > -		end_pfn = max_pfn;
> > +	ret = page_idle_get_frames(pos, count, NULL, &pfn, &end_pfn);
> > +	if (ret)
> > +		return ret;
> >  
> >  	for (; pfn < end_pfn; pfn++) {
> >  		bit = pfn % BITMAP_CHUNK_BITS;
> >  		if ((*in >> bit) & 1) {
> > -			page = page_idle_get_page(pfn);
> > +			page = page_idle_get_page_pfn(pfn);
> >  			if (page) {
> >  				page_idle_clear_pte_refs(page);
> >  				set_page_idle(page);
> > @@ -224,10 +251,208 @@ struct page_ext_operations page_idle_ops = {
> >  };
> >  #endif
> >  
> > +/*  page_idle tracking for /proc/<pid>/page_idle */
> > +
> > +static DEFINE_SPINLOCK(idle_page_list_lock);
> > +struct list_head idle_page_list;
> > +
> > +struct page_node {
> > +	struct page *page;
> > +	unsigned long addr;
> > +	struct list_head list;
> > +};
> > +
> > +struct page_idle_proc_priv {
> > +	unsigned long start_addr;
> > +	char *buffer;
> > +	int write;
> > +};
> > +
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
> > +	if (!pn)
> > +		return;
> > +
> > +	pn->page = page_get;
> > +	pn->addr = addr;
> > +	list_add(&pn->list, &idle_page_list);
> > +}
> > +
> > +static int pte_page_idle_proc_range(pmd_t *pmd, unsigned long addr,
> > +				    unsigned long end,
> > +				    struct mm_walk *walk)
> > +{
> > +	struct vm_area_struct *vma = walk->vma;
> > +	pte_t *pte;
> > +	spinlock_t *ptl;
> > +	struct page *page;
> > +
> > +	ptl = pmd_trans_huge_lock(pmd, vma);
> > +	if (ptl) {
> > +		if (pmd_present(*pmd)) {
> > +			page = follow_trans_huge_pmd(vma, addr, pmd,
> > +						     FOLL_DUMP|FOLL_WRITE);
> > +			if (!IS_ERR_OR_NULL(page))
> > +				add_page_idle_list(page, addr, walk);
> > +		}
> > +		spin_unlock(ptl);
> > +		return 0;
> > +	}
> > +
> > +	if (pmd_trans_unstable(pmd))
> > +		return 0;
> > +
> > +	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> > +	for (; addr != end; pte++, addr += PAGE_SIZE) {
> > +		if (!pte_present(*pte))
> > +			continue;
> > +
> > +		page = vm_normal_page(vma, addr, *pte);
> > +		if (page)
> > +			add_page_idle_list(page, addr, walk);
> > +	}
> > +
> > +	pte_unmap_unlock(pte - 1, ptl);
> > +	return 0;
> > +}
> > +
> > +ssize_t page_idle_proc_generic(struct file *file, char __user *ubuff,
> > +			       size_t count, loff_t *pos,
> > +			       struct task_struct *tsk, int write)
> > +{
> > +	int ret;
> > +	char *buffer;
> > +	u64 *out;
> > +	unsigned long start_addr, end_addr, start_frame, end_frame;
> > +	struct mm_struct *mm = file->private_data;
> > +	struct mm_walk walk = { .pmd_entry = pte_page_idle_proc_range, };
> > +	struct page_node *cur, *next;
> > +	struct page_idle_proc_priv priv;
> > +	bool walk_error = false;
> > +
> > +	if (!mm || !mmget_not_zero(mm))
> > +		return -EINVAL;
> > +
> > +	if (count > PAGE_SIZE)
> > +		count = PAGE_SIZE;
> > +
> > +	buffer = kzalloc(PAGE_SIZE, GFP_KERNEL);
> > +	if (!buffer) {
> > +		ret = -ENOMEM;
> > +		goto out_mmput;
> > +	}
> > +	out = (u64 *)buffer;
> > +
> > +	if (write && copy_from_user(buffer, ubuff, count)) {
> > +		ret = -EFAULT;
> > +		goto out;
> > +	}
> > +
> > +	ret = page_idle_get_frames(*pos, count, mm, &start_frame, &end_frame);
> > +	if (ret)
> > +		goto out;
> > +
> > +	start_addr = (start_frame << PAGE_SHIFT);
> > +	end_addr = (end_frame << PAGE_SHIFT);
> > +	priv.buffer = buffer;
> > +	priv.start_addr = start_addr;
> > +	priv.write = write;
> > +	walk.private = &priv;
> > +	walk.mm = mm;
> > +
> > +	down_read(&mm->mmap_sem);
> > +
> > +	/*
> > +	 * Protects the idle_page_list which is needed because
> > +	 * walk_page_vma() holds ptlock which deadlocks with
> > +	 * page_idle_clear_pte_refs(). So we have to collect all
> > +	 * pages first, and then call page_idle_clear_pte_refs().
> > +	 */
> > +	spin_lock(&idle_page_list_lock);
> > +	ret = walk_page_range(start_addr, end_addr, &walk);
> > +	if (ret)
> > +		walk_error = true;
> > +
> > +	list_for_each_entry_safe(cur, next, &idle_page_list, list) {
> > +		int bit, index;
> > +		unsigned long off;
> > +		struct page *page = cur->page;
> > +
> > +		if (unlikely(walk_error))
> > +			goto remove_page;
> > +
> > +		if (write) {
> > +			page_idle_clear_pte_refs(page);
> > +			set_page_idle(page);
> > +		} else {
> > +			if (page_really_idle(page)) {
> > +				off = ((cur->addr) >> PAGE_SHIFT) - start_frame;
> > +				bit = off % BITMAP_CHUNK_BITS;
> > +				index = off / BITMAP_CHUNK_BITS;
> > +				out[index] |= 1ULL << bit;
> > +			}
> > +		}
> > +remove_page:
> > +		put_page(page);
> > +		list_del(&cur->list);
> > +		kfree(cur);
> > +	}
> > +	spin_unlock(&idle_page_list_lock);
> > +
> > +	if (!write && !walk_error)
> > +		ret = copy_to_user(ubuff, buffer, count);
> > +
> > +	up_read(&mm->mmap_sem);
> > +out:
> > +	kfree(buffer);
> > +out_mmput:
> > +	mmput(mm);
> > +	if (!ret)
> > +		ret = count;
> > +	return ret;
> > +
> > +}
> > +
> > +ssize_t page_idle_proc_read(struct file *file, char __user *ubuff,
> > +			    size_t count, loff_t *pos, struct task_struct *tsk)
> > +{
> > +	return page_idle_proc_generic(file, ubuff, count, pos, tsk, 0);
> > +}
> > +
> > +ssize_t page_idle_proc_write(struct file *file, char __user *ubuff,
> > +			     size_t count, loff_t *pos, struct task_struct *tsk)
> > +{
> > +	return page_idle_proc_generic(file, ubuff, count, pos, tsk, 1);
> > +}
> > +
> >  static int __init page_idle_init(void)
> >  {
> >  	int err;
> >  
> > +	INIT_LIST_HEAD(&idle_page_list);
> > +
> >  	err = sysfs_create_group(mm_kobj, &page_idle_attr_group);
> >  	if (err) {
> >  		pr_err("page_idle: register sysfs failed\n");
> > -- 
> > 2.22.0.657.g960e92d24f-goog
