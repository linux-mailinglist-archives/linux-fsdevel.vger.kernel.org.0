Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8108638B37C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 17:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbhETPsc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 11:48:32 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:24146 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232783AbhETPsb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 11:48:31 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-vupLqh65Oji912do6_HGVA-1; Thu, 20 May 2021 11:47:05 -0400
X-MC-Unique: vupLqh65Oji912do6_HGVA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA3DA79EC4;
        Thu, 20 May 2021 15:47:04 +0000 (UTC)
Received: from bahia.redhat.com (ovpn-112-99.ams2.redhat.com [10.36.112.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2DE310016F4;
        Thu, 20 May 2021 15:46:55 +0000 (UTC)
From:   Greg Kurz <groug@kaod.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        Max Reitz <mreitz@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Greg Kurz <groug@kaod.org>
Subject: [PATCH v4 0/5] virtiofs: propagate sync() to file server
Date:   Thu, 20 May 2021 17:46:49 +0200
Message-Id: <20210520154654.1791183-1-groug@kaod.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This was a single patch until v3. Some preliminary cleanups were
introduced for submounts in this v4.

This can be tested with a custom virtiofsd implementing FUSE_SYNCFS, here:

https://gitlab.com/gkurz/qemu/-/tree/fuse-sync

v4: - submount fixes
    - set nodeid of the superblock in the request (Miklos)

v3: - just keep a 64-bit padding field in the arg struct (Vivek)

v2: - clarify compatibility with older servers in changelog (Vivek)
    - ignore the wait == 0 case (Miklos)
    - 64-bit aligned argument structure (Vivek, Miklos)

Greg Kurz (5):
  fuse: Fix leak in fuse_dentry_automount() error path
  fuse: Call vfs_get_tree() for submounts
  fuse: Make fuse_fill_super_submount() static
  virtiofs: Skip submounts in sget_fc()
  virtiofs: propagate sync() to file server

 fs/fuse/dir.c             | 45 +++++---------------
 fs/fuse/fuse_i.h          | 12 +++---
 fs/fuse/inode.c           | 87 ++++++++++++++++++++++++++++++++++++++-
 fs/fuse/virtio_fs.c       |  9 ++++
 include/uapi/linux/fuse.h | 10 ++++-
 5 files changed, 120 insertions(+), 43 deletions(-)

-- 
2.26.3


