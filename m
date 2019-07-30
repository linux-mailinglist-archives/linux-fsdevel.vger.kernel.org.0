Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37A407A71C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 13:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbfG3LhV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 07:37:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730616AbfG3LhV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 07:37:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 646513082B1F;
        Tue, 30 Jul 2019 11:37:21 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (ovpn-116-177.sin2.redhat.com [10.67.116.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DCED60856;
        Tue, 30 Jul 2019 11:37:12 +0000 (UTC)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     snitzer@redhat.com, dan.j.williams@intel.com
Cc:     dm-devel@redhat.com, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        agk@redhat.com, pagupta@redhat.com
Subject: [PATCH] dm: fix dax_dev NULL dereference
Date:   Tue, 30 Jul 2019 17:07:08 +0530
Message-Id: <20190730113708.14660-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 30 Jul 2019 11:37:21 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


  'Murphy Zhou' reports[1] hitting the panic when running xfstests 
  generic/108 on pmem ramdisk. In his words:

   This test is simulating partial disk error when calling fsync():
   create a lvm vg which consists of 2 disks:
   one scsi_debug disk; one other disk I specified, pmem ramdisk in this case.
   create lv in this vg and write to it, make sure writing across 2 disks;
   offline scsi_debug disk;
   write again to allocated area;
   expect fsync: IO error.
   If one of the disks is pmem ramdisk, it reproduces every time on my setup,
   on v5.3-rc2+.
   The mount -o dax option is not required to reproduce this panic.
   ...

  Fix this by returning false from 'device_synchronous' function when dax_dev
  is NULL.

 [ 1984.878208] BUG: kernel NULL pointer dereference, address: 00000000000002d0
 [ 1984.882546] #PF: supervisor read access in kernel mode
 [ 1984.885664] #PF: error_code(0x0000) - not-present page
 [ 1984.888626] PGD 0 P4D 0
 [ 1984.890140] Oops: 0000 [#1] SMP PTI
 ...
 ...
 [ 1984.943682] Call Trace:
 [ 1984.945007]  device_synchronous+0xe/0x20 [dm_mod]
 [ 1984.947328]  stripe_iterate_devices+0x48/0x60 [dm_mod]
 [ 1984.949947]  ? dm_set_device_limits+0x130/0x130 [dm_mod]
 [ 1984.952516]  dm_table_supports_dax+0x39/0x90 [dm_mod]
 [ 1984.954989]  dm_table_set_restrictions+0x248/0x5d0 [dm_mod]
 [ 1984.957685]  dm_setup_md_queue+0x66/0x110 [dm_mod]
 [ 1984.960280]  table_load+0x1e3/0x390 [dm_mod]
 [ 1984.962491]  ? retrieve_status+0x1c0/0x1c0 [dm_mod]
 [ 1984.964910]  ctl_ioctl+0x1d3/0x550 [dm_mod]
 [ 1984.967006]  ? path_lookupat+0xf4/0x200
 [ 1984.968890]  dm_ctl_ioctl+0xa/0x10 [dm_mod]
 [ 1984.970920]  do_vfs_ioctl+0xa9/0x630
 [ 1984.972701]  ksys_ioctl+0x60/0x90
 [ 1984.974335]  __x64_sys_ioctl+0x16/0x20
 [ 1984.976221]  do_syscall_64+0x5b/0x1d0
 [ 1984.978091]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

 [1] https://lore.kernel.org/linux-fsdevel/2011806368.5335560.1564469373050.JavaMail.zimbra@redhat.com/T/#mac662eb50b9d7bd282b23e6e8625a3f7a4687506

Fixes: 2e9ee0955d3c ("dm: enable synchronous dax")
Reported-by: jencce.kernel@gmail.com
Tested-by: jencce.kernel@gmail.com
Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 drivers/md/dm-table.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index caaee8032afe..b065845c1bdd 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -894,6 +894,9 @@ int device_supports_dax(struct dm_target *ti, struct dm_dev *dev,
 static int device_synchronous(struct dm_target *ti, struct dm_dev *dev,
 				       sector_t start, sector_t len, void *data)
 {
+	if (!dev->dax_dev)
+		return false;
+
 	return dax_synchronous(dev->dax_dev);
 }
 
-- 
2.20.1

