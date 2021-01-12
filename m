Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963CC2F3994
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 20:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406595AbhALTF3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 14:05:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:42278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406471AbhALTF2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:05:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB97D2312A;
        Tue, 12 Jan 2021 19:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610478251;
        bh=iS9NaJbF6WGlfwyaEVylnwoccWtqZ29B1EFuOerPM2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R9W+OfB/I0d3D9RbfhDSKnCAhk4DCLkG9op4kyVEfKGUF/Pzpt6RoHWPlcr2V/XHp
         EV0Y3n+nH1cwsTI1KtLNKJZlgKwWAMTLtH6+/i1rp58AtnGGEQ67lHflffmmwuxk8Z
         LQr7EsPW9Rgr35YPJBUOTGrdheviC4ThppaXO18jOO2thXuOz0sEDK0TFa5NzA24QS
         L0GHvTobDXLFPZwcwr+uj/Faq9uFi70PgUrtKsyt4Jyhw5gMyP+bxeetwyIeeHX1b4
         TzVeL2TBiN0d5qWOrsOcRn1PdWWYAxb6PvZIyGJ1Nr44mH5yUjWdPP6BV0CpsciDVB
         ZVYG8cM0p0p/A==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v3 08/11] fs: drop redundant check from __writeback_single_inode()
Date:   Tue, 12 Jan 2021 11:02:50 -0800
Message-Id: <20210112190253.64307-9-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210112190253.64307-1-ebiggers@kernel.org>
References: <20210112190253.64307-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

wbc->for_sync implies wbc->sync_mode == WB_SYNC_ALL, so there's no need
to check for both.  Just check for WB_SYNC_ALL.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/fs-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 80ee9816d9df5..cee1df6e3bd43 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1479,7 +1479,7 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 	 * change I_DIRTY_TIME into I_DIRTY_SYNC.
 	 */
 	if ((inode->i_state & I_DIRTY_TIME) &&
-	    (wbc->sync_mode == WB_SYNC_ALL || wbc->for_sync ||
+	    (wbc->sync_mode == WB_SYNC_ALL ||
 	     time_after(jiffies, inode->dirtied_time_when +
 			dirtytime_expire_interval * HZ))) {
 		trace_writeback_lazytime(inode);
-- 
2.30.0

