Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D99FE1B5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 14:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391920AbfJWMx0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 08:53:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:49442 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391046AbfJWMxQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:53:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0BE11B67D;
        Wed, 23 Oct 2019 12:53:14 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-scsi@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 7/8] scsi: sr: workaround VMware ESXi cdrom emulation bug
Date:   Wed, 23 Oct 2019 14:52:46 +0200
Message-Id: <abf81ec4f8b6139fffc609df519856ff8dc01d0d.1571834862.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571834862.git.msuchanek@suse.de>
References: <cover.1571834862.git.msuchanek@suse.de>
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

So the model looks like reliable identification while vendor does not.

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
 drivers/scsi/sr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 4664fdf75c0f..8090c5bdec09 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -867,6 +867,7 @@ static void get_capabilities(struct scsi_cd *cd)
 	unsigned int ms_len = 128;
 	int rc, n;
 
+	static const char *model_vmware = "VMware";
 	static const char *loadmech[] =
 	{
 		"caddy",
@@ -922,6 +923,11 @@ static void get_capabilities(struct scsi_cd *cd)
 		  buffer[n + 4] & 0x20 ? "xa/form2 " : "",	/* can read xa/from2 */
 		  buffer[n + 5] & 0x01 ? "cdda " : "", /* can read audio data */
 		  loadmech[buffer[n + 6] >> 5]);
+	if (!strncmp(cd->device->model, model_vmware, strlen(model_vmware))) {
+		buffer[n + 6] &= ~(0xff << 5);
+		sr_printk(KERN_INFO, cd,
+			  "VMware ESXi bug workaround: tray -> caddy\n");
+	}
 	if ((buffer[n + 6] >> 5) == 0)
 		/* caddy drives can't close tray... */
 		cd->cdi.mask |= CDC_CLOSE_TRAY;
-- 
2.23.0

