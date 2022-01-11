Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052E948B70C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350857AbiAKTRq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350770AbiAKTRK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:17:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF40C028BE1;
        Tue, 11 Jan 2022 11:16:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8CF3B81D2C;
        Tue, 11 Jan 2022 19:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE083C36AE9;
        Tue, 11 Jan 2022 19:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641928599;
        bh=orWi1qlXja6KaZwYiCBL6tqVKRi2KsvarrlQyzVpt0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JAZdE7ceEP+3TIbIVgg5IfpPDc6Ly9dpbpwE1oZl2w2lIHqoCnXJOZ58ZxP4JZ0fx
         dzSrX7uejkZPDUsUK3pCSg1a6/hIFEQ1mj/hkp8VNsiaa2EZWa7aiYMFhCHexd3z8U
         uz9Kv3VhHwvOgU23NkAMxFAaCfXl1JNy27tMvzDnTXPAOBnnGVqom7X0o72pJqh7Vy
         UQBKIyflBdqMhjTK2EF09xugiU0Dy19+IRchYogr8Pfs65luOhhVqcoFL0f7deQvBB
         4dZhKxeeFe9N3HmYdQ5aVI81uFHpbyM6a4ZJ6NulWFtXhK3GVKsoX+wWVpkNo2kWAK
         GOSEfjMX2rNRg==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: [RFC PATCH v10 40/48] ceph: don't use special DIO path for encrypted inodes
Date:   Tue, 11 Jan 2022 14:16:00 -0500
Message-Id: <20220111191608.88762-41-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111191608.88762-1-jlayton@kernel.org>
References: <20220111191608.88762-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eventually I want to merge the synchronous and direct read codepaths,
possibly via new netfs infrastructure. For now, the direct path is not
crypto-enabled, so use the sync read/write paths instead.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 1711fde46548..b74c9bf2cef1 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1631,7 +1631,9 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		     ceph_cap_string(got));
 
 		if (ci->i_inline_version == CEPH_INLINE_NONE) {
-			if (!retry_op && (iocb->ki_flags & IOCB_DIRECT)) {
+			if (!retry_op &&
+			    (iocb->ki_flags & IOCB_DIRECT) &&
+			    !IS_ENCRYPTED(inode)) {
 				ret = ceph_direct_read_write(iocb, to,
 							     NULL, NULL);
 				if (ret >= 0 && ret < len)
@@ -1863,7 +1865,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 		/* we might need to revert back to that point */
 		data = *from;
-		if (iocb->ki_flags & IOCB_DIRECT)
+		if ((iocb->ki_flags & IOCB_DIRECT) && !IS_ENCRYPTED(inode))
 			written = ceph_direct_read_write(iocb, &data, snapc,
 							 &prealloc_cf);
 		else
-- 
2.34.1

