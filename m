Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49EE02890A3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 20:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388180AbgJISQm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 14:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54494 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725979AbgJISQl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 14:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602267399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NBIFLEAJp62H7A0pgHn2uS/XaJf3Q3ojEbIgpZnScAI=;
        b=DmMLzeywRbnVajqjBa7T06GeCmCUknD7WghnvNOQ/qQnXTMD4GCb37Be49nKuIvcfm9J1B
        0n5wYEBuTA/TQdIe23gj+37EIc2NjPeEW15CiN3Loxx2/DsQRRZcIvAlVENPBemcuQlL8o
        4ugUbmcuntg0XcSsGfEywmL2D8WJohs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-UC7et51XMTm7AzkZLibCZA-1; Fri, 09 Oct 2020 14:16:38 -0400
X-MC-Unique: UC7et51XMTm7AzkZLibCZA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F32A118829DA;
        Fri,  9 Oct 2020 18:16:36 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-194.rdu2.redhat.com [10.10.115.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61C4D5D9F3;
        Fri,  9 Oct 2020 18:16:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E24E3223D09; Fri,  9 Oct 2020 14:16:32 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, virtio-fs@redhat.com
Subject: [PATCH v3 4/6] fuse: Don't send ATTR_MODE to kill suid/sgid for handle_killpriv_v2
Date:   Fri,  9 Oct 2020 14:15:10 -0400
Message-Id: <20201009181512.65496-5-vgoyal@redhat.com>
In-Reply-To: <20201009181512.65496-1-vgoyal@redhat.com>
References: <20201009181512.65496-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If client does a write() on a suid/sgid file, VFS will first call
fuse_setattr() with ATTR_KILL_S[UG]ID set. This requires sending
setattr to file server with ATTR_MODE set to kill suid/sgid. But
to do that client needs to know latest mode otherwise it is racy.

To reduce the race window, current code first call fuse_do_getattr()
to get latest ->i_mode and then resets suid/sgid bits and sends rest
to server with setattr(ATTR_MODE). This does not reduce the race
completely but narrows race window significantly.

With fc->handle_killpriv_v2 enabled, it should be possible to remove
this race completely. Do not kill suid/sgid with ATTR_MODE at all. It
will be killed by server when WRITE request is sent to server soon.
This is similar to fc->handle_killpriv logic. V2 is just more refined
version of protocol. Hence this patch does not send ATTR_MODE to
kill suid/sgid if fc->handle_killpriv_v2 is enabled.

This creates an issue if fc->writeback_cache is enabled. In that
case WRITE can be cached in guest and server might not see WRITE
request and hence will not kill suid/sgid. Miklos suggested that
in such cases, we should fallback to a writethrough WRITE instead
and that will generate WRITE request and kill suid/sgid. This patch
implements that too.

But this relies on client seeing the suid/sgid set. If another client
sets suid/sgid and this client does not see it immideately, then we
will not fallback to writethrough WRITE. So this is one limitation
with both fc->handle_killpriv_v2 and fc->writeback_cache enabled.
Both the options are not fully compatible. But might be good enough
for many use cases.

Note: I am not checking whether security.capability is set or not when
      falling back to writethrough path. if suid/sgid is not set and only
      security.capability is set, that will be taken care of by
      file_remove_privs() call in ->writeback_cache path.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/dir.c  | 2 +-
 fs/fuse/file.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ecdb7895c156..510178594a8d 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1664,7 +1664,7 @@ static int fuse_setattr(struct dentry *entry, struct iattr *attr)
 		 *
 		 * This should be done on write(), truncate() and chown().
 		 */
-		if (!fc->handle_killpriv) {
+		if (!fc->handle_killpriv && !fc->handle_killpriv_v2) {
 			/*
 			 * ia_mode calculation may have used stale i_mode.
 			 * Refresh and recalculate.
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e40428f3d0f1..ee1bb9bfdcd5 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1260,17 +1260,24 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t written_buffered = 0;
 	struct inode *inode = mapping->host;
 	ssize_t err;
+	struct fuse_conn *fc = get_fuse_conn(inode);
 	loff_t endbyte = 0;
 
-	if (get_fuse_conn(inode)->writeback_cache) {
+	if (fc->writeback_cache) {
 		/* Update size (EOF optimization) and mode (SUID clearing) */
 		err = fuse_update_attributes(mapping->host, file);
 		if (err)
 			return err;
 
+		if (fc->handle_killpriv_v2 &&
+		    should_remove_suid(file_dentry(file))) {
+			goto writethrough;
+		}
+
 		return generic_file_write_iter(iocb, from);
 	}
 
+writethrough:
 	inode_lock(inode);
 
 	/* We can write back this queue in page reclaim */
-- 
2.25.4

