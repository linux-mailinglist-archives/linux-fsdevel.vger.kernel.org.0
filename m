Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA343BF888
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jul 2021 12:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhGHKpu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jul 2021 06:45:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48804 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbhGHKpu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jul 2021 06:45:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9DDBF22093;
        Thu,  8 Jul 2021 10:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625740987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EJ1HsFHAAfuSfErssxtfv8nLSrzDHxYtuYvwU40BOaE=;
        b=TfwGZXcRwOOYhQKpddWlAvoyMgSl8PoBCt+Za4uoikhnKM8Y14sxxWVJAxToKpSrCjKats
        tMgXyOqQe0WwGxiY2pHYIi5gRGe+2SNgUpea2tbwQZ2ZmnQBQjqUh47p5tAXudxM0gVJpx
        kNuVzpGCdQhBhmuah6DSfQimUv0klwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625740987;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EJ1HsFHAAfuSfErssxtfv8nLSrzDHxYtuYvwU40BOaE=;
        b=82tiE2FgNh75xHjaoPtqomIHk5BJNp45e1KhOE7pvO1z2EUfGq4fs0p2n0Dp+dwwVFOH2F
        JknqYTT0M7xLkhBQ==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 819A6A3B85;
        Thu,  8 Jul 2021 10:43:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 62EB91E62E4; Thu,  8 Jul 2021 12:43:07 +0200 (CEST)
Date:   Thu, 8 Jul 2021 12:43:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     amir73il@gmail.com, djwong@kernel.org, tytso@mit.edu,
        david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v3 07/15] fsnotify: pass arguments of fsnotify() in
 struct fsnotify_event_info
Message-ID: <20210708104307.GA1656@quack2.suse.cz>
References: <20210629191035.681913-1-krisman@collabora.com>
 <20210629191035.681913-8-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629191035.681913-8-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 29-06-21 15:10:27, Gabriel Krisman Bertazi wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> There are a lot of arguments to fsnotify() and the handle_event() method.
> Pass them in a const struct instead of on the argument list.
> 
> Apart from being more tidy, this helps with passing error reports to the
> backend.  __fsnotify_parent() argument list was intentionally left
> untouched, because its argument list is still short enough and because
> most of the event info arguments are initialized inside
> __fsnotify_parent().
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/notify/fanotify/fanotify.c    | 59 +++++++++++------------
>  fs/notify/fsnotify.c             | 83 +++++++++++++++++---------------
>  include/linux/fsnotify.h         | 15 ++++--
>  include/linux/fsnotify_backend.h | 73 +++++++++++++++++++++-------
>  4 files changed, 140 insertions(+), 90 deletions(-)

Besides the noop function issue Amir has already pointed out I have just a
few nits:

> @@ -229,7 +229,11 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
>  	}
>  
>  notify:
> -	ret = fsnotify(mask, data, data_type, p_inode, file_name, inode, 0);
> +	ret = __fsnotify(mask, &(struct fsnotify_event_info) {
> +				.data = data, .data_type = data_type,
> +				.dir = p_inode, .name = file_name,
> +				.inode = inode,
> +				});

What's the advantage of using __fsnotify() here instead of fsnotify()? In
terms of readability the fewer places with these initializers the better
I'd say...

>  static int fsnotify_handle_event(struct fsnotify_group *group, __u32 mask,
> -				 const void *data, int data_type,
> -				 struct inode *dir, const struct qstr *name,
> -				 u32 cookie, struct fsnotify_iter_info *iter_info)
> +				 const struct fsnotify_event_info *event_info,
> +				 struct fsnotify_iter_info *iter_info)
>  {
>  	struct fsnotify_mark *inode_mark = fsnotify_iter_inode_mark(iter_info);
>  	struct fsnotify_mark *parent_mark = fsnotify_iter_parent_mark(iter_info);
> +	struct fsnotify_event_info child_event_info = { };
>  	int ret;

No need to init child_event_info. It is fully rewritten if it gets used...

> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index f8acddcf54fb..8c2c681b4495 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -30,7 +30,10 @@ static inline void fsnotify_name(struct inode *dir, __u32 mask,
>  				 struct inode *child,
>  				 const struct qstr *name, u32 cookie)
>  {
> -	fsnotify(mask, child, FSNOTIFY_EVENT_INODE, dir, name, NULL, cookie);
> +	__fsnotify(mask, &(struct fsnotify_event_info) {
> +			.data = child, .data_type = FSNOTIFY_EVENT_INODE,
> +			.dir = dir, .name = name, .cookie = cookie,
> +			});
>  }

Hmm, maybe we could have a macro initializer like:

#define FSNOTIFY_EVENT_INFO(data, data_type, dir, name, inode, cookie)	\
	(struct fsnotify_event_info) {					\
		.data = (data), .data_type = (data_type), .dir = (dir), \
		.name = (name), .inode = (inode), .cookie = (cookie)}

Then we'd have:
	__fsnotify(mask, &FSNOTIFY_EVENT_INFO(child, FSNOTIFY_EVENT_INODE,
				dir, name, NULL, cookie));

Which looks a bit nicer to me. What do you think guys?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
