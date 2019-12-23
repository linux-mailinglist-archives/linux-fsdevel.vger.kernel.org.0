Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65F4B129B8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2019 23:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfLWW4G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 17:56:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20713 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727012AbfLWW4G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 17:56:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577141765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zM2fkL4T/uoG/bJ548uR6UosY8oba9c5t652qosdH4g=;
        b=aym2Tjehx2vAjkZuN1UldY2pPAEwLVAat7/04pLfsORMm6pf66yN3G6+I3S9TgD7fMByJ7
        Y4N5ausbwguLaTjOkmiatTA2eGk10tKysoxjVn6SO2vgJdmBTTPUS+NJAgcI1jMXK3yO6M
        mDwcwJvk4VpAatscEjVYIkImIK9yB8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-kIbTEnYCNLe-GrvhLS8ELw-1; Mon, 23 Dec 2019 17:56:02 -0500
X-MC-Unique: kIbTEnYCNLe-GrvhLS8ELw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7D7B800D41;
        Mon, 23 Dec 2019 22:56:00 +0000 (UTC)
Received: from sulaco.redhat.com (ovpn-112-13.rdu2.redhat.com [10.10.112.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E8D8B60BE2;
        Mon, 23 Dec 2019 22:55:59 +0000 (UTC)
From:   Tony Asleson <tasleson@redhat.com>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [RFC 0/9] Add persistent durable identifier to storage log messages
Date:   Mon, 23 Dec 2019 16:55:49 -0600
Message-Id: <20191223225558.19242-1-tasleson@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Today users have no easy way to correlate kernel log messages for storage
devices across reboots, device dynamic add/remove, or when the device is
physically or logically moved from from system to system.  This is due
to the existing log IDs which identify how the device is attached and not
a unique ID of what is attached.  Additionally, even when the attachment
hasn't changed, it's not always obvious which messages belong to the
device as the different areas in the storage stack use different
identifiers, eg. (sda, sata1.00, sd 0:0:0:0).

This change addresses this by adding a unique ID to each log
message.  It couples the existing structured key/value logging capability
and VPD 0x83 device identification.


An example of logs filtered for a specific device:

# journalctl "_KERNEL_DURABLE_NAME"=3D"t10.ATA QEMU HARDDISK QM00005" \
> | cut -c 25- | fmt -t
...
l: sd 0:0:0:0: [sda] 125829120 512-byte logical blocks: (64.4 GB/60.0 GiB=
)
l: sd 0:0:0:0: Attached scsi generic sg0 type 0
l: sd 0:0:0:0: [sda] Write Protect is off
l: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
l: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
            support DPO or FUA
l: sd 0:0:0:0: [sda] Attached SCSI disk
l: sata1.00: exception Emask 0x0 SAct 0x2000000 SErr 0x2000000 action
            0x6 frozen
l: sata1.00: failed command: READ FPDMA QUEUED
l: sata1.00: cmd 60/08:c8:08:98:53/00:00:05:00:00/40 tag 25 ncq dma 4096
            in res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout=
)
l: sata1.00: status: { DRDY }
l: sata1.00: configured for UDMA/100
l: sata1.00: device reported invalid CHS sector 0
l: sd 0:0:0:0: [sda] tag#25 FAILED Result: hostbyte=3DDID_OK
            driverbyte=3DDRIVER_SENSE
l: sd 0:0:0:0: [sda] tag#25 Sense Key : Illegal Request [current]
l: sd 0:0:0:0: [sda] tag#25 Add. Sense: Unaligned write command
l: sd 0:0:0:0: [sda] tag#25 CDB: Read(10) 28 00 05 53 98 08 00 00 08 00
l: blk_update_request: I/O error, dev sda, sector 89364488 op 0x0:(READ)
            flags 0x80700 phys_seg 1 prio class 0
l: XFS (sda5): Mounting V5 Filesystem
l: XFS (sda5): Ending clean mount
l: XFS (sda5): Unmounting Filesystem
l: sata1.00: exception Emask 0x0 SAct 0x200000 SErr 0x200000 action
            0x6 frozen
l: sata1.00: failed command: READ FPDMA QUEUED
l: sata1.00: cmd 60/08:a8:08:98:53/00:00:05:00:00/40 tag 21 ncq dma 4096
            in res 40/00:ff:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout=
)
l: sata1.00: status: { DRDY }
l: sata1.00: configured for UDMA/100
l: sd 0:0:0:0: [sda] tag#21 FAILED Result: hostbyte=3DDID_OK
            driverbyte=3DDRIVER_SENSE
