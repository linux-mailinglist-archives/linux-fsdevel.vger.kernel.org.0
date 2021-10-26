Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C8143BABD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 21:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238702AbhJZT20 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 15:28:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25563 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238781AbhJZT2Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 15:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635276360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uMyoPqJ/QkHGpAdsU7Vs4JEa1JKZe97nC5IoasVOAVc=;
        b=Y1iQ4LsS9OuW7oydUjkvpQcBlQHnBQrjZzd2eDB9+pqyuM+/jElipWYffYM7r2hxdmAE7L
        p1s+sNI2RCs5QkEQl3q1rtooE2+S1yZKhndOgOXBNIDwv6z2GFWoVY4MRQTSbaC+XSIirA
        BD0jGoNEKGPLC0VJ8OX3lhG10daXWuY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-35zCJcZ4Mn2KP7pFToTZeg-1; Tue, 26 Oct 2021 15:25:56 -0400
X-MC-Unique: 35zCJcZ4Mn2KP7pFToTZeg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E789D1007905;
        Tue, 26 Oct 2021 19:25:54 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DC375F4E0;
        Tue, 26 Oct 2021 19:25:52 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id BF40A2204A5; Tue, 26 Oct 2021 15:25:51 -0400 (EDT)
Date:   Tue, 26 Oct 2021 15:25:51 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     JeffleXu <jefflexu@linux.alibaba.com>,
        Theodore Ts'o <tytso@mit.edu>, adilger.kernel@dilger.ca,
        ira.weiny@intel.com, linux-xfs@vger.kernel.org,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [Question] ext4/xfs: Default behavior changed after per-file DAX
Message-ID: <YXhWP/FCkgHG/+ou@redhat.com>
References: <26ddaf6d-fea7-ed20-cafb-decd63b2652a@linux.alibaba.com>
 <20211026154834.GB24307@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026154834.GB24307@magnolia>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 26, 2021 at 08:48:34AM -0700, Darrick J. Wong wrote:
> On Tue, Oct 26, 2021 at 10:12:17PM +0800, JeffleXu wrote:
> > Hi,
> > 
> > Recently I'm working on supporting per-file DAX for virtiofs [1]. Vivek
> > Goyal and I are interested [2] why the default behavior has changed
> > since introduction of per-file DAX on ext4 and xfs [3][4].
> > 
> > That is, before the introduction of per-file DAX, when user doesn't
> > specify '-o dax', DAX is disabled for all files. After supporting
> > per-file DAX, when neither '-o dax' nor '-o dax=always|inode|never' is
> > specified, it actually works in a '-o dax=inode' way if the underlying
> > blkdev is DAX capable, i.e. depending on the persistent inode flag. That
> > is, the default behavior has changed from user's perspective.
> > 
> > We are not sure if this is intentional or not. Appreciate if anyone
> > could offer some hint.
> 
> Yes, that was an intentional change to all three filesystems to make the
> steps we expose to sysadmins/users consistent and documented officially:
> 
> https://lore.kernel.org/linux-fsdevel/20200429043328.411431-1-ira.weiny@intel.com/

Ok, so basically new dax options semantics are different from old "-o dax".

- dax=inode is default. This is change of behavior from old "-o dax" where
  default was *no dax* at all.

- I tried xfs and mount does not fail even if user mounted with
  "-o dax=inode" and underlying block device does not support dax.
  That's little strange. Some users might expect a failure if certain
  mount option can't be enabled.

  So in general, what's the expected behavior with filesystem mount
  options. If user passes a mount option and it can't be enabled,
  should filesystem return error and force user to try again without
  the certain mount option or silently fallback to something else.

  I think in the past I have come across overlayfs users which demanded
  that mount fails if certain overlayfs option they have passed in
  can't be honored. They want to know about it so that they can either
  fix the configuration or change mount option.

- With xfs, I mounted /dev/pmem0 with "-o dax=inode" and checked
  /proc/mounts and I don't see "dax=inode" there. Is that intentional?

I am just trying to wrap my head around the new semantics as we are
trying to implement those for virtiofs.

So following is the side affects of behavior change.

A. If somebody wrote scripts and scanned for mount flags to decide whehter
   dax is enabled or not, these will not work anymore. scripts will have
   to be changed to stat() every file in filesystem and look for
   STATX_ATTR_DAX flag to determine dax status.

I would have thought to not make dax=inode default and let user opt-in
for that using "dax=inode" mount option. But I guess people liked 
dax=inode default better.

Anway, I guess if we want to keep the behavior of virtiofs in-line with
ext4/xfs, we might have to make dax=inode default (atleast in client).
Server default might be different because querying the state of
FS_XFLAG_DAX is extra ioctl() call on each LOOKUP and GETATTR call and
those who don't want to use DAX, might not want to pay this cost.

Thanks
Vivek

> 
> (This was the first step; ext* were converted as separate series around
> the same time.)
> 
> --D
> 
> > 
> > 
> > [1] https://lore.kernel.org/all/YW2Oj4FrIB8do3zX@redhat.com/T/
> > [2]
> > https://lore.kernel.org/all/YW2Oj4FrIB8do3zX@redhat.com/T/#mf067498887ca2023c64c8b8f6aec879557eb28f8
> > [3] 9cb20f94afcd2964944f9468e38da736ee855b19 ("fs/ext4: Make DAX mount
> > option a tri-state")
> > [4] 02beb2686ff964884756c581d513e103542dcc6a ("fs/xfs: Make DAX mount
> > option a tri-state")
> > 
> > 
> > -- 
> > Thanks,
> > Jeffle
> 

