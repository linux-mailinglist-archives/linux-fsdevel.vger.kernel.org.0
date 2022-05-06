Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213B751D406
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 11:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381989AbiEFJPw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 05:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352619AbiEFJPr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 05:15:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73E763399
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 02:12:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A2BC31F8BD;
        Fri,  6 May 2022 09:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651828323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ezRCPaxIImCpU4HFofeOei1/+NaOPYZ+2gW2gHiN71U=;
        b=HgaRHmMTrJhVsTQDU3lxgoeeDi4FwIkc6p/TwfyKkeM3F+AUtfG8xHqcR7VFZTjFi6c+cr
        0Pdm6I4Uc1EBh8bQ3DShOFwOk9HHWFBQqsn1K7yw2S8snA7AIS8f9/yk5hSqqxo3EzLsyk
        fMup+P0EJVDLlCt/FZoB5y/uOsxbKYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651828323;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ezRCPaxIImCpU4HFofeOei1/+NaOPYZ+2gW2gHiN71U=;
        b=MJ5jZLc/L6v5TNXorudnT1rCMb9/TLlLdNE12waVRGOP81B8D1AVFnzeYM6k9U1XIM1QS8
        0/3uKfY7GbGq+HBA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 842472C142;
        Fri,  6 May 2022 09:12:03 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 35D63A0629; Fri,  6 May 2022 11:12:03 +0200 (CEST)
Date:   Fri, 6 May 2022 11:12:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fanotify: do not allow setting FAN_RENAME on non-dir
Message-ID: <20220506091203.yknwtnnxaz6n547d@quack3.lan>
References: <20220506014626.191619-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506014626.191619-1-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 06-05-22 04:46:26, Amir Goldstein wrote:
> The desired sematics of this action are not clear, so for now deny
> this action.  We may relax it when we decide on the semantics and
> implement them.
> 
> Fixes: 8cc3b1ccd930 ("fanotify: wire up FAN_RENAME event")
> Link: https://lore.kernel.org/linux-fsdevel/20220505133057.zm5t6vumc4xdcnsg@quack3.lan/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Thanks guys. I've merged the fix to my tree (fast_track branch) and will
push it to Linus on Monday once it gets at least some exposure to
auto-testers.

								Honza

> ---
>  fs/notify/fanotify/fanotify_user.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index edad67d674dc..ae0c27fac651 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1695,6 +1695,11 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  	else
>  		mnt = path.mnt;
>  
> +	/* FAN_RENAME is not allowed on non-dir (for now) */
> +	ret = -EINVAL;
> +	if (inode && (mask & FAN_RENAME) && !S_ISDIR(inode->i_mode))
> +		goto path_put_and_out;
> +
>  	/* Mask out FAN_EVENT_ON_CHILD flag for sb/mount/non-dir marks */
>  	if (mnt || !S_ISDIR(inode->i_mode)) {
>  		mask &= ~FAN_EVENT_ON_CHILD;
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
