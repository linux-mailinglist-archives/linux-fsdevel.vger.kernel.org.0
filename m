Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A112116BDB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfLILJQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:09:16 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60028 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfLILJQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:09:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=p+wFX8QWQjxAfYcBJJUfwXYFWwf/JimsE63z6Ke748Y=; b=jkpE7Yl4WVIhy4epcudH0wRr2K
        JaN8U0Qcq/LqmTuHDE1e5nEwcDFFOJvRBz9L0pP/ICp++tIZeks8y2NVfbe6bIGXGFffi6zJ+fqjw
        Lyn1FWpVzAHuFGjm2QNJasISIJpMaNGbI8v86BjJNTdxaQxv/4VxYZoeufMIoJfrY8KPyBFJIcvxk
        fXk74eawONWvPuWo7f+4nsSIc2R/xS/9x/Am65pu/84ZgcjFJA9vAciW6KQiAht/esb+wXIg57Zye
        y0ba9uwPrcpE2vnsGy0uY70q01+HIXkefxUZUk0OKrgEeDEhE5kXzfXJD+CEs4Owhzw1WujjhF4Ws
        N4O+GCFg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54058 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGuY-0002Te-IA; Mon, 09 Dec 2019 11:09:06 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGuW-0004ah-SO; Mon, 09 Dec 2019 11:09:04 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/41] fs/adfs: map: fix map scanning
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGuW-0004ah-SO@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:09:04 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When scanning the map for a fragment id, we need to keep track of the
free space links, so we don't inadvertently believe that the freespace
link is a valid fragment id.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/map.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/adfs/map.c b/fs/adfs/map.c
index 82e1bf101fe6..a81de80c45c1 100644
--- a/fs/adfs/map.c
+++ b/fs/adfs/map.c
@@ -72,9 +72,12 @@ static int lookup_zone(const struct adfs_discmap *dm, const unsigned int idlen,
 	const u32 idmask = (1 << idlen) - 1;
 	unsigned char *map = dm->dm_bh->b_data;
 	unsigned int start = dm->dm_startbit;
-	unsigned int fragend;
+	unsigned int freelink, fragend;
 	u32 frag;
 
+	frag = GET_FRAG_ID(map, 8, idmask & 0x7fff);
+	freelink = frag ? 8 + frag : 0;
+
 	do {
 		frag = GET_FRAG_ID(map, start, idmask);
 
@@ -82,7 +85,9 @@ static int lookup_zone(const struct adfs_discmap *dm, const unsigned int idlen,
 		if (fragend >= endbit)
 			goto error;
 
-		if (frag == frag_id) {
+		if (start == freelink) {
+			freelink += frag & 0x7fff;
+		} else if (frag == frag_id) {
 			unsigned int length = fragend + 1 - start;
 
 			if (*offset < length)
-- 
2.20.1

