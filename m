Return-Path: <linux-fsdevel+bounces-49-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A637C4F57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 11:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063B61C20F44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 09:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735331DA26;
	Wed, 11 Oct 2023 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MINSzmiM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PuflIjs6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10111856;
	Wed, 11 Oct 2023 09:46:32 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C2E92;
	Wed, 11 Oct 2023 02:46:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4CBEE21846;
	Wed, 11 Oct 2023 09:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697017588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=soXVte2VbxPbbCiLRCQN5td7yB/rAeQqYWLQLBxTIFU=;
	b=MINSzmiMBqPcCbrrb5vPVjQ4FAleRRJnE1hYr+yINv0F92u7+T9emi+0wjSB8uUZUd69D0
	zh4gFBG77P84Bzd6iajzSLr+gqwv8cUjeCNuBJedY1ICnaMghUIWuVEjc4F1Obrx6fG7bM
	fXwXQ2CAmNnHT3yKSi8LykyvJd3qaN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697017588;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=soXVte2VbxPbbCiLRCQN5td7yB/rAeQqYWLQLBxTIFU=;
	b=PuflIjs6dBQNsSmZ34SZrkDPJN2uCfXBS9AiB4CipN0nI/vA5+5fZYmJ2XDxUn5d3P7yKC
	9X6t0U2qgkZGmDCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3EDD6134F5;
	Wed, 11 Oct 2023 09:46:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 5E5TD/RuJmWnSwAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 11 Oct 2023 09:46:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C200BA05BC; Wed, 11 Oct 2023 11:46:27 +0200 (CEST)
Date: Wed, 11 Oct 2023 11:46:27 +0200
From: Jan Kara <jack@suse.cz>
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>, Andy Lutomirski <luto@kernel.org>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mm: enforce the mapping_map_writable() check
 after call_mmap()
Message-ID: <20231011094627.3xohlpe4gm2idszm@quack3>
References: <cover.1696709413.git.lstoakes@gmail.com>
 <d2748bc4077b53c60bcb06fccaf976cb2afee345.1696709413.git.lstoakes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2748bc4077b53c60bcb06fccaf976cb2afee345.1696709413.git.lstoakes@gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat 07-10-23 21:51:01, Lorenzo Stoakes wrote:
> In order for an F_SEAL_WRITE sealed memfd mapping to have an opportunity to
> clear VM_MAYWRITE in seal_check_write() we must be able to invoke either
> the shmem_mmap() or hugetlbfs_file_mmap() f_ops->mmap() handler to do so.
> 
> We would otherwise fail the mapping_map_writable() check before we had
> the opportunity to clear VM_MAYWRITE.
> 
> However, the existing logic in mmap_region() performs this check BEFORE
> calling call_mmap() (which invokes file->f_ops->mmap()). We must enforce
> this check AFTER the function call.
> 
> In order to avoid any risk of breaking call_mmap() handlers which assume
> this will have been done first, we continue to mark the file writable
> first, simply deferring enforcement of it failing until afterwards.
> 
> This enables mmap(..., PROT_READ, MAP_SHARED, fd, 0) mappings for memfd's
> sealed via F_SEAL_WRITE to succeed, whereas previously they were not
> permitted.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217238
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

...

> diff --git a/mm/mmap.c b/mm/mmap.c
> index 6f6856b3267a..9fbee92aaaee 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2767,17 +2767,25 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	vma->vm_pgoff = pgoff;
>  
>  	if (file) {
> -		if (is_shared_maywrite(vm_flags)) {
> -			error = mapping_map_writable(file->f_mapping);
> -			if (error)
> -				goto free_vma;
> -		}
> +		int writable_error = 0;
> +
> +		if (vma_is_shared_maywrite(vma))
> +			writable_error = mapping_map_writable(file->f_mapping);
>  
>  		vma->vm_file = get_file(file);
>  		error = call_mmap(file, vma);
>  		if (error)
>  			goto unmap_and_free_vma;
>  
> +		/*
> +		 * call_mmap() may have changed VMA flags, so retry this check
> +		 * if it failed before.
> +		 */
> +		if (writable_error && vma_is_shared_maywrite(vma)) {
> +			error = writable_error;
> +			goto close_and_free_vma;
> +		}

Hum, this doesn't quite give me a peace of mind ;). One bug I can see is
that if call_mmap() drops the VM_MAYWRITE flag, we seem to forget to drop
i_mmap_writeable counter here?

I've checked why your v2 version broke i915 and I think the reason maybe
has nothing to do with i915. Just in case call_mmap() failed, it ended up
jumping to unmap_and_free_vma which calls mapping_unmap_writable() but we
didn't call mapping_map_writable() yet so the counter became imbalanced.

So I'd be for returning to v2 version, just fix up the error handling
paths...

								Honza


> +
>  		/*
>  		 * Expansion is handled above, merging is handled below.
>  		 * Drivers should not alter the address of the VMA.
> -- 
> 2.42.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

