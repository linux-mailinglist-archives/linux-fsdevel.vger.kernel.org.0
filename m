Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE89A617B08
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 11:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiKCKrJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 06:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiKCKrF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:47:05 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B862E0C2;
        Thu,  3 Nov 2022 03:47:02 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oqXkL-0003lj-L2; Thu, 03 Nov 2022 11:46:53 +0100
Message-ID: <d20a0a85-e415-cf78-27f9-77dd7a94bc8d@leemhuis.info>
Date:   Thu, 3 Nov 2022 11:46:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: [REGESSION] systemd-oomd overreacting due to PSI changes for Btrfs
 (was: Re: [PATCH 3/5] btrfs: add manual PSI accounting for compressed reads)
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-mm@kvack.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <20220915094200.139713-1-hch@lst.de>
 <20220915094200.139713-4-hch@lst.de>
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <linux@leemhuis.info>
In-Reply-To: <20220915094200.139713-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1667472422;8a47145f;
X-HE-SMSGID: 1oqXkL-0003lj-L2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph!

On 15.09.22 11:41, Christoph Hellwig wrote:
> btrfs compressed reads try to always read the entire compressed chunk,
> even if only a subset is requested.  Currently this is covered by the
> magic PSI accounting underneath submit_bio, but that is about to go
> away. Instead add manual psi_memstall_{enter,leave} annotations.
> 
> Note that for readahead this really should be using readahead_expand,
> but the additionals reads are also done for plain ->read_folio where
> readahead_expand can't work, so this overall logic is left as-is for
> now.

It seems this patch makes systemd-oomd overreact on my day-to-day
machine and aggressively kill applications. I'm not the only one that
noticed such a behavior with 6.1 pre-releases:
https://bugzilla.redhat.com/show_bug.cgi?id=2133829
https://bugzilla.redhat.com/show_bug.cgi?id=2134971

I think I have a pretty reliable way to trigger the issue that involves
starting the apps that I normally use and a VM that I occasionally use,
which up to now never resulted in such a behaviour.

On master as of today (8e5423e991e8) I can trigger the problem within a
minute or two. But I fail to trigger it with v6.0.6 or when I revert
4088a47e78f9 ("btrfs: add manual PSI accounting for compressed reads").
And yes, I use btrfs with compression for / and /home/.

See [1] for a log msg from systemd-oomd.

Note, I had some trouble with bisecting[2]. This series looked
suspicious, so I removed it completely ontop of master and the problem
went away. Then I tried reverting only 4088a47e78f9 which helped, too.
Let me know if you want me to try another combination or need more data.

Ciao, Thorsten


