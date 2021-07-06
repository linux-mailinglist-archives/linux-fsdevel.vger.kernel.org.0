Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6CF3BDF44
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 00:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhGFWJa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jul 2021 18:09:30 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:33762 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229753AbhGFWJ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jul 2021 18:09:29 -0400
Received: from dread.disaster.area (pa49-179-204-119.pa.nsw.optusnet.com.au [49.179.204.119])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id C796E7177;
        Wed,  7 Jul 2021 08:06:47 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1m0tDK-003Yhh-JT; Wed, 07 Jul 2021 08:06:46 +1000
Date:   Wed, 7 Jul 2021 08:06:46 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Wang Shilong <wangshilong1991@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3] fs: forbid invalid project ID
Message-ID: <20210706220646.GO664593@dread.disaster.area>
References: <20210702140243.3615-1-wangshilong1991@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702140243.3615-1-wangshilong1991@gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=Xomv9RKALs/6j/eO6r2ntA==:117 a=Xomv9RKALs/6j/eO6r2ntA==:17
        a=kj9zAlcOel0A:10 a=e_q4qTt1xDgA:10 a=lB0dNpNiAAAA:8 a=7-415B0cAAAA:8
        a=5GLb7GpSppZt8VVZA_8A:9 a=CjuIK1q_8ugA:10 a=c-ZiYqmG3AbHTdtsH08C:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 02, 2021 at 10:02:43AM -0400, Wang Shilong wrote:
> fileattr_set_prepare() should check if project ID
> is valid, otherwise dqget() will return NULL for
> such project ID quota.
> 
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> ---
> v2->v3: move check before @fsx_projid is accessed
> and use make_kprojid() helper.
> 
> v1->v2: try to fix in the VFS
> ---
>  fs/ioctl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 1e2204fa9963..d7edc92df473 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -806,6 +806,8 @@ static int fileattr_set_prepare(struct inode *inode,
>  	if (err)
>  		return err;
>  
> +	if (!projid_valid(make_kprojid(&init_user_ns, fa->fsx_projid)))
> +		return -EINVAL;
>  	/*
>  	 * Project Quota ID state is only allowed to change from within the init
>  	 * namespace. Enforce that restriction only if we are trying to change

I still don't think this is correct - read the comment directly
below where you put this. That was the code block I was referring to
early:

        /*
         * Project Quota ID state is only allowed to change from within the init
         * namespace. Enforce that restriction only if we are trying to change
         * the quota ID state. Everything else is allowed in user namespaces.
         */
        if (current_user_ns() != &init_user_ns) {
                if (old_ma->fsx_projid != fa->fsx_projid)
                        return -EINVAL;
                if ((old_ma->fsx_xflags ^ fa->fsx_xflags) &
                                FS_XFLAG_PROJINHERIT)
                        return -EINVAL;
        }

IOWs: if we are not changing the projid, then we should not be
checking it for validity because of the way the whole get/set
interface works.

The reason for this is that this interface is a get/set pair, where
you first have to get the values from the filesystem, then modify
them and send the set back to the filesystem. If the filesystem
sends out fsx_projid = -1 (for whatever reason), the caller must
send that same value back into the filesystem if they are not
modifying the project ID. Hence we have to accept any projid from
the caller that matches the current filesystem value, regardless of
whether it is an invalid value or not.

Therefore, we should only be checking if fa->fsx_projid is valid if
it is different to the current filesystem value *and* we are allowed
to change it. So:

        /*
         * Project Quota ID state is only allowed to change from within the init
         * namespace. Enforce that restriction only if we are trying to change
         * the quota ID state. Everything else is allowed in user namespaces.
         */
        if (current_user_ns() != &init_user_ns) {
                if (old_ma->fsx_projid != fa->fsx_projid)
                        return -EINVAL;
                if ((old_ma->fsx_xflags ^ fa->fsx_xflags) &
                                FS_XFLAG_PROJINHERIT)
                        return -EINVAL;
        } else {

		/*
		 * Caller is allowed to change the project ID. If it is being
		 * changed, make sure that the new value is valid.
		 */
                if (old_ma->fsx_projid != fa->fsx_projid &&
		    !projid_valid(make_kprojid(&init_user_ns, fa->fsx_projid)))
			return -EINVAL;
	}

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
