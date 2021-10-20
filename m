Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B625434FB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 18:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhJTQIt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 12:08:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36506 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231127AbhJTQIs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634745993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mpD7lqeK10V1p5jxWsgBeE3IJHB2sA3gAM212qwyuDQ=;
        b=M4xwRoDpVYvwwAPTRBePKCg1THUPZW81s0KrmuQJlNoz6awBjzgg6/TfGH8rwR2z1sE5OS
        dHeXpfPEh1qdKYJDtadIa8G64fOVThJBSGCbCsXzHfTl0cR0VwPX0Rl5g151yxNtOR7J/B
        iHmRxJW/q4OWYaQRB3k7l1U1+Y4MOp4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-tE-ZrEwIMpm3B_bIZFzJug-1; Wed, 20 Oct 2021 12:06:30 -0400
X-MC-Unique: tE-ZrEwIMpm3B_bIZFzJug-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CC4A1B18BC1;
        Wed, 20 Oct 2021 16:06:29 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9236A7092B;
        Wed, 20 Oct 2021 16:06:13 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 309EB2256FC; Wed, 20 Oct 2021 12:06:13 -0400 (EDT)
Date:   Wed, 20 Oct 2021 12:06:13 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v6 0/7] fuse,virtiofs: support per-file DAX
Message-ID: <YXA+dYmIUGwGVskC@redhat.com>
References: <20211011030052.98923-1-jefflexu@linux.alibaba.com>
 <YW2Q5Y3u1TMlQEcW@redhat.com>
 <85e66fb6-7587-4b8b-3e6f-0fc1019996fc@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85e66fb6-7587-4b8b-3e6f-0fc1019996fc@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 20, 2021 at 01:22:32PM +0800, JeffleXu wrote:
> 
> 
> On 10/18/21 11:21 PM, Vivek Goyal wrote:
> > On Mon, Oct 11, 2021 at 11:00:45AM +0800, Jeffle Xu wrote:
> >> changes since v5:
> >> Overall Design Changes:
> >> 1. virtiofsd now supports ioctl (only FS_IOC_SETFLAGS and
> >>   FS_IOC_FSSETXATTR), so that users inside guest could set/clear
> >>   persistent inode flags now. (FUSE kernel module has already supported
> >>   .ioctl(), virtiofsd need to suuport it.)
> > 
> > So no changes needed in fuse side (kernel) to support FS_IOC_FSSETXATTR?
> > Only virtiofsd needs to be changed. That sounds good.
> > 
> 
> Yes, the fuse kernel modules has already supported FUSE_IOCTL.
> 
> Per inode DAX on ext4/xfs will also call d_mark_dontcache() and try to
> evict this inode as soon as possible when the persistent (DAX) inode
> attribute has changed, just like [1].
> 
> But because of following reason:
> > 
> >> 2. The
> >>   algorithm used by virtiofsd to determine whether DAX shall be enabled
> >>   or not is totally implementation specific, and thus the following
> >>   scenario may exist: users inside guest has already set related persistent
> >>   inode flag (i.e. FS_XFLAG_DAX) on corresponding file but FUSE server finnaly
> >>   decides not to enable DAX for this file.
> 
> If we always call d_mark_dontcache() and try to evict this inode when
> the persistent (DAX) inode attribute has changed, the DAX state returned
> by virtiofsd may sustain the same, and thus the previous eviction is
> totally wasted and unnecessary.
> 
> So, as the following said,
> 
> >> Also because of this, d_mark_dontcache() is
> >>   not called when FS_IOC_SETFLAGS/FS_IOC_FSSETXATTR ioctl is done inside
> >>   guest. It's delayed to be done if the FUSE_ATTR_DAX flag **indeed**
> >>   changes (as showed in patch 6).
> 
> the call for d_mark_dontcache() and inode eviction is delayed when the
> DAX state returned by virtiofsd **indeed** changed (when dentry is timed
> out and a new FUSE_LOOKUP is requested). But the defect is that, if '-o
> cache=always' is set for virtiofsd, then the DAX state won't be updated
> for a long time, after users have changed the persistent (DAX) inode
> attribute inside guest via FS_IOC_FSSETXATTR ioctl.

Good point. I guess this probably is not too bad. If it becomes a concern,
we can always mark inode don't cache whenever client changes persistent
DAX flag.

Vivek
> 
> 
> 
> [1] https://www.spinics.net/lists/linux-fsdevel/msg200851.html
> 
> -- 
> Thanks,
> Jeffle
> 

