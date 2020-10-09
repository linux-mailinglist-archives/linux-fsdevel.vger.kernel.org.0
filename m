Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93892890A5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 20:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388802AbgJISQs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 14:16:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51591 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388128AbgJISQq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 14:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602267404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LcoJJWm6cQJGZeJL7rVr9Mya2yS3vWJSHHyzVQL03Hs=;
        b=hJrI1ZaN0/Y4k6f9mz9/gBjeV/htxs3Obf2bLNS/ADpsZ8nVXVUuAfBmuuKjjSu3ARwayB
        Xhnm5Qwftim0LWZeXYNaiLHrQuH+yipkcq6/lI6l5fm9zSFxroIznAKpkDwnvhTbQzQ4Pu
        uFThVOWnvf7OePYvHO//LCatLFwD3y8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-xe-OyDIWPFKgrSZfvnUGkQ-1; Fri, 09 Oct 2020 14:16:41 -0400
X-MC-Unique: xe-OyDIWPFKgrSZfvnUGkQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B1A410E2180;
        Fri,  9 Oct 2020 18:16:40 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-194.rdu2.redhat.com [10.10.115.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FD5319D7C;
        Fri,  9 Oct 2020 18:16:37 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E94CE223D0B; Fri,  9 Oct 2020 14:16:32 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, virtio-fs@redhat.com
Subject: [PATCH v3 6/6] fuse: Support SB_NOSEC flag to improve direct write performance
Date:   Fri,  9 Oct 2020 14:15:12 -0400
Message-Id: <20201009181512.65496-7-vgoyal@redhat.com>
In-Reply-To: <20201009181512.65496-1-vgoyal@redhat.com>
References: <20201009181512.65496-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

virtiofs can be slow with small writes if xattr are enabled and we are
doing cached writes (No direct I/). Ganesh Mahalingam noticed this here.

https://github.com/kata-containers/runtime/issues/2815

Some debugging showed that that file_remove_privs() is called in cached
write path on every write. And everytime it calls
security_inode_need_killpriv() which results in call to
__vfs_getxattr(XATTR_NAME_CAPS). And this goes to file server to fetch
xattr. This extra round trip for every write slows down writes tremendously.

Normally to avoid paying this penalty on every write, vfs has the
notion of caching this information in inode (S_NOSEC). So vfs
sets S_NOSEC, if filesystem opted for it using super block flag
SB_NOSEC. And S_NOSEC is cleared when setuid/setgid bit is set or
when security xattr is set on inode so that next time a write
happens, we check inode again for clearing setuid/setgid bits as well
clear any security.capability xattr.

This seems to work well for local file systems but for remote file
systems it is possible that VFS does not have full picture and a
different client sets setuid/setgid bit or security.capability xattr
on file and that means VFS information about S_NOSEC on another client
will be stale. So for remote filesystems SB_NOSEC was disabled by
default.

commit 9e1f1de02c2275d7172e18dc4e7c2065777611bf
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Fri Jun 3 18:24:58 2011 -0400

    more conservative S_NOSEC handling

That commit mentioned that these filesystems can still make use of
SB_NOSEC as long as they clear S_NOSEC when they are refreshing inode
attriutes from server.

So this patch tries to enable SB_NOSEC on fuse (regular fuse as well
as virtiofs). And clear SB_NOSEC when we are refreshing inode attributes.

This is enabled only if server supports FUSE_HANDLE_KILLPRIV_V2. This
says that server will clear setuid/setgid/security.capability on
chown/truncate/write as apporpriate.

This should provide tighter coherency because now suid/sgid/security.capability
will be cleared even if fuse client cache has not seen these attrs.

Basic idea is that fuse client will trigger suid/sgid/security.capability
clearing based on its attr cache. But even if cache has gone stale,
it is fine because FUSE_HANDLE_KILLPRIV_V2 will make sure WRITE
clear suid/sgid/security.capability.

We make this change only if server supports FUSE_HANDLE_KILLPRIV_V2.
This should make sure that existing filesystems which might be
relying on seucurity.capability always being queried from server
are not impacted.

This tighter coherency relies on WRITE showing up on server (and not
being cached in guest). So writeback_cache mode will not provide that
tight coherency and it is not recommended to use two together. Having
said that it might work reasonably well for lot of use cases.

This change improves random write performance very significantly. I
am running virtiofsd with cache=auto and following fio command.

fio --ioengine=libaio --direct=1  --name=test --filename=/mnt/virtiofs/random_read_write.fio --bs=4k --iodepth=64 --size=4G --readwrite=randwrite

Before this patch I get around 50MB/s and after the patch I get around
250MB/s bandwidth. So improvement is very significant.

Reported-by: "Mahalingam, Ganesh" <ganesh.mahalingam@intel.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/inode.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 20740b61f12b..4b7a043f21ee 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -201,6 +201,16 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 		inode->i_mode &= ~S_ISVTX;
 
 	fi->orig_ino = attr->ino;
+
+	/*
+	 * We are refreshing inode data and it is possible that another
+	 * client set suid/sgid or security.capability xattr. So clear
+	 * S_NOSEC. Ideally, we could have cleared it only if suid/sgid
+	 * was set or if security.capability xattr was set. But we don't
+	 * know if security.capability has been set or not. So clear it
+	 * anyway. Its less efficient but should is safe.
+	 */
+	inode->i_flags &= ~S_NOSEC;
 }
 
 void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
@@ -993,8 +1003,10 @@ static void process_init_reply(struct fuse_conn *fc, struct fuse_args *args,
 			    !fuse_dax_check_alignment(fc, arg->map_alignment)) {
 				ok = false;
 			}
-			if (arg->flags & FUSE_HANDLE_KILLPRIV_V2)
+			if (arg->flags & FUSE_HANDLE_KILLPRIV_V2) {
 				fc->handle_killpriv_v2 = 1;
+				fc->sb->s_flags |= SB_NOSEC;
+			}
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
-- 
2.25.4

