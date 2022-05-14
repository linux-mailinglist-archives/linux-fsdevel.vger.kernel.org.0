Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB10B527356
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 May 2022 19:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbiENReu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 May 2022 13:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiENRet (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 May 2022 13:34:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE65C27FFB;
        Sat, 14 May 2022 10:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J/CYoEWYN0//tJ7oLMZ9W2zbhdNH0QLc8IorvQFz8u0=; b=bKKkcu+uIoefITmMXktqtV/uHz
        6gopskH+sNJd3F0FI4e5OUQ8JCSUfcLPLs5clfSg/ekSn5tcqRaikq30Yoo+YQVQn0VCex5GeZ9y/
        vNG9PRXjINC8Z5Hk8LqtXAd6i4PvNkma3RqikSXntwp1KtCG/oNGKze5sxkldIl1lHcpynNMI4yBd
        iLWoIrnPC6DNnXh5YGf9fWY+qaJnO+OESmIQkq8LL1pEGAPnHV7Dx65g+M7qa6pzSbIMSMfhJ6ELC
        FSzRmHRzg4125i77nzWmu26Fpa8gpnKecz/xj/s0w4bomRyqmJmu5Yj56ZYA3ACB9qCfbzKKtXvq8
        9ZTqbvog==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npvf1-008NBP-Br; Sat, 14 May 2022 17:34:35 +0000
Date:   Sat, 14 May 2022 18:34:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sparse: use force attribute for vm_fault_t casts
Message-ID: <Yn/oKz6v5GkReeA3@casper.infradead.org>
References: <cf47f8c3-c4f3-7f80-ce17-ed9fbc7fe424@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf47f8c3-c4f3-7f80-ce17-ed9fbc7fe424@openvz.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 14, 2022 at 05:26:21PM +0300, Vasily Averin wrote:
> Fixes sparse warnings:
> ./include/trace/events/fs_dax.h:10:1: sparse:
>     got restricted vm_fault_t
> ./include/trace/events/fs_dax.h:153:1: sparse:
>     got restricted vm_fault_t
> fs/dax.c:563:39: sparse:    got restricted vm_fault_t
> fs/dax.c:565:39: sparse:    got restricted vm_fault_t
> fs/dax.c:569:31: sparse:    got restricted vm_fault_t
> fs/dax.c:1055:41: sparse:
>     got restricted vm_fault_t [assigned] [usertype] ret
> fs/dax.c:1461:46: sparse:    got restricted vm_fault_t [usertype] ret
> fs/dax.c:1477:21: sparse:
>     expected restricted vm_fault_t [assigned] [usertype] ret
> fs/dax.c:1518:51: sparse:
>     got restricted vm_fault_t [assigned] [usertype] ret
> fs/dax.c:1599:21: sparse:
>     expected restricted vm_fault_t [assigned] [usertype] ret
> fs/dax.c:1633:62: sparse:
>     got restricted vm_fault_t [assigned] [usertype] ret
> fs/dax.c:1696:55: sparse:    got restricted vm_fault_t
> fs/dax.c:1711:58: sparse:
>     got restricted vm_fault_t [assigned] [usertype] ret
> 
> vm_fault_t type is bitwise and requires __force attribute for any casts.

Well, this patch is all kinds of messy.  I would rather we had better
abstractions.  For example ...

> @@ -560,13 +560,13 @@ static void *grab_mapping_entry(struct xa_state *xas,
>  	if (xas_nomem(xas, mapping_gfp_mask(mapping) & ~__GFP_HIGHMEM))
>  		goto retry;
>  	if (xas->xa_node == XA_ERROR(-ENOMEM))
> -		return xa_mk_internal(VM_FAULT_OOM);
> +		return xa_mk_internal((__force unsigned long)VM_FAULT_OOM);
>  	if (xas_error(xas))
> -		return xa_mk_internal(VM_FAULT_SIGBUS);
> +		return xa_mk_internal((__force unsigned long)VM_FAULT_SIGBUS);
>  	return entry;
>  fallback:
>  	xas_unlock_irq(xas);
> -	return xa_mk_internal(VM_FAULT_FALLBACK);
> +	return xa_mk_internal((__force unsigned long)VM_FAULT_FALLBACK);
>  }

	return vm_fault_encode(VM_FAULT_xxx);

>  /**
> @@ -1052,7 +1052,7 @@ static vm_fault_t dax_load_hole(struct xa_state *xas,
>  			DAX_ZERO_PAGE, false);
>  
>  	ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
> -	trace_dax_load_hole(inode, vmf, ret);
> +	trace_dax_load_hole(inode, vmf, (__force int)ret);

Seems like trace_dax_load_hole() should take a vm_fault_t?

> -	trace_dax_pte_fault(iter.inode, vmf, ret);
> +	trace_dax_pte_fault(iter.inode, vmf, (__force int)ret);

Ditto.

> @@ -1474,7 +1474,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  
>  	entry = grab_mapping_entry(&xas, mapping, 0);
>  	if (xa_is_internal(entry)) {
> -		ret = xa_to_internal(entry);
> +		ret = (__force vm_fault_t)xa_to_internal(entry);

vm_fault_decode(entry)?

... the others seem like more of the same.  So I'm in favour of what
you're doing, but would rather it were done differently.  Generally
seeing __force casts in the body of a function is a sign that things are
wrong; it's better to have them hidden in abstractions.
