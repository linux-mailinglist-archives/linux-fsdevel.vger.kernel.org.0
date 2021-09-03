Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594F83FF9B5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 06:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbhICE4f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 00:56:35 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:53882 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229561AbhICE4e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 00:56:34 -0400
Received: from dread.disaster.area (pa49-195-182-146.pa.nsw.optusnet.com.au [49.195.182.146])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id E598E1B70A0;
        Fri,  3 Sep 2021 14:55:26 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mM1EX-0085qb-Da; Fri, 03 Sep 2021 14:55:21 +1000
Date:   Fri, 3 Sep 2021 14:55:21 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dwalsh@redhat.com, dgilbert@redhat.com,
        christian.brauner@ubuntu.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        tytso@mit.edu, miklos@szeredi.hu, gscrivan@redhat.com,
        bfields@redhat.com, stephen.smalley.work@gmail.com,
        agruenba@redhat.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 3/1] xfstests: generic/062: Do not run on newer kernels
Message-ID: <20210903045521.GD1756565@dread.disaster.area>
References: <20210902152228.665959-1-vgoyal@redhat.com>
 <YTDyE9wVQQBxS77r@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTDyE9wVQQBxS77r@redhat.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=QpfB3wCSrn/dqEBSktpwZQ==:117 a=QpfB3wCSrn/dqEBSktpwZQ==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=-kbUXcvnShYF-Q782qsA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 02, 2021 at 11:47:31AM -0400, Vivek Goyal wrote:
> 
> xfstests: generic/062: Do not run on newer kernels
> 
> This test has been written with assumption that setting user.* xattrs will
> fail on symlink and special files. When newer kernels support setting
> user.* xattrs on symlink and special files, this test starts failing.
> 
> Found it hard to change test in such a way that it works on both type of
> kernels. Primary problem is 062.out file which hardcodes the output and
> output will be different on old and new kernels.
> 
> So instead, do not run this test if kernel is new and is expected to
> exhibit new behavior. Next patch will create a new test and run that
> test on new kernel.
> 
> IOW, on old kernels run 062 and on new kernels run new test.
> 
> This is a proposed patch. Will need to be fixed if corresponding
> kernel changes are merged upstream.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  tests/generic/062 |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> Index: xfstests-dev/tests/generic/062
> ===================================================================
> --- xfstests-dev.orig/tests/generic/062	2021-08-31 15:51:08.160307982 -0400
> +++ xfstests-dev/tests/generic/062	2021-08-31 16:27:41.678307982 -0400
> @@ -55,6 +55,26 @@ _require_attrs
>  _require_symlinks
>  _require_mknod
>  
> +user_xattr_allowed()
> +{
> +	local kernel_version kernel_patchlevel
> +
> +	kernel_version=`uname -r | awk -F. '{print $1}'`
> +	kernel_patchlevel=`uname -r | awk -F. '{print $2}'`
> +
> +	# Kernel version 5.14 onwards allow user xattr on symlink/special files.
> +	[ $kernel_version -lt 5 ] && return 1
> +	[ $kernel_patchlevel -lt 14 ] && return 1
> +	return 0;
> +}

We don't do this because code changes get backported to random
kernels and so the kernel release is not a reliable indicator of
feature support.

Probing the functionality is the only way to reliably detect what a
kernel supports. That's what we don in all the _requires*()
functions, which is what this should all be wrapped in.

> +# Kernel version 5.14 onwards allow user xattr on symlink/special files.
> +# Do not run this test on newer kernels. Instead run the new test
> +# which has been written with the assumption that user.* xattr
> +# will succeed on symlink and special files.
> +user_xattr_allowed && _notrun "Kernel allows user.* xattrs on symlinks and special files. Skipping this test. Run newer test instead."

"run a newer test instead" is not a useful error message. Nor do you
need "skipping this test" - that's exactly what "notrun" means.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
