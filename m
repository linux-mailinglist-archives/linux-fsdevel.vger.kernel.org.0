Return-Path: <linux-fsdevel+bounces-74482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D796ED3B1C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B0943118064
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5973A7840;
	Mon, 19 Jan 2026 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Onl1ff2y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E5A32938C;
	Mon, 19 Jan 2026 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840162; cv=none; b=jJAPFAo/1LIr61JQmQukj6GjpcjHhpl2vlvERXHgvrRoZDizSjasabuGt0GaDTwqBwP757UfbyCWMxOpLt6+O7WnTuVm82I5gtJLmOfyuVS0mWDUJ3ap+gSrB5LFluJGJ7HD0OiuzwYUuaLg36IsFPTTXwGkyZT0RoeKsYzZSeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840162; c=relaxed/simple;
	bh=xYt2MSPBN08jqB6aoLGRn9g7bVaaZnkp3x/mAo4D07M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ABdAfTmruk2LfTssdBTQ7DgGyYHTuT7tEMhpFTXGxZArGFon79UBayilP1/wLDQePiHtaw9YbqCr9XpcqqQhbXw2eaCa63rfycfJNyVN9zgygNJU+/XcWzq1vgVwEjeWvxJoiSDBfxe6LUXFb7rkzm4u3FKtY5P6HHLyGxB6khI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Onl1ff2y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97545C19423;
	Mon, 19 Jan 2026 16:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840161;
	bh=xYt2MSPBN08jqB6aoLGRn9g7bVaaZnkp3x/mAo4D07M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Onl1ff2yL2rsRhbon2DKTICt3E0fC7f5rf9eTx08Plj/priMZPiOxyC95fr9OlZ1Q
	 Tj3bc6+F6jeoOP9lW9Omi57BHdrw9hIQi8iW1rYY2TZujDNAKYQmNHfnJF7TQR4jDL
	 XT2TgTAX8bojPDQ4CH/gyDuKnodpDRa7LoecaI7ZGol1EqqN38/2r2PumyMB6E/3IB
	 gMmbVJ5th0wfE7wFSrWJe7lDVaMZmMsDz/ijztbFWZezeG1mnnhpSefOWhWvGutvnJ
	 8P36f5TeigIVo4DvniWSBYfSlTL5nDQeA0+/f1ooF6OXQ+oRCHpAUeCOKIQg6DXWla
	 m3kUCp2qEriXA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:34 -0500
Subject: [PATCH v2 17/31] ovl: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-exportfs-nfsd-v2-17-d93368f903bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=779; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=xYt2MSPBN08jqB6aoLGRn9g7bVaaZnkp3x/mAo4D07M=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltdbZC4i859npPwVQCiLrrovPH3Ntgd1inG/
 8UBjD2xxyKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bXQAKCRAADmhBGVaC
 FYjDD/9hgSSTbDWpgx790fD9kUBlypy6yfUjVl/Cwssq2z749eDvf2KH5eMyxgd/6rOZkPqu2+2
 gbdvVNbDvUNY8fz7NspCjYiEDexBIC5tfRA9T62LVeoswQLxGM29wl2ixgPWMPBftcv7lAnPkjT
 S/jzjLHFQyKYcXtCf9pni1rK0jCr3OyBHk3e1lVuA6LafCIrvu6F9+tcmuWu49cVETld5ujnAfQ
 csp0C5d/6qNeeBHIcn/WZrpHMRm9O0eNuS5umBPhLGYss0OC/KOBEcRdZvSuR2kP/ArcVAuAFwJ
 2N5Otod+F4FKciuxVxlhVxmTUtY6RnEThZ3KAP9eUK7KirA4BUgoX4CEFxcARIfClDzwmm53bIW
 EdRuC2b1qkPYYuAWU5Xuu1N3uE8cGu8ytttjPbvB9nR/BBaATi2uwYx179nwZfoBchKvdZ5fGGu
 WC4LLqz6rN2YcqXs4zBkOZJwWzlmTxbob7Ao6GLHKN71Pc7fAWGuHtPXhlCz3lHkPw+aL3hZi/O
 fFRjI7ZBPIzSqYhm8g3W29oI5wMFvKvJjZ/3C16X/0UB/OpbmSgTYhYdc324ukf4fmF8BbqJsyL
 L0Sm7ILgw6KpAnenWxla09O1q8wWMSxHIge9mCAibjD2XvZiStJTbi1YtH8cmAIMhaZwCbrFLwN
 VOQon6cUTc3pFfQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to overlayfs export operations to
indicate that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/overlayfs/export.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index 83f80fdb156749e65a4ea0ab708cbff338dacdad..18c6aee9dd23bb450dadbe8eef9360ea268241ff 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -865,6 +865,7 @@ const struct export_operations ovl_export_operations = {
 	.fh_to_parent	= ovl_fh_to_parent,
 	.get_name	= ovl_get_name,
 	.get_parent	= ovl_get_parent,
+	.flags		= EXPORT_OP_STABLE_HANDLES,
 };
 
 /* encode_fh() encodes non-decodable file handles with nfs_export=off */

-- 
2.52.0


