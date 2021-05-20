Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF6B38B388
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 17:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239066AbhETPsr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 11:48:47 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:21655 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233137AbhETPsl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 11:48:41 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-J5b6BXnVM5CEOh3kl5xPKw-1; Thu, 20 May 2021 11:47:15 -0400
X-MC-Unique: J5b6BXnVM5CEOh3kl5xPKw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B97B21854E21;
        Thu, 20 May 2021 15:47:13 +0000 (UTC)
Received: from bahia.redhat.com (ovpn-112-99.ams2.redhat.com [10.36.112.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EEE8110013C1;
        Thu, 20 May 2021 15:47:11 +0000 (UTC)
From:   Greg Kurz <groug@kaod.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        Max Reitz <mreitz@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Greg Kurz <groug@kaod.org>
Subject: [PATCH v4 4/5] virtiofs: Skip submounts in sget_fc()
Date:   Thu, 20 May 2021 17:46:53 +0200
Message-Id: <20210520154654.1791183-5-groug@kaod.org>
In-Reply-To: <20210520154654.1791183-1-groug@kaod.org>
References: <20210520154654.1791183-1-groug@kaod.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All submounts share the same virtio-fs device instance as the root
mount. If the same virtiofs filesystem is mounted again, sget_fc()
is likely to pick up any of these submounts and reuse it instead of
the root mount.

On the server side:

# mkdir ${some_dir}
# mkdir ${some_dir}/mnt1
# mount -t tmpfs none ${some_dir}/mnt1
# touch ${some_dir}/mnt1/THIS_IS_MNT1
# mkdir ${some_dir}/mnt2
# mount -t tmpfs none ${some_dir}/mnt2
# touch ${some_dir}/mnt2/THIS_IS_MNT2

On the client side:

# mkdir /mnt/virtiofs1
# mount -t virtiofs myfs /mnt/virtiofs1
# ls /mnt/virtiofs1
mnt1 mnt2
# grep virtiofs /proc/mounts
myfs /mnt/virtiofs1 virtiofs rw,seclabel,relatime 0 0
none on /mnt/mnt1 type virtiofs (rw,relatime,seclabel)
none on /mnt/mnt2 type virtiofs (rw,relatime,seclabel)

And now remount it again:

# mount -t virtiofs myfs /mnt/virtiofs2
# grep virtiofs /proc/mounts
myfs /mnt/virtiofs1 virtiofs rw,seclabel,relatime 0 0
none on /mnt/mnt1 type virtiofs (rw,relatime,seclabel)
none on /mnt/mnt2 type virtiofs (rw,relatime,seclabel)
myfs /mnt/virtiofs2 virtiofs rw,seclabel,relatime 0 0
# ls /mnt/virtiofs2
THIS_IS_MNT2

Submount mnt2 was picked-up instead of the root mount.

Just skip submounts in virtio_fs_test_super().

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fs/fuse/virtio_fs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index e12e5190352c..8962cd033016 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1408,6 +1408,11 @@ static int virtio_fs_test_super(struct super_block *sb,
 	struct fuse_mount *fsc_fm = fsc->s_fs_info;
 	struct fuse_mount *sb_fm = get_fuse_mount_super(sb);
 
+
+	/* Skip submounts */
+	if (!list_is_first(&sb_fm->fc_entry, &sb_fm->fc->mounts))
+		return 0;
+
 	return fsc_fm->fc->iq.priv == sb_fm->fc->iq.priv;
 }
 
-- 
2.26.3

