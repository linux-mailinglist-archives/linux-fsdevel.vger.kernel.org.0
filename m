Return-Path: <linux-fsdevel+bounces-73974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA49D26F20
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 18:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DDA5F30146D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A733D7D95;
	Thu, 15 Jan 2026 17:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzaZLDCo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505E33D7D6C;
	Thu, 15 Jan 2026 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499408; cv=none; b=LGZPUQR9ShM9xCKIpg2Y1O9gijiRv48cmu/lAArymGrdky9QQ5RrAsyKygyNCcxOeg2ZpCKmNkdtDpmun6j0KpWR9MDut++d5NucXQEyOtaWVnbN1e2PUc34vIA1klq4NyyVTWPzB6o0YEHCLgWt3e41Gy6AbRVA8abbmb9bHZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499408; c=relaxed/simple;
	bh=ASJZAYmFtZFPW7zLvK0ZjL1I4NBdupfpmX/yzCsItik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sH+OXM4pIhXABKYe/9x1LBJ0bEShqQsawfdB/EMbIfp+o2X5drbb8d0Ib+TfMIh9Sr+oUpdZ+bkdhwgQV3vyDaXeno+CDSeImZIDi3TOLLMB2l2MFCRxJwa+flj5Y4t3wvey3JZ5jrKwHgHytFIf8Au9kDYE3UGHvSR5oQGaTEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzaZLDCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB285C16AAE;
	Thu, 15 Jan 2026 17:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499408;
	bh=ASJZAYmFtZFPW7zLvK0ZjL1I4NBdupfpmX/yzCsItik=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HzaZLDCouvYiTo43CgRna8k0stYnWVggWRX+E7ITKTkQk6SqWtN2mAUd0YAGY8YFg
	 fv5e/by8LOrzChGrKfliZQ09J2SJ9WIOLLR193K9GSI9t/myHqGnT6ZAlWdt+Uzf0N
	 0rJtKvSWVHfJJqTWUhDArUuUXTS48/7IUyWI+5Qw1LrZ/CqnOghvhiGz/sBaMmfaWF
	 KwiX1CJgcy1laOLzsMhtzU5kB/g4fimS9XsKVcl1aEGTakFkmzA5K2zFUXcXPxk3eL
	 joGa56XKg7cKCx0g9tt2zVErEcJm0Vej01lMJF225kYkCN1zd7whNuBBNxCg2pN5G+
	 x8ukV6eAv9GoQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:50 -0500
Subject: [PATCH 19/29] ntfs3: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-exportfs-nfsd-v1-19-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=702; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ASJZAYmFtZFPW7zLvK0ZjL1I4NBdupfpmX/yzCsItik=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShIkjDCKglCICLqHNwkybqhDZvmrtSF0SGBF
 LwETpg24QaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoSAAKCRAADmhBGVaC
 FXMJD/9cA2N1WYI1YFIcrFPq4MChLxHnvueE6hwkxPc5K7vP7yNwnn65W6JbEp2ObLGTsNTKPYj
 hmY2b/q/WvxyA0jN2iG7UYGUrcmbm8lyfJERfWQ5WnN1+fOBhsMD2Q+TLMqnMgi99BTN3V7CHwd
 7FcYq1rjFMR7i/SoCxFhaVCqjz/9amidfbT73cjGr0kRadbn4rbsw/SLhVv9+z9iK5uyJ4D0blu
 t6qe9CQoAyjLl+Gms605lcENCFqAWP24jtTNmaS/vvulwuBaTl8c+OxHuOCzcH9colTYZUoXSLG
 amzf7eGV7BAAvedVjh+Ycdb0/GwSn9uu+Tq6iJbHTMQMQhpStolF6blR/PRlzWQ/TjYQ3k1VhT+
 0gnz7OR6GaIZk7FkEbKolcNoVM5mc60b9ZoATyL6jx/F4dczwq8Rsv3SqAiClgX+w8mU9dp2Jse
 SRzo1N+Zkj5xAutyPJHj14ERMNwpP2GQIeG+tUyGQ0NU8BqNcwvKIVqRChO0ozWDEaLh757srrM
 olAdLIVH7Rz+CEygbk+t1jGLoA3ywVL2DS5w14345MUe5Hy0DR3iZdpCUlGE+OsZWQ0+BQmmVc2
 Qt72vG0qGAZ3O2rom6X15ExyF6DZpXjgau/5XwvIGUCwEP72+KQ0B1HN2KFve5zwRDbiBxvD5/o
 incrg3kj2EjzIqA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to ntfs3 export operations to indicate
that this filesystem can be exported via NFS.

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


