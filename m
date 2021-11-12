Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC41344EB92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 17:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbhKLQvQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 11:51:16 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:40934 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbhKLQvP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 11:51:15 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 558081FD3D;
        Fri, 12 Nov 2021 16:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636735704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GPwH2l6CpXukTnAcgy54K9/JUUu+3vqHTdHOFqPszM4=;
        b=Xb85fYkWJM5N4OmpwSu1yERCIo96O7SkgtLqXabXkiw77xj7MKiPAhhTyQp3He+v2P7zq8
        dVYTk908w4Lp+oYsKL1rSRo/PWVo2xU6IQsZE1sEVKk94SxkDlj7vxBSnb3uaKtw28cjiL
        6qPkLjkXiat2orcoDCbe1iq7mBGDvg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636735704;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GPwH2l6CpXukTnAcgy54K9/JUUu+3vqHTdHOFqPszM4=;
        b=sfkRAElCGCxd8YHAEdq7p5FBkRLdC28oAU2br7QZmq2kyaX4VwP2uIu2cGeEdGngFshvgd
        pWI0zjRfTXfoOiBQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 44AC8A3B83;
        Fri, 12 Nov 2021 16:48:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1661E1F2B50; Fri, 12 Nov 2021 17:48:24 +0100 (CET)
Date:   Fri, 12 Nov 2021 17:48:24 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/7] fanotify: record new parent and name in MOVED_FROM
 event
Message-ID: <20211112164824.GB30295@quack2.suse.cz>
References: <20211029114028.569755-1-amir73il@gmail.com>
 <20211029114028.569755-6-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029114028.569755-6-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 29-10-21 14:40:26, Amir Goldstein wrote:
> In the special case of MOVED_FROM event, if we are recording the child
> fid due to FAN_REPORT_TARGET_FID init flag, we also record the new
> parent and name.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
...
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 795bedcb6f9b..d1adcb3437c5 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -592,21 +592,30 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
>  							__kernel_fsid_t *fsid,
>  							const struct qstr *name,
>  							struct inode *child,
> +							struct dentry *moved,
>  							unsigned int *hash,
>  							gfp_t gfp)
>  {
>  	struct fanotify_name_event *fne;
>  	struct fanotify_info *info;
>  	struct fanotify_fh *dfh, *ffh;
> +	struct inode *dir2 = moved ? d_inode(moved->d_parent) : NULL;

I think we need to be more careful here (like dget_parent()?). Fsnotify is
called after everything is unlocked after rename so dentry can be changing
under us, cannot it? Also does that mean that we could actually get a wrong
parent here if the dentry is renamed immediately after we unlock things and
before we report fsnotify event?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
