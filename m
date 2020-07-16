Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089F42227EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 17:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgGPP7e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 11:59:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:58130 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728845AbgGPP7e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:59:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7F24AB7E1;
        Thu, 16 Jul 2020 15:59:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3EA131E0E81; Thu, 16 Jul 2020 17:59:32 +0200 (CEST)
Date:   Thu, 16 Jul 2020 17:59:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 21/22] fanotify: report parent fid + name + child fid
Message-ID: <20200716155932.GH5022@quack2.suse.cz>
References: <20200716084230.30611-1-amir73il@gmail.com>
 <20200716084230.30611-22-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716084230.30611-22-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 16-07-20 11:42:29, Amir Goldstein wrote:
> For a group with fanotify_init() flag FAN_REPORT_DFID_NAME, the parent
> fid and name are reported for events on non-directory objects with an
> info record of type FAN_EVENT_INFO_TYPE_DFID_NAME.
> 
> If the group also has the init flag FAN_REPORT_FID, the child fid
> is also reported with another info record that follows the first info
> record. The second info record is the same info record that would have
> been reported to a group with only FAN_REPORT_FID flag.
> 
> When the child fid needs to be recorded, the variable size struct
> fanotify_name_event is preallocated with enough space to store the
> child fh between the dir fh and the name.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/fanotify/fanotify.c      | 30 ++++++++++++++++++++++++++----
>  fs/notify/fanotify/fanotify.h      |  8 +++++++-
>  fs/notify/fanotify/fanotify_user.c |  3 ++-
>  3 files changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index c77b37eb33a9..1d8eb886fe08 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -479,15 +479,22 @@ static struct fanotify_event *fanotify_alloc_fid_event(struct inode *id,
>  static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
>  							__kernel_fsid_t *fsid,
>  							const struct qstr *file_name,
> +							struct inode *child,
>  							gfp_t gfp)
>  {
>  	struct fanotify_name_event *fne;
>  	struct fanotify_info *info;
> -	struct fanotify_fh *dfh;
> +	struct fanotify_fh *dfh, *ffh;
>  	unsigned int dir_fh_len = fanotify_encode_fh_len(id);
> +	unsigned int child_fh_len = fanotify_encode_fh_len(child);
>  	unsigned int size;
>  
> +	if (WARN_ON_ONCE(dir_fh_len % FANOTIFY_FH_HDR_LEN))
> +		child_fh_len = 0;
> +

Why this check? Do you want to check everything is 4-byte aligned? But then
FANOTIFY_FH_HDR_LEN works mostly by accident...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
