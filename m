Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D542215AE1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 18:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgBLRH6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 12:07:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28359 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728814AbgBLRH4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:07:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581527274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wp1678TYHxcRdW/SymzuQImvfcwDJWWzwf8rp6Sn0Cc=;
        b=jNAPH0t2hM12FJXvx0RLyrVUjnUQp5CVeM4VQiMoM1F6BeflDYI58WIbyWGHBMBdid8qx0
        VsWqSbCyAZiGDOgti/lH0Q8kazUlW1MgdaeZdiDSwNb99VgncWlgZ8nIn+2vOBzTcet3S+
        IXoirbsii9t8E1CQvRjH35QmmRT9O9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-Lvxy7clxM6SiJcwNjeQDmA-1; Wed, 12 Feb 2020 12:07:50 -0500
X-MC-Unique: Lvxy7clxM6SiJcwNjeQDmA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A23661800D6B;
        Wed, 12 Feb 2020 17:07:49 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 281445C101;
        Wed, 12 Feb 2020 17:07:47 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id B29462257D4; Wed, 12 Feb 2020 12:07:46 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, hch@infradead.org
Cc:     vgoyal@redhat.com, dm-devel@redhat.com, jack@suse.cz
Subject: [PATCH 2/6] dax,iomap,ext4,ext2,xfs: Save dax_offset in "struct iomap"
Date:   Wed, 12 Feb 2020 12:07:29 -0500
Message-Id: <20200212170733.8092-3-vgoyal@redhat.com>
In-Reply-To: <20200212170733.8092-1-vgoyal@redhat.com>
References: <20200212170733.8092-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a new field "sector_t dax_offset" to "struct iomap". This will be
filled by filesystems and dax code will make use of this to convert
sector into page offset (dax_pgoff()), instead of bdev_dax_pgoff(). This
removes the dependency of having to pass in block device for dax operatio=
ns.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/ext2/inode.c       | 1 +
 fs/ext4/inode.c       | 1 +
 fs/xfs/xfs_iomap.c    | 2 ++
 include/linux/iomap.h | 1 +
 4 files changed, 5 insertions(+)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index c885cf7d724b..5c3379e78d49 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -823,6 +823,7 @@ static int ext2_iomap_begin(struct inode *inode, loff=
_t offset, loff_t length,
 	iomap->bdev =3D inode->i_sb->s_bdev;
 	iomap->offset =3D (u64)first_block << blkbits;
 	iomap->dax_dev =3D sbi->s_daxdev;
+	iomap->dax_offset =3D get_start_sect(iomap->bdev);
=20
 	if (ret =3D=3D 0) {
 		iomap->type =3D IOMAP_HOLE;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1305b810c44a..0ea7fbb8076f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3330,6 +3330,7 @@ static void ext4_set_iomap(struct inode *inode, str=
uct iomap *iomap,
=20
 	iomap->bdev =3D inode->i_sb->s_bdev;
 	iomap->dax_dev =3D EXT4_SB(inode->i_sb)->s_daxdev;
+	iomap->dax_offset =3D get_start_sect(iomap->bdev);
 	iomap->offset =3D (u64) map->m_lblk << blkbits;
 	iomap->length =3D (u64) map->m_len << blkbits;
=20
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index bb590a267a7f..ad8b18fc96fd 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -80,6 +80,7 @@ xfs_bmbt_to_iomap(
 	iomap->length =3D XFS_FSB_TO_B(mp, imap->br_blockcount);
 	iomap->bdev =3D target->bt_bdev;
 	iomap->dax_dev =3D target->bt_daxdev;
+	iomap->dax_offset =3D get_start_sect(iomap->bdev);
 	iomap->flags =3D flags;
=20
 	if (xfs_ipincount(ip) &&
@@ -103,6 +104,7 @@ xfs_hole_to_iomap(
 	iomap->length =3D XFS_FSB_TO_B(ip->i_mount, end_fsb - offset_fsb);
 	iomap->bdev =3D target->bt_bdev;
 	iomap->dax_dev =3D target->bt_daxdev;
+	iomap->dax_offset =3D get_start_sect(iomap->bdev);
 }
=20
 static inline xfs_fileoff_t
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8b09463dae0d..cac5d667aa74 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -84,6 +84,7 @@ struct iomap {
 	u16			flags;	/* flags for mapping */
 	struct block_device	*bdev;	/* block device for I/O */
 	struct dax_device	*dax_dev; /* dax_dev for dax operations */
+	sector_t		dax_offset; /* offset in dax device */
 	void			*inline_data;
 	void			*private; /* filesystem private */
 	const struct iomap_page_ops *page_ops;
--=20
2.20.1

