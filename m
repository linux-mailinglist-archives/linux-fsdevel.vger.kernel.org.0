Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FA443E17E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 15:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhJ1NEF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Oct 2021 09:04:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34530 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230216AbhJ1NEE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Oct 2021 09:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635426097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FupFfwYx23AzIgmYL0JF4mnLTMKSzm4R1VAnl+qdKtw=;
        b=C5z6y3eNLbgQvoXLFgKsf0U3RlWwovyB2EmTDN9VRCIwtDpHUhADFWJhGROTNSZQ/lmYHo
        Mtf978Qi6G6REIHIGF4frQgZOh0+wnGYjvfZ6Jh+C+R+WR6fpv7P9nNjgtWdgznwQz0IcB
        2xbhxuAW6h9HtoIxZRSoQbEjqTyygRA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-ZULfcvIjNP2gz08D3yN8gw-1; Thu, 28 Oct 2021 09:01:35 -0400
X-MC-Unique: ZULfcvIjNP2gz08D3yN8gw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A92E110168C4;
        Thu, 28 Oct 2021 13:01:33 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.9.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21A795C1B4;
        Thu, 28 Oct 2021 13:01:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 8066A220562; Thu, 28 Oct 2021 09:01:32 -0400 (EDT)
Date:   Thu, 28 Oct 2021 09:01:32 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, adilger.kernel@dilger.ca,
        linux-xfs@vger.kernel.org,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [Question] ext4/xfs: Default behavior changed after per-file DAX
Message-ID: <YXqfLDLogZlk3m9e@redhat.com>
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
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Hi Jeffle,

Thanks for measuring the performance impact of enabling dax=inode by
default in server.

> 
> Currently we do ioctl() to query the persitent inode flags every time
> FUSE_LOOKUP request is received, maybe we could cache the result of
> ioctl() on virtiofsd side, but I have no idea how to intercept the
> runtime modification to these persistent indoe flags from other
> processes on host, e.g. sysadmin on host, to maintain the cache consistency.
> 
> So if the default behavior of client side is 'dax=inode', and virtiofsd
> disables per inode DAX by default (neither '-o dax=server|attr' is
> specified for virtiofsd) for the sake of performance, then guest won't
> see DAX enabled and thus won't be surprised. This can reduce the
> behavior change to the minimum.

Agreed. Lets not enable any dax by default in server and let admin/user
enable dax explicitly in server. From fuse client perspective, we can
assume dax=inode by default. That way kernel side behavior will be
similar to ext4/xfs (as long as server has been started with per
inode dax policy).

Vivek
> 
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
> 

