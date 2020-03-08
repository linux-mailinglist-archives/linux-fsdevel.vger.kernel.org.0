Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9E117D0EC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Mar 2020 03:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgCHCk0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Mar 2020 21:40:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:35468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbgCHCk0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Mar 2020 21:40:26 -0500
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C19AC2070A;
        Sun,  8 Mar 2020 02:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583635226;
        bh=BPtvgaMeJv/7+wbzTP9+Rt7/Uf1D7JLT0hjpTXsJ53Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w9g/UFgDcfUEx8nRARyA6ndQRVnHUX3u6hozDBqtWlc249Q8kAfovksCNVMk+PPFk
         hiq3st+xKpSXbsnz9lkZyzENnRsOSD+OaWcHO2CWNd4oA61YdmfIqRaUTFqN/+vo+0
         mC3b3GtebYk6N2/2tou71NgklaZ8dN9Uf67fLbUQ=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     glider@google.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzbot+fcab69d1ada3e8d6f06b@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: [PATCH] libfs: fix infoleak in simple_attr_read()
Date:   Sat,  7 Mar 2020 18:38:49 -0800
Message-Id: <20200308023849.988264-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAG_fn=WvVp7Nxm5E+1dYs4guMYUV8D1XZEt_AZFF6rAQEbbAeg@mail.gmail.com>
References: <CAG_fn=WvVp7Nxm5E+1dYs4guMYUV8D1XZEt_AZFF6rAQEbbAeg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Reading from a debugfs file at a nonzero position, without first reading
at position 0, leaks uninitialized memory to userspace.

It's a bit tricky to do this, since lseek() and pread() aren't allowed
on these files, and write() doesn't update the position on them.  But
writing to them with splice() *does* update the position:

	#define _GNU_SOURCE 1
	#include <fcntl.h>
	#include <stdio.h>
	#include <unistd.h>
	int main()
	{
		int pipes[2], fd, n, i;
		char buf[32];

		pipe(pipes);
		write(pipes[1], "0", 1);
		fd = open("/sys/kernel/debug/fault_around_bytes", O_RDWR);
		splice(pipes[0], NULL, fd, NULL, 1, 0);
		n = read(fd, buf, sizeof(buf));
		for (i = 0; i < n; i++)
			printf("%02x", buf[i]);
		printf("\n");
	}

Output:
	5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a30

Fix the infoleak by making simple_attr_read() always fill
simple_attr::get_buf if it hasn't been filled yet.

Reported-by: syzbot+fcab69d1ada3e8d6f06b@syzkaller.appspotmail.com
Reported-by: Alexander Potapenko <glider@google.com>
Fixes: acaefc25d21f ("[PATCH] libfs: add simple attribute files")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/libfs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index c686bd9caac6..3759fbacf522 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -891,7 +891,7 @@ int simple_attr_open(struct inode *inode, struct file *file,
 {
 	struct simple_attr *attr;
 
-	attr = kmalloc(sizeof(*attr), GFP_KERNEL);
+	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
 	if (!attr)
 		return -ENOMEM;
 
@@ -931,9 +931,11 @@ ssize_t simple_attr_read(struct file *file, char __user *buf,
 	if (ret)
 		return ret;
 
-	if (*ppos) {		/* continued read */
+	if (*ppos && attr->get_buf[0]) {
+		/* continued read */
 		size = strlen(attr->get_buf);
-	} else {		/* first read */
+	} else {
+		/* first read */
 		u64 val;
 		ret = attr->get(attr->data, &val);
 		if (ret)
-- 
2.25.1

