Return-Path: <linux-fsdevel+bounces-38255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0183F9FE18D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 02:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8A01881BE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 01:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBD617588;
	Mon, 30 Dec 2024 01:05:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-15.prod.sxb1.secureserver.net (sxb1plsmtpa01-15.prod.sxb1.secureserver.net [188.121.53.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08DC2F44
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Dec 2024 01:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735520707; cv=none; b=i/YWvIDlz7EMzGF7/WeAhjQB10eDgzG2hp4rYnrFaJzrnVeIHNBlIf/Z8kGNFs2PANvjTZLDmpfdW0KFl03WGb0mx6ShENzVqTrhHTrX0OAhiRqoFleLkyLcy4BQSKff0qbWf/7Te0pVSKzUu2FJksY/io/gfHBqh+Z7/XXO4D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735520707; c=relaxed/simple;
	bh=kjk/XwoczUUIrEYkmHqIr0r6vMr2QyNuRcUPCGvOmLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nnMqxqhs6da2trAqMqGyxiQrNpIw84JLNDt9N/FxVT5GfG2JbbVUzvoL2EadebYH/DWTMXM3338XM0CSHDbotNVwa7l4RnOGJNKx6gD/eKvmwro5CMQMIyrH+tk5CAFB3R7UKZ6oIsch8wgyfeFM0YDB2C1Sq9WGzPyQ/7KWthI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.95] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id S3urtTXXbQu8YS3uttTB9d; Sun, 29 Dec 2024 17:45:55 -0700
X-CMAE-Analysis: v=2.4 cv=Z6sWHGRA c=1 sm=1 tr=0 ts=6771ed44
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=JfrnYn6hAAAA:8 a=DKPZApLZDqOHnsDQJW4A:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <c37bc614-2656-44c4-9aed-c30fe6438677@squashfs.org.uk>
Date: Mon, 30 Dec 2024 00:45:00 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] squashfs: Convert squashfs_fill_page() to take a
 folio
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
References: <20241220224634.723899-1-willy@infradead.org>
 <20241220224634.723899-5-willy@infradead.org>
Content-Language: en-US
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20241220224634.723899-5-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFmR2wxqMk7KT+0R6tapvjQD5APCbUzx3Slc+UyKE4yrfogspIaVEtJd6q1HGael7eKsJwBcpMkE7A6qt37rKNBpvzJoWVmS3kMMHRQDE8xsX3CnHEO3
 vr9BF6ANy4jp1jZ5viAtFZs3FzIVqJjYKu2c2AIPvXo/qlUGSTetqdKiVXcxAoO3+qtW+GuAhiu7RjV+PX+Zle0BA/dLUC115kwkR5Dw9L2TuhUne68RecUe
 aNEt9vecn7POtgNncRt/Ax9sPH+RydGF5qmaAoLD7yw=



