Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A579C634056
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 16:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbiKVPgg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 10:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbiKVPgF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 10:36:05 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AFA71F03;
        Tue, 22 Nov 2022 07:35:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8357A22007;
        Tue, 22 Nov 2022 15:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669131353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xzeEtRVGkBValjf4cAqJIIBnm0WLgHIJrOj2Qpyeryk=;
        b=hSz8uo53GqZkaSBqbG3aIh16lgMQB2Sw8gZ6Z+fnEjIR6uPvpuBuVkR8TpcuCDJwN2rjjn
        iqJmydTFhzXH0tY5jw9oJ6zK0Sx7/l0zZrHLYI1mzVvp/woqabMd2RthMdqBUz+tckoXxt
        gvUiGWpp9yM7xLCq0tNctpGuD1es/pI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669131353;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xzeEtRVGkBValjf4cAqJIIBnm0WLgHIJrOj2Qpyeryk=;
        b=87yFyDfodelF6paPP+3fZVkcbfCamfu6aYJAmnQjTNh2RXFp/RQ8a0uSheJsgsaRl+tSbc
        rgSpbkEWiLk/2KDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E380913B01;
        Tue, 22 Nov 2022 15:35:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /ANwNljsfGPGGwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 22 Nov 2022 15:35:52 +0000
Message-ID: <34835490-57d7-4e26-7474-008b2c4c6b39@suse.cz>
Date:   Tue, 22 Nov 2022 16:35:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH mm-unstable v1 08/20] mm: extend FAULT_FLAG_UNSHARE
 support to anything in a COW mapping
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
 <20221116102659.70287-9-david@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221116102659.70287-9-david@redhat.com>
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
> Extend FAULT_FLAG_UNSHARE to break COW on anything mapped into a
> COW (i.e., private writable) mapping and adjust the documentation
> accordingly.
> 
> FAULT_FLAG_UNSHARE will now also break COW when encountering the shared
> zeropage, a pagecache page, a PFNMAP, ... inside a COW mapping, by
> properly replacing the mapped page/pfn by a private copy (an exclusive
> anonymous page).
> 
> Note that only do_wp_page() needs care: hugetlb_wp() already handles
> FAULT_FLAG_UNSHARE correctly. wp_huge_pmd()/wp_huge_pud() also handles it
> correctly, for example, splitting the huge zeropage on FAULT_FLAG_UNSHARE
> such that we can handle FAULT_FLAG_UNSHARE on the PTE level.
> 
> This change is a requirement for reliable long-term R/O pinning in
> COW mappings.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/mm_types.h | 8 ++++----
>  mm/memory.c              | 4 ----
>  2 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 5e7f4fac1e78..5e9aaad8c7b2 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1037,9 +1037,9 @@ typedef struct {
>   * @FAULT_FLAG_REMOTE: The fault is not for current task/mm.
>   * @FAULT_FLAG_INSTRUCTION: The fault was during an instruction fetch.
>   * @FAULT_FLAG_INTERRUPTIBLE: The fault can be interrupted by non-fatal signals.
> - * @FAULT_FLAG_UNSHARE: The fault is an unsharing request to unshare (and mark
> - *                      exclusive) a possibly shared anonymous page that is
> - *                      mapped R/O.
> + * @FAULT_FLAG_UNSHARE: The fault is an unsharing request to break COW in a
> + *                      COW mapping, making sure that an exclusive anon page is
> + *                      mapped after the fault.
>   * @FAULT_FLAG_ORIG_PTE_VALID: whether the fault has vmf->orig_pte cached.
>   *                        We should only access orig_pte if this flag set.
>   *
> @@ -1064,7 +1064,7 @@ typedef struct {
>   *
>   * The combination FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE is illegal.
>   * FAULT_FLAG_UNSHARE is ignored and treated like an ordinary read fault when
> - * no existing R/O-mapped anonymous page is encountered.
> + * applied to mappings that are not COW mappings.
>   */
>  enum fault_flag {
>  	FAULT_FLAG_WRITE =		1 << 0,
> diff --git a/mm/memory.c b/mm/memory.c
> index d47ad33c6487..56b21ab1e4d2 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3432,10 +3432,6 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  		}
>  		wp_page_reuse(vmf);
>  		return 0;
> -	} else if (unshare) {
> -		/* No anonymous page -> nothing to do. */
> -		pte_unmap_unlock(vmf->pte, vmf->ptl);
> -		return 0;
>  	}
>  copy:
>  	/*

