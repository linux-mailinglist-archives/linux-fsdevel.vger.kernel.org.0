Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691382EA1E5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 01:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbhAEA4g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 19:56:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:38158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbhAEA43 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 19:56:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F647227BF;
        Tue,  5 Jan 2021 00:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609808110;
        bh=gNmDYe2Lw3Moz7fSm4TY9dr/5OhIQas+i4KMcztjpdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iue5bgzUAw8lnkQhxntcvGe1ceXoW5GSJWYIHh3cLSi/unfeetrDIk3AEiLSYzXXM
         YRQ0yms8cM/fhbIoNhu2BFHmIxs1KHKry2eno50f0+As0LpEMAFdE2jzEK6/I+t79x
         q1xCXE9vM0AMyX4uOGz6HuPfUF9wxnuqjDGTfduCP/T8y+CI8WNZF+C6o8JGDmDuRb
         6XujVxKjL7yeDT5YHWoAHOi3U46i46aTw1Z6B/hNUFzMJq+9EuadYpNdInK2x1Ora2
         NDZjswrQjIOKf9F0DW31SasqoFVgS7ALAcH8xEZ6GQAEgUhyFzB2AoBeG23brpfA7v
         i9mSTRbrzfsTA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 12/13] xfs: remove a stale comment from xfs_file_aio_write_checks()
Date:   Mon,  4 Jan 2021 16:54:51 -0800
Message-Id: <20210105005452.92521-13-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210105005452.92521-1-ebiggers@kernel.org>
References: <20210105005452.92521-1-ebiggers@kernel.org>
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

