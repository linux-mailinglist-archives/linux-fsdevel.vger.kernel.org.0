Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C912116C01
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfLILLJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:11:09 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60192 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfLILLJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lYPWUgqBB4KKYF3mmEgjo7KJpyy6rrOe52G7yz5/GkI=; b=FCSTesUev5GPtuBGah4l5LBKZB
        sgZbZVruJGcWw01tDoJD3QfzTfN80ilYbPCowqN8aZ4eE476EPuMapKRcoG7G0gV5ceBxQDN9SrcC
        ze+zIQQAu76IzQHFrPyC0lHjg/EgIXC6TCbfOXrKMLQIHmUG01Y7b3N7eRt6Oprso9V8ymAWUms6r
        f62rAsjn71XQp2GFxsMQt5B5TpEwfJUFT2FrmfLAb5FgLmyOHFCmdPElfHAZfHzxlA/yERyMatDvl
        kt5N2mQ0KMlHT28qcq4znTDaIA/EZ2nEfboG7c1MdYiPqZRkcodKeG6Ng9nxDcmWG0AwYiXkqScqr
        tMrokK4A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54104 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGwR-0002XF-Pg; Mon, 09 Dec 2019 11:11:03 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGwQ-0004dc-UK; Mon, 09 Dec 2019 11:11:02 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 33/41] fs/adfs: bigdir: directory validation strengthening
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGwQ-0004dc-UK@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:11:02 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Strengthen the directory validation by ensuring that the header fields
contain sensible values that fit inside the directory, and limit the
directory size to 4MB as per RISC OS requirements.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/dir_fplus.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index b83a74e9ff6d..a2fa416fbb6d 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -19,11 +19,38 @@ static unsigned int adfs_fplus_offset(const struct adfs_bigdirheader *h,
 static int adfs_fplus_validate_header(const struct adfs_bigdirheader *h)
 {
 	unsigned int size = le32_to_cpu(h->bigdirsize);
+	unsigned int len;
 
 	if (h->bigdirversion[0] != 0 || h->bigdirversion[1] != 0 ||
 	    h->bigdirversion[2] != 0 ||
 	    h->bigdirstartname != cpu_to_le32(BIGDIRSTARTNAME) ||
-	    size & 2047)
+	    !size || size & 2047 || size > SZ_4M)
+		return -EIO;
+
+	size -= sizeof(struct adfs_bigdirtail) +
+		offsetof(struct adfs_bigdirheader, bigdirname);
+
+	/* Check that bigdirnamelen fits within the directory */
+	len = ALIGN(le32_to_cpu(h->bigdirnamelen), 4);
+	if (len > size)
+		return -EIO;
+
+	size -= len;
+
+	/* Check that bigdirnamesize fits within the directory */
+	len = le32_to_cpu(h->bigdirnamesize);
+	if (len > size)
+		return -EIO;
+
+	size -= len;
+
+	/*
+	 * Avoid division, we know that absolute maximum number of entries
+	 * can not be so large to cause overflow of the multiplication below.
+	 */
+	len = le32_to_cpu(h->bigdirentries);
+	if (len > SZ_4M / sizeof(struct adfs_bigdirentry) ||
+	    len * sizeof(struct adfs_bigdirentry) > size)
 		return -EIO;
 
 	return 0;
-- 
2.20.1

