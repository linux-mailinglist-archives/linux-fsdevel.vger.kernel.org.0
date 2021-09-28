Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E5041A62D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 05:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238862AbhI1Dqf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 23:46:35 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:60352 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238852AbhI1Dqe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 23:46:34 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id 0F8C410099E1;
        Tue, 28 Sep 2021 13:44:54 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mV433-00HYPl-Ba; Tue, 28 Sep 2021 13:44:53 +1000
Date:   Tue, 28 Sep 2021 13:44:53 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, stefanha@redhat.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, bo.liu@linux.alibaba.com,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v5 2/5] fuse: make DAX mount option a tri-state
Message-ID: <20210928034453.GJ2361455@dread.disaster.area>
References: <20210923092526.72341-1-jefflexu@linux.alibaba.com>
 <20210923092526.72341-3-jefflexu@linux.alibaba.com>
 <YUzPUYU8R5LL4mzU@redhat.com>
 <20210923222618.GB2361455@dread.disaster.area>
 <YU0jovIYv+xeinQd@redhat.com>
 <20210927002148.GH2361455@dread.disaster.area>
 <a8224842-7e05-c3fd-7413-5f425e099251@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8224842-7e05-c3fd-7413-5f425e099251@linux.alibaba.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=epq8cqlX c=1 sm=1 tr=0 ts=61528fb6
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=7-415B0cAAAA:8
        a=xlNc23ivPvyHtDMJF7YA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 10:28:34AM +0800, JeffleXu wrote:
> On 9/27/21 8:21 AM, Dave Chinner wrote:
> > On Thu, Sep 23, 2021 at 09:02:26PM -0400, Vivek Goyal wrote:
> >> On Fri, Sep 24, 2021 at 08:26:18AM +1000, Dave Chinner wrote:
> >>> On Thu, Sep 23, 2021 at 03:02:41PM -0400, Vivek Goyal wrote:
> > In the case that the user changes FS_XFLAG_DAX, the FUSE client
> > needs to communicate that attribute change to the server, where the
> > server then changes the persistent state of the on-disk inode so
> > that the next time the client requests that inode, it gets the state
> > it previously set. Unless, of course, there are server side policy
> > overrides (never/always).
> 
> One thing I'm concerned with is that, is the following behavior
> consistent with the semantics of per-file DAX in ext4/xfs?
> 
> Client changes FS_XFLAG_DAX, this change is communicated to server and
> then server also returns **success**. Then client finds that this file
> is not DAX enabled, since server doesn't honor the previously set state.

FS_XFLAG_DAX is advisory in nature - it does not have to be honored
at inode instantiation.

> IOWs, shall server always honor the persistent per-inode attribute of
> host file (if the change of FS_XFLAG_DAX inside guest is stored as
> persistent per-inode attribute on host file)?

If the user set the flag, then queries it, the server should be
returning the state that the user set, regardless of whether it is
being honored at inode instantiation time.

Remember, FS_XFLAG_DAX does not imply S_DAX and vice versa.

> >> Not sure what do you mean by server turns of DAX flag based on client
> >> turning off DAX. Server does not have to do anything. If client decides
> >> to not use DAX (in guest), it will not send FUSE_SETUPMAPPING requests
> >> to server and that's it.
> > 
> > Where does the client get it's per-inode DAX policy from if
> > dax=inode is, like other DAX filesystems, the default behaviour?
> > 
> > Where is the persistent storage of that per-inode attribute kept?
> 
> In the latest patch set, it is not supported yet to change FS_XFLAG_DAX
> (and thus setting/clearing persistent per-inode attribute) inside guest,
> since this scenario is not urgently needed as the real using case.

AFAICT the FS_IOC_FS{GS}ETXATTR ioctl is already supported by the
fuse client and it sends the ioctl to the server. Hence the client
should already support persistent FS_XFLAG_DAX manipulations
regardless of where/how the attribute is stored by the server. Did
you actually add code to the client in this patchset to stop
FS_XFLAG_DAX from being propagated to the server?

> Currently the per-inode dax attribute is completely fed from server
> thourgh FUSE protocol, e.g. server could set/clear the per-inode dax
> attribute depending on the file size.

Yup, that's a policy dax=inode on the client side would allow.
Indeed, this same policy could also be implemented as a client side
policy, allowing user control instead of admin control of such
conditional DAX behaviour... :)

> The previous path set indeed had ever supported changing FS_XFLAG_DAX
> and accordingly setting/clearing persistent per-inode attribute inside
> guest. For "passthrough" type virtiofsd, the persistent per-inode
> attribute is stored as XFS_DIFLAG2_DAX/EXT4_DAX_FL on host file
> directly, since this is what "passthrough" means.

Right, but that's server side storage implementation details, not a
protocol or client side detail. What I can't find in the current
client is where this per-inode flag is actually used in the FUSE dax
inode init path - it just checks whether the connection has DAX
state set up. Hence I don't see how FS_XFLAG_DAX control from the
client currently has any influence on the client side DAX usage.

Seems somewhat crazy to me explicitly want to remove that client
side control of per-inode behaviour whilst adding the missing client
side bits that allow for the per-inode policy control from server
side.  Can we please just start with the common, compatible
dax=inode behaviour on the client side, then layer the server side
policy control options over the top of that?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
