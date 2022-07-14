Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F2D5749B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 11:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237632AbiGNJwg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 05:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237757AbiGNJwX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:52:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC093ED51
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Jul 2022 02:52:21 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0FFBA1FA94;
        Thu, 14 Jul 2022 09:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657792340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JOs9ZtwM2YtCPQBcUyUgxS/wiPEcvMqmotjpx/qg8Rg=;
        b=FSvG9wcH7uz0PfKkC/O6kawmcQJz4VoXZQiHZuZQFyv+xCnvJwWg2lo4Y1gLoRvXhSlW3O
        H9IdtWFdmeTO5HLAVsOvk59cK9NXg7r/B9Arnv3Ls98PHsi3Q51gECaEpGRdCw6vBAlvYm
        P3Dk/P/bYEhGzm1HQOLvHhiVWTehzFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657792340;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JOs9ZtwM2YtCPQBcUyUgxS/wiPEcvMqmotjpx/qg8Rg=;
        b=bSnqUkT8QsLxiAHZvj3wolK7GUpLgDOxo6jnaKUhcJZt7mVL6kBehPdBwy6AMn4IVlCOm+
        VnUsrx/Bz2ZH3mCw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 98F812C142;
        Thu, 14 Jul 2022 09:52:19 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4974FA0632; Thu, 14 Jul 2022 11:52:18 +0200 (CEST)
Date:   Thu, 14 Jul 2022 11:52:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Hillf Danton <hdanton@sina.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        syzbot+9bd2b7adbd34b30b87e4@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] secretmem: fix unhandled fault in truncate
Message-ID: <20220714095218.f77ezhbdxki3qunj@quack3>
References: <20220714091337.412297-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714091337.412297-1-rppt@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 14-07-22 12:13:37, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> syzkaller reports the following issue:
> 
> BUG: unable to handle page fault for address: ffff888021f7e005
> PGD 11401067 P4D 11401067 PUD 11402067 PMD 21f7d063 PTE 800fffffde081060
> Oops: 0002 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 3761 Comm: syz-executor281 Not tainted 5.19.0-rc4-syzkaller-00014-g941e3e791269 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:memset_erms+0x9/0x10 arch/x86/lib/memset_64.S:64
> Code: c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6 f3 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 <f3> aa 4c 89 c8 c3 90 49 89 fa 40 0f b6 ce 48 b8 01 01 01 01 01 01
> RSP: 0018:ffffc9000329fa90 EFLAGS: 00010202
> RAX: 0000000000000000 RBX: 0000000000001000 RCX: 0000000000000ffb
> RDX: 0000000000000ffb RSI: 0000000000000000 RDI: ffff888021f7e005
> RBP: ffffea000087df80 R08: 0000000000000001 R09: ffff888021f7e005
> R10: ffffed10043efdff R11: 0000000000000000 R12: 0000000000000005
> R13: 0000000000000000 R14: 0000000000001000 R15: 0000000000000ffb
> FS:  00007fb29d8b2700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff888021f7e005 CR3: 0000000026e7b000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  zero_user_segments include/linux/highmem.h:272 [inline]
>  folio_zero_range include/linux/highmem.h:428 [inline]
>  truncate_inode_partial_folio+0x76a/0xdf0 mm/truncate.c:237
>  truncate_inode_pages_range+0x83b/0x1530 mm/truncate.c:381
>  truncate_inode_pages mm/truncate.c:452 [inline]
>  truncate_pagecache+0x63/0x90 mm/truncate.c:753
>  simple_setattr+0xed/0x110 fs/libfs.c:535
>  secretmem_setattr+0xae/0xf0 mm/secretmem.c:170
>  notify_change+0xb8c/0x12b0 fs/attr.c:424
>  do_truncate+0x13c/0x200 fs/open.c:65
>  do_sys_ftruncate+0x536/0x730 fs/open.c:193
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7fb29d900899
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fb29d8b2318 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
> RAX: ffffffffffffffda RBX: 00007fb29d988408 RCX: 00007fb29d900899
> RDX: 00007fb29d900899 RSI: 0000000000000005 RDI: 0000000000000003
> RBP: 00007fb29d988400 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb29d98840c
> R13: 00007ffca01a23bf R14: 00007fb29d8b2400 R15: 0000000000022000
>  </TASK>
> Modules linked in:
> CR2: ffff888021f7e005
> ---[ end trace 0000000000000000 ]---
> 
> Eric Biggers suggested that this happens when
> secretmem_setattr()->simple_setattr() races with secretmem_fault() so
> that a page that is faulted in by secretmem_fault() (and thus removed
> from the direct map) is zeroed by inode truncation right afterwards.
> 
> Use an mapping->invalidate_lock to make secretmem_fault() and
> secretmem_setattr() mutually exclusive.
> 
> Reported-by: syzbot+9bd2b7adbd34b30b87e4@syzkaller.appspotmail.com
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v3: use invalidate_lock rather than inode_lock
> v2: use inode_lock_shared() rather than add a new rw_sem to secretmem
> 
>  mm/secretmem.c | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 206ed6b40c1d..f06279d6190a 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -55,22 +55,28 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
>  	gfp_t gfp = vmf->gfp_mask;
>  	unsigned long addr;
>  	struct page *page;
> +	vm_fault_t ret;
>  	int err;
>  
>  	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
>  		return vmf_error(-EINVAL);
>  
> +	filemap_invalidate_lock_shared(mapping);
> +
>  retry:
>  	page = find_lock_page(mapping, offset);
>  	if (!page) {
>  		page = alloc_page(gfp | __GFP_ZERO);
> -		if (!page)
> -			return VM_FAULT_OOM;
> +		if (!page) {
> +			ret = VM_FAULT_OOM;
> +			goto out;
> +		}
>  
>  		err = set_direct_map_invalid_noflush(page);
>  		if (err) {
>  			put_page(page);
> -			return vmf_error(err);
> +			ret = vmf_error(err);
> +			goto out;
>  		}
>  
>  		__SetPageUptodate(page);
> @@ -86,7 +92,8 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
>  			if (err == -EEXIST)
>  				goto retry;
>  
> -			return vmf_error(err);
> +			ret = vmf_error(err);
> +			goto out;
>  		}
>  
>  		addr = (unsigned long)page_address(page);
> @@ -94,7 +101,11 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
>  	}
>  
>  	vmf->page = page;
> -	return VM_FAULT_LOCKED;
> +	ret = VM_FAULT_LOCKED;
> +
> +out:
> +	filemap_invalidate_unlock_shared(mapping);
> +	return ret;
>  }
>  
>  static const struct vm_operations_struct secretmem_vm_ops = {
> @@ -162,12 +173,20 @@ static int secretmem_setattr(struct user_namespace *mnt_userns,
>  			     struct dentry *dentry, struct iattr *iattr)
>  {
>  	struct inode *inode = d_inode(dentry);
> +	struct address_space *mapping = inode->i_mapping;
>  	unsigned int ia_valid = iattr->ia_valid;
> +	int ret;
> +
> +	filemap_invalidate_lock(mapping);
>  
>  	if ((ia_valid & ATTR_SIZE) && inode->i_size)
> -		return -EINVAL;
> +		ret = -EINVAL;
> +	else
> +		ret = simple_setattr(mnt_userns, dentry, iattr);
>  
> -	return simple_setattr(mnt_userns, dentry, iattr);
> +	filemap_invalidate_unlock(mapping);
> +
> +	return ret;
>  }
>  
>  static const struct inode_operations secretmem_iops = {
> 
> base-commit: 03c765b0e3b4cb5063276b086c76f7a612856a9a
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
