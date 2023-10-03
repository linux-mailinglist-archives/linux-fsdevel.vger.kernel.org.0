Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262E67B69D2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 15:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjJCNGl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 09:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjJCNGk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:06:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ECAC4;
        Tue,  3 Oct 2023 06:06:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C0E9A1F45B;
        Tue,  3 Oct 2023 13:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696338395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hBW6aALkPO3CT6TaCsu8tN/6UcJj9gFut487AL5616w=;
        b=QcRQPssugIvbxgWLAS2VGtKXSx5CY+ZdaiiMLY/XHjeNBNDY9OvYCcKBYgNN59N2Ca9Ujt
        v9DWcdQk/XBqS9rfr/U1yUBwv7XK0fJXdts9d4QEXRdZPW4OIqFv1d/7TioCl6X+rIlGnE
        /8kAOQVAL1yabk1Ph3hrWl1Knj/wMvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696338395;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hBW6aALkPO3CT6TaCsu8tN/6UcJj9gFut487AL5616w=;
        b=LlKeH0O8KpUR1zRBRWw/IGDhqnN8yAglhJMlsJSXEM9+ntps/cNngnCnQkSIL9gIP8APUw
        MHCgdFAKRgkXWnAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0EBD132D4;
        Tue,  3 Oct 2023 13:06:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HSUnK9sRHGUvLgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 03 Oct 2023 13:06:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3C9D0A07CC; Tue,  3 Oct 2023 15:06:35 +0200 (CEST)
Date:   Tue, 3 Oct 2023 15:06:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/8] shmem: shrink shmem_inode_info: dir_offsets in a
 union
Message-ID: <20231003130635.hn2ljuorlf7rdodx@quack3>
References: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com>
 <86ebb4b-c571-b9e8-27f5-cb82ec50357e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ebb4b-c571-b9e8-27f5-cb82ec50357e@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 29-09-23 20:25:38, Hugh Dickins wrote:
> Shave 32 bytes off (the 64-bit) shmem_inode_info.  There was a 4-byte
> pahole after stop_eviction, better filled by fsflags.  And the 24-byte
> dir_offsets can only be used by directories, whereas shrinklist and
> swaplist only by shmem_mapping() inodes (regular files or long symlinks):
> so put those into a union.  No change in mm/shmem.c is required for this.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  include/linux/shmem_fs.h | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 6b0c626620f5..2caa6b86106a 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -23,18 +23,22 @@ struct shmem_inode_info {
>  	unsigned long		flags;
>  	unsigned long		alloced;	/* data pages alloced to file */
>  	unsigned long		swapped;	/* subtotal assigned to swap */
> -	pgoff_t			fallocend;	/* highest fallocate endindex */
> -	struct list_head        shrinklist;     /* shrinkable hpage inodes */
> -	struct list_head	swaplist;	/* chain of maybes on swap */
> +	union {
> +	    struct offset_ctx	dir_offsets;	/* stable directory offsets */
> +	    struct {
> +		struct list_head shrinklist;	/* shrinkable hpage inodes */
> +		struct list_head swaplist;	/* chain of maybes on swap */
> +	    };
> +	};
> +	struct timespec64	i_crtime;	/* file creation time */
>  	struct shared_policy	policy;		/* NUMA memory alloc policy */
>  	struct simple_xattrs	xattrs;		/* list of xattrs */
> +	pgoff_t			fallocend;	/* highest fallocate endindex */
> +	unsigned int		fsflags;	/* for FS_IOC_[SG]ETFLAGS */
>  	atomic_t		stop_eviction;	/* hold when working on inode */
> -	struct timespec64	i_crtime;	/* file creation time */
> -	unsigned int		fsflags;	/* flags for FS_IOC_[SG]ETFLAGS */
>  #ifdef CONFIG_TMPFS_QUOTA
>  	struct dquot		*i_dquot[MAXQUOTAS];
>  #endif
> -	struct offset_ctx	dir_offsets;	/* stable entry offsets */
>  	struct inode		vfs_inode;
>  };
>  
> -- 
> 2.35.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