[1] just one example:
```
> 10:52:29 t14s systemd-oomd[1261]: Considered 60 cgroups for killing, top candidates were:
> 10:52:29 t14s systemd-oomd[1261]:         Path: /system.slice/packagekit.service
> 10:52:29 t14s systemd-oomd[1261]:                 Memory Pressure Limit: 0.00%
> 10:52:29 t14s systemd-oomd[1261]:                 Pressure: Avg10: 93.66 Avg60: 38.22 Avg300: 9.48 Total: 29s
> 10:52:29 t14s systemd-oomd[1261]:                 Current Memory Usage: 276.9M
> 10:52:29 t14s systemd-oomd[1261]:                 Memory Min: 0B
> 10:52:29 t14s systemd-oomd[1261]:                 Memory Low: 0B
> 10:52:29 t14s systemd-oomd[1261]:                 Pgscan: 181098
> 10:52:29 t14s systemd-oomd[1261]:                 Last Pgscan: 178926
> 10:52:29 t14s systemd-oomd[1261]:         Path: /system.slice/firewalld.service
> 10:52:29 t14s systemd-oomd[1261]:                 Memory Pressure Limit: 0.00%
> 10:52:29 t14s systemd-oomd[1261]:                 Pressure: Avg10: 0.00 Avg60: 0.00 Avg300: 0.00 Total: 0
> 10:52:29 t14s systemd-oomd[1261]:                 Current Memory Usage: 34.6M
> 10:52:29 t14s systemd-oomd[1261]:                 Memory Min: 0B
> 10:52:29 t14s systemd-oomd[1261]:                 Memory Low: 0B
> 10:52:29 t14s systemd-oomd[1261]:                 Pgscan: 13035
> 10:52:29 t14s systemd-oomd[1261]:                 Last Pgscan: 12854
> 10:52:29 t14s systemd-oomd[1261]:         Path: /system.slice/sssd-kcm.service
> 10:52:29 t14s systemd-oomd[1261]:                 Memory Pressure Limit: 0.00%
> 10:52:29 t14s systemd-oomd[1261]:                 Pressure: Avg10: 0.00 Avg60: 0.00 Avg300: 0.00 Total: 184us
> 10:52:29 t14s systemd-oomd[1261]:                 Current Memory Usage: 32.9M
> 10:52:29 t14s systemd-oomd[1261]:                 Memory Min: 0B
> 10:52:29 t14s systemd-oomd[1261]:                 Memory Low: 0B
> 10:52:29 t14s systemd-oomd[1261]:                 Pgscan: 7667
> 10:52:29 t14s systemd-oomd[1261]:                 Last Pgscan: 7501
> 10:52:29 t14s systemd-oomd[1261]:         Path: /system.slice/systemd-journald.service
> 10:52:29 t14s systemd-oomd[1261]:                 Memory Pressure Limit: 0.00%
> 10:52:29 t14s systemd-oomd[1261]:                 Pressure: Avg10: 0.00 Avg60: 0.00 Avg300: 0.00 Total: 8ms
> 10:52:29 t14s systemd-oomd[1261]:                 Current Memory Usage: 14.5M
> 10:52:29 t14s systemd-oomd[1261]:                 Memory Min: 0B
> 10:52:29 t14s systemd-oomd[1261]:                 Memory Low: 0B
> 10:52:29 t14s systemd-oomd[1261]:                 Pgscan: 13020
> 10:52:29 t14s systemd-oomd[1261]:                 Last Pgscan: 12914
> 10:52:29 t14s systemd-oomd[1261]:         Path: /system.slice/libvirtd.service
> 10:52:29 t14s systemd-oomd[1261]:                 Memory Pressure Limit: 0.00%
> 10:52:29 t14s systemd-oomd[1261]:                 Pressure: Avg10: 0.00 Avg60: 0.00 Avg300: 0.00 Total: 0
> 10:52:29 t14s systemd-oomd[1261]:                 Current Memory Usage: 18.9M
> 10:52:29 t14s systemd-oomd[1261]:                 Memory Min: 0B
> 10:52:29 t14s systemd-oomd[1261]:                 Memory Low: 0B
> 10:52:29 t14s systemd-oomd[1261]:                 Pgscan: 12983
> 10:52:29 t14s systemd-oomd[1261]:                 Last Pgscan: 12896
> 10:52:29 t14s systemd-oomd[1261]:         Path: /system.slice/geoclue.service
> 10:52:29 t14s systemd-oomd[1261]:                 Memory Pressure Limit: 0.00%
> 10:52:29 t14s systemd-oomd[1261]:                 Pressure: Avg10: 0.00 Avg60: 0.00 Avg300: 0.00 Total: 0
> 10:52:29 t14s systemd-oomd[1261]:                 Current Memory Usage: 18.0M
> 10:52:29 t14s systemd-oomd[1261]:                 Memory Min: 0B
> 10:52:29 t14s systemd-oomd[1261]:                 Memory Low: 0B
> 10:52:29 t14s systemd-oomd[1261]:                 Pgscan: 3625
> 10:52:29 t14s systemd-oomd[1261]:                 Last Pgscan: 3550
> 10:52:29 t14s systemd-oomd[1261]:         Path: /system.slice/polkit.service
> 10:52:29 t14s systemd-oomd[1261]:                 Memory Pressure Limit: 0.00%
> 10:52:29 t14s systemd-oomd[1261]:                 Pressure: Avg10: 0.00 Avg60: 0.00 Avg300: 0.00 Total: 2ms
> 10:52:29 t14s systemd-oomd[1261]:                 Current Memory Usage: 15.9M
> 10:52:29 t14s systemd-oomd[1261]:                 Memory Min: 0B
> 10:52:29 t14s systemd-oomd[1261]:                 Memory Low: 0B
> 10:52:29 t14s systemd-oomd[1261]:                 Pgscan: 10664
> 10:52:29 t14s systemd-oomd[1261]:                 Last Pgscan: 10596
> 10:52:29 t14s systemd-oomd[1261]:         Path: /system.slice/NetworkManager.service
> 10:52:29 t14s systemd-oomd[1261]:                 Memory Pressure Limit: 0.00%
> 10:52:29 t14s systemd-oomd[1261]:                 Pressure: Avg10: 0.00 Avg60: 0.00 Avg300: 0.00 Total: 3ms
> 10:52:29 t14s systemd-oomd[1261]:                 Current Memory Usage: 6.6M
> 10:52:29 t14s systemd-oomd[1261]:                 Memory Min: 0B
> 10:52:29 t14s systemd-oomd[1261]:                 Memory Low: 0B
> 10:52:29 t14s systemd-oomd[1261]:                 Pgscan: 2515
> 10:52:29 t14s systemd-oomd[1261]:                 Last Pgscan: 2492
> 10:52:29 t14s systemd-oomd[1261]:         Path: /system.slice/abrt-xorg.service
> 10:52:29 t14s systemd-oomd[1261]:                 Memory Pressure Limit: 0.00%
> 10:52:29 t14s systemd-oomd[1261]:                 Pressure: Avg10: 0.00 Avg60: 0.00 Avg300: 0.00 Total: 0
> 10:52:29 t14s systemd-oomd[1261]:                 Current Memory Usage: 5.2M
> 10:52:29 t14s systemd-oomd[1261]:                 Memory Min: 0B
> 10:52:29 t14s systemd-oomd[1261]:                 Memory Low: 0B
> 10:52:29 t14s systemd-oomd[1261]:                 Pgscan: 35154
> 10:52:29 t14s systemd-oomd[1261]:                 Last Pgscan: 35131
> 10:52:29 t14s systemd-oomd[1261]:         Path: /system.slice/dbus-broker.service
> 10:52:29 t14s systemd-oomd[1261]:                 Memory Pressure Limit: 0.00%
> 10:52:29 t14s systemd-oomd[1261]:                 Pressure: Avg10: 0.00 Avg60: 0.00 Avg300: 0.00 Total: 0
> 10:52:29 t14s systemd-oomd[1261]:                 Current Memory Usage: 7.5M
> 10:52:29 t14s systemd-oomd[1261]:                 Memory Min: 0B
> 10:52:29 t14s systemd-oomd[1261]:                 Memory Low: 0B
> 10:52:29 t14s systemd-oomd[1261]:                 Pgscan: 1183
> 10:52:29 t14s systemd-oomd[1261]:                 Last Pgscan: 1161
> 10:52:29 t14s systemd-oomd[1261]: Killed /system.slice/packagekit.service due to memory pressure for /system.slice being 91.73% > 50.00% for > 20s with reclaim activity
```

