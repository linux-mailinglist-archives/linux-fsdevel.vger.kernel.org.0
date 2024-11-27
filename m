Return-Path: <linux-fsdevel+bounces-36015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8439DAABE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 16:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B9A281832
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 15:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCD020011A;
	Wed, 27 Nov 2024 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzrIQLw4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFDD200113
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732721301; cv=none; b=BSw9GOKPRRWa+MMwrn/CxZaaHA/4oIAZBLIXH/Nb6lOv6buZ4XOaYnSPqnJSpPNiFSsxAgHXRvOyTbkOSJ4as2SlJV8aMmOTnzGfcVCK+f+9KUcIFa9QZEtRaAvoY4EoScI6xQdDE94Jre4knXeNGfqlVt7BVnKW8EAKkJUWunY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732721301; c=relaxed/simple;
	bh=aJTYjqVoUaXrqckTrck4WCU2AgH83lVUIj4TdCwyW2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AuiCCJ45SMXH8Edl1LWqfOlQJLVnuE7jqlV6/LyxwJLZGG6cKWohAOnsmRiGlTzRmdYd7NYglgP5rcNkD5Flx7h98u4pdiJA3uo/icRVBbH94Pfd6Jnw+RiTsEtijfWGPJHyzCsZuqA8Gg5B+bjzV7JvI46mO5wCm7I5x99yq1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzrIQLw4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49030C4CED2;
	Wed, 27 Nov 2024 15:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732721301;
	bh=aJTYjqVoUaXrqckTrck4WCU2AgH83lVUIj4TdCwyW2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uzrIQLw4Jw7yzpy6ZXPe3lXaRaa6goSV9ivXdsUM8ksj/HydQlqJ4WWkEW9MZGjVR
	 CRD7v+S9HNCXHNrp+a7juwjqJsekk1Obmyr5Cyzkj+KTZdBnCF1e2gExkRo0BOVWEL
	 bONFucLAdSkZqFjbtHRnET8KdeZObE4OQR6y19wYXVqAD8zeYxroq3WdLeFDdbRxji
	 Ma0fzQcfCDBgZ9xqaBtb+Co2HcLC6ddaEpir81jYH6hHGhjAsD0+UFvM5N5H8fI1MW
	 le88zehs5l7qVf4fAV15yWU+OoLIs8rNVNBBlyFnUQPxVtY9RLvCKOlxtJpJJd3uox
	 uF/pVBAOV68Wg==
From: cel@kernel.org
To: Hugh Dickens <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH v3 2/5] libfs: Remove unnecessary locking from simple_offset_empty()
Date: Wed, 27 Nov 2024 10:28:12 -0500
Message-ID: <20241127152815.151781-3-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127152815.151781-1-cel@kernel.org>
References: <20241127152815.151781-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

I hit the DEBUG_LOCKS_WARN_ON() in hlock_class() several times
during testing. This indicates that simple_offset_empty() is
attempting to lock a negative dentry. That warning is of course
silent on a kernel that is built without lock debugging.

The simple_positive() check can be done without holding the
child's d_lock.

Fixes: ecba88a3b32d ("libfs: Add simple_offset_empty()")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index bf67954b525b..f686336489a3 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -347,13 +347,10 @@ int simple_offset_empty(struct dentry *dentry)
 	index = DIR_OFFSET_MIN;
 	octx = inode->i_op->get_offset_ctx(inode);
 	mt_for_each(&octx->mt, child, index, LONG_MAX) {
-		spin_lock(&child->d_lock);
 		if (simple_positive(child)) {
-			spin_unlock(&child->d_lock);
 			ret = 0;
 			break;
 		}
-		spin_unlock(&child->d_lock);
 	}
 
 	return ret;
-- 
2.47.0


