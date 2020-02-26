Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19C3716FA78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 10:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgBZJSH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 04:18:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:54676 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgBZJSG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:18:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3C389AAFD;
        Wed, 26 Feb 2020 09:18:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E12F61E0EA2; Wed, 26 Feb 2020 10:18:04 +0100 (CET)
Date:   Wed, 26 Feb 2020 10:18:04 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 08/16] fanotify: merge duplicate events on parent and
 child
Message-ID: <20200226091804.GD10728@quack2.suse.cz>
References: <20200217131455.31107-1-amir73il@gmail.com>
 <20200217131455.31107-9-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217131455.31107-9-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 17-02-20 15:14:47, Amir Goldstein wrote:
> With inotify, when a watch is set on a directory and on its child, an
> event on the child is reported twice, once with wd of the parent watch
> and once with wd of the child watch without the filename.
> 
> With fanotify, when a watch is set on a directory and on its child, an
> event on the child is reported twice, but it has the exact same
> information - either an open file descriptor of the child or an encoded
> fid of the child.
> 
> The reason that the two identical events are not merged is because the
> tag used for merging events in the queue is the child inode in one event
> and parent inode in the other.
> 
> For events with path or dentry data, use the dentry instead of inode as
> the tag for event merging, so that the event reported on parent will be
> merged with the event reported on the child.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

I agree that reporting identical event twice seems wasteful but ...

> @@ -312,7 +313,12 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
>  	if (!event)
>  		goto out;
>  init: __maybe_unused
> -	fsnotify_init_event(&event->fse, inode);
> +	/*
> +	 * Use the dentry instead of inode as tag for event queue, so event
> +	 * reported on parent is merged with event reported on child when both
> +	 * directory and child watches exist.
> +	 */
> +	fsnotify_init_event(&event->fse, (void *)dentry ?: inode);

... this seems quite ugly and also previously we could merge 'inode' events
with others and now we cannot because some will carry "dentry where event
happened" and other ones "inode with watch" as object identifier. So if you
want to do this, I'd use "inode where event happened" as object identifier
for fanotify.

Hum, now thinking about this, maybe we could clean this up even a bit more.
event->inode is currently used only by inotify and fanotify for merging
purposes. Now inotify could use its 'wd' instead of inode with exactly the
same results, fanotify path or fid check is at least as strong as the inode
check. So only for the case of pure "inode" events, we need to store inode
identifier in struct fanotify_event - and we can do that in the union with
struct path and completely remove the 'inode' member from fsnotify_event.
Am I missing something?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
