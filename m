Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12A625A022
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 22:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgIAUle (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 16:41:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56492 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726091AbgIAUle (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 16:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598992893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TbD6iyPHh1QOxOewfASpUhAaecUK7MkCtFkbWC3ePDU=;
        b=LxajRk1AUZBlKIDz8gfnkFAJuOH76tOkapLBo8T4pFCmMQqQ2iq8zKv1k5AHPXo1b4FJXq
        qYoOx729VpPwDTnS8qG0xHhS2IYrr3pkeSotIpSncrOArXOsIGabNWKNdBaMfl6EChSJev
        tWZxFAgey4cA8ib2DP1up+45viDDfD0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-G6clpIqMM1Gr6jwbsBQ91A-1; Tue, 01 Sep 2020 16:41:04 -0400
X-MC-Unique: G6clpIqMM1Gr6jwbsBQ91A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89A00802B66;
        Tue,  1 Sep 2020 20:41:02 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-208.rdu2.redhat.com [10.10.116.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5E475C1C4;
        Tue,  1 Sep 2020 20:40:55 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 46F862255D9; Tue,  1 Sep 2020 16:40:55 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        miklos@szeredi.hu
Cc:     vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com
Subject: [PATCH 2/2] fuse: Enable SB_NOSEC if filesystem is not shared
Date:   Tue,  1 Sep 2020 16:40:45 -0400
Message-Id: <20200901204045.1250822-3-vgoyal@redhat.com>
In-Reply-To: <20200901204045.1250822-1-vgoyal@redhat.com>
References: <20200901204045.1250822-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We don't enable SB_NOSEC on fuse filesystems thinking filesystem is
shared and files attrs setuid/setgid/capabilities can change without
fuse knowing about it. This means on every WRITE, file_remove_privs(),
is called and that calls into fuse server to figure out if security.capability
xattr has been set on file. Most of the time this is a performance hog,
specially for small writes done at high frequency.

Enable SB_NOSEC if fuse filesystem sets flag FS_NONSHARED_FS. This means,
do not expect file attrs/xattrs to change without the knowledge of
fuse. In this case it should be possible to enable SB_NOSEC.

For the case of shared filesystems, we will have to come up with a different
mechanism to enable SB_NOSEC. I guess it will depend on invalidation
mechanisms implemented by filesystem and cache coherency guarantees.

I do clear inode S_NOSEC flag whenever file attrs are being refreshed. So
this still honors attr timeout protocol.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 088faa3e352c..2da13fe25417 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -187,6 +187,9 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 		inode->i_mode &= ~S_ISVTX;
 
 	fi->orig_ino = attr->ino;
+
+	/* Clear S_NOSEC whenever cached attrs are being refreshed */
+	inode->i_flags &= ~S_NOSEC;
 }
 
 void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
@@ -967,6 +970,9 @@ static void process_init_reply(struct fuse_conn *fc, struct fuse_args *args,
 			}
 			if (arg->flags & FUSE_NONSHARED_FS) {
 				fc->nonshared_fs = 1;
+				down_write(&fc->sb->s_umount);
+				fc->sb->s_flags |= SB_NOSEC;
+				up_write(&fc->sb->s_umount);
 			}
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
-- 
2.25.4

