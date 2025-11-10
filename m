Return-Path: <linux-fsdevel+bounces-67722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82907C47EA5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 17:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B65A54F2B44
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 16:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDFA25A340;
	Mon, 10 Nov 2025 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WRlZN1Dt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HtQdFl7J";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WRlZN1Dt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HtQdFl7J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F7527A123
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 16:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762791439; cv=none; b=FOV1aGYsfqN7ZNhKfFsQA8j+dzS4IO69/xSQiIW2uiP1RWtXvGUPzPZdT+EdOZzZLKKGzCn0vq7zxXe/on77itD4KOM3zEidcbklJonyUnvvZW8RuIoDBdyVKzahYB+AYZiwzoAs9hH4PQy5INRr9gzCmgOwj83Ojgq+xhEo5XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762791439; c=relaxed/simple;
	bh=BOICJgjEM8TZaqRMVH1oCsKEHOrwjoYHghZGGNdXB40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o9yyfzpn3PR2yVYCMhuwlrC8e0SkSYUmaYnlp3hJyJlxTYG3m1WNVUazT4UBfpl1G6/D3ovmCSbkXFU/Y/M4jkSxKZZ9zKDvgZ9wiSDixgTsrwLjvsoLoh1/Y6E8SCEpI4Nv/ce2jCYczEtrxDoI5E0QTS20L6HWkInaZ4I/yhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WRlZN1Dt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HtQdFl7J; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WRlZN1Dt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HtQdFl7J; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 56DAF1F81C;
	Mon, 10 Nov 2025 16:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762791434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YrOBspxCbbKPnxtqzlAEE5iWqhCmDcU42GABocD1amU=;
	b=WRlZN1DtAqT+PMxHhs21FZZKglAss9orVBCok9BiUdcNVF4BWPbgREkiQMWHjTRr9M0jhB
	YfXTlaczmrbDJb2qkrIxWTTPohaYFMZDzP/Exu8cPjZTFfov/RQwflcvIWIlsbRXt+Y/b4
	yBQqeggkkz8kar6oqBcLfhkKGVlMZPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762791434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YrOBspxCbbKPnxtqzlAEE5iWqhCmDcU42GABocD1amU=;
	b=HtQdFl7J5kPMtvohpN3txIm0DYVUFWOXvTD07pOuox8uLKCNTa0lKyC3EF5/ttsrd6zbNJ
	3m9tkwg2kKysFpAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762791434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YrOBspxCbbKPnxtqzlAEE5iWqhCmDcU42GABocD1amU=;
	b=WRlZN1DtAqT+PMxHhs21FZZKglAss9orVBCok9BiUdcNVF4BWPbgREkiQMWHjTRr9M0jhB
	YfXTlaczmrbDJb2qkrIxWTTPohaYFMZDzP/Exu8cPjZTFfov/RQwflcvIWIlsbRXt+Y/b4
	yBQqeggkkz8kar6oqBcLfhkKGVlMZPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762791434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YrOBspxCbbKPnxtqzlAEE5iWqhCmDcU42GABocD1amU=;
	b=HtQdFl7J5kPMtvohpN3txIm0DYVUFWOXvTD07pOuox8uLKCNTa0lKyC3EF5/ttsrd6zbNJ
	3m9tkwg2kKysFpAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1885C144A2;
	Mon, 10 Nov 2025 16:17:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wEKnBQoQEmmDewAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 10 Nov 2025 16:17:14 +0000
Message-ID: <2bbccc79-d64e-4ace-a528-37295e3f8a4d@suse.cz>
Date: Mon, 10 Nov 2025 17:17:13 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] mm: set the VM_MAYBE_GUARD flag on guard region
 install
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
References: <cover.1762531708.git.lorenzo.stoakes@oracle.com>
 <99ce6131e27592c92b43ac866da48b4c2a568298.1762531708.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <99ce6131e27592c92b43ac866da48b4c2a568298.1762531708.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lwn.net,redhat.com,oracle.com,kernel.org,google.com,suse.com,goodmis.org,efficios.com,suse.de,nvidia.com,linux.alibaba.com,arm.com,linux.dev,vger.kernel.org,kvack.org,gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RL37wz1aou84on4nnr4peu14t5)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 11/7/25 17:11, Lorenzo Stoakes wrote:
