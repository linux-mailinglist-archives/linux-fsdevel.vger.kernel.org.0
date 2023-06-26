Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A01773E0E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 15:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjFZNlq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 09:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjFZNlp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:41:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A413F4;
        Mon, 26 Jun 2023 06:41:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0F33C21867;
        Mon, 26 Jun 2023 13:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687786902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nvrMGiHpP8dqIjK7zu4WtGJ8NhmqnwYO1zz07P5FzZw=;
        b=Qz7XcL/HzBpS4a3YE/6pzhzqg7KK7Q4L7hdbGwRVSbCl+dpn0ocUdjXQi9X1GneRvrdgrk
        AN/yplnhol1afovIWvUZhfJew9ePCDRiRGD6qhnkZCQznuNmtSaA5gbiq13s/XW5jtu65j
        a5y8zYcSbW6obWcwTd6DsNzF8Wq8Abo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687786902;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nvrMGiHpP8dqIjK7zu4WtGJ8NhmqnwYO1zz07P5FzZw=;
        b=DPxKDZF35wYWAhMBk0ccpJVemlJDEbDtIe6K0j0/ug9TkAkt/wkfqpuM1qAOFroSY1u/vq
        SgBSC3yatmAhdwBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED62D13483;
        Mon, 26 Jun 2023 13:41:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zzLmOZWVmWQCbgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 26 Jun 2023 13:41:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 82718A0754; Mon, 26 Jun 2023 15:41:41 +0200 (CEST)
Date:   Mon, 26 Jun 2023 15:41:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        willy@infradead.org, hch@infradead.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, beanhuo@micron.com
Subject: Re: [RESEND PATCH v3 1/2] fs/buffer: clean up block_commit_write
Message-ID: <20230626134141.reroeq3hj4tja24d@quack3>
References: <20230626055518.842392-1-beanhuo@iokpp.de>
 <20230626055518.842392-2-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626055518.842392-2-beanhuo@iokpp.de>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 26-06-23 07:55:17, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> Originally inode is used to get blksize, after commit 45bce8f3e343
> ("fs/buffer.c: make block-size be per-page and protected by the page lock"),
> __block_commit_write no longer uses this parameter inode.
> 
> Signed-off-by: Bean Huo <beanhuo@micron.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index bd091329026c..50821dfb02f7 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2180,8 +2180,7 @@ int __block_write_begin(struct page *page, loff_t pos, unsigned len,
>  }
>  EXPORT_SYMBOL(__block_write_begin);
>  
> -static int __block_commit_write(struct inode *inode, struct folio *folio,
> -		size_t from, size_t to)
> +static int __block_commit_write(struct folio *folio, size_t from, size_t to)
>  {
>  	size_t block_start, block_end;
>  	bool partial = false;
> @@ -2277,7 +2276,7 @@ int block_write_end(struct file *file, struct address_space *mapping,
>  	flush_dcache_folio(folio);
>  
>  	/* This could be a short (even 0-length) commit */
> -	__block_commit_write(inode, folio, start, start + copied);
> +	__block_commit_write(folio, start, start + copied);
>  
>  	return copied;
>  }
> @@ -2601,8 +2600,7 @@ EXPORT_SYMBOL(cont_write_begin);
>  int block_commit_write(struct page *page, unsigned from, unsigned to)
>  {
>  	struct folio *folio = page_folio(page);
> -	struct inode *inode = folio->mapping->host;
> -	__block_commit_write(inode, folio, from, to);
> +	__block_commit_write(folio, from, to);
>  	return 0;
>  }
>  EXPORT_SYMBOL(block_commit_write);
> @@ -2650,7 +2648,7 @@ int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
>  
>  	ret = __block_write_begin_int(folio, 0, end, get_block, NULL);
>  	if (!ret)
> -		ret = __block_commit_write(inode, folio, 0, end);
> +		ret = __block_commit_write(folio, 0, end);
>  
>  	if (unlikely(ret < 0))
>  		goto out_unlock;
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
