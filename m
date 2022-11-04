Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8358A61920B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 08:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiKDHcg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 03:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiKDHcb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 03:32:31 -0400
X-Greylist: delayed 74729 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Nov 2022 00:32:29 PDT
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C954D60FF;
        Fri,  4 Nov 2022 00:32:29 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oqrBf-0006vW-Ob; Fri, 04 Nov 2022 08:32:23 +0100
Message-ID: <5f7bac77-c088-6fb7-ccb5-bef9267f7186@leemhuis.info>
Date:   Fri, 4 Nov 2022 08:32:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-mm@kvack.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <20220915094200.139713-1-hch@lst.de>
 <20220915094200.139713-4-hch@lst.de>
 <d20a0a85-e415-cf78-27f9-77dd7a94bc8d@leemhuis.info>
 <Y2Q+y8t9PV5nrjud@cmpxchg.org>
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [REGESSION] systemd-oomd overreacting due to PSI changes for
 Btrfs (was: Re: [PATCH 3/5] btrfs: add manual PSI accounting for compressed
 reads)
In-Reply-To: <Y2Q+y8t9PV5nrjud@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1667547149;090cbd81;
X-HE-SMSGID: 1oqrBf-0006vW-Ob
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03.11.22 23:20, Johannes Weiner wrote:
> On Thu, Nov 03, 2022 at 11:46:52AM +0100, Thorsten Leemhuis wrote:
>> On 15.09.22 11:41, Christoph Hellwig wrote:
>>> btrfs compressed reads try to always read the entire compressed chunk,
>>> even if only a subset is requested.  Currently this is covered by the
>>> magic PSI accounting underneath submit_bio, but that is about to go
>>> away. Instead add manual psi_memstall_{enter,leave} annotations.
>>>
>>> Note that for readahead this really should be using readahead_expand,
>>> but the additionals reads are also done for plain ->read_folio where
>>> readahead_expand can't work, so this overall logic is left as-is for
>>> now.
>>
>> It seems this patch makes systemd-oomd overreact on my day-to-day
>> machine and aggressively kill applications. I'm not the only one that
>> noticed such a behavior with 6.1 pre-releases:
>> https://bugzilla.redhat.com/show_bug.cgi?id=2133829
>> https://bugzilla.redhat.com/show_bug.cgi?id=2134971
> [...]
>> On master as of today (8e5423e991e8) I can trigger the problem within a
>> minute or two. But I fail to trigger it with v6.0.6 or when I revert
>> 4088a47e78f9 ("btrfs: add manual PSI accounting for compressed reads").
>> And yes, I use btrfs with compression for / and /home/.
> [...]
> 
> Oh, I think I see the bug. We can leak pressure state from the bio
> submission, which causes the task to permanently drive up pressure.

Thx for looking into this.

> Can you try this patch?

It apparently does the trick -- at least my test setup that usually
triggers the bug within a minute or two survived for nearly an hour now, so:

Tested-by: Thorsten Leemhuis <linux@leemhuis.info>

Can you please also add this tag to help future archeologists, as
explained by the kernel docs (for details see
Documentation/process/submitting-patches.rst and
Documentation/process/5.Posting.rst):

Link:
https://lore.kernel.org/r/d20a0a85-e415-cf78-27f9-77dd7a94bc8d@leemhuis.info/

It also will make my regression tracking bot see further postings of
this patch and mark the issue as resolved once the patch lands in mainline.

tia and thx again for the patch!

Ciao, Thorsten

>>From 499e5cab7b39fc4c90a0f96e33cdc03274b316fd Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Thu, 3 Nov 2022 17:34:31 -0400
> Subject: [PATCH] fs: btrfs: fix leaked psi pressure state
> 
> When psi annotations were added to to btrfs compression reads, the psi
> state tracking over add_ra_bio_pages and btrfs_submit_compressed_read
> was faulty. The task can remain in a stall state after the read. This
> results in incorrectly elevated pressure, which triggers OOM kills.
> 
> pflags record the *previous* memstall state when we enter a new
> one. The code tried to initialize pflags to 1, and then optimize the
> leave call when we either didn't enter a memstall, or were already
> inside a nested stall. However, there can be multiple PageWorkingset
> pages in the bio, at which point it's that path itself that re-enters
> the state and overwrites pflags. This causes us to miss the exit.
> 
> Enter the stall only once if needed, then unwind correctly.
> 
> Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
> Fixes: 4088a47e78f9 btrfs: add manual PSI accounting for compressed reads
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  fs/btrfs/compression.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index f1f051ad3147..e6635fe70067 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -512,7 +512,7 @@ static u64 bio_end_offset(struct bio *bio)
>  static noinline int add_ra_bio_pages(struct inode *inode,
>  				     u64 compressed_end,
>  				     struct compressed_bio *cb,
> -				     unsigned long *pflags)
> +				     int *memstall, unsigned long *pflags)
>  {
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	unsigned long end_index;
> @@ -581,8 +581,10 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>  			continue;
>  		}
>  
> -		if (PageWorkingset(page))
> +		if (!*memstall && PageWorkingset(page)) {
>  			psi_memstall_enter(pflags);
> +			*memstall = 1;
> +		}
>  
>  		ret = set_page_extent_mapped(page);
>  		if (ret < 0) {
> @@ -670,8 +672,8 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  	u64 em_len;
>  	u64 em_start;
>  	struct extent_map *em;
> -	/* Initialize to 1 to make skip psi_memstall_leave unless needed */
> -	unsigned long pflags = 1;
> +	unsigned long pflags;
> +	int memstall = 0;
>  	blk_status_t ret;
>  	int ret2;
>  	int i;
> @@ -727,7 +729,7 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  		goto fail;
>  	}
>  
> -	add_ra_bio_pages(inode, em_start + em_len, cb, &pflags);
> +	add_ra_bio_pages(inode, em_start + em_len, cb, &memstall, &pflags);
>  
>  	/* include any pages we added in add_ra-bio_pages */
>  	cb->len = bio->bi_iter.bi_size;
> @@ -807,7 +809,7 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  		}
>  	}
>  
> -	if (!pflags)
> +	if (memstall)
>  		psi_memstall_leave(&pflags);
>  
>  	if (refcount_dec_and_test(&cb->pending_ios))
