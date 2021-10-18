Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5D64322B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 17:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhJRPX0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:23:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32415 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229696AbhJRPX0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634570474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=phnFA+AYZdIW/IIrvmeatNFlSS2NokT860i5SDg7OrU=;
        b=d1WU/npCRtLV79jCYleBxcNmszOYyvAsRoO3k/dc0rMhcoUvJNVLNHSj9TE8qD+0FVgqaK
        fNWuUE900+RFz+QioHuZM/KFREcnQNy8wkKmEjQYv8uJn3CnrB21rDoXcVKjkdpp5+KuWs
        WNF95H4ad6BaU4J201Lj/KDdHpY2qRg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-egyOuiRqOnKApDVEdZuyZw-1; Mon, 18 Oct 2021 11:21:11 -0400
X-MC-Unique: egyOuiRqOnKApDVEdZuyZw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02522100D09D;
        Mon, 18 Oct 2021 15:21:10 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A42FB6418A;
        Mon, 18 Oct 2021 15:21:09 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 331572256F5; Mon, 18 Oct 2021 11:21:09 -0400 (EDT)
Date:   Mon, 18 Oct 2021 11:21:09 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hub,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v6 0/7] fuse,virtiofs: support per-file DAX
Message-ID: <YW2Q5Y3u1TMlQEcW@redhat.com>
References: <20211011030052.98923-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011030052.98923-1-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 11, 2021 at 11:00:45AM +0800, Jeffle Xu wrote:
> changes since v5:
> Overall Design Changes:
> 1. virtiofsd now supports ioctl (only FS_IOC_SETFLAGS and
>   FS_IOC_FSSETXATTR), so that users inside guest could set/clear
>   persistent inode flags now. (FUSE kernel module has already supported
>   .ioctl(), virtiofsd need to suuport it.)

So no changes needed in fuse side (kernel) to support FS_IOC_FSSETXATTR?
Only virtiofsd needs to be changed. That sounds good.

Vivek

