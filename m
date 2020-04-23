Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BDA1B555A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 09:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgDWHPF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 03:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgDWHPD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:15:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05F9C08C5F2;
        Thu, 23 Apr 2020 00:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=pVfzOqYHU5JU1YOfTs8v0Ll0TIqB5Hqqb6N6/6zrKBE=; b=WGzxE2p2lq93RMCLAz2RmqCzpo
        YKBJag0vWPLwjQPlpKNU9ch3wT5kJX+yWbwU0TVSwNNlxtYQT/7LSlqOtYCjHOobLHwQiajfOeB3n
        t2Pvc13Fd1xsFnzrdI7Ien5+BVZsNFLVSItM6qfrmUwJE991/KjW/DzKT+g60zrtbVetHelU5Fml+
        AiFdL6WfBXtinIfd5H1CZ/N73ik3DaigugYdC0hq8Tbu9vI0VNI12qMb0wTwOXFmMMv3sFa47Hjeo
        3Vrrf3KUFrsXAz1cGNrt0Cl1/gB2kNSGge4G4uymWPZPbyTD/aQSPQXsqPJSQavpjWzSrafauYtDa
        CK+v+E1g==;
Received: from [2001:4bb8:188:40ac:46e:e5e4:1e64:2584] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRW4J-0008T2-Hs; Thu, 23 Apr 2020 07:14:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] ide-cd: rename cdrom_read_tocentry
Date:   Thu, 23 Apr 2020 09:12:19 +0200
Message-Id: <20200423071224.500849-3-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200423071224.500849-1-hch@lst.de>
References: <20200423071224.500849-1-hch@lst.de>
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
---
 drivers/ide/ide-cd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 40e124eb918a..7f17f8303988 100644
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

