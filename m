Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B051C616DBB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 20:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiKBTVX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 15:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKBTVW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 15:21:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF811144;
        Wed,  2 Nov 2022 12:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=utt30JAJTgovEUnU7oZUHBSJjF7rzQywZWScCNuHRzY=; b=WPA3CheUPO+l2TLbtJ8F4sMjDY
        wuzW0rXM8/YT9+GS5bvCyNPAOVDTCdMZDfDmnEQ43hM8popaQVmO8joNM3aFWyHduRQ4eui3OXRgq
        eSafeyeT0YVoCmB3xSkQ6blaJFiS/555XUSI8y8stBxOr6eRzE5h1Gs8G6a1fiQz7ew/m2QUbY+D5
        mA6b3eEuM+tkoyEHlmtTZHUjmeqoL7Qfi9TYfB9VSYpeMkhLIREIFq0uDEVrRSvjSq/3ahoR9Qfor
        7/2A4QwC7pJ/PLrhQx2mIAtD6jS/CMbSMq2cnEwkdIUybVR4+Zkpju3W6ThTOF1jzL6Ryq/ih3woJ
        cyc5vPEg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqJId-005mDl-8K; Wed, 02 Nov 2022 19:21:19 +0000
Date:   Wed, 2 Nov 2022 19:21:19 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH 3/5] userfualtfd: Replace lru_cache functions with
 folio_add functions
Message-ID: <Y2LDL8zjgxDPCzH9@casper.infradead.org>
References: <20221101175326.13265-1-vishal.moola@gmail.com>
 <20221101175326.13265-4-vishal.moola@gmail.com>
 <Y2Fl/pZyLSw/ddZY@casper.infradead.org>
 <Y2K+y7wnhC4vbnP2@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2K+y7wnhC4vbnP2@x1n>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 02, 2022 at 03:02:35PM -0400, Peter Xu wrote:
> Does the patch attached look reasonable to you?

Mmm, no.  If the page is in the swap cache, this will be "true".

> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 3d0fef3980b3..650ab6cfd5f4 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -64,7 +64,7 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
>  	pte_t _dst_pte, *dst_pte;
>  	bool writable = dst_vma->vm_flags & VM_WRITE;
>  	bool vm_shared = dst_vma->vm_flags & VM_SHARED;
> -	bool page_in_cache = page->mapping;
> +	bool page_in_cache = page_mapping(page);

We could do:

	struct page *head = compound_head(page);
	bool page_in_cache = head->mapping && !PageMappingFlags(head);

