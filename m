Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22F303D2D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 18:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405752AbfFKQmz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 12:42:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34194 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404647AbfFKQmy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 12:42:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8109A30F1BA4;
        Tue, 11 Jun 2019 16:42:54 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (ovpn-116-60.sin2.redhat.com [10.67.116.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1255461F21;
        Tue, 11 Jun 2019 16:42:18 +0000 (UTC)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     dm-devel@redhat.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org,
        qemu-devel@nongnu.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Cc:     dan.j.williams@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com,
        jasowang@redhat.com, willy@infradead.org, rjw@rjwysocki.net,
        hch@infradead.org, lenb@kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        lcapitulino@redhat.com, kwolf@redhat.com, imammedo@redhat.com,
        jmoyer@redhat.com, nilal@redhat.com, riel@surriel.com,
        stefanha@redhat.com, aarcange@redhat.com, david@redhat.com,
        david@fromorbit.com, cohuck@redhat.com,
        xiaoguangrong.eric@gmail.com, pagupta@redhat.com,
        pbonzini@redhat.com, yuval.shaia@oracle.com, kilobyte@angband.pl,
        jstaron@google.com, rdunlap@infradead.org, snitzer@redhat.com
Subject: [PATCH v12 6/7] ext4: disable map_sync for async flush
Date:   Tue, 11 Jun 2019 22:08:01 +0530
Message-Id: <20190611163802.25352-7-pagupta@redhat.com>
In-Reply-To: <20190611163802.25352-1-pagupta@redhat.com>
References: <20190611163802.25352-1-pagupta@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 11 Jun 2019 16:42:54 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dont support 'MAP_SYNC' with non-DAX files and DAX files
with asynchronous dax_device. Virtio pmem provides
asynchronous host page cache flush mechanism. We don't
support 'MAP_SYNC' with virtio pmem and ext4.

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/file.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 98ec11f69cd4..dee549339e13 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -360,15 +360,17 @@ static const struct vm_operations_struct ext4_file_vm_ops = {
 static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file->f_mapping->host;
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct dax_device *dax_dev = sbi->s_daxdev;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(sbi)))
 		return -EIO;
 
 	/*
-	 * We don't support synchronous mappings for non-DAX files. At least
-	 * until someone comes with a sensible use case.
+	 * We don't support synchronous mappings for non-DAX files and
+	 * for DAX files if underneath dax_device is not synchronous.
 	 */
-	if (!IS_DAX(file_inode(file)) && (vma->vm_flags & VM_SYNC))
+	if (!daxdev_mapping_supported(vma, dax_dev))
 		return -EOPNOTSUPP;
 
 	file_accessed(file);
-- 
2.20.1

