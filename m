Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 844A434964
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 15:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfFDNuY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jun 2019 09:50:24 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40290 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbfFDNuY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1yWYT1Y/ckH+k43bQ1v4b7iLFaDZZhISrsC3Aa8KvVk=; b=PvlpKYyzsjjq+dU1HV4cCmBhlG
        mzWBdzPV3xr6SSjCj7gA5wL+JiJ7pX2w4SBF+0NNrWuGvAneH/e6lR20AomUoFVmFd/fyJ2xy3xFX
        Xw+SyEHCyqJ3g1YOqvtWqg16ygJqU7KCpF7evZASPbA/HOKvz8wrrLoum5WHnr3dbS+lG+ZXt76bS
        6PeTPAsq0pT2G/iS7wgEVpeodfhFDAV+RAPJpILrofRgHOO1sWjGjk7AqWzkSAJLFhuDpxFq0dbDE
        NRiN0y+JfBGPkL+nnIT3WctYG8tcc6mK/lsRMr1EC43fXbNccBwppW7PccDs2ZLgA3qsTWPnbv1vh
        GvhgV5Lw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:34838 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hY9pT-0001cE-Tr; Tue, 04 Jun 2019 14:50:19 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hY9pT-00085Y-Bk; Tue, 04 Jun 2019 14:50:19 +0100
In-Reply-To: <20190604111943.GA15281@rmk-PC.armlinux.org.uk>
References: <20190604111943.GA15281@rmk-PC.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/12] fs/adfs: super: limit idlen according to directory type
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1hY9pT-00085Y-Bk@rmk-PC.armlinux.org.uk>
Date:   Tue, 04 Jun 2019 14:50:19 +0100
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Limit idlen according to the directory type, as idlen (the size of a
fragment ID) can not be more than 16 with the "new directory" layout.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/super.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index c370b8618469..4529f53b1708 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -54,6 +54,7 @@ void adfs_msg(struct super_block *sb, const char *pfx, const char *fmt, ...)
 
 static int adfs_checkdiscrecord(struct adfs_discrecord *dr)
 {
+	unsigned int max_idlen;
 	int i;
 
 	/* sector size must be 256, 512 or 1024 bytes */
@@ -73,8 +74,13 @@ static int adfs_checkdiscrecord(struct adfs_discrecord *dr)
 	if (le32_to_cpu(dr->disc_size_high) >> dr->log2secsize)
 		return 1;
 
-	/* idlen must be no greater than 19 v2 [1.0] */
-	if (dr->idlen > 19)
+	/*
+	 * Maximum idlen is limited to 16 bits for new directories by
+	 * the three-byte storage of an indirect disc address.  For
+	 * big directories, idlen must be no greater than 19 v2 [1.0]
+	 */
+	max_idlen = dr->format_version ? 19 : 16;
+	if (dr->idlen > max_idlen)
 		return 1;
 
 	/* reserved bytes should be zero */
-- 
2.7.4

