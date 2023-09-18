Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D661E7A49E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 14:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240226AbjIRMl0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 08:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241508AbjIRMlE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:41:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842D99F;
        Mon, 18 Sep 2023 05:40:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 28CDF21AF1;
        Mon, 18 Sep 2023 12:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695040851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8PyckDZtdsyTzA12Zn8yCDPNj9kUjNSxcwu4VJCzOpc=;
        b=M/nkjFwzlaN3Bx1VXDNquDbMrquQCs7wxBxkQ2sGuZpXyy1FuatKczd+muS1L05n0zsCqh
        sbzRiRk2TqIE4elQSbTGS473tS+8uEt7ktkSRRvzwssr+CuaCh9EXi4/d5WdXKUInyeshb
        APstRO74+xgHMc/3/SaS2V55ZHK8fsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695040851;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8PyckDZtdsyTzA12Zn8yCDPNj9kUjNSxcwu4VJCzOpc=;
        b=NQ5a8tuetI5wGy9y9UIiwXLrfESWXimg6EkL9op1vGdMcmReuEAPEOj7xTPh+w686IBPHg
        mahqySc7i5wm0DDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1990A1358A;
        Mon, 18 Sep 2023 12:40:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nAQ1BlNFCGXhfQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 18 Sep 2023 12:40:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 95866A0759; Mon, 18 Sep 2023 14:40:50 +0200 (CEST)
Date:   Mon, 18 Sep 2023 14:40:50 +0200
From:   Jan Kara <jack@suse.cz>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, amir73il@gmail.com
Subject: Re: [PATCH 3/4] inotify_user: add system call inotify_add_watch_at()
Message-ID: <20230918124050.hzbgpci42illkcec@quack3>
References: <20230918123217.932179-1-max.kellermann@ionos.com>
 <20230918123217.932179-3-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918123217.932179-3-max.kellermann@ionos.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 18-09-23 14:32:16, Max Kellermann wrote:
> This implements a missing piece in the inotify API: referring to a
> file by a directory file descriptor and a path name.  This can be
> solved in userspace currently only by doing something similar to:
> 
>   int old = open(".");
>   fchdir(dfd);
>   inotify_add_watch(....);
>   fchdir(old);
> 
> Support for LOOKUP_EMPTY is still missing.  We could add another IN_*
> flag for that (which would clutter the IN_* flags list further) or
> add a "flags" parameter to the new system call (which would however
> duplicate features already present via special IN_* flags).
> 
> To: Jan Kara <jack@suse.cz>
> Cc: Amir Goldstein <amir73il@gmail.com>
> To: linux-fsdevel@vger.kernel.org
> To: linux-kernel@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Thanks for the patches! But generally we don't add new functionality to the
inotify API and rather steer users towards fanotify. In this particular
case fanotify_mark(2) already has the support for dirfd + name. Is there
any problem with using fanotify for you? Note that since kernel 5.13 you
don't need CAP_SYS_ADMIN capability for fanotify functionality that is
more-or-less equivalent to what inotify provides.

								Honza

> ---
>  fs/notify/inotify/inotify_user.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index b6e6f6ab21f8..8a9096c5ebb1 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -797,6 +797,12 @@ SYSCALL_DEFINE3(inotify_add_watch, int, fd, const char __user *, pathname,
>  	return do_inotify_add_watch(fd, AT_FDCWD, pathname, mask);
>  }
>  
> +SYSCALL_DEFINE4(inotify_add_watch_at, int, fd, int, dfd, const char __user *, pathname,
> +		u32, mask)
> +{
> +	return do_inotify_add_watch(fd, dfd, pathname, mask);
> +}
> +
>  SYSCALL_DEFINE2(inotify_rm_watch, int, fd, __s32, wd)
>  {
>  	struct fsnotify_group *group;
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
