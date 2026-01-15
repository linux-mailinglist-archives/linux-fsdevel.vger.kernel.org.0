Return-Path: <linux-fsdevel+bounces-73964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E23C5D2713A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 19:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A922E31DC12A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65943D5248;
	Thu, 15 Jan 2026 17:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwHkGr2x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52293C1FDE;
	Thu, 15 Jan 2026 17:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499348; cv=none; b=BtdJVzyPV0BxJnzeJnUBxUMu2y77DBzRLtgly1FW1fPvVfrv/K3XIQAiR49PodsMtOAhXY5Qdy2ckUOofdTCMRvFvXi57ncg/YUDFwznQTtpQcXZyE8gYjh7n1IcSw7fkb/PI9ZnTJrQ3S8xWeYsbeJ7oaRKhooMPnlKkVFuYVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499348; c=relaxed/simple;
	bh=FgvaakP+KkZTiWPmd/GcmMQL5i/gToOI+UK+TD05398=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oxF1W/YaOlj99uG8mka0jRF0L2mcNHvkEzI9Xm9DvfihN0OFXvv0uYlgkTCC0x/Qg9Y6EcoF23i1nSFT+W55rKxzsLPxsvD8R7y6j/yChgT/vrCrjVjgD61WCOs/ckKAn6e4VkLxYItEeSoCAzu07podM6DuMxDmQDbq5qVhun8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwHkGr2x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358B6C16AAE;
	Thu, 15 Jan 2026 17:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499348;
	bh=FgvaakP+KkZTiWPmd/GcmMQL5i/gToOI+UK+TD05398=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bwHkGr2xg6B8U5TV1PJOWofK8WpoXC25yUxxbtMAPlBPDhQrTQSG6vrqBrUs8uDBA
	 hTqGyj9yg2TH2uINyrZXCjzuH2kH/kz/XePVIL74Zs7t7dv4JpGdmbHA36OZU+DJpk
	 PWmLshHFOMRMefsxGC29Pff7c0kcVj0MxDdQhdnqdzMXc5Vap/L7iD8JqaqQDzOlpW
	 oevuq4IZNRQ60YjDnRkugrc+ROG3Hn+nEfLCVs9dFaMKHspLizBAMr2yjPWiQc5QxA
	 c/JcgLHuNUH3+8x2nXofqJfjnjWbvPUhDLylRyyE/uSqPEh1qjEcalALGwqW+YgG+k
	 G7FnxaFhkK23w==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:41 -0500
Subject: [PATCH 10/29] befs: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-exportfs-nfsd-v1-10-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=706; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=FgvaakP+KkZTiWPmd/GcmMQL5i/gToOI+UK+TD05398=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShGbxyozH9HfLZqQETsvfW/RuWGQpM8tpPCd
 YnS/wCZAa2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoRgAKCRAADmhBGVaC
 FV26EADSUInyFlfgi8mCxLJgVoNQbbVSxQ1aPK+W8ZC+ZjdRh0buWdJB1AqTinRIY/+hFrdznoR
 2ij1tYPigO5YJNUa1QuOcvdR1eMs/OF9F5mjiEO4NQVqjmtxFejq2q7Oz1dTaYOWKusvPa7duFk
 szeNwIHZigrHOXNHDA8mBsjuutshb2R7+3T8CzxrXHuU6KZFxQTBnItrStyDP3nCf57wQhs3lla
 1CKlKga4tIeLYArvkJaEfFiyGtqtctzSSWRbprAE4TqMfC1eUzsoSghWWpkNCAfpnAjcCgOcu7R
 Qd8+8pXhG4zvQtv7WVaWiYSTJtxkztKJB7aV25SRrs2bQpO/cIBvruIHhOZtV+C5KFC3q7S4Ng9
 cosmYNrH5tNiIe1f18DK3kHU22ippITqJ9OoOafSiehsarK+Z5w9Z60+Wfzjz3Q6ffD02Z8S5DS
 RUX1xUlKXgUW9ZpR86DLZoT/TJlqx52AWBrklpEV5+LQ+TC3lPHjq23gVI9GjTsai3UlHGnxhcf
 eg3VD1jJijVL1y3CsI0JMk0j67gHyCkWdQ67/MjF+DYzMfmLCOC7xquhxS28B9bfyDc48SyRAG8
 1wZJtPzPzh+aXjwMzsqJICCOR/ExR6mP1AJk+vFbe2nB1tS5Gyo721I/mFPhRhvfckkPX3ujRj3
 8k2oLoDOYoOrrmA==
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


