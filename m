Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A84DAE4192
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 04:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390142AbfJYCgR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 22:36:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41316 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbfJYCgQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 22:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YkdWxCgZ86gW+r2N4bvEmwwumBRWj7JLZ9Pw6USi34k=; b=JF+n3BkU0rDhAJ1n+7XcQP/k2
        x+f1MMLQ4SHD3XNCT24PNizn3j7Xs0qyZ36FHpc4gXjEjXinVJiekte9xOuSueDroEhSsTCX/Jkw2
        Z5/hWNokL+YT4y9jynU/zG3I3oh3H2m+GPQTPqDpHhL1dAT6lCjx0x/wC6vsObSsz5Frk/kWKKv87
        dY2aVKpM71OiCZM8DRuYdOHiag8dMJDrWwZSuLepIclph19NUVjaKaCwDqgpo6b4it6S6nVKOnwmx
        aIw8+KMSP6rHB3U5Mpi3h9uV3udwTpGQrA7plWSAjfcoZxOEEa57Xa+sLuBskKkMnZt4eWLA+QtMG
        6/Nw6JrFw==;
Received: from p91006-ipngnfx01marunouchi.tokyo.ocn.ne.jp ([153.156.43.6] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNpSZ-0003cj-Df; Fri, 25 Oct 2019 02:36:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/4] xfs: don't implement XFS_IOC_RESVSP / XFS_IOC_RESVSP64 directly
Date:   Fri, 25 Oct 2019 11:36:06 +0900
Message-Id: <20191025023609.22295-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025023609.22295-1-hch@lst.de>
References: <20191025023609.22295-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These ioctls are implemented by the VFS and mapped to ->fallocate now,
so this code won't ever be reached.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_ioctl.c   | 10 ----------
 fs/xfs/xfs_ioctl32.c |  2 --
 2 files changed, 12 deletions(-)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 0fed56d3175c..da4aaa75cfd3 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -643,8 +643,6 @@ xfs_ioc_space(
 	 */
 	switch (cmd) {
 	case XFS_IOC_ZERO_RANGE:
-	case XFS_IOC_RESVSP:
-	case XFS_IOC_RESVSP64:
 	case XFS_IOC_UNRESVSP:
 	case XFS_IOC_UNRESVSP64:
 		if (bf->l_len <= 0) {
@@ -670,12 +668,6 @@ xfs_ioc_space(
 		flags |= XFS_PREALLOC_SET;
 		error = xfs_zero_file_space(ip, bf->l_start, bf->l_len);
 		break;
-	case XFS_IOC_RESVSP:
-	case XFS_IOC_RESVSP64:
-		flags |= XFS_PREALLOC_SET;
-		error = xfs_alloc_file_space(ip, bf->l_start, bf->l_len,
-						XFS_BMAPI_PREALLOC);
-		break;
 	case XFS_IOC_UNRESVSP:
 	case XFS_IOC_UNRESVSP64:
 		error = xfs_free_file_space(ip, bf->l_start, bf->l_len);
@@ -2121,11 +2113,9 @@ xfs_file_ioctl(
 		return xfs_ioc_setlabel(filp, mp, arg);
 	case XFS_IOC_ALLOCSP:
 	case XFS_IOC_FREESP:
-	case XFS_IOC_RESVSP:
 	case XFS_IOC_UNRESVSP:
 	case XFS_IOC_ALLOCSP64:
 	case XFS_IOC_FREESP64:
-	case XFS_IOC_RESVSP64:
 	case XFS_IOC_UNRESVSP64:
 	case XFS_IOC_ZERO_RANGE: {
 		xfs_flock64_t		bf;
diff --git a/fs/xfs/xfs_ioctl32.c b/fs/xfs/xfs_ioctl32.c
index 1e08bf79b478..257b7caf7fed 100644
--- a/fs/xfs/xfs_ioctl32.c
+++ b/fs/xfs/xfs_ioctl32.c
@@ -558,8 +558,6 @@ xfs_file_compat_ioctl(
 	case XFS_IOC_FREESP_32:
 	case XFS_IOC_ALLOCSP64_32:
 	case XFS_IOC_FREESP64_32:
-	case XFS_IOC_RESVSP_32:
-	case XFS_IOC_UNRESVSP_32:
 	case XFS_IOC_RESVSP64_32:
 	case XFS_IOC_UNRESVSP64_32:
 	case XFS_IOC_ZERO_RANGE_32: {
-- 
2.20.1

