Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5241D753AE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 14:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbjGNM1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 08:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjGNM1X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:27:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7528A35BB
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 05:26:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5415F61D0C
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 12:26:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7686C433C7;
        Fri, 14 Jul 2023 12:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689337610;
        bh=xIcj5qUuQUu1ELhgWDH8nrX5vd05Q0RYyk2mpoN6BCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G54vAh/sovlSgetpZXD7UBAnYXv4mYRm65EEHuxuIRZZ+n7A1LgETTtu7SkvnAuSk
         kqSK4tHZQVXcPOJh5qduHSJm6IsZAukzO+lnH4ejLwt+UGOoSZsapfT0m6uqCJQXqR
         4qL8dmg9BORNKStP3SmuAffTkv6b3J99zN0O2phQvW/8/L0EqneksdPX+uxvcVXYQ6
         oRG4lnE7f1K5pq70R5fd2J9J9tCTzKhcIMsqePgHTOf+uod3RDl71hH1x4fX2PiBjJ
         nKaaOAOUCaOi21pB66nNmpr0+Dr9wnvCYwLCXjkrU7uTLOEa8Ux/E7zrHyEhwzh5ML
         hyWNKDPFaoHNw==
Date:   Fri, 14 Jul 2023 14:26:44 +0200
From:   Carlos Maiolino <cem@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, jack@suse.cz,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, djwong@kernel.org, hughd@google.com,
        mcgrof@kernel.org
Subject: Re: [PATCH 5/6] shmem: quota support
Message-ID: <20230714122644.l6g4wr3jb7fmkf7x@andromeda>
References: <20230713134848.249779-1-cem@kernel.org>
 <20230713134848.249779-6-cem@kernel.org>
 <V-TeE9XJsldIdG4LAdNamowXDhhAOwa8MwUQyN5xP05cErk5mEje-ZMEqjcyRRaOQ5I5SqZOdybV-YTRhCpDRg==@protonmail.internalid>
 <20230714-messtechnik-knieprobleme-5d0a3abb4413@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714-messtechnik-knieprobleme-5d0a3abb4413@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> >
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

I was just going to rebase these updated changes on top of linux-next, and I
realized the patches are already there. Wouldn't it be better if I send a
follow-up patch on top of linux-next, applying these changes, as a Fixes: tag?

-- 
Carlos

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
