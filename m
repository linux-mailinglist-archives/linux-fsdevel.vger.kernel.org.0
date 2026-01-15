Return-Path: <linux-fsdevel+bounces-73984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 028B6D27289
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 19:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A67830B3AAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 18:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1B83EDAC8;
	Thu, 15 Jan 2026 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7YSb1/T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1713D34B4;
	Thu, 15 Jan 2026 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499474; cv=none; b=md6Eh7J8EErGWw5ohti1xNuhwhHzubfd0HdoJwzqPefayaTWjnO8wnERKXwGN9TudJWtrUzu18qY+AJxI2ELT8IME9mvoYJAumBpa+/F38VsId11XKY+yKrOiLZLUpC7c69MtszZesdusu7njFK0TvJNJ+/pjAnxD96zRUFmjwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499474; c=relaxed/simple;
	bh=3Lesog+saJIE7fVwXxIqzocDbbL7seXSBVcQWCAEylo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XlUYNEV4fkC2sTDvuxOPVZ0Cbd20RltWxu8GcmzjLWR8lmy/ZaEPHiqzNGQT+RU6GfPfeIQvenyf8hKLIRzPQytggydrtaZnQEKW1/BMSFEbHs8WISS/Loi7qckJbEKMgHwCSpgFReTR3pvDSFYpKmzQ+f2PECnFcbxQj39Iak8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7YSb1/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28E0C2BC87;
	Thu, 15 Jan 2026 17:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499474;
	bh=3Lesog+saJIE7fVwXxIqzocDbbL7seXSBVcQWCAEylo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g7YSb1/TODzXkcIP6p9/wwYu2DGdEGs5A1xNbEaa6YXpXHCkZo75dKOhpzbEnke70
	 tFl/wi+2L9R7juokN9RrAO2hzFkzOo1UolYG7PTrgtqycoumg6wuMYanMSAiGEcL5+
	 rrebzmnse1W5h+gJbvvkGvabjn0w4tpVTl+YkKEq2+zyxzqIIVNGyGxTNWXPGgnVDI
	 yas38IdE9VvF4iPsPwJa+4aGhd++bDzX+ryoJ+6LAed16KiFtr8ZpWA0uQW4o4J8uj
	 O85No7vo/UQXZUte7vVLWFrrfWkgy2ib31R9cgJpIQxJgqj9Q4vVS5rQZcE6nkgtGB
	 bWbKRQtHDsekw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:48:00 -0500
Subject: [PATCH 29/29] nfsd: only allow filesystems that set
 EXPORT_OP_STABLE_HANDLES
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-exportfs-nfsd-v1-29-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=933; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=3Lesog+saJIE7fVwXxIqzocDbbL7seXSBVcQWCAEylo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShL1IWuANGZmRgu17fA6ieKmPdFRTw+kdOfE
 T/UW6Eb7tSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoSwAKCRAADmhBGVaC
 FVMKD/48eycQzLl5j5B6HkE8L1FfwXraMaTibRGf1ZUUO1tdf5xaliTxEmmTz245juQt2kJL6vV
 t3v0tmVInLOvhNl5Gml0VNKIfoY4DHYYDMqab3/BhWW52OAXYuFC1OHvNjVSOItR8sbZ+iJfdmP
 cpCABU6fsvW2RanNoGDQLVF2gHpTCVktYbUOx2fTqCClkLlPc7eyiG53QS9imf2Af1jR9/MObU2
 UJC8aPGoFg29JP+VBrJ7+K+uG/qCZ+4Lk8yD3Hb0EdyY0XHb70hMV4VEfQq77MoCSoVGAWAYq+b
 sydLKAPVS0MlM6fWB5A+y37+o3lo+1bVTlGmwslQVeTQiyGkKAYNQNCMygOJQ75i8hJBaJ3Ui0r
 wPpANaw1oBzTALc2orq3uIyZ2m6Kc8WXMOVdDcT86U6pBRMdATdTLzeEaNV+i+eRTrA8gCkrAXq
 JtaYC4ihJzgaSo8BPtxAJdlyFFkmEA8kw/Eg1fhJwl9r88x60VPSbw53L7sBrhYiykB4xsS0Yn0
 hW4FHIe8yJXugnlD+0XpRgz9ejnjAuydomhlSsmB109/2pn9NyuzvVEW6QO6oIhAsH8y+nYAm2O
 zDhKSTd453A4Zb1cz+XkXonK4dyl1yN7vyzDar6cQ/2BJVoC+1C7e3OSHy/2knx1Qt3EFlycS5s
 GPaWvnhRUrWOAkg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Some filesystems have grown export operations in order to provide
filehandles for local usage. Some of these filesystems are unsuitable
for use with nfsd, since their filehandles are not persistent across
reboots.

In __fh_verify, check whether EXPORT_OP_STABLE_HANDLES is set
and return nfserr_stale if it isn't.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsfh.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index ed85dd43da18e6d4c4667ff14dc035f2eacff1d6..da9d5fb2e6613c2707195da2e8678b3fcb3d444d 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -334,6 +334,10 @@ __fh_verify(struct svc_rqst *rqstp,
 	dentry = fhp->fh_dentry;
 	exp = fhp->fh_export;
 
+	error = nfserr_stale;
+	if (!(dentry->d_sb->s_export_op->flags & EXPORT_OP_STABLE_HANDLES))
+		goto out;
+
 	trace_nfsd_fh_verify(rqstp, fhp, type, access);
 
 	/*

-- 
2.52.0


