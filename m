Return-Path: <linux-fsdevel+bounces-74475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CDCD3B1CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 42ADB301E125
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDC5395D8C;
	Mon, 19 Jan 2026 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrsKMHXT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12178318BB5;
	Mon, 19 Jan 2026 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840112; cv=none; b=ln2F0ZiFb5AxFxuO2ID+hAs60UrvnOzSlnQkkTN82Z+43GWPSFzzfL2ovtI+I2B1h7iOOeDsDQjUIVU2bk3LeJTNlVVY/M5x+e9UHahnw07uE8w/cb18BwyCiPLpPCav1SOOF6cup79a14ZSGmc3lxlibKe72VA6ztzVjwYzGC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840112; c=relaxed/simple;
	bh=EHb6P72K+L3+Sb6SzLJj1rhREwGw2p+u8b7kNcs5wTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MVGftLETm7J8Z2upDuuOE8Ewpp8KetyVjZoXpZFtLrT+ycAvJBY7CceSZbrJSEYc33eRUdr11bYeIn57gZ3ZIMTxBV1P1W7EoXZNlJNTkfKS1i8J5PQ4QR6MxWEXCQnsafH0PuTxhQLzOX7n8LymdEnl7JuN/jxHl7fRfhDNPr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrsKMHXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE048C19423;
	Mon, 19 Jan 2026 16:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840111;
	bh=EHb6P72K+L3+Sb6SzLJj1rhREwGw2p+u8b7kNcs5wTw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TrsKMHXT/sCWcPrmeChQ8L/OZ+Si/PDQhiEM7iDesj6YXekwxdKrB2xnkwdcu92LL
	 HH/uxP2Msg+8sIyiXUDu8w1atUCsdySf5qfsTHdm+lDQKjVYfrF+7BwwTaiLvAFkVi
	 oNHfCi5olIFqrV9QNTwZBWASWLSU/z7pcAmrYhjYdcfvqgE5hKzR5qjswFtp1V9bMc
	 KRNymkwYKSyw01Riv37C0HKrRLEJ2Gi54kMPoML5smsTL5Ikh3az7wic4eVrgz0B29
	 3LAsKLmZoGRnwr4Lgl99QwOiGnsrsk4MrbjL2Z/tqXBta7oDaQAd9r6pLPzwRrSPZB
	 Qh0o/kHlSIPaw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:27 -0500
Subject: [PATCH v2 10/31] btrfs: add EXPORT_OP_STABLE_HANDLES flag to
 export operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-exportfs-nfsd-v2-10-d93368f903bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=678; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=EHb6P72K+L3+Sb6SzLJj1rhREwGw2p+u8b7kNcs5wTw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltbvp2orig7d9mXjeoPXhSVy0pWJJMG7Y7qq
 gRF3d5VdAuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bWwAKCRAADmhBGVaC
 Fe+RD/0ZkSh4Nai0BmaiUEvJICbcRTV5b1Lv7WJEwq5JjPI+bTHc3LovjfczVEaYuoGRdG2abhd
 cgg2Bl7HM09V6aZVbhZsyMZIlhRiz9fjdp3BB9kZiBv8QXIWFumRTxtwe+JYKsg33sqzi8iERMF
 s+4mESToF7z7l3CEFigwLlU3h/bDOCbXa76NM+5xsUih79xFHx5c66J/Qpy64Pvxy3SXF2ff+Db
 pYPfkSfWUHFBL0aKVLTX+KO5PJkCQKoAz/h4ytqpFX/swD3YLbUsT+oAtZ+X0fzMqTiYn49Xb3L
 jNYiGvi+iKzQfSf0QFEcNjhFA44Dpu8BmAsuH27BcUkRSbW5XuFrv+SzmIhhSBhhlyrEjqTSAB1
 h4u0eUui+5shxh2+EEhoIoJzAtQ0nhCGs5ixlvEvsekFglUy/wV5aCaKbscbejdIuwgB9SOwBcC
 NaffoK/cGpZB+fBU05w6C0t+4tKDn0S+u1dKfJNSzffOcB27eVll+IR2cI2CH0zNzDvkDVyh6Hc
 tsoqRTfn8CtdfoWs1mYVN/bqJVe9yE25LuB+hvEZNc52LywejSC4iD2wXfw8FkJ8dIf2fsRQgT3
 aaQQFsS1FLzw3naxtye9sdQ4gzqutNjtMU3JZTh8aLQhhnOlMc0MHNgUdEdvHDYBHLPJ0wyPxGt
 Sb5dYA/LEaVyd3w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to btrfs export operations to
indicate that this filesystem can be exported via NFS.

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


