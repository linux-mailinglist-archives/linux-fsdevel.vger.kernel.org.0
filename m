Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A48711071
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 18:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbjEYQH6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 12:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbjEYQHy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 12:07:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D037E61;
        Thu, 25 May 2023 09:07:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C3C7A21BD3;
        Thu, 25 May 2023 16:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685030845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6fUmMKEP0NVxF0dlYJ3RY0KP8iLVIJxr+Cik8LTdcs0=;
        b=tVp0qzVwlCNA27cvyif8ZJzfdvr0nmHI96GB1JWTQpMQs4ZdakZMUZ2rGnFUCas5JfQBU2
        UYxQ3x0JlGRia0jsPOsyC7qghzYza254c2wM2DvHqG00ztXcSeOBRjMroQJh2ZxjjMxtCc
        5DSwnqxg/m9XWuORKLsTYCcK6UVLPno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685030845;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6fUmMKEP0NVxF0dlYJ3RY0KP8iLVIJxr+Cik8LTdcs0=;
        b=bkY2qer6sn5GnmrBSL9dYeISnx+U55IZWNeE5Ei3jBtweIcQgK7skYuDEVsB3lVqUStOUb
        hAxH/SFvbCPPtQBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B172F13356;
        Thu, 25 May 2023 16:07:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gX42K72Hb2ScGgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 25 May 2023 16:07:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C3764A075C; Thu, 25 May 2023 18:07:24 +0200 (CEST)
Date:   Thu, 25 May 2023 18:07:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hch@infradead.org, djwong@kernel.org, sandeen@sandeen.net,
        song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jikos@kernel.org,
        bvanassche@acm.org, ebiederm@xmission.com, mchehab@kernel.org,
        keescook@chromium.org, p.raghav@samsung.com, da.gomez@samsung.com,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ext4: replace kthread freezing with auto fs freezing
Message-ID: <20230525160724.aqpwh5bapsw57uwm@quack3>
References: <20230508011927.4036707-1-mcgrof@kernel.org>
 <20230508011927.4036707-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508011927.4036707-2-mcgrof@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 07-05-23 18:19:25, Luis Chamberlain wrote:
> The kernel power management now supports allowing the VFS
> to handle filesystem freezing freezes and thawing. Take advantage
> of that and remove the kthread freezing. This is needed so that we
> properly really stop IO in flight without races after userspace
> has been frozen. Without this we rely on kthread freezing and
> its semantics are loose and error prone.
> 
> The filesystem therefore is in charge of properly dealing with
> quiescing of the filesystem through its callbacks if it thinks
> it knows better than how the VFS handles it.
> 
> The following Coccinelle rule was used as to remove the now superfluous
> freezer calls:
> 
> make coccicheck MODE=patch SPFLAGS="--in-place --no-show-diff" COCCI=./fs-freeze-cleanup.cocci M=fs/ext4
> 
> virtual patch
> 
> @ remove_set_freezable @
> expression time;
> statement S, S2;
> expression task, current;
> @@
> 
> (
> -       set_freezable();
> |
> -       if (try_to_freeze())
> -               continue;
> |
> -       try_to_freeze();
> |
> -       freezable_schedule();
> +       schedule();
> |
> -       freezable_schedule_timeout(time);
> +       schedule_timeout(time);
> |
> -       if (freezing(task)) { S }
> |
> -       if (freezing(task)) { S }
> -       else
> 	    { S2 }
> |
> -       freezing(current)
> )
> 
> @ remove_wq_freezable @
> expression WQ_E, WQ_ARG1, WQ_ARG2, WQ_ARG3, WQ_ARG4;
> identifier fs_wq_fn;
> @@
> 
> (
>     WQ_E = alloc_workqueue(WQ_ARG1,
> -                              WQ_ARG2 | WQ_FREEZABLE,
> +                              WQ_ARG2,
> 			   ...);
> |
>     WQ_E = alloc_workqueue(WQ_ARG1,
> -                              WQ_ARG2 | WQ_FREEZABLE | WQ_ARG3,
> +                              WQ_ARG2 | WQ_ARG3,
> 			   ...);
> |
>     WQ_E = alloc_workqueue(WQ_ARG1,
> -                              WQ_ARG2 | WQ_ARG3 | WQ_FREEZABLE,
> +                              WQ_ARG2 | WQ_ARG3,
> 			   ...);
> |
>     WQ_E = alloc_workqueue(WQ_ARG1,
> -                              WQ_ARG2 | WQ_ARG3 | WQ_FREEZABLE | WQ_ARG4,
> +                              WQ_ARG2 | WQ_ARG3 | WQ_ARG4,
> 			   ...);
> |
> 	    WQ_E =
> -               WQ_ARG1 | WQ_FREEZABLE
> +               WQ_ARG1
> |
> 	    WQ_E =
> -               WQ_ARG1 | WQ_FREEZABLE | WQ_ARG3
> +               WQ_ARG1 | WQ_ARG3
> |
>     fs_wq_fn(
> -               WQ_FREEZABLE | WQ_ARG2 | WQ_ARG3
> +               WQ_ARG2 | WQ_ARG3
>     )
> |
>     fs_wq_fn(
> -               WQ_FREEZABLE | WQ_ARG2
> +               WQ_ARG2
>     )
> |
>     fs_wq_fn(
> -               WQ_FREEZABLE
> +               0
>     )
> )
> 
> @ add_auto_flag @
> expression E1;
> identifier fs_type;
> @@
> 
> struct file_system_type fs_type = {
> 	.fs_flags = E1
> +                   | FS_AUTOFREEZE
> 	,
> };
> 
> Generated-by: Coccinelle SmPL
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

