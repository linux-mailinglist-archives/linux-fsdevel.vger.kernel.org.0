Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1750F48B6FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350749AbiAKTRk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350767AbiAKTRK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:17:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553EFC028BDC;
        Tue, 11 Jan 2022 11:16:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0AEAB81D1D;
        Tue, 11 Jan 2022 19:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4493EC36AE3;
        Tue, 11 Jan 2022 19:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641928598;
        bh=1JU5/Vk5xZTt7bCqWKoj0hGQaH3WXmjQ+nOqkI/VbWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CEAEKB5SxJ1WrRICcbhrh37Tuf3ONgTOZJSUiXzf8g9SuGHAAfy2Gfmydphb84hTv
         WqMMg0mF0H3ly/jIuhyABplWPz9YQFh5p7ST9vYB5qGnhFOH2ljkswlFsoe8o0Nv6O
         0O7F318KtusjZ9vEeajSlEd3wx3uPGS7Fy7/OY0akFjZ3PcZY/+n4i9KPwlLOcKNJF
         wgLo2bSpsVegOwLMCJewn7/tlX9xx7Ihdg/3eOSXVXwdgH/HXy7vBkmd1mZ4AJDlU2
         1cHdzAFSgTM1oVKj/T8EgeBTZcgcdWociY8CJZG7aJnNFyV6xB7NHzeddbYTh2a9OA
         Jj6Nlz3BpickA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: [RFC PATCH v10 39/48] ceph: disable copy offload on encrypted inodes
Date:   Tue, 11 Jan 2022 14:15:59 -0500
Message-Id: <20220111191608.88762-40-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111191608.88762-1-jlayton@kernel.org>
References: <20220111191608.88762-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we have an encrypted inode, then the client will need to re-encrypt
the contents of the new object. Disable copy offload to or from
encrypted inodes.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index c79c95138843..1711fde46548 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2462,6 +2462,10 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 		return -EOPNOTSUPP;
 	}
 
+	/* Every encrypted inode gets its own key, so we can't offload them */
+	if (IS_ENCRYPTED(src_inode) || IS_ENCRYPTED(dst_inode))
+		return -EOPNOTSUPP;
+
 	if (len < src_ci->i_layout.object_size)
 		return -EOPNOTSUPP; /* no remote copy will be done */
 
-- 
2.34.1

