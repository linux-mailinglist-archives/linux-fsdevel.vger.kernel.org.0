Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4E9349535
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 16:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhCYPTP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 11:19:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40708 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231411AbhCYPTG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 11:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616685544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7MNlH2ghOdmhiqcKF78/OwHndghS622I9hXiGUvAD1k=;
        b=EqBSLd/IiUzd1WJYUt11ZOnLTWnGqOxbdTeJ6OPCpbtPx/L61x+wtWTk6xupu/k5Ya9qH7
        Xgs0xeCXwQR6tT/hG/Md3Ob19LnP+M01OD3uqmxHS7/g9qmFR8oS8dZpsMQ7UsdN8S8hMA
        4Reh6ke8qrhs0ppJUqkt35H/gLrVG9E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-oXtED4M9OZq8MV8t9xxUjw-1; Thu, 25 Mar 2021 11:18:59 -0400
X-MC-Unique: oXtED4M9OZq8MV8t9xxUjw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2392096E551;
        Thu, 25 Mar 2021 15:18:58 +0000 (UTC)
Received: from horse.redhat.com (ovpn-118-78.rdu2.redhat.com [10.10.118.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4CC976E35;
        Thu, 25 Mar 2021 15:18:45 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 6DBBC220BCF; Thu, 25 Mar 2021 11:18:45 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, lhenriques@suse.de, dgilbert@redhat.com,
        seth.forshee@canonical.com
Subject: [PATCH v2 0/2] fuse: Fix clearing SGID when access ACL is set
Date:   Thu, 25 Mar 2021 11:18:21 -0400
Message-Id: <20210325151823.572089-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi,

This is V2 of the patchset. Posted V1 here.

https://lore.kernel.org/linux-fsdevel/20210319195547.427371-1-vgoyal@redhat.com/

Changes since V1:

- Dropped the helper to determine if SGID should be cleared and open
  coded it instead. I will follow up on helper separately in a different
  patch series. There are few places already which open code this, so
  for now fuse can do the same. Atleast I can make progress on this
  and virtiofs can enable ACL support.

Luis reported that xfstests generic/375 fails with virtiofs. Little
debugging showed that when posix access acl is set that in some
cases SGID needs to be cleared and that does not happen with virtiofs.

Setting posix access acl can lead to mode change and it can also lead
to clear of SGID. fuse relies on file server taking care of all
the mode changes. But file server does not have enough information to
determine whether SGID should be cleared or not.

Hence this patch series add support to send a flag in SETXATTR message
to tell server to clear SGID.

I have staged corresponding virtiofsd patches here.

https://github.com/rhvgoyal/qemu/commits/acl-sgid-setxattr-flag

With these patches applied "./check -g acl" passes now on virtiofs.

Thanks
Vivek

Vivek Goyal (2):
  fuse: Add support for FUSE_SETXATTR_V2
  fuse: Add a flag FUSE_SETXATTR_ACL_KILL_SGID to kill SGID

 fs/fuse/acl.c             |  8 +++++++-
 fs/fuse/fuse_i.h          |  5 ++++-
 fs/fuse/inode.c           |  4 +++-
 fs/fuse/xattr.c           | 21 +++++++++++++++------
 include/uapi/linux/fuse.h | 17 +++++++++++++++++
 5 files changed, 46 insertions(+), 9 deletions(-)

-- 
2.25.4

