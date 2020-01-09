Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC945135A24
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 14:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbgAINbB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 08:31:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21095 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729114AbgAINbB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:31:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578576660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0YYg4tVJ4OGAuXsuBTuC4BaFuZnWfJ/BXnswaMtHl4g=;
        b=jVWqL3qkDMPtpBqC4FurX5mksHGeYPwTubN1cNyQrFa/Of67bZ7YYaljrhHPMeTM46wMS4
        +PbqdTZX/8GDErk+ZTWFaLSoyejvOQR7Vq83MR3MJ9UdFJ0iH6s1fLUoe3dQipuMYHhSYK
        NynQwalRsX3cX+GYzbqgOnlaVFeyqOk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-p3E1xWXnOty9R7kPcOitPA-1; Thu, 09 Jan 2020 08:30:57 -0500
X-MC-Unique: p3E1xWXnOty9R7kPcOitPA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B4DD1005514;
        Thu,  9 Jan 2020 13:30:56 +0000 (UTC)
Received: from orion.redhat.com (ovpn-205-210.brq.redhat.com [10.40.205.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FEAA60C88;
        Thu,  9 Jan 2020 13:30:55 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, viro@zeniv.linux.org.uk
Subject: [PATCH 3/5] ecryptfs: drop direct calls to ->bmap
Date:   Thu,  9 Jan 2020 14:30:43 +0100
Message-Id: <20200109133045.382356-4-cmaiolino@redhat.com>
In-Reply-To: <20200109133045.382356-1-cmaiolino@redhat.com>
References: <20200109133045.382356-1-cmaiolino@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace direct ->bmap calls by bmap() method.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 fs/ecryptfs/mmap.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index cffa0c1ec829..019572c6b39a 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -524,16 +524,12 @@ static int ecryptfs_write_end(struct file *file,
=20
 static sector_t ecryptfs_bmap(struct address_space *mapping, sector_t bl=
ock)
 {
-	int rc =3D 0;
-	struct inode *inode;
-	struct inode *lower_inode;
-
-	inode =3D (struct inode *)mapping->host;
-	lower_inode =3D ecryptfs_inode_to_lower(inode);
-	if (lower_inode->i_mapping->a_ops->bmap)
-		rc =3D lower_inode->i_mapping->a_ops->bmap(lower_inode->i_mapping,
-							 block);
-	return rc;
+	struct inode *lower_inode =3D ecryptfs_inode_to_lower(mapping->host);
+	int ret =3D bmap(lower_inode, &block);
+
+	if (ret)
+		return 0;
+	return block;
 }
=20
 const struct address_space_operations ecryptfs_aops =3D {
--=20
2.23.0

