Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE0E43E8F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 21:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhJ1TWU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Oct 2021 15:22:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41485 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230481AbhJ1TWT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Oct 2021 15:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635448792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=itVqLjWPvjd96pFjKmpiNF0U4CjfqdxXKr0YqA5Ss10=;
        b=TBb3Ue181EUPv7EsQ/hAnONuLgTJRnADl830dYdeEWKW39EiPSxfO0xyV5qum3IswkzhU1
        vXUoSCXZDceGVFmlHY8c5b3Kl7L24MhY1ghrGEyEzeAe5ewcW6uep6ZDndMQJJw8YJsynf
        OW1Om6BxAUPdpkvhTzOpqYCSEkAPB8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-Cz9pkv1FM7iqfDz_qk42oA-1; Thu, 28 Oct 2021 15:19:48 -0400
X-MC-Unique: Cz9pkv1FM7iqfDz_qk42oA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2CD1806688;
        Thu, 28 Oct 2021 19:19:46 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.9.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 86DB02657F;
        Thu, 28 Oct 2021 19:19:46 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id DA429220562; Thu, 28 Oct 2021 15:19:45 -0400 (EDT)
Date:   Thu, 28 Oct 2021 15:19:45 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     JeffleXu <jefflexu@linux.alibaba.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, adilger.kernel@dilger.ca,
        linux-xfs@vger.kernel.org,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [Question] ext4/xfs: Default behavior changed after per-file DAX
Message-ID: <YXr30ZHODgKjZU2R@redhat.com>
References: <26ddaf6d-fea7-ed20-cafb-decd63b2652a@linux.alibaba.com>
 <20211026154834.GB24307@magnolia>
 <YXhWP/FCkgHG/+ou@redhat.com>
 <20211026205730.GI3465596@iweiny-DESK2.sc.intel.com>
 <YXlj6GhxkFBQRJYk@redhat.com>
 <665787d0-f227-a95b-37a3-20f2ea3e09aa@linux.alibaba.com>
 <20211028182407.GG3538886@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028182407.GG3538886@iweiny-DESK2.sc.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 28, 2021 at 11:24:08AM -0700, Ira Weiny wrote:
> On Thu, Oct 28, 2021 at 01:52:27PM +0800, JeffleXu wrote:
> > 
> > 
> > On 10/27/21 10:36 PM, Vivek Goyal wrote:
> > > [snip]
> > > 
> > >>
> > >> Is the biggest issue the lack of visibility to see if the device supports DAX?
> > > 
> > > Not necessarily. I think for me two biggest issues are.
> > > 
> > > - Should dax be enabled by default in server as well. If we do that,
> > >   server will have to make extra ioctl() call on every LOOKUP and GETATTR
> > >   fuse request. Local filesystems probably can easily query FS_XFLAGS_DAX
> > >   state but doing extra syscall all the time will probably be some cost
> > >   (No idea how much).
> > 
> > I tested the time cost from virtiofsd's perspective (time cost of
> > passthrough_ll.c:lo_do_lookup()):
> > - before per inode DAX feature: 2~4 us
> > - after per inode DAX feature: 7~8 us
> > 
> > It is within expectation, as the introduction of per inode DAX feature,
> > one extra ioctl() system call is introduced.
> > 
> > Also the time cost from client's perspective (time cost of
> > fs/fuse/dir.c:fuse_lookup_name())
> > - before per inode DAX feature: 25~30 us
> > - after per inode DAX feature: 30~35 us
> > 
> > That is, ~15%~20% performance loss.
> > 
> > Currently we do ioctl() to query the persitent inode flags every time
> > FUSE_LOOKUP request is received, maybe we could cache the result of
> > ioctl() on virtiofsd side, but I have no idea how to intercept the
> > runtime modification to these persistent indoe flags from other
> > processes on host, e.g. sysadmin on host, to maintain the cache consistency.
> >
> 
> Do you really expect the dax flag to change on individual files a lot?  This in
> itself is an expensive operation as the FS has to flush the inode.

No, we do not expect it to change often. But in a shared filesystem it
could be changed by somebody else. So we can't cache it in virtiofsd.
Even if we cache it we will need mechanism to invalidate cache if
some other client changed it. 

> 
> > 
> > So if the default behavior of client side is 'dax=inode', and virtiofsd
> > disables per inode DAX by default (neither '-o dax=server|attr' is
> 
> I'm not following what dax=server or dax=attr is?

These are just the virtiofs daemon option names we are considering to
allow daemon to switch between different kind of policies. These names
are not final. As of now dax=attr is suggesting that look for FS_XFLAG_DAX
flag on inode and enable DAX on inode accordingly. dax=server means
that server can choose other policy to enable/disable DAX on an inode
(and can ignore FS_XFLAG_DAX). 

> 
> > specified for virtiofsd) for the sake of performance, then guest won't
> > see DAX enabled and thus won't be surprised. This can reduce the
> > behavior change to the minimum.
> > 
> 
> What processes, other than virtiofsd have 'control' of these files?

Guest process  or user can change these flags. virtiofsd is not going
to modify this flag. It will just query this flag and respond to client
to enable DAX if this flag/attr is set on inode.

> 
> I know that a sysadmin could come in and change the dax flag but I think that
> is like saying a sys-admin can come in and change your .bashrc and your
> environment is suddenly different.  We have to trust the admins not to do stuff
> like that.  So I don't think admins are going to be changing the dax flag on
> files out from under 'users'; in this case virtiofsd.  Right?

Right. Generally I don't expect that on host anybody will change it. But I
will not rule it out because host is the one preparing initial filesystem
for the guest and if admin/tools on host want to set FS_XFLAG_DAX on
some of the inodes to begin with, so be it. Guest will boot with that
initial filesystem state.

> 
> That means that virtiofsd could cache the status and avoid the performance
> issues above correct?

This directory could be shared also. That means multiple guests are
sharing same directory (each guest has one corresponding virtiofsd
instance running). That means if one guest changes the property of
one of the files, other guests/virtiofsd will have no idea that property
has changed.

Vivek

> 
> Ira
> 
> > 
> > > 
> > > - So far if virtiofs is mounted without any of the dax options, just
> > >   by looking at mount option, I could tell, DAX is not enabled on any
> > >   of the files. But that will not be true anymore. Because dax=inode
> > >   be default, it is possible that server upgrade enabled dax on some
> > >   or all the files.
> > > 
> > >   I guess I will have to stick to same reason given by ext4/xfs. That is
> > >   to determine whether DAX is enabled on a file or not, you need to
> > >   query STATX_ATTR_DAX flag. That's the only way to conclude if DAX is
> > >   being used on a file or not. Don't look at filesystem mount options
> > >   and reach a conclusion (except the case of dax=never).
> > 
> > 
> > -- 
> > Thanks,
> > Jeffle
> 

