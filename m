Return-Path: <linux-fsdevel+bounces-14619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4FA87DEBC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05DF7280E81
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388EB63B3;
	Sun, 17 Mar 2024 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5QKlEuU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943221B949;
	Sun, 17 Mar 2024 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693261; cv=none; b=ZpXcEd31eiPYPNysxCs31FkdwxErT7t7l3RaqE2EzdxJlRJiyJxhMSfhPjsM2nLuJIncB+Lf+WRh+8U+BkiB4UB9RLdBFVa1pHUpT4wZg+WH8YDjsULFUwQrcglzvxKT/vIb5eQlAKhoj26TTsT/J15pgJ8ZY8Isj9m+xxLMmes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693261; c=relaxed/simple;
	bh=+O804seDjcWiSwjJhai6gBDtUJWVnPn4VUy30SoJQN8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gExxY8qA4+nnNhAiTwL95uic3E2FjI5wXmTKS/+tVUXvDyJKG9tj2npYCsJe/MjtMTwQAJVSj6v2j58fLCAfZAMFTFLbRdvHMZGKD2nF6vEQuDUC1w9JBsZ2vY9FHkgpa1TK5ptZOqF//U75mvnHlClMheHI0FrEgw2lXSMmSTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5QKlEuU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687BCC433C7;
	Sun, 17 Mar 2024 16:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693261;
	bh=+O804seDjcWiSwjJhai6gBDtUJWVnPn4VUy30SoJQN8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=d5QKlEuUepG4gBySv2cdGwZg2/HUhW8hkYoTwpYNdajs4cJuyKhDpooM3pm2AJwlN
	 4vEQh/0UyOskYAsM7ZcnlNH8CTJr002VVFnJfu1/Z7gkoZH9jRyB4/xCa9df4+6C0d
	 Gi1rq/cJ1ip8TULOCCROdOIE/6u9xM08RGPAwSR90mp6bwWAsZgXtTqwPIqx/nyX9g
	 zlgNee2Q7WQDkD55ziKSkan9wUWfwfbSlIYBKUD4UJ9qMl3hlGppwXuJWxx+Ap5R9G
	 NJHijDqlZFLAGCZvLfqDOE5OLKxHyLXjGVoEg4zKgwxH9snXTOmZuseR/tpSSO9xEJ
	 1ccyqwHEdAWDQ==
Date: Sun, 17 Mar 2024 09:34:20 -0700
Subject: [PATCH 02/20] xfsprogs: define parent pointer xattr format
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, djwong@kernel.org, cem@kernel.org,
 ebiggers@kernel.org
Cc: Dave Chinner <dchinner@redhat.com>,
 Allison Henderson <allison.henderson@oracle.com>, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <171069247702.2685643.4144188443131170132.stgit@frogsfrogsfrogs>
In-Reply-To: <171069247657.2685643.11583844772215446491.stgit@frogsfrogsfrogs>
References: <171069247657.2685643.11583844772215446491.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Allison Henderson <allison.henderson@oracle.com>

Source kernel commit: 655e7fb23dc155b37a2eeadf2c854def053980bf

We need to define the parent pointer attribute format before we start
adding support for it into all the code that needs to use it. The EA
format we will use encodes the following information:

name={parent inode #, parent inode generation, dirent offset}
value={dirent filename}

The inode/gen gives all the information we need to reliably identify the
parent without requiring child->parent lock ordering, and allows
userspace to do pathname component level reconstruction without the
kernel ever needing to verify the parent itself as part of ioctl calls.

By using the dirent offset in the EA name, we have a method of knowing
the exact parent pointer EA we need to modify/remove in rename/unlink
without an unbound EA name search.

By keeping the dirent name in the value, we have enough information to
be able to validate and reconstruct damaged directory trees. While the
diroffset of a filename alone is not unique enough to identify the
child, the {diroffset,filename,child_inode} tuple is sufficient. That
is, if the diroffset gets reused and points to a different filename, we
can detect that from the contents of EA. If a link of the same name is
created, then we can check whether it points at the same inode as the
parent EA we current have.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 libxfs/xfs_da_format.h |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)


diff --git a/libxfs/xfs_da_format.h b/libxfs/xfs_da_format.h
index 5434d4d5..fa0f46db 100644
--- a/libxfs/xfs_da_format.h
+++ b/libxfs/xfs_da_format.h
@@ -878,4 +878,29 @@ static inline unsigned int xfs_dir2_dirblock_bytes(struct xfs_sb *sbp)
 xfs_failaddr_t xfs_da3_blkinfo_verify(struct xfs_buf *bp,
 				      struct xfs_da3_blkinfo *hdr3);
 
+/*
+ * Parent pointer attribute format definition
+ *
+ * EA name encodes the parent inode number, generation and the offset of
+ * the dirent that points to the child inode. The EA value contains the
+ * same name as the dirent in the parent directory.
+ */
+struct xfs_parent_name_rec {
+	__be64  p_ino;
+	__be32  p_gen;
+	__be32  p_diroffset;
+};
+
+/*
+ * incore version of the above, also contains name pointers so callers
+ * can pass/obtain all the parent pointer information in a single structure
+ */
+struct xfs_parent_name_irec {
+	xfs_ino_t		p_ino;
+	uint32_t		p_gen;
+	xfs_dir2_dataptr_t	p_diroffset;
+	const char		*p_name;
+	uint8_t			p_namelen;
+};
+
 #endif /* __XFS_DA_FORMAT_H__ */


