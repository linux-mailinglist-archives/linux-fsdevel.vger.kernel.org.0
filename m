Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC5D417BC1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 21:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346675AbhIXT0k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 15:26:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53618 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346497AbhIXT0j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 15:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632511505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/PIrdaQ3mTr2jUUovAmAPxxxH+2EzMe5cu2pNMdSelk=;
        b=OSI0uesTup/p0AYzcbB24tSFugApAJPkiPC91ndMY6Jz2TqP2+4foXtgkqmtESO59gftd6
        bD33V9QL6OCejSq+fAGHtJA2h4woixwHY5EF+JH7RdqNlrTwU6254zdGbzPiyrduhgUhpn
        eOgoGXgbPPEPFXhX6s39YMGPaC8ZRg4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-gOD2J--zOuGk25l4esDDIA-1; Fri, 24 Sep 2021 15:25:02 -0400
X-MC-Unique: gOD2J--zOuGk25l4esDDIA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAEE78145E6;
        Fri, 24 Sep 2021 19:25:00 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.32.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E4845C1A3;
        Fri, 24 Sep 2021 19:24:57 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 5D275222E4F; Fri, 24 Sep 2021 15:24:56 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     chirantan@chromium.org, vgoyal@redhat.com, miklos@szeredi.hu,
        stephen.smalley.work@gmail.com, dwalsh@redhat.com
Subject: [PATCH 0/2] fuse: Send file/inode security context during creation
Date:   Fri, 24 Sep 2021 15:24:40 -0400
Message-Id: <20210924192442.916927-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

When a file is created (create, mknod, mkdir, symlink), typically file
systems call  ecurity_inode_init_security() to initialize security
context of an inode. But this does not very well with remote filesystems
as inode is not there yet. Client will send a creation request to
server and once server has created the file, client will instantiate
the inode.

So filesystems like nfs and ceph use security_dentry_init_security()
instead. This takes in a dentry and returns the security context of
file if any. 

These patches call security_dentry_init_security() and send security
label of file along with creation request (FUSE_CREATE, FUSE_MKDIR,
FUSE_MKNOD, FUSE_SYMLINK). This will give server an opportunity
to create new file and also set security label (possibly atomically
where possible).

These patches are based on the work Chirantan Ekbote did some time
back but it never got upstreamed. So I have taken his patches,
made some modifications and posting again.

https://listman.redhat.com/archives/virtio-fs/2020-July/msg00014.html
https://listman.redhat.com/archives/virtio-fs/2020-July/msg00015.html

These patches will allow us to support SELinux on virtiofs.

Vivek Goyal (2):
  fuse: Add a flag FUSE_SECURITY_CTX
  fuse: Send security context of inode on file creation

 fs/fuse/dir.c             | 114 ++++++++++++++++++++++++++++++++++++--
 fs/fuse/fuse_i.h          |   3 +
 fs/fuse/inode.c           |   4 +-
 include/uapi/linux/fuse.h |  20 ++++++-
 4 files changed, 134 insertions(+), 7 deletions(-)

-- 
2.31.1

