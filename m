Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5CE2EFE7B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jan 2021 09:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbhAIIBG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Jan 2021 03:01:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:41216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbhAIIBF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Jan 2021 03:01:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D30123A82;
        Sat,  9 Jan 2021 07:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610179187;
        bh=BCwJUP1PxHm+O0jkqtVgewHXBIFwwuWoM+6SlzLbD1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ArXO1T/oIWyOTfDCrsPPsTG1yBnlHnDCu6k2UEfX488lMMwJfExpGvUj0SUXv+FxB
         m4ezNQbMe1EjoHp4x6xZAqwQnJSutFewWYmT15xz2E7W9rZge00zn1wiBTkHoKkjpX
         h0q3ZUNyUClP4o0l4Adozv5UZU1xRDgRi4a8KYTobDCDPUem4XuPgUkAUZRLvilK0p
         eqkCQUmAzzvv1/uV2gd56CRPjA31IT7rcxaRnJAIkeJK674YuHSEp/arfRElObux6C
         kowNTi50o7F/O3FyN+dOUKU+XyOqSdMy6/oSBna+IAyh0gZNZTrxjNpxTPIXXDY7Ue
         Hj9ligQjmJIVg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 12/12] xfs: remove a stale comment from xfs_file_aio_write_checks()
Date:   Fri,  8 Jan 2021 23:59:03 -0800
Message-Id: <20210109075903.208222-13-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210109075903.208222-1-ebiggers@kernel.org>
References: <20210109075903.208222-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The comment in xfs_file_aio_write_checks() about calling file_modified()
after dropping the ilock doesn't make sense, because the code that
unconditionally acquires and drops the ilock was removed by
commit 467f78992a07 ("xfs: reduce ilock hold times in
xfs_file_aio_write_checks").

Remove this outdated comment.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/xfs/xfs_file.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 5b0f93f738372..4927c6653f15d 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -389,12 +389,6 @@ xfs_file_aio_write_checks(
 	} else
 		spin_unlock(&ip->i_flags_lock);
 
-	/*
-	 * Updating the timestamps will grab the ilock again from
-	 * xfs_fs_dirty_inode, so we have to call it after dropping the
-	 * lock above.  Eventually we should look into a way to avoid
-	 * the pointless lock roundtrip.
-	 */
 	return file_modified(file);
 }
 
-- 
2.30.0

