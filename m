Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5537435C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 09:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjF3HaQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 03:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjF3H3u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 03:29:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B60270E
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 00:29:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68E07616E2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 07:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C906C433C9;
        Fri, 30 Jun 2023 07:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688110176;
        bh=KaMOqVo6nQgIBxE3amVKo/9nWzpjRrOMkqxZIR53rM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QSS6QclqnMvI+P+qHGb9DgnMPmsyzzUAmRN5CqXHA98bvmhdCfDkB494r8Vgc1irl
         fZq7ft2aFi/pDGvbfUw3Jqre7fbSxRP6bRF80V5+o5odxTsF0pPQ2aI9Vi1ps+Wx8R
         tvNApGKOU7CKN2qajkGvdkaZMWUeINXMaZMaOZoGQYSh+HXrrzwk8zfrIqrs+PT0TX
         qm2ce/TTyI3D/LBVTYvtAzclcJYWw0kKGjyOjyeBwxIwapw9J/bz3nQy5PoRh+0kqw
         WKEWWoS42ED+YI1VsYGB+Ovnv7lsRG/apbA9nDp0dHQNN022zrs9QXgdn7mX640YYR
         0Q/Znu6b9KlHw==
Date:   Fri, 30 Jun 2023 09:29:32 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] fanotify: disallow mount/sb marks on kernel
 internal pseudo fs
Message-ID: <20230630-kitzeln-sitzt-c6b4325362e5@brauner>
References: <20230629042044.25723-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230629042044.25723-1-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 29, 2023 at 07:20:44AM +0300, Amir Goldstein wrote:
> Hopefully, nobody is trying to abuse mount/sb marks for watching all
> anonymous pipes/inodes.
> 
> I cannot think of a good reason to allow this - it looks like an
> oversight that dated back to the original fanotify API.
> 
> Link: https://lore.kernel.org/linux-fsdevel/20230628101132.kvchg544mczxv2pm@quack3/
> Fixes: d54f4fba889b ("fanotify: add API to attach/detach super block mark")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Jan,
> 
> As discussed, allowing sb/mount mark on anonymous pipes
> makes no sense and we should not allow it.
> 
> I've noted FAN_MARK_FILESYSTEM as the Fixes commit as a trigger to
> backport to maintained LTS kernels event though this dates back to day one
> with FAN_MARK_MOUNT. Not sure if we should keep the Fixes tag or not.
> 
> The reason this is an RFC and that I have not included also the
> optimization patch is because we may want to consider banning kernel
> internal inodes from fanotify and/or inotify altogether.
> 
> The tricky point in banning anonymous pipes from inotify, which
> could have existing users (?), but maybe not, so maybe this is
> something that we need to try out.
> 
> I think we can easily get away with banning anonymous pipes from
> fanotify altogeter, but I would not like to get to into a situation
> where new applications will be written to rely on inotify for
> functionaly that fanotify is never going to have.
> 
> Thoughts?
> Am I over thinking this?
> 
> Amir.
> 
>  fs/notify/fanotify/fanotify_user.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 95d7d8790bc3..8240a3fdbef0 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1622,6 +1622,20 @@ static int fanotify_events_supported(struct fsnotify_group *group,
>  	    path->mnt->mnt_sb->s_type->fs_flags & FS_DISALLOW_NOTIFY_PERM)
>  		return -EINVAL;
>  
> +	/*
> +	 * mount and sb marks are not allowed on kernel internal pseudo fs,
> +	 * like pipe_mnt, because that would subscribe to events on all the
> +	 * anonynous pipes in the system.

s/anonynous/anonymous/

> +	 *
> +	 * XXX: SB_NOUSER covers all of the internal pseudo fs whose objects
> +	 * are not exposed to user's mount namespace, but there are other
> +	 * SB_KERNMOUNT fs, like nsfs, debugfs, for which the value of
> +	 * allowing sb and mount mark is questionable.
> +	 */
> +	if (mark_type != FAN_MARK_INODE &&
> +	    path->mnt->mnt_sb->s_flags & SB_NOUSER)
> +		return -EINVAL;

It's a good starting point.

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
