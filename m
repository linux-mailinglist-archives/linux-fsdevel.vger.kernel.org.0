Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30817FCDF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 19:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfKNSlL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 13:41:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45682 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726901AbfKNSlL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573756869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UgtGbn1eYbgjdPbHsvL18nU6iPqWM6qO3qr2Grv4XiM=;
        b=XFcbH0nQU4qThazJVacZpBnHozZ0b9bWHbWYWY01lDLKziJlW72V31ZzY2K2ki1ZXbmTph
        HqT25z6ciNl5G/Yqt1U5Iter4rX8vQlAJ6/ggNRZ8wmwSzAP3S63sLiaClHucaqkGG3G9G
        UxtBVi218gjAOaEsY9N3E/kfnmGbEr8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-mUKNquzEO-ewlXXwfAUERw-1; Thu, 14 Nov 2019 13:41:07 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4ECA31005500;
        Thu, 14 Nov 2019 18:41:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-254.rdu2.redhat.com [10.10.120.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 956A45C219;
        Thu, 14 Nov 2019 18:41:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix race in commit bulk status fetch
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, marc.dionne@auristor.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Nov 2019 18:41:03 +0000
Message-ID: <157375686331.16781.5317786612607603165.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: mUKNquzEO-ewlXXwfAUERw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a lookup is done, the afs filesystem will perform a bulk status-fetch
operation on the requested vnode (file) plus the next 49 other vnodes from
the directory list (in AFS, directory contents are downloaded as blobs and
parsed locally).  When the results are received, it will speculatively
populate the inode cache from the extra data.

However, if the lookup races with another lookup on the same directory, but
for a different file - one that's in the 49 extra fetches, then if the bulk
status-fetch operation finishes first, it will try and update the inode
from the other lookup.

If this other inode is still in the throes of being created, however, this
will cause an assertion failure in afs_apply_status():

=09BUG_ON(test_bit(AFS_VNODE_UNSET, &vnode->flags));

on or about fs/afs/inode.c:175 because it expects data to be there already
that it can compare to.

Fix this by skipping the update if the inode is being created as the
creator will presumably set up the inode with the same information.

Fixes: 39db9815da48 ("afs: Fix application of the results of a inline bulk =
status fetch")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
---

 fs/afs/dir.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index cc12772d0a4d..497f979018c2 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -803,7 +803,12 @@ static struct inode *afs_do_lookup(struct inode *dir, =
struct dentry *dentry,
 =09=09=09continue;
=20
 =09=09if (cookie->inodes[i]) {
-=09=09=09afs_vnode_commit_status(&fc, AFS_FS_I(cookie->inodes[i]),
+=09=09=09struct afs_vnode *iv =3D AFS_FS_I(cookie->inodes[i]);
+
+=09=09=09if (test_bit(AFS_VNODE_UNSET, &iv->flags))
+=09=09=09=09continue;
+
+=09=09=09afs_vnode_commit_status(&fc, iv,
 =09=09=09=09=09=09scb->cb_break, NULL, scb);
 =09=09=09continue;
 =09=09}

