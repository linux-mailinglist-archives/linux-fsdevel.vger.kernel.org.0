Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860273CEF4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 00:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389938AbhGSVh1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 17:37:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49247 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1388312AbhGSUtd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 16:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626730212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dG16gNlXaHcUyckB4zj2EV2whasjEhhcwORskpcNxoE=;
        b=VsjcIP5g4EgAUi7RWucOC4j1CMLplZVnyAT5FBm7Sn/b9sBM6yGUsU4H1VEsoUmQvUFRzs
        rlHHHV+ao2UPyIy4SO6Va94L66mSZ0B3NyZTbcQiWnu8BBH/LlMl6ZzncdfTd14eGE16cl
        ru9lIhrdmUpXpJ2Qc/5ldY72b9uvAog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-3m2FqKCxPaiSMo1jWbqsxA-1; Mon, 19 Jul 2021 17:30:11 -0400
X-MC-Unique: 3m2FqKCxPaiSMo1jWbqsxA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AB10362F8;
        Mon, 19 Jul 2021 21:30:09 +0000 (UTC)
Received: from horse.redhat.com (ovpn-118-17.rdu2.redhat.com [10.10.118.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A92535D9D3;
        Mon, 19 Jul 2021 21:30:04 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 32E71223E4F; Mon, 19 Jul 2021 17:30:04 -0400 (EDT)
Date:   Mon, 19 Jul 2021 17:30:04 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v2 0/4] virtiofs,fuse: support per-file DAX
Message-ID: <YPXu3BefIi7Ts48I@redhat.com>
References: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 16, 2021 at 06:47:49PM +0800, Jeffle Xu wrote:
> This patchset adds support of per-file DAX for virtiofs, which is
> inspired by Ira Weiny's work on ext4[1] and xfs[2].
> 
> There are three related scenarios:
> 1. Alloc inode: get per-file DAX flag from fuse_attr.flags. (patch 3)
> 2. Per-file DAX flag changes when the file has been opened. (patch 3)
> In this case, the dentry and inode are all marked as DONT_CACHE, and
> the DAX state won't be updated until the file is closed and reopened
> later.
> 3. Users can change the per-file DAX flag inside the guest by chattr(1).
> (patch 4)
> 4. Create new files under directories with DAX enabled. When creating
> new files in ext4/xfs on host, the new created files will inherit the
> per-file DAX flag from the directory, and thus the new created files in
> virtiofs will also inherit the per-file DAX flag if the fuse server
> derives fuse_attr.flags from the underlying ext4/xfs inode's per-file
> DAX flag.

Thinking little bit more about this from requirement perspective. I think
we are trying to address two use cases here.

A. Client does not know which files DAX should be used on. Only server
   knows it and server passes this information to client. I suspect
   that's your primary use case.

B. Client is driving which files are supposed to be using DAX. This is
   exactly same as the model ext4/xfs are using by storing a persistent
   flag on inode. 

Current patches seem to be a hybrid of both approach A and B. 

If we were to implement B, then fuse client probably needs to have the
capability to query FS_XFLAG_DAX on inode and decide whether to
enable DAX or not. (Without extra round trip). Or know it indirectly
by extending GETATTR and requesting this explicitly.

If we were only implementing A, then server does not have a way to 
tell client to enable DAX. Server can either look at FS_XFLAG_DAX
and decide to enable DAX or use some other property. Given querying
FS_XFLAG_DAX will be an extra ioctl() on every inode lookup/getattr,
it probably will be a server option. But enabling on server does not
mean client will enable it.

I think my primary concern with this patch right now is trying to
figure out which requirement we are trying to cater to first and how
to connect server and client well so they both understand what mode
they are operating in and interact well.

Vivek

> 
> 
> Any comment is welcome.
> 
> [1] commit 9cb20f94afcd ("fs/ext4: Make DAX mount option a tri-state")
> [2] commit 02beb2686ff9 ("fs/xfs: Make DAX mount option a tri-state")
> 
> 
> changes since v1:
> - add support for changing per-file DAX flags inside guest (patch 4)
> 
> v1:https://www.spinics.net/lists/linux-virtualization/msg51008.html
> 
> Jeffle Xu (4):
>   fuse: add fuse_should_enable_dax() helper
>   fuse: Make DAX mount option a tri-state
>   fuse: add per-file DAX flag
>   fuse: support changing per-file DAX flag inside guest
> 
>  fs/fuse/dax.c             | 36 ++++++++++++++++++++++++++++++++++--
>  fs/fuse/file.c            |  4 ++--
>  fs/fuse/fuse_i.h          | 16 ++++++++++++----
>  fs/fuse/inode.c           |  7 +++++--
>  fs/fuse/ioctl.c           |  9 ++++++---
>  fs/fuse/virtio_fs.c       | 16 ++++++++++++++--
>  include/uapi/linux/fuse.h |  5 +++++
>  7 files changed, 78 insertions(+), 15 deletions(-)
> 
> -- 
> 2.27.0
> 

