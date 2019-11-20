Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 118F5103E4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 16:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbfKTP2A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 10:28:00 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34131 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730233AbfKTP16 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:27:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574263677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VfTwEHC91vLf788MahabIL/JjXF4xSOgcRFDg7nd7E0=;
        b=ilkHLL9OR5Zu/9W6dx9MNggTLylxA0ANbyDexiKn4nGnfAMrV6jQm+qaxW9gQLHcJgTaz7
        6nfjY8PDTUMBao1hhDK+ljUwahpw3tsCqNdBfEPl+5ORBpfGYlWCahIpCVkuvu/QuzmIn6
        UCx5/rPcUWeRHU2HsqHGvQ4otFWk6yw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-ZBvrTDm_MMy3MUvfRNLqDw-1; Wed, 20 Nov 2019 10:27:53 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 405FD18B5F75;
        Wed, 20 Nov 2019 15:27:52 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-123-90.rdu2.redhat.com [10.10.123.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 184CF1037ADA;
        Wed, 20 Nov 2019 15:27:52 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 6B2F1209BA; Wed, 20 Nov 2019 10:27:50 -0500 (EST)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 14/27] nfs_clone_sb_security(): simplify the check for server bogosity
Date:   Wed, 20 Nov 2019 10:27:37 -0500
Message-Id: <20191120152750.6880-15-smayhew@redhat.com>
In-Reply-To: <20191120152750.6880-1-smayhew@redhat.com>
References: <20191120152750.6880-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: ZBvrTDm_MMy3MUvfRNLqDw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

We used to check ->i_op for being nfs_dir_inode_operations.  With
separate inode_operations for v3 and v4 that became bogus, but
rather than going for protocol-dependent comparison we could've
just checked ->i_fop instead; _that_ is the same for all protocol
versions.

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index d8b53fcaa60e..c5fefd9bf6ae 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -2578,7 +2578,7 @@ int nfs_clone_sb_security(struct super_block *s, stru=
ct dentry *mntroot,
 =09unsigned long kflags =3D 0, kflags_out =3D 0;
=20
 =09/* clone any lsm security options from the parent to the new sb */
-=09if (d_inode(mntroot)->i_op !=3D NFS_SB(s)->nfs_client->rpc_ops->dir_ino=
de_ops)
+=09if (d_inode(mntroot)->i_fop !=3D &nfs_dir_operations)
 =09=09return -ESTALE;
=20
 =09if (NFS_SB(s)->caps & NFS_CAP_SECURITY_LABEL)
--=20
2.17.2

