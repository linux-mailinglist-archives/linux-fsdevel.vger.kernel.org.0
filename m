Return-Path: <linux-fsdevel+bounces-74495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81629D3B2BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE629311ABC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B363BB9E4;
	Mon, 19 Jan 2026 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzFgWc06"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE1E389E14;
	Mon, 19 Jan 2026 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840248; cv=none; b=KTd9xd0HsdFGzfw3oXFFNaMoK/hv64gzUJ5cnXbRKP6t4OtrQtjUlxkBMymom64Wu+83q3yDecYAyvAsl+YpT5RF6cpdsCXPVAQaT9/eJjkoFkkN2wOUAWb+PK57WCWqXXuOVl1bw31omKw57mrP1IqZpXR8Cs+ESDQzLKeuk3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840248; c=relaxed/simple;
	bh=htvmJ8h5f0pVu8ImvWNw/JEkkap4HdmaXUH9XULOP2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D7Ag+vLAWWQv71NrXlqcuMFNLLf13oAutWNGn5bj6D0A73xacQc5inlyrhAwLFbmXS57q5Ou3L23TFBK+MlJ9tFu3+RYhcdg2/qhbIAN5/CZYJuJ/Yh421mDzuNQh4gGcT7nAFLjCGXZ3KdvxIYWJhh56iACaut1LeOi4q7nzi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzFgWc06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578B6C116C6;
	Mon, 19 Jan 2026 16:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840248;
	bh=htvmJ8h5f0pVu8ImvWNw/JEkkap4HdmaXUH9XULOP2k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kzFgWc06aZFuLVxuUIaJbuzx1Q6DRqgjKSqHMG+3rx0WNtTnTeHoViYVYtsdlbnl3
	 lqrIDTwTxIDk6Wv7YDKzD4dGNaMQiGo21SK1N9WTrUnWHqeN1AwccSLrFYhdJKpX08
	 ycTFaGLIqIyp+7Skq1JJqCGRfXe78rqioX1Z8udYIhDTSyBzicw+7Sa93XN89py+wv
	 /X/U3zk+Ly9IpVN15GnuxYN6Jp73g9gDPVq1nFKVgNeYYcrr/bLecAeSadlP3TRH1h
	 98jce/UvFQXzJKk/dBpgJh8cajRnepjcNRKEZtyncNjOfqqNcDV/9L3tiYjSoQZLKY
	 O8avH5/3cPZJQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:46 -0500
Subject: [PATCH v2 29/31] f2fs: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-exportfs-nfsd-v2-29-d93368f903bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=728; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=htvmJ8h5f0pVu8ImvWNw/JEkkap4HdmaXUH9XULOP2k=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltgtBAQfQ5kS+MExK3FeETc+0guPdOqIeqKN
 mx8EKEmLxaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bYAAKCRAADmhBGVaC
 FeM9D/9txHa6W+i5xp+BRxUlC+XVX0On794rY5aGRkCAYEj9G8FgVMxYOjtDjcbiMsVdxqZ3WaU
 8QHVYA+iGrifPnLe1QX5jrXsBmrJOvPE8aiYvQEJ7Kn84fkr501BGqfPYbivwHHqSTW4rWD7Lkv
 CXuWb1ylgYgiLxDtB6YOyjO+VM2ELqQMvKtnKAX8jvpCLPMTNo4h9Egmvceuy+jmkFCZ5S1/RzI
 h8G4P4yUVcSRQCgJBt016ZJS3dhf5ZqlmgJCLYo1Cda1nZN/4jCJwUSpVU0ndR0+wkkzxqwgZX1
 FKc4yHuYOxRorNJe24Lf3LMrClmYnfwuKEtIWQV2PBbjQUnBu28z2anYNz3decQi4GuG8viuV8a
 gOAJXMC3qfw1dABMQg+Hiyw3inAbSxviSpXAdbzB3ZpdheY+I38kS8ZGknXqhYJDMGcKBwLR0G2
 e5NM2E22TFKSYCnu0C2ApdVfQT03Xyd0gWln+3M1Nhh5tE7pk3DmbfhO5r1IhB2eUmAUTbJriOf
 cuIqSl01a9VaIzNVTTXtFLeLIgvWHCIXtobkyWBHyRb4tELIU29i1q5x1NmGttPKaZizPWjN5XU
 y7yhWnW8gdZvuhuuRR3TZCCPT88HqdkSSsjxjE7hzPD7kZmL2+zhn+pRrGWIF682VKp+NBgQsbT
 Hzi+D+FGfINt2mw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to f2fs export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/f2fs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c4c225e09dc4701f009dec4338f2eaba1820ea7d..260c26771c431bbb36e99be8daff6cde40662751 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3750,6 +3750,7 @@ static const struct export_operations f2fs_export_ops = {
 	.fh_to_dentry = f2fs_fh_to_dentry,
 	.fh_to_parent = f2fs_fh_to_parent,
 	.get_parent = f2fs_get_parent,
+	.flags = EXPORT_OP_STABLE_HANDLES,
 };
 
 loff_t max_file_blocks(struct inode *inode)

-- 
2.52.0


