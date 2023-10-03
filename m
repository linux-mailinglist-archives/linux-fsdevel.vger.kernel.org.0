Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEFF7B6A3A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 15:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbjJCNTE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 09:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235929AbjJCNTC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:19:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F804E3;
        Tue,  3 Oct 2023 06:18:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 29A0C2189B;
        Tue,  3 Oct 2023 13:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696339134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LqjOkdf8wEGORSfxlGDuLFjsaB2EonO8sU3/o8407WE=;
        b=0L1N84/g4JW4Pz4EHuBiDWpCHedzO4xCWFk93E412HzHjVHMG2caaqbBmKjd54UvzEKNW3
        XzqOvxVn5fmUsDC+LZAx5acFvUUAydhayTqik7QMcHtRVwZOMHjUEka2gvCaYJEOG4zliA
        CCcjwTM5k6bjfVExditBMu97suSKm1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696339134;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LqjOkdf8wEGORSfxlGDuLFjsaB2EonO8sU3/o8407WE=;
        b=SBF+rWXcUn9e/501dNskOYmABTAkWJTPRFeceh/Zvkr8VgH4m0t+8/qME8tZhGLLf9Ho6y
        mRFWnMNlgk0DB+BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1BF73132D4;
        Tue,  3 Oct 2023 13:18:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CIjIBr4UHGXpMwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 03 Oct 2023 13:18:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A9412A07CC; Tue,  3 Oct 2023 15:18:53 +0200 (CEST)
Date:   Tue, 3 Oct 2023 15:18:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 3/8] shmem: factor shmem_falloc_wait() out of
 shmem_fault()
Message-ID: <20231003131853.ramdlfw5s6ne4iqx@quack3>
References: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com>
 <6fe379a4-6176-9225-9263-fe60d2633c0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fe379a4-6176-9225-9263-fe60d2633c0@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 29-09-23 20:27:53, Hugh Dickins wrote:
> That Trinity livelock shmem_falloc avoidance block is unlikely, and a
> distraction from the proper business of shmem_fault(): separate it out.
> (This used to help compilers save stack on the fault path too, but both
> gcc and clang nowadays seem to make better choices anyway.)
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Looking at the code I'm just wondering whether the livelock with
shmem_undo_range() couldn't be more easy to avoid by making
shmem_undo_range() always advance the index by 1 after evicting a page and
thus guaranteeing a forward progress... Because the forward progress within
find_get_entries() is guaranteed these days, it should be enough.

								Honza

