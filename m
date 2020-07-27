Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA76922F3E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 17:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbgG0Pdz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 11:33:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:55728 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbgG0Pdz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:33:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 79BE2AD76;
        Mon, 27 Jul 2020 15:34:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E96741E12C5; Mon, 27 Jul 2020 17:33:53 +0200 (CEST)
Date:   Mon, 27 Jul 2020 17:33:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/9] audit: do not set FS_EVENT_ON_CHILD in audit marks
 mask
Message-ID: <20200727153353.GF5284@quack2.suse.cz>
References: <20200722125849.17418-1-amir73il@gmail.com>
 <20200722125849.17418-4-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722125849.17418-4-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 22-07-20 15:58:43, Amir Goldstein wrote:
> The audit groups marks mask does not contain any events possible on
> child,so setting the flag FS_EVENT_ON_CHILD in the mask is counter
> productive.
> 
> It may lead to the undesired outcome of setting the dentry flag
> DCACHE_FSNOTIFY_PARENT_WATCHED on a directory inode even though it is
> not watching children, because the audit mark contribute the flag
> FS_EVENT_ON_CHILD to the inode's fsnotify_mask and another mark could
> be contributing an event that is possible on child to the inode's mask.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

The same as for patch 2/9...

								Honza

> ---
>  kernel/audit_fsnotify.c | 2 +-
>  kernel/audit_watch.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
> index 30ca239285a3..bd3a6b79316a 100644
> --- a/kernel/audit_fsnotify.c
> +++ b/kernel/audit_fsnotify.c
> @@ -36,7 +36,7 @@ static struct fsnotify_group *audit_fsnotify_group;
>  
>  /* fsnotify events we care about. */
>  #define AUDIT_FS_EVENTS (FS_MOVE | FS_CREATE | FS_DELETE | FS_DELETE_SELF |\
> -			 FS_MOVE_SELF | FS_EVENT_ON_CHILD)
> +			 FS_MOVE_SELF)
>  
>  static void audit_fsnotify_mark_free(struct audit_fsnotify_mark *audit_mark)
>  {
> diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
> index 61fd601f1edf..e23d54bcc587 100644
> --- a/kernel/audit_watch.c
> +++ b/kernel/audit_watch.c
> @@ -53,7 +53,7 @@ static struct fsnotify_group *audit_watch_group;
>  
>  /* fsnotify events we care about. */
>  #define AUDIT_FS_WATCH (FS_MOVE | FS_CREATE | FS_DELETE | FS_DELETE_SELF |\
> -			FS_MOVE_SELF | FS_EVENT_ON_CHILD | FS_UNMOUNT)
> +			FS_MOVE_SELF | FS_UNMOUNT)
>  
>  static void audit_free_parent(struct audit_parent *parent)
>  {
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
