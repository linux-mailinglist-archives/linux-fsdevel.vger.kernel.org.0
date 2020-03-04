Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C14B179626
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 18:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbgCDRBO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 12:01:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26321 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729865AbgCDQ7Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:59:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583341155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BDyna82gOULpd6exk200NRUKeqMshv908IMcsDkgfcs=;
        b=M8UGBoaWRdLFxj1wYZjMdEZnYwD2oUeKU91UbdxYteM4t5X9+sJb1QXAKn+T+qDD9Pz+sc
        BNRGQbcGBgGQ1xYshru2WfnJEIVd7ldHZtP2j12NFsX1UuHgW2XA56ihCUm5Pq25JQjT7k
        cchBJ+eXQWJEQ40pURnnU38Z5MnYcJU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-G7_KU9XAPJmSDI_OWHjqAA-1; Wed, 04 Mar 2020 11:59:13 -0500
X-MC-Unique: G7_KU9XAPJmSDI_OWHjqAA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56BBA107ACCA;
        Wed,  4 Mar 2020 16:59:12 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2FA4960C84;
        Wed,  4 Mar 2020 16:59:12 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 8153F225816; Wed,  4 Mar 2020 11:59:03 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        mst@redhat.com
Subject: [PATCH 16/20] fuse,virtiofs: Define dax address space operations
Date:   Wed,  4 Mar 2020 11:58:41 -0500
Message-Id: <20200304165845.3081-17-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-1-vgoyal@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is done along the lines of ext4 and xfs. I primarily wanted ->writep=
ages
hook at this time so that I could call into dax_writeback_mapping_range()=
.
This in turn will decide which pfns need to be written back.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/file.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index ab56396cf661..619aff6b5f44 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2696,6 +2696,16 @@ static int fuse_writepages_fill(struct page *page,
 	return err;
 }
=20
+static int fuse_dax_writepages(struct address_space *mapping,
+				struct writeback_control *wbc)
+{
+
+	struct inode *inode =3D mapping->host;
+	struct fuse_conn *fc =3D get_fuse_conn(inode);
+
+	return dax_writeback_mapping_range(mapping, fc->dax_dev, wbc);
+}
+
 static int fuse_writepages(struct address_space *mapping,
 			   struct writeback_control *wbc)
 {
@@ -4032,6 +4042,13 @@ static const struct address_space_operations fuse_=
file_aops  =3D {
 	.write_end	=3D fuse_write_end,
 };
=20
+static const struct address_space_operations fuse_dax_file_aops  =3D {
+	.writepages	=3D fuse_dax_writepages,
+	.direct_IO	=3D noop_direct_IO,
+	.set_page_dirty	=3D noop_set_page_dirty,
+	.invalidatepage	=3D noop_invalidatepage,
+};
+
 void fuse_init_file_inode(struct inode *inode)
 {
 	struct fuse_inode *fi =3D get_fuse_inode(inode);
@@ -4049,5 +4066,6 @@ void fuse_init_file_inode(struct inode *inode)
=20
 	if (fc->dax_dev) {
 		inode->i_flags |=3D S_DAX;
+		inode->i_data.a_ops =3D &fuse_dax_file_aops;
 	}
 }
--=20
2.20.1

