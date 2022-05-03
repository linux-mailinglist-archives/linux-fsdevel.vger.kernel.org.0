Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2915191A1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 00:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243794AbiECWqr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 18:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbiECWqq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 18:46:46 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80A662DA8D;
        Tue,  3 May 2022 15:43:12 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id DCC56534356;
        Wed,  4 May 2022 08:43:06 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nm1EX-007glS-UL; Wed, 04 May 2022 08:43:05 +1000
Date:   Wed, 4 May 2022 08:43:05 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Karel Zak <kzak@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [RFC PATCH] getting misc stats/attributes via xattr API
Message-ID: <20220503224305.GF1360180@dread.disaster.area>
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=6271afff
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=7-415B0cAAAA:8
        a=yUZlb4BpVi82aJ1b07cA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 03, 2022 at 02:23:23PM +0200, Miklos Szeredi wrote:
> This is a simplification of the getvalues(2) prototype and moving it to the
> getxattr(2) interface, as suggested by Dave.
> 
> The patch itself just adds the possibility to retrieve a single line of
> /proc/$$/mountinfo (which was the basic requirement from which the fsinfo
> patchset grew out of).
> 
> But this should be able to serve Amir's per-sb iostats, as well as a host of
> other cases where some statistic needs to be retrieved from some object.  Note:
> a filesystem object often represents other kinds of objects (such as processes
> in /proc) so this is not limited to fs attributes.
> 
> This also opens up the interface to setting attributes via setxattr(2).
> 
> After some pondering I made the namespace so:
> 
> : - root
> bar - an attribute
> foo: - a folder (can contain attributes and/or folders)
> 
> The contents of a folder is represented by a null separated list of names.
> 
> Examples:
> 
> $ getfattr -etext -n ":" .
> # file: .
> :="mnt:\000mntns:"
> 
> $ getfattr -etext -n ":mnt:" .
> # file: .
> :mnt:="info"
> 
> $ getfattr -etext -n ":mnt:info" .
> # file: .
> :mnt:info="21 1 254:0 / / rw,relatime - ext4 /dev/root rw\012"
> 
> $ getfattr -etext -n ":mntns:" .
> # file: .
> :mntns:="21:\00022:\00024:\00025:\00023:\00026:\00027:\00028:\00029:\00030:\00031:"
> 
> $ getfattr -etext -n ":mntns:28:" .
> # file: .
> :mntns:28:="info"
> 
> Comments?

I like. :)

> Thanks,
> Miklos
> 
> ---
>  fs/Makefile            |    2 
>  fs/mount.h             |    8 +
>  fs/namespace.c         |   15 ++-
>  fs/pnode.h             |    2 
>  fs/proc_namespace.c    |   15 ++-
>  fs/values.c            |  242 +++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/xattr.c             |   16 ++-
>  include/linux/values.h |   11 ++

"values" is a very generic name - probably should end up being
something more descriptive of the functionality is provides,
especially if the header file is going to be dumped in
include/linux/. I don't really have a good suggestion at the moment,
though. 

....

> +
> +enum {
> +	VAL_MNT_INFO,
> +};
> +
> +static struct val_desc val_mnt_group[] = {
> +	{ VD_NAME("info"),		.idx = VAL_MNT_INFO		},
> +	{ }
> +};
....
> +
> +
> +static struct val_desc val_toplevel_group[] = {
> +	{ VD_NAME("mnt:"),	.get = val_mnt_get,	},
> +	{ VD_NAME("mntns:"),	.get = val_mntns_get,	},
> +	{ },
> +};

I know this is an early POC, my main question is how do you
envisiage this table driven structure being extended down from just
the mount into the filesystem so we can expose filesystem specific
information that isn't covered by generic interfaces like statx?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
