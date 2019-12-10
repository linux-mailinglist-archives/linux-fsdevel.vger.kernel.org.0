Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E567F118BEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 16:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfLJPEG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 10:04:06 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27981 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727566AbfLJPEG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575990245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dPGQOfABvktYphzs0ypCJBGv3QqQ358wkiKWnHzjexs=;
        b=RKjp3I4v5orv2FoKS8GsJiTxhYoOiae//b1IEgPLadrhWzGdDE55W8GjPTBcYsRzYkvLZy
        ZniHotugduFHbkdwq3X9J+D+NViRelXfvwIpcQ3QzHzprwrVXDPWTlsEeR3T6xU+pia+7/
        kZZbHKPzgAwHsw1W9h7fWXLrcVQP9QI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-9glu79mlNaC3z9m9FQ2lYA-1; Tue, 10 Dec 2019 10:04:01 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1BD51852E22;
        Tue, 10 Dec 2019 15:04:00 +0000 (UTC)
Received: from orion.redhat.com (ovpn-205-230.brq.redhat.com [10.40.205.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24AA11001925;
        Tue, 10 Dec 2019 15:03:59 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de
Subject: [PATCH 3/5] ecryptfs: drop direct calls to ->bmap
Date:   Tue, 10 Dec 2019 16:03:42 +0100
Message-Id: <20191210150344.112181-4-cmaiolino@redhat.com>
In-Reply-To: <20191210150344.112181-1-cmaiolino@redhat.com>
References: <20191210150344.112181-1-cmaiolino@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 9glu79mlNaC3z9m9FQ2lYA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
 static sector_t ecryptfs_bmap(struct address_space *mapping, sector_t bloc=
k)
 {
-=09int rc =3D 0;
-=09struct inode *inode;
-=09struct inode *lower_inode;
-
-=09inode =3D (struct inode *)mapping->host;
-=09lower_inode =3D ecryptfs_inode_to_lower(inode);
-=09if (lower_inode->i_mapping->a_ops->bmap)
-=09=09rc =3D lower_inode->i_mapping->a_ops->bmap(lower_inode->i_mapping,
-=09=09=09=09=09=09=09 block);
-=09return rc;
+=09struct inode *lower_inode =3D ecryptfs_inode_to_lower(mapping->host);
+=09int ret =3D bmap(lower_inode, &block);
+
+=09if (ret)
+=09=09return 0;
+=09return block;
 }
=20
 const struct address_space_operations ecryptfs_aops =3D {
--=20
2.23.0

