Return-Path: <linux-fsdevel+bounces-74481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DED9D3B26A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BF6130CA0EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601563A63F3;
	Mon, 19 Jan 2026 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqyE8RmG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B4E32938A;
	Mon, 19 Jan 2026 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840154; cv=none; b=F8+mrkIFQTkhntCA00tsWFscxgjsBoM02GFNncnE7XmPbTTel1wJqiBeMbZFIxNkvV3nAuOGqPfOXC/pF5jr4rnWIv7CyEvH3XYgDJ50k8gKue8d8qEGHIbjtghe9hlbnWnHY+yA+d2VH+HwRI2bSaltfxe6iei5OUXa75KNDBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840154; c=relaxed/simple;
	bh=o5Frh9Jas0eQsKFwc6fvb8GEIHx/ysO3v6fDYVnQinY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kVeM0mZOnFdt5TuGvhDoCV2nSYyKfAq9xS3XOdsCsXJEVIkHiuOJxp3MDgcMowmL9ybgd2ijznT7NpS0uEZXdppvlMU2LL1byy96R6JmtGQRgaKDw7ADsiUtqkQzNWQmNZAL1pLEL5Y3AR00YGwRYX7pxwv8hP8Z4p0T3qd67z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqyE8RmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4ACC116C6;
	Mon, 19 Jan 2026 16:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840154;
	bh=o5Frh9Jas0eQsKFwc6fvb8GEIHx/ysO3v6fDYVnQinY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lqyE8RmGZSejzsOQU0MO1ISUcONtsmxikVAGnuUP3SkfDMQ3Du8mM81jZl+aYhVuB
	 Ahn33iMXaUsrrtOpeVjyWwYyKouJkXrEAahILxno3ID9CMj64h5u/UalJZy5oqVgyZ
	 8qWHLcfOhFmYBRu6IYevN+88h7qyQw529L1Juby+udKOlj8WypkXar2wrvwFoOVhnA
	 K7H7Vre4b+VLlU0bHBrNO1jGA6nmVF/nOA8lUtw2Xqq5NotuPvNB/yoj6y2uj88HJC
	 ELMxRaczdd3rzjuNa2h8KNXBV5hP6Fe5ZlTEdVEBaKpIZgflUX0lW18A7v898UgNl8
	 UgMZBpoYTa0FQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:33 -0500
Subject: [PATCH v2 16/31] smb/client: add EXPORT_OP_STABLE_HANDLES flag to
 export operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-exportfs-nfsd-v2-16-d93368f903bd@kernel.org>
References: <20260119-exportfs-nfsd-v2-0-d93368f903bd@kernel.org>
In-Reply-To: <20260119-exportfs-nfsd-v2-0-d93368f903bd@kernel.org>
To: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Amir Goldstein <amir73il@gmail.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
 Chunhai Guo <guochunhai@vivo.com>, Carlos Maiolino <cem@kernel.org>, 
 Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>, 
 David Sterba <dsterba@suse.com>, Luis de Bethencourt <luisbg@kernel.org>, 
 Salah Triki <salah.triki@gmail.com>, 
 Phillip Lougher <phillip@squashfs.org.uk>, Steve French <sfrench@samba.org>, 
 Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, 
 Bharath SM <bharathsm@microsoft.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Mike Marshall <hubcap@omnibond.com>, 
 Martin Brandenburg <martin@omnibond.com>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Dave Kleikamp <shaggy@kernel.org>, David Woodhouse <dwmw2@infradead.org>, 
 Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>, 
 Andreas Gruenbacher <agruenba@redhat.com>, 
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: David Laight <david.laight.linux@gmail.com>, 
 Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-unionfs@vger.kernel.org, 
 devel@lists.orangefs.org, ocfs2-devel@lists.linux.dev, 
 ntfs3@lists.linux.dev, linux-nilfs@vger.kernel.org, 
 jfs-discussion@lists.sourceforge.net, linux-mtd@lists.infradead.org, 
 gfs2@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=823; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=o5Frh9Jas0eQsKFwc6fvb8GEIHx/ysO3v6fDYVnQinY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltdaF1cThL9y/0XwYSNisksrkVKsW/AB2P05
 5IbY1gx72iJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bXQAKCRAADmhBGVaC
 FZXcD/97dgCRFTvF92HsNCtcdMvHBW9NPsmSKBBjqVDufX8MGZ4/VSQkMX3HxFlI1V8Z0AmjBGz
 lepo+/QvxuI983RYiCoBo5QKyaqD5/LhYdLwVB6zL2YcgcVUabFRo/0cPkUTEfYkqb8V/vkFI6Q
 BGpYkOdXPXNbCnjqJRHdjPS6VtBDFXHqdYnLZq1U6/+qNniAioZHs5rk/ceAoybjzHeSqa2bWy9
 yW7UK/oLbatR1sXkXVW4s7a6exqOIK8LxdhjYq6ANlZWAtrum1SWW4nEeByKZQNRAH10bdF3xoK
 kP+kkah34mombElyQofkbwoeLokO09lPBuz/i8S7AlbPqTLSEduAbi5+usEtscs8lcqf/5GeqkF
 3cNT3AVl/M4F5ZSRnPJ3HE3vnIRcLE8WVCQ/iVgjQ/d/Jbrg/iuzYvdTdPxAUaIX9hU7+44HaXx
 Pl9JVlefKdZ4EYPVs+13QPDPsW6+rGzkr06LyGnGx10hzaBWxV8NGBGExK17p7P92SiS42s9/Wx
 qZBUU6XIMmZf8uHh4znogNDhhcm33486WnkQWR5sLhrUEPwQTtno+8U/psXvsmQmBMyNP/ud70/
 Y5W9N5xJcynuMTUHAhIG6VqPezcQlvq/glcZk1dYpz9wOHUP7ThX4OUQyTlCDU9q44iBIV+KYKB
 2PU4LQy2kgFCM1Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to cifs export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/smb/client/export.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/client/export.c b/fs/smb/client/export.c
index d606e8cbcb7db2b4026675bd9cbc264834687807..6dfdba9fcade9e4d7ae01fd107e84956f2f9b82a 100644
--- a/fs/smb/client/export.c
+++ b/fs/smb/client/export.c
@@ -43,6 +43,7 @@ static struct dentry *cifs_get_parent(struct dentry *dentry)
 const struct export_operations cifs_export_ops = {
 	.encode_fh = generic_encode_ino32_fh,
 	.get_parent = cifs_get_parent,
+	.flags = EXPORT_OP_STABLE_HANDLES,
 /*
  * Following export operations are mandatory for NFS export support:
  *	.fh_to_dentry =

-- 
2.52.0


