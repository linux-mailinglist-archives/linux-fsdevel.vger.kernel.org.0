Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9D36FD36B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 03:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjEJBHp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 21:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjEJBHn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 21:07:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8228E46B7;
        Tue,  9 May 2023 18:07:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2D33021B82;
        Wed, 10 May 2023 01:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683680859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KDOIbYCc8cEVMo43jDWz1q3omhbKLsZ5bmHLW9Q3nx0=;
        b=KmfsshDJwbLSI9cQhJej3WeTjpKKdwn/WDh8CVfdB1s7174IS5BgrWvujONqgpG8GL4ZOC
        yry0mnSO/Z3LYH6RZla3Lo/Nbiw/q5jeTbO2R1U2rsUsSUAXxLZ8ulMPM0yYjOzbGHT6xG
        GoQlrWw52E/pYd/iAK+o6rXO21lF9Ks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683680859;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KDOIbYCc8cEVMo43jDWz1q3omhbKLsZ5bmHLW9Q3nx0=;
        b=lhGqPBcFXZod3cdJf8lThYcIRHii/80QYIW+AUgflS4q86KK+kz0naRXucwEwl0lcStpKR
        Td9br/xgIgxz9XCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F1D0113416;
        Wed, 10 May 2023 01:07:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 66AEO1ruWmTVMwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 10 May 2023 01:07:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 490FDA0745; Wed, 10 May 2023 03:07:37 +0200 (CEST)
Date:   Wed, 10 May 2023 03:07:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH 06/32] sched: Add task_struct->faults_disabled_mapping
Message-ID: <20230510010737.heniyuxazlprrbd6@quack3>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-7-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509165657.1735798-7-kent.overstreet@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 09-05-23 12:56:31, Kent Overstreet wrote:
> From: Kent Overstreet <kent.overstreet@gmail.com>
> 
> This is used by bcachefs to fix a page cache coherency issue with
> O_DIRECT writes.
> 
> Also relevant: mapping->invalidate_lock, see below.
> 
> O_DIRECT writes (and other filesystem operations that modify file data
> while bypassing the page cache) need to shoot down ranges of the page
> cache - and additionally, need locking to prevent those pages from
> pulled back in.
> 
> But O_DIRECT writes invoke the page fault handler (via get_user_pages),
> and the page fault handler will need to take that same lock - this is a
> classic recursive deadlock if userspace has mmaped the file they're DIO
> writing to and uses those pages for the buffer to write from, and it's a
> lock ordering deadlock in general.
> 
> Thus we need a way to signal from the dio code to the page fault handler
> when we already are holding the pagecache add lock on an address space -
> this patch just adds a member to task_struct for this purpose. For now
> only bcachefs is implementing this locking, though it may be moved out
> of bcachefs and made available to other filesystems in the future.

It would be nice to have at least a link to the code that's actually using
the field you are adding.

Also I think we were already through this discussion [1] and we ended up
agreeing that your scheme actually solves only the AA deadlock but a
malicious userspace can easily create AB BA deadlock by running direct IO
to file A using mapped file B as a buffer *and* direct IO to file B using
mapped file A as a buffer.

[1] https://lore.kernel.org/all/20191218124052.GB19387@quack2.suse.cz

> ---------------------------------
> 
> The closest current VFS equivalent is mapping->invalidate_lock, which
> comes from XFS. However, it's not used by direct IO.  Instead, direct IO
> paths shoot down the page cache twice - before starting the IO and at
> the end, and they're still technically racy w.r.t. page cache coherency.
> 
> This is a more complete approach: in the future we might consider
> replacing mapping->invalidate_lock with the bcachefs code.

Yes, and this is because we never provided 100% consistent buffered VS
direct IO behavior on the same file exactly because we never found the
complexity worth the usefulness...

								Honza

> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> ---
>  include/linux/sched.h | 1 +
>  init/init_task.c      | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 63d242164b..f2a56f64f7 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -869,6 +869,7 @@ struct task_struct {
>  
>  	struct mm_struct		*mm;
>  	struct mm_struct		*active_mm;
> +	struct address_space		*faults_disabled_mapping;
>  
>  	int				exit_state;
>  	int				exit_code;
> diff --git a/init/init_task.c b/init/init_task.c
> index ff6c4b9bfe..f703116e05 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -85,6 +85,7 @@ struct task_struct init_task
>  	.nr_cpus_allowed= NR_CPUS,
>  	.mm		= NULL,
>  	.active_mm	= &init_mm,
> +	.faults_disabled_mapping = NULL,
>  	.restart_block	= {
>  		.fn = do_no_restart_syscall,
>  	},
> -- 
> 2.40.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
