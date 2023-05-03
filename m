Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58D86F5B9D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 17:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjECP5J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 11:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjECP5J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 11:57:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0314EE3
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 08:57:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B7ABB20516;
        Wed,  3 May 2023 15:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683129426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b5qLOBoOgZMOLtrRy7NkkeKNcsJlIk5ADh/xeQl9ea0=;
        b=JPvf/96owqKct4k1M23vwQ/J4TBbrVpVgqRd52atixHWxbTrSDPsR+lNbiEOJZt53oqfZW
        wZmZ8Oc2rKdduYYH0zpZDR5L9TBnuzfJMlhN4K9yCVpqJ5cJS50E9JJtUOvPJJUbX3sIiD
        gE8OFzgWNU/ud/QM1kjVTjAmrRtBFH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683129426;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b5qLOBoOgZMOLtrRy7NkkeKNcsJlIk5ADh/xeQl9ea0=;
        b=0tWzV85a4/6lyxK9FvB0R567kFPvxVdYQ7iI9FQg16bbVRckUHr5V7bvq3b3eDf9xJrvGi
        2pV/wh8QNwoDttCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA38113584;
        Wed,  3 May 2023 15:57:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hqKGKVKEUmSzdQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 03 May 2023 15:57:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 334A9A0744; Wed,  3 May 2023 17:57:06 +0200 (CEST)
Date:   Wed, 3 May 2023 17:57:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     akpm@linux-foundation.org, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dhowells@redhat.com, marc.dionne@auristor.com,
        linux-afs@lists.infradead.org,
        syzbot+48011b86c8ea329af1b9@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] filemap: fix the conditional folio_put in
 filemap_fault
Message-ID: <20230503155706.3j3y3nlfh6aglhhm@quack3>
References: <20230503154526.1223095-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503154526.1223095-1-hch@lst.de>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 03-05-23 17:45:25, Christoph Hellwig wrote:
> folio can't be NULL here now that __filemap_get_folio returns an
> ERR_PTR.  Remove the conditional folio_put after the out_retry
> label and add a new label for the cases where we have a valid folio.
> 
> Fixes: 66dabbb65d67 ("mm: return an ERR_PTR from __filemap_get_folio")
> Reported-by: syzbot+48011b86c8ea329af1b9@syzkaller.appspotmail.com
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/filemap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index a34abfe8c65430..ae597f63a9bc54 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3298,7 +3298,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  	}
>  
>  	if (!lock_folio_maybe_drop_mmap(vmf, folio, &fpin))
> -		goto out_retry;
> +		goto out_retry_put_folio;
>  
>  	/* Did it get truncated? */
>  	if (unlikely(folio->mapping != mapping)) {
> @@ -3334,7 +3334,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  	 */
>  	if (fpin) {
>  		folio_unlock(folio);
> -		goto out_retry;
> +		goto out_retry_put_folio;
>  	}
>  	if (mapping_locked)
>  		filemap_invalidate_unlock_shared(mapping);
> @@ -3363,7 +3363,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>  	error = filemap_read_folio(file, mapping->a_ops->read_folio, folio);
>  	if (fpin)
> -		goto out_retry;
> +		goto out_retry_put_folio;
>  	folio_put(folio);
>  
>  	if (!error || error == AOP_TRUNCATED_PAGE)
> @@ -3372,14 +3372,14 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  
>  	return VM_FAULT_SIGBUS;
>  
> +out_retry_put_folio:
> +	folio_put(folio);
>  out_retry:
>  	/*
>  	 * We dropped the mmap_lock, we need to return to the fault handler to
>  	 * re-find the vma and come back and find our hopefully still populated
>  	 * page.
>  	 */
> -	if (folio)
> -		folio_put(folio);
>  	if (mapping_locked)
>  		filemap_invalidate_unlock_shared(mapping);
>  	if (fpin)
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