On 12/20/24 22:46, Matthew Wilcox (Oracle) wrote:
> squashfs_fill_page is only used in this file, so make it static.
> Use kmap_local instead of kmap_atomic, and return a bool so that
> the caller can use folio_end_read() which saves an atomic operation
> over calling folio_mark_uptodate() followed by folio_unlock().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   fs/squashfs/file.c     | 21 ++++++++++++---------
>   fs/squashfs/squashfs.h |  1 -
>   2 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index 1f27e8161319..da25d6fa45ce 100644
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
> +		bool uptodate = true;
>   
>   		TRACE("bytes %zu, i %d, available_bytes %zu\n", bytes, i, avail);
>   
> @@ -412,9 +415,9 @@ void squashfs_copy_cache(struct folio *folio,
>   		if (folio_test_uptodate(push_folio))
>   			goto skip_folio;
>   
> -		squashfs_fill_page(&push_folio->page, buffer, offset, avail);
> +		uptodate = squashfs_fill_page(push_folio, buffer, offset, avail);
>   skip_folio:
> -		folio_unlock(push_folio);
> +		folio_end_read(push_folio, uptodate);

Hi Matthew,

I'm still getting an oops with this (V2) patch.  The same as before, which is an
assert in folio_end_read() triggers.

Looking at the code in folio_end_read(), the assert appears to happen irrespective
of the value of success.

void folio_end_read(struct folio *folio, bool success)
{
	unsigned long mask = 1 << PG_locked;

	/* Must be in bottom byte for x86 to work */
	BUILD_BUG_ON(PG_uptodate > 7);
	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
	VM_BUG_ON_FOLIO(folio_test_uptodate(folio), folio);

	if (likely(success))
		mask |= 1 << PG_uptodate;
	if (folio_xor_flags_has_waiters(folio, mask))
		folio_wake_bit(folio, PG_locked);
}
EXPORT_SYMBOL(folio_end_read);

Thanks

Phillip

The oops is

[  977.270664][ T7696] page: refcount:2 mapcount:0 mapping:ffff8880114c1c98 index:0x100 pfn:0x2022c
[  977.271277][ T7696] memcg:ffff8880162c4000
[  977.271501][ T7696] aops:squashfs_aops ino:1f dentry name(?):".tmp_vmlinux2"
[  977.271941][ T7696] flags: 0x200000000000012d(locked|referenced|uptodate|lru|active|zone=1)
[  977.272375][ T7696] raw: 200000000000012d ffffea0000aeaf08 ffffea00009ae388 ffff8880114c1c98
[  977.272796][ T7696] raw: 0000000000000100 0000000000000000 00000002ffffffff ffff8880162c4000
[  977.273215][ T7696] page dumped because: VM_BUG_ON_FOLIO(folio_test_uptodate(folio))
[  977.273600][ T7696] page_owner tracks the page as allocated
[  977.273916][ T7696] page last allocated via order 0, migratetype Movable, gfp_mask 0x152c4a(GFP_NOFS|__GFP_HIGH0
[  977.274987][ T7696]  post_alloc_hook+0x2d0/0x350
[  977.275233][ T7696]  get_page_from_freelist+0xb39/0x22a0
[  977.275512][ T7696]  __alloc_pages_slowpath.constprop.0+0x2ff/0x2650
[  977.275872][ T7696]  __alloc_pages_noprof+0x3e6/0x480
[  977.276139][ T7696]  __folio_alloc_noprof+0x11/0x90
[  977.276392][ T7696]  page_cache_ra_unbounded+0x2e3/0x750
[  977.276779][ T7696]  page_cache_ra_order+0x8ef/0xc30
[  977.277057][ T7696]  page_cache_async_ra+0x5cb/0x820
[  977.277530][ T7696]  filemap_get_pages+0x105b/0x1bd0
[  977.277827][ T7696]  filemap_read+0x3b6/0xd50
[  977.278058][ T7696]  generic_file_read_iter+0x344/0x450
[  977.278323][ T7696]  __kernel_read+0x3b5/0xb10
[  977.278581][ T7696]  integrity_kernel_read+0x7f/0xb0
[  977.278844][ T7696]  ima_calc_file_hash_tfm+0x2bc/0x3d0
[  977.279131][ T7696]  ima_calc_file_hash+0x1ba/0x490
[  977.279415][ T7696]  ima_collect_measurement+0x848/0x9d0
[  977.279721][ T7696] page last free pid 7695 tgid 7695 stack trace:
[  977.280101][ T7696]  free_unref_page+0x619/0x10e0
[  977.280363][ T7696]  __folio_put+0x31d/0x440
[  977.280603][ T7696]  put_page+0x21d/0x280
[  977.280875][ T7696]  anon_pipe_buf_release+0x11a/0x240
[  977.281171][ T7696]  pipe_read+0x635/0x13b0
[  977.281447][ T7696]  vfs_read+0xa0c/0xba0
[  977.281761][ T7696]  ksys_read+0x1fe/0x240
[  977.282045][ T7696]  do_syscall_64+0x74/0x1c0
[  977.282314][ T7696]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  977.282679][ T7696] ------------[ cut here ]------------
[  977.283000][ T7696] kernel BUG at mm/filemap.c:1535!
[  977.283313][ T7696] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
[  977.283939][ T7696] CPU: 4 UID: 0 PID: 7696 Comm: cat Not tainted 6.13.0-rc2-00367-gbfe147475f84 #24
[  977.284605][ T7696] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  977.285195][ T7696] RIP: 0010:folio_end_read+0x17b/0x1a0
[  977.285517][ T7696] Code: e8 1a 62 ca ff 48 c7 c6 60 17 d8 8a 48 89 ef e8 2b d2 0e 00 0f 0b e8 04 62 ca ff 48 c8
[  977.287017][ T7696] RSP: 0018:ffffc90007aa7710 EFLAGS: 00010293
[  977.287424][ T7696] RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffc90007aa75b8
[  977.287897][ T7696] RDX: ffff888026320000 RSI: ffffffff81cd65bb RDI: ffff888026320444
[  977.288356][ T7696] RBP: ffffea0000808b00 R08: 0000000000000000 R09: fffffbfff1efaf3a
[  977.288781][ T7696] R10: ffffffff8f7d79d7 R11: 0000000000000001 R12: 0000000000000001
[  977.289166][ T7696] R13: 0000000000000001 R14: 0000000000000001 R15: ffffea0000ac3440
[  977.289550][ T7696] FS:  00007f7d03bb7700(0000) GS:ffff88802da00000(0000) knlGS:0000000000000000
[  977.289982][ T7696] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  977.290304][ T7696] CR2: 00007f833c9a6c68 CR3: 0000000011584000 CR4: 00000000003506f0
[  977.290688][ T7696] Call Trace:
[  977.290852][ T7696]  <TASK>
[  977.290999][ T7696]  ? die+0x31/0x80
[  977.291190][ T7696]  ? do_trap+0x232/0x430
[  977.291400][ T7696]  ? folio_end_read+0x17b/0x1a0
[  977.291644][ T7696]  ? folio_end_read+0x17b/0x1a0
[  977.291912][ T7696]  ? do_error_trap+0xf4/0x230
[  977.292172][ T7696]  ? folio_end_read+0x17b/0x1a0
[  977.292415][ T7696]  ? handle_invalid_op+0x34/0x40
[  977.292660][ T7696]  ? folio_end_read+0x17b/0x1a0
[  977.292904][ T7696]  ? exc_invalid_op+0x2d/0x40
[  977.293140][ T7696]  ? asm_exc_invalid_op+0x1a/0x20
[  977.293392][ T7696]  ? folio_end_read+0x17b/0x1a0
[  977.293635][ T7696]  ? folio_end_read+0x17b/0x1a0
[  977.293882][ T7696]  squashfs_copy_cache+0x1d7/0x550
[  977.294174][ T7696]  squashfs_read_folio+0xa13/0xc00
[  977.294483][ T7696]  ? __pfx_squashfs_read_folio+0x10/0x10
[  977.294811][ T7696]  ? __pfx_squashfs_read_folio+0x10/0x10
[  977.295154][ T7696]  filemap_read_folio+0xc0/0x2a0
[  977.295457][ T7696]  ? __pfx_filemap_read_folio+0x10/0x10
[  977.295819][ T7696]  ? page_cache_sync_ra+0x4b4/0x9c0
[  977.296171][ T7696]  filemap_get_pages+0x155c/0x1bd0
[  977.296473][ T7696]  ? current_time+0x79/0x380
[  977.296744][ T7696]  ? __pfx_filemap_get_pages+0x10/0x10
[  977.297055][ T7696]  filemap_read+0x3b6/0xd50
[  977.297315][ T7696]  ? __pfx_filemap_read+0x10/0x10
[  977.297605][ T7696]  ? pipe_write+0xf9f/0x1ae0
[  977.297854][ T7696]  ? __pfx_pipe_write+0x10/0x10
[  977.298127][ T7696]  ? lock_acquire+0x1b1/0x550
[  977.298391][ T7696]  ? __pfx_autoremove_wake_function+0x10/0x10
[  977.298714][ T7696]  generic_file_read_iter+0x344/0x450
[  977.299008][ T7696]  ? rw_verify_area+0xd0/0x700
[  977.299283][ T7696]  vfs_read+0x83e/0xba0
[  977.299526][ T7696]  ? __pfx_vfs_read+0x10/0x10
[  977.299809][ T7696]  ? __pfx_generic_fadvise+0x10/0x10
[  977.300132][ T7696]  ksys_read+0x122/0x240
[  977.300361][ T7696]  ? __pfx_ksys_read+0x10/0x10
[  977.300630][ T7696]  do_syscall_64+0x74/0x1c0
[  977.300859][ T7696]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  977.301152][ T7696] RIP: 0033:0x7f7d034dbba0
[  977.301372][ T7696] Code: 0b 31 c0 48 83 c4 08 e9 be fe ff ff 48 8d 3d 3f f0 08 00 e8 e2 ce 01 00 66 90 83 3d 34
[  977.302300][ T7696] RSP: 002b:00007fffbb0b34a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[  977.302705][ T7696] RAX: ffffffffffffffda RBX: 0000000000008000 RCX: 00007f7d034dbba0
[  977.303088][ T7696] RDX: 0000000000008000 RSI: 0000000031e9c000 RDI: 0000000000000003
[  977.303473][ T7696] RBP: 0000000000008000 R08: 0000000000000003 R09: 00007f7d0344b99a
[  977.303874][ T7696] R10: 0000000000000002 R11: 0000000000000246 R12: 0000000031e9c000
[  977.304283][ T7696] R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000008000
[  977.304675][ T7696]  </TASK>
[  977.304827][ T7696] Modules linked in:
[  977.305052][ T7696] ---[ end trace 0000000000000000 ]---
[  977.305346][ T7696] RIP: 0010:folio_end_read+0x17b/0x1a0
[  977.305640][ T7696] Code: e8 1a 62 ca ff 48 c7 c6 60 17 d8 8a 48 89 ef e8 2b d2 0e 00 0f 0b e8 04 62 ca ff 48 c8
[  977.306747][ T7696] RSP: 0018:ffffc90007aa7710 EFLAGS: 00010293
[  977.307125][ T7696] RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffc90007aa75b8
[  977.307610][ T7696] RDX: ffff888026320000 RSI: ffffffff81cd65bb RDI: ffff888026320444
[  977.308117][ T7696] RBP: ffffea0000808b00 R08: 0000000000000000 R09: fffffbfff1efaf3a
[  977.308541][ T7696] R10: ffffffff8f7d79d7 R11: 0000000000000001 R12: 0000000000000001
[  977.308964][ T7696] R13: 0000000000000001 R14: 0000000000000001 R15: ffffea0000ac3440
[  977.309385][ T7696] FS:  00007f7d03bb7700(0000) GS:ffff88802da00000(0000) knlGS:0000000000000000
[  977.309842][ T7696] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  977.310165][ T7696] CR2: 00007f833c9a6c68 CR3: 0000000011584000 CR4: 00000000003506f0
[  977.310551][ T7696] Kernel panic - not syncing: Fatal exception
[  977.311300][ T7696] Kernel Offset: disabled
[  977.311520][ T7696] Rebooting in 86400 seconds..
  

