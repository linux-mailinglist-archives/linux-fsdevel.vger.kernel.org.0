Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E0375386A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 12:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbjGNKkv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 06:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235948AbjGNKkt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:40:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A623D2D7D
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 03:40:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40F1761CE4
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 10:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDA1C433C7;
        Fri, 14 Jul 2023 10:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689331247;
        bh=McAF6OOvBTRjliiSqjAaea2L7Hppjte3npPE1j55d9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jyhjUwyCzAGjLkYvRdPlRoaD0yDjf02kOoGB/IUtc2pBMnFj05McGDmEgmlnsI+v1
         8ZJvYz3/1YMhtnZ48RV2LiqJFPKEPzmEXtShw4e5ln1HeljyMGpiRceBIvnZz6m2y4
         EkNORX06d75v+FKFoYwGYqwzthnGtLxZpH6Kpn2kRQE11l4Xb3Dk08pQb986lHaxNi
         ywDeWcCFt/7BskAwjhPuBmkZ9U3w56FUlRKmthprRmUYjARJvJfMRPkwpF+q2Hq7Mz
         ukv+hc/d2+OYCgHf5wsvwkrIwzqPIp6o/y/lCjOo/VOn7IU16LFmznuZXB1O9/idmk
         Cg/aCBGTRD9/A==
Date:   Fri, 14 Jul 2023 12:40:42 +0200
From:   Carlos Maiolino <cem@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, jack@suse.cz,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, djwong@kernel.org, hughd@google.com,
        mcgrof@kernel.org
Subject: Re: [PATCH 5/6] shmem: quota support
Message-ID: <20230714104042.ooih4eqd2t7wjkoc@andromeda>
References: <20230713134848.249779-1-cem@kernel.org>
 <20230713134848.249779-6-cem@kernel.org>
 <V-TeE9XJsldIdG4LAdNamowXDhhAOwa8MwUQyN5xP05cErk5mEje-ZMEqjcyRRaOQ5I5SqZOdybV-YTRhCpDRg==@protonmail.internalid>
 <20230714-messtechnik-knieprobleme-5d0a3abb4413@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714-messtechnik-knieprobleme-5d0a3abb4413@brauner>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christian.

> > @@ -3736,6 +3853,18 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
> >  		ctx->noswap = true;
> >  		ctx->seen |= SHMEM_SEEN_NOSWAP;
> >  		break;
> > +	case Opt_quota:
> > +		ctx->seen |= SHMEM_SEEN_QUOTA;
> > +		ctx->quota_types |= (QTYPE_MASK_USR | QTYPE_MASK_GRP);
> > +		break;
> > +	case Opt_usrquota:
> > +		ctx->seen |= SHMEM_SEEN_QUOTA;
> > +		ctx->quota_types |= QTYPE_MASK_USR;
> > +		break;
> > +	case Opt_grpquota:
> > +		ctx->seen |= SHMEM_SEEN_QUOTA;
> > +		ctx->quota_types |= QTYPE_MASK_GRP;
> > +		break;
> >  	}
> >  	return 0;
> 
> I mentioned this in an earlier review; following the sequence:

Ok, my apologies, I should have lost it in the noise.

> 
> if (ctx->seen & SHMEM_SEEN_QUOTA)
> -> shmem_enable_quotas()
>    -> dquot_load_quota_sb()
> 
> to then figure out that in dquot_load_quota_sb() we fail if
> sb->s_user_ns != &init_user_ns is too subtle for a filesystem that's
> mountable by unprivileged users. Every few months someone will end up
> stumbling upon this code and wonder where it's blocked. There isn't even
> a comment in the code.
> 
> Aside from that it's also really unfriendly to users because they may go
> through setting up a tmpfs instances in the following way:
> 
>         fd_fs = fsopen("tmpfs");
> 
> User now enables quota:
> 
>         fsconfig(fd_fs, ..., "quota", ...) = 0
> 
> and goes on to set a bunch of other options:
> 
>         fsconfig(fd_fs, ..., "inode64", ...) = 0
>         fsconfig(fd_fs, ..., "nr_inodes", ...) = 0
>         fsconfig(fd_fs, ..., "nr_blocks", ...) = 0
>         fsconfig(fd_fs, ..., "huge", ...) = 0
>         fsconfig(fd_fs, ..., "mode", ...) = 0
>         fsconfig(fd_fs, ..., "gid", ...) = 0
> 
> everything seems dandy and they create the superblock:
> 
>         fsconfig(fd_fs, FSCONFIG_CMD_CREATE, ...) = -EINVAL
> 
> which fails.
> 
> The user has not just performed 9 useless system calls they also have
> zero clue what mount option caused the failure.
> 
> What this code really really should do is fail at:
> 
>         fsconfig(fd_fs, ..., "quota", ...) = -EINVAL
> 
> and log an error that the user can retrieve from the fs context. IOW,
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 083ce6b478e7..baca8bf44569 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3863,14 +3863,20 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
>                 ctx->seen |= SHMEM_SEEN_NOSWAP;
>                 break;
>         case Opt_quota:
> +               if (fc->user_ns != &init_user_ns)
> +                       return invalfc(fc, "Quotas in unprivileged tmpfs mounts unsupported");
>                 ctx->seen |= SHMEM_SEEN_QUOTA;
>                 ctx->quota_types |= (QTYPE_MASK_USR | QTYPE_MASK_GRP);
>                 break;
>         case Opt_usrquota:
> +               if (fc->user_ns != &init_user_ns)
> +                       return invalfc(fc, "Quotas in unprivileged tmpfs mounts unsupported");
>                 ctx->seen |= SHMEM_SEEN_QUOTA;
>                 ctx->quota_types |= QTYPE_MASK_USR;
>                 break;
>         case Opt_grpquota:
> +               if (fc->user_ns != &init_user_ns)
> +                       return invalfc(fc, "Quotas in unprivileged tmpfs mounts unsupported");
>                 ctx->seen |= SHMEM_SEEN_QUOTA;
>                 ctx->quota_types |= QTYPE_MASK_GRP;
>                 break;
> 
> This exactly what we already to for the "noswap" option btw.
> 
> Could you fold these changes into the patch and resend, please?
> I synced with Andrew earlier and I'll be taking this series.

Thanks! I will sure do it, I'll update the patch, build, test and send it again
in a few minutes.

> 
> ---
> 
> And btw, the *_SEEN_* logic for mount options is broken - but that's not
> specific to your patch. Imagine:
> 
>         fd_fs = fsopen("tmpfs");
>         fsconfig(fd_fs, ..., "nr_inodes", 0, "1000") = 0
> 
> Now ctx->inodes == 1000 and ctx->seen |= SHMEM_SEEN_INODES.
> 
> Now the user does:
> 
>         fsconfig(fd_fs, ..., "nr_inodes", 0, "-1234") = -EINVAL
> 
> This fails, but:
> 
>         ctx->inodes = memparse(param->string, &rest);
>         if (*rest)
>                 goto bad_value;
> 
> will set ctx->inodes to whatever memparse returns but leaves
> SHMEM_SEEN_INODES raised in ctx->seen. Now superblock creation may
> succeed with a garbage inode limit. This should affect other mount
> options as well.

Interesting. Thanks for the heads up. I'll look in more details into it when I
start working for namespace support for quotas (as we spoke previously).

Cheers.

-- 
Carlos
