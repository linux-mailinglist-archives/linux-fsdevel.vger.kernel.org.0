Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B9D230451
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 09:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgG1Hmb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 03:42:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:51462 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726933AbgG1Hmb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 03:42:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C6C6BB1E5;
        Tue, 28 Jul 2020 07:42:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BFB7C1E12C7; Tue, 28 Jul 2020 09:42:29 +0200 (CEST)
Date:   Tue, 28 Jul 2020 09:42:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fanotify: compare fsid when merging name event
Message-ID: <20200728074229.GA2318@quack2.suse.cz>
References: <20200728065108.26332-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728065108.26332-1-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 28-07-20 09:51:08, Amir Goldstein wrote:
> This was missed when splitting name event from fid event
> 
> Fixes: cacfb956d46e ("fanotify: record name info for FAN_DIR_MODIFY event")
> Cc: <stable@vger.kernel.org> # v5.7+
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

OK, but given we never enabled FAN_DIR_MODIFY in 5.7, this is just a dead
code there, isn't it? So it should be enough to fix this for the series
that's currently queued?

								Honza

> ---
> 
> Jan,
> 
> We missed a spot in v5.7.
> 
> IMO, the issue is not that critical that we must fast track the fix to
> v5.8, but I am posting this patch based on v5.8-rc7, so you may decide
> whether you want to fast track it or to apply it at the beginning of the
> series for next.
> 
> Either way, this is going to be easier for cherry-picking to stable rather
> that backporting the fix from the top of the series for next.
> I pushed my "forward porting" to branch fsnotify-fixes.
> 
> Thanks,
> Amir.
> 
>  fs/notify/fanotify/fanotify.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 85eda539b35f..04f9a7012f46 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -64,6 +64,7 @@ static bool fanotify_name_event_equal(struct fanotify_name_event *fne1,
>  		return false;
>  
>  	if (fne1->name_len != fne2->name_len ||
> +	    !fanotify_fsid_equal(&fne1->fsid, &fne2->fsid) ||
>  	    !fanotify_fh_equal(&fne1->dir_fh, &fne2->dir_fh))
>  		return false;
>  
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
