Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37C7CFEE9E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2019 16:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731083AbfKPPwz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Nov 2019 10:52:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:33684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbfKPPwy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:52:54 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B7D620859;
        Sat, 16 Nov 2019 15:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919573;
        bh=Ubzdtado8qpF9VSRmYdGAtTkvjECdbzj1U/T/2pUfco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xn+gbUI8x6iVR6FvRM0f4HawiJabggGEz8NpmEb4iFVctpi1Y3VJzgS2bEIMN14LB
         hWcg7NiqHI8nBLjIx35jIte1XtFGQt9QO60yRiqCd6bJTcknyfScEaCiLSUeME+BjG
         DhhofQrGUDPYqpJaTxAQ8T9ogKeXidUmRgBzRHD8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        "Ernesto A . Fernndez" <ernesto.mnd.fernandez@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Hin-Tak Leung <htl10@users.sourceforge.net>,
        Vyacheslav Dubeyko <slava@dubeyko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 67/99] fs/hfs/extent.c: fix array out of bounds read of array extent
Date:   Sat, 16 Nov 2019 10:50:30 -0500
Message-Id: <20191116155103.10971-67-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116155103.10971-1-sashal@kernel.org>
References: <20191116155103.10971-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 6c9a3f843a29d6894dfc40df338b91dbd78f0ae3 ]

Currently extent and index i are both being incremented causing an array
out of bounds read on extent[i].  Fix this by removing the extraneous
increment of extent.

Ernesto said:

: This is only triggered when deleting a file with a resource fork.  I
: may be wrong because the documentation isn't clear, but I don't think
: you can create those under linux.  So I guess nobody was testing them.
:
: > A disk space leak, perhaps?
:
: That's what it looks like in general.  hfs_free_extents() won't do
: anything if the block count doesn't add up, and the error will be
: ignored.  Now, if the block count randomly does add up, we could see
: some corruption.

Detected by CoverityScan, CID#711541 ("Out of bounds read")

Link: http://lkml.kernel.org/r/20180831140538.31566-1-colin.king@canonical.com
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Ernesto A. Fernndez <ernesto.mnd.fernandez@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Hin-Tak Leung <htl10@users.sourceforge.net>
Cc: Vyacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfs/extent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
index 16819d2a978b4..cbe4fca96378a 100644
--- a/fs/hfs/extent.c
+++ b/fs/hfs/extent.c
@@ -304,7 +304,7 @@ int hfs_free_fork(struct super_block *sb, struct hfs_cat_file *file, int type)
 		return 0;
 
 	blocks = 0;
-	for (i = 0; i < 3; extent++, i++)
+	for (i = 0; i < 3; i++)
 		blocks += be16_to_cpu(extent[i].count);
 
 	res = hfs_free_extents(sb, extent, blocks, blocks);
-- 
2.20.1

