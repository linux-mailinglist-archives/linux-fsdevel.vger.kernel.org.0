Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3043533D883
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 17:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238331AbhCPQCj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 12:02:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56224 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238323AbhCPQCL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615910530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Acqq+545iKTpdChRZQ9YUyH78hdHIys777mSiKSqw4c=;
        b=M1HpN9CX34V1BqLcXOnGbDbGk1I1zclw4Y7hrvzdpRfAhL/L64tmsMIZ2O139Wwlz9No0h
        dDziSsLBi3hjrCuPmAon6DopiUIQ1xMLwdcaN0q38ZSsxbOeOfTiYp93AbkR/k16AWRpBy
        zokUwnq4SdQtyvUp9kXTypM9/aPtSew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-DUxpSaLwOpCFpYwFhiulxQ-1; Tue, 16 Mar 2021 12:02:07 -0400
X-MC-Unique: DUxpSaLwOpCFpYwFhiulxQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDBA6800C78;
        Tue, 16 Mar 2021 16:02:05 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-57.rdu2.redhat.com [10.10.114.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD3C060875;
        Tue, 16 Mar 2021 16:02:01 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 64914220BCF; Tue, 16 Mar 2021 12:02:01 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        miklos@szeredi.hu
Cc:     lhenriques@suse.de, dgilbert@redhat.com,
        seth.forshee@canonical.com, Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 0/1] fuse: acl: Send file mode updates using SETATTR
Date:   Tue, 16 Mar 2021 12:01:46 -0400
Message-Id: <20210316160147.289193-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Miklos,

Please find attached a patch to fix the SGID clearing issue upon 
ACL change. 

Luis reported that currently fstests generic/375 fails on virtiofs. And
reason being that we don't clear SGID when it should be.

Setting ACL can lead to file mode change. And this in-turn also can
lead to clearing SGID bit if.

- None of caller's groups match file owner group.
AND
- Caller does not have CAP_FSETID.

Current implementation relies on server updating the mode. But file
server does not have enough information to do so. 

Initially I thought of sending CAP_FSETID information to server but
then I realized, it is just one of the pieces. What about all the
groups caller is a member of. If this has to work correctly, then
all the information will have to be sent to virtiofsd somehow. Just
sending CAP_FSETID information required adding V2 of fuse_setxattr_in
because we don't have any space for sending extra information.

https://github.com/rhvgoyal/linux/commit/681cf5bdbba9c965c3dbd4337c16e9b17f27debe

Also this approach will not work with idmapped mounts because server
does not have information about idmapped mappings.

So I started to look at the approach of sending file mode updates
using SETATTR. As filesystems like 9pfs and ceph are doing. This
seems simpler approach. Though it has its issues too.

- File mode update and setxattr(system.posix_acl_access) are not atomic.

None of the approaches seem very clean to me. But sending SETATTR
explicitly seems to be lesser of two evils to me at this point of time.
Hence I am proposing this patch. 

I have run fstests acl tests and they pass. (./check -g acl).

Corresponding virtiofsd patches are here.

https://github.com/rhvgoyal/qemu/commits/acl-sgid-setattr

What do you think.

Vivek Goyal (1):
  fuse: Add a mode where fuse client sends mode changes on ACL change

 fs/fuse/acl.c             | 54 ++++++++++++++++++++++++++++++++++++---
 fs/fuse/dir.c             | 11 ++++----
 fs/fuse/fuse_i.h          |  9 ++++++-
 fs/fuse/inode.c           |  4 ++-
 include/uapi/linux/fuse.h |  5 ++++
 5 files changed, 71 insertions(+), 12 deletions(-)

-- 
2.25.4

