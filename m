Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2317A643A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 15:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjISNCc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 09:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjISNCb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:02:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726CFF3;
        Tue, 19 Sep 2023 06:02:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5174FC433C7;
        Tue, 19 Sep 2023 13:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695128546;
        bh=ado56bNidPzKZVR2ueEZ6I3D4NjiLbfnVnDP4Tvkvo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U4PD0xcgInMQR0s0aIedkb2uzowPCY2CbN1o1B+bGp2BjGeOLCuz/1cussljadkby
         2lT454Vzz0si2ff6tr/UWPTZarSVAv5I4pyDs8zsuA3BmlQ0ZZNcP94uWP/nn4dGQz
         hSzvwJiHnOI2552FEsfKlIR++4yGUSJYQ67eBS20GM4lms5ZOZg3wBRJykQ4l1kj7o
         6puPkWnLApdyT12YyxbarNuGQpIZhL5TYp2WI/IML0KsbUxo2gH3sGA9eHPTUwIeqJ
         du5g0Fx/6xqM93l0h2pHyIYBMJX2o/rCx6GIoyH2tv06tBoNrhD9dWi7SZCV4A6Fgf
         RnuqNiFTXxIIw==
Date:   Tue, 19 Sep 2023 15:02:21 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "J . Bruce Fields" <bfields@redhat.com>, Jan Kara <jack@suse.cz>,
        stable@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH] linux/fs.h: fix umask on NFS with CONFIG_FS_POSIX_ACL=n
Message-ID: <20230919-altbekannt-musisch-35ac924166cf@brauner>
References: <20230919081837.1096695-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230919081837.1096695-1-max.kellermann@ionos.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 10:18:36AM +0200, Max Kellermann wrote:
> Make IS_POSIXACL() return false if POSIX ACL support is disabled and
> ignore SB_POSIXACL/MS_POSIXACL.
> 
> Never skip applying the umask in namei.c and never bother to do any
> ACL specific checks if the filesystem falsely indicates it has ACLs
> enabled when the feature is completely disabled in the kernel.
> 
> This fixes a problem where the umask is always ignored in the NFS
> client when compiled without CONFIG_FS_POSIX_ACL.  This is a 4 year
> old regression caused by commit 013cdf1088d723 which itself was not
> completely wrong, but failed to consider all the side effects by
> misdesigned VFS code.
> 
> Prior to that commit, there were two places where the umask could be
> applied, for example when creating a directory:
> 
>  1. in the VFS layer in SYSCALL_DEFINE3(mkdirat), but only if
>     !IS_POSIXACL()
> 
>  2. again (unconditionally) in nfs3_proc_mkdir()
> 
> The first one does not apply, because even without
> CONFIG_FS_POSIX_ACL, the NFS client sets MS_POSIXACL in
> nfs_fill_super().

Jeff, in light of the recent SB_NOUMASK work for nfs4 to always skip
applying the umask how would this patch fit into the picture? Would be
good to have your review here.

> 
> After that commit, (2.) was replaced by:
> 
>  2b. in posix_acl_create(), called by nfs3_proc_mkdir()
> 
> There's one branch in posix_acl_create() which applies the umask;
> however, without CONFIG_FS_POSIX_ACL, posix_acl_create() is an empty
> dummy function which does not apply the umask.
> 
> The approach chosen by this patch is to make IS_POSIXACL() always
> return false when POSIX ACL support is disabled, so the umask always
> gets applied by the VFS layer.  This is consistent with the (regular)
> behavior of posix_acl_create(): that function returns early if
> IS_POSIXACL() is false, before applying the umask.
> 
> Therefore, posix_acl_create() is responsible for applying the umask if
> there is ACL support enabled in the file system (SB_POSIXACL), and the
> VFS layer is responsible for all other cases (no SB_POSIXACL or no
> CONFIG_FS_POSIX_ACL).
> 
> Reviewed-by: J. Bruce Fields <bfields@redhat.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  include/linux/fs.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 4aeb3fa11927..c1a4bc5c2e95 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2110,7 +2110,12 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
>  #define IS_NOQUOTA(inode)	((inode)->i_flags & S_NOQUOTA)
>  #define IS_APPEND(inode)	((inode)->i_flags & S_APPEND)
>  #define IS_IMMUTABLE(inode)	((inode)->i_flags & S_IMMUTABLE)
> +
> +#ifdef CONFIG_FS_POSIX_ACL
>  #define IS_POSIXACL(inode)	__IS_FLG(inode, SB_POSIXACL)
> +#else
> +#define IS_POSIXACL(inode)	0
> +#endif
>  
>  #define IS_DEADDIR(inode)	((inode)->i_flags & S_DEAD)
>  #define IS_NOCMTIME(inode)	((inode)->i_flags & S_NOCMTIME)
> -- 
> 2.39.2
> 
