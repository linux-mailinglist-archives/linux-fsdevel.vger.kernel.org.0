Return-Path: <linux-fsdevel+bounces-37496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3259F33E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 16:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBF9E167082
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 15:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D9213A868;
	Mon, 16 Dec 2024 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YOk37B3k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NGFewVIP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YOk37B3k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NGFewVIP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC8E3BBF2;
	Mon, 16 Dec 2024 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734361237; cv=none; b=FRGZcDPyx1I9IpHJrjtvs5GcRpTpcS+hRo9KpcxUrYdSUmKPv1pbHDnqyl8aZPdVezKhe/CcqWmztJxq+qw9TWyAB/3sXge6AHPpSH1atYu5HBcKkemN3l49yD2gcz2QJfcObX7dMBPK1dBUkU7R4BrboYrDs+NxsUNynYZwvGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734361237; c=relaxed/simple;
	bh=YEHWqrT+uZYlqdlBk0PzDL3D7jlQ5rNIQO9zbglVyEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBdYaQvek8TgnEn93LU0ZfiNnffWsuUIY8pKd2U747mc4ZwJf4vgU8026KY0JYDgE4rlE5bul6R/IoouM4xdes8yT1tnsLerbRnW8KOMHjz3ztMW32s9AekVSG4Wa7/MIrvvKxMvbnoRfHOHChjJMNsIPU+PzThTGheYKSuz8xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YOk37B3k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NGFewVIP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YOk37B3k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NGFewVIP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6BA471F381;
	Mon, 16 Dec 2024 15:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734361233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BqqkGynGnzixM/sZcOFGedWU3EXateIKh7Ij6iuN3jY=;
	b=YOk37B3koU3/uMTW2liGfH/IC1sJ5pCCf2lknxftFp74f+dvHSst2fZfqQUn4ESpVXOB6+
	QiyNU/61rJv5OrwpkUm1Hq8SMpSypmBDMfA3r1MgZU0G/8B+9VbHOKCGw+yCGydiVoL/LO
	s43MjQPFb5zhg3/DjocVQeJ9t75y19U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734361233;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BqqkGynGnzixM/sZcOFGedWU3EXateIKh7Ij6iuN3jY=;
	b=NGFewVIP62spqficD7pTbtRTjF3gLtIPo2xPFyaqWB9boKgk2KvNzlcfk/cNCQkXO4cUIe
	ruXLd5V9XU4nhQAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734361233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BqqkGynGnzixM/sZcOFGedWU3EXateIKh7Ij6iuN3jY=;
	b=YOk37B3koU3/uMTW2liGfH/IC1sJ5pCCf2lknxftFp74f+dvHSst2fZfqQUn4ESpVXOB6+
	QiyNU/61rJv5OrwpkUm1Hq8SMpSypmBDMfA3r1MgZU0G/8B+9VbHOKCGw+yCGydiVoL/LO
	s43MjQPFb5zhg3/DjocVQeJ9t75y19U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734361233;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BqqkGynGnzixM/sZcOFGedWU3EXateIKh7Ij6iuN3jY=;
	b=NGFewVIP62spqficD7pTbtRTjF3gLtIPo2xPFyaqWB9boKgk2KvNzlcfk/cNCQkXO4cUIe
	ruXLd5V9XU4nhQAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59481137CF;
	Mon, 16 Dec 2024 15:00:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KP3GFZFAYGfFdwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 16 Dec 2024 15:00:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 05B83A0935; Mon, 16 Dec 2024 16:00:28 +0100 (CET)
Date: Mon, 16 Dec 2024 16:00:28 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v4 01/10] ext4: remove writable userspace mappings before
 truncating page cache
Message-ID: <20241216150028.xq4qlr7xqjce34ey@quack3>
References: <20241216013915.3392419-1-yi.zhang@huaweicloud.com>
 <20241216013915.3392419-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216013915.3392419-2-yi.zhang@huaweicloud.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,huawei.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 16-12-24 09:39:06, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When zeroing a range of folios on the filesystem which block size is
> less than the page size, the file's mapped blocks within one page will
> be marked as unwritten, we should remove writable userspace mappings to
> ensure that ext4_page_mkwrite() can be called during subsequent write
> access to these partial folios. Otherwise, data written by subsequent
> mmap writes may not be saved to disk.
> 
>  $mkfs.ext4 -b 1024 /dev/vdb
>  $mount /dev/vdb /mnt
>  $xfs_io -t -f -c "pwrite -S 0x58 0 4096" -c "mmap -rw 0 4096" \
>                -c "mwrite -S 0x5a 2048 2048" -c "fzero 2048 2048" \
>                -c "mwrite -S 0x59 2048 2048" -c "close" /mnt/foo
> 
>  $od -Ax -t x1z /mnt/foo
>  000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
>  *
>  000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59
>  *
>  001000
> 
>  $umount /mnt && mount /dev/vdb /mnt
>  $od -Ax -t x1z /mnt/foo
>  000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
>  *
>  000800 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  *
>  001000
> 
> Fix this by introducing ext4_truncate_page_cache_block_range() to remove
> writable userspace mappings when truncating a partial folio range.
> Additionally, move the journal data mode-specific handlers and
> truncate_pagecache_range() into this function, allowing it to serve as a
> common helper that correctly manages the page cache in preparation for
> block range manipulations.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

