Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B1765B221
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jan 2023 13:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjABMeQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Jan 2023 07:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjABMeO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Jan 2023 07:34:14 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAB73886;
        Mon,  2 Jan 2023 04:34:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8454B340E0;
        Mon,  2 Jan 2023 12:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672662852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8qf88St9DDFohARjpxMOsSqgMfS644j5Qbz1lUlEwTA=;
        b=QbYIoA+3rISlQ6pkWz2FpTQp9Ef2cRZZmIXM1jBabftO0si6M98aY3HBkxSF4aXyQol+W+
        vNhpG2ciOS1AV02CVUK73UIZZgQbPPJZxybdLR4k737SbSZjtwmKIzaseCQ/jJjvP1uzVw
        P2PP7D6ZBaKg9i96FsM2bzNARfn/KaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672662852;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8qf88St9DDFohARjpxMOsSqgMfS644j5Qbz1lUlEwTA=;
        b=n0RiflyPoB6WlCPNWkzfRITt/7wOJIfAsiCZXXXuZDhn9VvtxEv1onmzDI0EqSr22odLRe
        lkY9CvqZrYbF6mBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 639EF139C8;
        Mon,  2 Jan 2023 12:34:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kmJiGETPsmO6EwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Jan 2023 12:34:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E2E12A073E; Mon,  2 Jan 2023 13:34:11 +0100 (CET)
Date:   Mon, 2 Jan 2023 13:34:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] fs/ext2: Replace kmap_atomic() with kmap_local_page()
Message-ID: <20230102123411.a7xgfocrbr56qruh@quack3>
References: <20221231174205.8492-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221231174205.8492-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 31-12-22 18:42:05, Fabio M. De Francesco wrote:
> kmap_atomic() is deprecated in favor of kmap_local_page(). Therefore,
> replace kmap_atomic() with kmap_local_page().
> 
> kmap_atomic() is implemented like a kmap_local_page() which also disables
> page-faults and preemption (the latter only for !PREEMPT_RT kernels).
> 
> However, the code within the mapping and un-mapping in ext2_make_empty()
> does not depend on the above-mentioned side effects.
> 
> Therefore, a mere replacement of the old API with the new one is all it
> is required (i.e., there is no need to explicitly add any calls to
> pagefault_disable() and/or preempt_disable()).
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks, the patch looks good and I'll queue it in my tree. I'm not sure why
it got missed during the initial conversion by Ira :).

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
>  fs/ext2/dir.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
> index e5cbc27ba459..0f144c5c7861 100644
> --- a/fs/ext2/dir.c
> +++ b/fs/ext2/dir.c
> @@ -646,7 +646,7 @@ int ext2_make_empty(struct inode *inode, struct inode *parent)
>  		unlock_page(page);
>  		goto fail;
>  	}
> -	kaddr = kmap_atomic(page);
> +	kaddr = kmap_local_page(page);
>  	memset(kaddr, 0, chunk_size);
>  	de = (struct ext2_dir_entry_2 *)kaddr;
>  	de->name_len = 1;
> @@ -661,7 +661,7 @@ int ext2_make_empty(struct inode *inode, struct inode *parent)
>  	de->inode = cpu_to_le32(parent->i_ino);
>  	memcpy (de->name, "..\0", 4);
>  	ext2_set_de_type (de, inode);
> -	kunmap_atomic(kaddr);
> +	kunmap_local(kaddr);
>  	ext2_commit_chunk(page, 0, chunk_size);
>  	err = ext2_handle_dirsync(inode);
>  fail:
> -- 
> 2.39.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
