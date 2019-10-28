Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAF1E6FA5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 11:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732880AbfJ1K2P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 06:28:15 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:36596 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727105AbfJ1K2P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 06:28:15 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 8D6062E0DC6;
        Mon, 28 Oct 2019 13:28:11 +0300 (MSK)
Received: from sas1-7fab0cd91cd2.qloud-c.yandex.net (sas1-7fab0cd91cd2.qloud-c.yandex.net [2a02:6b8:c14:3a93:0:640:7fab:cd9])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id mrHLwd9UoF-SA98rx4o;
        Mon, 28 Oct 2019 13:28:11 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572258491; bh=J7Z/eIGyReSbbdRl5mEG9aN+6qXvv1CCh1xb2jn2xu0=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=pbkbG+GaQE8Ixq2o3uBu8UY0Kx1WgoNyg8VSCOQolIWcTwAMgi3SyH9G9puMg2/7a
         jy4EnsVOEXnyvhTqDMOAtfeYQwI1rMUNDOUy8r8DyPvfnJoRDgPfdrr/1kP6dIS2e1
         iyhjkCcm7CWAd9RFZ60QhYvrmjL//8mbVoFIoaAo=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:148a:8f3:5b61:9f4])
        by sas1-7fab0cd91cd2.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id YKvcRXU12r-SAWGkupb;
        Mon, 28 Oct 2019 13:28:10 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH RFC] fs/fcntl: add fcntl F_GET_RSS
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
Date:   Mon, 28 Oct 2019 13:28:09 +0300
Message-ID: <157225848971.557.16257813537984792761.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This implements fcntl() for getting amount of resident memory in cache.
Kernel already maintains counter for each inode, this patch just exposes
it into userspace. Returned size is in kilobytes like values in procfs.

Alternatively this could be implemented via mapping file and collecting
map of cached pages with mincore(). Which is much slower and O(n*log n).

Syscall fincore() never was implemented in Linux.
This fcntl() covers one of its use-cases with minimal footprint.

Unlike to mincore() this fcntl counts all pages, including allocated but
not read yet (non-uptodate) and pages beyond end of file.

This employs same security model as mincore() and requires one of:
- file is opened for writing
- current user owns inode
- current user could open inode for writing

Usage:
resident_kb = fcntl(fd, F_GET_RSS);

Error codes:
-EINVAL		- not supported
-EPERM		- not writable / owner
-ENODATA	- special inode without cache

Notes:
Range of pages could be evicted from cache using POSIX_FADV_DONTNEED.
Populating with POSIX_FADV_WILLNEED is asynchronous and limited with
disk read_ahead_kb and max_sectors_kb. It seems most effective way to
read data into cache synchronously is a sendfile() into /dev/null.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 fs/fcntl.c                 |   30 ++++++++++++++++++++++++++++++
 include/uapi/linux/fcntl.h |    5 +++++
 2 files changed, 35 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 3d40771e8e7c..b241d3c925db 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -25,6 +25,8 @@
 #include <linux/user_namespace.h>
 #include <linux/memfd.h>
 #include <linux/compat.h>
+#include <linux/dax.h>
+#include <linux/hugetlb.h>
 
 #include <linux/poll.h>
 #include <asm/siginfo.h>
@@ -319,6 +321,31 @@ static long fcntl_rw_hint(struct file *file, unsigned int cmd,
 	}
 }
 
+static long fcntl_get_rss(struct file *filp)
+{
+	struct address_space *mapping = filp->f_mapping;
+	unsigned long pages;
+
+	if (!mapping)
+		return -ENODATA;
+
+	/* The same limitations as for sys_mincore() */
+	if (!(filp->f_mode & FMODE_WRITE) &&
+	    !inode_owner_or_capable(mapping->host) &&
+	    inode_permission(mapping->host, MAY_WRITE))
+		return -EPERM;
+
+	if (dax_mapping(mapping))
+		pages = READ_ONCE(mapping->nrexceptional);
+	else
+		pages = READ_ONCE(mapping->nrpages);
+
+	if (is_file_hugepages(filp))
+		pages <<= huge_page_order(hstate_file(filp));
+
+	return pages << (PAGE_SHIFT - 10);	/* page -> kb */
+}
+
 static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		struct file *filp)
 {
@@ -426,6 +453,9 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 	case F_SET_FILE_RW_HINT:
 		err = fcntl_rw_hint(filp, cmd, arg);
 		break;
+	case F_GET_RSS:
+		err = fcntl_get_rss(filp);
+		break;
 	default:
 		break;
 	}
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 1d338357df8a..d467f1dbfc67 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -54,6 +54,11 @@
 #define F_GET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 13)
 #define F_SET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 14)
 
+/*
+ * Get amount of resident memory in file cache in kilobytes.
+ */
+#define F_GET_RSS		(F_LINUX_SPECIFIC_BASE + 15)
+
 /*
  * Valid hint values for F_{GET,SET}_RW_HINT. 0 is "not set", or can be
  * used to clear any hints previously set.

