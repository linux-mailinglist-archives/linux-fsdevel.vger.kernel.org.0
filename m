Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B56E116BD7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfLILJC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:09:02 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60012 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfLILJB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:09:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=O8t+RI4lc5YSko84lAz/rN4UzLZr16U0eoEAtW32nV8=; b=G5+I/OElPM3q2uIP0wjH30RcmK
        90j+ixr2atxw/v79Ga+Aj2J7ZEhZ5gi9Y7JYRDlBGtOy5ZGSz9H6uLAJhsmoDrNsf05ZnJsxJBSnp
        134N5vqx+k/KsCsD0o+xAyvI5P1xKBqRTobGmGDHUu0+qAxrPjEiF8x4czJa0naW1uRySunIa/EBz
        2F2ZWEjGbddLHoYoQPse/Qmc9nTZnYXzpDUxEd+SdJOoBQeaPM9kUDfq7fBLgFgb/sHTDpMlDYVSd
        cpjQrDUkCy64BkpweKGy2/CXjWQct6N6CptVfnocry5XoGoSIwGOT7dza0np5MdKxuoyVqXTeXLkL
        3WsWhntg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:49810 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGuO-0002TI-05; Mon, 09 Dec 2019 11:08:56 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGuM-0004aS-Jz; Mon, 09 Dec 2019 11:08:54 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/41] fs/adfs: map: use find_next_bit_le() rather than open
 coding it
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGuM-0004aS-Jz@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:08:54 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use find_next_bit_le() to find the end of a fragment in the map rather
than open-coding this functionality.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/map.c | 76 ++++++++++++++-------------------------------------
 1 file changed, 21 insertions(+), 55 deletions(-)

diff --git a/fs/adfs/map.c b/fs/adfs/map.c
index 55bd7c20158c..9be0b47da19c 100644
--- a/fs/adfs/map.c
+++ b/fs/adfs/map.c
@@ -72,50 +72,32 @@ static int lookup_zone(const struct adfs_discmap *dm, const unsigned int idlen,
 	const u32 idmask = (1 << idlen) - 1;
 	unsigned char *map = dm->dm_bh->b_data;
 	unsigned int start = dm->dm_startbit;
-	unsigned int mapptr;
+	unsigned int fragend;
 	u32 frag;
 
 	do {
 		frag = GET_FRAG_ID(map, start, idmask);
-		mapptr = start + idlen;
-
-		/*
-		 * find end of fragment
-		 */
-		{
-			__le32 *_map = (__le32 *)map;
-			u32 v = le32_to_cpu(_map[mapptr >> 5]) >> (mapptr & 31);
-			while (v == 0) {
-				mapptr = (mapptr & ~31) + 32;
-				if (mapptr >= endbit)
-					goto error;
-				v = le32_to_cpu(_map[mapptr >> 5]);
-			}
-
-			mapptr += 1 + ffz(~v);
+
+		fragend = find_next_bit_le(map, endbit, start + idlen);
+		if (fragend >= endbit)
+			goto error;
+
+		if (frag == frag_id) {
+			unsigned int length = fragend + 1 - start;
+
+			if (*offset < length)
+				return start + *offset;
+			*offset -= length;
 		}
 
-		if (frag == frag_id)
-			goto found;
-again:
-		start = mapptr;
-	} while (mapptr < endbit);
+		start = fragend + 1;
+	} while (start < endbit);
 	return -1;
 
 error:
 	printk(KERN_ERR "adfs: oversized fragment 0x%x at 0x%x-0x%x\n",
-		frag, start, mapptr);
+		frag, start, fragend);
 	return -1;
-
-found:
-	{
-		int length = mapptr - start;
-		if (*offset >= length) {
-			*offset -= length;
-			goto again;
-		}
-	}
-	return start + *offset;
 }
 
 /*
@@ -132,7 +114,7 @@ scan_free_map(struct adfs_sb_info *asb, struct adfs_discmap *dm)
 	const unsigned int frag_idlen = idlen <= 15 ? idlen : 15;
 	const u32 idmask = (1 << frag_idlen) - 1;
 	unsigned char *map = dm->dm_bh->b_data;
-	unsigned int start = 8, mapptr;
+	unsigned int start = 8, fragend;
 	u32 frag;
 	unsigned long total = 0;
 
@@ -151,29 +133,13 @@ scan_free_map(struct adfs_sb_info *asb, struct adfs_discmap *dm)
 	do {
 		start += frag;
 
-		/*
-		 * get fragment id
-		 */
 		frag = GET_FRAG_ID(map, start, idmask);
-		mapptr = start + idlen;
-
-		/*
-		 * find end of fragment
-		 */
-		{
-			__le32 *_map = (__le32 *)map;
-			u32 v = le32_to_cpu(_map[mapptr >> 5]) >> (mapptr & 31);
-			while (v == 0) {
-				mapptr = (mapptr & ~31) + 32;
-				if (mapptr >= endbit)
-					goto error;
-				v = le32_to_cpu(_map[mapptr >> 5]);
-			}
-
-			mapptr += 1 + ffz(~v);
-		}
 
-		total += mapptr - start;
+		fragend = find_next_bit_le(map, endbit, start + idlen);
+		if (fragend >= endbit)
+			goto error;
+
+		total += fragend + 1 - start;
 	} while (frag >= idlen + 1);
 
 	if (frag != 0)
-- 
2.20.1

