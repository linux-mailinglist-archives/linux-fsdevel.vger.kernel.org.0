Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2AEF810A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 21:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfKKUWD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 15:22:03 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:35595 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfKKUWC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:22:02 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MhUHt-1hzcGS466d-00eYkO; Mon, 11 Nov 2019 21:16:48 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH 05/19] nfs: fscache: use timespec64 in inode auxdata
Date:   Mon, 11 Nov 2019 21:16:25 +0100
Message-Id: <20191111201639.2240623-6-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191111201639.2240623-1-arnd@arndb.de>
References: <20191111201639.2240623-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:R85AnppbPpRbASBN+qeQQkooI5x2H4Dl4b39qnIy/84P06Psutx
 1UgpJewoA+26kC3RGAFzMl4tr537CnsdCYpMzZpqaquzBmda48YFiq1sp4JBpKVAm/6hG6B
 T+xjyEzQBA78TjjLjPu3UkZokiY0Cf7wC2JTPJNzmWhI28vtCMwD+TomKV1+kSoNGHlQIcf
 llNfgK00g8glajmY6FJtQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2/4Mf+qV6d4=:n2dwiOweaOHyBIYwZrNd0B
 lW+2gm7GVpKURbp6YNWNUA8VTknHJ7ALNzPgpoTOVu3r7Wg9S4I2Px9rDC0QfF/SE6EldpIbo
 CJvNUVX4ltU9rErfId/9EY8HKSvEbnHWwVCcgoYgoy7DdMtkFEdFWxilBJ/c+l8gONahbmerQ
 NPrmWqfZaBHWY2ycepLz/G1MTFalmgp6VtSk1amgbw6cfSazCx8AcUTgP7clC8QxDpivYDRM6
 5hDAlsr95+SXafhF3L+ZtPOYHciUXr/wd0TtVLLoueMzlW8J40VLmIei6wh9vIRFeoG7PTSyx
 om8Pt1ty7SX7kPnFDeyYDCSaRvtp2Th7OpO+M3/NWeY5XIsb5QhIn+o3dN3chTD+MVn0hRc+8
 ycsqCJ4xnF2NqOZveetUawN2/rU++A8EOC9F/533Pg8Ir1E9mnjdEPRdibWtZZ2al+62ZeYZ1
 t4Zg5Qkf1sanO5G9h5hs50/zPeEBQNTMPwULx+ZP1G2rXdGnxjwWbt9cFvsoopQCWC3OwGnhA
 n8PG53tvIf4XHMKpR3afjThw8ETdOcVTfvrvT5j2cUpHh8naebWzhaHxG0gcx5EL4ywuefUk1
 w1oLs1mq+UMkGKyosBlEm42IR6lrxD892zI02mL7Z11qJv3WlVglJmFBQUUWnwxNeQKB9+tu7
 mDYTgpW6KIE2/+MiHdC2zc8mp+57bcTONSgqdwte/taLeXcMtMUJBeyG/5adgslOhg20m+WA6
 +UVgE5D+RV6VMrgvrNiK6Va91JEr2RFCCzUHq3c0GSD0davk251oOKxp+LbLeFau6k25cOiy1
 QqkTYcHcnHIPNrWY3eF8pxvBR7bOs+mw7UrSQfKwSxMsGHsq6vSw+/t5Sg8i8YDO7R4S3fSr4
 +mKI+XhmaPHChuLJPLhg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

nfs currently behaves differently on 32-bit and 64-bit kernels regarding
the on-disk format of nfs_fscache_inode_auxdata.

That format should really be the same on any kernel, and we should avoid
the 'timespec' type in order to remove that from the kernel later on.

Using plain 'timespec64' would not be good here, since that includes
implied padding and would possibly leak kernel stack data to the on-disk
format on 32-bit architectures.

