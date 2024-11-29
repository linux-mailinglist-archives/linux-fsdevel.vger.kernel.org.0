Return-Path: <linux-fsdevel+bounces-36147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8319DE7CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 14:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B723DB212FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 13:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0576619F461;
	Fri, 29 Nov 2024 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTJDgEWu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8511A2625;
	Fri, 29 Nov 2024 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732887568; cv=none; b=YwvcHrh1pOfJktqXxn8CrmBJsTGUr5FvkgkX8FrlnhhaEVhmFVk3ltLgNvCRAamOHUCEhlUDQXX+pQ1aeOAKtMnf2PFEKabUOvwoZjrtnyhbDM4pbrB6lL8maBRFDKOBKBlOQylihl0Yo12NdVklAXsDdOtnYUQYN1Ux+I53W7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732887568; c=relaxed/simple;
	bh=IzT13zirsd9Il47+VcD309SeoUwtTzDUSJ/JlVEGVNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGcicuvlfDmRi7Te1pxytAALfCoFp231vWcelvnwrXpK99I3zUXk1LJmkkENqIAO1viBQP89KO+jDuU8NJmlF4k1B2LsRgtzJ/jcQpp1D57qdFT0IuIc4VJHs3BSWDoytKSdRLd3hYdUSCzHNlbQXsy51oB01pLvDBo22rmStB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTJDgEWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C62C4CED2;
	Fri, 29 Nov 2024 13:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732887567;
	bh=IzT13zirsd9Il47+VcD309SeoUwtTzDUSJ/JlVEGVNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hTJDgEWucqUR1qFpViySZ7Qzicq6ESW08Io2vHC9FPDCpWkMTe7dNTRFDE8W/EnHF
	 jtPjGGqxGBCGDpx5dVGsIRJaauwmiyE/keSnly+wJeMEyNJXdVz62o+F8niE6c9hOA
	 DMT0WADrvvY3BXu3EI0j/QI+60WuuP4zLR7kqzetoKzxKZtY71iFaIUMBxtMbf4ktU
	 SNkXfZVUblrENas2eumChFKjDF7i3ae38+p1igUNkTYOGmWdTxw+vZxQyUA/cYPSIO
	 V5cY1J/OvOeW5rAwu3aKAhtO6iV0J93Wj0CrMa5uNqr2+7rzTKj002YygirYhGX3Y8
	 /qoRzd1Xj+1gg==
From: Christian Brauner <brauner@kernel.org>
To: Erin Shepherd <erin.shepherd@e43.eu>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH RFC 3/6] exportfs: add open method
Date: Fri, 29 Nov 2024 14:38:02 +0100
Message-ID: <20241129-work-pidfs-file_handle-v1-3-87d803a42495@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241129-work-pidfs-file_handle-v1-0-87d803a42495@kernel.org>
References: <20241129-work-pidfs-file_handle-v1-0-87d803a42495@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1482; i=brauner@kernel.org; h=from:subject:message-id; bh=IzT13zirsd9Il47+VcD309SeoUwtTzDUSJ/JlVEGVNA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR7Hj7QJe5ayRURojW5qHMNs9mU4m/e1rVnF1zjW7P47 inROn62jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkcvMDIMO9z+/pip71T+zXf WbyUNGHeWRQRuel735xLL57Pv/GtfiEjw+UN3z3/Pi15crzp2uFJcxas0l1f+X+CV+uOmT/lLv9 lieMFAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

This allows filesystems such as pidfs to provide their custom open.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/exportfs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 4cc8801e50e395442f9e3ae69b6c9f04fa590ff9..c69b79b64466d5bc32ffe9b2796a388130fe72d8 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -10,6 +10,7 @@ struct inode;
 struct iomap;
 struct super_block;
 struct vfsmount;
+struct path;
 
 /* limit the handle size to NFSv4 handle size now */
 #define MAX_HANDLE_SZ 128
@@ -225,6 +226,9 @@ struct fid {
  *    is also a directory.  In the event that it cannot be found, or storage
  *    space cannot be allocated, a %ERR_PTR should be returned.
  *
+ * open:
+ *    Allow filesystems to specify a custom open function.
+ *
  * commit_metadata:
  *    @commit_metadata should commit metadata changes to stable storage.
  *
@@ -251,6 +255,7 @@ struct export_operations {
 			  bool write, u32 *device_generation);
 	int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
 			     int nr_iomaps, struct iattr *iattr);
+	struct file * (*open)(struct path *path, unsigned int oflags);
 #define	EXPORT_OP_NOWCC			(0x1) /* don't collect v3 wcc data */
 #define	EXPORT_OP_NOSUBTREECHK		(0x2) /* no subtree checking */
 #define	EXPORT_OP_CLOSE_BEFORE_UNLINK	(0x4) /* close files before unlink */

-- 
2.45.2


