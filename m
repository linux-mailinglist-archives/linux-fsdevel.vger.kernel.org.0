Return-Path: <linux-fsdevel+bounces-37973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 544829F997B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 19:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85FDC188F11F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 18:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC3521D596;
	Fri, 20 Dec 2024 18:22:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-08.prod.sxb1.secureserver.net (sxb1plsmtpa01-08.prod.sxb1.secureserver.net [188.121.53.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AC8218E9C
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734718941; cv=none; b=h/lSB5zlPpjZMVOYCRB2lE7q1RpuCwM14gx8/FPfQXfBf7T3H8u4aZaN/6LBS4YwnuPm9RBdHp2z+cZJKbVTHifDjPME8IMUqTC34uBT9eR6QF8Gbfgnglr4MpRjLgaVB5jccQsuAwYFjeoE/z2CdUIFQeMp7d+YU4ezxeuPyR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734718941; c=relaxed/simple;
	bh=84qzR7RkEhhKDvw3kmgoG5Fe2ljmqXGDo7uXITlyqMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSTagyj03BdSRuKa7BD/HQrjJB/JJF8xcSMjeayYH6KkgwGgKIVz+UYPKUeiduW8afTMWa/Li4sf0/vcRc8V0x8MmLskDQWZdeH4WEq9zaKwC2tycVqwRPW7HZ/FCguT98fu/tpYPeEJ6EPhRirJTCzMBZB03jougUzZZunp9CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.95] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id OhbFta1TmyBKyOhbGtaTPk; Fri, 20 Dec 2024 11:19:47 -0700
X-CMAE-Analysis: v=2.4 cv=WsXRMcfv c=1 sm=1 tr=0 ts=6765b544
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=JfrnYn6hAAAA:8 a=KZSWHz_UvdTQn7LSBjsA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <9365db29-dc4a-44a5-b90b-721a546d28c2@squashfs.org.uk>
Date: Fri, 20 Dec 2024 18:19:24 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] squashfs: Convert squashfs_fill_page() to take a
 folio
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
References: <20241216162701.57549-1-willy@infradead.org>
 <20241216162701.57549-5-willy@infradead.org>
Content-Language: en-US
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20241216162701.57549-5-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfP5Hw7OAKSLEaFNSz5E81TnkckOeHBP6RCYrHT8C11LW5dxVc64r8WB060ZejdMYmdqDJeBwiFA4C616zkLaVLY65LYIrxM04TWCJ9Y4zwHNOSOIsLfu
 19117VAHroY6uTjvAJSqmtpYppVb4rkog8JrDDNMlD2ZDoZE8PNIcehteKGyG/brx0IXxrKP3lMzZpOGb4XkDTjQEVEWlx3JRg5mrKpzHUtAkhtrxsdhCT6d
 9VZV7A9/ULaIKYspcNEhpmIl5DdpmwbKRzaHGC0mmo4CCdJ4UuTfNc2i6maBduyRn/m1ynVq2nR1aynLnUXc4bCoRKhLhKGqofRh734mXfw1i7V3MySjZWlD
 OfLrIsFw



On 16/12/2024 16:26, Matthew Wilcox (Oracle) wrote:
> squashfs_fill_page is only used in this file, so make it static.
> Use kmap_local instead of kmap_atomic, and return a bool so that
> the caller can use folio_end_read() which saves an atomic operation
> over calling folio_mark_uptodate() followed by folio_unlock().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Hi Matthew,

This patch causes 2 oops (VM_BUG_ON_FOLIO).

The cause and fix for the first oops follows (second oops in the next
email).

