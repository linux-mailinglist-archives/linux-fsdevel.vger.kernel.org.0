Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B06E42AB96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 20:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbhJLSIr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 14:08:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21719 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232694AbhJLSIq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634062004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SioDeXv3YTV9XygoNXTKPjcQrRE5f0WV9e+ioPpVxR4=;
        b=BUz4K5E6lEy/V5kXBC1a2aLuncsdYf3stVgMXojTzs6A2s+fquyrH+l4BO/y4WDqwdJ1rT
        udb4iG1kPcyoXPciXKXBczDcHda0hm9U9eio0R/CgBE222ro9lpN41B4+XE4m5990d8gl1
        JwYxclTfhHAQiAiVNfZjvDDNGOkKoLM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-0HnMwaDyMb-HJAPLF71fVw-1; Tue, 12 Oct 2021 14:06:41 -0400
X-MC-Unique: 0HnMwaDyMb-HJAPLF71fVw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C2741927801;
        Tue, 12 Oct 2021 18:06:39 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.9.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95F0C2B060;
        Tue, 12 Oct 2021 18:06:36 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 22B2622023A; Tue, 12 Oct 2021 14:06:36 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, miklos@szeredi.hu
Cc:     virtio-fs@redhat.com, chirantan@chromium.org, vgoyal@redhat.com,
        stephen.smalley.work@gmail.com, dwalsh@redhat.com,
        casey@schaufler-ca.com, omosnace@redhat.com
Subject: [PATCH v2 0/2] fuse: Send file/inode security context during creation
Date:   Tue, 12 Oct 2021 14:06:22 -0400
Message-Id: <20211012180624.447474-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This is V2 of patches. Posted V1 here.

https://lore.kernel.org/linux-fsdevel/20210924192442.916927-1-vgoyal@redhat.com/

Changes since v1:

- Added capability to send multiple security contexts in fuse protocol.
  Miklos suggestd this. So now protocol can easily carry multiple
  security labels. Just that right now we only send one. When a security
  hook becomes available which can handle multiple security labels,
  it should be easy to send those.

This patch series is dependent on following patch I have posted to
change signature of security_dentry_init_security().

https://lore.kernel.org/linux-fsdevel/YWWMO%2FZDrvDZ5X4c@redhat.com/

Description
-----------
When a file is created (create, mknod, mkdir, symlink), typically file
systems call  security_inode_init_security() to initialize security
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
and made modifications on top.

https://listman.redhat.com/archives/virtio-fs/2020-July/msg00014.html
https://listman.redhat.com/archives/virtio-fs/2020-July/msg00015.html

These patches will allow us to support SELinux on virtiofs.

Vivek Goyal (2):
  fuse: Add a flag FUSE_SECURITY_CTX
  fuse: Send security context of inode on file creation

 fs/fuse/dir.c             | 115 ++++++++++++++++++++++++++++++++++++--
 fs/fuse/fuse_i.h          |   3 +
 fs/fuse/inode.c           |   4 +-
 include/uapi/linux/fuse.h |  29 +++++++++-
 4 files changed, 144 insertions(+), 7 deletions(-)

-- 
2.31.1

