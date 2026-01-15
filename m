Return-Path: <linux-fsdevel+bounces-73963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73120D27A0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 19:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E27633A5731
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4944B3D4135;
	Thu, 15 Jan 2026 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhGTowRv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8053C199D;
	Thu, 15 Jan 2026 17:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499342; cv=none; b=usamVZBXwQATjDhZicJ0MKjY7/+5UIEZ9k5TzSv+9klis/JFqSSi6DIZ0pVyQ8Np009Ha545Muk7Ob+9zXjkQqORQ66uuUjJbiJBjhHVi81qVIxJqxYFdXDObjAL+pp8yvcLIdnxFzy3gotuBH8zmCqD80vxtj4mYC+qOA4DueM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499342; c=relaxed/simple;
	bh=kXEhnrEqBGLUfKXF9oxTrDiEyMD/rJY/BOIQHOiqT1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yb5CrCFnJ/l+npNKVlKUbF01FkFlx+bhzg2gf0t+YEoPF/3Y38/tK8gpjpoGcu5oq5N605Jvg/Xn+6Sx5nh9UXkybyxBd0azn1AKZFUbMCeLnkmpBouNqYrQrwrSINrPWrLuVmQVh+MlqW9iL5yRtM/Xe8kqVy7BHBH9uBjEv4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhGTowRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C9FC19422;
	Thu, 15 Jan 2026 17:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499341;
	bh=kXEhnrEqBGLUfKXF9oxTrDiEyMD/rJY/BOIQHOiqT1U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VhGTowRv1ZdCSbwrP6fIZLhAzqz52dHubpyKszBLI7URAG7W6SPZKGF3KIn0U2zg+
	 5tVYEGsuwDF0mJJELm7H4UgOFOZa8Rmf73fjwJHRZQODsuh4NDe4N42RJqo5k0t/Ox
	 wk0Zyo9z0NB4J2vm9kg+NAPOl3NU2G13g328/x0Ky/AmMH30Duw5NUr8i6JtfOedpq
	 J5Dm+VWr3ls784CODv1E8lo+kwt8rHWrmv7tNk1pSucEBPQyhieOVhKlDaTv3/dxrS
	 mFXsnQgF2g22EioMuqnjQY2fJpwhESYq4WgT9lyV5RHSiQDikgxbfcTKxzQfqZwGW+
	 WoFqmmRBqrJHA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:40 -0500
Subject: [PATCH 09/29] btrfs: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-exportfs-nfsd-v1-9-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=678; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=kXEhnrEqBGLUfKXF9oxTrDiEyMD/rJY/BOIQHOiqT1U=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShG89hcHuGwJsd2BxAERNQ67iytfM88cVk1v
 a8CNYB6vTCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoRgAKCRAADmhBGVaC
 FfdyEACPSGL8gQMZBDLdHovcBu5qSm6pu4yGdMYyroq6SWbbG9R0Q5Q2XtDnm7GKMnylAUV/7eD
 76S6FhEf7x/OgCgs8sl5VNhrQ1fFRq2rMYx2v6XOqKiCyRShojkXZw/Hxwof17Gk/IYLjwdZqim
 VUVSQ/pSZy3CqJLm0BXUsMs+kCLPzF5G8ZkLT+BNwDGC3KZwhB0HtOut2eYvgwYxWSnQGjV5v/9
 txa5IckHztnGFocaKw9dBZj2YbgWQs37r7LRAJZsmPoSO08Rqu7zr+Z0BtWAAvznqYRu+cQoycT
 41wkc56BHYvd4UFgUOM+7TjEbXnVfuX0u7VdrLQ8esaCm2oh4x8HfqZ+Zt1Yhzn5xhV+bFqmu/t
 D7mX3Pfblk6hCjPdSYPsj5IwLEIKpxUwKcPwOofceq+p4s8f3HXix9p/EPS7PVP2XzgAebYNNAM
 VJxrqtcHumJplzhU9CGlzT3Kob2C/sZ7FqRoMsZGZMRUoQ5MUQX9iFNSVEhAzTf6S5DsYJ9MYse
 c4Chhe+FV8WHQsMBHumIIWiOuHDgPOEeauU1sQlYQDU6HwaQ/bEdxHShDeA7b+/riW4JH/ASR5x
 OGlR2kuII9fCsvYL2J9mVdHOCwyAWITJMJ1OBaJp+VAyA1otLqh9rgT9NK7BlTdb1x13X84Xofs
 i45vrL1rJ67tEoA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to btrfs export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/btrfs/export.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index 230d9326b685c4e12dc0fffd4a86ebba68a55bd6..14b688849ce406b2f784015afced2c29422ab6c3 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -304,4 +304,5 @@ const struct export_operations btrfs_export_ops = {
 	.fh_to_parent	= btrfs_fh_to_parent,
 	.get_parent	= btrfs_get_parent,
 	.get_name	= btrfs_get_name,
+	.flags		= EXPORT_OP_STABLE_HANDLES,
 };

-- 
2.52.0


