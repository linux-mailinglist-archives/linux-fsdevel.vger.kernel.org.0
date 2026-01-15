Return-Path: <linux-fsdevel+bounces-73972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFFDD274C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 19:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 84C803017E70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264B73D7D03;
	Thu, 15 Jan 2026 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYvNCKEm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0B733993;
	Thu, 15 Jan 2026 17:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499395; cv=none; b=Ndt7pFy/ivVKnYmmzGE7qWeQHIovuGVba3tXKUcR9fLFd9pEablMC/87IrRaXu73aOuqf13/gydbc1UiP/M4hdSkXsQe+yAt1M3Kp4HImZnNFVTwE2lUcr17h/ooYWhjd2W4m+DVRwsaCa6fKecpkzRiP9vqV9V/jXeity6rP6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499395; c=relaxed/simple;
	bh=uje1SB5ZiQFb1nZ8cBWe/zh7xTuwWFv4kYXj9kW+shY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MejmHw3eEnnobCzgJ+ab/0DkmyJ+X4JSltKi3PijuCEu/XkYFl9pmP1WgV0r7GPwGRYcTQO7R3qFVV8H8JJV5dpWNto2+iRhglY13IOgTbM+Ddwo9kUIXPrYfpNFzFrZ9at4yVbry1Kw7XOF8j6oasYPF7E4W7ZlkV53eS1Anrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYvNCKEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BD1C2BC86;
	Thu, 15 Jan 2026 17:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499394;
	bh=uje1SB5ZiQFb1nZ8cBWe/zh7xTuwWFv4kYXj9kW+shY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PYvNCKEmybxkHf/xhYZRJA1JR3gi7hwzBl39gO6WcRa3q4IORVrO7YuHny7TQpgiy
	 zl17QOknyAtYmsTiWLBB8kQX5MvY5wrTFagloc02WkBy4em6uCkvDjKoFHPKgA23OP
	 emXGk9XryVRw6nf06RD9Jk//mYkLce7bxq8Ap9KaZVFkkVfi2UtR1Ay7+9pJigW2aV
	 gCp0wp4jlq5kzP/U0dF9wDDaTjGEPnvHrsy5L6bYYDJnpDGVchHD6uaUI+z8KRqcQP
	 iGrph9vhwR67PUaiR/AGoZY8mbdpeRYHcNNaXtUEfUA6tSTZqAxqkmZ6b2KyUgQrbr
	 crJ/YdcNWu9Cg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:48 -0500
Subject: [PATCH 17/29] orangefs: add EXPORT_OP_STABLE_HANDLES flag to
 export operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-exportfs-nfsd-v1-17-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=801; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=uje1SB5ZiQFb1nZ8cBWe/zh7xTuwWFv4kYXj9kW+shY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShI7iVykyDXfFrTuLTz0reyANBqvVlG7B0Uu
 1Vj+ckj+QSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoSAAKCRAADmhBGVaC
 FVnED/9f0D1oqBjCgp3CIeAScQlnoGQ8qajHoqRzOI6pjd4BeqJxdTpgcQ9spfu5wEwf8/uW168
 AsidtnL65hfLo5B2jfzmYVtN8khTkYlu7o+v30HMwhrc+TdP8MbPt5uENZxqhYc6IzHalGQ+sA6
 lO6ebPCT7OSx0kc8KCnNrauxgw0r2yW790BGEUUOd5rdNkOWFNANuL6cCsZ0iGnWS5HgN/IIaXn
 pSuaXSn5yI8kTwKbcq+UQl26zHz2XAH+8XaabHQwV1/1tqbprihc0VIjA9ATuJ3el552cA4P6t7
 +mUkygIX/9E/GK/b2xR7rQdMtzwrMXfwYMKX3Dm9EIeRBKaUAkYDju/jIZ1r7fC8zReSpsp55KN
 nm9vynzH9R1cpP/fVn/Mi47dNwrypVVxyaeHqDW6OWQQthOCT5LIHs2LyeLStN7qpqPQElynuXd
 LyF0nnucvGghbceqM1JJps5jcNg+YM6f7tLgSJMUW2tieWOWIL3y7du3CI3YXeeHcFJE4AVp9Zf
 v8PN25mGlu9MyKpPWG4vF1MEDrCXJHoFgL9Pwyd/UTE88RjgfrbrP4dd6dGwiq04F6Z+Hyy4wsO
 CBxXCdkbZP3HFIUX0kWTbzYM0yKyBotEBElD6owLCSVU9rv0PLz3JL1vHgYObjL5Ke/6POBKGIq
 72Kjn84TseU7iGA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to orangefs export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/orangefs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index b46100a4f5293576549300ae9050430c3f07969b..140f27f750939cf5538eb68501dd60012bd2daec 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -377,6 +377,7 @@ static int orangefs_encode_fh(struct inode *inode,
 static const struct export_operations orangefs_export_ops = {
 	.encode_fh = orangefs_encode_fh,
 	.fh_to_dentry = orangefs_fh_to_dentry,
+	.flags = EXPORT_OP_STABLE_HANDLES,
 };
 
 static int orangefs_unmount(int id, __s32 fs_id, const char *devname)

-- 
2.52.0


