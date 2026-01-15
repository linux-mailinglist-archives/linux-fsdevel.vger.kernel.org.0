Return-Path: <linux-fsdevel+bounces-73955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 656DBD26EDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 18:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1FE73128140
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348EA3C1FD6;
	Thu, 15 Jan 2026 17:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/aT5jS7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F843BFE50;
	Thu, 15 Jan 2026 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499295; cv=none; b=q/6geQvkyOYDD2AWrP4H94MyU+c0MqdhLTOhAgazdDBOpUdl+Gnuc1XzO5j/1z0b+jfMANjR8mEhSrZyHxrnvNWa56Manewi6KzDcSoleU4iT5l8iewsIrA4pDpyMXTn3obvjDWbLdVVNa4gBOeLD9CGav8psYtt3WmYgM2cTxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499295; c=relaxed/simple;
	bh=eGzcrbK82AAYHA8mp9BK4OkYs2dNeYeCsyAFHAtDQCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k/05lX0V6/bRzS3qrVf5FBNEtGlgw6Fjb3IKP8QwXUoletc+GPucRoNqw4VfZKpXqOQNqtKAeDep4Ch8miKEgOV9TQmDqDLvQPA3cyhpEvdC4ohyx9gKzOR17Lhl3JHhbKIJ7QWYgJLx4cI5lJCYm6rO/oasSse3q5EhBzwsrD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/aT5jS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B80C2BC87;
	Thu, 15 Jan 2026 17:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499295;
	bh=eGzcrbK82AAYHA8mp9BK4OkYs2dNeYeCsyAFHAtDQCg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N/aT5jS7N6QoemTXHYE0cX8UVkbOu2/wbixgEVBgnGYF7LhX8OhNz4XrWyrjWRC7M
	 zD29UA1bZK9fVBcd+hA6xYgcgJEJ2sOcHLu62k3G02+2GGzKX/VLC9noXIbXKuuT5K
	 Nr+33LfHhpTNa+foKCiyUmvvq00e+Du8qeu6aHkC+zm9MykELBvSIJbtqfNnq/OaOK
	 SF+mPjA+LVjF+9H+bIal6zl1BUwjpoAojxDJr4szcfYTYT5pi3BOBaWc53Pi/XWVcL
	 UUg6FGToVwTQewnPmGxKUIYtkaiiQBopAjTCdSXAr5q8BAP1a33Gv7jD+4BPFrdlhn
	 7fI1YzYPg+SYQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:33 -0500
Subject: [PATCH 02/29] tmpfs: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-exportfs-nfsd-v1-2-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=687; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=eGzcrbK82AAYHA8mp9BK4OkYs2dNeYeCsyAFHAtDQCg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShEbLwccGXUC5j0WTeZML8RysoPsUjSds8pC
 JZi3m3aO2KJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoRAAKCRAADmhBGVaC
 FVG3EACMORg6FWU2k+gTVXQsRhFWMoWdpO7xBjnubHZheO/O5JyWKYWNPX4sbXBvJB6B7Jk1/b1
 MaY4i/BdFxaDMt69GQfQWSs/ZjgMLW4LaHiT35v+0ApKcyuUcyUpGbePY8Q45RmV6DfOh9whS9I
 t8sVCOKSYWlli98pTJRslgDUbjULTXyaFW3R08JP3i5prQEUPNI85rq3Ia39b/3nRxCeLKaHexo
 Wh8mjzMVA3ncr3QS3JDW8EiM4mJqdcnsG7C0p0NsRXX9Bj1POl4qDX4/A7s0z02kDavF/u2IJaJ
 vzU3qxp6MoJLJtZOYAMJEzw6d2NIMsfFQi8pwo/iMRDwkqxsFpwRvT7h8npYMpXyQRou5PI4d0k
 WHlJK66KpzRjMnk6kiLnVvwtZuUQrYq4oVkkaWTcUB+fY19qVtW1hVVw7scwCIR3paw5NG2hfJd
 yGUZ66kVaTV4kRZIMqbz4YnHGfIFhEP3jeaF0kbPpJ5OOuVTBVgLJoD+69v4diy5ByzJk/ujYyj
 EnGCShycUwb0IGd7r5f1TDdSScJ49Fh85Zg86XLyxoT3TDIvfZG2VWm5VKRN81ifgwd84hYqGHs
 dMhx7JclW4kuJSjtBkrqYaWP3J4TCUaDo3fstC9n+P/mEEHHzveE3Gf/t3MD3vm9L8CDEYfw0rc
 Din5n2xsqXt5kxw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to tmpfs export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 mm/shmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index ec6c01378e9d2bd47db9d7506e4d6a565e092185..c64c4410b4fd9961599a5ea768b469d8184e713e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4477,6 +4477,7 @@ static const struct export_operations shmem_export_ops = {
 	.get_parent     = shmem_get_parent,
 	.encode_fh      = shmem_encode_fh,
 	.fh_to_dentry	= shmem_fh_to_dentry,
+	.flags		= EXPORT_OP_STABLE_HANDLES,
 };
 
 enum shmem_param {

-- 
2.52.0


