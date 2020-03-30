Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A21A319796E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 12:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgC3Kks (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 06:40:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:56120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728656AbgC3Kkr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 06:40:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0BC6AADDD;
        Mon, 30 Mar 2020 10:40:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D40561E11AF; Mon, 30 Mar 2020 12:40:45 +0200 (CEST)
Date:   Mon, 30 Mar 2020 12:40:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH -next] fanotify: Fix the checks in fanotify_fsid_equal
Message-ID: <20200330104045.GA26544@quack2.suse.cz>
References: <20200327171030.30625-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327171030.30625-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 27-03-20 10:10:30, Nathan Chancellor wrote:
> Clang warns:
> 
> fs/notify/fanotify/fanotify.c:28:23: warning: self-comparison always
> evaluates to true [-Wtautological-compare]
>         return fsid1->val[0] == fsid1->val[0] && fsid2->val[1] == fsid2->val[1];
>                              ^
> fs/notify/fanotify/fanotify.c:28:57: warning: self-comparison always
> evaluates to true [-Wtautological-compare]
>         return fsid1->val[0] == fsid1->val[0] && fsid2->val[1] == fsid2->val[1];
>                                                                ^
> 2 warnings generated.
> 
> The intention was clearly to compare val[0] and val[1] in the two
> different fsid structs. Fix it otherwise this function always returns
> true.
> 
> Fixes: afc894c784c8 ("fanotify: Store fanotify handles differently")
> Link: https://github.com/ClangBuiltLinux/linux/issues/952
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for the fix! That's a good catch that would have been pain to debug!
I've applied it to my tree.

								Honza

> ---
>  fs/notify/fanotify/fanotify.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 7a889da1ee12..cb54ecdb3fb9 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -25,7 +25,7 @@ static bool fanotify_path_equal(struct path *p1, struct path *p2)
>  static inline bool fanotify_fsid_equal(__kernel_fsid_t *fsid1,
>  				       __kernel_fsid_t *fsid2)
>  {
> -	return fsid1->val[0] == fsid1->val[0] && fsid2->val[1] == fsid2->val[1];
> +	return fsid1->val[0] == fsid2->val[0] && fsid1->val[1] == fsid2->val[1];
>  }
>  
>  static bool fanotify_fh_equal(struct fanotify_fh *fh1,
> -- 
> 2.26.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
