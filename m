Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E14710F31F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 00:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfLBXHk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 18:07:40 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:59747 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725834AbfLBXHk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 18:07:40 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TjlHfCQ_1575328051;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TjlHfCQ_1575328051)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 Dec 2019 07:07:34 +0800
Subject: Re: [RFC PATCH] mm: shmem: allow split THP when truncating THP
 partially
To:     Hugh Dickins <hughd@google.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1574471132-55639-1-git-send-email-yang.shi@linux.alibaba.com>
 <20191125093611.hlamtyo4hvefwibi@box>
 <3a35da3a-dff0-a8ca-8269-3018fff8f21b@linux.alibaba.com>
 <20191125183350.5gmcln6t3ofszbsy@box>
 <9a68b929-2f84-083d-0ac8-2ceb3eab8785@linux.alibaba.com>
 <14b7c24b-706e-79cf-6fbc-f3c042f30f06@linux.alibaba.com>
 <alpine.LSU.2.11.1911271718130.652@eggly.anvils>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <c687299a-574a-b35f-4ba4-ca67dc498ebd@linux.alibaba.com>
Date:   Mon, 2 Dec 2019 15:07:25 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.1911271718130.652@eggly.anvils>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 11/27/19 7:06 PM, Hugh Dickins wrote:
> On Tue, 26 Nov 2019, Yang Shi wrote:
>> On 11/25/19 11:33 AM, Yang Shi wrote:
>>> On 11/25/19 10:33 AM, Kirill A. Shutemov wrote:
>>>> On Mon, Nov 25, 2019 at 10:24:38AM -0800, Yang Shi wrote:
>>>>> On 11/25/19 1:36 AM, Kirill A. Shutemov wrote:
>>>>>> On Sat, Nov 23, 2019 at 09:05:32AM +0800, Yang Shi wrote:
>>>>>>> Currently when truncating shmem file, if the range is partial of
>>>>>>> THP
>>>>>>> (start or end is in the middle of THP), the pages actually will
>>>>>>> just get
>>>>>>> cleared rather than being freed unless the range cover the whole
>>>>>>> THP.
>>>>>>> Even though all the subpages are truncated (randomly or
>>>>>>> sequentially),
>>>>>>> the THP may still be kept in page cache.  This might be fine for
>>>>>>> some
>>>>>>> usecases which prefer preserving THP.
>>>>>>>
>>>>>>> But, when doing balloon inflation in QEMU, QEMU actually does hole
>>>>>>> punch
>>>>>>> or MADV_DONTNEED in base page size granulairty if hugetlbfs is not
>>>>>>> used.
>>>>>>> So, when using shmem THP as memory backend QEMU inflation actually
>>>>>>> doesn't
>>>>>>> work as expected since it doesn't free memory.  But, the inflation
>>>>>>> usecase really needs get the memory freed.  Anonymous THP will not
>>>>>>> get
>>>>>>> freed right away too but it will be freed eventually when all
>>>>>>> subpages are
>>>>>>> unmapped, but shmem THP would still stay in page cache.
>>>>>>>
>>>>>>> To protect the usecases which may prefer preserving THP, introduce
>>>>>>> a
>>>>>>> new fallocate mode: FALLOC_FL_SPLIT_HPAGE, which means spltting THP
>>>>>>> is
>>>>>>> preferred behavior if truncating partial THP.  This mode just makes
>>>>>>> sense to tmpfs for the time being.
> Sorry, I haven't managed to set aside enough time for this until now.
>
> First off, let me say that I firmly believe this punch-split behavior
> should be the standard behavior (like in my huge tmpfs implementation),
> and we should not need a special FALLOC_FL_SPLIT_HPAGE to do it.
> But I don't know if I'll be able to persuade Kirill of that.
>
> If the caller wants to write zeroes into the file, she can do so with the
> write syscall: the caller has asked to punch a hole or truncate the file,
> and in our case, like your QEMU case, hopes that memory and memcg charge
> will be freed by doing so.  I'll be surprised if changing the behavior
> to yours and mine turns out to introduce a regression, but if it does,
> I guess we'll then have to put it behind a sysctl or whatever.

