Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD757758410
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 20:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjGRSEA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 14:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjGRSD7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:03:59 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3E9C0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 11:03:56 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-57012b2973eso61146027b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 11:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689703436; x=1692295436;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q4CNF+rFTUAFOsBEhouBKLc7oCXFnNA366elyzGW4JA=;
        b=MajzVeq2e8H/0R87Xtso03TCRV/nKjiwEOYIrZPU3SQEJt1uJ31zDkTlcgphETFQtc
         kbXVXF3eMfXaGCvh8xjHPugNVtbqTzh173+DWIjbnHpmiZ4HCxObRngUZV/0vzxmztHE
         fQWTc2iyxeQXZ3aVIeziT3f8xkFGiWP/vRwIf4jUQ4bAUMuEZ4j1XDGqF57jZesWuPlL
         JGqC0MEbYkQhWTAIf2kG/Me/1g68qf4aTHINDuTwwKk4KICji1vYXVQ9XFnd8qUkUr4P
         NF9Wode2GKRWdExle1SRQPqKGtWO3Xbvg57dyEPrF5hGQGM76K2/j4NFEare+tVHjVgv
         98lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689703436; x=1692295436;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4CNF+rFTUAFOsBEhouBKLc7oCXFnNA366elyzGW4JA=;
        b=L6Bq25hXlAuHJ95bA2ZX822EHKV61FIIZrjUHHlkx8axC5bdkGeUAV2KTTVIkcCRDh
         waRpYTAHQOpgcxQmysJXb0/86btu4ws4tMq/vF2xSIHlhGXSGhnE8hLMaOND5KgzUO0c
         AQzo5t+tHB5sGFg8teI/lD+oCqv3IXG7MTu3UCq6m4XjLWyGAP2yOPyyA/SeIlWdmOFk
         /tuls2P3aJDI27CNSQ+Pr56hZKcD3+B9Zc5d515uWasSNy7fz3TvdjZyzZGva6Is9Ch6
         oOXWTIkkCWYneQav4MLbDeB4/UFSOyRcUV90AIcLa7wejRVMZzfRWgFciMe5CIv5R/UU
         8Krg==
X-Gm-Message-State: ABy/qLb6Iph20hId94PX0sP/xOmEPMCY5cwNiJRvwdl2EqZb6hU9oS94
        dL7hXRntTGh5P3qXy52CQY1bQA==
X-Google-Smtp-Source: APBJJlGPg7wlRhHKekm0is+KBQAGFMmR19sLA5ULGCY3dMkWHVh1xGMUi0EDnr+UMn8UVh+t+wKWQQ==
X-Received: by 2002:a0d:f101:0:b0:56c:f8f1:eed5 with SMTP id a1-20020a0df101000000b0056cf8f1eed5mr509779ywf.6.1689703436033;
        Tue, 18 Jul 2023 11:03:56 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h18-20020a81b412000000b0057a6e41aad1sm574314ywi.67.2023.07.18.11.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 11:03:55 -0700 (PDT)
