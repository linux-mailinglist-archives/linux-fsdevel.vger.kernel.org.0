Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8392C3C18C8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jul 2021 20:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhGHSDH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jul 2021 14:03:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29435 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229842AbhGHSDD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jul 2021 14:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625767221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=18KcAbQHHQOnGgyLTPniNq5bLdf4iPeZS1lA1UFZF18=;
        b=Nma7ybUC7uMUDoynrurZxQD3nxZkLOS5C/MXdvX51owxKjkFtET9w5VNk9tdIe82kGGsF8
        hO2MJS8H8Ru/JjOn819u1AhmlVIZu5N9EwQlnKVkXk0Xa4i361rG3P8FMdcNhgge7OyO+G
        A39ddpqNBh52uanPmrJOizTX4IxkcWA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-fuS_scvrM2uTDXA43gZdNg-1; Thu, 08 Jul 2021 14:00:17 -0400
X-MC-Unique: fuS_scvrM2uTDXA43gZdNg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3690F1B18BC0;
        Thu,  8 Jul 2021 18:00:16 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-175.rdu2.redhat.com [10.10.114.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5AAB91383B;
        Thu,  8 Jul 2021 18:00:10 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9AE5E22054F; Thu,  8 Jul 2021 14:00:09 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Cc:     virtio-fs@redhat.com, dwalsh@redhat.com, dgilbert@redhat.com,
        vgoyal@redhat.com, christian.brauner@ubuntu.com,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, tytso@mit.edu, miklos@szeredi.hu,
        gscrivan@redhat.com, jack@suse.cz
Subject: [RFC PATCH v2 0/1] Relax restrictions on user.* xattr
Date:   Thu,  8 Jul 2021 13:57:37 -0400
Message-Id: <20210708175738.360757-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This is V2 of the patch. Posted V1 here.

https://lore.kernel.org/linux-fsdevel/20210625191229.1752531-1-vgoyal@redhat.com/

Right now we don't allow setting user.* xattrs on symlinks and special
files at all. Initially I thought that real reason behind this
restriction is quota limitations but from last conversation it seemed
that real reason is that permission bits on symlink and special files
are special and different from regular files and directories, hence
this restriction is in place.

Given it probably is not a quota issue (I tested with xfs user quota
enabled and quota restrictions kicked in on symlink), I dropped the
idea of allowing user.* xattr if process has CAP_SYS_RESOURCE.

Instead this version of patch allows reading/writing user.* xattr
on symlink and special files if caller is owner or priviliged (has
CAP_FOWNER) w.r.t inode.

We need this for virtiofs daemon. I also found one more user. Giuseppe,
seems to set user.* xattr attrs on unpriviliged fuse-overlay as well
and he ran into similar issue. So fuse-overlay should benefit from
this change as well.

Who wants to set user.* xattr on symlink/special files
-----------------------------------------------------

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

 fs/xattr.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.25.4

