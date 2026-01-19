Return-Path: <linux-fsdevel+bounces-74476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4BBD3B23E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F008303C624
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6C039A7F4;
	Mon, 19 Jan 2026 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wgi+FWvL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B9A31DD90;
	Mon, 19 Jan 2026 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840119; cv=none; b=AgQHV+FEWO2fzyBUpxjk+676CHiLhjxiA1TrHi0ivBw15T7lAcwhU8krh2NbtGjLjWGKP3GVm3/tYZoCoTux+EN27lb/PQl5miwhlM9ve6Vm6OUlVtWqp6E2S+y+E5awMinTQeYfpwhpcYkRCIiS+buqCdRJ5ChQtEUu9nlpp4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840119; c=relaxed/simple;
	bh=FgvaakP+KkZTiWPmd/GcmMQL5i/gToOI+UK+TD05398=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t6lISGeOeCK+icO/7Ma2m7yIlwMFjHdldCdOWaMULBtlQx062WHuJX3z28r+JFR76/sSeK3WV2Y7tdlLfJhDz/u3Q13DD8AhbpTg1Ml4s2VSqO52XhCriJvtmQledP8ZxstDarL02R9esQ2aqjKqxBqwTPATnh2oFcYuwIl91UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wgi+FWvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F5DC116C6;
	Mon, 19 Jan 2026 16:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840118;
	bh=FgvaakP+KkZTiWPmd/GcmMQL5i/gToOI+UK+TD05398=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Wgi+FWvLw0MQ+2HORgz5R2DzsE3xTDpIeJv3h1S0cFNs6i9UQbBFBYRNiA8j8Fg9+
	 KHV2BRMV8sc5hIpryCF11pPiQxFsp5jsFeGRgjvKpjnr50AHMK8gIN85Nf3HliIyJN
	 fVEnoXFDYtI2qYy/Ygj8CYKdqJi8j61eA8sNsahGBpQ1xk2jp5P4+4TfuS7JqNHmrB
	 NIwutz+PXPre13vg54KrR7HlTKnjxB4xKcJY/PQYeRmbOh3hCGCON9Juobo7p2e8vA
	 llAP9XHmK5riLuTYR5uf34R6+LIIkqWX0A7ghO8ELhidE6qt+BMPFR9uiYqbZgi+m3
	 4gFfkEvNqWt6w==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:28 -0500
Subject: [PATCH v2 11/31] befs: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-exportfs-nfsd-v2-11-d93368f903bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=706; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=FgvaakP+KkZTiWPmd/GcmMQL5i/gToOI+UK+TD05398=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltbCPwpzNwYdBr0vFnmbNYzyzE/ZPMcrbCYA
 XY3FvJ2K7mJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bWwAKCRAADmhBGVaC
 FXLLEAC5N5AzFG4uvYDzXr4HYnhMSx1oslQeDc2aNn/1b0a0OMrmi86P7CYesaBsl2EI1ujp33F
 OtWIgVKwOCZ0pSCYP3crtFEbaq0Aw+i2Iyap1/h/6lHHzapF70M0725+Adlu3M9tGmo7Bjn9ZY1
 o3g1+ZCSHq7lVtNiYMCk90mQ1RLDIva6G7gisSZ0fNGeM5YvlxzF/PsylbBWHu0MnsIQSKTN08x
 8lcD3ifSkZh+XuXVyuqGPPojdmvdQH2+KTj3ye6IdrjX67X6HUS0cJHLPZZGYv7qZ3zhHIZ4ocP
 S/4ZMNiZoheepK1QszjjTUh6OgEpzWX6wDrw4HIBp5sFA/qKKcltgPiGeItaZGnb1zHxgxKhEta
 6rCEV1Z4hVXYA8qhEdd4mlpJrN8I8crXV7Byc5x1gTg2LAwlNXNqDY/AMBY65Lo1Tz9AEHmByTu
 PIcDAm+N9dxEnC1iKlTmlUoJ1KSXFME0B0IxTb4/5lkGTrgiT3NRCOY53lJ/4kY9QRJuuJUjLhb
 r/b3XrJj5q2R9ASU1G78XzaNpdcTx7XqsTf/VCB6XsMbLtDtkBv5HFeP4Ggahuw4xSJoK3HHhbz
 KtCZVqPbkuk5PQxouzkrY9RyqOAz4a3KbwGRNzNuGfTCJBDAUCM6LBh2uoT33ckjofS0O6ihZ3r
 s+733coP9qobvCw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to befs export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/befs/linuxvfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index 9fcfdd6b8189aaf5cc3b68aa8dff4798af5bdcbc..1f358d58af8b4de9bc840b9926970340395bc9e4 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -99,6 +99,7 @@ static const struct export_operations befs_export_operations = {
 	.fh_to_dentry	= befs_fh_to_dentry,
 	.fh_to_parent	= befs_fh_to_parent,
 	.get_parent	= befs_get_parent,
+	.flags		= EXPORT_OP_STABLE_HANDLES,
 };
 
 /*

-- 
2.52.0


