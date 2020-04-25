Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B963E1B847C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Apr 2020 09:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgDYH5Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Apr 2020 03:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726098AbgDYH5Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Apr 2020 03:57:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988F3C09B049;
        Sat, 25 Apr 2020 00:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=fRRB7Hw/olceB/aYN2JO9ZS8o+tiMugLsMPr0vwHMzw=; b=QqBgQzau0psQY6V+7WQxpmy5PU
        ajsY2re2MDG11WgmEv5R8G0a/BioSP9tdlDLI5sebNGA3PM9o2nj5FW0KgMosAgCyAiNGLsZjJwWD
        5hP48gFZo+lE0VsiKSiXoHUc850adImMb5Iwh5HbRgHZqBvKx3zuz8dt8Imwq6SmRuAcGd4sAwBIZ
        KyXNjbQdtMS9p0ySeuQ2T8LeOV62SQY4USm+i0yhAhVWfVS1rnJLPiH9tu19PLXn54+6GPor1LTqp
        YQSqctE/qnFyktzPvKiO3VaQ46PTMuYg7o/NGIUPLdpPh+ujf1Ea3GWd4ux5Ygb1qIZMBlok+tpmV
        RA490WSg==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSFgX-00021r-EH; Sat, 25 Apr 2020 07:57:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 2/7] ide-cd: rename cdrom_read_tocentry
Date:   Sat, 25 Apr 2020 09:57:01 +0200
Message-Id: <20200425075706.721917-3-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200425075706.721917-1-hch@lst.de>
References: <20200425075706.721917-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Give the cdrom_read_tocentry function and ide_ prefix to not conflict
with the soon to be added generic function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/ide/ide-cd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 40e124eb918aa..7f17f83039888 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1034,8 +1034,8 @@ static int cdrom_read_capacity(ide_drive_t *drive, unsigned long *capacity,
 	return 0;
 }
 
-static int cdrom_read_tocentry(ide_drive_t *drive, int trackno, int msf_flag,
-				int format, char *buf, int buflen)
+static int ide_cdrom_read_tocentry(ide_drive_t *drive, int trackno,
+		int msf_flag, int format, char *buf, int buflen)
 {
 	unsigned char cmd[BLK_MAX_CDB];
 
@@ -1104,7 +1104,7 @@ int ide_cd_read_toc(ide_drive_t *drive)
 				     sectors_per_frame << SECTOR_SHIFT);
 
 	/* first read just the header, so we know how long the TOC is */
-	stat = cdrom_read_tocentry(drive, 0, 1, 0, (char *) &toc->hdr,
+	stat = ide_cdrom_read_tocentry(drive, 0, 1, 0, (char *) &toc->hdr,
 				    sizeof(struct atapi_toc_header));
 	if (stat)
 		return stat;
@@ -1121,7 +1121,7 @@ int ide_cd_read_toc(ide_drive_t *drive)
 		ntracks = MAX_TRACKS;
 
 	/* now read the whole schmeer */
-	stat = cdrom_read_tocentry(drive, toc->hdr.first_track, 1, 0,
+	stat = ide_cdrom_read_tocentry(drive, toc->hdr.first_track, 1, 0,
 				  (char *)&toc->hdr,
 				   sizeof(struct atapi_toc_header) +
 				   (ntracks + 1) *
@@ -1141,7 +1141,7 @@ int ide_cd_read_toc(ide_drive_t *drive)
 		 * Heiko Eißfeldt.
 		 */
 		ntracks = 0;
-		stat = cdrom_read_tocentry(drive, CDROM_LEADOUT, 1, 0,
+		stat = ide_cdrom_read_tocentry(drive, CDROM_LEADOUT, 1, 0,
 					   (char *)&toc->hdr,
 					   sizeof(struct atapi_toc_header) +
 					   (ntracks + 1) *
@@ -1181,7 +1181,7 @@ int ide_cd_read_toc(ide_drive_t *drive)
 
 	if (toc->hdr.first_track != CDROM_LEADOUT) {
 		/* read the multisession information */
-		stat = cdrom_read_tocentry(drive, 0, 0, 1, (char *)&ms_tmp,
+		stat = ide_cdrom_read_tocentry(drive, 0, 0, 1, (char *)&ms_tmp,
 					   sizeof(ms_tmp));
 		if (stat)
 			return stat;
@@ -1195,7 +1195,7 @@ int ide_cd_read_toc(ide_drive_t *drive)
 
 	if (drive->atapi_flags & IDE_AFLAG_TOCADDR_AS_BCD) {
 		/* re-read multisession information using MSF format */
-		stat = cdrom_read_tocentry(drive, 0, 1, 1, (char *)&ms_tmp,
+		stat = ide_cdrom_read_tocentry(drive, 0, 1, 1, (char *)&ms_tmp,
 					   sizeof(ms_tmp));
 		if (stat)
 			return stat;
-- 
2.26.1

