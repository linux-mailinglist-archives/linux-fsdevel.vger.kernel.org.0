Return-Path: <linux-fsdevel+bounces-73967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E54D27C12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 19:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 347D73185DC3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5903D6045;
	Thu, 15 Jan 2026 17:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoVPha7R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39C13C009C;
	Thu, 15 Jan 2026 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499362; cv=none; b=gJH+oqm0R8psjCcIGkesb0RP++lvxNMslyazaVmKeFGiJ1N2hM/exGagocTcVtSZDjiI03cnsLVrM9+I9NAZfp1QfOcksEQGF+4KfXdA78imfJfvryEQ8EN7HtdVkDgitG2zFsg9CekylqVE40CRej3K1WRJFpj/2e0XxAS/TKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499362; c=relaxed/simple;
	bh=vIHxhWXy09cxwOBR5jwdqwOPX/LuIGbTAXFi0NJ+sEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uZYbZcVIZMcZtVvBD06kaUc0ooyx5oOSpGgCoDgi29nBwn2WANZNryt2PviMvnYBpvQElQGKjYIuIG3+EK7+VBTFMgbVLqAt87ZzOIcMfRspvzukQXZGQHFhQX0oo5aJPlhik6I1YLgXYL4wv739vLpl6FAcKca9e5eEA1CrDQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoVPha7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDF0C116D0;
	Thu, 15 Jan 2026 17:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499361;
	bh=vIHxhWXy09cxwOBR5jwdqwOPX/LuIGbTAXFi0NJ+sEE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aoVPha7RotP93KFonT0uh/G1PEbUfw5RzccdIbFwSWenDBhTkyRjOJtVzv97+g7Lc
	 ey8x9BxnX8OrG87Onr98FCMeeFPvzY9mFFWJ1ymiwRuWLGMXivaI0bR4sGFSYPTABe
	 z+Vl+P07B9BOYnJ46E3xo8EGbkd1+fhpXhG2qNpWFExdd+esO9kHr1jEmpufkm9E+v
	 QPBOflETm5Ydo0n4CF+1YV5V78GVEx8fbCw3C9LWmfF8KAscJIf3WE9nnTzPh/j5c2
	 /UHM/HpXTiP1OdEOOgX2+fDNfZD04sq96BNryy9C3J+VVT7VM40RwnkU319j+sj+i8
	 AkQrkPFtxLQ5w==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:43 -0500
Subject: [PATCH 12/29] udf: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-exportfs-nfsd-v1-12-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=735; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=vIHxhWXy09cxwOBR5jwdqwOPX/LuIGbTAXFi0NJ+sEE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShHxC/QAhbO7mbVrXH1nVia3Hfviv3SDRtnW
 +y+FMiktpyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoRwAKCRAADmhBGVaC
 FTFZD/9XDkcZd82hmY1yhsac5N/jsQmiIXeuAQ2Mkni6mEVMyB92tEdrk3Gwd8HgDOuWYPHu1Bz
 Z0O/OLUE08CCrAkc+MNTfeih8RKuVwDIW/S8xPrmsI1R7Fph8Qisc4hx8sMoaZ24qkAJ4GU+oMn
 AoBxvXpqJUDPih2yNiXyvrsdIXRJMDr0r+fnffl3Z1G/IYnc+Iom6R8Yi/JxVk1QHyJFKWBpCYv
 5+H1zVkKmg3n6OW7GXXq4boj+hd+YK3lgDgNTmYMKLeKxWajkeJ5vdqoaJwssSQ643uSWl/54b8
 MJa9r1hdHeR0oIUn8ZhMDFeqUZkVaePVRgmQPmPyZPFlmDdXmpw1wXMz9Li4DP6adL8mdtNl3JE
 OuJPSv7VxvmI7hqt5yO3GtdNn0QyNsEkotek1aAPUvSGFLD6P/OcK+JyysT2cxa11yh/iXUn3jx
 /yTeRPDYoqvBzQU97cd2AKrWp8YZCcJAtiwIvjJOO2jmURfe5Yr2sWLS/XF0Fi8QPKJuth76n6h
 mI71FzBHHxE/RE/lFB27XbFser2x53DCRndN6oMxqvDyZrvGJhlCftA/nu60B3fIFvIIiEWHeil
 wXaDHvjkwLW7kGh0gAkcLiqxiq6ba+YQ1+3OimFS8lE6jElkoDn425GmpS4u9OHc26ZNg28lZP5
 lWOj0uKQEFaRbbw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to udf export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/udf/namei.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 5f2e9a892bffa9579143cedf71d80efa7ad6e9fb..7b8db8331c77bb43d9a3c4528aee535eac2bbd37 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -1012,6 +1012,7 @@ const struct export_operations udf_export_ops = {
 	.fh_to_dentry   = udf_fh_to_dentry,
 	.fh_to_parent   = udf_fh_to_parent,
 	.get_parent     = udf_get_parent,
+	.flags		= EXPORT_OP_STABLE_HANDLES,
 };
 
 const struct inode_operations udf_dir_inode_operations = {

-- 
2.52.0


