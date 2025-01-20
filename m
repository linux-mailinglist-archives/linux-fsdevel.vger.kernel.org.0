Return-Path: <linux-fsdevel+bounces-39693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB67A16FC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 17:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A051884A50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 16:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CBC1E8841;
	Mon, 20 Jan 2025 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nnzCQtxm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/feCphDO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nnzCQtxm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/feCphDO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F9110F9;
	Mon, 20 Jan 2025 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737388849; cv=none; b=Nylw0zbKVFpLeWKabGTZrs9Zrc2fOxathlv1rzV80nVrKTm/rXz8sKC7UqqeN5ZBk49x1VNYiEKazzI6ut2m9B7DIh5Zddp5p/q3s0O04Ml/0KdNeB/pVtM68FlTqgfbD9oflLRH3CFlFQGDXt8RuuktYoPL1vdhdRyDQ6oxEHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737388849; c=relaxed/simple;
	bh=VMJdmaD9xHcpbW41HE/U4iNsMderrWFZB4HaKOJ8N4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOUkurqaY+JP4nA0zU1dveAd2+ametS6BG2L6yKYxAR0zY76fw50puIhPn/Ot1FTw2RFnjE+q1kyR/cGcNVqyShQPM0jleoq4LI+su5E692m1nHxoqLn2xRVjNLrluyxfS8lvQWgZervQQGM0Dncm89/0lVxtt5N/i/B7FvLotg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nnzCQtxm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/feCphDO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nnzCQtxm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/feCphDO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3196A1F399;
	Mon, 20 Jan 2025 16:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737388845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ujqEMMfIMtzlt/Dc8SJOf+csB9q64VZHSVIJQmZbRBw=;
	b=nnzCQtxmeWaHXX+Z0Zitc2YyBTKcz4bJr7fN4m5X2Mmxe28HUh/Eih+vdLRhVDZzaKO8Mq
	8+P8nEeDePtQ+U6+UY7m4uh7wlnjnz7g4tG3OJtKypESUXJcA0hUKiSDCgqRHJeOpkux3U
	6E3fGkIQhDamlXtfRgvREEunrEHGwDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737388845;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ujqEMMfIMtzlt/Dc8SJOf+csB9q64VZHSVIJQmZbRBw=;
	b=/feCphDOSs7hWtwC9qPZr7/WvEW+4nHOAMZcCHecOnE/2h5AgkticNtwS74sdshIkVDpfU
	JzAOUn7yGBp/8YDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nnzCQtxm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/feCphDO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737388845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ujqEMMfIMtzlt/Dc8SJOf+csB9q64VZHSVIJQmZbRBw=;
	b=nnzCQtxmeWaHXX+Z0Zitc2YyBTKcz4bJr7fN4m5X2Mmxe28HUh/Eih+vdLRhVDZzaKO8Mq
	8+P8nEeDePtQ+U6+UY7m4uh7wlnjnz7g4tG3OJtKypESUXJcA0hUKiSDCgqRHJeOpkux3U
	6E3fGkIQhDamlXtfRgvREEunrEHGwDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737388845;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ujqEMMfIMtzlt/Dc8SJOf+csB9q64VZHSVIJQmZbRBw=;
	b=/feCphDOSs7hWtwC9qPZr7/WvEW+4nHOAMZcCHecOnE/2h5AgkticNtwS74sdshIkVDpfU
	JzAOUn7yGBp/8YDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 257CE1393E;
	Mon, 20 Jan 2025 16:00:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dwkiCS1zjmfwDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Jan 2025 16:00:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D1785A081E; Mon, 20 Jan 2025 17:00:44 +0100 (CET)
Date: Mon, 20 Jan 2025 17:00:44 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, tavianator@tavianator.com, 
	linux-mm@kvack.org, akpm@linux-foundation.org
Subject: Re: [RESEND PATCH] fs: avoid mmap sem relocks when coredumping with
 many missing pages
Message-ID: <55qxyg2diynlelvdzorhvtk4omfcobarious3fkxh4n33oezod@sju7s6sebec3>
References: <20250119103205.2172432-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250119103205.2172432-1-mjguzik@gmail.com>
X-Rspamd-Queue-Id: 3196A1F399
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Sun 19-01-25 11:32:05, Mateusz Guzik wrote:
> Dumping processes with large allocated and mostly not-faulted areas is
> very slow.
> 
> Borrowing a test case from Tavian Barnes:
> 
> int main(void) {
>     char *mem = mmap(NULL, 1ULL << 40, PROT_READ | PROT_WRITE,
>             MAP_ANONYMOUS | MAP_NORESERVE | MAP_PRIVATE, -1, 0);
>     printf("%p %m\n", mem);
>     if (mem != MAP_FAILED) {
>             mem[0] = 1;
>     }
>     abort();
> }
> 
> That's 1TB of almost completely not-populated area.
> 
> On my test box it takes 13-14 seconds to dump.
> 
> The profile shows:
> -   99.89%     0.00%  a.out
>      entry_SYSCALL_64_after_hwframe
>      do_syscall_64
>      syscall_exit_to_user_mode
>      arch_do_signal_or_restart
>    - get_signal
>       - 99.89% do_coredump
>          - 99.88% elf_core_dump
>             - dump_user_range
>                - 98.12% get_dump_page
>                   - 64.19% __get_user_pages
>                      - 40.92% gup_vma_lookup
>                         - find_vma
>                            - mt_find
>                                 4.21% __rcu_read_lock
>                                 1.33% __rcu_read_unlock
>                      - 3.14% check_vma_flags
>                           0.68% vma_is_secretmem
>                        0.61% __cond_resched
>                        0.60% vma_pgtable_walk_end
>                        0.59% vma_pgtable_walk_begin
>                        0.58% no_page_table
>                   - 15.13% down_read_killable
>                        0.69% __cond_resched
>                     13.84% up_read
>                  0.58% __cond_resched
> 
> Almost 29% of the time is spent relocking the mmap semaphore between
> calls to get_dump_page() which find nothing.
> 
> Whacking that results in times of 10 seconds (down from 13-14).
> 
> While here make the thing killable.
> 
> The real problem is the page-sized iteration and the real fix would
> patch it up instead. It is left as an exercise for the mm-familiar
> reader.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