l: sd 0:0:0:0: [sda] tag#21 Sense Key : Illegal Request [current]
l: sd 0:0:0:0: [sda] tag#21 Add. Sense: Unaligned write command
l: sd 0:0:0:0: [sda] tag#21 CDB: Read(10) 28 00 05 53 98 08 00 00 08 00
l: blk_update_request: I/O error, dev sda, sector 89364488 op 0x0:(READ)
            flags 0x80700 phys_seg 1 prio class 0
l: sata1.00: exception Emask 0x0 SAct 0x20 SErr 0x20 action 0x6 frozen
l: sata1.00: failed command: READ FPDMA QUEUED
l: sata1.00: cmd 60/08:28:08:98:53/00:00:05:00:00/40 tag 5 ncq dma 4096
            in res 40/00:ff:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout=
)
l: sata1.00: status: { DRDY }
l: sata1.00: configured for UDMA/100
l: sata1.00: exception Emask 0x0 SAct 0x200000 SErr 0x200000 action
            0x6 frozen
l: sata1.00: failed command: READ FPDMA QUEUED
l: sata1.00: cmd 60/08:a8:08:98:53/00:00:05:00:00/40 tag 21 ncq dma 4096
            in res 40/00:ff:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout=
)
l: sata1.00: status: { DRDY }
l: sata1.00: configured for UDMA/100
l: sata1.00: NCQ disabled due to excessive errors
l: sata1.00: exception Emask 0x0 SAct 0x40000 SErr 0x40000 action
            0x6 frozen
l: sata1.00: failed command: READ FPDMA QUEUED
l: sata1.00: cmd 60/08:90:08:98:53/00:00:05:00:00/40 tag 18 ncq dma 4096
            in res 40/00:ff:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout=
)
l: sata1.00: status: { DRDY }
l: sata1.00: configured for UDMA/100
l: XFS (sda5): Mounting V5 Filesystem
l: XFS (sda5): Ending clean mount
l: XFS (sda5): Unmounting Filesystem

This change is incomplete.  With the plethora of different logging
techniques utilized in the kernel for different drivers, file systems,
etc. it will take some coordinated effort and additional changes.  I
tried a few different approaches, to cover as much as I could without
resorting to changing every print statement in all the storage layers,
but maybe there is a better, more elegant approach?

I believe having this functionality is very useful and important for
system configurations of all sizes.  I mentioned this change briefly in:
https://lore.kernel.org/lkml/30f29fe6-8445-0016-8cdc-3ef99d43fbf5@redhat.=
com/

The series is based on 5.4.

-Tony

Tony Asleson (9):
  lib/string: Add function to trim duplicate WS
  printk: Bring back printk_emit
  printk: Add printk_emit_ratelimited macro
  struct device_type: Add function callback durable_name
  block: Add support functions for persistent durable name
  create_syslog_header: Add durable name
  print_req_error: Add persistent durable name
  ata_dev_printk: Add durable name to output
  __xfs_printk: Add durable name to output

 block/blk-core.c           | 11 ++++++++++-
 drivers/ata/libata-core.c  | 26 +++++++++++++++++++++++---
 drivers/base/core.c        | 33 +++++++++++++++++++++++++++++++++
 drivers/scsi/scsi_lib.c    | 20 ++++++++++++++++++++
 drivers/scsi/scsi_sysfs.c  |  1 +
 fs/xfs/xfs_message.c       | 17 +++++++++++++++++
 include/linux/device.h     |  4 ++++
 include/linux/printk.h     | 17 +++++++++++++++++
 include/linux/string.h     |  2 ++
 include/scsi/scsi_device.h |  3 +++
 kernel/printk/printk.c     | 15 +++++++++++++++
 lib/string.c               | 35 +++++++++++++++++++++++++++++++++++
 12 files changed, 180 insertions(+), 4 deletions(-)

--=20
2.21.0

