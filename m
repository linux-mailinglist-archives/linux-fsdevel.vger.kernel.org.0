Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8283933D85F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 16:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238223AbhCPPzf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 11:55:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:32934 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238237AbhCPPz0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:55:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6C47BAE8F;
        Tue, 16 Mar 2021 15:55:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EA01C1F2C4C; Tue, 16 Mar 2021 16:55:24 +0100 (CET)
Date:   Tue, 16 Mar 2021 16:55:24 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v2 0/2] unprivileged fanotify listener
Message-ID: <20210316155524.GD23532@quack2.suse.cz>
References: <20210304112921.3996419-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304112921.3996419-1-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 04-03-21 13:29:19, Amir Goldstein wrote:
> Jan,
> 
> These patches try to implement a minimal set and least controversial
> functionality that we can allow for unprivileged users as a starting
> point.
> 
> The patches were tested on top of v5.12-rc1 and the fanotify_merge
> patches using the unprivileged listener LTP tests written by Matthew
> and another LTP tests I wrote to test the sysfs tunable limits [1].

Thanks. I've added both patches to my tree.

								Honza

> 
> Thanks,
> Amir.
> 
> Changes since v1:
> - Dropped marks per group limit in favor of max per user
> - Rename sysfs files from 'listener' to 'group' terminology
> - Dropped internal group flag FANOTIFY_UNPRIV
> - Limit unprivileged listener to FAN_REPORT_FID family
> - Report event->pid depending on reader capabilities
> 
> [1] https://github.com/amir73il/ltp/commits/fanotify_unpriv
> 
> Amir Goldstein (2):
>   fanotify: configurable limits via sysfs
>   fanotify: support limited functionality for unprivileged users
> 
>  fs/notify/fanotify/fanotify.c      |  16 ++-
>  fs/notify/fanotify/fanotify_user.c | 152 ++++++++++++++++++++++++-----
>  fs/notify/fdinfo.c                 |   3 +-
>  fs/notify/group.c                  |   1 -
>  fs/notify/mark.c                   |   4 -
>  include/linux/fanotify.h           |  36 ++++++-
>  include/linux/fsnotify_backend.h   |   6 +-
>  include/linux/sched/user.h         |   3 -
>  include/linux/user_namespace.h     |   4 +
>  kernel/sysctl.c                    |  12 ++-
>  kernel/ucount.c                    |   4 +
>  11 files changed, 194 insertions(+), 47 deletions(-)
> 
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
