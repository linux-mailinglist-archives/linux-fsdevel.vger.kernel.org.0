Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5A939047B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 17:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhEYPEN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 11:04:13 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:49645 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231196AbhEYPEM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 11:04:12 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-7C9pcnqfPDeWOuR97G3bxA-1; Tue, 25 May 2021 11:02:38 -0400
X-MC-Unique: 7C9pcnqfPDeWOuR97G3bxA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37E97192CC41;
        Tue, 25 May 2021 15:02:37 +0000 (UTC)
Received: from bahia.lan (ovpn-113-46.ams2.redhat.com [10.36.113.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 449495D75A;
        Tue, 25 May 2021 15:02:31 +0000 (UTC)
From:   Greg Kurz <groug@kaod.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Vivek Goyal <vgoyal@redhat.com>, virtio-fs@redhat.com,
        Greg Kurz <groug@kaod.org>
Subject: [PATCH 0/4] fuse: Some fixes for submounts
Date:   Tue, 25 May 2021 17:02:26 +0200
Message-Id: <20210525150230.157586-1-groug@kaod.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While working on adding syncfs() support in FUSE, I've hit some severe
bugs with submounts (a crash and an infinite loop). The fix for the
crash is straightforward (patch 1), but the fix for the infinite loop
is more invasive : as suggested by Miklos, a simple bug fix is applied
first (patch 2) and the final fix (patch 3) is applied on top.

Greg Kurz (4):
  fuse: Fix crash in fuse_dentry_automount() error path
  fuse: Fix infinite loop in sget_fc()
  fuse: Call vfs_get_tree() for submounts
  fuse: Make fuse_fill_super_submount() static

 fs/fuse/dir.c       | 46 ++++++++++---------------------------------
 fs/fuse/fuse_i.h    |  9 +++------
 fs/fuse/inode.c     | 48 +++++++++++++++++++++++++++++++++++++++++++--
 fs/fuse/virtio_fs.c |  3 +++
 4 files changed, 62 insertions(+), 44 deletions(-)

-- 
2.31.1


