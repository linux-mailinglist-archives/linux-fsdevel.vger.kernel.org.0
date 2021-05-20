Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9634238B383
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 17:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238025AbhETPsf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 11:48:35 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:30627 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236883AbhETPse (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 11:48:34 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-1lUyBVChNhe7Z27CTXJhgg-1; Thu, 20 May 2021 11:47:09 -0400
X-MC-Unique: 1lUyBVChNhe7Z27CTXJhgg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E956107ACCA;
        Thu, 20 May 2021 15:47:07 +0000 (UTC)
Received: from bahia.redhat.com (ovpn-112-99.ams2.redhat.com [10.36.112.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FAE610016F4;
        Thu, 20 May 2021 15:47:04 +0000 (UTC)
From:   Greg Kurz <groug@kaod.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        Max Reitz <mreitz@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Greg Kurz <groug@kaod.org>
Subject: [PATCH v4 1/5] fuse: Fix leak in fuse_dentry_automount() error path
Date:   Thu, 20 May 2021 17:46:50 +0200
Message-Id: <20210520154654.1791183-2-groug@kaod.org>
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

Some rollback was forgotten during the addition of crossmounts.

Fixes: bf109c64040f ("fuse: implement crossmounts")
Cc: mreitz@redhat.com
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fs/fuse/dir.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 1b6c001a7dd1..fb2af70596c3 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -339,8 +339,11 @@ static struct vfsmount *fuse_dentry_automount(struct path *path)
 
 	/* Initialize superblock, making @mp_fi its root */
 	err = fuse_fill_super_submount(sb, mp_fi);
-	if (err)
+	if (err) {
+		fuse_conn_put(fc);
+		kfree(fm);
 		goto out_put_sb;
+	}
 
 	sb->s_flags |= SB_ACTIVE;
 	fsc->root = dget(sb->s_root);
-- 
2.26.3