> ---
>  mm/shmem.c | 126 +++++++++++++++++++++++++++++------------------------
>  1 file changed, 69 insertions(+), 57 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 824eb55671d2..5501a5bc8d8c 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2148,87 +2148,99 @@ int shmem_get_folio(struct inode *inode, pgoff_t index, struct folio **foliop,
>   * entry unconditionally - even if something else had already woken the
>   * target.
>   */
> -static int synchronous_wake_function(wait_queue_entry_t *wait, unsigned mode, int sync, void *key)
> +static int synchronous_wake_function(wait_queue_entry_t *wait,
> +			unsigned int mode, int sync, void *key)
>  {
>  	int ret = default_wake_function(wait, mode, sync, key);
>  	list_del_init(&wait->entry);
>  	return ret;
>  }
>  
> +/*
> + * Trinity finds that probing a hole which tmpfs is punching can
> + * prevent the hole-punch from ever completing: which in turn
> + * locks writers out with its hold on i_rwsem.  So refrain from
> + * faulting pages into the hole while it's being punched.  Although
> + * shmem_undo_range() does remove the additions, it may be unable to
> + * keep up, as each new page needs its own unmap_mapping_range() call,
> + * and the i_mmap tree grows ever slower to scan if new vmas are added.
> + *
> + * It does not matter if we sometimes reach this check just before the
> + * hole-punch begins, so that one fault then races with the punch:
> + * we just need to make racing faults a rare case.
> + *
> + * The implementation below would be much simpler if we just used a
> + * standard mutex or completion: but we cannot take i_rwsem in fault,
> + * and bloating every shmem inode for this unlikely case would be sad.
> + */
> +static vm_fault_t shmem_falloc_wait(struct vm_fault *vmf, struct inode *inode)
> +{
> +	struct shmem_falloc *shmem_falloc;
> +	struct file *fpin = NULL;
> +	vm_fault_t ret = 0;
> +
> +	spin_lock(&inode->i_lock);
> +	shmem_falloc = inode->i_private;
> +	if (shmem_falloc &&
> +	    shmem_falloc->waitq &&
> +	    vmf->pgoff >= shmem_falloc->start &&
> +	    vmf->pgoff < shmem_falloc->next) {
> +		wait_queue_head_t *shmem_falloc_waitq;
> +		DEFINE_WAIT_FUNC(shmem_fault_wait, synchronous_wake_function);
> +
> +		ret = VM_FAULT_NOPAGE;
> +		fpin = maybe_unlock_mmap_for_io(vmf, NULL);
> +		shmem_falloc_waitq = shmem_falloc->waitq;
> +		prepare_to_wait(shmem_falloc_waitq, &shmem_fault_wait,
> +				TASK_UNINTERRUPTIBLE);
> +		spin_unlock(&inode->i_lock);
> +		schedule();
> +
> +		/*
> +		 * shmem_falloc_waitq points into the shmem_fallocate()
> +		 * stack of the hole-punching task: shmem_falloc_waitq
> +		 * is usually invalid by the time we reach here, but
> +		 * finish_wait() does not dereference it in that case;
> +		 * though i_lock needed lest racing with wake_up_all().
> +		 */
> +		spin_lock(&inode->i_lock);
> +		finish_wait(shmem_falloc_waitq, &shmem_fault_wait);
> +	}
> +	spin_unlock(&inode->i_lock);
> +	if (fpin) {
> +		fput(fpin);
> +		ret = VM_FAULT_RETRY;
> +	}
> +	return ret;
> +}
> +
>  static vm_fault_t shmem_fault(struct vm_fault *vmf)
>  {
> -	struct vm_area_struct *vma = vmf->vma;
> -	struct inode *inode = file_inode(vma->vm_file);
> +	struct inode *inode = file_inode(vmf->vma->vm_file);
>  	gfp_t gfp = mapping_gfp_mask(inode->i_mapping);
>  	struct folio *folio = NULL;
> +	vm_fault_t ret = 0;
>  	int err;
> -	vm_fault_t ret = VM_FAULT_LOCKED;
>  
>  	/*
>  	 * Trinity finds that probing a hole which tmpfs is punching can
> -	 * prevent the hole-punch from ever completing: which in turn
> -	 * locks writers out with its hold on i_rwsem.  So refrain from
> -	 * faulting pages into the hole while it's being punched.  Although
> -	 * shmem_undo_range() does remove the additions, it may be unable to
> -	 * keep up, as each new page needs its own unmap_mapping_range() call,
> -	 * and the i_mmap tree grows ever slower to scan if new vmas are added.
> -	 *
> -	 * It does not matter if we sometimes reach this check just before the
> -	 * hole-punch begins, so that one fault then races with the punch:
> -	 * we just need to make racing faults a rare case.
> -	 *
> -	 * The implementation below would be much simpler if we just used a
> -	 * standard mutex or completion: but we cannot take i_rwsem in fault,
> -	 * and bloating every shmem inode for this unlikely case would be sad.
> +	 * prevent the hole-punch from ever completing: noted in i_private.
>  	 */
>  	if (unlikely(inode->i_private)) {
> -		struct shmem_falloc *shmem_falloc;
> -
> -		spin_lock(&inode->i_lock);
> -		shmem_falloc = inode->i_private;
> -		if (shmem_falloc &&
> -		    shmem_falloc->waitq &&
> -		    vmf->pgoff >= shmem_falloc->start &&
> -		    vmf->pgoff < shmem_falloc->next) {
> -			struct file *fpin;
> -			wait_queue_head_t *shmem_falloc_waitq;
> -			DEFINE_WAIT_FUNC(shmem_fault_wait, synchronous_wake_function);
> -
> -			ret = VM_FAULT_NOPAGE;
> -			fpin = maybe_unlock_mmap_for_io(vmf, NULL);
> -			if (fpin)
> -				ret = VM_FAULT_RETRY;
> -
> -			shmem_falloc_waitq = shmem_falloc->waitq;
> -			prepare_to_wait(shmem_falloc_waitq, &shmem_fault_wait,
> -					TASK_UNINTERRUPTIBLE);
> -			spin_unlock(&inode->i_lock);
> -			schedule();
> -
> -			/*
> -			 * shmem_falloc_waitq points into the shmem_fallocate()
> -			 * stack of the hole-punching task: shmem_falloc_waitq
> -			 * is usually invalid by the time we reach here, but
> -			 * finish_wait() does not dereference it in that case;
> -			 * though i_lock needed lest racing with wake_up_all().
> -			 */
> -			spin_lock(&inode->i_lock);
> -			finish_wait(shmem_falloc_waitq, &shmem_fault_wait);
> -			spin_unlock(&inode->i_lock);
> -
> -			if (fpin)
> -				fput(fpin);
> +		ret = shmem_falloc_wait(vmf, inode);
> +		if (ret)
>  			return ret;
> -		}
> -		spin_unlock(&inode->i_lock);
>  	}
>  
> +	WARN_ON_ONCE(vmf->page != NULL);
>  	err = shmem_get_folio_gfp(inode, vmf->pgoff, &folio, SGP_CACHE,
>  				  gfp, vmf, &ret);
>  	if (err)
>  		return vmf_error(err);
> -	if (folio)
> +	if (folio) {
>  		vmf->page = folio_file_page(folio, vmf->pgoff);
> +		ret |= VM_FAULT_LOCKED;
> +	}
>  	return ret;
>  }
>  
> -- 
> 2.35.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
