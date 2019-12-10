Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DED0911887A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 13:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfLJMdf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 07:33:35 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53608 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727504AbfLJMbX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:31:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575981082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XxEX7wEHWkbRhZaxvYab+tKzaTycjPdOhUXQjnzVqf0=;
        b=f2XuKygNQwwFLcOPMaxnRQZc4QQeZ3zP1e6Ii2XpNxcPGnycZ+P9yIueNNQAF44PlU8KIm
        u2VvP8v0HkyEgTsDAlKERkGokbiqHaGIPF8qekktKB6JrqfBZbNMuZ9IWrkdPsNKgu1xcs
        AsGnT6V6YE06LwEIZ8nnGN2ZF3JdOsY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-GYGKWjL3OfuxJDfm07ET6A-1; Tue, 10 Dec 2019 07:31:18 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E974800D5B;
        Tue, 10 Dec 2019 12:31:17 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF43E60BE1;
        Tue, 10 Dec 2019 12:31:16 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id A567320BC4; Tue, 10 Dec 2019 07:31:15 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v6 05/27] nfs: don't bother setting/restoring export_path around do_nfs_root_mount()
Date:   Tue, 10 Dec 2019 07:30:53 -0500
Message-Id: <20191210123115.1655-6-smayhew@redhat.com>
In-Reply-To: <20191210123115.1655-1-smayhew@redhat.com>
References: <20191210123115.1655-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: GYGKWjL3OfuxJDfm07ET6A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

nothing in it will be looking at that thing anyway

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/nfs4super.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 54dbb4561ccc..8146edf4ce3a 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -233,12 +233,10 @@ struct dentry *nfs4_try_mount(int flags, const char *=
dev_name,
 =09dfprintk(MOUNT, "--> nfs4_try_mount()\n");
=20
 =09export_path =3D data->nfs_server.export_path;
-=09data->nfs_server.export_path =3D "/";
 =09root_mnt =3D nfs_do_root_mount(
 =09=09=09nfs4_create_server(mount_info, &nfs_v4),
 =09=09=09flags, mount_info,
 =09=09=09data->nfs_server.hostname);
-=09data->nfs_server.export_path =3D export_path;
=20
 =09res =3D nfs_follow_remote_path(root_mnt, export_path);
=20
@@ -271,12 +269,10 @@ static struct dentry *nfs4_referral_mount(struct file=
_system_type *fs_type,
 =09=09return ERR_PTR(-ENOMEM);
=20
 =09export_path =3D data->mnt_path;
-=09data->mnt_path =3D "/";
 =09root_mnt =3D nfs_do_root_mount(
 =09=09=09nfs4_create_referral_server(mount_info.cloned,
 =09=09=09=09=09=09    mount_info.mntfh),
 =09=09=09flags, &mount_info, data->hostname);
-=09data->mnt_path =3D export_path;
=20
 =09res =3D nfs_follow_remote_path(root_mnt, export_path);
 =09dprintk("<-- nfs4_referral_mount() =3D %d%s\n",
--=20
2.17.2

