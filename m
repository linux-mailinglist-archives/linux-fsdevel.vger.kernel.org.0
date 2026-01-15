Return-Path: <linux-fsdevel+bounces-73979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE94D270DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 19:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87BF030652E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3733C1974;
	Thu, 15 Jan 2026 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDbX3mGa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489293D331E;
	Thu, 15 Jan 2026 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499441; cv=none; b=JPiCIUiPYTPSF4l4BR/ACxyefzkN+YQUGZoSw6s+7tH6LuZSJ6RRtlGOAe8Q2SSUyIrt8qEc3XJeFiT+EXvrOFY4kokxDkwWbd4PcAiJytKgNoWF4M90I0lTQVLuBmiRpHwfvVmuM/j6TLlTSMcoXJbzXYS2hyrz0J3Pj+LLAXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499441; c=relaxed/simple;
	bh=i+7my1hIKzN4dEiJBuVJ6Xq5R7300GKAIzUA6le5LwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g4GUvOuBmsKVU0vPVSxX30TI5kgcLHbMksBykgF+pgaKi98TAGu8b3dXVy2DTb8Jo+AMAQlDi5Pes2hW2oB17FqmaI2xi27gsBeOQNlnISu1dv01YzOjmxTDxmG32CNfQg8zllqSBBPP3NM9wtJs4gf2GKRf+qZo9aLdTUqhpjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDbX3mGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E44C19425;
	Thu, 15 Jan 2026 17:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499441;
	bh=i+7my1hIKzN4dEiJBuVJ6Xq5R7300GKAIzUA6le5LwI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vDbX3mGaV3J17XgmaClvzPrir7rcZ3244jEyEMkg0ulRRJHe2lzEsEsl6v8ITObrV
	 WvkOhbgNaFo0/WL1grmWsd9hNTGlelkodJYte8X5Zfy6RlEbAVoND5Tq6LyWEqSfuz
	 r0YrXIL6lkDuTdzPDLpnxOz7z6Wh1fE6c9RhzNESyCG5HWxL0omGNAUy0P3QJIDwYx
	 oPZdKHZUG6U3Qkk2i+a1Gk0Yd1/Q76deryInYPHiVrIL7A15tmkN17tEIGtuwpAJmE
	 HoSOOj+qtSeBvhBwA86v5yb2oCgnDtqWCqqSQKXfOrWy5Kfo/GtlsuNj5uXjdW9Ezs
	 PR8uNNzO9mghg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:55 -0500
Subject: [PATCH 24/29] isofs: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-exportfs-nfsd-v1-24-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=697; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=i+7my1hIKzN4dEiJBuVJ6Xq5R7300GKAIzUA6le5LwI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShKBTZTAVUXXqyi6bJrxji0XIyjkD7JqQZY6
 wonbWMv0LGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoSgAKCRAADmhBGVaC
 FUq9EACyr/b3KvTajXKKWcsw4iTSig7acGp/8un3L9dhMH4MPBenFoJ9AZtBo9TOeulQUWODwV5
 d0cHtwgvOQyQ5BYykoPeKH3Klf7jh974vbAUu9wNUoufhW31N1yHvp98Hw+1KjoJBj8VEd7xrX9
 UklYejwsyZtn2s0Y9hw+wdkywLFwHe1wdyRKYh2ayx657SSRqjxH18TcmTGkf23E6UiM+CM0AVy
 uFtyUv/kbGeSxYJs/4Y8x9T/gZ6Sth6DCZB3Cs7pJkBXwrtyvZTW1gD77G9M74xXIAWsxDJ8Eyt
 P46Fgt6ZLJlF31KqAGaMdsAQPitvRXAnImogjK3VhJX1kibYdHlLAU8bXjGOs6YTLyNpmLfulQT
 nFWxdkYrH8SZU8AcRZoM86AaPxosuiValXES5vL1ZGcW3dCh6Fi4BCuLqNiWtpCgMr3+Uzt2r22
 Phlyrr58r259LfLhbyZ9qeym2OKdm47S+FTpKKlEK68rS3/9mHOR8GdsY0AtTX3Y0rLb+LXfWtb
 MomTNKAZCecJIvoHWpsKO6lcrok1r1PZo21H11IAheF+wwmQuoVer+ihSNb/2rOutE+Ow3+K+rR
 HoHCt0GkoR97A9lJJVP6yvgQl5GmJ5jMsLZHHBEVl6tuCuNO642t+/h+BMzVGVlHNCEDNiH8aJR
 +8vy+LDJemHgrzw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to isofs export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/isofs/export.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/isofs/export.c b/fs/isofs/export.c
index 421d247fae52301b778f0589b27fcf48f2372832..7c17eb4e030813d1d22456ccbfb005c6b6934500 100644
--- a/fs/isofs/export.c
+++ b/fs/isofs/export.c
@@ -190,4 +190,5 @@ const struct export_operations isofs_export_ops = {
 	.fh_to_dentry	= isofs_fh_to_dentry,
 	.fh_to_parent	= isofs_fh_to_parent,
 	.get_parent     = isofs_export_get_parent,
+	.flags		= EXPORT_OP_STABLE_HANDLES,
 };

-- 
2.52.0


