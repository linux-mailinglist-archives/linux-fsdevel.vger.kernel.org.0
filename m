Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC32506FB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 16:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347073AbiDSOIF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 10:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353149AbiDSOIB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:08:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D999C16594;
        Tue, 19 Apr 2022 07:05:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85A68B819A1;
        Tue, 19 Apr 2022 14:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A661BC385A7;
        Tue, 19 Apr 2022 14:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650377113;
        bh=mCyLOQ+YYWJdnCkas4j4KrcCEsk9TWMaw5fUA2B90wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sbUJfZtKE357HLp9zwkgO1gzbtcIxHIOOMuWmDIljYvWwcLZdyiJ/Z+gm3xs2XS/3
         62n6gpgcZwGH2LfiSx0A+5gKTfdMcONgxyIt+InI4zGJqnY84H/LuCnsQDO0Px9G/N
         vTDDN71LOQJt3cKZ0ThGi3Fo2zsRnvmXAy5HmJ9GQ/UqpRXNrN9AoJll/tvY4WWE5E
         ppI5nh+G7uVGCJvBmOQYl49dNALLu442pIiHZh0eVa1pggrPjnC2QXiyZPw2rTRzAP
         Do7Kd2/fCr2TTpw+wSa/pKf0FCtBVw/g4NmGZ50jEKRUFySiu6NnEDyaF87NF8RNKh
         TPDU8z9wgcbFw==
Date:   Tue, 19 Apr 2022 16:05:08 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com, djwong@kernel.org,
        jlayton@kernel.org, ntfs3@lists.linux.dev, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v4 1/8] fs: move sgid strip operation from
 inode_init_owner into inode_sgid_strip
Message-ID: <20220419140508.b6c4uit3u5hmdql4@wittgenstein>
References: <1650368834-2420-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650368834-2420-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 19, 2022 at 07:47:07PM +0800, Yang Xu wrote:
> This has no functional change. Just create and export inode_sgid_strip api for
> the subsequent patch. This function is used to strip S_ISGID mode when init
> a new inode.
> 
> Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  fs/inode.c         | 22 ++++++++++++++++++----
>  include/linux/fs.h |  3 ++-
>  2 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 9d9b422504d1..3215e61a0021 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2246,10 +2246,8 @@ void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
>  		/* Directories are special, and always inherit S_ISGID */
>  		if (S_ISDIR(mode))
>  			mode |= S_ISGID;
> -		else if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP) &&
> -			 !in_group_p(i_gid_into_mnt(mnt_userns, dir)) &&
> -			 !capable_wrt_inode_uidgid(mnt_userns, dir, CAP_FSETID))
> -			mode &= ~S_ISGID;
> +		else
> +			inode_sgid_strip(mnt_userns, dir, &mode);
>  	} else
>  		inode_fsgid_set(inode, mnt_userns);
>  	inode->i_mode = mode;
> @@ -2405,3 +2403,19 @@ struct timespec64 current_time(struct inode *inode)
>  	return timestamp_truncate(now, inode);
>  }
>  EXPORT_SYMBOL(current_time);
> +
> +void inode_sgid_strip(struct user_namespace *mnt_userns,
> +		      const struct inode *dir, umode_t *mode)
> +{

I think with Willy agreeing in an earlier version with me and you
needing to resend anyway I'd say have this return umode_t instead of
passing a pointer.
