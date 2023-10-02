Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93F27B4F7C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 11:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236273AbjJBJth (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 05:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236261AbjJBJtg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:49:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB2183;
        Mon,  2 Oct 2023 02:49:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 72D232185C;
        Mon,  2 Oct 2023 09:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696240172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j+NdBRB608UMGwx19cp+azxH113d9HD7eQvWbnS3E3c=;
        b=E+VgZxU2q7CeNul975RN62i/o1qDZ41PCZ1yfpJ/5EpmyZ2G8JL3Jn7cukYgFh2niPOfWc
        SyETRyyDPubwOSlZT1g8pQ9/vahrFzS+iL6blQ33WfjlQMvm98l8e2Juw/3AINPSSM8jtj
        ayW3HiPv0UwgPQLGj+ef8g7/mj5okiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696240172;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j+NdBRB608UMGwx19cp+azxH113d9HD7eQvWbnS3E3c=;
        b=iRcq7NUyaP5be6nrcnYMoyljbjqkeyYLsaQZ4eSy3U1GaWLLWqRA9usXG8xjAdPx+QUsyb
        9DNRCd1OwrwuHgAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6381613434;
        Mon,  2 Oct 2023 09:49:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LFFDGCySGmUkTwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Oct 2023 09:49:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EEDC5A07C9; Mon,  2 Oct 2023 11:49:31 +0200 (CEST)
Date:   Mon, 2 Oct 2023 11:49:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 09/29] ext2: move ext2_xattr_handlers and
 ext2_xattr_handler_map to .rodata
Message-ID: <20231002094931.yalzcksclq77qjvx@quack3>
References: <20230930050033.41174-1-wedsonaf@gmail.com>
 <20230930050033.41174-10-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230930050033.41174-10-wedsonaf@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 30-09-23 02:00:13, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> This makes it harder for accidental or malicious changes to
> ext2_xattr_handlers or ext2_xattr_handler_map at runtime.
> 
> Cc: Jan Kara <jack@suse.com>
> Cc: linux-ext4@vger.kernel.org
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>

Looks good to me. Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext2/xattr.c | 4 ++--
>  fs/ext2/xattr.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> index 8906ba479aaf..cfbe376da612 100644
> --- a/fs/ext2/xattr.c
> +++ b/fs/ext2/xattr.c
> @@ -98,7 +98,7 @@ static struct buffer_head *ext2_xattr_cache_find(struct inode *,
>  static void ext2_xattr_rehash(struct ext2_xattr_header *,
>  			      struct ext2_xattr_entry *);
>  
> -static const struct xattr_handler *ext2_xattr_handler_map[] = {
> +static const struct xattr_handler * const ext2_xattr_handler_map[] = {
>  	[EXT2_XATTR_INDEX_USER]		     = &ext2_xattr_user_handler,
>  #ifdef CONFIG_EXT2_FS_POSIX_ACL
>  	[EXT2_XATTR_INDEX_POSIX_ACL_ACCESS]  = &nop_posix_acl_access,
> @@ -110,7 +110,7 @@ static const struct xattr_handler *ext2_xattr_handler_map[] = {
>  #endif
>  };
>  
> -const struct xattr_handler *ext2_xattr_handlers[] = {
> +const struct xattr_handler * const ext2_xattr_handlers[] = {
>  	&ext2_xattr_user_handler,
>  	&ext2_xattr_trusted_handler,
>  #ifdef CONFIG_EXT2_FS_SECURITY
> diff --git a/fs/ext2/xattr.h b/fs/ext2/xattr.h
> index 7925f596e8e2..6a4966949047 100644
> --- a/fs/ext2/xattr.h
> +++ b/fs/ext2/xattr.h
> @@ -72,7 +72,7 @@ extern void ext2_xattr_delete_inode(struct inode *);
>  extern struct mb_cache *ext2_xattr_create_cache(void);
>  extern void ext2_xattr_destroy_cache(struct mb_cache *cache);
>  
> -extern const struct xattr_handler *ext2_xattr_handlers[];
> +extern const struct xattr_handler * const ext2_xattr_handlers[];
>  
>  # else  /* CONFIG_EXT2_FS_XATTR */
>  
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
