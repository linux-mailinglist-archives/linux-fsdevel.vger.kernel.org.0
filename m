Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D547412E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 15:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjF1Np2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 09:45:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60081 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232213AbjF1No0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687959815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BR1e31KWtCzKshHk3i9sGJsYk/tQaHs2cFTTZ86spN4=;
        b=QqPxBBSSTkmLpgsdguo8+nYI2EYI3Z6qNsI/6MjUXBk949hiZfzjFouWAQnysH7l3l/fNh
        Ns6NbG9Q8Slb2jaNMlV3+omOwYoeFDgI+WjiDa1KVbE/S8EOyBLauktJrkiaB4ynCGjKQu
        siTjFg3WclfzERX0pixYf7gANFPbek0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-w4tca5BPM1u3kD-eGbf30A-1; Wed, 28 Jun 2023 09:43:32 -0400
X-MC-Unique: w4tca5BPM1u3kD-eGbf30A-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-402fa256023so2117771cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 06:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687959812; x=1690551812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BR1e31KWtCzKshHk3i9sGJsYk/tQaHs2cFTTZ86spN4=;
        b=Tvff5TQ7ZaVyLKICsHU0knFZkXI+A05w2X/mFtmpv9JvpqLpEvSHd/YkKgqwjFKlSP
         hLY7mGs58kdIpPjlRjeiDutMaNH8clbNlKxomx0FC0qTDBjgew18pYHZ7rnbM0A17+O/
         pkxB4wTB5vuqO4MHbqn2//zkjj+ZCEqUEqZGJfPZzEa8aEm+CXpltPGxIlGpS3ds3WEa
         nUccuqkAmMD293qypA7azgiYYW3Uud4Haavt4K6MsUyiGnTm6xgggVegN724PSUnGVmL
         XtOEJr7Fn6XuiVwtF7jMNKdsbPRY8UW6N67c9dLEkN05dfvWBatPltYsympJtSQhg8ru
         PM2Q==
X-Gm-Message-State: AC+VfDzfq3F7txC4BKkHPboISFLBYPXfSNAVS+rV87eOEGxxrIMzE3+M
        ePY8npDFGX+S0C/tQLt0L1CpVMb3Qhph7ACI/QCM9ExXdIQGgrycY9spIwmLJtJFQJO+3wXTZlc
        x+9rVYpIzOmokCirBdXhKNCwTMQ==
X-Received: by 2002:ac8:5713:0:b0:400:9bd5:3387 with SMTP id 19-20020ac85713000000b004009bd53387mr12057664qtw.0.1687959812248;
        Wed, 28 Jun 2023 06:43:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4GFumLvOCPj0F9b49es3pXW0L/ClPJqVb/4kHTZ+ZSwVk61r/fK/ZvKcbBwMMSNkp8sCzcFg==
X-Received: by 2002:ac8:5713:0:b0:400:9bd5:3387 with SMTP id 19-20020ac85713000000b004009bd53387mr12057630qtw.0.1687959811891;
        Wed, 28 Jun 2023 06:43:31 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id fw15-20020a05622a4a8f00b00400a5ca26fesm4279836qtb.2.2023.06.28.06.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 06:43:31 -0700 (PDT)
Date:   Wed, 28 Jun 2023 09:43:29 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v4 5/6] mm: handle swap page faults under per-VMA lock
Message-ID: <ZJw5AcazkbA5u+wO@x1n>
References: <20230628071800.544800-1-surenb@google.com>
 <20230628071800.544800-6-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230628071800.544800-6-surenb@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 12:17:59AM -0700, Suren Baghdasaryan wrote:
> When page fault is handled under per-VMA lock protection, all swap page
> faults are retried with mmap_lock because folio_lock_or_retry has to drop
> and reacquire mmap_lock if folio could not be immediately locked.
> Follow the same pattern as mmap_lock to drop per-VMA lock when waiting
> for folio and retrying once folio is available.
> With this obstacle removed, enable do_swap_page to operate under
> per-VMA lock protection. Drivers implementing ops->migrate_to_ram might
> still rely on mmap_lock, therefore we have to fall back to mmap_lock in
> that particular case.
> Note that the only time do_swap_page calls synchronous swap_readpage
> is when SWP_SYNCHRONOUS_IO is set, which is only set for
> QUEUE_FLAG_SYNCHRONOUS devices: brd, zram and nvdimms (both btt and
> pmem). Therefore we don't sleep in this path, and there's no need to
> drop the mmap or per-VMA lock.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Peter Xu <peterx@redhat.com>

