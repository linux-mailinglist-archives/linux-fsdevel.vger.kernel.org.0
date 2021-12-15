Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9291475FA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Dec 2021 18:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbhLORp4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Dec 2021 12:45:56 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:34864 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhLORpz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Dec 2021 12:45:55 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 238131F3A6;
        Wed, 15 Dec 2021 17:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639590354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gB/u3dYJznNM1NRxSVJEPF4j1XEvKbc8T/luGOErgPg=;
        b=bKuayshv4iZJh4nMRSjo6ajUTG7fwfMKO2B/uefKyUomajULXUegkf9yKFGox9i/IkQIPz
        bFisti+TkdTRDMr6idPOyQc14U2EhLuNJ7Ugshvl4cMeh7s0PErQoXKI00C8jceYYkw0EM
        bugaoHUHQZNfnmxhxd8MZt4h4+a9VLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639590354;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gB/u3dYJznNM1NRxSVJEPF4j1XEvKbc8T/luGOErgPg=;
        b=SPFZ2rCoVPTb0qrSE5hA77bQXWq/nCxeY3q/8Hqs8xj3lqO+XReOZsGkWLQrg+MZXjGR77
        LUkdGgz34cYT6/Bw==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id 424BBA3B85;
        Wed, 15 Dec 2021 17:45:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 67DBB1E3B2F; Wed, 15 Dec 2021 18:45:47 +0100 (CET)
Date:   Wed, 15 Dec 2021 18:45:47 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v3 00/11] Extend fanotify dirent events
Message-ID: <20211215174547.GO14044@quack2.suse.cz>
References: <20211129201537.1932819-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129201537.1932819-1-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Amir!

On Mon 29-11-21 22:15:26, Amir Goldstein wrote:
> This is the 3rd version of patches to add FAN_REPORT_TARGET_FID group
> flag and FAN_RENAME event.
> 
> Patches [1] LTP test [2] and man page draft [3] are available on my
> github.

I'm sorry it took so long but I was sick for a week and a bit and so things
got delayed. I've looked through the changes and they look good to me. I've
just modified patch 9/11 to pass around just mask of marks matching the
event instead of full struct fsnotify_iter_info. I understand you wanted to
reuse the fanotify_should_report_type() helpers etc. but honestly I don't
think it was bringing much clarity. The result is pushed out to fsnotify &
for_next branches in my tree. Thanks for your work!

								Honza

> [1] https://github.com/amir73il/linux/commits/fan_rename-v3
> [2] https://github.com/amir73il/ltp/commits/fan_rename
> [2] https://github.com/amir73il/man-pages/commits/fan_rename
> 
> Changes since v2:
> - Rebase on v5.16-rc3
> - Separate mark iterator type from object type enum
> - Use dedicated iter type for 2nd dir
> - Use iter type report mask to indicate if old and/or new
>   dir are watching FAN_RENAME
> 
> Amir Goldstein (11):
>   fsnotify: clarify object type argument
>   fsnotify: separate mark iterator type from object type enum
>   fanotify: introduce group flag FAN_REPORT_TARGET_FID
>   fsnotify: generate FS_RENAME event with rich information
>   fanotify: use macros to get the offset to fanotify_info buffer
>   fanotify: use helpers to parcel fanotify_info buffer
>   fanotify: support secondary dir fh and name in fanotify_info
>   fanotify: record old and new parent and name in FAN_RENAME event
>   fanotify: record either old name new name or both for FAN_RENAME
>   fanotify: report old and/or new parent+name in FAN_RENAME event
>   fanotify: wire up FAN_RENAME event
> 
>  fs/notify/dnotify/dnotify.c        |   2 +-
>  fs/notify/fanotify/fanotify.c      | 213 ++++++++++++++++++++++-------
>  fs/notify/fanotify/fanotify.h      | 142 +++++++++++++++++--
>  fs/notify/fanotify/fanotify_user.c |  82 +++++++++--
>  fs/notify/fsnotify.c               |  53 ++++---
>  fs/notify/group.c                  |   2 +-
>  fs/notify/mark.c                   |  31 +++--
>  include/linux/dnotify.h            |   2 +-
>  include/linux/fanotify.h           |   5 +-
>  include/linux/fsnotify.h           |   9 +-
>  include/linux/fsnotify_backend.h   |  74 +++++-----
>  include/uapi/linux/fanotify.h      |  12 ++
>  12 files changed, 485 insertions(+), 142 deletions(-)
> 
> -- 
> 2.33.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
