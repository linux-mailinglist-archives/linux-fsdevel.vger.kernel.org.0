Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 681D6116BF2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfLILKA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:10:00 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60098 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbfLILKA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:10:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+qYfN3gc3R2uCzRI2SpU+d0frycyBslJxPxssLLa4zk=; b=KEoPttLHq/nimi36ew73B1pRzB
        u2mSrHKsx1UtphBGbPRZeM9ZBYfmmR1oGzS5VMRLXlHCS4I0s3As1sg7zAQnLErvX9kbs8yu9XmH/
        LlMAMvRAidT5hKNEtYgnGSUE3mE/y16EkgDhDIM1czSplf5BETlri/nP89Cq79zNfsnL5gZl6ejzY
        +uIfgU3lXk+knvlxlCo95+o04AUzf0UBLZyCMhphYjQLvyPnVYiSyOw4IhhPMX1cSidduAEqMtlU0
        cge6pgOxS5Hi8qW2esD3ONeGV6+if0XK2AzwwcIzSMbXb0CboDfgiXr4ECXBO3qBdxKVXS/10Ob90
        OyXp8g6w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54078 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGvM-0002VJ-Pa; Mon, 09 Dec 2019 11:09:56 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGvM-0004br-7a; Mon, 09 Dec 2019 11:09:56 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 20/41] fs/adfs: dir: modernise on-disk directory structures
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGvM-0004br-7a@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:09:56 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use __u8 and pack the structures for on-disk directories.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/dir_f.h     | 52 ++++++++++++++++++++++++---------------------
 fs/adfs/dir_fplus.h |  6 +++---
 2 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/fs/adfs/dir_f.h b/fs/adfs/dir_f.h
index 5aec332b90f5..a5393e6cf9f4 100644
--- a/fs/adfs/dir_f.h
+++ b/fs/adfs/dir_f.h
@@ -13,9 +13,9 @@
  * Directory header
  */
 struct adfs_dirheader {
-	unsigned char startmasseq;
-	unsigned char startname[4];
-};
+	__u8 startmasseq;
+	__u8 startname[4];
+} __attribute__((packed));
 
 #define ADFS_NEWDIR_SIZE	2048
 #define ADFS_NUM_DIR_ENTRIES	77
@@ -31,32 +31,36 @@ struct adfs_direntry {
 	__u8 dirlen[4];
 	__u8 dirinddiscadd[3];
 	__u8 newdiratts;
-};
+} __attribute__((packed));
 
 /*
  * Directory tail
  */
+struct adfs_olddirtail {
+	__u8 dirlastmask;
+	char dirname[10];
+	__u8 dirparent[3];
+	char dirtitle[19];
+	__u8 reserved[14];
+	__u8 endmasseq;
+	__u8 endname[4];
+	__u8 dircheckbyte;
+} __attribute__((packed));
+
+struct adfs_newdirtail {
+	__u8 dirlastmask;
+	__u8 reserved[2];
+	__u8 dirparent[3];
+	char dirtitle[19];
+	char dirname[10];
+	__u8 endmasseq;
+	__u8 endname[4];
+	__u8 dircheckbyte;
+} __attribute__((packed));
+
 union adfs_dirtail {
-	struct {
-		unsigned char dirlastmask;
-		char dirname[10];
-		unsigned char dirparent[3];
-		char dirtitle[19];
-		unsigned char reserved[14];
-		unsigned char endmasseq;
-		unsigned char endname[4];
-		unsigned char dircheckbyte;
-	} old;
-	struct {
-		unsigned char dirlastmask;
-		unsigned char reserved[2];
-		unsigned char dirparent[3];
-		char dirtitle[19];
-		char dirname[10];
-		unsigned char endmasseq;
-		unsigned char endname[4];
-		unsigned char dircheckbyte;
-	} new;
+	struct adfs_olddirtail old;
+	struct adfs_newdirtail new;
 };
 
 #endif
diff --git a/fs/adfs/dir_fplus.h b/fs/adfs/dir_fplus.h
index 4ec0931e36ad..d729b1591e5e 100644
--- a/fs/adfs/dir_fplus.h
+++ b/fs/adfs/dir_fplus.h
@@ -22,7 +22,7 @@ struct adfs_bigdirheader {
 	__le32	bigdirnamesize;
 	__le32	bigdirparent;
 	char	bigdirname[1];
-};
+} __attribute__((packed, aligned(4)));
 
 struct adfs_bigdirentry {
 	__le32	bigdirload;
@@ -32,11 +32,11 @@ struct adfs_bigdirentry {
 	__le32	bigdirattr;
 	__le32	bigdirobnamelen;
 	__le32	bigdirobnameptr;
-};
+} __attribute__((packed, aligned(4)));
 
 struct adfs_bigdirtail {
 	__le32	bigdirendname;
 	__u8	bigdirendmasseq;
 	__u8	reserved[2];
 	__u8	bigdircheckbyte;
-};
+} __attribute__((packed, aligned(4)));
-- 
2.20.1