One nit below:

> ---
>  mm/filemap.c | 25 ++++++++++++++++---------
>  mm/memory.c  | 16 ++++++++++------
>  2 files changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 52bcf12dcdbf..7ee078e1a0d2 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1699,31 +1699,38 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
>  	return ret;
>  }
>  
> +static void release_fault_lock(struct vm_fault *vmf)
> +{
> +	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
> +		vma_end_read(vmf->vma);
> +	else
> +		mmap_read_unlock(vmf->vma->vm_mm);
> +}
> +
>  /*
>   * Return values:
>   * 0 - folio is locked.
>   * VM_FAULT_RETRY - folio is not locked.
> - *     mmap_lock has been released (mmap_read_unlock(), unless flags had both
> - *     FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_RETRY_NOWAIT set, in
> - *     which case mmap_lock is still held.
> + *     mmap_lock or per-VMA lock has been released (mmap_read_unlock() or
> + *     vma_end_read()), unless flags had both FAULT_FLAG_ALLOW_RETRY and
> + *     FAULT_FLAG_RETRY_NOWAIT set, in which case the lock is still held.
>   *
>   * If neither ALLOW_RETRY nor KILLABLE are set, will always return 0
> - * with the folio locked and the mmap_lock unperturbed.
> + * with the folio locked and the mmap_lock/per-VMA lock is left unperturbed.
>   */
>  vm_fault_t __folio_lock_or_retry(struct folio *folio, struct vm_fault *vmf)
>  {
> -	struct mm_struct *mm = vmf->vma->vm_mm;
>  	unsigned int flags = vmf->flags;
>  
>  	if (fault_flag_allow_retry_first(flags)) {
>  		/*
> -		 * CAUTION! In this case, mmap_lock is not released
> -		 * even though return VM_FAULT_RETRY.
> +		 * CAUTION! In this case, mmap_lock/per-VMA lock is not
> +		 * released even though returning VM_FAULT_RETRY.
>  		 */
>  		if (flags & FAULT_FLAG_RETRY_NOWAIT)
>  			return VM_FAULT_RETRY;
>  
> -		mmap_read_unlock(mm);
> +		release_fault_lock(vmf);
>  		if (flags & FAULT_FLAG_KILLABLE)
>  			folio_wait_locked_killable(folio);
>  		else
> @@ -1735,7 +1742,7 @@ vm_fault_t __folio_lock_or_retry(struct folio *folio, struct vm_fault *vmf)
>  
>  		ret = __folio_lock_killable(folio);
>  		if (ret) {
> -			mmap_read_unlock(mm);
> +			release_fault_lock(vmf);
>  			return VM_FAULT_RETRY;
>  		}
>  	} else {
> diff --git a/mm/memory.c b/mm/memory.c
> index 345080052003..76c7907e7286 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3712,12 +3712,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	if (!pte_unmap_same(vmf))
>  		goto out;
>  
> -	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> -		ret = VM_FAULT_RETRY;
> -		vma_end_read(vma);
> -		goto out;
> -	}
> -
>  	entry = pte_to_swp_entry(vmf->orig_pte);
>  	if (unlikely(non_swap_entry(entry))) {
>  		if (is_migration_entry(entry)) {
> @@ -3727,6 +3721,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  			vmf->page = pfn_swap_entry_to_page(entry);
>  			ret = remove_device_exclusive_entry(vmf);
>  		} else if (is_device_private_entry(entry)) {
> +			if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> +				/*
> +				 * migrate_to_ram is not yet ready to operate
> +				 * under VMA lock.
> +				 */
> +				vma_end_read(vma);
> +				ret |= VM_FAULT_RETRY;

Here IIUC ret==0 is guaranteed, so maybe "ret = VM_FAULT_RETRY" is slightly
clearer.

> +				goto out;
> +			}
> +
>  			vmf->page = pfn_swap_entry_to_page(entry);
>  			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
>  					vmf->address, &vmf->ptl);
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 

-- 
Peter Xu

