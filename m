Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD0A116BC5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfLILIW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:08:22 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:59960 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfLILIW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:08:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5Ey/dQ/ecawyVfi/tl4x2NTBYjTzoJw4/FMIRDec+z4=; b=gRszekqOVUbAnS9LLXRFzXU1Cm
        QLo1NDYlxW7u9PcVd6t7AjipwmhBAsF7+NiqQwaW4BDyysvSxSHq0wXa107KUGNIj+ZpUvZ5cmNTU
        pgCiZOdE24HZQF4wRf+Zm2UmLa0/ssigZn9UEeoHa1F+CT41salay3abuYXMVeTIgMl/pmWoOOyqM
        1yI8ocbSCrPPkfVqZfJPPp4IuJidYXPrprFYEUMV1jnwPOf9AyE7NVEgs05uU4yFvPgQ/biWYH5AU
        Di2nO5vqV/xsjOBgWzMq0hV48eaHXVb6bz4CdDfYQMXPF7WpVcwKoAR73gCqNkA6VZt4mvGRKjfSc
        dIIi3OfA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:37608 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGtn-0002ST-5e; Mon, 09 Dec 2019 11:08:19 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGtm-0004ZY-DD; Mon, 09 Dec 2019 11:08:18 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/41] fs/adfs: inode: update timestamps to centisecond
 precision
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGtm-0004ZY-DD@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:08:18 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Despite ADFS timestamps having centi-second granularity, and Linux
gaining fine-grained timestamp support in v2.5.48, fs/adfs was never
updated.

Update fs/adfs to centi-second support, and ensure that the inode ctime
always reflects what is written in underlying media.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/inode.c | 40 ++++++++++++++++++++--------------------
 fs/adfs/super.c |  2 ++
 2 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
index 124de75413a5..18a1d478669b 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -158,6 +158,8 @@ adfs_mode2atts(struct super_block *sb, struct inode *inode)
 	return attr;
 }
 
+static const s64 nsec_unix_epoch_diff_risc_os_epoch = 2208988800000000000LL;
+
 /*
  * Convert an ADFS time to Unix time.  ADFS has a 40-bit centi-second time
  * referenced to 1 Jan 1900 (til 2248) so we need to discard 2208988800 seconds
@@ -170,8 +172,6 @@ adfs_adfs2unix_time(struct timespec64 *tv, struct inode *inode)
 	/* 01 Jan 1970 00:00:00 (Unix epoch) as nanoseconds since
 	 * 01 Jan 1900 00:00:00 (RISC OS epoch)
 	 */
-	static const s64 nsec_unix_epoch_diff_risc_os_epoch =
-							2208988800000000000LL;
 	s64 nsec;
 
 	if (!adfs_inode_is_stamped(inode))
@@ -204,24 +204,23 @@ adfs_adfs2unix_time(struct timespec64 *tv, struct inode *inode)
 	return;
 }
 
-/*
- * Convert an Unix time to ADFS time.  We only do this if the entry has a
- * time/date stamp already.
- */
-static void
-adfs_unix2adfs_time(struct inode *inode, unsigned int secs)
+/* Convert an Unix time to ADFS time for an entry that is already stamped. */
+static void adfs_unix2adfs_time(struct inode *inode,
+				const struct timespec64 *ts)
 {
-	unsigned int high, low;
+	s64 cs, nsec = timespec64_to_ns(ts);
 
-	if (adfs_inode_is_stamped(inode)) {
-		/* convert 32-bit seconds to 40-bit centi-seconds */
-		low  = (secs & 255) * 100;
-		high = (secs / 256) * 100 + (low >> 8) + 0x336e996a;
+	/* convert from Unix to RISC OS epoch */
+	nsec += nsec_unix_epoch_diff_risc_os_epoch;
 
-		ADFS_I(inode)->loadaddr = (high >> 24) |
-				(ADFS_I(inode)->loadaddr & ~0xff);
-		ADFS_I(inode)->execaddr = (low & 255) | (high << 8);
-	}
+	/* convert from nanoseconds to centiseconds */
+	cs = div_s64(nsec, 10000000);
+
+	cs = clamp_t(s64, cs, 0, 0xffffffffff);
+
+	ADFS_I(inode)->loadaddr &= ~0xff;
+	ADFS_I(inode)->loadaddr |= (cs >> 32) & 0xff;
+	ADFS_I(inode)->execaddr = cs;
 }
 
 /*
@@ -315,10 +314,11 @@ adfs_notify_change(struct dentry *dentry, struct iattr *attr)
 	if (ia_valid & ATTR_SIZE)
 		truncate_setsize(inode, attr->ia_size);
 
-	if (ia_valid & ATTR_MTIME) {
-		inode->i_mtime = attr->ia_mtime;
-		adfs_unix2adfs_time(inode, attr->ia_mtime.tv_sec);
+	if (ia_valid & ATTR_MTIME && adfs_inode_is_stamped(inode)) {
+		adfs_unix2adfs_time(inode, &attr->ia_mtime);
+		adfs_adfs2unix_time(&inode->i_mtime, inode);
 	}
+
 	/*
 	 * FIXME: should we make these == to i_mtime since we don't
 	 * have the ability to represent them in our filesystem?
diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index 65b04ebb51c3..e0eea9adb4e6 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -391,7 +391,9 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 	asb = kzalloc(sizeof(*asb), GFP_KERNEL);
 	if (!asb)
 		return -ENOMEM;
+
 	sb->s_fs_info = asb;
+	sb->s_time_gran = 10000000;
 
 	/* set default options */
 	asb->s_uid = GLOBAL_ROOT_UID;
-- 
2.20.1