> Now we have established the VM_MAYBE_GUARD flag and added the capacity to
> set it atomically, do so upon MADV_GUARD_INSTALL.
> 
> The places where this flag is used currently and matter are:
> 
> * VMA merge - performed under mmap/VMA write lock, therefore excluding
>   racing writes.
> 
> * /proc/$pid/smaps - can race the write, however this isn't meaningful as
>   the flag write is performed at the point of the guard region being
>   established, and thus an smaps reader can't reasonably expect to avoid
>   races. Due to atomicity, a reader will observe either the flag being set
>   or not. Therefore consistency will be maintained.
> 
> In all other cases the flag being set is irrelevant and atomicity
> guarantees other flags will be read correctly.
> 
> Note that non-atomic updates of unrelated flags do not cause an issue with
> this flag being set atomically, as writes of other flags are performed
> under mmap/VMA write lock, and these atomic writes are performed under
> mmap/VMA read lock, which excludes the write, avoiding RMW races.
> 
> Note that we do not encounter issues with KCSAN by adjusting this flag
> atomically, as we are only updating a single bit in the flag bitmap and
> therefore we do not need to annotate these changes.
> 
> We intentionally set this flag in advance of actually updating the page
> tables, to ensure that any racing atomic read of this flag will only return
> false prior to page tables being updated, to allow for serialisation via
> page table locks.
> 
> Note that we set vma->anon_vma for anonymous mappings. This is because the
> expectation for anonymous mappings is that an anon_vma is established
> should they possess any page table mappings. This is also consistent with
> what we were doing prior to this patch (unconditionally setting anon_vma on
> guard region installation).
> 
> We also need to update retract_page_tables() to ensure that madvise(...,
> MADV_COLLAPSE) doesn't incorrectly collapse file-backed ranges contain
> guard regions.
> 
> This was previously guarded by anon_vma being set to catch MAP_PRIVATE
> cases, but the introduction of VM_MAYBE_GUARD necessitates that we check
> this flag instead.
> 
> We utilise vma_flag_test_atomic() to do so - we first perform an optimistic
> check, then after the PTE page table lock is held, we can check again
> safely, as upon guard marker install the flag is set atomically prior to
> the page table lock being taken to actually apply it.
> 
> So if the initial check fails either:
> 
> * Page table retraction acquires page table lock prior to VM_MAYBE_GUARD
>   being set - guard marker installation will be blocked until page table
>   retraction is complete.
> 
> OR:
> 
> * Guard marker installation acquires page table lock after setting
>   VM_MAYBE_GUARD, which raced and didn't pick this up in the initial
>   optimistic check, blocking page table retraction until the guard regions
>   are installed - the second VM_MAYBE_GUARD check will prevent page table
>   retraction.
> 
> Either way we're safe.
> 
> We refactor the retraction checks into a single
> file_backed_vma_is_retractable(), there doesn't seem to be any reason that
> the checks were separated as before.
> 
> Note that VM_MAYBE_GUARD being set atomically remains correct as
> vma_needs_copy() is invoked with the mmap and VMA write locks held,
> excluding any race with madvise_guard_install().
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Small nit below:

> @@ -1778,15 +1801,16 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>  			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
>  
>  		/*
> -		 * Huge page lock is still held, so normally the page table
> -		 * must remain empty; and we have already skipped anon_vma
> -		 * and userfaultfd_wp() vmas.  But since the mmap_lock is not
> -		 * held, it is still possible for a racing userfaultfd_ioctl()
> -		 * to have inserted ptes or markers.  Now that we hold ptlock,
> -		 * repeating the anon_vma check protects from one category,
> -		 * and repeating the userfaultfd_wp() check from another.
> +		 * Huge page lock is still held, so normally the page table must
> +		 * remain empty; and we have already skipped anon_vma and
> +		 * userfaultfd_wp() vmas.  But since the mmap_lock is not held,
> +		 * it is still possible for a racing userfaultfd_ioctl() or
> +		 * madvise() to have inserted ptes or markers.  Now that we hold
> +		 * ptlock, repeating the anon_vma check protects from one
> +		 * category, and repeating the userfaultfd_wp() check from
> +		 * another.

The last part of the comment is unchanged and mentions anon_vma check and
userfaultfd_wp() check which were there explicitly originally, but now it's
a file_backed_vma_is_retractable() check that also includes the guard region
check, so maybe could be updated?

>  		 */
> -		if (likely(!vma->anon_vma && !userfaultfd_wp(vma))) {
> +		if (likely(file_backed_vma_is_retractable(vma))) {
>  			pgt_pmd = pmdp_collapse_flush(vma, addr, pmd);
>  			pmdp_get_lockless_sync();
>  			success = true;
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 67bdfcb315b3..de918b107cfc 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1139,15 +1139,21 @@ static long madvise_guard_install(struct madvise_behavior *madv_behavior)
>  		return -EINVAL;
>  
>  	/*
> -	 * If we install guard markers, then the range is no longer
> -	 * empty from a page table perspective and therefore it's
> -	 * appropriate to have an anon_vma.
> -	 *
> -	 * This ensures that on fork, we copy page tables correctly.
> +	 * Set atomically under read lock. All pertinent readers will need to
> +	 * acquire an mmap/VMA write lock to read it. All remaining readers may
> +	 * or may not see the flag set, but we don't care.
> +	 */
> +	vma_flag_set_atomic(vma, VM_MAYBE_GUARD_BIT);
> +
> +	/*
> +	 * If anonymous and we are establishing page tables the VMA ought to
> +	 * have an anon_vma associated with it.
>  	 */
> -	err = anon_vma_prepare(vma);
> -	if (err)
> -		return err;
> +	if (vma_is_anonymous(vma)) {
> +		err = anon_vma_prepare(vma);
> +		if (err)
> +			return err;
> +	}
>  
>  	/*
>  	 * Optimistically try to install the guard marker pages first. If any


