Return-Path: <linux-fsdevel+bounces-73978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A2196D27076
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 19:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BAD38305A85F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF1B3C1976;
	Thu, 15 Jan 2026 17:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="il/VdfDB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36D33C1974;
	Thu, 15 Jan 2026 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499434; cv=none; b=dHA3lgOX4J8oblp9qg2CzjhDwNkFB5UTRPTPwIEHcHbt5nUK4Q1orB6BJYCBW3VerGM3S3DPE/9jOb+05AlkMWR7/zpCC5z/ftyFMFFwFpHpdMs2XGg8suioZ/tKEF5ROPRs4mWayCMkLp1dqD7AeM8rJXvfo0k1ALCWtArRB5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499434; c=relaxed/simple;
	bh=Ehx/fY8sKADLaMJl7+FCvLMSAa/U8OqMGXINa886kwM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iSfmQAEGbxwmzpg58Ih5nOXquyfICrnbR08gNygrL2wQoipCgjG3swHPKt59h3VXRfRvede44gUdz6elEil7lsmPPJR+/33Ekvg8SBFB0ah7c4XAoS0zelCMwF+ZnK24Itb0mQ+0q0xsZDXqrjKq+WY5GeuHtm4e1iV60pZn5VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=il/VdfDB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3889FC2BC86;
	Thu, 15 Jan 2026 17:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499434;
	bh=Ehx/fY8sKADLaMJl7+FCvLMSAa/U8OqMGXINa886kwM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=il/VdfDB1LkGOpRnPQvrFUwdx0K2JPqnFGRJntiUMVPnRxs5PHZsfMSValtvlYy4j
	 mP/J05iJU0gPS64R8GEMOhjWoZHTdcqWYKm1Ogw222ideGX5ipm1oSmIbMKQDoynXi
	 UP645amY6X6foCDNx121QYUsH6YuE9qBLm2QyYpgyOtDMDTtrSfXKS6vvYfzeGVlpZ
	 NBXNHO0X6RoEWOVoNemGaYh4g8Rj0kVFicUqGBtTiM+GOp9CM0/rmo3WVap7u4Plx9
	 iF1KhPCMNTJlYXtmOpwM4F52XhDOSltoNylPFsa9HOjQ5jMxePli3mEAGzckJ3GyvS
	 POj6uKKk9HrQw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:54 -0500
Subject: [PATCH 23/29] jffs2: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-exportfs-nfsd-v1-23-8e80160e3c0c@kernel.org>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
In-Reply-To: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
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
 Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-ext4@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, 
 ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-unionfs@vger.kernel.org, devel@lists.orangefs.org, 
 ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
 linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
 linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, 
 linux-f2fs-devel@lists.sourceforge.net, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=695; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Ehx/fY8sKADLaMJl7+FCvLMSAa/U8OqMGXINa886kwM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShJPTKQVJtR38HPlADggm6IpGXuFgpgP+f7i
 KyE9A2oIKGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoSQAKCRAADmhBGVaC
 FXW6D/sGkS32C0CvjQ+A3ll9zy6dfI2gSXvXs2ERkXcQcsSsv5r/hSiEtw2RyBxQyx6rumNm5mE
 QyUFWXbdaTwcwSGobqehxKp5MKzzcfp66q/Zpo2jAaY7Da35SD3PyLH2KIbv+fiLrBBo7g4tDXn
 mkyY0E5I7NyoHgkD7SQ01nu7bbMi//dbuZJ6f4swfTGiZIdiCkQdMPdK8Ab1nXZBTmGes/5vUoD
 tGaMY27xGBCoU1OH0XNfDeZDjCmt0zCV1GcU2M6s5qytJFpPecsCi3g9XTpKEPAiuUVohlmUH6Y
 964nITE1D+6aDlHH/n8fXWwBcwAvWaUEd0zjh33SwdeUbgGGtpFvVIY5jZvo7+a1zqLkm/v02PD
 i8nD3PIVvfzsAadwDV0ljzI9h1nNV0XB5gAA0NYuiq2KdbpspRl3AwFGziplhIc2IfOUFi4pqEx
 SWDLkaRbFUSzetyFiUM3KqyYHrJFY7y1lO0+Rteb0YEfr2HVYP+9wA6e1xFpmUVrxVQCszE9tzS
 qbr2AirzqRv4ThIptuA5w3v8c5ZPCJiKva4Jx3gS8TT2vj8MZlBxl9rywDy5WyKKUPnoFelofEp
 giBXGcbgNMLDfX7iQ7xtrMTIY2WQNMzmLb0/QRyfr4yue/WVp+cUchExc+2VVPEi6eH84pgNfcg
 n6TOjJhVwZKiTNw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to jffs2 export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/jffs2/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 4545f885c41efa1d925afc1d643576d859c42921..80ff5a0130603f94c9bce452c976753c85314c3a 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -155,6 +155,7 @@ static const struct export_operations jffs2_export_ops = {
 	.get_parent = jffs2_get_parent,
 	.fh_to_dentry = jffs2_fh_to_dentry,
 	.fh_to_parent = jffs2_fh_to_parent,
+	.flags = EXPORT_OP_STABLE_HANDLES,
 };
 
 /*

-- 
2.52.0