The patch looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

BTW: I don't see how we could fundamentally move away from page-sized
iteration because core dumping is "by definition" walking page tables and
gathering pages there. But it could certainly be much more efficient if
implemented properly (e.g. in the example above we'd see that most of PGD
level tables are not even allocated so we could be skipping 1GB ranges of
address space in one step).

								Honza

> ---
> 
> Minimally tested, very plausible I missed something.
> 
> sent again because the previous thing has myself in To -- i failed to
> fix up the oneliner suggested by lore.kernel.org. it seem the original
> got lost.
> 
>  arch/arm64/kernel/elfcore.c |  3 ++-
>  fs/coredump.c               | 38 +++++++++++++++++++++++++++++++------
>  include/linux/mm.h          |  2 +-
>  mm/gup.c                    |  5 ++---
>  4 files changed, 37 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/kernel/elfcore.c b/arch/arm64/kernel/elfcore.c
> index 2e94d20c4ac7..b735f4c2fe5e 100644
> --- a/arch/arm64/kernel/elfcore.c
> +++ b/arch/arm64/kernel/elfcore.c
> @@ -27,9 +27,10 @@ static int mte_dump_tag_range(struct coredump_params *cprm,
>  	int ret = 1;
>  	unsigned long addr;
>  	void *tags = NULL;
> +	int locked = 0;
>  
>  	for (addr = start; addr < start + len; addr += PAGE_SIZE) {
> -		struct page *page = get_dump_page(addr);
> +		struct page *page = get_dump_page(addr, &locked);
>  
>  		/*
>  		 * get_dump_page() returns NULL when encountering an empty
> diff --git a/fs/coredump.c b/fs/coredump.c
> index d48edb37bc35..84cf76f0d5b6 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -925,14 +925,23 @@ int dump_user_range(struct coredump_params *cprm, unsigned long start,
>  {
>  	unsigned long addr;
>  	struct page *dump_page;
> +	int locked, ret;
>  
>  	dump_page = dump_page_alloc();
>  	if (!dump_page)
>  		return 0;
>  
> +	ret = 0;
> +	locked = 0;
>  	for (addr = start; addr < start + len; addr += PAGE_SIZE) {
>  		struct page *page;
>  
> +		if (!locked) {
> +			if (mmap_read_lock_killable(current->mm))
> +				goto out;
> +			locked = 1;
> +		}
> +
>  		/*
>  		 * To avoid having to allocate page tables for virtual address
>  		 * ranges that have never been used yet, and also to make it
> @@ -940,21 +949,38 @@ int dump_user_range(struct coredump_params *cprm, unsigned long start,
>  		 * NULL when encountering an empty page table entry that would
>  		 * otherwise have been filled with the zero page.
>  		 */
> -		page = get_dump_page(addr);
> +		page = get_dump_page(addr, &locked);
>  		if (page) {
> +			if (locked) {
> +				mmap_read_unlock(current->mm);
> +				locked = 0;
> +			}
>  			int stop = !dump_emit_page(cprm, dump_page_copy(page, dump_page));
>  			put_page(page);
> -			if (stop) {
> -				dump_page_free(dump_page);
> -				return 0;
> -			}
> +			if (stop)
> +				goto out;
>  		} else {
>  			dump_skip(cprm, PAGE_SIZE);
>  		}
> +
> +		if (dump_interrupted())
> +			goto out;
> +
> +		if (!need_resched())
> +			continue;
> +		if (locked) {
> +			mmap_read_unlock(current->mm);
> +			locked = 0;
> +		}
>  		cond_resched();
>  	}
> +	ret = 1;
> +out:
> +	if (locked)
> +		mmap_read_unlock(current->mm);
> +
>  	dump_page_free(dump_page);
> -	return 1;
> +	return ret;
>  }
>  #endif
>  
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 75c9b4f46897..7df0d9200d8c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2633,7 +2633,7 @@ int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
>  			struct task_struct *task, bool bypass_rlim);
>  
>  struct kvec;
> -struct page *get_dump_page(unsigned long addr);
> +struct page *get_dump_page(unsigned long addr, int *locked);
>  
>  bool folio_mark_dirty(struct folio *folio);
>  bool folio_mark_dirty_lock(struct folio *folio);
> diff --git a/mm/gup.c b/mm/gup.c
> index 2304175636df..f3be2aa43543 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2266,13 +2266,12 @@ EXPORT_SYMBOL(fault_in_readable);
>   * Called without mmap_lock (takes and releases the mmap_lock by itself).
>   */
>  #ifdef CONFIG_ELF_CORE
> -struct page *get_dump_page(unsigned long addr)
> +struct page *get_dump_page(unsigned long addr, int *locked)
>  {
>  	struct page *page;
> -	int locked = 0;
>  	int ret;
>  
> -	ret = __get_user_pages_locked(current->mm, addr, 1, &page, &locked,
> +	ret = __get_user_pages_locked(current->mm, addr, 1, &page, locked,
>  				      FOLL_FORCE | FOLL_DUMP | FOLL_GET);
>  	return (ret == 1) ? page : NULL;
>  }
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

