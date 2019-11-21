Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 707E71055BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 16:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfKUPhf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 10:37:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34127 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726293AbfKUPhe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:37:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574350653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jCutdT9TaQdIImo/1AFgCrOpVjlugrWqMw96TD3dGTc=;
        b=Old+/sSgsNYi7vmHy2rmXPV99Oz4J4ZSe56Fo3JP/h8gF6aj2v/LONxnAElJTPDCb1ZRYo
        zfuaXmZ81WPEwzJNxGpcl5OMRaCJP6BlKCB9ryAytYLpmuhhpzMlAnrAoyDXHJRmxO0dij
        ac7H4m5OdrnOLpna6Ne9t19SIjAEoCA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-0jpKBEWHNDKHOS8NdKZ-Dg-1; Thu, 21 Nov 2019 10:37:29 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67F3C10171AB;
        Thu, 21 Nov 2019 15:37:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-161.rdu2.redhat.com [10.10.120.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5229E692AE;
        Thu, 21 Nov 2019 15:37:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix large file support
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, marc.dionne@auristor.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 21 Nov 2019 15:37:26 +0000
Message-ID: <157435064653.9583.16369826233033888377.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 0jpKBEWHNDKHOS8NdKZ-Dg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Marc Dionne <marc.dionne@auristor.com>

By default s_maxbytes is set to MAX_NON_LFS, which limits the usable
file size to 2GB, enforced by the vfs.

Commit b9b1f8d5930a ("AFS: write support fixes") added support for the
64-bit fetch and store server operations, but did not change this value.
As a result, attempts to write past the 2G mark result in EFBIG errors:

 $ dd if=3D/dev/zero of=3Dfoo bs=3D1M count=3D1 seek=3D2048
 dd: error writing 'foo': File too large

Set s_maxbytes to MAX_LFS_FILESIZE.

Fixes: b9b1f8d5930a ("AFS: write support fixes")
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/super.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/super.c b/fs/afs/super.c
index f18911e8d770..488641b1a418 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -435,6 +435,7 @@ static int afs_fill_super(struct super_block *sb, struc=
t afs_fs_context *ctx)
 =09/* fill in the superblock */
 =09sb->s_blocksize=09=09=3D PAGE_SIZE;
 =09sb->s_blocksize_bits=09=3D PAGE_SHIFT;
+=09sb->s_maxbytes=09=09=3D MAX_LFS_FILESIZE;
 =09sb->s_magic=09=09=3D AFS_FS_MAGIC;
 =09sb->s_op=09=09=3D &afs_super_ops;
 =09if (!as->dyn_root)

