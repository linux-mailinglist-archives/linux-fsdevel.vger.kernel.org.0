Return-Path: <linux-fsdevel+bounces-15754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294AB892893
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 984DAB22338
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C241A1366;
	Sat, 30 Mar 2024 00:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKzk7nJF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308A77E2;
	Sat, 30 Mar 2024 00:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711760357; cv=none; b=My5D/V/XaUF1LdDTxJCdk0YhJfXb4jbxO6h82dodkVPKr+ev18Y868F/Ro/P9VoI7fkIzPadEby3pdTPnaHQjNNheHu/DXHFMbsZhZA9R8TQgYL53UhBK7uSQGmIQYQ4Zm+H/kxKbhciBgsBwTU+hA+NZUuB59dp/WS4ZMWaewc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711760357; c=relaxed/simple;
	bh=7B7T8wI2H2Yn7aw7hNrDvVDir5I0YSe5QFcq9CpLD2Y=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fkysUOV7idLr+V54qK/ThCzvmhfv4eGRnhYQ+mCWnWPMGUqPDJFOZLaGgTcvy8OhdPK3Ffm5SHKIGwRBEla69QKF7cnq5jlCvWdePKQVlgqsbAXdIdGRxGgknlkkTLG0L4I13CmjFZEj6qVO8B/UJ1ZJlUd8VoJF61kDEi0RDRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKzk7nJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A33BC433F1;
	Sat, 30 Mar 2024 00:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711760357;
	bh=7B7T8wI2H2Yn7aw7hNrDvVDir5I0YSe5QFcq9CpLD2Y=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=YKzk7nJFVB+2xuoa8z4qZLwQfN3YMBzzZhg6dWPIHajDXqc3PhhujTvFn+YXOrZD1
	 Oxq/kySWslQ1s+xM+v5LTvZjPc8rPPRMuiGePBIopLf8dfqOoVHce26rYEPNQJ4QE/
	 5v5cbLYI04GSh4s9rnmq3786z/0Ix4TlBHs58ypoo9QOeYcTLObC/GJDzUnisDAGIW
	 lWXMRBzVB3EpLghugvGrO/bkLyK0wUdkIMmi1HMHCdNYXbp2PTAA5gzPDnz/AthX/X
	 NUhEQzwDXDaNWw8lg9KQx3X6R03hmSP3NavT6uuykpa7w6tKw1fLzFvr7bPhP5NYVb
	 7Z6/x0/BjhzRQ==
Date: Fri, 29 Mar 2024 17:59:16 -0700
Subject: [PATCH 09/14] xfs: condense directories after a mapping exchange
 operation
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org, hch@lst.de,
 linux-xfs@vger.kernel.org
Message-ID: <171176018826.2014991.6580731764634309751.stgit@frogsfrogsfrogs>
In-Reply-To: <171176018639.2014991.12163554496963657299.stgit@frogsfrogsfrogs>
References: <171176018639.2014991.12163554496963657299.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

The previous commit added a new file mapping exchange flag that enables
us to perform post-swap processing on file2 once we're done exchanging
extent mappings.  Now add this ability for directories.

This isn't used anywhere right now, but we need to have the basic ondisk
flags in place so that a future online directory repair feature can
create salvaged dirents in a temporary directory and exchange the data
fork mappings when ready.  If one file is in extents format and the
other is inline, we will have to promote both to extents format to
perform the exchange.  After the exchange, we can try to condense the
fixed directory down to inline format if possible.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/libxfs/xfs_exchmaps.c |   43 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)


diff --git a/fs/xfs/libxfs/xfs_exchmaps.c b/fs/xfs/libxfs/xfs_exchmaps.c
index a4578231ed3e3..065d879a2fa9f 100644
--- a/fs/xfs/libxfs/xfs_exchmaps.c
+++ b/fs/xfs/libxfs/xfs_exchmaps.c
@@ -28,6 +28,8 @@
 #include "xfs_da_btree.h"
 #include "xfs_attr_leaf.h"
 #include "xfs_attr.h"
+#include "xfs_dir2_priv.h"
+#include "xfs_dir2.h"
 
 struct kmem_cache	*xfs_exchmaps_intent_cache;
 
@@ -395,6 +397,42 @@ xfs_exchmaps_attr_to_sf(
 	return xfs_attr3_leaf_to_shortform(bp, &args, forkoff);
 }
 
+/* Convert inode2's block dir fork back to shortform, if possible.. */
+STATIC int
+xfs_exchmaps_dir_to_sf(
+	struct xfs_trans		*tp,
+	struct xfs_exchmaps_intent	*xmi)
+{
+	struct xfs_da_args	args = {
+		.dp		= xmi->xmi_ip2,
+		.geo		= tp->t_mountp->m_dir_geo,
+		.whichfork	= XFS_DATA_FORK,
+		.trans		= tp,
+	};
+	struct xfs_dir2_sf_hdr	sfh;
+	struct xfs_buf		*bp;
+	bool			isblock;
+	int			size;
+	int			error;
+
+	error = xfs_dir2_isblock(&args, &isblock);
+	if (error)
+		return error;
+
+	if (!isblock)
+		return 0;
+
+	error = xfs_dir3_block_read(tp, xmi->xmi_ip2, &bp);
+	if (error)
+		return error;
+
+	size = xfs_dir2_block_sfsize(xmi->xmi_ip2, bp->b_addr, &sfh);
+	if (size > xfs_inode_data_fork_size(xmi->xmi_ip2))
+		return 0;
+
+	return xfs_dir2_block_to_sf(&args, bp, size, &sfh);
+}
+
 /* Clear the reflink flag after an exchange. */
 static inline void
 xfs_exchmaps_clear_reflink(
@@ -418,6 +456,8 @@ xfs_exchmaps_do_postop_work(
 
 		if (xmi->xmi_flags & XFS_EXCHMAPS_ATTR_FORK)
 			error = xfs_exchmaps_attr_to_sf(tp, xmi);
+		else if (S_ISDIR(VFS_I(xmi->xmi_ip2)->i_mode))
+			error = xfs_exchmaps_dir_to_sf(tp, xmi);
 		xmi->xmi_flags &= ~__XFS_EXCHMAPS_INO2_SHORTFORM;
 		if (error)
 			return error;
@@ -882,6 +922,9 @@ xfs_exchmaps_init_intent(
 			xmi->xmi_flags |= XFS_EXCHMAPS_CLEAR_INO2_REFLINK;
 	}
 
+	if (S_ISDIR(VFS_I(xmi->xmi_ip2)->i_mode))
+		xmi->xmi_flags |= __XFS_EXCHMAPS_INO2_SHORTFORM;
+
 	return xmi;
 }
 


