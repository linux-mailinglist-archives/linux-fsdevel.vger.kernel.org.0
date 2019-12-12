Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1978411C309
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 03:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfLLCKh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 21:10:37 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43232 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbfLLCKg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 21:10:36 -0500
Received: by mail-pf1-f195.google.com with SMTP id h14so254905pfe.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 18:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r+iTpOmaAZEdC4zvsG5rmetn8GEK9gyyZldMYiC/ToE=;
        b=iRs/I6CCfO/iknU7o6N+zVJTI0/bkkSqD/+YNehQL6mgoqt0Z6OImCAwutGkYyIfHl
         LqQCtAXKUcWVgKI78g+pelGYrLI0d5lJ5vgXa/bj89dU7SuNi1/SEI/hg5bJuPqOyeyL
         8GvP/GCFnm+qTX7ibEbdKRp6fnbduA/lyvdjWD874zMn7vCiAWMloEr2xDpoPEt4d0mM
         Y7ech8qG8TViZbTKdTKPxq+HfxIM+GKpM7OMIgWefEBNuFzFbpPdx44fH0Wuq3iOWbM1
         umLsSCVhqyk+d1SK2qmxx87BkdrDu7FL11RCyWmEC8t0Jb14jdbkbuHouMtAzJoZBtue
         5KqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r+iTpOmaAZEdC4zvsG5rmetn8GEK9gyyZldMYiC/ToE=;
        b=XC7MsaJBttIW0WOs8t/z8T0U2lF5pMsPv9Uc7VfVHZWUCWyGzNeZjJfUOVkdygFn10
         TaUDIDy/9kFNyafJqc1UTqSP8wpLrSlZLBLPRZeZnKXOQAvZPK0GcXpStkRsdcB1zqTG
         Dv1qLrekRaeB6rIRqfbY2PvqC8ctLRQQkTjEoco0SFviuB/eDASbIaAug5dmB+6F2i/M
         uFb8uCrtLSgQigOfwygybprFdPub23aHYKiSmdNBsvf09kbQf4O7FugJlJ01Rea+xWAr
         jggZ1FxWABoLEowFlLqXd5O7XEhR+/EheqGQEAKwDZHJQxGKB1HAE5QJzpqdJjpxcMam
         ccUA==
X-Gm-Message-State: APjAAAVvX0dWCVFj3S8tYhSuz5Txp65hR9e5bNaZzpfPKgSVZATfTPNj
        3L5OxWKolO+VV236slj6e936jg==
X-Google-Smtp-Source: APXvYqxktrP7Zx8/rdGta4v4/Dl8ZYw2xXfI4wKpQz2ERfVYqCcRKqx3Eb/4DRI4LnOs8MyCxSOWag==
X-Received: by 2002:a65:488f:: with SMTP id n15mr8105815pgs.61.1576116635742;
        Wed, 11 Dec 2019 18:10:35 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id r3sm4471785pfg.145.2019.12.11.18.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 18:10:34 -0800 (PST)
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20191211152943.2933-1-axboe@kernel.dk>
 <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk>
 <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
 <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
 <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk>
 <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
 <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk>
 <e7fc6b37-8106-4fe2-479c-05c3f2b1c1f1@kernel.dk>
 <00a5c8b7-215a-7615-156d-d8f3dbb1cd3a@kernel.dk>
