Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7FC633F45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 15:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbiKVOuL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 09:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbiKVOuJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:50:09 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D64663CE;
        Tue, 22 Nov 2022 06:50:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 683391F85D;
        Tue, 22 Nov 2022 14:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669128607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TuOeD9hS5w47LsnqcPKQtrXy6koctaIzcHPxwbxmwbA=;
        b=aGZachSXiRVjKPJsrWk8CPop2PpOEMJr7spf/DAJ5bmOd/2f4r4PDMztApEKo2PcSlvmxW
        kUYly+UTyuJUxKmOQFyKK0uK83vpsu8HLfHf74wJV6xsDgOcFpyyuGww7bQkx1IkhT+zig
        CKpIYly4TJFynSwnq3h8C8XfDQxdhu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669128607;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TuOeD9hS5w47LsnqcPKQtrXy6koctaIzcHPxwbxmwbA=;
        b=3O83wprOyy/Za1HsOlbBbN841s6+bHjQppNWEZSAiaC61+01222yq5NJYcQdKsFuOVce+G
        lcMh2DB+p4IaJ9Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BDF4713AA1;
        Tue, 22 Nov 2022 14:50:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xuSnLZ7hfGM/fwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 22 Nov 2022 14:50:06 +0000
Message-ID: <d40947e4-06c4-8413-9d53-e4926abd9559@suse.cz>
Date:   Tue, 22 Nov 2022 15:50:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH mm-unstable v1 07/20] mm: don't call vm_ops->huge_fault()
 in wp_huge_pmd()/wp_huge_pud() for private mappings
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-8-david@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221116102659.70287-8-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/16/22 11:26, David Hildenbrand wrote:
> If we already have a PMD/PUD mapped write-protected in a private mapping
> and we want to break COW either due to FAULT_FLAG_WRITE or
> FAULT_FLAG_UNSHARE, there is no need to inform the file system just like on
> the PTE path.
> 
> Let's just split (->zap) + fallback in that case.
> 
> This is a preparation for more generic FAULT_FLAG_UNSHARE support in
> COW mappings.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Nits:

> ---
>  mm/memory.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index c35e6cd32b6a..d47ad33c6487 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4802,6 +4802,7 @@ static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
>  static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
>  {
>  	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
> +	vm_fault_t ret;
>  
>  	if (vma_is_anonymous(vmf->vma)) {
>  		if (likely(!unshare) &&
> @@ -4809,11 +4810,13 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
>  			return handle_userfault(vmf, VM_UFFD_WP);
>  		return do_huge_pmd_wp_page(vmf);
>  	}
> -	if (vmf->vma->vm_ops->huge_fault) {
> -		vm_fault_t ret = vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PMD);
>  
> -		if (!(ret & VM_FAULT_FALLBACK))
> -			return ret;
> +	if (vmf->vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
> +		if (vmf->vma->vm_ops->huge_fault) {

I guess it could have been a single if with && and the reduced identation
could fit keeping 'ret' declaration inside.
AFAICS the later patches don't build more on top of this anyway.
But also fine keeping as is.

(the hunk below same)

> +			ret = vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PMD);
> +			if (!(ret & VM_FAULT_FALLBACK))
> +				return ret;
> +		}
>  	}
>  
>  	/* COW or write-notify handled on pte level: split pmd. */
> @@ -4839,14 +4842,17 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
>  {
>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) &&			\
>  	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
> +	vm_fault_t ret;
> +
>  	/* No support for anonymous transparent PUD pages yet */
>  	if (vma_is_anonymous(vmf->vma))
>  		goto split;
> -	if (vmf->vma->vm_ops->huge_fault) {
> -		vm_fault_t ret = vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PUD);
> -
> -		if (!(ret & VM_FAULT_FALLBACK))
> -			return ret;
> +	if (vmf->vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
> +		if (vmf->vma->vm_ops->huge_fault) {
> +			ret = vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PUD);
> +			if (!(ret & VM_FAULT_FALLBACK))
> +				return ret;
> +		}
>  	}
>  split:
>  	/* COW or write-notify not handled on PUD level: split pud.*/

