Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5399F2E2E90
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Dec 2020 16:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgLZPzr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Dec 2020 10:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgLZPzr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Dec 2020 10:55:47 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A36C061757
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Dec 2020 07:55:06 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ktBuG-004JDx-Hp; Sat, 26 Dec 2020 15:55:00 +0000
Date:   Sat, 26 Dec 2020 15:55:00 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Shijie Luo <luoshijie1@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org, yangerkun@huawei.com,
        yi.zhang@huawei.com, linfeilong@huawei.com, jack@suse.cz
Subject: Re: [RFC PATCH RESEND] fs: fix a hungtask problem when
 freeze/unfreeze fs
Message-ID: <20201226155500.GB3579531@ZenIV.linux.org.uk>
References: <20201226095641.17290-1-luoshijie1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201226095641.17290-1-luoshijie1@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 26, 2020 at 04:56:41AM -0500, Shijie Luo wrote:

> The root cause is that when offline/onlines disks, the filesystem can easily get into 
> a error state and this makes it change to be read-only. Function freeze_super() will hold 
> all sb_writers rwsems including rwsem of SB_FREEZE_WRITE when filesystem not read-only, 
> but thaw_super_locked() cannot release these while the filesystem suddenly become read-only, 
> because the logic will go to out.
> 
> freeze_super
>     hold sb_writers rwsems
>         sb->s_writers.frozen = SB_FREEZE_COMPLETE
>                                                  thaw_super_locked
>                                                      sb_rdonly
>                                                         sb->s_writers.frozen = SB_UNFROZEN;
>                                                             goto out // not release rwsems
> 
> And at this time, if we call mnt_want_write(), the process will be blocked.
> 
> This patch fixes this problem, when filesystem is read-only, just not to set sb_writers.frozen 
> be SB_FREEZE_COMPLETE in freeze_super() and then release all rwsems in thaw_super_locked.

I really don't like that - you end up with a case when freeze_super() returns 0 *and*
consumes the reference it had been give.

>  	if (sb_rdonly(sb)) {
> -		/* Nothing to do really... */
> -		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
> -		up_write(&sb->s_umount);
> +		deactivate_locked_super(sb);
>  		return 0;
>  	}
