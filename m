Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B6F48B6C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350649AbiAKTQu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:16:50 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60808 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350574AbiAKTQb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:16:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BB59B81D0E;
        Tue, 11 Jan 2022 19:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C214DC36AF2;
        Tue, 11 Jan 2022 19:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641928589;
        bh=+C2trUiZPCTEWyTvmutqANQLRRY+XvzYO8gZ5/8aZv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZYPTCashaniiRogeQRnsgKRawTLtjBgZp8g8ECRApsml5nPB4ga3xqzPhSkv28j43
         UMW1dbWLv1JDsRW+PrPszQegGtj4YheRy8aWMZOV+4AmD7kebxLV4ZY++d3p+cfIme
         MzI7oLb3Q6lwECegCVV/0m7cLXyNLM/XrHt+UNWcHjhrW+Ch8T/vlCU24GqTkmx+6m
         6+AC0WJ1NuNXzC0Ss+VEhcENRaqZpw4Bw3qXqvp3sQoE5FqAamxS9PslfbxjbBiGUS
         RQ9UA5klzSyEYiqruJYaC4XCJDsruEjDzOelOMwL7nTT3K+KQZIn/EtPxTmmLMIfot
         HKU/or0dVyn2Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com,
        Luis Henriques <lhenriques@suse.de>
Subject: [RFC PATCH v10 26/48] ceph: don't allow changing layout on encrypted files/directories
Date:   Tue, 11 Jan 2022 14:15:46 -0500
Message-Id: <20220111191608.88762-27-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111191608.88762-1-jlayton@kernel.org>
References: <20220111191608.88762-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Henriques <lhenriques@suse.de>

Encryption is currently only supported on files/directories with layouts
where stripe_count=1.  Forbid changing layouts when encryption is involved.

Signed-off-by: Luis Henriques <lhenriques@suse.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/ioctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index 477ecc667aee..480d18bb2ff0 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -294,6 +294,10 @@ static long ceph_set_encryption_policy(struct file *file, unsigned long arg)
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
+	/* encrypted directories can't have striped layout */
+	if (ci->i_layout.stripe_count > 1)
+		return -EINVAL;
+
 	ret = vet_mds_for_fscrypt(file);
 	if (ret)
 		return ret;
-- 
2.34.1

