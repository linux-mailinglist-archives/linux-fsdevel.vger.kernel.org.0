Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C51C7046C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 09:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjEPHpP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 03:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjEPHpO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 03:45:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4946A1FC9;
        Tue, 16 May 2023 00:45:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAAF560AFF;
        Tue, 16 May 2023 07:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E556C433D2;
        Tue, 16 May 2023 07:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684223112;
        bh=7BlG4EAaAQ/2PfJOByK6/yL6MquEqFQSgp+HP1sIrO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rIvMj1JmRgzYN1y+iVKqKvOkJp/1DmVR5JlVAwph4mcKzBnAFR1M+UEX/2O3Y+dYv
         DMj5yrVMHmmg2CPbXLrmFwOXJHHx2cL0finNLS6cke3kiK2QtuKhUD8pMyrYYIJaXH
         nmcAcHCoPmUrEyHKoc3eY30kwGjwvdx111WWwQl56Eup8W48WkJACGL6YCET7SooA4
         iJCWfehbNamCnfrj19DFONCzV5WGoEg0eEIMKBIFXvVwhCnxy2HIanrNdWsPq9f/hH
         PzUfoASABgYdCIyv32R57oCFO7DoPQbxl67VxGeeguaFbQUXT04PrAJybbPO2nzJPv
         UhUDEraTb2alQ==
Date:   Tue, 16 May 2023 10:45:05 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Yuanchu Xie <yuanchu@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Peter Xu <peterx@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: pagemap: restrict pagewalk to the requested range
Message-ID: <ZGM0gegQkvrQtq49@kernel.org>
References: <20230515172608.3558391-1-yuanchu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515172608.3558391-1-yuanchu@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 16, 2023 at 01:26:08AM +0800, Yuanchu Xie wrote:
> The pagewalk in pagemap_read reads one PTE past the end of the requested
> range, and stops when the buffer runs out of space. While it produces
> the right result, the extra read is unnecessary and less performant.
> 
> I timed the following command before and after this patch:
> 	dd count=100000 if=/proc/self/pagemap of=/dev/null
> The results are consistently within 0.001s across 5 runs.
> 
> Before:
> 100000+0 records in
> 100000+0 records out
> 51200000 bytes (51 MB) copied, 0.0763159 s, 671 MB/s
> 
> real    0m0.078s
> user    0m0.012s
> sys     0m0.065s
> 
> After:
> 100000+0 records in
> 100000+0 records out
> 51200000 bytes (51 MB) copied, 0.0487928 s, 1.0 GB/s
> 
> real    0m0.050s
> user    0m0.011s
> sys     0m0.039s
> 
> Signed-off-by: Yuanchu Xie <yuanchu@google.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  fs/proc/task_mmu.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 420510f6a545..6259dd432eeb 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1689,23 +1689,23 @@ static ssize_t pagemap_read(struct file *file, char __user *buf,
>  	/* watch out for wraparound */
>  	start_vaddr = end_vaddr;
>  	if (svpfn <= (ULONG_MAX >> PAGE_SHIFT)) {
> +		unsigned long end;
> +
>  		ret = mmap_read_lock_killable(mm);
>  		if (ret)
>  			goto out_free;
>  		start_vaddr = untagged_addr_remote(mm, svpfn << PAGE_SHIFT);
>  		mmap_read_unlock(mm);
> +
> +		end = start_vaddr + ((count / PM_ENTRY_BYTES) << PAGE_SHIFT);
> +		if (end >= start_vaddr && end < mm->task_size)
> +			end_vaddr = end;
>  	}
>  
>  	/* Ensure the address is inside the task */
>  	if (start_vaddr > mm->task_size)
>  		start_vaddr = end_vaddr;
>  
> -	/*
> -	 * The odds are that this will stop walking way
> -	 * before end_vaddr, because the length of the
> -	 * user buffer is tracked in "pm", and the walk
> -	 * will stop when we hit the end of the buffer.
> -	 */
>  	ret = 0;
>  	while (count && (start_vaddr < end_vaddr)) {
>  		int len;
> -- 
> 2.40.1.606.ga4b1b128d6-goog
> 
> 

-- 
Sincerely yours,
Mike.