Date:   Tue, 18 Jul 2023 11:03:45 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Jeff Layton <jlayton@kernel.org>
cc:     Hugh Dickins <hughd@google.com>, Theodore Ts'o <tytso@mit.edu>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-next ext4 inode size 128 corrupted
In-Reply-To: <368e567a3a0a1a21ce37f5fba335068c50ab6f29.camel@kernel.org>
Message-ID: <a51815d0-16fb-201b-77db-e16af4caa8b0@google.com>
References: <26cd770-469-c174-f741-063279cdf7e@google.com> <368e567a3a0a1a21ce37f5fba335068c50ab6f29.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 18 Jul 2023, Jeff Layton wrote:
> On Mon, 2023-07-17 at 20:43 -0700, Hugh Dickins wrote:
> > Hi Jeff,
> > 
> > I've been unable to run my kernel builds on ext4 on loop0 on tmpfs
> > swapping load on linux-next recently, on one machine: various kinds
> > of havoc, most common symptoms being ext4_find_dest_de:2107 errors,
> > systemd-journald errors, segfaults.  But no problem observed running
> > on a more recent installation.
> > 
> > Bisected yesterday to 979492850abd ("ext4: convert to ctime accessor
> > functions").
> > 
> > I've mostly averted my eyes from the EXT4_INODE macro changes there,
> > but I think that's where the problem lies.  Reading the comment in
> > fs/ext4/ext4.h above EXT4_FITS_IN_INODE() led me to try "tune2fs -l"
> > and look at /etc/mke2fs.conf.  It's an old installation, its own
> > inodes are 256, but that old mke2fs.conf does default to 128 for small
> > FSes, and what I use for the load test is small.  Passing -I 256 to the
> > mkfs makes the problems go away.
> > 
> > (What's most alarming about the corruption is that it appears to extend
> > beyond just the throwaway test filesystem: segfaults on bash and libc.so
> > from the root filesystem.  But no permanent damage done there.)
> > 
> > One oddity I noticed in scrutinizing that commit, didn't help with
> > the issues above, but there's a hunk in ext4_rename() which changes
> > -	old.dir->i_ctime = old.dir->i_mtime = current_time(old.dir);
> > +	old.dir->i_mtime = inode_set_ctime_current(old.inode);
> > 
> > 
> 
> I suspect the problem here is the i_crtime, which lives wholly in the
> extended part of the inode. The old macros would just not store anything
> if the i_crtime didn't fit, but the new ones would still store the
> tv_sec field in that case, which could be a memory corruptor. This patch
> should fix it, and I'm testing it now.

That makes sense.

> 
> Hugh, if you're able to give this a spin on your setup, then that would
> be most helpful. This is also in the "ctime" branch in my kernel.org
> tree if that helps. If this looks good, I'll ask Christian to fold this
> into the ext4 conversion patch.

Yes, it's now running fine on the problem machine, and on the no-problem.

Tested-by: Hugh Dickins <hughd@google.com>

> 
> Thanks for the bug report!

And thanks for the quick turnaround!

But I'm puzzled by your dismissing that
-	old.dir->i_ctime = old.dir->i_mtime = current_time(old.dir);
+	old.dir->i_mtime = inode_set_ctime_current(old.inode);
in ext4_rename() as "actually looks fine".

Different issue, nothing to do with the corruption, sure.  Much less
important, sure.  But updating ctime on the wrong inode is "fine"?

Hugh

> 
> ---------------------------8<--------------------------
> 
> [PATCH] ext4: fix the time handling macros when ext4 is using small inodes
> 
> If ext4 is using small on-disk inodes, then it may not be able to store
> fine grained timestamps. It also can't store the i_crtime at all in that
> case since that fully lives in the extended part of the inode.
> 
> 979492850abd got the EXT4_EINODE_{GET,SET}_XTIME macros wrong, and would
> still store the tv_sec field of the i_crtime into the raw_inode, even
> when they were small, corrupting adjacent memory.
> 
> This fixes those macros to skip setting anything in the raw_inode if the
> tv_sec field doesn't fit. 
> 
> Cc: Jan Kara <jack@suse.cz>
> Fixes: 979492850abd ("ext4: convert to ctime accessor functions")
> Reported-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ext4/ext4.h | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 2af347669db7..1e2259d9967d 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -900,8 +900,10 @@ do {										\
>  #define EXT4_INODE_SET_CTIME(inode, raw_inode)					\
>  	EXT4_INODE_SET_XTIME_VAL(i_ctime, inode, raw_inode, inode_get_ctime(inode))
>  
> -#define EXT4_EINODE_SET_XTIME(xtime, einode, raw_inode)			       \
> -	EXT4_INODE_SET_XTIME_VAL(xtime, &((einode)->vfs_inode), raw_inode, (einode)->xtime)
> +#define EXT4_EINODE_SET_XTIME(xtime, einode, raw_inode)				\
> +	if (EXT4_FITS_IN_INODE(raw_inode, einode, xtime))			\
> +		EXT4_INODE_SET_XTIME_VAL(xtime, &((einode)->vfs_inode),		\
> +					 raw_inode, (einode)->xtime)
>  
>  #define EXT4_INODE_GET_XTIME_VAL(xtime, inode, raw_inode)			\
>  	(EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), xtime ## _extra) ?	\
> @@ -922,9 +924,14 @@ do {										\
>  		EXT4_INODE_GET_XTIME_VAL(i_ctime, inode, raw_inode));		\
>  } while (0)
>  
> -#define EXT4_EINODE_GET_XTIME(xtime, einode, raw_inode)			       \
> -do {									       \
> -	(einode)->xtime = EXT4_INODE_GET_XTIME_VAL(xtime, &(einode->vfs_inode), raw_inode);	\
> +#define EXT4_EINODE_GET_XTIME(xtime, einode, raw_inode)				\
> +do {										\
> +	if (EXT4_FITS_IN_INODE(raw_inode, einode, xtime)) 			\
> +		(einode)->xtime =						\
> +			EXT4_INODE_GET_XTIME_VAL(xtime, &(einode->vfs_inode),	\
> +						 raw_inode);			\
> +	else									\
> +		(einode)->xtime = (struct timespec64){0, 0};			\
>  } while (0)
>  
>  #define i_disk_version osd1.linux1.l_i_version
> -- 
> 2.41.0
> 
> 
> 
