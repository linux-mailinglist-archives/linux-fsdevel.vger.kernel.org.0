Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CC16EA68C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 11:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjDUJGy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 05:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjDUJGk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:06:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F8EAD17;
        Fri, 21 Apr 2023 02:06:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0C14E1FDE0;
        Fri, 21 Apr 2023 09:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682067989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HX10+0HDLIsn0cxmTn+6s9NsLefeOwSabewyiDJe+5k=;
        b=pppH1y8+pFI+CVSu6LPDj+RobOVhVIVsgrrNhZNKPDD6yTftnzjvOKQsF/cAJKV/BsFZmq
        FDtvMxKBD7MqPp/2f6GgVWeUpW5suvGhF/+IqxGKsA2nme7Z2ACm0j0K+lvz16TPajyn4X
        yhone20sK04L1gSFgzuryxTlyusdFUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682067989;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HX10+0HDLIsn0cxmTn+6s9NsLefeOwSabewyiDJe+5k=;
        b=H0zEBcWZ/j3jzNziddPjbRDEmEctQ4E+qlP8PZdjtWknCa69iQgmCgPiC/OX6v2WYnd+tU
        4x6dNUlO3TwzRmCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0F1D13456;
        Fri, 21 Apr 2023 09:06:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7mLOOhRSQmS0QwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 21 Apr 2023 09:06:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 86ED4A0729; Fri, 21 Apr 2023 11:06:28 +0200 (CEST)
Date:   Fri, 21 Apr 2023 11:06:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC PATCH 3/3] mm: perform the mapping_map_writable() check
 after call_mmap()
Message-ID: <20230421090628.347b6qojxvfsgoqk@quack3>
References: <cover.1680560277.git.lstoakes@gmail.com>
 <c814a3694f09896e4ec85cbca74069ea6174ebb6.1680560277.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c814a3694f09896e4ec85cbca74069ea6174ebb6.1680560277.git.lstoakes@gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 03-04-23 23:28:32, Lorenzo Stoakes wrote:
> In order for a F_SEAL_WRITE sealed memfd mapping to have an opportunity to
> clear VM_MAYWRITE, we must be able to invoke the appropriate vm_ops->mmap()
> handler to do so. We would otherwise fail the mapping_map_writable() check
> before we had the opportunity to avoid it.
> 
> This patch moves this check after the call_mmap() invocation. Only memfd
> actively denies write access causing a potential failure here (in
> memfd_add_seals()), so there should be no impact on non-memfd cases.
> 
> This patch makes the userland-visible change that MAP_SHARED, PROT_READ
> mappings of an F_SEAL_WRITE sealed memfd mapping will now succeed.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  mm/mmap.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index c96dcce90772..a166e9f3c474 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2596,17 +2596,17 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	vma->vm_pgoff = pgoff;
>  
>  	if (file) {
> -		if (is_shared_maywrite(vm_flags)) {
> -			error = mapping_map_writable(file->f_mapping);
> -			if (error)
> -				goto free_vma;
> -		}
> -
>  		vma->vm_file = get_file(file);
>  		error = call_mmap(file, vma);
>  		if (error)
>  			goto unmap_and_free_vma;
>  
> +		if (vma_is_shared_maywrite(vma)) {
> +			error = mapping_map_writable(file->f_mapping);
> +			if (error)
> +				goto unmap_and_free_vma;

Shouldn't we rather jump to close_and_free_vma?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
