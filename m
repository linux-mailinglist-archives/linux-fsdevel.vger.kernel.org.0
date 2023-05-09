Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851C06FBC6B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 03:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbjEIBUU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 21:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbjEIBUT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 21:20:19 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0A76E9E
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 May 2023 18:20:17 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6439d505274so2842157b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 May 2023 18:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1683595217; x=1686187217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qvnKgDrLdGbPYsBYq8JxxD98sZ+MraP0qApL2fP5if4=;
        b=iufZEJq7q54DB+83WSv76z5TKf12tRvtuirtcVl8etOYO+KDFOgEs5HzHXV8UXRpls
         Gx1bclRmOPbq+s8Vfe44vd84pPXampuZyNEXwvmXDrBKdl2YExdkv4IRON39ESkJqC2i
         8Ot/Te9Xub2Tw9BnsW4b0h5PTrp1lvtA2B6Jm9kTB5uaoeemy8aI2Ju2wLN5k1aL5Tf2
         Bdvfs2SrGIHa91GTNbUcSC6537zXPmsiQgjjQPs79KsNpop9jDK11NwrITU9pCV8ObdZ
         W+69n1y8r7o6Kka1hCH0e6prx2fs+MbbbodjeFMOQK2sbc7ULVJKnKKg/gWK0LBJO080
         f3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683595217; x=1686187217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvnKgDrLdGbPYsBYq8JxxD98sZ+MraP0qApL2fP5if4=;
        b=kbXpOnxDAnN6+E/aVqAbs6oJnlNmRcmZIaoFUZPw2dAe397x+ovlWDM5YueeXo9mQu
         f5Cg4vz+yGsMG5pSqGbZG/JSkJ2yXNnJIucMK2vMGwihuP4eutPPekTzVaWaA2n2nEC0
         Gv65rgFSghSOmNwK606GiiGDdNNZ62HACrxbrcp68+npVcqXSO0Sqp1NMwQGNOqZZCL5
         b6edfVz9TBhIKVAFcAkpwiijktb/K8KYq++fde72jyPtR7cpNd/qJOLwMTjRqSqMomQD
         gbJIiZq3npBwnn3ey2MIxdFHcelznhvsmxSr/O/75TwucN7md+r5WOIJ70DxPoUv2JKv
         tWMQ==
X-Gm-Message-State: AC+VfDxgltfXNH4xWwODdFYeBOI77qPcqjTveXaZqJqLzNDsaJXQb1ln
        wsfmEAJBvEJ1k8NLadg3gvrrbg==
X-Google-Smtp-Source: ACHHUZ5h+1TgYj4KujZCQwdLTfcSFgNpCbTRC56j2A0dOjVoakdhu4USEX4rOpq23HrAkNhxodPAaw==
X-Received: by 2002:a05:6a00:2343:b0:644:d775:60bb with SMTP id j3-20020a056a00234300b00644d77560bbmr10814865pfj.20.1683595216924;
        Mon, 08 May 2023 18:20:16 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79251000000b006468222af91sm581010pfp.48.2023.05.08.18.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 18:20:16 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pwC1V-00D2Im-7t; Tue, 09 May 2023 11:20:13 +1000
Date:   Tue, 9 May 2023 11:20:13 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hch@infradead.org, djwong@kernel.org, sandeen@sandeen.net,
        song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jikos@kernel.org,
        bvanassche@acm.org, ebiederm@xmission.com, mchehab@kernel.org,
        keescook@chromium.org, p.raghav@samsung.com, da.gomez@samsung.com,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] fs: add automatic kernel fs freeze / thaw and remove
 kthread freezing
Message-ID: <20230509012013.GD2651828@dread.disaster.area>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-7-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508011717.4034511-7-mcgrof@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 07, 2023 at 06:17:17PM -0700, Luis Chamberlain wrote:
> Add support to automatically handle freezing and thawing filesystems
> during the kernel's suspend/resume cycle.
> 
> This is needed so that we properly really stop IO in flight without
> races after userspace has been frozen. Without this we rely on
> kthread freezing and its semantics are loose and error prone.
> For instance, even though a kthread may use try_to_freeze() and end
> up being frozen we have no way of being sure that everything that
> has been spawned asynchronously from it (such as timers) have also
> been stopped as well.
> 
> A long term advantage of also adding filesystem freeze / thawing
> supporting during suspend / hibernation is that long term we may
> be able to eventually drop the kernel's thread freezing completely
> as it was originally added to stop disk IO in flight as we hibernate
> or suspend.
> 
> This does not remove the superfluous freezer calls on all filesystems.
> Each filesystem must remove all the kthread freezer stuff and peg
> the fs_type flags as supporting auto-freezing with the FS_AUTOFREEZE
> flag.
> 
> Subsequent patches remove the kthread freezer usage from each
> filesystem, one at a time to make all this work bisectable.
> Once all filesystems remove the usage of the kthread freezer we
> can remove the FS_AUTOFREEZE flag.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  fs/super.c             | 50 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h     | 14 ++++++++++++
>  kernel/power/process.c | 15 ++++++++++++-
>  3 files changed, 78 insertions(+), 1 deletion(-)

.....

> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index cae81a87cc91..7ca7688f0b5d 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -140,6 +140,16 @@ int freeze_processes(void)
>  
>  	BUG_ON(in_atomic());
>  
> +	pr_info("Freezing filesystems ... ");
> +	error = iterate_supers_reverse_excl(fs_suspend_freeze_sb, NULL);
> +	if (error) {
> +		pr_cont("failed\n");
> +		iterate_supers_excl(fs_suspend_thaw_sb, NULL);
> +		thaw_processes();
> +		return error;

That looks wrong. i.e. if the sb iteration fails to freeze a
filesystem (for whatever reason) then every userspace frozen
filesystem will be thawed by this call, right? i.e. it will thaw
more than just the filesystems frozen by the suspend freeze
iteration before it failed.

Don't we only want to thaw the superblocks we froze before the
failure occurred? i.e. the "undo" iteration needs to start from the
last superblock we successfully froze and then only walk to the tail
of the list we started from?

> +	}
> +	pr_cont("done.\n");
> +
>  	/*
>  	 * Now that the whole userspace is frozen we need to disable
>  	 * the OOM killer to disallow any further interference with
> @@ -149,8 +159,10 @@ int freeze_processes(void)
>  	if (!error && !oom_killer_disable(msecs_to_jiffies(freeze_timeout_msecs)))
>  		error = -EBUSY;
>  
> -	if (error)
> +	if (error) {
> +		iterate_supers_excl(fs_suspend_thaw_sb, NULL);
>  		thaw_processes();
> +	}

Does this also have the same problem? i.e. if fs_suspend_freeze_sb()
skips over superblocks that are already userspace frozen without any
error, then this will incorrectly thaw those userspace frozen
filesystems.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