struct __kernel_timespec would work as a replacement, but open-coding
the two struct members in nfs_fscache_inode_auxdata makes it more
obvious what's going on here, and keeps the current format for 64-bit
architectures.

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nfs/fscache-index.c |  6 ++++--
 fs/nfs/fscache.c       | 18 ++++++++++++------
 fs/nfs/fscache.h       |  8 +++++---
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/fscache-index.c b/fs/nfs/fscache-index.c
index 15f271401dcc..573b1da9342c 100644
--- a/fs/nfs/fscache-index.c
+++ b/fs/nfs/fscache-index.c
@@ -84,8 +84,10 @@ enum fscache_checkaux nfs_fscache_inode_check_aux(void *cookie_netfs_data,
 		return FSCACHE_CHECKAUX_OBSOLETE;
 
 	memset(&auxdata, 0, sizeof(auxdata));
-	auxdata.mtime = timespec64_to_timespec(nfsi->vfs_inode.i_mtime);
-	auxdata.ctime = timespec64_to_timespec(nfsi->vfs_inode.i_ctime);
+	auxdata.mtime_sec  = nfsi->vfs_inode.i_mtime.tv_sec;
+	auxdata.mtime_nsec = nfsi->vfs_inode.i_mtime.tv_nsec;
+	auxdata.ctime_sec  = nfsi->vfs_inode.i_ctime.tv_sec;
+	auxdata.ctime_nsec = nfsi->vfs_inode.i_ctime.tv_nsec;
 
 	if (NFS_SERVER(&nfsi->vfs_inode)->nfs_client->rpc_ops->version == 4)
 		auxdata.change_attr = inode_peek_iversion_raw(&nfsi->vfs_inode);
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 3800ab6f08fa..7def925d3af5 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -238,8 +238,10 @@ void nfs_fscache_init_inode(struct inode *inode)
 		return;
 
 	memset(&auxdata, 0, sizeof(auxdata));
-	auxdata.mtime = timespec64_to_timespec(nfsi->vfs_inode.i_mtime);
-	auxdata.ctime = timespec64_to_timespec(nfsi->vfs_inode.i_ctime);
+	auxdata.mtime_sec  = nfsi->vfs_inode.i_mtime.tv_sec;
+	auxdata.mtime_nsec = nfsi->vfs_inode.i_mtime.tv_nsec;
+	auxdata.ctime_sec  = nfsi->vfs_inode.i_ctime.tv_sec;
+	auxdata.ctime_nsec = nfsi->vfs_inode.i_ctime.tv_nsec;
 
 	if (NFS_SERVER(&nfsi->vfs_inode)->nfs_client->rpc_ops->version == 4)
 		auxdata.change_attr = inode_peek_iversion_raw(&nfsi->vfs_inode);
@@ -263,8 +265,10 @@ void nfs_fscache_clear_inode(struct inode *inode)
 	dfprintk(FSCACHE, "NFS: clear cookie (0x%p/0x%p)\n", nfsi, cookie);
 
 	memset(&auxdata, 0, sizeof(auxdata));
-	auxdata.mtime = timespec64_to_timespec(nfsi->vfs_inode.i_mtime);
-	auxdata.ctime = timespec64_to_timespec(nfsi->vfs_inode.i_ctime);
+	auxdata.mtime_sec  = nfsi->vfs_inode.i_mtime.tv_sec;
+	auxdata.mtime_nsec = nfsi->vfs_inode.i_mtime.tv_nsec;
+	auxdata.ctime_sec  = nfsi->vfs_inode.i_ctime.tv_sec;
+	auxdata.ctime_nsec = nfsi->vfs_inode.i_ctime.tv_nsec;
 	fscache_relinquish_cookie(cookie, &auxdata, false);
 	nfsi->fscache = NULL;
 }
@@ -305,8 +309,10 @@ void nfs_fscache_open_file(struct inode *inode, struct file *filp)
 		return;
 
 	memset(&auxdata, 0, sizeof(auxdata));
-	auxdata.mtime = timespec64_to_timespec(nfsi->vfs_inode.i_mtime);
-	auxdata.ctime = timespec64_to_timespec(nfsi->vfs_inode.i_ctime);
+	auxdata.mtime_sec  = nfsi->vfs_inode.i_mtime.tv_sec;
+	auxdata.mtime_nsec = nfsi->vfs_inode.i_mtime.tv_nsec;
+	auxdata.ctime_sec  = nfsi->vfs_inode.i_ctime.tv_sec;
+	auxdata.ctime_nsec = nfsi->vfs_inode.i_ctime.tv_nsec;
 
 	if (inode_is_open_for_write(inode)) {
 		dfprintk(FSCACHE, "NFS: nfsi 0x%p disabling cache\n", nfsi);
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index ad041cfbf9ec..6754c8607230 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -62,9 +62,11 @@ struct nfs_fscache_key {
  * cache object.
  */
 struct nfs_fscache_inode_auxdata {
-	struct timespec	mtime;
-	struct timespec	ctime;
-	u64		change_attr;
+	s64	mtime_sec;
+	s64	mtime_nsec;
+	s64	ctime_sec;
+	s64	ctime_nsec;
+	u64	change_attr;
 };
 
 /*
-- 
2.20.0

