Return-Path: <linux-fsdevel+bounces-26697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA0E95B1A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 11:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEBDE1F21D90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 09:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BC717C200;
	Thu, 22 Aug 2024 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yn/7fAxM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3832014EC5E
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 09:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318932; cv=none; b=uPyr4s9bVO29ZJrZjv8MGiQHREkhyHiE1MJ5n6p28BVKHgMT5a3INdKG+sBG2RjCNs8wGnFy0TV7dLTFloOEeZaxVcS+gcQb1QX75BSdYNrwO/cdvOJJbVuHRsCEyx+wukW4rKTyAxrBhqi7HiK1PUhA3cghOR8aYRleO5POcfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318932; c=relaxed/simple;
	bh=/MednjHkB6YNRTNjLDV6CMy67/wi4LFEDiVCn3rUHwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HvjYKbB1KEqBSL1vAbHGCy3D3A6Wrz4TMlP9CjwoWB8+M9kr3+jjg5ogahxQv/qaInNS4jFHBJZ+9ZZznzpAZdKIYV0SwE6Q0ZqGlnZ4IfEr3lEBeb1D/NmJytU3pOxz7NBQvbS0Q4u+QsWp7+Hus4DCuRCl0C2yuyHUwClcUUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yn/7fAxM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2E7C32782;
	Thu, 22 Aug 2024 09:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724318931;
	bh=/MednjHkB6YNRTNjLDV6CMy67/wi4LFEDiVCn3rUHwM=;
	h=From:To:Cc:Subject:Date:From;
	b=Yn/7fAxMC99pPVwRloNQfioAecFYxwFbvN1IkwBSn0Ep4JaLvb6/yzYds6mrPqUH/
	 SqqVR4+KX2hy5EZCT/T42RVMCVCQc9f074V70+rq3OgXOIMWcyDpRt0mQqsZ++3Mik
	 VrbIOvs3alFeyZzQFwELY7X0BVYAJkwydFhKdhPsSmkEIF7KdlIfjIe7CTfVtuNCJN
	 ScFYoyTu7z4A1u1krIOUc/ri6zrn94ATg+B7OrFN0BOCsQv73eGbjuHxJUjrVAuwfO
	 ejP9gdEHJrp7gascl2qS+msOf2XBiwZZixytOh+KXqxTDU6jemW2B7epfLCE1O5BB9
	 B/fUZIS9te/Bw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] fs: remove unused path_put_init()
Date: Thu, 22 Aug 2024 11:28:38 +0200
Message-ID: <20240822-bewuchs-werktag-46672b3c0606@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=840; i=brauner@kernel.org; h=from:subject:message-id; bh=/MednjHkB6YNRTNjLDV6CMy67/wi4LFEDiVCn3rUHwM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQdZzn1+FRnnbrik01pO9jK5A9JRPkovk7ZM1lVU2au+ MVaebHNHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZG8bwz+yWVtarsk9fj9Xu m+qcurV80uO4qlcVCqaNc+YXLj/z9xMjw262Y+z6/zWu953axXN+8wZBpe6bW6pmafP/O5LbZ7w ikgEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

This helper has been unused for a while now.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Goes into vfs.misc unless I hear complaints.
---
 include/linux/path.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/path.h b/include/linux/path.h
index ca073e70decd..7ea389dc764b 100644
--- a/include/linux/path.h
+++ b/include/linux/path.h
@@ -18,12 +18,6 @@ static inline int path_equal(const struct path *path1, const struct path *path2)
 	return path1->mnt == path2->mnt && path1->dentry == path2->dentry;
 }
 
-static inline void path_put_init(struct path *path)
-{
-	path_put(path);
-	*path = (struct path) { };
-}
-
 /*
  * Cleanup macro for use with __free(path_put). Avoids dereference and
  * copying @path unlike DEFINE_FREE(). path_put() will handle the empty
-- 
2.43.0