I'm not sure if there may be regression or not so I added the flag to 
have a choice. But, sysctl may seem better. Anyway, I agree we don't 
have to consider the potential regression until the real regression is 
found.

>
> IIUC the reason that it's currently implemented by clearing the hole
> is because split_huge_page() (unlike in older refcounting days) cannot
> be guaranteed to succeed.  Which is unfortunate, and none of us is very
> keen to build a filesystem on unreliable behavior; but the failure cases
> appear in practice to be rare enough, that it's on balance better to give
> the punch-hole-truncate caller what she asked for whenever possible.
>
>>>>>> We need to clarify interaction with khugepaged. This implementation
>>>>>> doesn't do anything to prevent khugepaged from collapsing the range
>>>>>> back
>>>>>> to THP just after the split.
>>>>> Yes, it doesn't. Will clarify this in the commit log.
>>>> Okay, but I'm not sure that documention alone will be enough. We need
>>>> proper design.
>>> Maybe we could try to hold inode lock with read during collapse_file(). The
>>> shmem fallocate does acquire inode lock with write, this should be able to
>>> synchronize hole punch and khugepaged. And, shmem just needs hold inode
>>> lock for llseek and fallocate, I'm supposed they are should be called not
>>> that frequently to have impact on khugepaged. The llseek might be often,
>>> but it should be quite fast. However, they might get blocked by khugepaged.
>>>
>>> It sounds safe to hold a rwsem during collapsing THP.
> No, I don't think we want to take any more locks while collapsing THP,
> but that wasn't really the point.  We're not concerned about a *race*
> between splitting and khugepaged reassembling (I'm assuming that any
> such race would already exist, and be well-guarded against by all the
> refcount checks, punchhole not adding anything new here; but perhaps
> I'm assuming too blithely, and it is worth checking over).
>
> The point, as I see it anyway, is the contradiction in effort: the
> caller asks for hole to be punched, we do that, then a few seconds
> or minutes later, khugepaged comes along and fills in the hole (if
> huge page availability and memcg limit allow it).
>
> I agree that's not very satisfactory, but I think it's a side issue:
> we don't have a good mechanism to tell khugepaged to keep off a range.
> As it is, fallocate and ftruncate ought to do the job expected of them,
> and khugepaged ought to do the job expected of it.  And in many cases,
> the punched file will not even be mapped (visible to khugepaged), or
> max_ptes_none set to exclude working on such holes.
>
> Is khugepaged's action an issue for your QEMU case?

So far not.

>
>>> Or we could set VM_NOHUGEPAGE in shmem inode's flag with hole punch and
>>> clear it after truncate, then check the flag before doing collapse in
>>> khugepaged. khugepaged should not need hold the inode lock during collapse
>>> since it could be released after the flag is checked.
>> By relooking the code, it looks the latter one (check VM_NOHUGEPAGE) doesn't
>> make sense, it can't prevent khugepaged from collapsing THP in parallel.
>>
>>>>>>> @@ -976,8 +1022,31 @@ static void shmem_undo_range(struct inode
>>>>>>> *inode, loff_t lstart, loff_t lend,
>>>>>>>                 }
>>>>>>>                 unlock_page(page);
>>>>>>>             }
>>>>>>> +rescan_split:
>>>>>>>             pagevec_remove_exceptionals(&pvec);
>>>>>>>             pagevec_release(&pvec);
>>>>>>> +
>>>>>>> +        if (split && PageTransCompound(page)) {
>>>>>>> +            /* The THP may get freed under us */
>>>>>>> +            if (!get_page_unless_zero(compound_head(page)))
>>>>>>> +                goto rescan_out;
>>>>>>> +
>>>>>>> +            lock_page(page);
>>>>>>> +
>>>>>>> +            /*
>>>>>>> +             * The extra pins from page cache lookup have been
>>>>>>> +             * released by pagevec_release().
>>>>>>> +             */
>>>>>>> +            if (!split_huge_page(page)) {
>>>>>>> +                unlock_page(page);
>>>>>>> +                put_page(page);
>>>>>>> +                /* Re-look up page cache from current index */
>>>>>>> +                goto again;
>>>>>>> +            }
>>>>>>> +            unlock_page(page);
>>>>>>> +            put_page(page);
>>>>>>> +        }
>>>>>>> +rescan_out:
>>>>>>>             index++;
>>>>>>>         }
>>>>>> Doing get_page_unless_zero() just after you've dropped the pin for
>>>>>> the
>>>>>> page looks very suboptimal.
>>>>> If I don't drop the pins the THP can't be split. And, there might be
>>>>> more
>>>>> than one pins from find_get_entries() if I read the code correctly. For
>>>>> example, truncate 8K length in the middle of THP, the THP's refcount
>>>>> would
>>>>> get bumpped twice since  two sub pages would be returned.
>>>> Pin the page before pagevec_release() and avoid get_page_unless_zero().
>>>>
>>>> Current code is buggy. You need to check that the page is still belong to
>>>> the file after speculative lookup.
> Yes indeed (I think you can even keep the page locked, but I may be wrong).
>
>>> Yes, I missed this point. Thanks for the suggestion.
> The main problem I see is your "goto retry" and "goto again":
> split_huge_page() may fail because a get_page() somewhere is holding
> a transient reference to the page, or it may fail because there's a
> GUP that holds a reference for days: you do not want to be stuck here
> going round and around the loop waiting for that GUP to be released!

