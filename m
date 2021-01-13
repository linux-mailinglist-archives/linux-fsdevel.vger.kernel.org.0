Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6C92F5158
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 18:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbhAMRpU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 12:45:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:49484 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbhAMRpS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:45:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 322D5AB92;
        Wed, 13 Jan 2021 17:44:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 490731E083D; Wed, 13 Jan 2021 18:44:32 +0100 (CET)
Date:   Wed, 13 Jan 2021 18:44:32 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhengyuan Liu <liuzhengyuan@tj.kylinos.cn>
Cc:     jack@suse.com, linux-fsdevel@vger.kernel.org,
        liuzhengyuang521@gmail.com
Subject: Re: [PATCH] fs/quota: fix the mismatch of data type
Message-ID: <20210113174432.GH6854@quack2.suse.cz>
References: <20210111043541.11622-1-liuzhengyuan@tj.kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111043541.11622-1-liuzhengyuan@tj.kylinos.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 11-01-21 12:35:41, Zhengyuan Liu wrote:
> From: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
> 
> When doing fuzzing test to quota, an error occurred due to the
> mismatch of data type:
> 
>     Quota error (device loop0): qtree_write_dquot: Error -1244987383 occurred while creating quota
>     Unable to handle kernel paging request at virtual address ffffffffb5cb0071
>     Mem abort info:
>       ESR = 0x96000006
>       EC = 0x25: DABT (current EL), IL = 32 bits
>       SET = 0, FnV = 0
>       EA = 0, S1PTW = 0
>     Data abort info:
>       ISV = 0, ISS = 0x00000006
>       CM = 0, WnR = 0
>     swapper pgtable: 64k pages, 48-bit VAs, pgdp=0000000023980000
>     [ffffffffb5cb0071] pgd=00000000243f0003, p4d=00000000243f0003, pud=00000000243f0003, pmd=0000000000000000
>     Internal error: Oops: 96000006 [#1] SMP
>     Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nftn
>     CPU: 1 PID: 1256 Comm: a.out Not tainted 5.10.0 #31
>     Hardware name: XXXX XXXX/Kunpeng Desktop Board D920L11K, BIOS 0.23 07/22/2020
>     pstate: 00400009 (nzcv daif +PAN -UAO -TCO BTYPE=--)
>     pc : dquot_add_space+0x30/0x258
>     lr : __dquot_alloc_space+0x22c/0x358
>     sp : ffff80001c10f660
>     x29: ffff80001c10f660 x28: 0000000000000001
>     x27: 0000000000000000 x26: 0000000000000000
>     x25: ffff800011add9c8 x24: ffff0020a2110470
>     x23: 0000000000000400 x22: 0000000000000400
>     x21: 0000000000000000 x20: 0000000000000400
>     x19: ffffffffb5cb0009 x18: 0000000000000000
>     x17: 0000000000000020 x16: 0000000000000000
>     x15: 0000000000000010 x14: 65727471203a2930
>     x13: 706f6f6c20656369 x12: 0000000000000020
>     x11: 000000000000000a x10: 0000000000000400
>     x9 : ffff8000103afb5c x8 : 0000000800000000
>     x7 : 0000000000002000 x6 : 000000000000000f
>     x5 : ffffffffb5cb0009 x4 : ffff80001c10f728
>     x3 : 0000000000000001 x2 : 0000000000000000
>     x1 : 0000000000000400 x0 : ffffffffb5cb0009
>     Call trace:
>      dquot_add_space+0x30/0x258
>      __dquot_alloc_space+0x22c/0x358
>      ext4_mb_new_blocks+0x100/0xe88
>      ext4_new_meta_blocks+0xb4/0x110
>      ext4_xattr_block_set+0x4ec/0xce8
>      ext4_xattr_set_handle+0x400/0x528
>      ext4_xattr_set+0xc4/0x170
>      ext4_xattr_security_set+0x30/0x40
>      __vfs_setxattr+0x7c/0xa0
>      __vfs_setxattr_noperm+0x88/0x218
>      __vfs_setxattr_locked+0xf8/0x120
>      vfs_setxattr+0x6c/0x100
>      setxattr+0x148/0x240
>      path_setxattr+0xc4/0xd8
>      __arm64_sys_setxattr+0x2c/0x40
>      el0_svc_common.constprop.4+0x94/0x178
>      do_el0_svc+0x78/0x98
>      el0_svc+0x20/0x30
>      el0_sync_handler+0x90/0xb8
>      el0_sync+0x158/0x180
> 
> In this test case, the return value from get_free_dqblk() could be
> info->dqi_free_blk, which is defined as unsigned int, but we use
> type int in do_insert_tree to check the return value, and therefor we
> may get a negative duo to the transformation. This negative(as aboved
> said -1244987383) then can transmit to dquots in __dquot_initialize(),
> and once we access there can trigger above panic.
> 
> 	__dquot_initialize():
>                 dquot = dqget(sb, qid);
>                 if (IS_ERR(dquot)) {
>                         /* We raced with somebody turning quotas off... */
>                         if (PTR_ERR(dquot) != -ESRCH) {
>                                 ret = PTR_ERR(dquot);
>                                 goto out_put;
>                         }
>                         dquot = NULL;
>                 }
>                 got[cnt] = dquot;
> 
> Try to fix this problem by making the data type consistent. 
> 
> Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos.cn>

Hum, I think this problem has already been fixed by commits:

10f04d40a9f "quota: Don't overflow quota file offsets"

and

11c514a99bb "quota: Sanity-check quota file headers on load"

I'll try your reproducer...

								Honza

> ---
>  fs/quota/quota_tree.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/quota/quota_tree.c b/fs/quota/quota_tree.c
> index c5562c871c8b..f898a550a3ee 100644
> --- a/fs/quota/quota_tree.c
> +++ b/fs/quota/quota_tree.c
> @@ -81,11 +81,11 @@ static ssize_t write_blk(struct qtree_mem_dqinfo *info, uint blk, char *buf)
>  }
>  
>  /* Remove empty block from list and return it */
> -static int get_free_dqblk(struct qtree_mem_dqinfo *info)
> +static ssize_t get_free_dqblk(struct qtree_mem_dqinfo *info)
>  {
>  	char *buf = getdqbuf(info->dqi_usable_bs);
>  	struct qt_disk_dqdbheader *dh = (struct qt_disk_dqdbheader *)buf;
> -	int ret, blk;
> +	ssize_t ret, blk;
>  
>  	if (!buf)
>  		return -ENOMEM;
> @@ -295,11 +295,12 @@ static uint find_free_dqentry(struct qtree_mem_dqinfo *info,
>  }
>  
>  /* Insert reference to structure into the trie */
> -static int do_insert_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
> +static ssize_t do_insert_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
>  			  uint *treeblk, int depth)
>  {
>  	char *buf = getdqbuf(info->dqi_usable_bs);
> -	int ret = 0, newson = 0, newact = 0;
> +	int newson = 0, newact = 0;
> +	ssize_t ret = 0;
>  	__le32 *ref;
>  	uint newblk;
>  
> @@ -335,7 +336,7 @@ static int do_insert_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
>  			goto out_buf;
>  		}
>  #endif
> -		newblk = find_free_dqentry(info, dquot, &ret);
> +		newblk = find_free_dqentry(info, dquot, (int*)&ret);
>  	} else {
>  		ret = do_insert_tree(info, dquot, &newblk, depth+1);
>  	}
> @@ -352,7 +353,7 @@ static int do_insert_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
>  }
>  
>  /* Wrapper for inserting quota structure into tree */
> -static inline int dq_insert_tree(struct qtree_mem_dqinfo *info,
> +static inline ssize_t dq_insert_tree(struct qtree_mem_dqinfo *info,
>  				 struct dquot *dquot)
>  {
>  	int tmp = QT_TREEOFF;
> -- 
> 2.20.1
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
