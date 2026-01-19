Return-Path: <linux-fsdevel+bounces-74490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 997DFD3B28F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6A04E303C5E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE103ACA70;
	Mon, 19 Jan 2026 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a81wX7CH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6BA2C3757;
	Mon, 19 Jan 2026 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840212; cv=none; b=VaqU/OvmcHDi2IUiYm3ycITRovGx7lPvJspxPh4QWaFVIPgW4HTKBwuzW+VyACWMXcX+MfCZvp/ItTt3+HNl6aEOo8dMQNXq4ZnoixkH3PvTQn4c/bP1HJT/TFcr1HpiVtecaZ0N2uw28tWOXuyQiMkfsNeZgwW0p+gZEDg2MFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840212; c=relaxed/simple;
	bh=n6o2QP6G+vRALjzLSnRDRDjCb5K6Xo6hC7kQYuLTnag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p+/fbp5QefenAeS9XvJ/3b/mH2SoedJ4xDk4AjfZRhKvCunOCOb8z8fQI4x1pBwit6XH9xm99TK0g2ngLCYIuj1zt3Lke2i/sK+mFMN2d5KoI3pBDHdCfuQtXosfzb+C0lXWYU8Zk9AFBqy0l80HKJfkxke7dF+KdTFX9OXMvYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a81wX7CH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A639EC116C6;
	Mon, 19 Jan 2026 16:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840212;
	bh=n6o2QP6G+vRALjzLSnRDRDjCb5K6Xo6hC7kQYuLTnag=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a81wX7CHFaMcWABGqmtr3bCnnlSH2+QJW6sj7Z5s+YHeHljRLrpmkrFPCRjArvVgi
	 /XaWZDcbtZpLtK/pb0aJ9GWE2dfijyEGdXqoSe4kJcGmsC3eNBKhUb35dBWA4dCtEc
	 77ftcJ2FU6Tb+BFuvMrPAHF5ksnWZxqJCeiOxur4Fk+wsxTxtj6qRIBFJvKmFmm5Ow
	 UEr/+uPLfVxiPt8W0cv/zj+rZQ7Uig3djb9n8GUKAJXwvu3yF1ovzkjetfwCRoq9cN
	 RyeS0NSJuTN3iyYs8sWrdDC32QcczPIYJiZcC7xFlpSM9IZl63faxJ+zmMU+ot8Oee
	 cu+IW2ZApdGdg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:41 -0500
Subject: [PATCH v2 24/31] jffs2: add EXPORT_OP_STABLE_HANDLES flag to
 export operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-exportfs-nfsd-v2-24-d93368f903bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=742; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=n6o2QP6G+vRALjzLSnRDRDjCb5K6Xo6hC7kQYuLTnag=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltfI0USivroSaPnKybgkczOShKdRT9HZraZF
 OxjWyUMDF2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bXwAKCRAADmhBGVaC
 Fdz3EACbzDFYvTKaT6J+G9ta/KSD1FSJsg97pPf4Pr3Ovq777BAZcpKmF2NX/mQBaUKyOfBzk6O
 YM2Mx7K1IT8iRZuJywzH/PH8fL6L8dR790PYOZDjz0wl8jnfobiJ50BB7eJo9iVgrOjb3Xz4Gqf
 NvgQamJe9o8ouJuUZpBhkwICfWgKMap5x92NL/4cf2tQn4YgWtqeHIHbIQ0NaSoWZ11w994n84B
 iCVAfMocfV7h0qZ59VS7Fc/HdaFQLwFSmKvlz2GS0kHbsMKeVZFrzdL0zC0ebJolRow9hnZF+1s
 vJQWpBh4SVhgwNLgc/AZXq3vReL4GvAM8Ha8+MgA8p+nuqL7zN18lFi3vNwJS4yjMwYq0qFafWk
 65zGwA+xIKY1uOIbRdtgwrxH74ptBWZQVD26VlmtB1qrelYciadJWV3+tsAOhKXxWh8yRP9BNEc
 C1b1Xh+XJz+3AM7myF+l/Nohzwy8tkkJCU8Ku2yAFJcUpHeBwAjEub93HM99JQ7xWgM8YLSNPx4
 QcXXD2LE5fN5WBuLbdlC0LRYHgeFmq6zUeFGmZZVkbD/CLbtdblGJ7E8YRrOZBXDE46lPOywZ9O
 5MT8vhgYocG2wgiTbTHDrtM+8LubBwz81EAvtnTITbIWXmDSYYmocdD/0l3AaXEplO1s2iJkWR0
 F/Tqn/AjaU/GRUQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to jffs2 export operations to
indicate that this filesystem can be exported via NFS.

Acked-by: Richard Weinberger <richard@nod.at>
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


