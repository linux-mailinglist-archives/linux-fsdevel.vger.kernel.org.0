Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF7E4733B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 19:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241751AbhLMSNM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 13:13:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60750 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241489AbhLMSNL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:13:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639419191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lkqXZEdV7YVkcWExftspf/54i0BEWhlSAx/t+8WBgPQ=;
        b=BRdM51RyEW1P9ffrSk80Yzk6B/xFaX6/UpY2X7AV/quNwufXMptzZ/9lptAoN5ae9msghT
        W8gAgOWCQKCRwxan7QxPZzlwNib54WPP2t0PVPmCX7qKyWp4Sk7B4rFLSMjpfmY31jLG9O
        LhUg8wT7npxzZ3oJtlALmEjcbbKAqgc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-WbbbN1hPOzGDSoxpUBDB9A-1; Mon, 13 Dec 2021 13:13:08 -0500
X-MC-Unique: WbbbN1hPOzGDSoxpUBDB9A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBA9B1023F4F;
        Mon, 13 Dec 2021 18:13:06 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B42F0610F5;
        Mon, 13 Dec 2021 18:12:38 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 48C562233DF; Mon, 13 Dec 2021 13:12:38 -0500 (EST)
Date:   Mon, 13 Dec 2021 13:12:38 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu, virtio-fs@redhat.com,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v8 0/7] fuse,virtiofs: support per-file DAX
Message-ID: <YbeNFkzynMUHRnoS@redhat.com>
References: <20211125070530.79602-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125070530.79602-1-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 25, 2021 at 03:05:23PM +0800, Jeffle Xu wrote:
> changes since v7:
> - rebase to v5.16
> - patch 2: rename FUSE_DAX_NONE|FUSE_DAX_INODE to
>   FUSE_DAX_INODE_DEFAULT|FUSE_DAX_INODE_USER
> - patch 5: remove redundant call for fuse_is_inode_dax_mode() in
>   process_init_reply()
> - patch 5: if server's map alignment is non-compliant (fail
>   fuse_dax_check_alignment()), the mounted fs won't work and users are
>   required to remount it explicitly, instead of silently falling back to
>   'never' mode.

Thanks Jeffle for this work. These patches look good to me. I have done
a basic testing with it and it seems to work as expected. Hence I have
provided my Reviewed-by tags for all the patches. 

Now it is up to the Miklos to decide whether he likes the patches or not.

Thanks
Vivek
> 
> Corresponding changes to virtiofsd:
> https://www.mail-archive.com/virtio-fs@redhat.com/msg04349.html
> 
> v7: https://lore.kernel.org/all/c41837f0-a183-d911-885d-cf3bcdd9b7c8@linux.alibaba.com/T/
> v6: https://lore.kernel.org/all/20211011030052.98923-1-jefflexu@linux.alibaba.com/
> v5: https://lore.kernel.org/all/20210923092526.72341-1-jefflexu@linux.alibaba.com/
> v4: https://lore.kernel.org/linux-fsdevel/20210817022220.17574-1-jefflexu@linux.alibaba.com/
> v3: https://www.spinics.net/lists/linux-fsdevel/msg200852.html
> v2: https://www.spinics.net/lists/linux-fsdevel/msg199584.html
> v1: https://www.spinics.net/lists/linux-virtualization/msg51008.html
> 
> Original Rationale for this Patchset
> ====================================
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
> 
> Jeffle Xu (7):
>   fuse: add fuse_should_enable_dax() helper
>   fuse: make DAX mount option a tri-state
>   fuse: support per inode DAX in fuse protocol
>   fuse: enable per inode DAX
>   fuse: negotiate per inode DAX in FUSE_INIT
>   fuse: mark inode DONT_CACHE when per inode DAX hint changes
>   Documentation/filesystem/dax: DAX on virtiofs
> 
>  Documentation/filesystems/dax.rst | 20 +++++++++++++++--
>  fs/fuse/dax.c                     | 36 +++++++++++++++++++++++++++++--
>  fs/fuse/file.c                    |  4 ++--
>  fs/fuse/fuse_i.h                  | 28 ++++++++++++++++++++----
>  fs/fuse/inode.c                   | 28 +++++++++++++++++-------
>  fs/fuse/virtio_fs.c               | 18 +++++++++++++---
>  include/uapi/linux/fuse.h         |  5 +++++
>  7 files changed, 118 insertions(+), 21 deletions(-)
> 
> -- 
> 2.27.0
> 

