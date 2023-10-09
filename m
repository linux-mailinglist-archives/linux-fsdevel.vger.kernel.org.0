Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E517BE663
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 18:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377179AbjJIQaG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 12:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376275AbjJIQaF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:30:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE94C9C;
        Mon,  9 Oct 2023 09:30:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9EE1321885;
        Mon,  9 Oct 2023 16:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696869002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iJ25GEH2pINt3gABXbLxbOv+SPlRzVibKTVz/BRVbHI=;
        b=E7mwfyKJO5ILDPNPhyHNBZtMlYw9bRajg/xKfY4ftf5Z2kgqdciwaAGVRjTphiYfXa7T+r
        DOvTvmbRVzrmDy4V2taoWR7E5+N/+Ro5yCFwfiQTv9KG97SE3CxtulN7snbM3utqrIgH2O
        plWLCJxlm+vSKM5xSEu046lzsv2yeI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696869002;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iJ25GEH2pINt3gABXbLxbOv+SPlRzVibKTVz/BRVbHI=;
        b=PM7LMvvCUpOxI33nQ1Hzyf+Cen1eGQw//R0AbELg6yvkKDop/+NWHnuFMPVZm/PZFPcoX0
        HnCim9crdGFGP2DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 805AC13905;
        Mon,  9 Oct 2023 16:30:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BEC0HooqJGWiUQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 09 Oct 2023 16:30:02 +0000
Message-ID: <fe147a1e-6fe5-309f-b2e7-48f5f3c97bae@suse.cz>
Date:   Mon, 9 Oct 2023 18:30:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/4] mm: abstract VMA extension and merge into
 vma_merge_extend() helper
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <cover.1696795837.git.lstoakes@gmail.com>
 <1ed3d1ba0069104e1685298aa2baf980c38a85ff.1696795837.git.lstoakes@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <1ed3d1ba0069104e1685298aa2baf980c38a85ff.1696795837.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/8/23 22:23, Lorenzo Stoakes wrote:
> mremap uses vma_merge() in the case where a VMA needs to be extended. This
> can be significantly simplified and abstracted.
> 
> This makes it far easier to understand what the actual function is doing,
> avoids future mistakes in use of the confusing vma_merge() function and
> importantly allows us to make future changes to how vma_merge() is
> implemented by knowing explicitly which merge cases each invocation uses.
> 
> Note that in the mremap() extend case, we perform this merge only when
> old_len == vma->vm_end - addr. The extension_start, i.e. the start of the
> extended portion of the VMA is equal to addr + old_len, i.e. vma->vm_end.
> 
> With this refactoring, vma_merge() is no longer required anywhere except
> mm/mmap.c, so mark it static.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Nit:
> @@ -2546,6 +2546,24 @@ static struct vm_area_struct *vma_merge_new_vma(struct vma_iterator *vmi,
>  			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
>  }
>  
> +/*
> + * Expand vma by delta bytes, potentially merging with an immediately adjacent
> + * VMA with identical properties.
> + */
> +struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
> +					struct vm_area_struct *vma,
> +					unsigned long delta)
> +{
> +	pgoff_t pgoff = vma->vm_pgoff +
> +		((vma->vm_end - vma->vm_start) >> PAGE_SHIFT);

could use vma_pages() here

> +
> +	/* vma is specified as prev, so case 1 or 2 will apply. */
> +	return vma_merge(vmi, vma->vm_mm, vma, vma->vm_end, vma->vm_end + delta,
> +			 vma->vm_flags, vma->anon_vma, vma->vm_file, pgoff,
> +			 vma_policy(vma), vma->vm_userfaultfd_ctx,
> +			 anon_vma_name(vma));
> +}
> +
>  /*
>   * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
>   * @vmi: The vma iterator
