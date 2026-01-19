Return-Path: <linux-fsdevel+bounces-74486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 971B5D3B29C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 022663088146
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA6E3A8FE7;
	Mon, 19 Jan 2026 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWpRmCRl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0BE3A89BE;
	Mon, 19 Jan 2026 16:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840183; cv=none; b=Q0lhcJWYkfBltOq4gv544SbB0rUCTitVck74358qD+euRsm01CoCqvZ0FpDps5MJ4mfvgEW5oDvahxQVkV4UrekOBdddwoW38uJDir3s/9LH9IWN0wL3CFJUFFIvUpzQFYAubn8ArB9SKdg2d0X7Lcy7PMj22xhiWJHgBs1+5Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840183; c=relaxed/simple;
	bh=0pjRYIsnDRpw9eCc428hMJ+RmLNOXECTiV0TzjyGuWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sVJPEHLIo5t0NzoRGnSRnl/WibgE9q3QRNcH0QcFRFa4V2WXCOI2ytBNqezMypEcGYRnnp2/TmBdkWIou4fOL4d679o9ppqnYpMse8J1O/lnD4BHO/W7/UY0LYAOQmuMLbpuXuK2B+OADUWmaS6028BxojJUq/x5npB90JgkURo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWpRmCRl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED218C2BCB1;
	Mon, 19 Jan 2026 16:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840182;
	bh=0pjRYIsnDRpw9eCc428hMJ+RmLNOXECTiV0TzjyGuWE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EWpRmCRlLqA7JIm8OHKhCrXcT2ln5vA63b0sZyoVI3zCuqdcFLzc4lORDKTmNYPgE
	 68L/MldcRNmq7VjXDoYJoCDFOIAMCsTPNrQQrWwbaRzw8R/DojiRLpEhdab0Mokr2b
	 HCN7YzXCa6Kb2QMc/Fv0AhxCHNWSJd0MtERaTQkcJWqox9B6q7Q4nS2xcysS4axClP
	 Q5SrX8dLhllK86laqesoQ2aGFtn7PE0Wq8rZ7mWf7BWEXrhaUv8U1gHj5gz34zE4Ur
	 LdYxuZHS7V0X5KEMOfWN4bc+BgVBojyIM5X2h33jNR0RIocK7OyyiZWPrJO9p0v1Kt
	 /1xXtEu+1aQmw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:37 -0500
Subject: [PATCH v2 20/31] ntfs3: add EXPORT_OP_STABLE_HANDLES flag to
 export operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-exportfs-nfsd-v2-20-d93368f903bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=702; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=0pjRYIsnDRpw9eCc428hMJ+RmLNOXECTiV0TzjyGuWE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpblteUCie9VgtOBk7k8KPcwYUjg+5e3aTiLSyz
 pedHEvEigeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bXgAKCRAADmhBGVaC
 FXDrEADXMOqneHOXazrfXcU6SEaFdPp2jgcDyKlpcouTHeHL7JMG75dMhNd8/tZpaqBBFh8PXPr
 m/R0lXt0HXYZD/WowEUdI9wfb8zMEoSXka6WUnrgA2qLKI2K5EoYLcUDlB2f11F39Cg42pXIv+Q
 GwIpJ81OsYk8AMTKSlmCBneF4heHmiUP3ceLQEd77l8rNMaM97BuExMkt6/FAXyx7QPMM90orOY
 5ru14ROv12v5JtsocjudqdzZhUkNVJq4qQ8BSksvhOzGrEHyktSKKC/4qF54Q/AGTlU2IsSca5G
 YlLwjI6/aLM2HkJ07JS8Tp8XQHW6KktCwDkz5gI8cfWiOqfSZhhBxicjQd20i9XzXSfixWitcGl
 2OuYprkJVsaf3xiPIOluLq1RZBodScZOje3zQS1b2pv6jm4BlgqEyd77HzLudAmpYNo4wwLvEql
 KPtVvl8CASGIRsPK3aDKAi1HNbzKPgSUIA29eRhvzlLbWTBlO7pxqeYgHhJZiwsMJCRnsWm/144
 39yZpmFmTHkZnPTT80fwG3j9E36XUg65OPrPlv/9wGEjgBA8PH/4Uowj0JPGJSQr67iERPo7rr6
 i2wOrIsCiT+ItGJOWG1dfznfv2LMHa0wNrDOimgp9zKPWyOD+8E4Tup3ekZmosQr7//lt8Ry8kl
 38O1cP6Qlg6j2ug==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to ntfs3 export operations to
indicate that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ntfs3/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 8b0cf0ed4f72cc643b2b42fc491b259cf19fe3b8..df58aeb46206982cc782fad6005a13160806926d 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -889,6 +889,7 @@ static const struct export_operations ntfs_export_ops = {
 	.fh_to_parent = ntfs_fh_to_parent,
 	.get_parent = ntfs3_get_parent,
 	.commit_metadata = ntfs_nfs_commit_metadata,
+	.flags = EXPORT_OP_STABLE_HANDLES,
 };
 
 /*

-- 
2.52.0


