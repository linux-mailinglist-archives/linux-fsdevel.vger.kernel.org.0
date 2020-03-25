Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6027C192D7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 16:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgCYPyi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 11:54:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:49204 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgCYPyi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:54:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 83F0AAC65;
        Wed, 25 Mar 2020 15:54:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 545C21E1108; Wed, 25 Mar 2020 16:54:36 +0100 (CET)
Date:   Wed, 25 Mar 2020 16:54:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 00/14] fanotify directory modify event
Message-ID: <20200325155436.GL28951@quack2.suse.cz>
References: <20200319151022.31456-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319151022.31456-1-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Thu 19-03-20 17:10:08, Amir Goldstein wrote:
> Jan,
> 
> This v3 posting is a trimmed down version of v2 name info patches [1].
> It includes the prep/fix patches and the patches to add support for
> the new FAN_DIR_MODIFY event, but leaves out the FAN_REPORT_NAME
> patches. I will re-post those as a later time.
> 
> The v3 patches are available on my github branch fanotify_dir_modify [2].
> Same branch names for LTP tests [3], man page draft [6] and a demo [7].
> The fanotify_name branches in those github trees include the additional
> FAN_REPORT_NAME related changes.
> 
> Main changes since v2:
> - Split fanotify_path_event fanotify_fid_event and fanotify_name_event
> - Drop the FAN_REPORT_NAME patches

So I have pushed out the result to my tree (fsnotify branch and also pulled
it to for_next branch).

								Honza

> 
> [1] https://lore.kernel.org/linux-fsdevel/20200217131455.31107-1-amir73il@gmail.com/
> [2] https://github.com/amir73il/linux/commits/fanotify_dir_modify
> [3] https://github.com/amir73il/ltp/commits/fanotify_dir_modify
> [4] https://github.com/amir73il/man-pages/commits/fanotify_dir_modify
> [5] https://github.com/amir73il/inotify-tools/commits/fanotify_dir_modify
> 
> Amir Goldstein (14):
>   fsnotify: tidy up FS_ and FAN_ constants
>   fsnotify: factor helpers fsnotify_dentry() and fsnotify_file()
>   fsnotify: funnel all dirent events through fsnotify_name()
>   fsnotify: use helpers to access data by data_type
>   fsnotify: simplify arguments passing to fsnotify_parent()
>   fsnotify: pass dentry instead of inode for events possible on child
>   fsnotify: replace inode pointer with an object id
>   fanotify: merge duplicate events on parent and child
>   fanotify: fix merging marks masks with FAN_ONDIR
>   fanotify: divorce fanotify_path_event and fanotify_fid_event
>   fanotify: send FAN_DIR_MODIFY event flavor with dir inode and name
>   fanotify: prepare to report both parent and child fid's
>   fanotify: record name info for FAN_DIR_MODIFY event
>   fanotify: report name info for FAN_DIR_MODIFY event
> 
>  fs/notify/fanotify/fanotify.c        | 304 ++++++++++++++++++++-------
>  fs/notify/fanotify/fanotify.h        | 172 +++++++++------
>  fs/notify/fanotify/fanotify_user.c   | 171 ++++++++++-----
>  fs/notify/fsnotify.c                 |  22 +-
>  fs/notify/inotify/inotify_fsnotify.c |  12 +-
>  fs/notify/inotify/inotify_user.c     |   2 +-
>  include/linux/fanotify.h             |   3 +-
>  include/linux/fsnotify.h             | 138 +++++-------
>  include/linux/fsnotify_backend.h     |  87 ++++++--
>  include/uapi/linux/fanotify.h        |   6 +-
>  kernel/audit_fsnotify.c              |  13 +-
>  kernel/audit_watch.c                 |  16 +-
>  12 files changed, 610 insertions(+), 336 deletions(-)
> 
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
