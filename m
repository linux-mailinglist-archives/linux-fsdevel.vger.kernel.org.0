Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC4CF811F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 21:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfKKUV7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 15:21:59 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:37069 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfKKUV7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:21:59 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M3DFj-1iStbG1rY5-003bdi; Mon, 11 Nov 2019 21:16:47 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 04/19] nfs: callback: use timespec64 in cb_getattrres
Date:   Mon, 11 Nov 2019 21:16:24 +0100
Message-Id: <20191111201639.2240623-5-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191111201639.2240623-1-arnd@arndb.de>
References: <20191111201639.2240623-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KWYyInVBUVuj//LzWFbXW2jcS7+5FTXV3dKVlBIHKk1L18WZled
 7C3tZe/xX+O/9EMFYukOjVwOsPlCnHzCiYNH4glxd86c+Ov99enjaCjXGhJe+FG5h9878Jh
 qoAKEUCaNqnuToo37uYLLqhhgga4HRmi/8gaidBeQFst7aaYFBdi8OiC+uidAOCuK1FEDC2
 Zg8whbTLZiKS5Pv0t3A/A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6JTjadtS4S4=:RpCZNcIkzsq0/oqcUn9z9o
 BK7x0h11eGMyUUW2CZDKK4vMwxFNZeBbfStAzocF9OMM12o4NGObOWCZDhKxiPyUyHMQ9Y8jd
 aMH7pJnBmLqxe39j6+OHfGKyjcCwkaNjMtFPB0fKF7o70u94XKK7JRrLtRaeLMSnRiZHulWMi
 1QjJCXvyYIL4Bs+4PtLRWJl64uLIsQKtzbaLO4OUIZ1psMRGsJObrjtAH5HzKF1P81s7e2I3D
 nshvpjQS+5TrnUsNYzFEMF1ezf/NMeb3yVaA3h1SOvj/4Ffg1mJKcV8lwRSDa28ESk6V/rxSn
 9/dhiHSXH1k2ax7vwQgvZVUX38hIH4/vI0TPB3oO+0gFkXm3m82SprbcD2MWt3D9Jp62wycfP
 NXt8rOuqXcSjeTh8RNxjZjFFGcCCA2oti4iG1r6MUEprMcb/0Hy4yVJLJZn+nqDV08wXn7VPS
 W4v0NCHpFWFE9ThZ1PSYNI+h0EE/lzljpbFynfgBlVma8pGoYwTc9NWO+TPfQWr6n4Acl5KnQ
 9GUyKYRTOnZj6YLNpUkW6KihWbe6Gp1f9N8vP5SXKHuKoVJYRNxwehWZLS+HcIY0CaL9Iq8Pe
 1hqQpAvkNgkPhdTfUGjT8XTcAZOfbOc1x0KPCF2E+GbrrM8b4rfd3tDSwu/qtzrIIE90h4zk1
 E2gCZc+IVbnVjvXGq961uoffpBe6148zvpb4RPrMDx2RatWufLIRiYthhEZO3y9FPXwFV3A7E
 LUaYjOAkQV51mq6of1Q7JC5HNJ22wiQ+rvDHfaRFOVGCmOtktJpqrCrUyKk3iBScPQe9+9Y+8
 zIg1clgKST1iUaFvj/2ewDGl1sdlmSOQ37bRqUQ1wdYXBOKfhmuRnIl6zDejzPbnPCtuwkbmX
 H4DHvRimHDUkukdJskiQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make this use 64-bit timestamps to not lose information on 32-bit
architectures. As both the input and the ouput are 64-bit wide,
this is the obvious step.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nfs/callback.h      | 4 ++--
 fs/nfs/callback_proc.c | 4 ++--
 fs/nfs/callback_xdr.c  | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/callback.h b/fs/nfs/callback.h
index 8f34daf85f70..549350259840 100644
--- a/fs/nfs/callback.h
+++ b/fs/nfs/callback.h
@@ -72,8 +72,8 @@ struct cb_getattrres {
 	uint32_t bitmap[2];
 	uint64_t size;
 	uint64_t change_attr;
-	struct timespec ctime;
-	struct timespec mtime;
+	struct timespec64 ctime;
+	struct timespec64 mtime;
 };
 
 struct cb_recallargs {
diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index f39924ba050b..db3e7771e597 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -56,8 +56,8 @@ __be32 nfs4_callback_getattr(void *argp, void *resp,
 	res->change_attr = delegation->change_attr;
 	if (nfs_have_writebacks(inode))
 		res->change_attr++;
-	res->ctime = timespec64_to_timespec(inode->i_ctime);
-	res->mtime = timespec64_to_timespec(inode->i_mtime);
+	res->ctime = inode->i_ctime;
+	res->mtime = inode->i_mtime;
 	res->bitmap[0] = (FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE) &
 		args->bitmap[0];
 	res->bitmap[1] = (FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY) &
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 73a5a5ea2976..03a20f5716c7 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -627,7 +627,7 @@ static __be32 encode_attr_size(struct xdr_stream *xdr, const uint32_t *bitmap, u
 	return 0;
 }
 
-static __be32 encode_attr_time(struct xdr_stream *xdr, const struct timespec *time)
+static __be32 encode_attr_time(struct xdr_stream *xdr, const struct timespec64 *time)
 {
 	__be32 *p;
 
@@ -639,14 +639,14 @@ static __be32 encode_attr_time(struct xdr_stream *xdr, const struct timespec *ti
 	return 0;
 }
 
-static __be32 encode_attr_ctime(struct xdr_stream *xdr, const uint32_t *bitmap, const struct timespec *time)
+static __be32 encode_attr_ctime(struct xdr_stream *xdr, const uint32_t *bitmap, const struct timespec64 *time)
 {
 	if (!(bitmap[1] & FATTR4_WORD1_TIME_METADATA))
 		return 0;
 	return encode_attr_time(xdr,time);
 }
 
-static __be32 encode_attr_mtime(struct xdr_stream *xdr, const uint32_t *bitmap, const struct timespec *time)
+static __be32 encode_attr_mtime(struct xdr_stream *xdr, const uint32_t *bitmap, const struct timespec64 *time)
 {
 	if (!(bitmap[1] & FATTR4_WORD1_TIME_MODIFY))
 		return 0;
-- 
2.20.0

