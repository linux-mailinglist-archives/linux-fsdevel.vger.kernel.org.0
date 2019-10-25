Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4B04E49DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 13:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407270AbfJYLVv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Oct 2019 07:21:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:56776 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726298AbfJYLVu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:21:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5885EB19E;
        Fri, 25 Oct 2019 11:21:48 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-scsi@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 0/7] Fix cdrom autoclose
Date:   Fri, 25 Oct 2019 13:21:37 +0200
Message-Id: <cover.1572002144.git.msuchanek@suse.de>
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

Link: https://lore.kernel.org/lkml/cover.1513263482.git.msuchanek@suse.de/
Link: https://lore.kernel.org/lkml/cover.1571834862.git.msuchanek@suse.de/

v3:
- change the VMware workaround to use blacklist flag
- use exported function instead of ioctl

Michal Suchanek (7):
  cdrom: add poll_event_interruptible
  cdrom: factor out common open_for_* code
  cdrom: wait for the tray to close
  cdrom: export autoclose logic as a separate function
  bdev: add open_finish.
  scsi: blacklist: add VMware ESXi cdrom - broken tray emulation.
  scsi: sr: wait for the medium to become ready

 Documentation/filesystems/locking.rst |   2 +
 drivers/cdrom/cdrom.c                 | 192 ++++++++++++++------------
 drivers/scsi/scsi_devinfo.c           |  15 +-
 drivers/scsi/sr.c                     |  60 ++++++--
 fs/block_dev.c                        |  21 ++-
 include/linux/blkdev.h                |   1 +
 include/linux/cdrom.h                 |   1 +
 include/scsi/scsi_devinfo.h           |   7 +-
 8 files changed, 191 insertions(+), 108 deletions(-)

-- 
2.23.0

