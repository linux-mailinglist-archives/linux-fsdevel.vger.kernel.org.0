Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D1F1D107E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 13:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbgEMLDd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 07:03:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:46602 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728784AbgEMLDc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 07:03:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 01A97AD41;
        Wed, 13 May 2020 11:03:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 651E51E12AE; Wed, 13 May 2020 13:03:30 +0200 (CEST)
Date:   Wed, 13 May 2020 13:03:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Fabian Frederick <fabf@skynet.be>
Cc:     jack@suse.cz, amir73il@gmail.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V2 2/6 linux-next] notify: explicit shutdown
 initialization
Message-ID: <20200513110330.GB27709@quack2.suse.cz>
References: <20200512181740.405774-1-fabf@skynet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512181740.405774-1-fabf@skynet.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 12-05-20 20:17:40, Fabian Frederick wrote:
> kzalloc should already do it but explicitly initialize group
> shutdown variable to false.
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

I don't think this patch makes sence. false is defined to be 0. kzalloc is
there exactly so that we don't have to initialize fields that should be
zero.

								Honza

> ---
>  fs/notify/group.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/notify/group.c b/fs/notify/group.c
> index 133f723aca07..f2cba2265061 100644
> --- a/fs/notify/group.c
> +++ b/fs/notify/group.c
> @@ -130,6 +130,7 @@ struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops)
>  	INIT_LIST_HEAD(&group->notification_list);
>  	init_waitqueue_head(&group->notification_waitq);
>  	group->max_events = UINT_MAX;
> +	group->shutdown = false;
>  
>  	mutex_init(&group->mark_mutex);
>  	INIT_LIST_HEAD(&group->marks_list);
> -- 
> 2.26.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