Message-ID: <9283b30b-393d-8662-06d6-f78990fd0b94@kernel.dk>
Date:   Wed, 11 Dec 2019 19:10:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <00a5c8b7-215a-7615-156d-d8f3dbb1cd3a@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/11/19 7:03 PM, Jens Axboe wrote:
> On 12/11/19 6:09 PM, Jens Axboe wrote:
>> On 12/11/19 4:41 PM, Jens Axboe wrote:
>>> On 12/11/19 1:18 PM, Linus Torvalds wrote:
>>>> On Wed, Dec 11, 2019 at 12:08 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>
>>>>> $ cat /proc/meminfo | grep -i active
>>>>> Active:           134136 kB
>>>>> Inactive:       28683916 kB
>>>>> Active(anon):      97064 kB
>>>>> Inactive(anon):        4 kB
>>>>> Active(file):      37072 kB
>>>>> Inactive(file): 28683912 kB
>>>>
>>>> Yeah, that should not put pressure on some swap activity. We have 28
>>>> GB of basically free inactive file data, and the VM is doing something
>>>> very very bad if it then doesn't just quickly free it with no real
>>>> drama.
>>>>
>>>> In fact, I don't think it should even trigger kswapd at all, it should
>>>> all be direct reclaim. Of course, some of the mm people hate that with
>>>> a passion, but this does look like a prime example of why it should
>>>> just be done.
>>>
>>> For giggles, I ran just a single thread on the file set. We're only
>>> doing about 100K IOPS at that point, yet when the page cache fills,
>>> kswapd still eats 10% cpu. That seems like a lot for something that
>>> slow.
>>
>> Warning, the below is from the really crazy department...
>>
>> Anyway, I took a closer look at the profiles for the uncached case.
>> We're spending a lot of time doing memsets (this is the xa_node init,
>> from the radix tree constructor), and call_rcu for the node free later
>> on. All wasted time, and something that meant we weren't as close to the
>> performance of O_DIRECT as we could be.
>>
>> So Chris and I started talking about this, and pondered "what would
>> happen if we simply bypassed the page cache completely?". Case in point,
>> see below incremental patch. We still do the page cache lookup, and use
>> that page to copy from if it's there. If the page isn't there, allocate
>> one and do IO to it, but DON'T add it to the page cache. With that,
>> we're almost at O_DIRECT levels of performance for the 4k read case,
>> without 1-2%. I think 512b would look awesome, but we're reading full
>> pages, so that won't really help us much. Compared to the previous
>> uncached method, this is 30% faster on this device. That's substantial.
>>
>> Obviously this has issues with truncate that would need to be resolved,
>> and it's definitely dirtier. But the performance is very enticing...
> 
> Tested and cleaned a bit, and added truncate protection through
> inode_dio_begin()/inode_dio_end().
> 
> https://git.kernel.dk/cgit/linux-block/commit/?h=buffered-uncached&id=6dac80bc340dabdcbfb4230b9331e52510acca87
> 
> This is much faster than the previous page cache dance, and I _think_
> we're ok as long as we block truncate and hole punching.
> 
> Comments?

Incremental was unnecessarily hard to read, here's the original
RWF_UNCACHED with it folded in instead for easier reading:

commit d1c9eec7b958760ea4d4e75483b0f2e3cfec53d5
Author: Jens Axboe <axboe@kernel.dk>
Date:   Thu Dec 5 17:45:00 2019 -0700

    fs: add read support for RWF_UNCACHED
    
    If RWF_UNCACHED is set for io_uring (or preadv2(2)), we'll use private
    pages for the buffered reads. These pages will never be inserted into
    the page cache, and they are simply droped when we have done the copy at
    the end of IO.
    
    If pages in the read range are already in the page cache, then use those
    for just copying the data instead of starting IO on private pages.
    
    A previous solution used the page cache even for non-cached ranges, but
    the cost of doing so was too high. Removing nodes at the end is
    expensive, even with LRU bypass. On top of that, repeatedly
    instantiating new xarray nodes is very costly, as it needs to memset 576
    bytes of data, and freeing said nodes involve an RCU call per node as
    well. All that adds up, making uncached somewhat slower than O_DIRECT.
    
    With the current solition, we're basically at O_DIRECT levels of
    performance for RWF_UNCACHED IO.
    
    Protect against truncate the same way O_DIRECT does, by calling
    inode_dio_begin() to elevate the inode->i_dio_count.
    
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98e0349adb52..092ea2a4319b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -314,6 +314,7 @@ enum rw_hint {
 #define IOCB_SYNC		(1 << 5)
 #define IOCB_WRITE		(1 << 6)
 #define IOCB_NOWAIT		(1 << 7)
+#define IOCB_UNCACHED		(1 << 8)
 
 struct kiocb {
 	struct file		*ki_filp;
@@ -3418,6 +3419,8 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
 		ki->ki_flags |= (IOCB_DSYNC | IOCB_SYNC);
 	if (flags & RWF_APPEND)
 		ki->ki_flags |= IOCB_APPEND;
+	if (flags & RWF_UNCACHED)
+		ki->ki_flags |= IOCB_UNCACHED;
 	return 0;
 }
 
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 379a612f8f1d..357ebb0e0c5d 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -299,8 +299,11 @@ typedef int __bitwise __kernel_rwf_t;
 /* per-IO O_APPEND */
 #define RWF_APPEND	((__force __kernel_rwf_t)0x00000010)
 
+/* drop cache after reading or writing data */
+#define RWF_UNCACHED	((__force __kernel_rwf_t)0x00000040)
+
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
-			 RWF_APPEND)
+			 RWF_APPEND | RWF_UNCACHED)
 
 #endif /* _UAPI_LINUX_FS_H */
