Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D14648B70D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350780AbiAKTRo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350762AbiAKTRK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:17:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D478C061763;
        Tue, 11 Jan 2022 11:16:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97AF761786;
        Tue, 11 Jan 2022 19:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85739C36AE9;
        Tue, 11 Jan 2022 19:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641928598;
        bh=HhuUOceGWBSn85IWQRyXLlv7pCQTZ8BEMILRBNY08y0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OA2jC4xJ5uCf5BJO+P1F0BRPXsBx2XOYwNdQOFbWfxW+kMcYqkiczjCGppf/XMNPk
         KhMfAyUYgPaGTF5N2XcoN0kInMTuDh57vWsfG9HeuFWNlwkdfGz6ah461bhE5x4nnK
         ib2RJuNG/7/e2CZEtXL+2B5HoFFCthsCO9DTolQAQa5JIBQfAgiHSa+RHzNqrAfnF0
         idTXo7xmq9FT75lqJnzNDl9vTqp7lxcIKi7h6HqmqbuisucmwcRnQFQPA1nKO6vs/a
         AAdF3b9BE7UEmE7UtW8Csj4WaVPHnm3D7kyTxTfe+dnHJfltDqINSroPbstxR4J6KM
         w28wUxgL4J5ug==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: [RFC PATCH v10 38/48] ceph: disable fallocate for encrypted inodes
Date:   Tue, 11 Jan 2022 14:15:58 -0500
Message-Id: <20220111191608.88762-39-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111191608.88762-1-jlayton@kernel.org>
References: <20220111191608.88762-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

...hopefully, just for now.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index f14a2999f6d5..c79c95138843 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2136,6 +2136,9 @@ static long ceph_fallocate(struct file *file, int mode,
 	if (!S_ISREG(inode->i_mode))
 		return -EOPNOTSUPP;
 
+	if (IS_ENCRYPTED(inode))
+		return -EOPNOTSUPP;
+
 	prealloc_cf = ceph_alloc_cap_flush();
 	if (!prealloc_cf)
 		return -ENOMEM;
-- 
2.34.1

