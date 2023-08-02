Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1807676D4DB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 19:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjHBROJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 13:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjHBROH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:14:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DF5E6F
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 10:14:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C55BB21A2F;
        Wed,  2 Aug 2023 17:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690996439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uOVh2SoVWe//hSreR01WhcY/eyZdAgmMhq5k/oX+ETI=;
        b=s7osewlzBYERDAb4mgI6/4vaURQC4pVNBsgubkaf6ck+AQmTEvVbna6HPXN9YJclVb51q5
        GgW+znc8POMV1vKP8jc/X3Vj9E9+98bGyPMRyn2O5BfidXb53lDr6cIxoIjigUAigPyNg/
        UsgAkvhZK0lbYBKwMVaYB4pni1ghtIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690996439;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uOVh2SoVWe//hSreR01WhcY/eyZdAgmMhq5k/oX+ETI=;
        b=dnSfYDCdnz8919OgQ7SP59TiLwMadvIaeEEqStEqeltNxEKC6XLKrn1ytWKt7i05eLdWlX
        5k6QEuODQYFRx7Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D69D13919;
        Wed,  2 Aug 2023 17:13:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9F1rJteOymQ8YAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 02 Aug 2023 17:13:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 17D78A076B; Wed,  2 Aug 2023 19:13:59 +0200 (CEST)
Date:   Wed, 2 Aug 2023 19:13:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Karel Zak <kzak@redhat.com>,
        linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 1/4] super: remove get_tree_single_reconf()
Message-ID: <20230802171359.wjmzyt7xn4aovp2k@quack3>
References: <20230802-vfs-super-exclusive-v2-0-95dc4e41b870@kernel.org>
 <20230802-vfs-super-exclusive-v2-1-95dc4e41b870@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802-vfs-super-exclusive-v2-1-95dc4e41b870@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 02-08-23 13:57:03, Christian Brauner wrote:
> The get_tree_single_reconf() helper isn't used anywhere. Remote it.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c                 | 28 +++++-----------------------
>  include/linux/fs_context.h |  3 ---
>  2 files changed, 5 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 3ef39df5bec5..9aaf0fbad036 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1136,7 +1136,7 @@ static int test_single_super(struct super_block *s, struct fs_context *fc)
>  	return 1;
>  }
>  
> -static int vfs_get_super(struct fs_context *fc, bool reconf,
> +static int vfs_get_super(struct fs_context *fc,
>  		int (*test)(struct super_block *, struct fs_context *),
>  		int (*fill_super)(struct super_block *sb,
>  				  struct fs_context *fc))
> @@ -1154,19 +1154,9 @@ static int vfs_get_super(struct fs_context *fc, bool reconf,
>  			goto error;
>  
>  		sb->s_flags |= SB_ACTIVE;
> -		fc->root = dget(sb->s_root);
> -	} else {
> -		fc->root = dget(sb->s_root);
> -		if (reconf) {
> -			err = reconfigure_super(fc);
> -			if (err < 0) {
> -				dput(fc->root);
> -				fc->root = NULL;
> -				goto error;
> -			}
> -		}
>  	}
>  
> +	fc->root = dget(sb->s_root);
>  	return 0;
>  
>  error:
> @@ -1178,7 +1168,7 @@ int get_tree_nodev(struct fs_context *fc,
>  		  int (*fill_super)(struct super_block *sb,
>  				    struct fs_context *fc))
>  {
> -	return vfs_get_super(fc, false, NULL, fill_super);
> +	return vfs_get_super(fc, NULL, fill_super);
>  }
>  EXPORT_SYMBOL(get_tree_nodev);
>  
> @@ -1186,25 +1176,17 @@ int get_tree_single(struct fs_context *fc,
>  		  int (*fill_super)(struct super_block *sb,
>  				    struct fs_context *fc))
>  {
> -	return vfs_get_super(fc, false, test_single_super, fill_super);
> +	return vfs_get_super(fc, test_single_super, fill_super);
>  }
>  EXPORT_SYMBOL(get_tree_single);
>  
> -int get_tree_single_reconf(struct fs_context *fc,
> -		  int (*fill_super)(struct super_block *sb,
> -				    struct fs_context *fc))
> -{
> -	return vfs_get_super(fc, true, test_single_super, fill_super);
> -}
> -EXPORT_SYMBOL(get_tree_single_reconf);
> -
>  int get_tree_keyed(struct fs_context *fc,
>  		  int (*fill_super)(struct super_block *sb,
>  				    struct fs_context *fc),
>  		void *key)
>  {
>  	fc->s_fs_info = key;
> -	return vfs_get_super(fc, false, test_keyed_super, fill_super);
> +	return vfs_get_super(fc, test_keyed_super, fill_super);
>  }
>  EXPORT_SYMBOL(get_tree_keyed);
>  
> diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
> index ff6341e09925..851b3fe2549c 100644
> --- a/include/linux/fs_context.h
> +++ b/include/linux/fs_context.h
> @@ -150,9 +150,6 @@ extern int get_tree_nodev(struct fs_context *fc,
>  extern int get_tree_single(struct fs_context *fc,
>  			 int (*fill_super)(struct super_block *sb,
>  					   struct fs_context *fc));
> -extern int get_tree_single_reconf(struct fs_context *fc,
> -			 int (*fill_super)(struct super_block *sb,
> -					   struct fs_context *fc));
>  extern int get_tree_keyed(struct fs_context *fc,
>  			 int (*fill_super)(struct super_block *sb,
>  					   struct fs_context *fc),
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
