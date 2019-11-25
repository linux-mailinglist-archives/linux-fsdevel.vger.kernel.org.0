Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47D9510921B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 17:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbfKYQq0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 11:46:26 -0500
Received: from fieldses.org ([173.255.197.46]:40400 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728683AbfKYQq0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 11:46:26 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 63B9D1CE6; Mon, 25 Nov 2019 11:46:25 -0500 (EST)
Date:   Mon, 25 Nov 2019 11:46:25 -0500
From:   "J . Bruce Fields" <bfields@fieldses.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, y2038@lists.linaro.org
Subject: Re: [PATCH] utimes: Clamp the timestamps in notify_change()
Message-ID: <20191125164625.GB28608@fieldses.org>
References: <20191124193145.22945-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191124193145.22945-1-amir73il@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 24, 2019 at 09:31:45PM +0200, Amir Goldstein wrote:
> Push clamping timestamps down the call stack into notify_change(), so
> in-kernel callers like nfsd and overlayfs will get similar timestamp
> set behavior as utimes.

So, nfsd has always bypassed timestamp_truncate() and we've never
noticed till now?  What are the symptoms?  (Do timestamps go backwards
after cache eviction on filesystems with large time granularity?)

Looks like generic/402 has never run in my tests:

	generic/402     [not run] no kernel support for y2038 sysfs switch

--b.

> 
> Suggested-by: Miklos Szeredi <mszeredi@redhat.com>
> Fixes: 42e729b9ddbb ("utimes: Clamp the timestamps before update")
> Cc: stable@vger.kernel.org # v5.4
> Cc: Deepa Dinamani <deepa.kernel@gmail.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Arnd,
> 
> This fixes xfstest generic/402 when run with -overlay setup.
> Note that running the test requires latest xfstests with:
>  acb2ba78 - overlay: support timestamp range check
> 
> I had previously posted a fix specific for overlayfs [1],
> but Miklos suggested this more generic fix, which should also
> serve nfsd and other in-kernel users.
> 
> I tested this change with test generic/402 on ext4/xfs/btrfs
> and overlayfs, but not with nfsd.
> 
> Jeff, could you ack this change is good for nfsd as well?
> 
> Thanks,
> Amir.
> 
> [1] https://lore.kernel.org/linux-fsdevel/20191111073000.2957-1-amir73il@gmail.com/
> 
>  fs/attr.c   | 5 +++++
>  fs/utimes.c | 4 ++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/attr.c b/fs/attr.c
> index df28035aa23e..e8de5e636e66 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -268,8 +268,13 @@ int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **de
>  	attr->ia_ctime = now;
>  	if (!(ia_valid & ATTR_ATIME_SET))
>  		attr->ia_atime = now;
> +	else
> +		attr->ia_atime = timestamp_truncate(attr->ia_atime, inode);
>  	if (!(ia_valid & ATTR_MTIME_SET))
>  		attr->ia_mtime = now;
> +	else
> +		attr->ia_mtime = timestamp_truncate(attr->ia_mtime, inode);
> +
>  	if (ia_valid & ATTR_KILL_PRIV) {
>  		error = security_inode_need_killpriv(dentry);
>  		if (error < 0)
> diff --git a/fs/utimes.c b/fs/utimes.c
> index 1ba3f7883870..090739322463 100644
> --- a/fs/utimes.c
> +++ b/fs/utimes.c
> @@ -36,14 +36,14 @@ static int utimes_common(const struct path *path, struct timespec64 *times)
>  		if (times[0].tv_nsec == UTIME_OMIT)
>  			newattrs.ia_valid &= ~ATTR_ATIME;
>  		else if (times[0].tv_nsec != UTIME_NOW) {
> -			newattrs.ia_atime = timestamp_truncate(times[0], inode);
> +			newattrs.ia_atime = times[0];
>  			newattrs.ia_valid |= ATTR_ATIME_SET;
>  		}
>  
>  		if (times[1].tv_nsec == UTIME_OMIT)
>  			newattrs.ia_valid &= ~ATTR_MTIME;
>  		else if (times[1].tv_nsec != UTIME_NOW) {
> -			newattrs.ia_mtime = timestamp_truncate(times[1], inode);
> +			newattrs.ia_mtime = times[1];
>  			newattrs.ia_valid |= ATTR_MTIME_SET;
>  		}
>  		/*
> -- 
> 2.17.1
