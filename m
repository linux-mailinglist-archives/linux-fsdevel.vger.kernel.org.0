Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A05D27FCA8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 11:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbgJAJtk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 05:49:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:52770 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731067AbgJAJtk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 05:49:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7323BB19E;
        Thu,  1 Oct 2020 09:49:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 147E91E12EF; Thu,  1 Oct 2020 11:49:39 +0200 (CEST)
Date:   Thu, 1 Oct 2020 11:49:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        linux-audit@redhat.com, Paul Moore <paul@paul-moore.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH 1/3] fanotify: Ensure consistent variable type for
 response
Message-ID: <20201001094939.GD17860@quack2.suse.cz>
References: <12617626.uLZWGnKmhe@x2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12617626.uLZWGnKmhe@x2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 30-09-20 12:12:24, Steve Grubb wrote:
> The user space API for the response variable is __u32. This patch makes
> sure that the whole path through the kernel uses __u32 so that there is
> no sign extension or truncation of the user space response.
> 
> Signed-off-by: Steve Grubb <sgrubb@redhat.com>
> ---
>  fs/notify/fanotify/fanotify.h      | 2 +-
>  fs/notify/fanotify/fanotify_user.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Looks good, just one nit below:

> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 63b5dffdca9e..c8da9ea1e76e 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -157,7 +157,7 @@ static int create_fd(struct fsnotify_group *group, struct path *path,
>   */
>  static void finish_permission_event(struct fsnotify_group *group,
>  				    struct fanotify_perm_event *event,
> -				    unsigned int response)
> +				    __u32 response)
>  				    __releases(&group->notification_lock)
>  {
>  	bool destroy = false;
> @@ -178,7 +178,7 @@ static int process_access_response(struct fsnotify_group *group,
>  {
>  	struct fanotify_perm_event *event;
>  	int fd = response_struct->fd;
> -	int response = response_struct->response;
> +	__u32 response = response_struct->response;
>  
>  	pr_debug("%s: group=%p fd=%d response=%d\n", __func__, group,
>  		 fd, response);

You want to print the response with "%u" here I guess...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