diff --git a/mm/filemap.c b/mm/filemap.c
index bf6aa30be58d..5d299d69b185 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1990,6 +1990,13 @@ static void shrink_readahead_size_eio(struct file *filp,
 	ra->ra_pages /= 4;
 }
 
+static void buffered_put_page(struct page *page, bool clear_mapping)
+{
+	if (clear_mapping)
+		page->mapping = NULL;
+	put_page(page);
+}
+
 /**
  * generic_file_buffered_read - generic file read routine
  * @iocb:	the iocb to read
@@ -2013,6 +2020,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 	struct address_space *mapping = filp->f_mapping;
 	struct inode *inode = mapping->host;
 	struct file_ra_state *ra = &filp->f_ra;
+	bool did_dio_begin = false;
 	loff_t *ppos = &iocb->ki_pos;
 	pgoff_t index;
 	pgoff_t last_index;
@@ -2032,6 +2040,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 	offset = *ppos & ~PAGE_MASK;
 
 	for (;;) {
+		bool clear_mapping = false;
 		struct page *page;
 		pgoff_t end_index;
 		loff_t isize;
@@ -2048,6 +2057,13 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		if (!page) {
 			if (iocb->ki_flags & IOCB_NOWAIT)
 				goto would_block;
+			/* UNCACHED implies no read-ahead */
+			if (iocb->ki_flags & IOCB_UNCACHED) {
+				did_dio_begin = true;
+				/* block truncate for UNCACHED reads */
+				inode_dio_begin(inode);
+				goto no_cached_page;
+			}
 			page_cache_sync_readahead(mapping,
 					ra, filp,
 					index, last_index - index);
@@ -2106,7 +2122,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		isize = i_size_read(inode);
 		end_index = (isize - 1) >> PAGE_SHIFT;
 		if (unlikely(!isize || index > end_index)) {
-			put_page(page);
+			buffered_put_page(page, clear_mapping);
 			goto out;
 		}
 
@@ -2115,7 +2131,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		if (index == end_index) {
 			nr = ((isize - 1) & ~PAGE_MASK) + 1;
 			if (nr <= offset) {
-				put_page(page);
+				buffered_put_page(page, clear_mapping);
 				goto out;
 			}
 		}
@@ -2147,7 +2163,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		offset &= ~PAGE_MASK;
 		prev_offset = offset;
 
-		put_page(page);
+		buffered_put_page(page, clear_mapping);
 		written += ret;
 		if (!iov_iter_count(iter))
 			goto out;
@@ -2189,7 +2205,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 		if (unlikely(error)) {
 			if (error == AOP_TRUNCATED_PAGE) {
-				put_page(page);
+				buffered_put_page(page, clear_mapping);
 				error = 0;
 				goto find_page;
 			}
@@ -2206,7 +2222,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 					 * invalidate_mapping_pages got it
 					 */
 					unlock_page(page);
-					put_page(page);
+					buffered_put_page(page, clear_mapping);
 					goto find_page;
 				}
 				unlock_page(page);
@@ -2221,7 +2237,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 readpage_error:
 		/* UHHUH! A synchronous read error occurred. Report it */
-		put_page(page);
+		buffered_put_page(page, clear_mapping);
 		goto out;
 
 no_cached_page:
@@ -2234,7 +2250,15 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 			error = -ENOMEM;
 			goto out;
 		}
-		error = add_to_page_cache_lru(page, mapping, index,
+		if (iocb->ki_flags & IOCB_UNCACHED) {
+			__SetPageLocked(page);
+			page->mapping = mapping;
+			page->index = index;
+			clear_mapping = true;
+			goto readpage;
+		}
+
+		error = add_to_page_cache(page, mapping, index,
 				mapping_gfp_constraint(mapping, GFP_KERNEL));
 		if (error) {
 			put_page(page);
@@ -2250,6 +2274,8 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 would_block:
 	error = -EAGAIN;
 out:
+	if (did_dio_begin)
+		inode_dio_end(inode);
 	ra->prev_pos = prev_index;
 	ra->prev_pos <<= PAGE_SHIFT;
 	ra->prev_pos |= prev_offset;

-- 
Jens Axboe

