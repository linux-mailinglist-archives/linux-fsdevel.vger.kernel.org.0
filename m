Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB6A1116BFB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfLILKl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:10:41 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60158 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfLILKl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=07+kyVDc4mzwU/oiB0u0yB9/JjkfHObrta0s6Iw1gxo=; b=xnRrxSwbvyQkPIxuUpuNQIbMf5
        9z7cow6q/h0Y/MQBFX5axm5LK6NOpwEng5G16+P5H2XUSOrzKXlwNt7XsYapAGJLiiEa2yXoXoQb1
        kCx7Wxhu6FBvS+/3HtcPZxjBmEwQSm/unQKNKK7zHQ0rAEEJrfhBUbYxb5gDeUD6bJ1aWq7BFmbe2
        IhXFJnJNXhpr41aDcqPhTvqEVlnhbFY9i38GE5SbAhq2qz4Yr5WrSx8JcGTTXWg1k6LZk9nL6QV1O
        RmDmY29fbNdsUCypA+hJekcAYGAOCoc6YDMjLD5k9gVxCLURBqq3i+Rc7Dc2nyQek3PvbRN1P7/mp
        jOmRJmJw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:49852 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGw1-0002Wa-TA; Mon, 09 Dec 2019 11:10:37 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGw1-0004cz-Bh; Mon, 09 Dec 2019 11:10:37 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 28/41] fs/adfs: newdir: merge adfs_dir_read() into
 adfs_f_read()
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGw1-0004cz-Bh@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:10:37 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

adfs_dir_read() is only called from adfs_f_read(), so merge it into
that function.  As new directories are always 2048 bytes in size,
(which we rely on elsewhere) we can consolidate some of the code.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/dir_f.c | 33 +++++++--------------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/fs/adfs/dir_f.c b/fs/adfs/dir_f.c
index ebe8616ee533..dbb4f1ef7bb7 100644
--- a/fs/adfs/dir_f.c
+++ b/fs/adfs/dir_f.c
@@ -138,20 +138,16 @@ static int adfs_f_validate(struct adfs_dir *dir)
 }
 
 /* Read and check that a directory is valid */
-static int adfs_dir_read(struct super_block *sb, u32 indaddr,
-			 unsigned int size, struct adfs_dir *dir)
+static int adfs_f_read(struct super_block *sb, u32 indaddr, unsigned int size,
+		       struct adfs_dir *dir)
 {
 	const unsigned int blocksize_bits = sb->s_blocksize_bits;
 	int ret;
 
-	/*
-	 * Directories which are not a multiple of 2048 bytes
-	 * are considered bad v2 [3.6]
-	 */
-	if (size & 2047)
-		goto bad_dir;
+	if (size && size != ADFS_NEWDIR_SIZE)
+		return -EIO;
 
-	ret = adfs_dir_read_buffers(sb, indaddr, size, dir);
+	ret = adfs_dir_read_buffers(sb, indaddr, ADFS_NEWDIR_SIZE, dir);
 	if (ret)
 		return ret;
 
@@ -161,6 +157,8 @@ static int adfs_dir_read(struct super_block *sb, u32 indaddr,
 	if (adfs_f_validate(dir))
 		goto bad_dir;
 
+	dir->parent_id = adfs_readval(dir->newtail->dirparent, 3);
+
 	return 0;
 
 bad_dir:
@@ -271,23 +269,6 @@ static int adfs_dir_find_entry(struct adfs_dir *dir, u32 indaddr)
 	return ret;
 }
 
-static int adfs_f_read(struct super_block *sb, u32 indaddr, unsigned int size,
-		       struct adfs_dir *dir)
-{
-	int ret;
-
-	if (size != ADFS_NEWDIR_SIZE)
-		return -EIO;
-
-	ret = adfs_dir_read(sb, indaddr, size, dir);
-	if (ret)
-		adfs_error(sb, "unable to read directory");
-	else
-		dir->parent_id = adfs_readval(dir->newtail->dirparent, 3);
-
-	return ret;
-}
-
 static int
 adfs_f_setpos(struct adfs_dir *dir, unsigned int fpos)
 {
-- 
2.20.1