I guess we can also usually remove the #include <linux/freezer.h> line? At
least in ext4 it is the case I believe. Otherwise this looks good.

								Honza

> ---
>  fs/ext4/super.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index d39f386e9baf..1f436938d8be 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -136,7 +136,7 @@ static struct file_system_type ext2_fs_type = {
>  	.init_fs_context	= ext4_init_fs_context,
>  	.parameters		= ext4_param_specs,
>  	.kill_sb		= kill_block_super,
> -	.fs_flags		= FS_REQUIRES_DEV,
> +	.fs_flags		= FS_REQUIRES_DEV | FS_AUTOFREEZE,
>  };
>  MODULE_ALIAS_FS("ext2");
>  MODULE_ALIAS("ext2");
> @@ -152,7 +152,7 @@ static struct file_system_type ext3_fs_type = {
>  	.init_fs_context	= ext4_init_fs_context,
>  	.parameters		= ext4_param_specs,
>  	.kill_sb		= kill_block_super,
> -	.fs_flags		= FS_REQUIRES_DEV,
> +	.fs_flags		= FS_REQUIRES_DEV | FS_AUTOFREEZE,
>  };
>  MODULE_ALIAS_FS("ext3");
>  MODULE_ALIAS("ext3");
> @@ -3790,7 +3790,6 @@ static int ext4_lazyinit_thread(void *arg)
>  	unsigned long next_wakeup, cur;
>  
>  	BUG_ON(NULL == eli);
> -	set_freezable();
>  
>  cont_thread:
>  	while (true) {
> @@ -3842,8 +3841,6 @@ static int ext4_lazyinit_thread(void *arg)
>  		}
>  		mutex_unlock(&eli->li_list_mtx);
>  
> -		try_to_freeze();
> -
>  		cur = jiffies;
>  		if ((time_after_eq(cur, next_wakeup)) ||
>  		    (MAX_JIFFY_OFFSET == next_wakeup)) {
> @@ -7245,7 +7242,7 @@ static struct file_system_type ext4_fs_type = {
>  	.init_fs_context	= ext4_init_fs_context,
>  	.parameters		= ext4_param_specs,
>  	.kill_sb		= kill_block_super,
> -	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
> +	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_AUTOFREEZE,
>  };
>  MODULE_ALIAS_FS("ext4");
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