[2]

I have no idea what went wrong. 0a78a376ef3c (the last merge before the
one with this series) was fine, but c6ea70604249 (which afaics basically
is the next commit if I understand things right) was not. I tried
reverting it, which should give me the merge base (v6.0-rc2), but it was
broken, too. I guess I must have done something wrong, but I have no
idea what, but I tried again and got the same result. :-/

/me must be missing something and/or not understand git properly...


> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: David Sterba <dsterba@suse.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  fs/btrfs/compression.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index e84d22c5c6a83..370788b9b1249 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -15,6 +15,7 @@
>  #include <linux/string.h>
>  #include <linux/backing-dev.h>
>  #include <linux/writeback.h>
> +#include <linux/psi.h>
>  #include <linux/slab.h>
>  #include <linux/sched/mm.h>
>  #include <linux/log2.h>
> @@ -519,7 +520,8 @@ static u64 bio_end_offset(struct bio *bio)
>   */
>  static noinline int add_ra_bio_pages(struct inode *inode,
>  				     u64 compressed_end,
> -				     struct compressed_bio *cb)
> +				     struct compressed_bio *cb,
> +				     unsigned long *pflags)
>  {
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	unsigned long end_index;
> @@ -588,6 +590,9 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>  			continue;
>  		}
>  
> +		if (PageWorkingset(page))
> +			psi_memstall_enter(pflags);
> +
>  		ret = set_page_extent_mapped(page);
>  		if (ret < 0) {
>  			unlock_page(page);
> @@ -674,6 +679,8 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  	u64 em_len;
>  	u64 em_start;
>  	struct extent_map *em;
> +	/* Initialize to 1 to make skip psi_memstall_leave unless needed */
> +	unsigned long pflags = 1;
>  	blk_status_t ret;
>  	int ret2;
>  	int i;
> @@ -729,7 +736,7 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  		goto fail;
>  	}
>  
> -	add_ra_bio_pages(inode, em_start + em_len, cb);
> +	add_ra_bio_pages(inode, em_start + em_len, cb, &pflags);
>  
>  	/* include any pages we added in add_ra-bio_pages */
>  	cb->len = bio->bi_iter.bi_size;
> @@ -810,6 +817,9 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  		}
>  	}
>  
> +	if (!pflags)
> +		psi_memstall_leave(&pflags);
> +
>  	if (refcount_dec_and_test(&cb->pending_ios))
>  		finish_compressed_bio_read(cb);
>  	return;
