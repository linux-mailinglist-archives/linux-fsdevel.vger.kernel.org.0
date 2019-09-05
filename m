Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2F94AAC68
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 21:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391530AbfIETuz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 15:50:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732081AbfIETt0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:49:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EDE0A883823;
        Thu,  5 Sep 2019 19:49:25 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D6B46012D;
        Thu,  5 Sep 2019 19:49:18 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id B6929220292; Thu,  5 Sep 2019 15:49:17 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu
Cc:     linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        mst@redhat.com
Subject: [PATCH 00/18] virtiofs: Fix various races and cleanups round 1
Date:   Thu,  5 Sep 2019 15:48:41 -0400
Message-Id: <20190905194859.16219-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Thu, 05 Sep 2019 19:49:26 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Michael Tsirkin pointed out issues w.r.t various locking related TODO
items and races w.r.t device removal. 

In this first round of cleanups, I have taken care of most pressing
issues.

These patches apply on top of following.

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#virtiofs-v4

I have tested these patches with mount/umount and device removal using
qemu monitor. For example.

virsh qemu-monitor-command --hmp vm9-f28 device_del myvirtiofs

Now a mounted device can be removed and file system will return errors
-ENOTCONN and one can unmount it.

Miklos, if you are fine with the patches, I am fine if you fold these
all into existing patch. I kept them separate so that review is easier.

Any feedback or comments are welcome.

Thanks
Vivek


Vivek Goyal (18):
  virtiofs: Remove request from processing list before calling end
  virtiofs: Check whether hiprio queue is connected at submission time
  virtiofs: Pass fsvq instead of vq as parameter to
    virtio_fs_enqueue_req
  virtiofs: Check connected state for VQ_REQUEST queue as well
  Maintain count of in flight requests for VQ_REQUEST queue
  virtiofs: ->remove should not clean virtiofs fuse devices
  virtiofs: Stop virtiofs queues when device is being removed
  virtiofs: Drain all pending requests during ->remove time
  virtiofs: Add an helper to start all the queues
  virtiofs: Do not use device managed mem for virtio_fs and virtio_fs_vq
  virtiofs: stop and drain queues after sending DESTROY
  virtiofs: Use virtio_fs_free_devs() in error path
  virtiofs: Do not access virtqueue in request submission path
  virtiofs: Add a fuse_iqueue operation to put() reference
  virtiofs: Make virtio_fs object refcounted
  virtiofs: Use virtio_fs_mutex for races w.r.t ->remove and mount path
  virtiofs: Remove TODO to quiesce/end_requests
  virtiofs: Remove TODO item from virtio_fs_free_devs()

 fs/fuse/fuse_i.h    |   5 +
 fs/fuse/inode.c     |   6 +
 fs/fuse/virtio_fs.c | 259 ++++++++++++++++++++++++++++++++------------
 3 files changed, 198 insertions(+), 72 deletions(-)

-- 
2.20.1

