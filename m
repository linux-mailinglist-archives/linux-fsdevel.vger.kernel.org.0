Return-Path: <linux-fsdevel+bounces-51344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAB1AD5C78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 18:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 898AA16B54E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 16:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AE820468C;
	Wed, 11 Jun 2025 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJR/8fYN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3971C8632;
	Wed, 11 Jun 2025 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660045; cv=none; b=OVqQHbTo9qtNvbHvZJoBeCrCwPb/L6OJEkXhXU8cs3O4bca2wWtVb0Upz0M6OYEMSUB51WdVEygoGJLWRvQhtBi6V6j53UYiIn42wUEKSsKRnqitilITDs50b13yZtlxl+qzP5eteEt6TuTVMxAYgSzvCQu8OpKu914w0zIXghc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660045; c=relaxed/simple;
	bh=tdoCZ5WhTTd1H3icgbRTRkNnOgUeWkbsQeuTsnJniVg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P26YXR6POFgfByGFOHaLk/CkuSqTxxtQm/lp40uok+V61MUTxy/FiWOrKbs6C6dwR+qJ8nV+KmRWE3fbW4fNpCc18+QDDNMkfaq7wsEHFSRckL9NxxBQeMkIdfak3+PwZh+Hv6c4H7gZlI1zKVFXmJ5pk1f4Dpf7v7WGLns25ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJR/8fYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF65AC4CEE3;
	Wed, 11 Jun 2025 16:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749660045;
	bh=tdoCZ5WhTTd1H3icgbRTRkNnOgUeWkbsQeuTsnJniVg=;
	h=Date:From:To:Cc:Subject:From;
	b=oJR/8fYNHipE2xIaaWv92JuLsUciOnZjEF5d1JffwBH7rAxfibQ7xDRJT/ELdnWOM
	 LbkyIaQKgosGFPgeh/rz0X4hjpWp2qi7WEkJCb2IviqxvaM7zwzzTwz1wuEorv2Yum
	 iPNPKRJQ95Qc8zluyeLKFrts0OlZpzreI7sXOvzPzOmQCHd9eo/dGnrQLPpm+4Cu4m
	 jEYjzw8GBf/crS1wfp1uFHDXASMi4ZgFkuQ/J9YU5SLkeWOPdn0sr8DWDjobYS52Gn
	 GJfdaW1QWk+Pm+58v3lp0P3CPANdDtzovRV9dwlrVQl5WatALpxLYo+jYAChtCJvMU
	 vqrHYgtywqMow==
Date: Wed, 11 Jun 2025 09:40:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs: unlock the superblock during iterate_supers_type
Message-ID: <20250611164044.GF6138@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Darrick J. Wong <djwong@kernel.org>

This function takes super_lock in shared mode, so it should release the
same lock.

Cc: <stable@vger.kernel.org> # v6.16-rc1
Fixes: af7551cf13cf7f ("super: remove pointless s_root checks")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/super.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 21799e213fd747..80418ca8e215bb 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -964,8 +964,10 @@ void iterate_supers_type(struct file_system_type *type,
 		spin_unlock(&sb_lock);
 
 		locked = super_lock_shared(sb);
-		if (locked)
+		if (locked) {
 			f(sb, arg);
+			super_unlock_shared(sb);
+		}
 
 		spin_lock(&sb_lock);
 		if (p)

