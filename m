Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715F665B52B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jan 2023 17:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbjABQjO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Jan 2023 11:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABQjN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:39:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532F11D4;
        Mon,  2 Jan 2023 08:39:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8D54E5C64C;
        Mon,  2 Jan 2023 16:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672677549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=blL9CkQczhX/shYpuKJ5vpzvxPNVo08LCejCIx/lGTw=;
        b=sQ32aBfSpXU1RqGPwxJ0+JKuLhdnwPuWXgtZ9CjueXgVwwNJyPnc93Uubdqb1c4rW6l2qr
        wW0kBt+Z3/3ekG4TPs04iPTdy91AcxkU5PcYSLvBDnaTXSCu3OEtKbjMtHwresB/Tuwkm7
        GIxCdzIuePk8YoN3uRtaJvBcBdubQVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672677549;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=blL9CkQczhX/shYpuKJ5vpzvxPNVo08LCejCIx/lGTw=;
        b=D1PmfiOfLluBB2j8rVVuJG9zj+EWVAdEWK7OELTNoc8w5ZjLjjAVQCP6NLMVnP/MEO7JW4
        B3LxITtA4xiuVpBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7EDCF139C8;
        Mon,  2 Jan 2023 16:39:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kIPxHq0Is2N3CwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Jan 2023 16:39:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D7947A0742; Mon,  2 Jan 2023 17:39:08 +0100 (CET)
Date:   Mon, 2 Jan 2023 17:39:08 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] fs/ext4: Replace kmap_atomic() with kmap_local_page()
Message-ID: <20230102163908.gxe3afwgbfejbq4m@quack3>
References: <20221231174439.8557-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221231174439.8557-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 31-12-22 18:44:39, Fabio M. De Francesco wrote:
> kmap_atomic() is deprecated in favor of kmap_local_page(). Therefore,
> replace kmap_atomic() with kmap_local_page().
> 
> kmap_atomic() is implemented like a kmap_local_page() which also disables
> page-faults and preemption (the latter only for !PREEMPT_RT kernels).
> 
> However, the code within the mappings and un-mappings in ext4/inline.c
> does not depend on the above-mentioned side effects.
> 
> Therefore, a mere replacement of the old API with the new one is all it
> is required (i.e., there is no need to explicitly add any calls to
> pagefault_disable() and/or preempt_disable()).
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

The patch looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> I tried my best to understand the code within mapping and un-mapping.
> However, I'm not an expert. Therefore, although I'm pretty confident, I
> cannot be 100% sure that the code between the mapping and the un-mapping
> does not depend on pagefault_disable() and/or preempt_disable().
> 
> Unfortunately, I cannot currently test this changes to check the
> above-mentioned assumptions. However, if I'm required to do the tests
> with (x)fstests, I have no problems with doing them in the next days.
> 
> If so, I'll test in a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
> HIGHMEM64GB enabled.
> 
> I'd like to hear whether or not the maintainers require these tests
> and/or other tests.
> 
>  fs/ext4/inline.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 2b42ececa46d..bfb044425d8a 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -490,10 +490,10 @@ static int ext4_read_inline_page(struct inode *inode, struct page *page)
>  		goto out;
>  
>  	len = min_t(size_t, ext4_get_inline_size(inode), i_size_read(inode));
> -	kaddr = kmap_atomic(page);
> +	kaddr = kmap_local_page(page);
>  	ret = ext4_read_inline_data(inode, kaddr, len, &iloc);
>  	flush_dcache_page(page);
> -	kunmap_atomic(kaddr);
> +	kunmap_local(kaddr);
>  	zero_user_segment(page, len, PAGE_SIZE);
>  	SetPageUptodate(page);
>  	brelse(iloc.bh);
> @@ -763,9 +763,9 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
>  		 */
>  		(void) ext4_find_inline_data_nolock(inode);
>  
> -		kaddr = kmap_atomic(page);
> +		kaddr = kmap_local_page(page);
>  		ext4_write_inline_data(inode, &iloc, kaddr, pos, copied);
> -		kunmap_atomic(kaddr);
> +		kunmap_local(kaddr);
>  		SetPageUptodate(page);
>  		/* clear page dirty so that writepages wouldn't work for us. */
>  		ClearPageDirty(page);
> @@ -831,9 +831,9 @@ ext4_journalled_write_inline_data(struct inode *inode,
>  	}
>  
>  	ext4_write_lock_xattr(inode, &no_expand);
> -	kaddr = kmap_atomic(page);
> +	kaddr = kmap_local_page(page);
>  	ext4_write_inline_data(inode, &iloc, kaddr, 0, len);
> -	kunmap_atomic(kaddr);
> +	kunmap_local(kaddr);
>  	ext4_write_unlock_xattr(inode, &no_expand);
>  
>  	return iloc.bh;
> -- 
> 2.39.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
