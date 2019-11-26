Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A648A10A4D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 20:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfKZTzG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 14:55:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:40276 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727109AbfKZTys (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:54:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4B0E6B166;
        Tue, 26 Nov 2019 19:54:46 +0000 (UTC)
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
Subject: [PATCH v4 rebase 09/10] scsi: blacklist: add VMware ESXi cdrom - broken tray emulation
Date:   Tue, 26 Nov 2019 20:54:28 +0100
Message-Id: <1d01db2460f0e75bbe5d2b87f6335a0add7a954d.1574797504.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1574797504.git.msuchanek@suse.de>
References: <cover.1574797504.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The WMware ESXi cdrom identifies itself as:
sr 0:0:0:0: [sr0] scsi3-mmc drive: vendor: "NECVMWarVMware SATA CD001.00"
model: "VMware SATA CD001.00"
with the following get_capabilities print in sr.c:
        sr_printk(KERN_INFO, cd,
                  "scsi3-mmc drive: vendor: \"%s\" model: \"%s\"\n",
                  cd->device->vendor, cd->device->model);

The model looks like reliable identification while vendor does not.

The drive claims to have a tray and claims to be able to close it.
However, the UI has no notion of a tray - when medium is ejected it is
dropped in the floor and the user must select a medium again before the
drive can be re-loaded.  On the kernel side the tray_move call to close
the tray succeeds but the drive state does not change as a result of the
call.

The drive does not in fact emulate the tray state. There are two ways to
get the medium state. One is the SCSI status:

Physical drive:

Fixed format, current; Sense key: Not Ready
Additional sense: Medium not present - tray open
Raw sense data (in hex):
        70 00 02 00 00 00 00 0a  00 00 00 00 3a 02 00 00
        00 00

Fixed format, current; Sense key: Not Ready
Additional sense: Medium not present - tray closed
 Raw sense data (in hex):
        70 00 02 00 00 00 00 0a  00 00 00 00 3a 01 00 00
        00 00

VMware ESXi:

Fixed format, current; Sense key: Not Ready
Additional sense: Medium not present
  Info fld=0x0 [0]
 Raw sense data (in hex):
        f0 00 02 00 00 00 00 0a  00 00 00 00 3a 00 00 00
        00 00

So the tray state is not reported here. Other is medium status which the
kernel prefers if available. Adding a print here gives:

cdrom: get_media_event success: code = 0, door_open = 1, medium_present = 0

door_open is interpreted as open tray. This is fine so long as tray_move
would close the tray when requested or report an error which never
happens on VMware ESXi servers (5.5 and 6.5 tested).

This is a popular virtualization platform so a workaround is worthwhile.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v2: new patch
v3: change into a blacklist flag
v4: fix vendor match condition
---
 drivers/scsi/scsi_devinfo.c | 15 +++++++++------
 drivers/scsi/sr.c           |  6 ++++++
 include/scsi/scsi_devinfo.h |  7 ++++++-
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
index df14597752ec..923f54b88d24 100644
--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -252,6 +252,7 @@ static struct {
 	{"TOSHIBA", "CD-ROM", NULL, BLIST_ISROM},
 	{"Traxdata", "CDR4120", NULL, BLIST_NOLUN},	/* locks up */
 	{"USB2.0", "SMARTMEDIA/XD", NULL, BLIST_FORCELUN | BLIST_INQUIRY_36},
+	{"VMware", "VMware", NULL, BLIST_NO_MATCH_VENDOR | BLIST_NO_TRAY},
 	{"WangDAT", "Model 2600", "01.7", BLIST_SELECT_NO_ATN},
 	{"WangDAT", "Model 3200", "02.2", BLIST_SELECT_NO_ATN},
 	{"WangDAT", "Model 1300", "02.4", BLIST_SELECT_NO_ATN},
@@ -454,10 +455,11 @@ static struct scsi_dev_info_list *scsi_dev_info_list_find(const char *vendor,
 			/*
 			 * vendor strings must be an exact match
 			 */
-			if (vmax != strnlen(devinfo->vendor,
-					    sizeof(devinfo->vendor)) ||
-			    memcmp(devinfo->vendor, vskip, vmax))
-				continue;
+			if (!(devinfo->flags & BLIST_NO_MATCH_VENDOR))
+				if (vmax != strnlen(devinfo->vendor,
+						    sizeof(devinfo->vendor)) ||
+				    memcmp(devinfo->vendor, vskip, vmax))
+					continue;
 
 			/*
 			 * @model specifies the full string, and
@@ -468,8 +470,9 @@ static struct scsi_dev_info_list *scsi_dev_info_list_find(const char *vendor,
 				continue;
 			return devinfo;
 		} else {
-			if (!memcmp(devinfo->vendor, vendor,
-				    sizeof(devinfo->vendor)) &&
+			if ((!memcmp(devinfo->vendor, vendor,
+				    sizeof(devinfo->vendor))
+			       || (devinfo->flags & BLIST_NO_MATCH_VENDOR)) &&
 			    !memcmp(devinfo->model, model,
 				    sizeof(devinfo->model)))
 				return devinfo;
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 4664fdf75c0f..07c319494bf4 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -58,6 +58,7 @@
 #include <scsi/scsi_eh.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_ioctl.h>	/* For the door lock/unlock commands */
+#include <scsi/scsi_devinfo.h>
 
 #include "scsi_logging.h"
 #include "sr.h"
@@ -922,6 +923,11 @@ static void get_capabilities(struct scsi_cd *cd)
 		  buffer[n + 4] & 0x20 ? "xa/form2 " : "",	/* can read xa/from2 */
 		  buffer[n + 5] & 0x01 ? "cdda " : "", /* can read audio data */
 		  loadmech[buffer[n + 6] >> 5]);
+	if (cd->device->sdev_bflags & BLIST_NO_TRAY) {
+		buffer[n + 6] &= ~(0xff << 5);
+		sr_printk(KERN_INFO, cd,
+			  "Tray emulation bug workaround: tray -> caddy\n");
+	}
 	if ((buffer[n + 6] >> 5) == 0)
 		/* caddy drives can't close tray... */
 		cd->cdi.mask |= CDC_CLOSE_TRAY;
diff --git a/include/scsi/scsi_devinfo.h b/include/scsi/scsi_devinfo.h
index 3fdb322d4c4b..17ea96936cc6 100644
--- a/include/scsi/scsi_devinfo.h
+++ b/include/scsi/scsi_devinfo.h
@@ -67,8 +67,13 @@
 #define BLIST_RETRY_ITF		((__force blist_flags_t)(1ULL << 32))
 /* Always retry ABORTED_COMMAND with ASC 0xc1 */
 #define BLIST_RETRY_ASC_C1	((__force blist_flags_t)(1ULL << 33))
+/* Device reports to have a tray but it cannot be operated reliably */
+#define BLIST_NO_TRAY		((__force blist_flags_t)(1ULL << 34))
+/* Vendor string is bogus */
+#define BLIST_NO_MATCH_VENDOR	((__force blist_flags_t)(1ULL << 35))
 
-#define __BLIST_LAST_USED BLIST_RETRY_ASC_C1
+
+#define __BLIST_LAST_USED BLIST_NO_MATCH_VENDOR
 
 #define __BLIST_HIGH_UNUSED (~(__BLIST_LAST_USED | \
 			       (__force blist_flags_t) \
-- 
2.23.0