> 2. When FUSE client is mounted with '-o dax=inode', it indicates that
>   whether DAX shall be enabled or not for one specific file is
>   completely determined by FUSE server while FUSE client has no say on
>   it, and the decision whether DAX shall be enabled or not for specific
>   file is communicated through FUSE_ATTR_DAX flag of FUSE protocol. The
>   algorithm used by virtiofsd to determine whether DAX shall be enabled
>   or not is totally implementation specific, and thus the following
>   scenario may exist: users inside guest has already set related persistent
>   inode flag (i.e. FS_XFLAG_DAX) on corresponding file but FUSE server finnaly
>   decides not to enable DAX for this file. This slight semantic difference
>   is documented in patch 7. Also because of this, d_mark_dontcache() is
>   not called when FS_IOC_SETFLAGS/FS_IOC_FSSETXATTR ioctl is done inside
>   guest. It's delayed to be done if the FUSE_ATTR_DAX flag **indeed**
>   changes (as showed in patch 6).
> 3. patch 1: slightly modify logic of fuse_should_enable_dax()
> 4. patch 4: add back negotiation during FUSE_INIT. FUSE client shall
>   advertise to FUSE server that it's in per-file DAX mode, so that FUSE
>   server may omit querying persistent inode flags on host if FUSE client
>   is not mounted in per-file DAX mode, giving querying persistent inode
>   flags could be quite expensive.
> 
> 
> chanegs since v4:
> - drop support for setting/clearing FS_DAX inside guest
> - and thus drop the negotiation phase during FUSE_INIT
> 
> This patchset adds support of per-file DAX for virtiofs, which is
> inspired by Ira Weiny's work on ext4[1] and xfs[2].
> 
> Any comment is welcome.
> 
> [1] commit 9cb20f94afcd ("fs/ext4: Make DAX mount option a tri-state")
> [2] commit 02beb2686ff9 ("fs/xfs: Make DAX mount option a tri-state")
> 
> [Purpose]
> DAX may be limited in some specific situation. When the number of usable
> DAX windows is under watermark, the recalim routine will be triggered to
> reclaim some DAX windows. It may have a negative impact on the
> performance, since some processes may need to wait for DAX windows to be
> recalimed and reused then. To mitigate the performance degradation, the
> overall DAX window need to be expanded larger.
> 
> However, simply expanding the DAX window may not be a good deal in some
> scenario. To maintain one DAX window chunk (i.e., 2MB in size), 32KB
> (512 * 64 bytes) memory footprint will be consumed for page descriptors
> inside guest, which is greater than the memory footprint if it uses
> guest page cache when DAX disabled. Thus it'd better disable DAX for
> those files smaller than 32KB, to reduce the demand for DAX window and
> thus avoid the unworthy memory overhead.
> 
> Per-file DAX feature is introduced to address this issue, by offering a
> finer grained control for dax to users, trying to achieve a balance
> between performance and memory overhead.
> 
> 
> [Note]
> When the per-file DAX hint changes while the file is still *opened*, it
> is quite complicated and maybe fragile to dynamically change the DAX
> state, since dynamic switching needs to switch a_ops atomiclly. Ira
> Weiny had ever implemented a so called i_aops_sem lock [3] but
> eventually gave up since the complexity of the implementation
> [4][5][6][7].
> 
> Hence mark the inode and corresponding dentries as DONE_CACHE once the
> per-file DAX hint changes, so that the inode instance will be evicted
> and freed as soon as possible once the file is closed and the last
> reference to the inode is put. And then when the file gets reopened next
> time, the new instantiated inode will reflect the new DAX state.
> 
> In summary, when the per-file DAX hint changes for an *opened* file, the
> DAX state of the file won't be updated until this file is closed and
> reopened later. This is also how ext4/xfs per-file DAX works.
> 
> [3] https://lore.kernel.org/lkml/20200227052442.22524-7-ira.weiny@intel.com/
> [4] https://patchwork.kernel.org/project/xfs/cover/20200407182958.568475-1-ira.weiny@intel.com/
> [5] https://lore.kernel.org/lkml/20200305155144.GA5598@lst.de/
> [6] https://lore.kernel.org/lkml/20200401040021.GC56958@magnolia/
> [7] https://lore.kernel.org/lkml/20200403182904.GP80283@magnolia/
> 
> changes since v3:
> - bug fix (patch 6): s/"IS_DAX(inode) != newdax"/"!!IS_DAX(inode) !=
>   newdax"
> - during FUSE_INIT, advertise capability for per-file DAX only when
>   mounted as "-o dax=inode" (patch 4)
> 
> changes since v2:
> - modify fuse_show_options() accordingly to make it compatible with
>   new tri-state mount option (patch 2)
> - extract FUSE protocol changes into one separate patch (patch 3)
> - FUSE server/client need to negotiate if they support per-file DAX
>   (patch 4)
> - extract DONT_CACHE logic into patch 6/7
> 
> v5: https://lore.kernel.org/all/20210923092526.72341-1-jefflexu@linux.alibaba.com/
> v4: https://lore.kernel.org/linux-fsdevel/20210817022220.17574-1-jefflexu@linux.alibaba.com/
> v3: https://www.spinics.net/lists/linux-fsdevel/msg200852.html
> v2: https://www.spinics.net/lists/linux-fsdevel/msg199584.html
> v1: https://www.spinics.net/lists/linux-virtualization/msg51008.html
> 
> 
> Jeffle Xu (7):
>   fuse: add fuse_should_enable_dax() helper
>   fuse: make DAX mount option a tri-state
>   fuse: support per-file DAX in fuse protocol
>   fuse: negotiate per-file DAX in FUSE_INIT
>   fuse: enable per-file DAX
>   fuse: mark inode DONT_CACHE when per-file DAX hint changes
>   Documentation/filesystem/dax: record DAX on virtiofs
> 
>  Documentation/filesystems/dax.rst | 20 +++++++++++++++--
>  fs/fuse/dax.c                     | 36 ++++++++++++++++++++++++++++---
>  fs/fuse/file.c                    |  4 ++--
>  fs/fuse/fuse_i.h                  | 19 ++++++++++++----
>  fs/fuse/inode.c                   | 17 +++++++++++----
>  fs/fuse/virtio_fs.c               | 16 ++++++++++++--
>  include/uapi/linux/fuse.h         |  9 +++++++-
>  7 files changed, 103 insertions(+), 18 deletions(-)
> 
> -- 
> 2.27.0
> 

