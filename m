Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A377423D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 12:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjF2KTR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 06:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjF2KTJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 06:19:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF46131
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 03:19:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C170B211C2;
        Thu, 29 Jun 2023 10:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688033938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ves0UlcAp64UCr8Ud3bKMByOkkVOBpK9dCE5t0KAUZo=;
        b=gTVzHR6daDEOP/g8EW9Uss5dpjo7/Kmv035ql1r8kGllzGRjRk8qx+VTIUFpLZ2DNd6Qu7
        jjtigZrPAIZdnrSj0+wSfQQREUH1tAl/hgvmShNV1883N1ZZdYNQy5hDUoXuwV2JRMlQsi
        Y0JU24m/1s2haoJXVWQtV5Wp+6RnHW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688033938;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ves0UlcAp64UCr8Ud3bKMByOkkVOBpK9dCE5t0KAUZo=;
        b=T8VPXtVwB0GDP7uwnj19YweytOjIfovtoaaKD6JtXmbA8vWlszzb8vhUY3sOvXIWjsIkmN
        Q7iWZb4itsBBShDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE4E013905;
        Thu, 29 Jun 2023 10:18:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ORiIKpJanWQPGAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 29 Jun 2023 10:18:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3D262A0722; Thu, 29 Jun 2023 12:18:58 +0200 (CEST)
Date:   Thu, 29 Jun 2023 12:18:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] fanotify: disallow mount/sb marks on kernel
 internal pseudo fs
Message-ID: <20230629101858.72ftsgnfblb5kv64@quack3>
References: <20230629042044.25723-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629042044.25723-1-amir73il@gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 29-06-23 07:20:44, Amir Goldstein wrote:
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

I can add CC to stable. We can also modify the Fixes tag to:

Fixes: 0ff21db9fcc3 ("fanotify: hooks the fanotify_mark syscall to the vfsmount code")

to make things a bit more accurate. Not that it would matter much...

> The reason this is an RFC and that I have not included also the
> optimization patch is because we may want to consider banning kernel
> internal inodes from fanotify and/or inotify altogether.

So here I guess you mean to ban also inode marks for them? And by
kernel-internal I suppose you mean on SB_NOUSER superblock?
 
> The tricky point in banning anonymous pipes from inotify, which
> could have existing users (?), but maybe not, so maybe this is
> something that we need to try out.
> 
> I think we can easily get away with banning anonymous pipes from
> fanotify altogeter, but I would not like to get to into a situation
> where new applications will be written to rely on inotify for
> functionaly that fanotify is never going to have.

Yeah, so didn't we try to already disable inotify on some virtual inodes
and didn't it break something? I have a vague feeling we've already tried
that in the past and it didn't quite fly but searching the history didn't
reveal anything so maybe I'm mistaking it with something else.

I guess you are looking for this so that fsnotify code can bail early when
it sees such inodes and thus improve performance?

								Honza

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
> +	 *
> +	 * XXX: SB_NOUSER covers all of the internal pseudo fs whose objects
> +	 * are not exposed to user's mount namespace, but there are other
> +	 * SB_KERNMOUNT fs, like nsfs, debugfs, for which the value of
> +	 * allowing sb and mount mark is questionable.
> +	 */
> +	if (mark_type != FAN_MARK_INODE &&
> +	    path->mnt->mnt_sb->s_flags & SB_NOUSER)
> +		return -EINVAL;
> +
>  	/*
>  	 * We shouldn't have allowed setting dirent events and the directory
>  	 * flags FAN_ONDIR and FAN_EVENT_ON_CHILD in mask of non-dir inode,
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
