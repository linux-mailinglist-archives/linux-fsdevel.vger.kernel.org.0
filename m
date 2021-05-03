Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C2F3712FE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 11:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbhECJaD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 05:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231523AbhECJaD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 05:30:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4885D6134F;
        Mon,  3 May 2021 09:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620034150;
        bh=I1Va2M1In7/8Va4ug37hQWcWQ6HmBWYcOh51DEY5fuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fLr3Rw/5KuN7AdI4iGvmjflgDT8KEAvkqmIqRzugSLFvrln6yXh9vAxVmpsqNrv8P
         xE8FJtRESmSwQ23TKy/T3vyrWKBskbsUVkrPu6To8pNXIzZd357jqo8Ing/JyFo1Fv
         sfk18desrvvWKI0pwl08PsRN9PsEDuXQPrbpYEcEDGzT/yMujqy5wjx43yj0pCqUes
         Mi4zu361NOtsbBmJtNHWL/osjPbubXqhT7IPrbCNdZL1R8YsW0B09t8iiT2z+UrlPh
         snHK6IUaDGY6J7jvjGoq5CfDF7LW1DcMlUfI43honVFe5Ih3mQboTTYy4BqvihlVFI
         mVLzE8bWl2SMQ==
Date:   Mon, 3 May 2021 12:28:58 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Steven Price <steven.price@arm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Aili Yao <yaoaili@kingsoft.com>, Jiri Bohac <jbohac@suse.cz>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 7/7] fs/proc/kcore: use page_offline_(freeze|unfreeze)
Message-ID: <YI/CWg6PrMxcCT2D@kernel.org>
References: <20210429122519.15183-1-david@redhat.com>
 <20210429122519.15183-8-david@redhat.com>
 <YI5H4yV/c6ReuIDt@kernel.org>
 <5a5a7552-4f0a-75bc-582f-73d24afcf57b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a5a7552-4f0a-75bc-582f-73d24afcf57b@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 03, 2021 at 10:28:36AM +0200, David Hildenbrand wrote:
> On 02.05.21 08:34, Mike Rapoport wrote:
> > On Thu, Apr 29, 2021 at 02:25:19PM +0200, David Hildenbrand wrote:
> > > Let's properly synchronize with drivers that set PageOffline(). Unfreeze
> > > every now and then, so drivers that want to set PageOffline() can make
> > > progress.
> > > 
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> > > ---
> > >   fs/proc/kcore.c | 15 +++++++++++++++
> > >   1 file changed, 15 insertions(+)
> > > 
> > > diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> > > index 92ff1e4436cb..3d7531f47389 100644
> > > --- a/fs/proc/kcore.c
> > > +++ b/fs/proc/kcore.c
> > > @@ -311,6 +311,7 @@ static void append_kcore_note(char *notes, size_t *i, const char *name,
> > >   static ssize_t
> > >   read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
> > >   {
> > > +	size_t page_offline_frozen = 0;
> > >   	char *buf = file->private_data;
> > >   	size_t phdrs_offset, notes_offset, data_offset;
> > >   	size_t phdrs_len, notes_len;
> > > @@ -509,6 +510,18 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
> > >   			pfn = __pa(start) >> PAGE_SHIFT;
> > >   			page = pfn_to_online_page(pfn);
> > 
> > Can't this race with page offlining for the first time we get here?
> 
> 
> To clarify, we have three types of offline pages in the kernel ...
> 
> a) Pages part of an offline memory section; the memap is stale and not
> trustworthy. pfn_to_online_page() checks that. We *can* protect against
> memory offlining using get_online_mems()/put_online_mems(), but usually
> avoid doing so as the race window is very small (and a problem all over the
> kernel we basically never hit) and locking is rather expensive. In the
> future, we might switch to rcu to handle that more efficiently and avoiding
> these possible races.
> 
> b) PageOffline(): logically offline pages contained in an online memory
> section with a sane memmap. virtio-mem calls these pages "fake offline";
> something like a "temporary" memory hole. The new mechanism I propose will
> be used to handle synchronization as races can be more severe, e.g., when
> reading actual page content here.
> 
> c) Soft offline pages: hwpoisoned pages that are not actually harmful yet,
> but could become harmful in the future. So we better try to remove the page
> from the page allcoator and try to migrate away existing users.
> 
> 
> So page_offline_* handle "b) PageOffline()" only. There is a tiny race
> between pfn_to_online_page(pfn) and looking at the memmap as we have in many
> cases already throughout the kernel, to be tackled in the future.

Right, but here you anyway add locking, so why exclude the first iteration?
 
> (A better name for PageOffline() might make sense; PageSoftOffline() would
> be catchy but interferes with c). PageLogicallyOffline() is ugly;
> PageFakeOffline() might do)
> 
> > > +			/*
> > > +			 * Don't race against drivers that set PageOffline()
> > > +			 * and expect no further page access.
> > > +			 */
> > > +			if (page_offline_frozen == MAX_ORDER_NR_PAGES) {
> > > +				page_offline_unfreeze();
> > > +				page_offline_frozen = 0;
> > > +				cond_resched();
> > > +			}
> > > +			if (!page_offline_frozen++)
> > > +				page_offline_freeze();
> > > +

BTW, did you consider something like

	if (page_offline_frozen++ % MAX_ORDER_NR_PAGES == 0) {
		page_offline_unfreeze();
		cond_resched();
		page_offline_freeze();
	}

We don't seem to care about page_offline_frozen overflows here, do we?

-- 
Sincerely yours,
Mike.
