Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCB3169568
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 03:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbgBWCiB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 21:38:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:49792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727229AbgBWCV2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:21:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2445214DB;
        Sun, 23 Feb 2020 02:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582424487;
        bh=oBFlDE9A/gis0xHj4tQtmtNTj/P1n3aibbo6E0lXCWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=17RmoHZgQ2jP22/+LnQzM48rIiM3H5+4vM81ITcq9rxBDCbw9ys6dcwuujoDFx74c
         GboYYXVNhrVRRSS4zD3tAqnQQaxLQdo5j/Rr8kc8LjMa5B3yI01t+8U9lwI8MhqckB
         C4KATk2gEP/UxAydI8d4VnVWgYmwMUHilvRorYiA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jeff Moyer <jmoyer@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Subject: [PATCH AUTOSEL 5.5 06/58] dax: pass NOWAIT flag to iomap_apply
Date:   Sat, 22 Feb 2020 21:20:27 -0500
Message-Id: <20200223022119.707-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200223022119.707-1-sashal@kernel.org>
References: <20200223022119.707-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jeff Moyer <jmoyer@redhat.com>

[ Upstream commit 96222d53842dfe54869ec4e1b9d4856daf9105a2 ]

fstests generic/471 reports a failure when run with MOUNT_OPTIONS="-o
dax".  The reason is that the initial pwrite to an empty file with the
RWF_NOWAIT flag set does not return -EAGAIN.  It turns out that
dax_iomap_rw doesn't pass that flag through to iomap_apply.

With this patch applied, generic/471 passes for me.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/x49r1z86e1d.fsf@segfault.boston.devel.redhat.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dax.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/dax.c b/fs/dax.c
index 1f1f0201cad18..0b0d8819cb1bb 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1207,6 +1207,9 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 		lockdep_assert_held(&inode->i_rwsem);
 	}
 
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		flags |= IOMAP_NOWAIT;
+
 	while (iov_iter_count(iter)) {
 		ret = iomap_apply(inode, pos, iov_iter_count(iter), flags, ops,
 				iter, dax_iomap_actor);
-- 
2.20.1

