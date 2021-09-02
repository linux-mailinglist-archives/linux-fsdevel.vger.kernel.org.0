Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C4F3FF011
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 17:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345787AbhIBPXr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 11:23:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27523 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345772AbhIBPXp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 11:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630596166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QzUOsHXMIDWOAqPBo9u7M1z5IuvL3zXT1jeF9JdpLYg=;
        b=Xqeuad+L/cjN0iSQtzqm9WmBnsFksd6Ek+CX7/GSsyO7B1S4c5pk/AsPHENKctA1LlZgmw
        Ls4GM1mRW6T5G/+4Bc4oSx6MEOwEdSOnhe6V8zkC1imVtl9qOpc7SrtJ0JIgRIbpqOi5ab
        rXn/39n1fvllrKaJSV1rzBmD/rdpRgU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-dbbv2vMKPXyQX_ZS3tISzA-1; Thu, 02 Sep 2021 11:22:45 -0400
X-MC-Unique: dbbv2vMKPXyQX_ZS3tISzA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61A48194092E;
        Thu,  2 Sep 2021 15:22:43 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.8.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4485E5D6B1;
        Thu,  2 Sep 2021 15:22:39 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id C6199220257; Thu,  2 Sep 2021 11:22:38 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, dwalsh@redhat.com, dgilbert@redhat.com,
        vgoyal@redhat.com, christian.brauner@ubuntu.com,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, tytso@mit.edu, miklos@szeredi.hu,
        gscrivan@redhat.com, bfields@redhat.com,
        stephen.smalley.work@gmail.com, agruenba@redhat.com,
        david@fromorbit.com
Subject: [PATCH v3 0/1] Relax restrictions on user.* xattr
Date:   Thu,  2 Sep 2021 11:22:27 -0400
Message-Id: <20210902152228.665959-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This is V3 of the patch. Previous versions were posted here.

v2:
https://lore.kernel.org/linux-fsdevel/20210708175738.360757-1-vgoyal@redhat.com/
v1:
https://lore.kernel.org/linux-fsdevel/20210625191229.1752531-1-vgoyal@redhat.co
+m/

Changes since v2
----------------
- Do not call inode_permission() for special files as file mode bits
  on these files represent permissions to read/write from/to device
  and not necessarily permission to read/write xattrs. In this case
  now user.* extended xattrs can be read/written on special files
  as long as caller is owner of file or has CAP_FOWNER.
 
- Fixed "man xattr". Will post a patch in same thread little later. (J.
  Bruce Fields)

- Fixed xfstest 062. Changed it to run only on older kernels where
  user extended xattrs are not allowed on symlinks/special files. Added
  a new replacement test 648 which does exactly what 062. Just that
  it is supposed to run on newer kernels where user extended xattrs
  are allowed on symlinks and special files. Will post patch in 
  same thread (Ted Ts'o).

Testing
-------
- Ran xfstest "./check -g auto" with and without patches and did not
  notice any new failures.

- Tested setting "user.*" xattr with ext4/xfs/btrfs/overlay/nfs
  filesystems and it works.
 
Description
===========

Right now we don't allow setting user.* xattrs on symlinks and special
files at all. Initially I thought that real reason behind this
restriction is quota limitations but from last conversation it seemed
that real reason is that permission bits on symlink and special files
are special and different from regular files and directories, hence
this restriction is in place. (I tested with xfs user quota enabled and
quota restrictions kicked in on symlink).

This version of patch allows reading/writing user.* xattr on symlink and
special files if caller is owner or priviliged (has CAP_FOWNER) w.r.t inode.

Who wants to set user.* xattr on symlink/special files
-----------------------------------------------------
I have primarily two users at this point of time.

- virtiofs daemon.

- fuse-overlay. Giuseppe, seems to set user.* xattr attrs on unpriviliged
  fuse-overlay as well and he ran into similar issue. So fuse-overlay
  should benefit from this change as well.

Why virtiofsd wants to set user.* xattr on symlink/special files
----------------------------------------------------------------
In virtiofs, actual file server is virtiosd daemon running on host.
There we have a mode where xattrs can be remapped to something else.
For example security.selinux can be remapped to
user.virtiofsd.securit.selinux on the host.

This remapping is useful when SELinux is enabled in guest and virtiofs
as being used as rootfs. Guest and host SELinux policy might not match
and host policy might deny security.selinux xattr setting by guest
onto host. Or host might have SELinux disabled and in that case to
be able to set security.selinux xattr, virtiofsd will need to have
CAP_SYS_ADMIN (which we are trying to avoid). Being able to remap
guest security.selinux (or other xattrs) on host to something else
is also better from security point of view.

But when we try this, we noticed that SELinux relabeling in guest
is failing on some symlinks. When I debugged a little more, I
came to know that "user.*" xattrs are not allowed on symlinks
or special files.

So if we allow owner (or CAP_FOWNER) to set user.* xattr, it will
allow virtiofs to arbitrarily remap guests's xattrs to something
else on host and that solves this SELinux issue nicely and provides
two SELinux policies (host and guest) to co-exist nicely without
interfering with each other.

Thanks
Vivek

Vivek Goyal (1):
  xattr: Allow user.* xattr on symlink and special files

 fs/xattr.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

-- 
2.31.1

