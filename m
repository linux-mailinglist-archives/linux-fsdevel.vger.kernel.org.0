Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 960B9105823
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 18:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfKURN3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 12:13:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:53954 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726279AbfKURN2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:13:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 831E4B27B;
        Thu, 21 Nov 2019 17:13:26 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@google.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hou Tao <houtao1@huawei.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Hannes Reinecke <hare@suse.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 00/10] Fix cdrom autoclose
Date:   Thu, 21 Nov 2019 18:13:07 +0100
Message-Id: <cover.1574355709.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

there is cdrom autoclose feature that is supposed to close the tray,
wait for the disc to become ready, and then open the device.

This used to work in ancient times. Then in old times there was a hack
in util-linux which worked around the breakage which probably resulted
from switching to scsi emulation.

Currently util-linux maintainer refuses to merge another hack on the
basis that kernel still has the feature so it should be fixed there.
The code needs not be replicated in every userspace utility like mount
or dd which has no business knowing which devices are CD-roms and where
the autoclose setting is in the kernel.

v3:
- change the VMware workaround to use blacklist flag
- use exported function instead of ioctl
v4:
- fix crash reported by kernel test robot
- fix the debug message logic while refactoring cdrom_open
- move repeated code out of __blkdev_get

Link: https://lore.kernel.org/lkml/cover.1571834862.git.msuchanek@suse.de/
Link: https://lore.kernel.org/lkml/cover.1513263482.git.msuchanek@suse.de/

Michal Suchanek (10):
  cdrom: add poll_event_interruptible
  cdrom: factor out common open_for_* code
  cdrom: wait for the tray to close
  cdrom: export autoclose logic as a separate function
  cdrom: unify log messages.
  bdev: reset first_open when looping in __blkget_dev
  bdev: separate parts of __blkdev_get as helper functions
  bdev: add open_finish
  scsi: blacklist: add VMware ESXi cdrom - broken tray emulation
  scsi: sr: wait for the medium to become ready

 Documentation/filesystems/locking.rst |   2 +
 drivers/cdrom/cdrom.c                 | 471 +++++++++++++-------------
 drivers/scsi/scsi_devinfo.c           |  15 +-
 drivers/scsi/sr.c                     |  60 +++-
 fs/block_dev.c                        |  80 +++--
 include/linux/blkdev.h                |   1 +
 include/linux/cdrom.h                 |   1 +
 include/scsi/scsi_devinfo.h           |   7 +-
 8 files changed, 360 insertions(+), 277 deletions(-)

-- 
2.23.0

