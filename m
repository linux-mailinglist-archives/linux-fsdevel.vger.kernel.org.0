Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D3743E84A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 20:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhJ1S0g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Oct 2021 14:26:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:58306 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229645AbhJ1S0g (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Oct 2021 14:26:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="230336085"
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="230336085"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 11:24:08 -0700
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="448078729"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 11:24:08 -0700
Date:   Thu, 28 Oct 2021 11:24:08 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, adilger.kernel@dilger.ca,
        linux-xfs@vger.kernel.org,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [Question] ext4/xfs: Default behavior changed after per-file DAX
Message-ID: <20211028182407.GG3538886@iweiny-DESK2.sc.intel.com>
References: <26ddaf6d-fea7-ed20-cafb-decd63b2652a@linux.alibaba.com>
 <20211026154834.GB24307@magnolia>
 <YXhWP/FCkgHG/+ou@redhat.com>
 <20211026205730.GI3465596@iweiny-DESK2.sc.intel.com>
 <YXlj6GhxkFBQRJYk@redhat.com>
 <665787d0-f227-a95b-37a3-20f2ea3e09aa@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <665787d0-f227-a95b-37a3-20f2ea3e09aa@linux.alibaba.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 28, 2021 at 01:52:27PM +0800, JeffleXu wrote:
> 
> 
> On 10/27/21 10:36 PM, Vivek Goyal wrote:
> > [snip]
> > 
> >>
> >> Is the biggest issue the lack of visibility to see if the device supports DAX?
> > 
> > Not necessarily. I think for me two biggest issues are.
> > 
> > - Should dax be enabled by default in server as well. If we do that,
> >   server will have to make extra ioctl() call on every LOOKUP and GETATTR
> >   fuse request. Local filesystems probably can easily query FS_XFLAGS_DAX
> >   state but doing extra syscall all the time will probably be some cost
> >   (No idea how much).
> 
> I tested the time cost from virtiofsd's perspective (time cost of
> passthrough_ll.c:lo_do_lookup()):
> - before per inode DAX feature: 2~4 us
> - after per inode DAX feature: 7~8 us
> 
> It is within expectation, as the introduction of per inode DAX feature,
> one extra ioctl() system call is introduced.
> 
> Also the time cost from client's perspective (time cost of
> fs/fuse/dir.c:fuse_lookup_name())
> - before per inode DAX feature: 25~30 us
> - after per inode DAX feature: 30~35 us
> 
> That is, ~15%~20% performance loss.
> 
> Currently we do ioctl() to query the persitent inode flags every time
> FUSE_LOOKUP request is received, maybe we could cache the result of
> ioctl() on virtiofsd side, but I have no idea how to intercept the
> runtime modification to these persistent indoe flags from other
> processes on host, e.g. sysadmin on host, to maintain the cache consistency.
>

Do you really expect the dax flag to change on individual files a lot?  This in
itself is an expensive operation as the FS has to flush the inode.

> 
> So if the default behavior of client side is 'dax=inode', and virtiofsd
> disables per inode DAX by default (neither '-o dax=server|attr' is

I'm not following what dax=server or dax=attr is?

> specified for virtiofsd) for the sake of performance, then guest won't
> see DAX enabled and thus won't be surprised. This can reduce the
> behavior change to the minimum.
> 

What processes, other than virtiofsd have 'control' of these files?

I know that a sysadmin could come in and change the dax flag but I think that
is like saying a sys-admin can come in and change your .bashrc and your
environment is suddenly different.  We have to trust the admins not to do stuff
like that.  So I don't think admins are going to be changing the dax flag on
files out from under 'users'; in this case virtiofsd.  Right?

That means that virtiofsd could cache the status and avoid the performance
issues above correct?

Ira

> 
> > 
> > - So far if virtiofs is mounted without any of the dax options, just
> >   by looking at mount option, I could tell, DAX is not enabled on any
> >   of the files. But that will not be true anymore. Because dax=inode
> >   be default, it is possible that server upgrade enabled dax on some
> >   or all the files.
> > 
> >   I guess I will have to stick to same reason given by ext4/xfs. That is
> >   to determine whether DAX is enabled on a file or not, you need to
> >   query STATX_ATTR_DAX flag. That's the only way to conclude if DAX is
> >   being used on a file or not. Don't look at filesystem mount options
> >   and reach a conclusion (except the case of dax=never).
> 
> 
> -- 
> Thanks,
> Jeffle