I think my code already handled this case. Once the split is failed, it 
just falls through to next index. It just does retry as long as split 
succeeds.

But my patch does clear before split.

>
> It's nice that we already have a trylock_page() loop followed by a
> lock_page() loop.  When split_huge_page() fails, the trylock_page()
> loop can simply move on to the next page (skip over the compound page,
> or retry it subpage by subpage? I've forgotten the pros and cons),
> and leave final resolution to the later lock_page() loop: which has to
> accept when split_huge_page() failed, and fall back to clearing instead.
>
> I would prefer a smaller patch than your RFC: making split the
> default behavior cuts out a lot of it, but I think there's still
> more that can be cut.  Here's the patch we've been using internally,
> which deletes quite a lot of the old code; but you'll quickly notice
> has a "Revisit later" hack in find_get_entries(), which I've not got
> around to revisiting yet.  Please blend what you can from my patch
> into yours, or vice versa.

Thank you very much. It looks your "Revisit later" hack tries to keep 
just one extra pin for the THP so that split could succeed.

I will try to blend the two patches.

>
> Hugh
>
> ---
>
>   mm/filemap.c |    3 +
>   mm/shmem.c   |   86 +++++++++++++++++--------------------------------
>   2 files changed, 34 insertions(+), 55 deletions(-)
>
> --- v5.4/mm/filemap.c	2019-11-24 16:32:01.000000000 -0800
> +++ linux/mm/filemap.c	2019-11-27 16:21:16.316801433 -0800
> @@ -1752,6 +1752,9 @@ unsigned find_get_entries(struct address
>   			goto put_page;
>   		page = find_subpage(page, xas.xa_index);
>   
> +		/* Revisit later: make shmem_undo_range() easier for now */
> +		if (PageTransCompound(page))
> +			nr_entries = ret + 1;
>   export:
>   		indices[ret] = xas.xa_index;
>   		entries[ret] = page;
> --- v5.4/mm/shmem.c	2019-11-24 16:32:01.000000000 -0800
> +++ linux/mm/shmem.c	2019-11-27 16:21:16.320801450 -0800
> @@ -788,6 +788,20 @@ void shmem_unlock_mapping(struct address
>   	}
>   }
>   
> +static bool shmem_punch_compound(struct page *page, pgoff_t start, pgoff_t end)
> +{
> +	if (!PageTransCompound(page))
> +		return true;
> +
> +	/* Just proceed to delete a huge page wholly within the range punched */
> +	if (PageHead(page) &&
> +	    page->index >= start && page->index + HPAGE_PMD_NR <= end)
> +		return true;
> +
> +	/* Try to split huge page, so we can truly punch the hole or truncate */
> +	return split_huge_page(page) >= 0;
> +}
> +
>   /*
>    * Remove range of pages and swap entries from page cache, and free them.
>    * If !unfalloc, truncate or punch hole; if unfalloc, undo failed fallocate.
> @@ -838,31 +852,11 @@ static void shmem_undo_range(struct inod
>   			if (!trylock_page(page))
>   				continue;
>   
> -			if (PageTransTail(page)) {
> -				/* Middle of THP: zero out the page */
> -				clear_highpage(page);
> -				unlock_page(page);
> -				continue;
> -			} else if (PageTransHuge(page)) {
> -				if (index == round_down(end, HPAGE_PMD_NR)) {
> -					/*
> -					 * Range ends in the middle of THP:
> -					 * zero out the page
> -					 */
> -					clear_highpage(page);
> -					unlock_page(page);
> -					continue;
> -				}
> -				index += HPAGE_PMD_NR - 1;
> -				i += HPAGE_PMD_NR - 1;
> -			}
> -
> -			if (!unfalloc || !PageUptodate(page)) {
> -				VM_BUG_ON_PAGE(PageTail(page), page);
> -				if (page_mapping(page) == mapping) {
> -					VM_BUG_ON_PAGE(PageWriteback(page), page);
> +			if ((!unfalloc || !PageUptodate(page)) &&
> +			    page_mapping(page) == mapping) {
> +				VM_BUG_ON_PAGE(PageWriteback(page), page);
> +				if (shmem_punch_compound(page, start, end))
>   					truncate_inode_page(mapping, page);
> -				}
>   			}
>   			unlock_page(page);
>   		}
> @@ -936,43 +930,25 @@ static void shmem_undo_range(struct inod
>   
>   			lock_page(page);
>   
> -			if (PageTransTail(page)) {
> -				/* Middle of THP: zero out the page */
> -				clear_highpage(page);
> -				unlock_page(page);
> -				/*
> -				 * Partial thp truncate due 'start' in middle
> -				 * of THP: don't need to look on these pages
> -				 * again on !pvec.nr restart.
> -				 */
> -				if (index != round_down(end, HPAGE_PMD_NR))
> -					start++;
> -				continue;
> -			} else if (PageTransHuge(page)) {
> -				if (index == round_down(end, HPAGE_PMD_NR)) {
> -					/*
> -					 * Range ends in the middle of THP:
> -					 * zero out the page
> -					 */
> -					clear_highpage(page);
> -					unlock_page(page);
> -					continue;
> -				}
> -				index += HPAGE_PMD_NR - 1;
> -				i += HPAGE_PMD_NR - 1;
> -			}
> -
>   			if (!unfalloc || !PageUptodate(page)) {
> -				VM_BUG_ON_PAGE(PageTail(page), page);
> -				if (page_mapping(page) == mapping) {
> -					VM_BUG_ON_PAGE(PageWriteback(page), page);
> -					truncate_inode_page(mapping, page);
> -				} else {
> +				if (page_mapping(page) != mapping) {
>   					/* Page was replaced by swap: retry */
>   					unlock_page(page);
>   					index--;
>   					break;
>   				}
> +				VM_BUG_ON_PAGE(PageWriteback(page), page);
> +				if (shmem_punch_compound(page, start, end))
> +					truncate_inode_page(mapping, page);
> +				else {
> +					/* Wipe the page and don't get stuck */
> +					clear_highpage(page);
> +					flush_dcache_page(page);
> +					set_page_dirty(page);
> +					if (index <
> +					    round_up(start, HPAGE_PMD_NR))
> +						start = index + 1;
> +				}
>   			}
>   			unlock_page(page);
>   		}