I like the patch. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Just one thing occured to me when thinking about this: It seems like a
nasty catch that truncate_inode_pages_range() does not writeprotect these
partial pages because practically any filesystem supporting blocksize <
pagesize and doing anything non-trivial in ->page_mkwrite handler will need
this. So ultimately I think we might want to fix this in generic code but
ext4 solution is fine for now.

								Honza
> ---
>  fs/ext4/ext4.h    |  2 ++
>  fs/ext4/extents.c | 19 ++++-----------
>  fs/ext4/inode.c   | 62 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 69 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 74f2071189b2..8843929b46ce 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3016,6 +3016,8 @@ extern int ext4_inode_attach_jinode(struct inode *inode);
>  extern int ext4_can_truncate(struct inode *inode);
>  extern int ext4_truncate(struct inode *);
>  extern int ext4_break_layouts(struct inode *);
> +extern int ext4_truncate_page_cache_block_range(struct inode *inode,
> +						loff_t start, loff_t end);
>  extern int ext4_punch_hole(struct file *file, loff_t offset, loff_t length);
>  extern void ext4_set_inode_flags(struct inode *, bool init);
>  extern int ext4_alloc_da_blocks(struct inode *inode);
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index a07a98a4b97a..8dc6b4271b15 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4667,22 +4667,13 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  			goto out_mutex;
>  		}
>  
> -		/*
> -		 * For journalled data we need to write (and checkpoint) pages
> -		 * before discarding page cache to avoid inconsitent data on
> -		 * disk in case of crash before zeroing trans is committed.
> -		 */
> -		if (ext4_should_journal_data(inode)) {
> -			ret = filemap_write_and_wait_range(mapping, start,
> -							   end - 1);
> -			if (ret) {
> -				filemap_invalidate_unlock(mapping);
> -				goto out_mutex;
> -			}
> +		/* Now release the pages and zero block aligned part of pages */
> +		ret = ext4_truncate_page_cache_block_range(inode, start, end);
> +		if (ret) {
> +			filemap_invalidate_unlock(mapping);
> +			goto out_mutex;
>  		}
>  
> -		/* Now release the pages and zero block aligned part of pages */
> -		truncate_pagecache_range(inode, start, end - 1);
>  		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
>  
>  		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 89aade6f45f6..c68a8b841148 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -31,6 +31,7 @@
>  #include <linux/writeback.h>
>  #include <linux/pagevec.h>
>  #include <linux/mpage.h>
> +#include <linux/rmap.h>
>  #include <linux/namei.h>
>  #include <linux/uio.h>
>  #include <linux/bio.h>
> @@ -3902,6 +3903,67 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
>  	return ret;
>  }
>  
> +static inline void ext4_truncate_folio(struct inode *inode,
> +				       loff_t start, loff_t end)
> +{
> +	unsigned long blocksize = i_blocksize(inode);
> +	struct folio *folio;
> +
> +	/* Nothing to be done if no complete block needs to be truncated. */
> +	if (round_up(start, blocksize) >= round_down(end, blocksize))
> +		return;
> +
> +	folio = filemap_lock_folio(inode->i_mapping, start >> PAGE_SHIFT);
> +	if (IS_ERR(folio))
> +		return;
> +
> +	if (folio_mkclean(folio))
> +		folio_mark_dirty(folio);
> +	folio_unlock(folio);
> +	folio_put(folio);
> +}
> +
> +int ext4_truncate_page_cache_block_range(struct inode *inode,
> +					 loff_t start, loff_t end)
> +{
> +	unsigned long blocksize = i_blocksize(inode);
> +	int ret;
> +
> +	/*
> +	 * For journalled data we need to write (and checkpoint) pages
> +	 * before discarding page cache to avoid inconsitent data on disk
> +	 * in case of crash before freeing or unwritten converting trans
> +	 * is committed.
> +	 */
> +	if (ext4_should_journal_data(inode)) {
> +		ret = filemap_write_and_wait_range(inode->i_mapping, start,
> +						   end - 1);
> +		if (ret)
> +			return ret;
> +		goto truncate_pagecache;
> +	}
> +
> +	/*
> +	 * If the block size is less than the page size, the file's mapped
> +	 * blocks within one page could be freed or converted to unwritten.
> +	 * So it's necessary to remove writable userspace mappings, and then
> +	 * ext4_page_mkwrite() can be called during subsequent write access
> +	 * to these partial folios.
> +	 */
> +	if (blocksize < PAGE_SIZE && start < inode->i_size) {
> +		loff_t start_boundary = round_up(start, PAGE_SIZE);
> +
> +		ext4_truncate_folio(inode, start, min(start_boundary, end));
> +		if (end > start_boundary)
> +			ext4_truncate_folio(inode,
> +					    round_down(end, PAGE_SIZE), end);
> +	}
> +
> +truncate_pagecache:
> +	truncate_pagecache_range(inode, start, end - 1);
> +	return 0;
> +}
> +
>  static void ext4_wait_dax_page(struct inode *inode)
>  {
>  	filemap_invalidate_unlock(inode->i_mapping);
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

