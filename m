Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56BA39BCB3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 18:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhFDQOC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Fri, 4 Jun 2021 12:14:02 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:28494 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229976AbhFDQOB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:14:01 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-CmAo95vYMZKnalAqwwVMqA-1; Fri, 04 Jun 2021 12:12:11 -0400
X-MC-Unique: CmAo95vYMZKnalAqwwVMqA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DD5D180FD6F;
        Fri,  4 Jun 2021 16:12:09 +0000 (UTC)
Received: from bahia.lan (ovpn-112-232.ams2.redhat.com [10.36.112.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E038F60CEC;
        Fri,  4 Jun 2021 16:11:57 +0000 (UTC)
From:   Greg Kurz <groug@kaod.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-kernel@vger.kernel.org, Max Reitz <mreitz@redhat.com>,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        Vivek Goyal <vgoyal@redhat.com>, Greg Kurz <groug@kaod.org>
Subject: [PATCH v2 0/7] fuse: Some fixes for submounts
Date:   Fri,  4 Jun 2021 18:11:49 +0200
Message-Id: <20210604161156.408496-1-groug@kaod.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

v2:

- add an extra fix (patch 2) : mount is now added to the list before
  unlocking sb->s_umount
- set SB_BORN just before unlocking sb->s_umount, just like it would
  happen when using fc_mount() (Max)
- don't allocate a FUSE context for the submounts (Max)
- introduce a dedicated context ops for submounts
- add a extra cleanup : simplify the code even more with fc_mount()

v1:

While working on adding syncfs() support in FUSE, I've hit some severe
bugs with submounts (a crash and an infinite loop). The fix for the
crash is straightforward (patch 1), but the fix for the infinite loop
is more invasive : as suggested by Miklos, a simple bug fix is applied
first (patch 2) and the final fix (patch 3) is applied on top.

Greg Kurz (7):
  fuse: Fix crash in fuse_dentry_automount() error path
  fuse: Fix crash if superblock of submount gets killed early
  fuse: Fix infinite loop in sget_fc()
  fuse: Add dedicated filesystem context ops for submounts
  fuse: Call vfs_get_tree() for submounts
  fuse: Switch to fc_mount() for submounts
  fuse: Make fuse_fill_super_submount() static

 fs/fuse/dir.c       | 58 ++++++---------------------------------------
 fs/fuse/fuse_i.h    | 14 ++++-------
 fs/fuse/inode.c     | 56 +++++++++++++++++++++++++++++++++++++++++--
 fs/fuse/virtio_fs.c |  3 +++
 4 files changed, 69 insertions(+), 62 deletions(-)

-- 
2.31.1


