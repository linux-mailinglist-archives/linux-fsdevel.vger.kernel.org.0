Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4B243A4EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 22:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhJYUtj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 16:49:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46799 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231339AbhJYUti (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635194835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AeN7KcDHjn6aum/R7EAKq/9fY+9mB67hD1V5NhOmHYw=;
        b=XObmiFWuWk1xCLW0n2yABSkQs86i41B5ODS5ZQF9GVPtvQNh+udHgz61xQPXbv+pU63NVK
        dPzXxI6jFM4whJG/hgggxjZDU8FVuvCv03ccjCaxzxNgBOjOOjaSmhkfKoqVagn6t56MKj
        HGqeR0M3bzaFDnmyVFRaONxV1nxm1E0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-5IxlmRrIOraATQK6ncZeBg-1; Mon, 25 Oct 2021 16:47:12 -0400
X-MC-Unique: 5IxlmRrIOraATQK6ncZeBg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D8F6362FA;
        Mon, 25 Oct 2021 20:47:11 +0000 (UTC)
Received: from iangelak.redhat.com (unknown [10.22.32.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3839760CA1;
        Mon, 25 Oct 2021 20:47:07 +0000 (UTC)
From:   Ioannis Angelakopoulos <iangelak@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        linux-kernel@vger.kernel.org, jack@suse.cz, amir73il@gmail.com,
        viro@zeniv.linux.org.uk, miklos@szeredi.hu, vgoyal@redhat.com
Cc:     Ioannis Angelakopoulos <iangelak@redhat.com>
Subject: [RFC PATCH 0/7] Inotify support in FUSE and virtiofs
Date:   Mon, 25 Oct 2021 16:46:27 -0400
Message-Id: <20211025204634.2517-1-iangelak@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I am a PhD student currently interning at Red Hat and working on the
virtiofs file system. I am trying to add support for the Inotify
notification subsystem in virtiofs. I seek your feedback and
suggestions on what is the right direction to take.

Currently, virtiofs does not support the Inotify API and there are
applications which look for the Inotify support in virtiofs (e.g., Kata
containers).

However, all the event notification subsystems (Dnotify/Inotify/Fanotify)
are supported by only by local kernel file systems.

--Proposed solution

With this RFC patch we add the inotify support to the FUSE kernel module
so that the remote virtiofs file system (based on FUSE) used by a QEMU
guest VM can make use of this feature.

Specifically, we enhance FUSE to add/modify/delete watches on the FUSE
server and also receive remote inotify events. To achieve this we modify
the fsnotify subsystem so that it calls specific hooks in FUSE when a
remote watch is added/modified/deleted and FUSE calls into fsnotify when
a remote event is received to send the event to user space.

In our case the FUSE server is virtiofsd.

We also considered an out of band approach for implementing the remote
notifications (e.g., FAM, Gamin), however this approach would break
applications that are already compatible with inotify, and thus would
require an update.

These kernel patches depend on the patch series posted by Vivek Goyal:
https://lore.kernel.org/linux-fsdevel/20210930143850.1188628-1-vgoyal@redhat.com/

My PoC Linux kernel patches are here:
https://github.com/iangelak/linux/commits/inotify_v1

My PoC virtiofsd corresponding patches are here:
https://github.com/iangelak/qemu/commits/inotify_v1

--Advantages

1) Our approach is compatible with existing applications that rely on
Inotify, thus improves portability.

2) Everything is implemented in one place (virtiofs and virtiofsd) and
there is no need to run additional processes (daemons) specifically to
handle the remote notifications.

--Weaknesses

1) Both a local (QEMU guest) and a remote (Host/Virtiofsd) watch on the
target inode have to be active at the same time. The local watch
guarantees that events are going to be sent to the guest user space while
the remote watch captures events occurring on the host (and will be sent
to the guest).

As a result, when an event occures on a inode within the exported
directory by virtiofs, two events will be generated at the same time; a
local event (generated by the guest kernel) and a remote event (generated
by the host), thus the guest will receive duplicate events.

To account for this issue we implemented two modes; one where local events
function as expected (when virtiofsd does not support the remote
inotify) and one where the local events are suppressed and only the
remote events originating from the host side are let through (when
virtiofsd supports the remote inotify).

3) The lifetime of the local watch in the guest kernel is very
important. Specifically, there is a possibility that the guest does not
receive remote events on time, if it removes its local watch on the
target or deletes the inode (and thus the guest kernel removes the watch).
In these cases the guest kernel removes the local watch before the
remote events arrive from the host (virtiofsd) and as such the guest
kernel drops all the remote events for the target inode (since the
corresponding local watch does not exist anymore). On top of that,
virtiofsd keeps an open proc file descriptor for each inode that is not
immediately closed on a inode deletion request by the guest. As a result
no IN_DELETE_SELF is generated by virtiofsd and sent to the guest kernel
in this case.

4) Because virtiofsd implements additional operations during the
servicing of a request from the guest, additional inotify events might
be generated and sent to the guest other than the ones the guest
expects. However, this is not technically a limitation and it is dependent
on the implementation of the remote file system server (in this case
virtiofsd).

5) The current implementation only supports Inotify, due to its
simplicity and not Fanotify. Fanotify's complexity requires support from
virtiofsd that is not currently available. One such example is
Fsnotify's access permission decision capabilities, which could
conflict with virtiofsd's current access permission implementation.

Ioannis Angelakopoulos (7):
  FUSE: Add the fsnotify opcode and in/out structs to FUSE
  FUSE: Add the remote inotify support capability to FUSE
  FUSE,Inotify,Fsnotify,VFS: Add the fuse_fsnotify_update_mark inode
    operation
  FUSE: Add the fuse_fsnotify_send_request to FUSE
  Fsnotify: Add a wrapper around the fsnotify function
  FUSE,Fsnotify: Add the fuse_fsnotify_event inode operation
  virtiofs: Add support for handling the remote fsnotify notifications

 fs/fuse/dev.c                    | 37 ++++++++++++++++++
 fs/fuse/dir.c                    | 56 ++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h                 | 10 +++++
 fs/fuse/inode.c                  |  6 +++
 fs/fuse/virtio_fs.c              | 64 +++++++++++++++++++++++++++++++-
 fs/notify/fsnotify.c             | 35 ++++++++++++++++-
 fs/notify/inotify/inotify_user.c | 11 ++++++
 fs/notify/mark.c                 | 10 +++++
 include/linux/fs.h               |  5 +++
 include/linux/fsnotify_backend.h | 14 ++++++-
 include/uapi/linux/fuse.h        | 23 +++++++++++-
 11 files changed, 265 insertions(+), 6 deletions(-)

-- 
2.33.0

