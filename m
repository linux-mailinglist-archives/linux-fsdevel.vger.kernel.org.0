Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2A255CCAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244623AbiF1Kpb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 06:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbiF1Kpb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:45:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319D031371;
        Tue, 28 Jun 2022 03:45:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D8D1A1FA12;
        Tue, 28 Jun 2022 10:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656413128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O0nt2J5ePcRV7nkaFA0OV/T6zQxmOqrbqRciI67/u2Q=;
        b=cjo/ofZKs9v9HXQskNf/9FY0eqNF0c6Sk8dQv7JicBnP9u5FUHKJRTduoByCU49b6b81E+
        J0w/eIhlkd/q1S9xeNY3Q4quxyHwl479Bqgq1gQ60bd9N4zgI+mX3xSNYjQYpaLHDDdamP
        D5oUz4Sf/PEMLFKyBzPSZ4oJ4dDfzT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656413128;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O0nt2J5ePcRV7nkaFA0OV/T6zQxmOqrbqRciI67/u2Q=;
        b=NIiPhwCUaumeJpV+tRv9qaxMJE7PD/ZW7e6ORLFYG0zuZmLhsngAZLg0cHPi1ZXbjaE1zr
        /B3814+aiuSxr9BQ==
Received: from quack3.suse.cz (dhcp194.suse.cz [10.100.51.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8D2042C141;
        Tue, 28 Jun 2022 10:45:28 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 68E24A062F; Tue, 28 Jun 2022 12:45:28 +0200 (CEST)
Date:   Tue, 28 Jun 2022 12:45:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Guowei Du <duguoweisz@gmail.com>
Cc:     jack@suse.cz, amir73il@gmail.com, repnop@google.com,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, duguowei <duguowei@xiaomi.com>
Subject: Re: [PATCH 6/6] fanotify: add current_user_instances node
Message-ID: <20220628104528.no4jarh2ihm5gxau@quack3>
References: <20220628101413.10432-1-duguoweisz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628101413.10432-1-duguoweisz@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 28-06-22 18:14:13, Guowei Du wrote:
> From: duguowei <duguowei@xiaomi.com>
> 
> Add a node of sysctl, which is current_user_instances.
> It shows current initialized group counts of system.
> 
> Signed-off-by: duguowei <duguowei@xiaomi.com>

Hum, I'm not sure about a wider context here but the changelog is certainly
missing a motivation of this change - why do you need this counter? In
particular because we already do maintain (and limit) the number of
fanotify groups each user has allocated in a particular namespace...

								Honza

> ---
>  fs/notify/fanotify/fanotify_user.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index c2255b440df9..39674fbffc4f 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -51,6 +51,8 @@
>  
>  /* configurable via /proc/sys/fs/fanotify/ */
>  static int fanotify_max_queued_events __read_mostly;
> +/* current initialized group count */
> +static int fanotify_user_instances __read_mostly;
>  
>  #ifdef CONFIG_SYSCTL
>  
> @@ -86,6 +88,14 @@ static struct ctl_table fanotify_table[] = {
>  		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= SYSCTL_ZERO
>  	},
> +	{
> +		.procname	= "current_user_instances",
> +		.data		= &fanotify_user_instances,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0444,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO
> +	},
>  	{ }
>  };
>  
> @@ -905,6 +915,8 @@ static int fanotify_release(struct inode *ignored, struct file *file)
>  	/* matches the fanotify_init->fsnotify_alloc_group */
>  	fsnotify_destroy_group(group);
>  
> +	fanotify_user_instances--;
> +
>  	return 0;
>  }
>  
> @@ -1459,6 +1471,8 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  	if (fd < 0)
>  		goto out_destroy_group;
>  
> +	fanotify_user_instances++;
> +
>  	return fd;
>  
>  out_destroy_group:
> -- 
> 2.36.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