> ---
>   fs/squashfs/file.c     | 21 ++++++++++++---------
>   fs/squashfs/squashfs.h |  1 -
>   2 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index 1f27e8161319..d363fb26c2c8 100644
> --- a/fs/squashfs/file.c
> +++ b/fs/squashfs/file.c
> @@ -362,19 +362,21 @@ static int read_blocklist(struct inode *inode, int index, u64 *block)
>   	return squashfs_block_size(size);
>   }
>   
> -void squashfs_fill_page(struct page *page, struct squashfs_cache_entry *buffer, int offset, int avail)
> +static bool squashfs_fill_page(struct folio *folio,
> +		struct squashfs_cache_entry *buffer, size_t offset,
> +		size_t avail)
>   {
> -	int copied;
> +	size_t copied;
>   	void *pageaddr;
>   
> -	pageaddr = kmap_atomic(page);
> +	pageaddr = kmap_local_folio(folio, 0);
>   	copied = squashfs_copy_data(pageaddr, buffer, offset, avail);
>   	memset(pageaddr + copied, 0, PAGE_SIZE - copied);
> -	kunmap_atomic(pageaddr);
> +	kunmap_local(pageaddr);
>   
> -	flush_dcache_page(page);
> -	if (copied == avail)
> -		SetPageUptodate(page);
> +	flush_dcache_folio(folio);
> +
> +	return copied == avail;
>   }
>   
>   /* Copy data into page cache  */
> @@ -398,6 +400,7 @@ void squashfs_copy_cache(struct folio *folio,
>   			bytes -= PAGE_SIZE, offset += PAGE_SIZE) {
>   		struct folio *push_folio;
>   		size_t avail = buffer ? min(bytes, PAGE_SIZE) : 0;
> +		bool filled = false;
>   
>   		TRACE("bytes %zu, i %d, available_bytes %zu\n", bytes, i, avail);
>   
> @@ -412,9 +415,9 @@ void squashfs_copy_cache(struct folio *folio,
>   		if (folio_test_uptodate(push_folio))
>   			goto skip_folio;
>   
> -		squashfs_fill_page(&push_folio->page, buffer, offset, avail);
> +		filled = squashfs_fill_page(push_folio, buffer, offset, avail);
>   skip_folio:
> -		folio_unlock(push_folio);
> +		folio_end_read(folio, filled);

This should be

		folio_end_read(push_folio, filled)

Without this folio_end_read() is repeatedly called on folio,
generating the following oops

[  187.271288][ T8043] page: refcount:2 mapcount:0 mapping:ffff888116ae0798 index:0x100 pfn:0x1296c7
[  187.272129][ T8043] memcg:ffff8881016cc000
[  187.272458][ T8043] aops:squashfs_aops ino:1b dentry name(?):".tmp_vmlinux1"
[  187.273013][ T8043] flags: 0x4000000000000028(uptodate|lru|zone=2)
[  187.273500][ T8043] raw: 4000000000000028 ffffea0004655308 ffffea0004ac2e08 ffff888116ae0798
[  187.274160][ T8043] raw: 0000000000000100 0000000000000000 00000002ffffffff ffff8881016cc000
[  187.274809][ T8043] page dumped because: VM_BUG_ON_FOLIO(!folio_test_locked(folio))
[  187.275348][ T8043] page_owner tracks the page as allocated
[  187.275787][ T8043] page last allocated via order 0, migratetype Movable, gfp_mask 0x152c4a(GFP_N0
[  187.277262][ T8043]  post_alloc_hook+0x2d0/0x350
[  187.277586][ T8043]  get_page_from_freelist+0xb39/0x22a0
[  187.277941][ T8043]  __alloc_pages_noprof+0x1bc/0x480
[  187.278279][ T8043]  __folio_alloc_noprof+0x11/0x90
[  187.278600][ T8043]  page_cache_ra_unbounded+0x2e3/0x750
[  187.278939][ T8043]  page_cache_ra_order+0x8ef/0xc30
[  187.279252][ T8043]  page_cache_async_ra+0x5cb/0x820
[  187.279567][ T8043]  filemap_get_pages+0x105b/0x1bd0
[  187.279880][ T8043]  filemap_read+0x3b6/0xd50
[  187.280157][ T8043]  generic_file_read_iter+0x344/0x450
[  187.280481][ T8043]  __kernel_read+0x3b5/0xb10
[  187.280774][ T8043]  integrity_kernel_read+0x7f/0xb0
[  187.281091][ T8043]  ima_calc_file_hash_tfm+0x2bc/0x3d0
[  187.281425][ T8043]  ima_calc_file_hash+0x1ba/0x490
[  187.281756][ T8043]  ima_collect_measurement+0x848/0x9d0
[  187.282088][ T8043]  process_measurement+0x126b/0x2390
[  187.282409][ T8043] page last free pid 4949 tgid 4949 stack trace:
[  187.282788][ T8043]  free_unref_folios+0x8ea/0x13e0
[  187.283095][ T8043]  folios_put_refs+0x589/0x7b0
[  187.283386][ T8043]  free_pages_and_swap_cache+0x23d/0x490
[  187.283727][ T8043]  __tlb_batch_free_encoded_pages+0xf9/0x290
[  187.284115][ T8043]  tlb_finish_mmu+0x168/0x7b0
[  187.284438][ T8043]  vms_clear_ptes.part.0+0x4b7/0x690
[  187.284853][ T8043]  vms_complete_munmap_vmas+0x6c3/0x9e0
[  187.285276][ T8043]  do_vmi_align_munmap+0x600/0x870
[  187.285679][ T8043]  __do_sys_brk+0x888/0xa50
[  187.286001][ T8043]  do_syscall_64+0x74/0x1c0
[  187.286325][ T8043]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  187.286768][ T8043] ------------[ cut here ]------------
[  187.287114][ T8043] kernel BUG at mm/filemap.c:1534!
[  187.287464][ T8043] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
[  187.287979][ T8043] CPU: 13 UID: 0 PID: 8043 Comm: wc Not tainted 6.13.0-rc2-00368-g673506e97177 5
[  187.288717][ T8043] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.24
[  187.289495][ T8043] RIP: 0010:folio_end_read+0x165/0x1a0
[  187.289910][ T8043] Code: 89 ef 31 f6 e8 1c c6 ff ff 5b 5d 41 5c 41 5d 41 5e e9 1f 62 ca ff e8 1a0
[  187.291452][ T8043] RSP: 0018:ffffc9000a0cea00 EFLAGS: 00010293
[  187.291867][ T8043] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc9000a0ce8a8
[  187.292442][ T8043] RDX: ffff888118375880 RSI: ffffffff81cd65a5 RDI: ffff888118375cc4
[  187.293006][ T8043] RBP: ffffea0004a5b1c0 R08: 0000000000000000 R09: fffffbfff1efaefa
[  187.293632][ T8043] R10: ffffffff8f7d77d7 R11: 0000000000000001 R12: 0000000000000001
[  187.294228][ T8043] R13: 0000000000000001 R14: 0000000000000101 R15: ffffea0004a5b1c0
[  187.294808][ T8043] FS:  00007f2509ad0700(0000) GS:ffff888159480000(0000) knlGS:0000000000000000
[  187.295485][ T8043] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  187.295993][ T8043] CR2: 00007fff92c60000 CR3: 0000000124c28000 CR4: 00000000003506f0
[  187.296600][ T8043] Call Trace:
[  187.296837][ T8043]  <TASK>
[  187.297052][ T8043]  ? die+0x31/0x80
[  187.297332][ T8043]  ? do_trap+0x232/0x430
[  187.297668][ T8043]  ? folio_end_read+0x165/0x1a0
[  187.298045][ T8043]  ? folio_end_read+0x165/0x1a0
[  187.298414][ T8043]  ? do_error_trap+0xf4/0x230
[  187.298741][ T8043]  ? folio_end_read+0x165/0x1a0
[  187.299130][ T8043]  ? handle_invalid_op+0x34/0x40
[  187.299442][ T8043]  ? folio_end_read+0x165/0x1a0
[  187.299748][ T8043]  ? exc_invalid_op+0x2d/0x40
[  187.300104][ T8043]  ? asm_exc_invalid_op+0x1a/0x20
[  187.300487][ T8043]  ? folio_end_read+0x165/0x1a0
[  187.300821][ T8043]  ? folio_end_read+0x165/0x1a0
[  187.301164][ T8043]  squashfs_copy_cache+0x1d4/0x540
[  187.301532][ T8043]  squashfs_read_folio+0xa13/0xc00
[  187.301869][ T8043]  ? __pfx_squashfs_read_folio+0x10/0x10
[  187.302219][ T8043]  ? __pfx_squashfs_read_folio+0x10/0x10
[  187.302566][ T8043]  filemap_read_folio+0xc0/0x2a0
[  187.302886][ T8043]  ? __pfx_filemap_read_folio+0x10/0x10
[  187.303257][ T8043]  ? page_cache_async_ra+0x5cb/0x820
[  187.303624][ T8043]  filemap_get_pages+0x155c/0x1bd0
[  187.303968][ T8043]  ? __pfx_make_vfsgid+0x10/0x10
[  187.304279][ T8043]  ? __pfx_filemap_get_pages+0x10/0x10
[  187.304626][ T8043]  filemap_read+0x3b6/0xd50
[  187.304944][ T8043]  ? __pfx_filemap_read+0x10/0x10
[  187.305280][ T8043]  ? kernel_text_address+0x8d/0x100
[  187.305643][ T8043]  ? pvh_start_xen+0x1/0x108
[  187.305964][ T8043]  ? __kernel_text_address+0xd/0x40
[  187.306309][ T8043]  ? unwind_get_return_address+0x59/0xa0
[  187.306697][ T8043]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[  187.307104][ T8043]  ? arch_stack_walk+0x9d/0xf0
[  187.307413][ T8043]  ? stack_trace_save+0x95/0xd0
[  187.307737][ T8043]  ? __pfx_stack_trace_save+0x10/0x10
[  187.308133][ T8043]  ? stack_depot_save_flags+0x28/0x9d0
[  187.308652][ T8043]  generic_file_read_iter+0x344/0x450
[  187.309054][ T8043]  __kernel_read+0x3b5/0xb10
[  187.309430][ T8043]  ? __pfx___kernel_read+0x10/0x10
[  187.309855][ T8043]  integrity_kernel_read+0x7f/0xb0
[  187.310279][ T8043]  ? __pfx_integrity_kernel_read+0x10/0x10
[  187.310737][ T8043]  ? _sha256_update+0x93/0x220
[  187.311140][ T8043]  ? __pfx_sha256_transform_rorx+0x10/0x10
[  187.311579][ T8043]  ? kasan_save_track+0x14/0x30
[  187.311956][ T8043]  ima_calc_file_hash_tfm+0x2bc/0x3d0
[  187.312362][ T8043]  ? __pfx_ima_calc_file_hash_tfm+0x10/0x10
[  187.312780][ T8043]  ? squashfs_xattr_handler_get+0x522/0x6c0
[  187.313171][ T8043]  ? vfs_getxattr_alloc+0x1b9/0x340
[  187.313541][ T8043]  ? ima_read_xattr+0x38/0x60
[  187.313868][ T8043]  ? process_measurement+0x11e2/0x2390
[  187.314237][ T8043]  ? ima_file_check+0xb4/0x100
[  187.314556][ T8043]  ? security_file_post_open+0x8e/0x210
[  187.314933][ T8043]  ? path_openat+0x13f9/0x2d50
[  187.315261][ T8043]  ? mark_lock+0x101/0x1780
[  187.315558][ T8043]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  187.315949][ T8043]  ? mark_held_locks+0x9f/0xe0
[  187.316266][ T8043]  ? __pfx_mark_lock+0x10/0x10
[  187.316590][ T8043]  ? lockdep_hardirqs_on+0x7c/0x100
[  187.317283][ T8043]  ? _raw_spin_unlock_irqrestore+0x3b/0x80
[  187.317722][ T8043]  ? debug_check_no_obj_freed+0x2eb/0x5c0
[  187.318090][ T8043]  ? make_vfsgid+0xf2/0x140
[  187.318389][ T8043]  ? __pfx_make_vfsgid+0x10/0x10
[  187.318719][ T8043]  ? __pfx_debug_check_no_obj_freed+0x10/0x10
[  187.319113][ T8043]  ? ima_alloc_tfm+0x21d/0x2d0
[  187.319430][ T8043]  ? generic_fillattr+0x6bf/0x940
[  187.319762][ T8043]  ima_calc_file_hash+0x1ba/0x490
[  187.320096][ T8043]  ima_collect_measurement+0x848/0x9d0
[  187.320459][ T8043]  ? __pfx_ima_collect_measurement+0x10/0x10
[  187.320855][ T8043]  ? squashfs_xattr_handler_get+0x527/0x6c0
[  187.321253][ T8043]  ? process_measurement+0x86d/0x2390
[  187.321630][ T8043]  ? find_held_lock+0x2d/0x110
[  187.321973][ T8043]  ? xattr_resolve_name+0x27b/0x3f0
[  187.322333][ T8043]  ? __pfx_squashfs_xattr_handler_get+0x10/0x10
[  187.322762][ T8043]  ? vfs_getxattr_alloc+0xf1/0x340
[  187.323118][ T8043]  ? ima_get_hash_algo+0x27d/0x410
[  187.323474][ T8043]  ? __pfx_ima_get_hash_algo+0x10/0x10
[  187.323895][ T8043]  ? process_measurement+0x126b/0x2390
[  187.324268][ T8043]  process_measurement+0x126b/0x2390
[  187.324661][ T8043]  ? __pfx_process_measurement+0x10/0x10
[  187.325046][ T8043]  ? tomoyo_check_open_permission+0x1f0/0x3a0
[  187.325463][ T8043]  ? __pfx_smack_log+0x10/0x10
[  187.325796][ T8043]  ? smk_access+0x39a/0x5e0
[  187.326105][ T8043]  ? smk_tskacc+0x340/0x430
[  187.326409][ T8043]  ? smack_file_open+0x1c1/0x250
[  187.326741][ T8043]  ? __pfx_smack_file_open+0x10/0x10
[  187.327087][ T8043]  ? inode_to_bdi+0x9e/0x160
[  187.327389][ T8043]  ima_file_check+0xb4/0x100
[  187.327687][ T8043]  ? __pfx_ima_file_check+0x10/0x10
[  187.328056][ T8043]  security_file_post_open+0x8e/0x210
[  187.328427][ T8043]  path_openat+0x13f9/0x2d50
[  187.328740][ T8043]  ? __pfx_path_openat+0x10/0x10
[  187.329057][ T8043]  ? __pfx___lock_acquire+0x10/0x10
[  187.329402][ T8043]  ? lock_acquire+0x1b1/0x550
[  187.329732][ T8043]  ? find_held_lock+0x2d/0x110
[  187.330052][ T8043]  do_filp_open+0x1f8/0x460
[  187.330343][ T8043]  ? __pfx_do_filp_open+0x10/0x10
[  187.330666][ T8043]  ? find_held_lock+0x2d/0x110
[  187.330979][ T8043]  ? do_raw_spin_lock+0x12d/0x2b0
[  187.331318][ T8043]  ? __pfx_do_raw_spin_lock+0x10/0x10
[  187.331661][ T8043]  ? __phys_addr_symbol+0x30/0x70
[  187.331999][ T8043]  ? __check_object_size+0x4f7/0x7d0
[  187.332349][ T8043]  ? _raw_spin_unlock+0x28/0x50
[  187.332662][ T8043]  ? alloc_fd+0x41f/0x760
[  187.332963][ T8043]  do_sys_openat2+0x160/0x1c0
[  187.333296][ T8043]  ? __pfx_do_sys_openat2+0x10/0x10
[  187.333655][ T8043]  ? kmem_cache_free+0x39e/0x5b0
[  187.333979][ T8043]  ? security_file_free+0xb9/0x180
[  187.334304][ T8043]  ? __fput+0x686/0xb60
[  187.334561][ T8043]  __x64_sys_open+0x154/0x1e0
[  187.334855][ T8043]  ? __pfx___x64_sys_open+0x10/0x10
[  187.335209][ T8043]  do_syscall_64+0x74/0x1c0
[  187.335503][ T8043]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  187.335882][ T8043] RIP: 0033:0x7f25094db960
[  187.336176][ T8043] Code: 48 8b 15 2b 95 2c 00 f7 d8 64 89 02 48 83 c8 ff c3 66 0f 1f 84 00 00 004
[  187.337420][ T8043] RSP: 002b:00007fff92c63888 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
[  187.337967][ T8043] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f25094db960
[  187.338505][ T8043] RDX: 00007f2509a74e50 RSI: 0000000000000000 RDI: 00007fff92c6a173
[  187.339015][ T8043] RBP: 00007fff92c6a173 R08: 6f2e736d79736c6c R09: 00007f250944b99a
[  187.339511][ T8043] R10: 00007f25097a46a0 R11: 0000000000000246 R12: 00007f2509a74e50
[  187.340044][ T8043] R13: 0000000000000993 R14: 0000000000000001 R15: 00007fff92c6a173
[  187.340523][ T8043]  </TASK>
[  187.340707][ T8043] Modules linked in:
[  187.340976][ T8043] ---[ end trace 0000000000000000 ]---
[  187.341417][ T8043] RIP: 0010:folio_end_read+0x165/0x1a0
[  187.341807][ T8043] Code: 89 ef 31 f6 e8 1c c6 ff ff 5b 5d 41 5c 41 5d 41 5e e9 1f 62 ca ff e8 1a0
[  187.343080][ T8043] RSP: 0018:ffffc9000a0cea00 EFLAGS: 00010293
[  187.343461][ T8043] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc9000a0ce8a8
[  187.343989][ T8043] RDX: ffff888118375880 RSI: ffffffff81cd65a5 RDI: ffff888118375cc4
[  187.344527][ T8043] RBP: ffffea0004a5b1c0 R08: 0000000000000000 R09: fffffbfff1efaefa
[  187.345049][ T8043] R10: ffffffff8f7d77d7 R11: 0000000000000001 R12: 0000000000000001
[  187.345598][ T8043] R13: 0000000000000001 R14: 0000000000000101 R15: ffffea0004a5b1c0
[  187.346144][ T8043] FS:  00007f2509ad0700(0000) GS:ffff888159480000(0000) knlGS:0000000000000000
[  187.346802][ T8043] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  187.347288][ T8043] CR2: 00007fff92c60000 CR3: 0000000124c28000 CR4: 00000000003506f0
[  187.347888][ T8043] Kernel panic - not syncing: Fatal exception
[  187.348594][ T8043] Kernel Offset: disabled
[  187.348906][ T8043] Rebooting in 86400 seconds..

