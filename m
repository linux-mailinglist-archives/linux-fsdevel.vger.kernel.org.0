Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D06E2890A0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 20:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388176AbgJISQl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 14:16:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54621 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731864AbgJISQl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 14:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602267399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6AOI++zZ6Cc9pncudS+cwz7OKe/aDNndvOS5Ql/WTSg=;
        b=QMTommPiXgskajhRYIYryRtoZPxraQXkvhXNoKAs+YTc+t6P5fR1Zm2K+OTbDNapXSzw0X
        qlmbLwo4hmhVXFlqWczDeN4Oydtc2ODLb0vHe7O5HECmT3uB73rbBUr2UvcwhPxc0Iczpy
        yCnCgUH/sZWR20Mj/o02+mdX5LUF2Ko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-OqU97U7IMFCPu48irsqf2w-1; Fri, 09 Oct 2020 14:16:37 -0400
X-MC-Unique: OqU97U7IMFCPu48irsqf2w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBC9B10E2184;
        Fri,  9 Oct 2020 18:16:36 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-194.rdu2.redhat.com [10.10.115.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49E556EF57;
        Fri,  9 Oct 2020 18:16:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id D461B220307; Fri,  9 Oct 2020 14:16:32 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, virtio-fs@redhat.com
Subject: [PATCH v3 0/6] fuse: Implement FUSE_HANDLE_KILLPRIV_V2 and enable SB_NOSEC
Date:   Fri,  9 Oct 2020 14:15:06 -0400
Message-Id: <20201009181512.65496-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi All,

Please find attached V3 of the patches to enable SB_NOSEC for fuse. I
posted V1 and V2 here.

v2:
https://lore.kernel.org/linux-fsdevel/20200916161737.38028-1-vgoyal@redhat.com/
v1:
https://lore.kernel.org/linux-fsdevel/20200724183812.19573-1-vgoyal@redhat.com/

Changes since v2:

- Based on Miklos's feedback, dropped a patch where we send ATTR_MODE as
  that's racy. To help the case of writeback_cache with killpriv_v2, I
  fallback to a synchronous WRITE if suid/sgid is set on file.

I have generated these patches on top of.

https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/log/?h=for-nex
+t

I have taken care of feedback from last round. For the case of random
write peformance has jumped from 50MB/s to 250MB/s. So I am really
looking forward to these changes so that fuse/virtiofs performance
can be improved for direct random writes.

Thanks
Vivek


Vivek Goyal (6):
  fuse: Introduce the notion of FUSE_HANDLE_KILLPRIV_V2
  fuse: Set FUSE_WRITE_KILL_PRIV in cached write path
  fuse: setattr should set FATTR_KILL_PRIV upon size change
  fuse: Don't send ATTR_MODE to kill suid/sgid for handle_killpriv_v2
  fuse: Add a flag FUSE_OPEN_KILL_PRIV for open() request
  fuse: Support SB_NOSEC flag to improve direct write performance

 fs/fuse/dir.c             |  4 +++-
 fs/fuse/file.c            | 16 +++++++++++++++-
 fs/fuse/fuse_i.h          |  6 ++++++
 fs/fuse/inode.c           | 17 ++++++++++++++++-
 include/uapi/linux/fuse.h | 18 +++++++++++++++++-
 5 files changed, 57 insertions(+), 4 deletions(-)

-- 
2.25.4

