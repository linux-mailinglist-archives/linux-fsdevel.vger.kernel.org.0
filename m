Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAF79AB961
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 15:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405171AbfIFNhc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 09:37:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405168AbfIFNhb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:37:31 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7056591761
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2019 13:37:31 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id o5so2548281wrg.15
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2019 06:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aanmrrFSrbrC16B1/2djxgOZCrfOygi38gX6T8Hx2OE=;
        b=ZWsXMVPu+5dSD9xU0MGPzHxuPA0tq20HAqSe9/LPpgA8Uts5Mr0lydnaz0EZG/Ibrq
         5E0Fuq9cI80TAS93A8RE02atwBrbQyjPxMpbZnCV5CbDPqo3eUGxs4E0ZVbYhSn+YQQR
         urJFwy8myLCdB+ZKJjTEPBcIU6fb7R0H69MhU5CyT/cshBkvqxNPD91E91JiNxNUO+Iw
         YpFFX1ETlLk8fIbST1IDYSObGdYLFc+e/N3X151p4i9HDSYWJiZbAfLgmPmf3jL9jUgG
         aerh5ictOpZrEM3AhlbOpmk+eHeMDilaeD4AmM7b8kwRnuP5jChX4Iy/cMWN0s3OeUlL
         FjeA==
X-Gm-Message-State: APjAAAWgZ270vYvnHe6AEUf1x6RVUZ3tfhxdcklk1QyprA/gfdSTNnfF
        TIe1WMYbi4OVKoL+04ruijNq0+LIpsQXgjbAsZ3sj4sLiPVkhBfbgGlpOHDKgOnO9EBFgQZmAX6
        tH++ZUC/cZ5qJqzoApk+ZgVrvlw==
X-Received: by 2002:a5d:5387:: with SMTP id d7mr7529777wrv.312.1567777050244;
        Fri, 06 Sep 2019 06:37:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzrpuonK7IF0vd2h5/N8BnZyiFJnrBEAjQQ2tjZ4s0GtPaJu0RyYzs+POTHYWjLzSnK7iYEuw==
X-Received: by 2002:a5d:5387:: with SMTP id d7mr7529755wrv.312.1567777049914;
        Fri, 06 Sep 2019 06:37:29 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
        by smtp.gmail.com with ESMTPSA id k6sm10237535wrg.0.2019.09.06.06.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 06:37:29 -0700 (PDT)
Date:   Fri, 6 Sep 2019 09:37:26 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        stefanha@redhat.com, dgilbert@redhat.com
Subject: Re: [PATCH 00/18] virtiofs: Fix various races and cleanups round 1
Message-ID: <20190906093703-mutt-send-email-mst@kernel.org>
References: <20190905194859.16219-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905194859.16219-1-vgoyal@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 05, 2019 at 03:48:41PM -0400, Vivek Goyal wrote:
> Hi,
> 
> Michael Tsirkin pointed out issues w.r.t various locking related TODO
> items and races w.r.t device removal. 
> 
> In this first round of cleanups, I have taken care of most pressing
> issues.
> 
> These patches apply on top of following.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#virtiofs-v4
> 
> I have tested these patches with mount/umount and device removal using
> qemu monitor. For example.
> 
> virsh qemu-monitor-command --hmp vm9-f28 device_del myvirtiofs
> 
> Now a mounted device can be removed and file system will return errors
> -ENOTCONN and one can unmount it.
> 
> Miklos, if you are fine with the patches, I am fine if you fold these
> all into existing patch. I kept them separate so that review is easier.
> 
> Any feedback or comments are welcome.
> 
> Thanks
> Vivek
> 


Another version of a patch with fixes all rolled in would also
be nice.
> Vivek Goyal (18):
>   virtiofs: Remove request from processing list before calling end
>   virtiofs: Check whether hiprio queue is connected at submission time
>   virtiofs: Pass fsvq instead of vq as parameter to
>     virtio_fs_enqueue_req
>   virtiofs: Check connected state for VQ_REQUEST queue as well
>   Maintain count of in flight requests for VQ_REQUEST queue
>   virtiofs: ->remove should not clean virtiofs fuse devices
>   virtiofs: Stop virtiofs queues when device is being removed
>   virtiofs: Drain all pending requests during ->remove time
>   virtiofs: Add an helper to start all the queues
>   virtiofs: Do not use device managed mem for virtio_fs and virtio_fs_vq
>   virtiofs: stop and drain queues after sending DESTROY
>   virtiofs: Use virtio_fs_free_devs() in error path
>   virtiofs: Do not access virtqueue in request submission path
>   virtiofs: Add a fuse_iqueue operation to put() reference
>   virtiofs: Make virtio_fs object refcounted
>   virtiofs: Use virtio_fs_mutex for races w.r.t ->remove and mount path
>   virtiofs: Remove TODO to quiesce/end_requests
>   virtiofs: Remove TODO item from virtio_fs_free_devs()
> 
>  fs/fuse/fuse_i.h    |   5 +
>  fs/fuse/inode.c     |   6 +
>  fs/fuse/virtio_fs.c | 259 ++++++++++++++++++++++++++++++++------------
>  3 files changed, 198 insertions(+), 72 deletions(-)
> 
> -- 
> 2.20.1
