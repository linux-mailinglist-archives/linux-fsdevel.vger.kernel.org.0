Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACF146EBCA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 16:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240281AbhLIPlR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 10:41:17 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:42510 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240248AbhLIPkp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:40:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 10543CE2689;
        Thu,  9 Dec 2021 15:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4754C341CD;
        Thu,  9 Dec 2021 15:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639064228;
        bh=pdHlpJNgTjSsWmnL3CRTHK7QBgLJLxU3X5wXscIWqrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VNRbqkyZG58yciD3Q8CwMGgEnK00U44xnmYW7revzkiU/vDMsQuBJoNHDRTb20/gu
         tx9hhMmjDcX6YGiluMR7DVCuAp+OGGsxokeAPMF1yi5wwRyWVPCyKR1IQLsQk6mpIT
         clZmP/PnTRbxEryoJrN0wgFGK4+a14PfqkIPdvUx1Iqwm9nKO0gcMe2n3FcXKfE9ey
         Eo+wOXDUCcAB4pctnWIM1oKjC7vmYtsDEwJh+lRiylguJltJdS0sFAzcmOhGJ+ETwm
         ijzFan+19tbM9z+WdKt/SxBqO4Xt1Volg3zDV74aBmBRr9YuZq2HDF7ApZNxClk3NH
         Xm2QfJsiM+JyA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Luis Henriques <lhenriques@suse.de>
Subject: [PATCH 27/36] ceph: don't allow changing layout on encrypted files/directories
Date:   Thu,  9 Dec 2021 10:36:38 -0500
Message-Id: <20211209153647.58953-28-jlayton@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211209153647.58953-1-jlayton@kernel.org>
References: <20211209153647.58953-1-jlayton@kernel.org>
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
2.33.1

