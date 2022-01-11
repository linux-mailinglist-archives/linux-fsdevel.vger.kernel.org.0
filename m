Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C298548B702
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350754AbiAKTRl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345828AbiAKTRK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:17:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CCEC028BE4;
        Tue, 11 Jan 2022 11:16:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49222B81D1D;
        Tue, 11 Jan 2022 19:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D01C36AEF;
        Tue, 11 Jan 2022 19:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641928600;
        bh=4iaEfsfQA8OpTXoYYgy9s8ntzzPdam8HtvumNLO5nyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qIeqaIwh2ko2YgaKfqkwpk4HV0LGrwCE+7/MijpRlO9oSt9ALYmXsVdyhDpNeulPf
         ScqtY2W2ZCwfhgIeXTMXTScwyZBfUQwAQg7VXWL4Yxu/NXZHD/zQOhX7ldO/Rt78sI
         TO2+1IoIHb1Bq4KZ1XpuOjRIee2TQe0GNX8G4RXsKRDesu2w9G3SMDoDxj/L+OK4RG
         ZJJu+xmHkfhAk3XO6ZkPc/KOaJP+xsORYsvqeLyAy47C77vt+Qqjb6ba+GsrZ9k6LK
         +b4pDvA7qy/I02E4hkuI/HbVO4Q7yjCxMkid12VmX5RX2Po2jpseywr7Qasx1Rkuex
         c2yF7a95kWGmA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: [RFC PATCH v10 41/48] ceph: set encryption context on open
Date:   Tue, 11 Jan 2022 14:16:01 -0500
Message-Id: <20220111191608.88762-42-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111191608.88762-1-jlayton@kernel.org>
References: <20220111191608.88762-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index b74c9bf2cef1..17e26c030f5f 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -369,6 +369,12 @@ int ceph_open(struct inode *inode, struct file *file)
 	fmode = ceph_flags_to_mode(flags);
 	wanted = ceph_caps_for_mode(fmode);
 
+	if (S_ISREG(inode->i_mode)) {
+		err = fscrypt_file_open(inode, file);
+		if (err)
+			return err;
+	}
+
 	/* snapped files are read-only */
 	if (ceph_snap(inode) != CEPH_NOSNAP && (file->f_mode & FMODE_WRITE))
 		return -EROFS;
-- 
2.34.1

